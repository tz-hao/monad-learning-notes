# Dev Summary：IntentGuard Agent Wallet

## 1. 我想做什么

我想做一个 Web3 / AI 原型：

```text
IntentGuard Agent Wallet
```

一句话介绍：

```text
AI 可以生成候选交易或策略，但真正能不能执行，要先经过链上 IntentGuard 策略合约检查。
```

这个项目想解决的问题是：AI Agent 可以帮助用户理解和准备链上操作，但不能无限制控制钱包。用户应该能用自然语言表达授权边界，例如“只允许 AI 调用某个合约，不能转出 MON”，系统再把这个意图转换成可验证的策略规则。

最小技术方向：

- AI 生成候选策略 / 候选交易
- `IntentGuard` 合约检查 target、selector、value
- 用户保留最终签名和确认权
- 所有链上证据用交易 hash、截图和 README 记录

## 2. 我实际做到了哪一步

当前状态：

```text
部分完成，尚未跑通完整代码
```

已经完成：

- 定义 Dev Plan：`IntentGuard Agent Wallet`
- 阅读 Moss 文档，理解 AI Agent 链上执行安全边界
- 生成 `IntentGuard` 合约代码骨架
- 设计 Foundry 最小测试计划
- 写出 mock AI policy JSON
- 整理 Demo README
- 记录 AI Collaboration Log
- 记录 Known Issues
- 保存已有 Monad 测试网交互证据

已有材料：

| 类型 | 文件 / 证据 |
| --- | --- |
| Dev Plan | `prototype-definition.md` |
| 最小 README | `intentguard-demo-readme.md` |
| 技术骨架 | `doc-ai-skeleton.md` |
| AI Collaboration Log | `ai-collaboration-record.md` |
| Known Issues | `intentguard-demo-readme.md` |
| Week 3 角色 | `week3-role.md` |
| 测试网交易 Hash | `0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814` |
| 交易截图 | `outputs/monad-checkin-tx.png` |

目前可以证明的进度：

- GitHub repo 有完整学习记录和原型说明
- 有真实 Monad 测试网交易 hash
- 有 MonadVision 截图
- 有 `IntentGuard` 合约骨架
- 有 mock 数据说明
- 有错误日志 / Known Issues

当前没有完成：

- `IntentGuard.sol` 还没有落到 `src/`
- `test/IntentGuard.t.sol` 还没有写
- 本地 `forge` 不可用，`forge test` 未跑通
- `IntentGuard` 尚未部署到 Monad 测试网
- AI 意图解析仍是 mock JSON，不是真实 LLM 调用

## 3. Week 3 我能继续承担什么开发角色

Week 3 我可以承担：

```text
Dev Builder / 合约开发者 & AI 集成工程师
```

我能继续负责：

- Solidity 合约设计和实现
- Foundry 项目搭建、测试和调试
- Monad 测试网部署与交易记录
- AI Agent 与链上执行边界设计
- README、Known Issues、错误修复记录整理
- 帮团队控制 Demo scope，避免需求膨胀

我需要的队友：

- Ops / 产品队友：负责 Demo 叙事、用户场景和展示材料
- Research / Frontend 队友：负责竞品调研、生态资料或前端界面

我的 Proof of Work 不是完整产品，而是一个清楚的开发推进记录：

```text
想法 → 文档理解 → 技术骨架 → mock 策略 → 证据记录 → Known Issues → Week 3 可继续实现
```

下一步最小开发动作：

1. 安装或切换到可用 Foundry 环境
2. 创建 `src/IntentGuard.sol`
3. 创建 `test/IntentGuard.t.sol`
4. 跑通 `forge test`
5. 再考虑 Monad 测试网部署

