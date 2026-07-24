# 项目研究简报：IntentGuard Agent Wallet

## 目标用户遇到的问题

目标用户是第一次尝试 AI x Web3 的 Monad 新人、Builder Camp 团队，以及想让 AI Agent 协助链上操作的开发者。

他们遇到的核心问题是：

```text
AI 可以生成交易建议，但用户不知道这笔交易是否越权，也不知道该把哪些权限交给 AI。
```

具体表现：

- 看不懂合约地址、函数 selector、calldata 和 value
- 不知道 AI 生成的交易是否符合自己的真实意图
- 担心 AI 幻觉、误调用合约或转出资产
- 不清楚“AI 建议交易”和“AI 直接控制钱包”的边界

## 3 条问题证据

### 证据 1：EIP-7702 把“权限降级”列为重要动机

EIP-7702 说明，EOA 需要获得更接近智能账户的能力，包括批量交易、Gas sponsorship 和权限降级。它举例说明用户可能希望给子密钥更弱的权限，例如只能花费特定 token、限制每日额度、只与特定应用交互。

这说明“有限授权”和“权限边界”不是伪问题，而是账户抽象方向中的真实需求。

### 证据 2：Safe 明确区分 Module 和 Transaction Guard

Safe 文档说明，Safe Modules 可以扩展 Safe 的执行能力，但也提醒恶意 Module 可能接管 Safe。Safe 的 Transaction Guard 则用于在交易执行前后做检查，例如检查交易参数。

这说明成熟智能账户也需要“执行前检查”机制，不能只依赖普通多签或钱包弹窗。

### 证据 3：MOSS / Agentic Wallet 类产品强调 Agent 权限层

MOSS 的公开介绍把 Raw EOA + private key 描述为危险模式，原因是密钥泄露会带来完全损失、Agent 权限不受限制、无法撤销或按应用 / 时间 / 金额限制。

这和 `IntentGuard` 的问题假设一致：AI Agent 需要权限层，而不是直接持有用户私钥。

## 类似产品或现有解决方式

### 1. Safe Modules / Transaction Guards

Safe 的方向是智能账户扩展：Module 可以执行自定义逻辑，Guard 可以在交易前后检查参数。

和 `IntentGuard` 的关系：

- 相似点：都关注交易执行前的权限检查
- 不同点：Safe 是成熟智能账户体系，`IntentGuard` 是新人可理解的最小 Demo
- 可借鉴点：把规则写成明确的参数检查，不把权限判断藏在自然语言里

### 2. MOSS / Agentic Wallet

MOSS 方向是给 AI Agent 提供钱包、身份和权限层，让 Agent 能执行任务但不直接暴露私钥。

和 `IntentGuard` 的关系：

- 相似点：都关注 Agent 能做什么、不能做什么
- 不同点：MOSS 是完整执行层，`IntentGuard` 本周只验证 target、selector、value 三个规则
- 可借鉴点：强调私钥不暴露、权限可限制、操作可解释

## 项目可能遇到的风险

### 技术风险

- `IntentGuard` 目前只是骨架，还没有正式编译和测试
- `bytes4(data[:4])` 需要真实 Solidity 编译验证，可能要改成 assembly
- 本地 `forge` 暂时不可用，Foundry 测试还没跑通
- 只检查 selector 可能不够，复杂 calldata 参数仍可能隐藏风险

### 用户理解风险

- 新人可能不理解 `target / selector / value`
- 用户可能误以为“通过 IntentGuard 检查”就等于绝对安全
- 如果 README 没讲清楚 mock 与真实开发部分，测试者会误解项目完成度

### 产品范围风险

- 很容易从最小 Guard 扩展成完整钱包、AI Agent、前端、session key
- 如果范围失控，本周无法交付可展示 Demo
- 如果没有真实用户反馈，项目只能证明技术兴趣，不能证明用户需求

## 给团队的建议

1. 继续压缩 Demo 范围。本周只证明一件事：`IntentGuard` 能区分允许和拒绝的候选交易，不做自动签名、完整钱包和真实 LLM。
2. 把新人语言放在技术语言前面。先解释“AI 不能越权操作钱包”，再解释 `target / selector / value` 分别是什么。
3. 尽快找 3 名外部同学测试 README。重点观察他们是否能判断 4 个测试用例，而不是问他们“喜不喜欢这个项目”。

## 人工检查结论

AI 可以帮助整理资料和生成简报结构，但关键判断需要人工确认：

- 不能把未跑通的合约写成已完成
- 不能把 MOSS、Safe、EIP-7702 简化成同一种方案
- 不能暗示 `IntentGuard` 已经达到审计级安全
- 不能伪造用户反馈、测试结果或部署交易

当前人工判断：

```text
项目问题真实，但本周只能做最小策略检查 Demo。它适合作为 Week 3 Dev Builder 的起点，不适合现在承诺完整 Agent Wallet。
```

## 参考资料

- EIP-7702: Set Code for EOAs  
  https://eips.ethereum.org/EIPS/eip-7702
- Safe Modules  
  https://docs.safe.global/advanced/smart-account-modules
- Safe Transaction Guard 说明  
  https://help.safe.global/articles/6757075087-what-is-a-transaction-guard
- Safe Smart Account Reference  
  https://docs.safe.global/reference-smart-account/overview
- MOSS Agentic Wallet 介绍  
  https://joinmoss.megaeth.com/ai-agent-guide
- Coinbase AgentKit  
  https://github.com/coinbase/agentkit
