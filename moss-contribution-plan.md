# Moss 开源贡献计划

**Builder 身份：** Research Builder  
**周期：** 2026-07-15 ～ 2026-07-21  
**项目：** [nishuzumi/moss](https://github.com/nishuzumi/moss)

## 选择的贡献方向

我选择 **Research Builder**。本周先围绕 Moss 的架构、Agent Workflow 与安全边界输出一篇可供新贡献者使用的中文技术笔记，并将其中可直接进入项目的改进点整理为 Documentation 建议。

## 为什么选择这个方向

我已经完成 Moss 的基础调研，能够用中文解释它为何以 `discover → load → action → simulate` 组织 Agent 的链上操作。相比立刻编写协议 adapter，这条路径更适合当前阶段：

- Moss 仍处于 Alpha，先准确理解 Plan、`expects`、模拟和 warning 的边界更重要。
- 项目已经提供英文 Getting Started、MCP 工具与 Agent Skill 文档，但新中文读者仍需要一份以“Agent 为什么必须模拟并停在 warning 前”为主线的导读。
- 先输出可验证的文档和术语对照，可以降低后续参与 adapter、Demo 或 PR 的理解成本。

## 准备完成的任务

### 必做

1. 阅读 `@themoss/core`、`@themoss/simulator`、`@themoss/mcp-server` 三层职责，以及一个协议 adapter（WMON 或 Kuru）。
2. 画出 Agent 的标准调用链：用户意图 → `discover` → `load` → `action` → `simulate` → 人工确认/钱包签名。
3. 输出中文技术笔记《Moss Agent Workflow 与安全边界》：解释 Plan、`expects`、effects reconciliation、intent alignment、warning halt rule。
4. 整理至少 5 个新贡献者常见问题，例如“零 warning 是否等于可以无条件签名？”、“为什么不能从网页记忆 token 地址？”、“多步骤 Plan 如何模拟？”。
5. 将可以被上游采用的文档改进建议整理成一个 GitHub Issue；若维护者确认范围合适，再提交文档 PR。

### 验收标准

- 技术笔记包含一个 `claim → swap → supply` 的多步骤示例，并清楚标注模拟与签名的边界。
- 每个安全结论都能回链到 Moss 的官方 README、MCP Tools 或 Agent Skill Guide。
- Issue 或 PR 只包含可复现、范围明确的文档建议，不修改核心交易逻辑。

## 本周计划

| 时间 | 计划 | 产出 |
| --- | --- | --- |
| Day 1 | 阅读 README、Getting Started、Agent Skill；建立核心术语表。 | 架构与术语笔记 |
| Day 2 | 阅读 `core`、`simulator`、`mcp-server` 的职责与 Plan 结构。 | 分层架构图与 Plan 字段说明 |
| Day 3 | 跟随官方示例梳理 `discover → load → action → simulate`。 | Agent Workflow 图与单步骤案例 |
| Day 4 | 研究多步骤模拟和 warning 规则，整理失败/停止条件。 | 安全边界与 FAQ 草稿 |
| Day 5 | 完成中文技术笔记，检查术语、链接与事实准确性。 | 可公开的 Markdown 文档 |
| Day 6 | 将可上游化的改进点写成 Issue；若适合，准备最小文档 PR。 | 1 个 Issue 或 1 个文档 PR 草稿 |
| Day 7 | 回顾维护者反馈，补充待办与下一周 Dev Builder 路线。 | 周复盘与后续贡献清单 |

## 贡献边界

- 不跳过 `simulate`，不将模拟结果表述为执行保证。
- 不处理私钥、不代替用户签名，也不提交未经验证的交易示例。
- 第一周只做研究和文档产出；新的协议 adapter 或核心逻辑改动留到充分理解项目约束之后。

## 参考资料

- [Moss README](https://github.com/nishuzumi/moss)
- [Getting Started](https://github.com/nishuzumi/moss/blob/main/docs/getting-started.md)
- [MCP Tools Reference](https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md)
- [Agent Skill Guide](https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md)
- [Protocol Onboarding Guide](https://github.com/nishuzumi/moss/blob/main/docs/protocol-onboarding.md)
