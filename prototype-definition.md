# 最小 Web3 / AI 原型定义：IntentGuard Agent Wallet

## 我要做的最小功能是什么？

我要做一个更有创新度的 Web3 / AI 原型：

```text
IntentGuard Agent Wallet
```

它不是普通打卡 DApp，而是一个“AI Agent 安全执行守卫”原型。

用户用自然语言描述意图，例如：

```text
允许 AI 帮我在 Monad 测试网上执行低风险操作，但单笔不能超过 0.01 MON，只能调用白名单合约。
```

系统把这个意图转成链上策略，并在 AI 准备执行交易前做检查：

- 目标合约是否在白名单
- 调用函数是否允许
- 交易 Value 是否超过限制
- 是否需要用户二次确认
- 是否只是在测试网执行

最小版本的重点不是让 AI 自动控制钱包，而是证明：

```text
AI 可以提出交易建议，但链上策略合约负责限制它能做什么。
```

## 谁会使用它？

目标用户：

- 想尝试 AI Agent 链上操作，但担心资产安全的用户
- Monad Builder Camp 里做 AI x Web3 Demo 的团队
- 需要给 Agent 设置权限边界的开发者
- 想理解 session key、policy wallet、transaction guard 的学习者

这个原型适合 Week 3 组队，因为它同时包含：

- 合约开发
- AI 意图解析
- 钱包权限模型
- 安全边界设计
- Monad 测试网真实交易证据

## 用户完成的一个动作是什么？

用户完成的最小动作：

```text
创建一条 Agent 执行策略 → 让 AI 生成一笔交易 → 策略合约判断是否允许执行
```

用户视角流程：

1. 用户连接钱包
2. 用户输入自然语言策略：
   ```text
   只允许 AI 调用 CheckIn 合约，禁止转出 MON。
   ```
3. 系统生成策略参数：
   - allowedTarget：`CheckIn` 合约地址
   - maxValue：`0`
   - allowedSelector：`checkIn()`
4. 用户把策略写入 `IntentGuard` 合约
5. AI 生成一次 `checkIn()` 调用建议
6. `IntentGuard` 检查交易是否符合策略
7. 符合则允许执行，不符合则拒绝
8. 页面展示：
   - 这笔交易为什么被允许 / 拒绝
   - 触发了哪条规则
   - 对应交易 Hash 或模拟结果

## 我需要读哪 1–3 个文档？

本周只读最相关的 3 个方向：

1. Monad Developer Docs  
   https://docs.monad.xyz/

   用途：确认 Monad 测试网、RPC、Gas、部署和交易查看方式。

2. Foundry Book  
   https://book.getfoundry.sh/

   用途：搭建合约项目、写测试、写部署脚本、跑本地验证。

3. Moss Repository / Docs  
   https://github.com/nishuzumi/moss

   用途：学习 Moss 的安全边界：Agent 不签名、不广播，交易需要构建、解释、模拟和人工确认。

## 本周真实实现什么？

本周真实实现一个非常小的安全守卫原型：

### 合约部分

写一个 `IntentGuard.sol`：

- 用户可以设置一条策略：
  - 允许的目标合约 `allowedTarget`
  - 允许的函数选择器 `allowedSelector`
  - 最大转账金额 `maxValue`
- 提供 `validateTransaction(address target, uint256 value, bytes calldata data)`：
  - target 不匹配则拒绝
  - value 超过限制则拒绝
  - selector 不匹配则拒绝
  - 全部满足则通过

### 测试部分

用 Foundry 写最小测试：

- 允许调用 `CheckIn.checkIn()`
- 拒绝调用非白名单合约
- 拒绝转出 MON
- 拒绝非白名单函数 selector

### AI 部分

先不接真实 LLM API，而是写一个 Prompt / JSON mock：

```json
{
  "userIntent": "只允许 AI 调用 CheckIn 合约，禁止转出 MON",
  "policy": {
    "allowedTarget": "0x...",
    "allowedSelector": "0x183ff085",
    "maxValue": "0"
  }
}
```

AI 的职责是解释和生成候选策略，不负责签名和最终执行。

### 证据部分

保留至少一种真实 Proof：

- `forge test` 通过截图或输出
- 合约部署到 Monad 测试网的交易 Hash
- 或至少一次对 `IntentGuard` 的链上调用记录
- README 说明策略检查过程

## 哪些可以 mock？

可以 mock：

- AI 意图解析：先用固定 JSON 表示 AI 输出
- 前端 UI：可以先用 README + 脚本替代
- 多协议支持：本周只支持 `CheckIn`
- session key：先不做真实 session key，只做策略守卫
- 交易模拟：可以先用 Foundry 测试代替真实模拟服务

不能 mock：

- `IntentGuard` 合约逻辑
- Foundry 测试
- 允许 / 拒绝的判断规则
- 最终 README 里的安全边界说明
- 如果写链上证据，交易 Hash 和截图不能伪造

## 我如何证明它做出来了？

Proof of Work：

- GitHub repo 有 `IntentGuard.sol`
- 有 Foundry 测试文件
- `forge test` 能通过
- README 解释：
  - 用户意图是什么
  - AI 输出了什么
  - 策略合约检查了什么
  - 哪些操作被允许 / 拒绝
- 有至少一个失败用例，例如：
  ```text
  AI 想调用非白名单合约 → IntentGuard 拒绝
  ```
- 如果完成部署，有 Monad 测试网交易 Hash 和截图

最小验收标准：

```text
队友看到 Demo 后能理解：AI 不是直接控制钱包，而是在链上策略限制下提出交易建议；真正的安全边界由合约和用户确认共同决定。
```

## 为什么这个比 CheckIn Copilot 更创新？

`CheckIn Copilot` 只是解释一笔交易，创新度偏低。

`IntentGuard Agent Wallet` 更接近 AI x Web3 的核心问题：

- AI Agent 如何获得有限链上权限
- 用户如何约束 Agent 的行为
- 钱包如何在不暴露私钥的情况下让 Agent 协助操作
- 如何用合约把自然语言意图变成可验证规则
- 如何防止 Agent 幻觉造成错误交易

它和我之前做过的 SafePay Guard Wallet、Safe Session Key、AI x Web3 Bridge 更连续，也更适合 Week 3 组队和 Hackathon 展示。

## 当前取舍

本周不做完整 AI Wallet，不做复杂 DeFi，不做真实自动签名。

只做一个最小但有说服力的核心：

```text
AI 生成候选交易 / 策略 → IntentGuard 检查 → 合约允许或拒绝
```

这比做一个漂亮页面更重要，因为它验证的是 AI Agent 链上执行的安全边界。

