# Week 4 计划与个人协作复盘

## 团队提交

### 团队决定

```text
继续参加 Week 4 Hackathon，但继续缩小范围。
```

团队不切换新方向，继续推进 `IntentGuard Agent Wallet`。原因是这个方向已经完成了问题定义、研究简报、团队计划、测试准备材料，并且和 Dev Builder 的能力匹配。

Week 4 不做完整 AI 钱包，只做可展示的最小原型：

```text
AI 候选交易 → IntentGuard 权限检查 → 允许 / 拒绝结果展示
```

### Week 3 完成了什么

Week 3 已完成：

- 确定项目方向：`IntentGuard Agent Wallet`
- 明确目标用户：AI x Web3 新人、Monad Builder Camp 团队、想让 Agent 协助链上操作的开发者
- 完成 Problem & Mini Demo Card
- 完成 Dev Builder 核心功能可行性确认
- 完成团队脑暴会议记录
- 完成团队本周计划
- 完成团队决策与 AI 协作记录
- 完成用户测试准备包
- 完成项目研究简报
- 整理外部反馈记录模板
- 保留已有 Monad 测试网 `CheckIn.checkIn()` 真实交易证据

当前真实证据：

```text
0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814
```

### Week 4 准备完成什么

Week 4 目标：

```text
把文档型 Mini Demo 推进到最小可运行或半可运行 Demo。
```

优先级：

1. 创建 `src/IntentGuard.sol`
2. 修正 selector 读取方式，避免 `bytes4(data[:4])` 编译风险
3. 创建最小测试文件，覆盖允许 / 拒绝逻辑
4. 尝试跑通 Foundry 或切换到 Hardhat
5. 补充一份 Demo README，展示 4 个测试用例
6. 收集至少 3 条外部用户反馈
7. 如果测试跑通，再考虑部署到 Monad 测试网

Week 4 最小验收：

```text
即使没有完整前端，也要让别人看懂并验证：
IntentGuard 能允许白名单 CheckIn 调用，也能拒绝越权调用。
```

### 目前还需要什么帮助

团队需要的帮助：

- Dev：需要确认本地 Foundry / Hardhat 环境，解决 Solidity 测试运行问题
- Research：需要继续补充 Safe Guard、session key、EIP-7702 的安全边界资料
- Ops：需要邀请 3 名外部同学进行 README / Demo 理解测试
- 助教：希望帮助判断 Week 4 是否应该优先做本地测试，还是优先部署 Monad 测试网

## 个人提交：Dev Builder

### 我本周负责什么

我本周主要负责 Dev Builder 方向：

- 把项目想法从“AI + Web3 大方向”缩小为 `IntentGuard Agent Wallet`
- 定义最小核心功能：检查 `target / selector / value`
- 整理合约接口和 mock policy JSON
- 判断哪些部分真实开发，哪些部分先 Mock
- 维护 GitHub 学习记录和提交历史
- 协助团队把想法、计划、研究和测试材料整理成可提交文档

### 我的成果或贡献证据

贡献证据：

- `problem-mini-demo-card.md`
- `dev-feasibility-check.md`
- `team-brainstorm-meeting.md`
- `team-week-plan.md`
- `team-decision-ai-log.md`
- `user-test-intro-pack.md`
- `project-research-brief.md`
- `intentguard-demo-readme.md`
- `doc-ai-skeleton.md`

链上证据：

```text
Monad 测试网 CheckIn 交易：
0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814
```

GitHub 仓库：

```text
https://github.com/tz-hao/monad-learning-notes
```

### 我在团队协作中的收获

本周最大的收获是：项目不是越大越好，而是要先证明一个真实问题。

我之前容易从技术实现出发，直接想做 AI Wallet、自动交易或完整前端。但团队协作后，我更清楚地看到新人真正需要的是：

```text
先理解 AI 能做什么、不能做什么，再决定是否让它参与链上操作。
```

对 Dev Builder 来说，最重要的不是一开始写很多功能，而是把边界写清楚：

- AI 不签名
- AI 不广播
- AI 不持有私钥
- 合约检查权限
- 用户最终确认

这让我对 Monad / Web3 的理解从“完成一次链上交互”推进到“如何设计可验证的链上执行规则”。

### 我是否希望继续合作，以及原因

```text
我希望继续合作，并继续作为 Dev Builder 参与 Week 4。
```

原因：

- 项目方向已经明确，不需要重新选题
- 我能继续负责合约、测试和链上验证
- Ops / Research 的工作能帮助我避免只做技术 Demo，而忽略用户理解和问题真实性
- Week 4 如果能跑通 `IntentGuard` 测试，就能形成更强的 Proof of Work

## 其他成员个人复盘占位

### Ops / Product Builder

本周负责：

- 项目一句话介绍
- 测试邀请文案
- 用户测试任务设计
- 外部反馈收集准备

成果证据：

- `user-test-intro-pack.md`
- `external-feedback-record.md`

协作收获：

```text
需要把技术概念翻译成新人能判断的任务，而不是只写项目愿景。
```

是否继续：

```text
建议继续，Week 4 重点负责真实用户反馈和 Demo 叙事。
```

### Research Builder

本周负责：

- 问题证据整理
- 类似产品 / 替代方案对比
- 风险识别
- 给团队提出建议

成果证据：

- `project-research-brief.md`
- `team-decision-ai-log.md`

协作收获：

```text
需要区分资料支持的结论和团队自己的假设，避免把概念热度当成用户需求。
```

是否继续：

```text
建议继续，Week 4 重点负责安全边界资料和竞品补充。
```

## Week 4 暂时不做

- 不做完整 AI 钱包
- 不做自动签名
- 不做自动广播
- 不接真实 LLM API
- 不做复杂前端
- 不承诺审计级安全
- 不伪造用户反馈、测试结果或部署 hash

## 最终结论

团队决定继续 Week 4 Hackathon。

Week 4 的目标不是把 `IntentGuard Agent Wallet` 做成完整产品，而是把 Week 3 的文档、研究和测试准备推进为一个更可验证的 Mini Demo：

```text
最小合约 + 最小测试 + 用户能看懂的演示说明 + 真实反馈记录
```
