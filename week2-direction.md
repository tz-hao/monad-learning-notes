# Role Choice Card — Dev Builder

## 1. 我选择的方向

💻 Dev（开发）

## 2. 选择理由

三个层次的理由：

### 能力匹配

我有实际的 Web3 开发基础。此前完成过 SafePay Guard Wallet（智能合约钱包）、x402 协议 Demo、Safe Session Key 脚本，熟悉 Solidity / Foundry / 链上交互全流程。

选择 Dev 不是从零开始，而是把已有技能在 Monad 生态中落地验证。

### AI × Web3 是最佳切入点

我已完成 AI × Web3 Bridge 系统学习，理解 Agent 架构、钱包权限模型和链上安全执行。

Monad 的高性能 EVM（10,000 TPS）天然适合 AI Agent 的链上高频操作场景，这正是我想探索的方向。

### 产出可验证

Dev 的 Proof of Work 是代码、repo、交易 hash、截图录屏，不可造假、不可模糊。

相比 Research 的论述和 Ops 的活动方案，代码产出的说服力更适合我的 Week 3 组队和 Hackathon 展示。

## 3. 服务的问题

Dev Builder 解决的核心问题是：把需求变成可运行的原型。

在 Monad Builder Camp 的语境下，具体包括：

- 降低 Monad 开发门槛：通过 AI-assisted 开发工作流，让团队快速验证想法，减少「读文档 → 写第一行代码」之间的摩擦
- 桥接 AI 与链上执行：探索 AI Agent 如何在 Monad 上安全、高效地执行链上操作（交易、合约调用、数据查询）
- 为 Week 3 团队提供技术 backbone：能承担合约开发、前端对接、链上调试等关键角色，确保团队 Demo 不卡在「没人会写合约」

## 4. 本周最小产出（Week 2 Minimum Deliverable）

本周最小产出是：

```text
Monad CheckIn Demo 1
```

目标不是做完整产品，而是把 Week 1 的最小打卡合约升级成一个更标准、更可验证的 Dev Demo。

交付内容：

- 标准 Foundry 项目结构：`src/`、`test/`、`script/`
- 升级版 `CheckIn` 合约：在每日打卡基础上增加连续打卡天数或积分记录
- 最小测试用例：覆盖首次打卡、重复打卡失败、间隔后再次打卡、计数更新
- 部署或交互记录：保留 Monad 测试网交易 hash、合约地址、截图
- README：说明项目功能、如何安装、如何测试、如何部署、AI 辅助了哪些步骤
- 失败与修复记录：记录至少一个开发中遇到的问题，以及如何定位和修复

验收标准：

- 本地可以运行测试
- 合约逻辑能被 README 解释清楚
- 至少有一条真实 Monad 测试网交互证据
- 产出能让 Week 3 队友快速判断我能承担 Dev Builder 角色

## 5. 参考资料

核心必读：

- Monad Developer Docs：https://docs.monad.xyz/
- Solidity Docs：https://docs.soliditylang.org/
- Foundry Book：https://book.getfoundry.sh/

AI × 开发工作流：

- Cursor Docs：https://docs.cursor.com/
- GitHub Docs（Issue/PR 协作）：https://docs.github.com/

Monad 特有知识点：

- Monad Best Practices：https://docs.monad.xyz/developer-essentials/best-practices
- Monad Gas Pricing：https://docs.monad.xyz/developer-essentials/gas-pricing
- BuildAnything Freshman（Monad 入门）

Bonus 开源贡献：

- Moss Repository：https://github.com/nishuzumi/moss

## 6. Week 3 角色定位

> 我是团队的合约开发者 & AI 集成工程师。

进入 Week 3 组队后，我能承担：

- 智能合约开发：Solidity 合约设计、编写、测试、部署到 Monad 测试网
- AI Agent 集成：将 AI 能力（LLM 调用、意图解析）与链上执行对接
- 全栈脚手架：Foundry + 前端（如果需要）的工程化搭建
- 技术方案输出：帮团队定义 Scope、Tech Stack、API 边界，防止 Week 3 需求膨胀

需要的队友：

- 一个 Ops / 产品队友：负责 Demo 叙事、用户场景定义、Hackathon 展示材料
- 一个 Research / Frontend 队友（可选）：负责竞品调研或前端 UI

