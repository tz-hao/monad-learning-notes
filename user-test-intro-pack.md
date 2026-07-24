# 用户测试准备包：IntentGuard Agent Wallet

## 一句话项目介绍

`IntentGuard Agent Wallet` 是一个 AI Agent 链上执行守卫：AI 可以建议交易，但合约会先检查它有没有越权。

## 100–200 字项目简介

很多 Web3 新人开始尝试 AI Agent 时，会遇到一个安全问题：AI 可以帮我生成交易、解释合约调用，但它到底能不能直接操作我的钱包？`IntentGuard Agent Wallet` 想解决的就是这个边界问题。我们的 Mini Demo 不做完整钱包，也不做自动交易，只展示一个最小流程：用户设置允许调用的合约、函数和转账额度，AI 生成一笔候选交易，`IntentGuard` 判断这笔交易是否符合规则。符合规则才进入用户确认，不符合就拒绝。当前版本以 Monad 测试网上的 `CheckIn.checkIn()` 作为示例场景。

## 测试邀请文案

```text
大家好，我这周在做一个 Monad / AI x Web3 Mini Demo，叫 IntentGuard Agent Wallet。

一句话：AI 可以帮用户生成候选交易，但不能直接控制钱包；交易必须先经过 IntentGuard 检查 target、selector、value 是否越权，再由用户最终确认。

现在还不是完整产品，本周只验证一个最小功能：
固定用户意图 → mock AI policy JSON → 合约判断候选交易允许还是拒绝。

想邀请你花 5 分钟看一下介绍，并完成一个小测试：
判断几笔 AI 候选交易哪些应该允许、哪些应该拒绝。

反馈重点不是技术细节，而是：
1. 你能不能看懂这个项目想解决什么问题？
2. 哪个概念最难理解？
3. 这个 Demo 是否能让你更放心地理解 AI Agent 上链权限？

GitHub: https://github.com/tz-hao/monad-learning-notes
```

## 用户测试任务

请测试者阅读项目简介后完成一个任务：

```text
判断下面 4 笔 AI 候选交易是否应该被 IntentGuard 允许。
```

已设置的用户策略：

```json
{
  "allowedTarget": "0x7d465988fbe510c7b1890e822be4a66078c09b80",
  "allowedSelector": "0x183ff085",
  "maxValue": "0"
}
```

策略含义：

```text
只允许 AI 建议调用 CheckIn 合约的 checkIn()，并且不能携带 MON 转账。
```

测试用例：

| 编号 | AI 候选交易 | 期望用户判断 |
| --- | --- | --- |
| 1 | 调用 `CheckIn.checkIn()`，value = 0 | 应该允许 |
| 2 | 调用另一个陌生合约，value = 0 | 应该拒绝 |
| 3 | 调用 `CheckIn` 合约，但不是 `checkIn()` 函数 | 应该拒绝 |
| 4 | 调用 `CheckIn.checkIn()`，但携带 0.01 MON | 应该拒绝 |

完成后请测试者说明：

```text
你是根据哪个字段判断允许或拒绝的？
```

## 反馈问题

请测试者回答 3–5 个简单问题：

1. 你能用一句话说出这个项目想解决什么问题吗？
2. 你是否理解 `target`、`selector`、`value` 分别限制什么？
3. 哪个部分最难懂：AI 候选交易、合约检查、用户确认，还是 mock 数据？
4. 看完介绍后，你是否相信这个 Demo 能减少 AI 越权操作的风险？为什么？
5. 如果只改一个地方，你希望我们优先改 README、流程图、示例交易，还是页面展示？

## 项目介绍页 / Landing Page 草稿

### 页面标题

```text
IntentGuard Agent Wallet
```

### 副标题

```text
让 AI 能建议链上操作，但不能越过用户设置的权限边界。
```

### 第一屏核心文案

```text
AI Agent 正在进入 Web3，但钱包权限不能交给一句自然语言。
IntentGuard 用最小的合约规则检查每一笔候选交易：
它能调用哪个合约？
它能调用哪个函数？
它能转出多少资产？
```

主按钮：

```text
查看 Mini Demo
```

次按钮：

```text
参与 5 分钟测试
```

### 它帮助谁

```text
适合第一次尝试 AI x Web3 的 Monad 新人、Builder Camp 团队，以及想理解 Agent 钱包权限边界的开发者。
```

### 它解决什么问题

```text
AI 可以生成交易建议，但新人很难判断这笔交易有没有越权。
IntentGuard 把用户授权变成清楚的检查规则，在签名前先判断是否允许。
```

### Mini Demo 展示什么

```text
固定用户意图：
只允许 AI 调用 CheckIn.checkIn()，禁止转出 MON。

Demo 流程：
用户意图 → mock AI policy JSON → 候选交易 → IntentGuard 检查 → 允许 / 拒绝
```

### 当前完成状态

```text
已完成：
- 项目问题定义
- Mini Demo 范围
- mock policy JSON
- 合约接口设计
- 测试任务设计
- 真实 Monad 测试网 CheckIn 交互证据

未完成：
- 完整前端
- 真实 LLM API
- 自动签名
- IntentGuard 测试网部署
```

### 海报文案草稿

```text
AI 能帮你准备交易，
但不能替你越权操作钱包。

IntentGuard Agent Wallet
一个 Monad / AI x Web3 Mini Demo

核心机制：
target 检查
selector 检查
value 检查
用户最终确认

5 分钟体验任务：
判断 4 笔 AI 候选交易哪些应该允许，哪些应该拒绝。
```

## 提交材料清单

- 项目介绍：已完成
- 测试邀请：已完成
- 测试任务：已完成
- 反馈问题：已完成
- Landing Page / 海报草稿：已完成
- 真实用户反馈：待收集后补充
- 分享截图或会议记录：待收集后补充
