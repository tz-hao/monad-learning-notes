# 开源项目阅读记录：从 Maintainer 视角看 GitHub 项目

## 阅读目标

学习如何阅读一个真实开源项目，理解 Maintainer 如何组织项目、管理问题、接收贡献，并找到一个自己感兴趣的问题或功能。

本次重点项目：

- 主项目：[nishuzumi/moss](https://github.com/nishuzumi/moss)
- 对比项目：[argotorg/solidity](https://github.com/argotorg/solidity)
- 对比项目：[NomicFoundation/hardhat](https://github.com/NomicFoundation/hardhat)

## 主项目：Moss

### README

Moss 的 README 很像一份“项目入口 + 安全边界说明”。它先解释项目定位：把 Monad 上复杂的 DApp / 协议交互统一成 Agent 可调用能力，核心流程是：

```text
discover → load → action → simulate
```

README 最重要的点不是“让 Agent 自动交易”，而是强调：

- Agent 不应该手写 calldata
- 系统负责构建未签名交易
- 每次写操作必须先模拟
- Moss 不签名、不广播，最终签名权仍在用户钱包
- 当前是 Alpha，模拟不是执行结果保证

这说明 Maintainer 很重视风险边界。README 不只讲功能，也讲“不能保证什么”。

### Docs

Moss 的 `docs/` 目录包含：

```text
docs/
  README.md
  getting-started.md
  getting-started.zh-CN.md
  mcp-tools.md
  protocol-onboarding.md
  agent-skill.md
  adr/
```

我看到的组织方式：

- `getting-started`：给新用户跑通最小流程
- `mcp-tools`：解释 MCP 工具接口
- `protocol-onboarding`：给贡献者写协议 adapter
- `agent-skill`：给 AI Agent 定义行为规则
- `adr/`：记录架构决策和取舍

这比普通 Demo 项目更成熟，因为它同时服务三类人：使用者、Agent、贡献者。

### 项目结构

Moss 根目录结构：

```text
.github/
docs/
examples/
packages/
README.md
README.zh-CN.md
CONTRIBUTING.md
SECURITY.md
CODE_OF_CONDUCT.md
TODO.md
package.json
pnpm-workspace.yaml
tsconfig.base.json
biome.json
```

我的理解：

- `packages/` 是核心代码，说明这是 monorepo
- `examples/` 用来展示真实使用方式
- `docs/` 解释概念、工具和贡献流程
- `.github/` 承载 issue / PR / CI 工作流
- `SECURITY.md` 单独说明安全边界
- `CONTRIBUTING.md` 降低外部贡献门槛

### Issues / Pull Requests / Discussions

Moss 当前 GitHub 导航中有 Issues 和 Pull Requests，但没有 Discussions 入口。GitHub API 显示 `has_discussions = false`。

Open items 中我看到很多是 PR，说明项目维护节奏偏“功能推进 + 文档补齐”：

- `#35 feat(example): add WMON wrap & transfer example and fix Windows CRLF ...`
- `#34 feat: add Chainlink oracle adapter`
- `#33 feat(protocols): Adds a complete NFT mint protocol`
- `#32 feat(protocols): add FastLane shMONAD liquid staking adapter`
- `#31 feat: implement Capability and Receipt framework`
- `#29 feat(scripts): add pnpm fetch-abi for ADR 0007 'explorer' tier`
- `#28 Tooling: Fetch verified ABIs through the Monadscan API`
- `#26 docs: add beginner troubleshooting FAQ`

这说明 Maintainer 主要通过 Issues / PR 管理工作，没有使用 Discussions 做社区讨论。对早期项目来说，这种方式更集中，适合快速迭代。

## 对比项目：Solidity

Solidity 是大型语言项目，目录非常工程化：

```text
.github/
docs/
libsolidity/
libsolc/
libyul/
test/
scripts/
tools/
CMakeLists.txt
CONTRIBUTING.md
CODING_STYLE.md
ReviewChecklist.md
ReleaseChecklist.md
SECURITY.md
```

观察：

- 这是编译器级别项目，不是普通应用
- 有清晰的代码风格、Review Checklist、Release Checklist
- Issues 和 PR 数量很多，维护方式更接近大型基础设施项目
- GitHub 有 Wiki，但没有 Discussions 入口

我学到：大型项目靠流程维护质量。贡献者不能只看代码，还要先看 `CONTRIBUTING`、`CODING_STYLE` 和 review / release checklist。

## 对比项目：Hardhat

Hardhat 是 Web3 开发工具项目，目录偏 TypeScript monorepo：

```text
.github/
docs/
packages/
e2e/
end-to-end/
scripts/
CONTRIBUTING.md
AGENTS.md
CLAUDE.md
package.json
pnpm-workspace.yaml
```

README 强调它是 Ethereum 开发环境，用于编译、部署、测试和调试智能合约。它提供 `npx hardhat --init` 作为新用户入口。

观察：

- 有 Discussions，适合社区提问和交流
- Issues / PR 数量多，说明维护规模大
- `packages/` + `pnpm-workspace` 说明它也是 monorepo
- `e2e` 和 `end-to-end` 说明它很重视真实场景测试

我学到：成熟工具项目需要把“用户入口”和“贡献入口”分开。用户看 README 和 Docs，贡献者看 CONTRIBUTING、packages、tests 和 CI。

## 我感兴趣的问题 / 功能

我最感兴趣的是 Moss 的：

```text
#28 Tooling: Fetch verified ABIs through the Monadscan API
```

原因：

- ABI 是 Agent 构建链上操作的重要基础
- 如果 ABI 来源不可靠，Agent 可能构造错误调用
- 自动从 Monadscan 获取 verified ABI，可以降低协议接入成本
- 这和我的 Dev Builder 方向有关：让 AI-assisted 开发更快、更安全

如果要参与，我会先做小范围贡献：

1. 阅读 `docs/protocol-onboarding.md`
2. 阅读 ADR 0007 相关设计
3. 找到当前 scripts / tooling 目录
4. 写一个只读脚本，输入合约地址，输出 verified ABI
5. 补 README 或 troubleshooting 文档

## Maintainer 如何组织项目

这次阅读后，我理解 Maintainer 的核心工作不是“写代码最多”，而是建立秩序：

- README：告诉新人项目是什么、怎么开始、风险是什么
- Docs：把使用者、贡献者、Agent 的路径分开
- Issues：记录问题、需求和任务
- PR：承载具体实现和 review
- CONTRIBUTING：定义贡献流程
- SECURITY：定义安全边界
- ADR：记录架构选择和取舍
- Tests / CI：防止贡献破坏已有功能

## 我的发现

- README 不是宣传页，而是项目的入口协议
- Docs 是维护者降低重复解释成本的工具
- Issues 不只是 bug，也可以是功能规划和贡献入口
- PR 标题能反映项目当前重点
- `SECURITY.md` 对 Web3 项目非常重要
- 早期项目可以没有 Discussions，但必须有清楚的 Issues / PR 流程
- 大项目更依赖 checklist、CI、风格规范和 review 纪律

## 对我 Dev Builder 的启发

我自己的 Monad Demo 后续也应该补齐：

- 清楚的 README
- `docs/` 或至少一份开发记录
- `CONTRIBUTING.md` 的最小版本
- `SECURITY.md`，说明私钥、签名、测试网风险
- Issues：用来拆任务，而不是只靠脑内计划
- PR：即使是个人项目，也可以用 PR 记录功能演进

## 参考资料

- Moss: https://github.com/nishuzumi/moss
- Moss Getting Started: https://github.com/nishuzumi/moss/blob/main/docs/getting-started.md
- Moss MCP Tools: https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md
- Moss Protocol Onboarding: https://github.com/nishuzumi/moss/blob/main/docs/protocol-onboarding.md
- Moss Agent Skill Guide: https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md
- Solidity: https://github.com/argotorg/solidity
- Hardhat: https://github.com/NomicFoundation/hardhat

