# Moss 调研：让 AI Agent 更安全地操作链上协议

## 项目简介

[Moss](https://github.com/nishuzumi/moss) 是面向 Monad 的 AI Agent 交易执行框架。它把不同 DApp/协议的交互统一为 `discover → load → action → simulate`：协议适配器负责构建交易，Agent 不需要手写 calldata。Moss 只构建和验证未签名交易，永不持有私钥、签名或广播。

## 核心问题

一次看似简单的链上兑换，实际涉及路由地址、ABI、精度、滑点、授权、原生币包装与清理等细节。Agent 即使只错一个参数，也可能造成资金损失。

Moss 将这些协议细节和安全校验从 Agent 的自由推理中抽离出来，封装为可复用、可模拟、可验证的能力层。

## 核心能力

- **能力发现**：按用户语义（如 `swap`、`supply`）查找协议能力，而非按合约函数名。
- **Plan 构建**：输出未签名交易、预期资金流 `expects`、风险标签及完整性哈希。
- **链上模拟与对账**：基于 trace 重放交易，核对真实资金流、授权和接收方与 Plan 声明是否一致。
- **警告即停止**：未声明流出、授权超限、回滚或 Plan 被篡改时，不能进入签名环节。
- **多步骤验证**：可在一次模拟中验证“领取 → 兑换 → 存入”等存在状态依赖的流程。
- **MCP 接入**：向 Agent 提供 `discover`、`load`、`action`、`simulate` 四个工具。

## AI Agent 为什么需要它

Agent 擅长理解“把 1 MON 换成 USDC”，但不应猜测底层合约调用。Moss 的责任划分是：

- 框架负责正确组装交易，并机械化核对实际效果。
- Agent 负责理解用户意图，并在模拟零警告后检查结果是否真的符合用户要求。
- 钱包与用户保留最终签名权。

因此，Moss 验证的是“交易是否符合已声明的 Plan”；而 Agent 仍必须验证“Plan 是否符合用户原话”。

## 可能应用场景

1. Monad 上的自然语言交易助手：兑换、转账、包装 MON、NFT 操作。
2. DeFi 投资或金库 Agent：领取收益、换币、供给、再平衡。
3. 企业钱包交易预审：先输出模拟结果和可读的资产变动，再交由审批人确认。
4. 多协议自动化：将各协议封装成独立 adapter，在统一安全流程下扩展能力目录。
5. 本地开发与测试：在主网 fork 上验证真实订单簿和多步骤交易，无需真实资金。

## 我的理解

Moss 的重点不是让 Agent 更自由地交易，而是让它在高风险链上场景中拥有更少、但更可靠的自由度。它将“自由生成合约调用”变成“从受约束的能力目录中选择、构建、模拟、解释”。可用性来自标准化接口，安全性来自模拟对账，而控制权始终留给用户。

Moss 目前仍处于 Alpha 阶段。模拟只反映模拟时的链上状态，不能保证签名后的结果不发生变化；真实使用仍应小额测试，并逐笔在钱包中确认。

## 参考链接

- [Moss GitHub 仓库与 README](https://github.com/nishuzumi/moss)
- [Moss Getting Started](https://github.com/nishuzumi/moss/blob/main/docs/getting-started.md)
- [Moss MCP Tools](https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md)
- [Moss Agent Skill Guide](https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md)
