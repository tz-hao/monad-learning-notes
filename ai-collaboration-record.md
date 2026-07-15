# AI 协作记录

## 背景

本记录用于说明 Week 1 / Week 2 Monad 学习过程中，AI 在 Dev Builder 方向中具体参与了哪些工作，人类做了哪些删改、核查和最终判断，以及哪些部分不能交给 AI。

当前主方向：

```text
Dev Builder
```

当前核心产出：

- `CheckIn` 最小打卡合约
- Monad 测试网真实 `checkIn()` 交易记录
- Mini Demo 0
- Week 1 复盘
- Week 2 Role Choice Card
- Week 2 学习记录

## AI 帮了什么

AI 主要承担了“辅助生成、解释、整理、核查”的工作。

### 代码与合约

- 生成最小 Solidity 打卡合约 `CheckIn`
- 解释合约结构，包括 `mapping`、`msg.sender`、`block.timestamp`、`require`、`event`
- 帮助区分部署交易和合约交互交易
- 通过 Monad 测试网 JSON-RPC 查询交易回执和交易详情
- 把交易字段整理成可读表格，例如区块号、Gas、From、To、Input、事件 count

### 文档与学习记录

- 整理 `README.md`
- 整理 `MiniDemo0.md`
- 整理 `week1-review.md`
- 整理 `week2-direction.md`
- 建立 `week2-learning-log.md`
- 把零散 Prompt、截图、错误、判断变化整理成持续记录格式

### 方向选择

- 辅助比较 Dev / Ops / Research 的差异
- 帮助把方向选择整理成 `Role Choice Card — Dev Builder`
- 补全 Week 2 Minimum Deliverable
- 帮助明确 Week 3 角色定位：合约开发者 & AI 集成工程师

## 人类删改 / 核查了什么

AI 输出不是直接提交结果，人类做了以下核查和修改：

### 内容核查

- 确认 Week 2 主方向不是泛泛的 Tech，而是更明确的 `Dev Builder`
- 补充个人真实背景：SafePay Guard Wallet、x402 Demo、Safe Session Key、AI × Web3 Bridge 学习经历
- 强化选择理由：能力匹配、AI × Web3 切入点、代码产出可验证
- 明确 Week 3 组队角色和需要的队友类型

### 链上证据核查

- 提供真实 MonadVision 交易链接和截图
- 确认交易 Hash：`0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814`
- 确认该交易是 `checkIn()` 合约交互，不是部署交易
- 确认没有部署交易 Hash 时不能伪造成已部署记录
- 确认截图、交易 Hash、RPC 查询结果可以互相对应

### 仓库核查

- 纠正仓库目标：真正要维护的是 `tz-hao/monad-learning-notes`
- 避免把另一个本地仓库 `monad` 当成学习笔记主仓库
- 发现并修正嵌套仓库带来的上传混乱
- 确认提交前后 `git status`，避免误提交无关目录

## 哪些不能交给 AI

以下部分不能完全交给 AI，必须由人类最终负责。

### 私钥、钱包和签名

- 私钥不能交给 AI
- 钱包签名不能自动交给 AI
- 主网或测试网交易确认必须由人类在钱包中检查
- 授权、转账、部署等链上操作必须人工确认风险

### 真实性判断

- 交易 Hash 是否真实
- 合约地址是否正确
- 截图是否对应同一笔交易
- 交易是部署还是调用
- 是否真的在 Monad 测试网上发生

这些不能只相信 AI 描述，必须用区块浏览器、RPC 或钱包记录核查。

### 方向选择

AI 可以辅助分析 Dev / Ops / Research 的优劣，但不能替我决定方向。

最终选择 Dev Builder，是基于我的真实技能背景、Week 1 产出、Week 3 组队需求和 Hackathon 展示目标。

### 安全与边界

AI 不能替我判断所有安全后果，尤其是：

- 合约是否适合生产环境
- `block.timestamp` 是否满足业务语义
- Gas 成本是否可以接受
- Agent 是否应该执行某个链上操作
- 是否应该授权某个合约花费资产

AI 的建议只能作为辅助，最终安全判断必须由人类承担。

## 我的协作原则

后续我会按以下方式使用 AI：

- AI 负责生成初稿、解释概念、整理结构、辅助排错
- 我负责核查事实、删改内容、确认方向、控制风险
- 涉及私钥、签名、转账、授权、部署时，必须人工确认
- 所有链上产出尽量保留交易 Hash、截图、README 和错误记录
- 不把 AI 输出当作最终事实，必须经过验证再提交

## 本周结论

AI 对我的帮助最大的是提高整理和开发启动速度；但 Monad / Web3 学习的核心仍然是可验证的链上实践。

Dev Builder 的 Proof of Work 不能只靠文字，需要代码、测试、交易 Hash、截图和复盘记录共同支撑。

