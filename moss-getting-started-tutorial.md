# Moss 入门指南：从零跑通第一个可验证的链上 Agent 流程

> 适合想了解 AI Agent × Web3、Monad 或 Moss 的初学者。本文基于 Moss 当前主分支文档整理；Moss 仍处于 Alpha 阶段，请勿把模拟结果视为交易结果保证。

## 你将完成什么

完成本教程后，你将能够：

1. 在本地构建 Moss；
2. 运行一次 MON → WMON 的完整示例；
3. 理解 `discover → load → action → simulate`；
4. 将 Moss 接入 MCP 客户端；
5. 知道如何安全地开始贡献。

## 0. 先理解 Moss 的边界

Moss 负责**构建并验证未签名交易**，不保存私钥、不签名、不发送交易。它让 Agent 通过统一能力操作协议，但最终签名权仍在用户钱包。

核心原则只有两条：

- 每一次写操作都必须先 `simulate`；
- 任何 warning 都停止；零 warning 后，Agent 仍要检查结果是否符合用户原始意图。

## 1. 准备环境

需要：

- Node.js 22 或更高版本；
- pnpm；
- Git；
- 可访问 Monad RPC 的网络。

克隆并构建项目：

```bash
git clone https://github.com/nishuzumi/moss
cd moss
pnpm install
pnpm build
```

先运行离线测试，确认本地工具链正常：

```bash
MOSS_SKIP_E2E=1 pnpm test
```

> 去掉 `MOSS_SKIP_E2E=1` 后，测试还会运行 Monad 主网 E2E 模拟。Moss 的模拟不需要私钥或资金，但 RPC 必须支持 `debug_traceCall`。

## 2. 第一次运行：包装 MON

运行官方最小示例：

```bash
pnpm --filter @themoss/example-simple-flow wrap
```

该命令不会让你的钱包签名，也不会使用你的资金。它演示把 1.5 MON 包装为 WMON 的完整过程。

预期看到的四个阶段：

```text
discover → load → action → simulate
```

最后的关键结果是：模拟没有 warning。只有这时，未签名交易才可以被交给钱包审阅。

## 3. 读懂四步工作流

### `discover`：发现能力

Agent 先按用户意图找能力，而不是直接猜合约函数。例如用户想“兑换”，应搜索 `swap`；想“包装 MON”，应搜索 `wrap`。

这避免了把 WMON 的 `deposit()` 误解为借贷协议的 `supply`。Moss 关注的是用户视角的动作语义，而不是协议内部函数名。

### `load`：读取调用契约

`load` 返回能力的参数说明、意图模板和风险标签。此时要特别确认：

- 金额是人类可读的小数字符串，例如 `"1.5"`，不是基础单位；
- Token 使用受支持符号或用户明确提供的地址；
- 风险标签是否包含资金流出、授权或价格影响。

### `action`：构建 Plan

`action` 接收协议、方法、账户和参数，生成一个 Plan。Plan 包含完整的未签名交易，以及它声明的预期效果：最多流出什么资产、至少流入什么资产、授权上限是多少。

Agent 不应编辑 Plan，也不应自行补 calldata。若参数改变，重新调用 `action`。

### `simulate`：模拟并对账

模拟器会在当前链上状态中重放 Plan，提取实际资产流、授权、接收方与协议回执，并和 Plan 的声明对账。

常见 warning 包括：交易回滚、Plan 被篡改、未声明资金流出、授权超限、最低流入不满足、缺少确认回执。

**规则：任何 warning 都停止。** 不要反复重试模拟直到 warning 消失，也不要把 warning 当作普通日志。

## 4. 体验多步骤模拟

Moss 可以在同一次模拟中串联多个 Plan，后一步会看到前一步模拟产生的状态。官方示例是 MON → USDC → MON：

```bash
pnpm --filter @themoss/example-simple-flow swap
```

这类能力适合“领取收益 → 兑换 → 存入”等组合流程。关键不是交易数量，而是所有步骤都必须按执行顺序在模拟中验证。

## 5. 接入 MCP 客户端

构建成功后，可将 Moss 配置为 MCP server：

```json
{
  "mcpServers": {
    "moss": {
      "command": "node",
      "args": ["<path-to-moss>/packages/mcp-server/dist/cli.js"],
      "env": {
        "MOSS_RPC_URL": "https://rpc.monad.xyz"
      }
    }
  }
}
```

接入后，Agent 获得四个工具：`discover`、`load`、`action`、`simulate`。

一个安全的 Agent 提示词可以是：

```text
在 Monad 上报价 1 MON 可兑换多少 USDC。
先 discover 和 load；若需要写操作，必须 action 后 simulate。
任何 warning 都停止。不要签名、不要发送交易、不要请求私钥。
```

## 6. 新手常见问题

### 为什么模拟通过后还要用户确认？

模拟只反映模拟时的链上状态。价格、流动性和合约状态可能在签名前变化。Moss 提供验证，不替代用户的钱包审阅。

### 为什么不能自己从网页找 Token 地址？

代币名称和符号可以被伪造。优先使用 Moss 的受控目录；若目录没有该资产，应让用户明确提供地址，并说明这是用户提供的信任输入。

### `simulate` 失败怎么办？

先检查 RPC 是否支持 `debug_traceCall`。部分免费 RPC 禁用 `debug` 命名空间；Moss 会明确失败，而不是悄悄跳过模拟。

### 我能立刻让 Moss 操作真实资金吗？

不建议。Moss 目前是 Alpha，API 和 Plan 格式都可能变化。先运行示例、使用本地 fork 或小额测试，并始终在钱包中逐笔确认。

## 7. 如何贡献

你不必从复杂 adapter 开始：

1. **文档贡献**：补充中文教程、FAQ、示例解释或开发者体验反馈；
2. **研究贡献**：在 Issue 中梳理新协议的用户动作、风险与可验证效果；
3. **开发贡献**：复制 `packages/protocols/_template`，为一个协议实现能力、回执和测试。

协议 adapter 的最低要求是：ABI 与地址有来源并完成验证；能力准确声明风险和预期；模拟 happy path 无 warning；文档与测试同步更新。

## 8. 下一步

- 阅读 [Getting Started](https://github.com/nishuzumi/moss/blob/main/docs/getting-started.md) 了解每一层实现；
- 阅读 [MCP Tools](https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md) 了解完整输入输出；
- 阅读 [Agent Skill Guide](https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md) 了解 Agent 的强制安全规则；
- 浏览 [开放 Issue](https://github.com/nishuzumi/moss/issues) 选择一个小而可验证的贡献方向。

## 参考

- [Moss README](https://github.com/nishuzumi/moss)
- [Getting Started](https://github.com/nishuzumi/moss/blob/main/docs/getting-started.md)
- [MCP Tools Reference](https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md)
- [Protocol Onboarding Guide](https://github.com/nishuzumi/moss/blob/main/docs/protocol-onboarding.md)
