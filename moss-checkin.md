# Moss 学习打卡记录

**日期：** 2026-07-15  
**主题：** AI Agent × Monad：Moss 框架调研

## 今日完成

- 阅读 Moss 的 README、Getting Started、MCP Tools 与 Agent Skill Guide。
- 理解 Moss 通过 `discover → load → action → simulate` 统一链上协议能力。
- 完成 Moss 的项目简介、核心问题、核心能力和应用场景整理。
- 将调研笔记提交到本仓库：[Moss 调研](./moss-research.md)。

## 关键收获

Moss 的价值不只是帮助 Agent 调用链上协议，更重要的是限制 Agent 在高风险操作中的自由度：

1. 协议 adapter 负责构建正确的未签名交易，Agent 不手写 calldata。
2. Plan 会声明资产流出、流入和授权预期；模拟后必须对账。
3. 出现任何警告时必须停止，不能交给钱包签名。
4. 即使模拟零警告，Agent 仍需确认交易结果是否与用户原始意图一致。

## 我的理解

对 AI Agent 来说，“能完成交易”不足以代表安全。更可靠的路径是：让框架处理确定性的交易构建与效果验证，让 Agent 负责理解用户意图，让用户保留最终签名权。Moss 正是在 Monad 生态中把这三层责任分开的一个实践。

## 后续计划

- 继续关注 Moss 支持的协议 adapter 与能力目录。
- 尝试在本地或 Monad fork 环境中跑通一次 `discover → load → action → simulate`。
- 对比 Agent 直接调用合约与经由能力层调用的安全边界。

## 参考

- [Moss](https://github.com/nishuzumi/moss)
- [Moss Agent Skill Guide](https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md)
