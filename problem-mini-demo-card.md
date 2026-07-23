# Problem & Mini Demo Card：IntentGuard Agent Wallet

## 目标用户

目标用户是第一次尝试 AI x Web3 开发的 Monad Builder Camp 新人，以及想把 AI Agent 接入链上操作、但担心权限和资产安全的开发者。

他们不一定缺少写合约的能力，真正缺的是一套清楚的执行边界：AI 能帮我生成什么，钱包必须由谁确认，合约应该限制哪些行为。

## 核心问题

用户想让 AI Agent 协助完成链上操作，例如生成交易、解释调用、准备合约交互参数，但又担心 AI 幻觉、误调用合约、转出资产或执行超出授权范围的操作。

具体问题是：

- AI 可以生成交易建议，但不能默认拥有无限钱包权限
- 自然语言意图必须转成可验证的规则
- 用户需要在签名前看懂 target、selector、value 的含义
- 团队需要一个最小 Demo 说明“AI 辅助”和“链上执行权限”之间的边界

## 当前解决方式

用户现在通常用人工方式降低风险：

- 复制合约地址到区块浏览器手动查看
- 让 AI 解释交易内容，但自己再人工核查
- 在测试网先试错
- 只给 AI 做文档总结，不让它直接参与链上执行
- 依赖钱包弹窗做最后确认

这些方式可以降低风险，但缺少一个明确的、可复用的策略检查层。新人容易把“AI 能生成交易”误解成“AI 可以直接控制钱包”。

## 我们的方案

我们准备做一个最小的 `IntentGuard Agent Wallet` 原型。

核心思路：

```text
AI 负责生成候选策略 / 候选交易，IntentGuard 合约负责检查是否允许，用户保留最终确认权。
```

最小策略只检查三件事：

- `target`：只能调用白名单合约
- `selector`：只能调用白名单函数
- `value`：不能超过用户设置的最大转账金额

以当前 Week 1 的 `CheckIn` 合约作为场景：

```text
只允许 AI 建议调用 CheckIn.checkIn()，禁止转出 MON，禁止调用其他合约或函数。
```

## Mini Demo 核心功能

本周 Mini Demo 只展示一个核心功能：

```text
输入一条固定策略，模拟 AI 生成一笔交易，然后由 IntentGuard 判断这笔交易允许还是拒绝。
```

Demo 展示内容：

- 一条 mock 用户意图：
  ```text
  只允许 AI 调用 CheckIn 合约的 checkIn()，禁止转出 MON。
  ```
- 一份 mock AI 输出的 policy JSON：
  ```json
  {
    "allowedTarget": "0x7d465988fbe510c7b1890e822be4a66078c09b80",
    "allowedSelector": "0x183ff085",
    "maxValue": "0"
  }
  ```
- 一个 `IntentGuard` 合约骨架
- 最小测试或说明：
  - 符合 target + selector + value 的交易通过
  - 非白名单 target 被拒绝
  - 非白名单 selector 被拒绝
  - value 大于 0 被拒绝

## 本周不做

本周明确不做完整产品。

不做内容：

- 不做真实自动交易 Agent
- 不让 AI 持有私钥或直接签名
- 不做完整钱包
- 不接真实 LLM API
- 不做复杂前端
- 不做 DEX、借贷或多协议支持
- 不做主网资产操作
- 不承诺安全审计级别的权限系统

本周只证明一个最小判断：

```text
AI 可以协助生成候选操作，但链上执行必须经过明确规则检查和用户最终确认。
```

## 本周可展示证据

可提交的轻量证据：

- GitHub repo 中的原型说明
- `IntentGuard` 合约骨架
- mock policy JSON
- README / Known Issues
- Week 1 已有 Monad 测试网 `CheckIn` 交互 hash

已有链上背景证据：

```text
0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814
```

说明：这笔交易是 `CheckIn.checkIn()` 的真实 Monad 测试网交互，用来作为 Mini Demo 的安全策略场景。`IntentGuard` 本身本周先以代码骨架和测试计划为主，不伪造部署记录。
