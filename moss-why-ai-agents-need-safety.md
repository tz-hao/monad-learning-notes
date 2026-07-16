# 为什么 AI Agent 需要 Moss：让链上自动化先学会“停下”

当我们说“让 AI 帮我把 1 MON 换成 USDC”时，听起来像一句自然语言指令。但在链上，它并不是一个简单动作：Agent 要选协议和路由、找到正确合约地址、处理代币精度、计算滑点，还可能需要先授权、包装原生币并清理交易残余。

任何一个环节“差不多对”，都可能带来真实的资产风险。

这正是 [Moss](https://github.com/nishuzumi/moss) 想解决的问题：它不是让 AI 更自由地拼装交易，而是把复杂协议交互收敛成可发现、可构建、可模拟、可核对的能力，让 AI 在高风险场景中拥有更少、但更可靠的自由度。

## Moss 是什么？

Moss 是面向 Monad 的 AI Agent × Web3 开源框架。它把不同 DApp 和协议的交互统一成四个步骤：

```text
discover → load → action → simulate
```

- `discover`：按用户语义寻找能力，例如 `swap`、`transfer`、`wrap`。
- `load`：读取该能力的意图、参数语义和风险标签。
- `action`：由协议适配器构建未签名交易，而不是由 Agent 手写 calldata。
- `simulate`：在当前链上状态中重放交易，核对实际效果和预期是否一致。

Moss 不持有私钥，不签名，也不广播交易。最终确认仍在用户的钱包中完成。这个边界很重要：框架负责构建和验证，Agent 负责理解用户意图，用户负责最终授权。

## 它解决的不是“会不会调用合约”，而是“能不能安全调用”

普通 Agent 可以读取 ABI，再尝试拼出一次 DEX 交易。但交易路径里有大量容易出错的细节：

- exact-in 与 exact-out 的调用差异；
- 原生 MON 与 WMON 的转换；
- 代币的小数位与人类可读金额；
- 授权对象和授权额度；
- 滑点、退款、sweep 等多调用清理逻辑；
- 多步骤流程中前一步产生的资产如何被后一步使用。

Moss 的做法是让每个协议提供 adapter。adapter 把协议细节包装成统一能力，Agent 只传入有语义的参数，例如 `tokenIn: "MON"`、`amount: "1"`，而不是自己记住地址、编码函数和处理单位。

这降低的不是模型“写代码”的难度，而是它在资金操作中猜错细节的概率。

## Moss 的安全核心：两层检查

我理解 Moss 最有价值的地方，是它把“交易正确”拆成两件不同的事。

第一层是**机械对账**。一次写操作会生成 Plan，其中声明预期的资产流出、流入和授权。模拟器使用链上 trace 重放交易，提取真实资产变化、授权和接收方；如果出现未声明的流出、授权超限、最低流入未达成、Plan 被篡改或交易回滚，就产生 warning。出现 warning，流程必须停止。

第二层是**意图对齐**。即使模拟没有 warning，也只代表交易符合它声明的 Plan，并不自动代表它符合用户原话。Agent 仍要检查：用户要换的币种、金额和方向是否一致？授权对象是否合理？实际结果是否变成了另一个协议操作？

这正是 AI Agent 不可被“全自动化”掩盖的责任：系统能验证链上效果，但只有 Agent 和用户知道最初的意图。

## 一个简单例子：从“换币”到可审查流程

假设用户说：“把 1 MON 换成 USDC。”

使用 Moss 的 Agent 不应直接调用某个 router，而应：

1. 用 `discover` 找到支持 `swap` 的协议；
2. 用 `load` 确认参数、风险与协议能力；
3. 用 `action` 构建对应账户的未签名 Plan；
4. 用 `simulate` 检查模拟得到的 MON 流出、USDC 流入、授权和接收方；
5. 只要有 warning 就停止并解释；
6. 零 warning 后，仍向用户展示“支付什么、收到什么、授权给谁、可能有哪些滑点或市场变化”；
7. 由用户在钱包中审阅并签名。

这个过程比“一句话直接交易”多了几步，但这些步骤让自动化变得可解释、可审查、可停止。

## 它可以用在哪里？

我认为 Moss 很适合以下场景：

- **自然语言交易助手**：把“兑换、转账、包装 MON、查询余额”等请求转成可验证操作。
- **DeFi 自动化工作流**：例如“领取收益 → 兑换 → 存入”，并在同一次模拟中串联状态。
- **企业钱包预审**：先输出资产变化和风险摘要，再进入多人审批或钱包签名流程。
- **协议接入层**：为 Monad 上的 DEX、借贷、质押或 NFT 协议编写独立 adapter，形成可发现的能力目录。
- **本地 fork 测试**：在接近真实链上状态的环境中验证 Agent 流程，而不使用真实资金。

当然，Moss 不是成交保证。模拟结果基于模拟时的链上状态；价格、流动性和合约状态都可能在签名后变化。它提供的是安全网，而不是对未来执行结果的承诺。

## 我的第一次 Moss 开源实践

我最初把 Moss 理解为“给 Agent 调用合约的一层封装”。阅读 README、MCP Tools 和 Agent Skill Guide 后，我发现它更像一个责任分配框架：

- 协议作者负责把复杂实现写成诚实、可验证的能力；
- 框架负责模拟与机械化检查；
- Agent 负责意图对齐和清晰解释；
- 用户始终保留签名权。

基于这个理解，我参与了 Moss 的设计讨论：在永续合约场景中，普通代币流并不足以表达仓位、杠杆和清算风险。未来若接入 perps 协议，除了验证保证金流，还需要让 Agent 看见结构化的仓位结果，并明确停止条件。这种从“能否接入”到“接入后如何安全解释”的思考，也是我认为开源贡献最有价值的部分。

## 如何开始参与？

不一定要从写大功能开始。

1. 先运行官方 Getting Started，观察一次 `discover → load → action → simulate`。
2. 阅读 Agent Skill Guide，理解“任何 warning 都停止”和“零 warning 后仍需意图对齐”。
3. 选择适合自己的方向：补充文档/示例、研究协议语义、完善测试，或从协议 adapter 模板开始。
4. 在 Issue 中先讨论设计边界，再提交小而可验证的 PR。

对我来说，Moss 的启发是：AI Agent 进入 Web3，不应只追求“替用户执行”，更应具备“在证据不足时停下”的能力。把这条原则写进框架、文档和社区协作流程，才是 AI × Web3 真正值得投入的基础设施。

## 参考

- [Moss GitHub 与 README](https://github.com/nishuzumi/moss)
- [Getting Started](https://github.com/nishuzumi/moss/blob/main/docs/getting-started.md)
- [MCP Tools Reference](https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md)
- [Agent Skill Guide](https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md)
- [Protocol Onboarding Guide](https://github.com/nishuzumi/moss/blob/main/docs/protocol-onboarding.md)
