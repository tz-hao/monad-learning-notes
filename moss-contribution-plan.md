# Moss 开源贡献计划：永续合约语义研究

**Builder 身份：** Research Builder  
**目标 Issue：** [#15 Design: perpetuals need verbs and a category](https://github.com/nishuzumi/moss/issues/15)
**周期：** 2026-07-15 ～ 2026-07-21

## 选择的贡献方向

我选择参与 Issue #15：为 Monad 上永续合约（Perps）设计适合 Moss 的用户动作词、协议分类、风险标签与可验证效果模型。这是一个已有的开放设计议题，不与 #16 的新手文档/FAQ 改进重复。

## 为什么选择它

Moss 的核心是把用户意图映射为安全、可模拟的能力。现有动词集覆盖兑换、借贷、质押等操作，但无法表达开仓、平仓和保证金管理；而永续合约的“仓位”也不等同于普通代币流。

这更适合 Research Builder：先厘清语义、风险与验证边界，为后续 adapter 开发提供明确约束，而不是在规则未定义时直接写代码。

## 本周准备完成的任务

1. 阅读 Moss 的 `discover` 词汇设计、`expects` 对账模型、observations 以及 Agent halt rule。
2. 调研 Monad 上至少一个永续协议的公开交互模型，区分开仓、平仓、加/减保证金、清算与资金费。
3. 比较两套动词设计：
   - `open` / `close` + `long` / `short` 参数；
   - 以 `supply` / `withdraw` 表示保证金操作，并单独定义仓位动作。
4. 提出分类建议：新增闭集分类 `perps`，或保留 `dex` 并使用 `perps` tag；说明取舍。
5. 为每种动作写出可机械验证的 `expects` 与只能由 observation 叙述的结果。
6. 在 #15 提交一条结构化评论，供维护者讨论；未经确认不修改 ADR 或核心代码。

## 预期交付

- 一份 1～2 页的设计笔记：动词、分类、参数、风险标签与安全边界。
- 一张“用户意图 → Plan 预期 → 模拟效果 → Agent 检查”的映射表。
- Issue #15 下的讨论评论，明确待维护者决策的问题。

## 初步设计假设

| 用户动作 | 建议能力 | 可对账的效果 | 需 observation 补充的效果 |
| --- | --- | --- | --- |
| 开多/开空 | `open`，参数含方向与保证金 | 保证金流出、授权、接收方 | 仓位方向、名义价值、杠杆、开仓价 |
| 平仓 | `close` | 返还或扣除的资产流 | 已平仓数量、已实现盈亏 |
| 增加保证金 | `supply` 或 `marginAdd` | 资产流出 | 仓位健康度变化 |
| 提取保证金 | `withdraw` 或 `marginRemove` | 资产流入 | 可提额度、清算风险 |

无论采用哪一种命名，`leverage` 与 `liquidation` 都应作为明确风险标签；模拟出现未声明资金流、授权异常或回滚时，仍必须停止。

## 本周节奏

| 时间 | 工作 | 产出 |
| --- | --- | --- |
| Day 1 | 阅读 Issue #15 与相关 ADR、Agent Workflow。 | 术语与问题清单 |
| Day 2 | 调研一个 Monad 永续协议的用户动作和链上结果。 | 协议交互摘要 |
| Day 3 | 设计动词、分类与参数候选方案。 | 方案对比表 |
| Day 4 | 建立 `expects` / observation / risk labels 映射。 | 验证边界草图 |
| Day 5 | 完成设计笔记并自查是否符合 halt rule。 | 评论草稿 |
| Day 6 | 在 #15 发表结构化讨论评论。 | 上游讨论记录 |
| Day 7 | 根据反馈修订，并决定下周是否进入 adapter 实现。 | 周复盘 |

## 贡献边界

- 不在本周实现或提交永续协议 adapter；先等待词汇与验证边界达成共识。
- 不把模拟结果当作交易结果保证；不处理私钥、不签名、不广播交易。
- 所有设计必须兼容 Moss 的“warning 即停止”和“Agent 仍需对齐用户意图”规则。

## 参考

- [Issue #15](https://github.com/nishuzumi/moss/issues/15)
- [Moss README](https://github.com/nishuzumi/moss)
- [MCP Tools Reference](https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md)
- [Agent Skill Guide](https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md)
