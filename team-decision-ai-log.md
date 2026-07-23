# 团队决策与 AI 协作记录

## 团队做出的重要决定

1. 本周 Mini Demo 方向确定为 `IntentGuard Agent Wallet`。
2. 项目优先解决 AI Agent 链上执行的权限边界问题，而不是做完整 AI 钱包。
3. 本周核心功能只检查 `target / selector / value` 三个字段。
4. AI 只负责生成候选策略或候选交易，不负责签名、不广播、不持有私钥。
5. 使用 Week 1 已完成的 `CheckIn.checkIn()` 真实 Monad 测试网交易作为 Demo 场景背景。
6. 如果本地工具未跑通，允许先提交代码骨架、测试计划、Known Issues，但不能伪造测试结果或交易 hash。

## 团队成员

| 成员角色 | 本次补充内容 |
| --- | --- |
| Dev Builder | 确认本周只实现 `IntentGuard` 最小策略检查，不做完整钱包和自动交易。 |
| Ops / Product Builder | 确认项目介绍要让新人听懂：“AI 可以建议交易，但合约先检查有没有越权。” |
| Research Builder | 确认需要持续验证新人是否真的能理解 `target / selector / value` 三个权限字段。 |

## 为什么这样决定

这样决定是因为本周目标不是做一个功能很多的产品，而是做一个能被验证的 Mini Demo。

`IntentGuard Agent Wallet` 的核心问题足够具体：

```text
当 AI 参与链上操作时，谁来限制它能做什么？
```

团队选择先用合约规则回答这个问题：

```text
AI 生成候选操作，IntentGuard 检查权限边界，用户保留最终确认权。
```

这个方向和已有学习记录连续：

- 已有 `CheckIn` 合约和真实 Monad 测试网交互
- 已经整理过 Moss 文档中的 Agent 安全边界
- Dev Builder 可以在本周完成最小合约和测试计划
- Ops / Product Builder 可以围绕新人理解成本做测试
- Research Builder 可以继续补充相似方案和风险证据

## 删除或暂时不做的功能

暂时不做：

- 完整 AI Agent
- 完整钱包
- 真实 LLM API
- 自动签名
- 自动广播交易
- session key
- DEX / 借贷 / 多协议支持
- 复杂前端页面
- 主网部署
- 审计级安全权限系统

暂时放弃的方向：

- Monad 交易解释助手：后续可以作为展示层补充，但不是本周核心
- AI Agent 权限风险长报告：作为背景材料，不作为 Mini Demo
- CheckIn 连续打卡积分：偏普通合约练习，和 AI x Web3 主线不够强

## AI 帮助完成了什么

AI 帮助团队完成了：

- 整理 `IntentGuard Agent Wallet` 的项目定位
- 把“AI + Web3”大想法缩小成本周可完成的 Mini Demo
- 生成 Problem & Mini Demo Card
- 整理 Dev Builder 可完成性判断
- 设计团队脑暴会议记录
- 制定 Day 1 到 Day 5 的团队计划
- 生成 mock policy JSON
- 梳理 `IntentGuard` 合约接口：
  - `setPolicy`
  - `validateTransaction`
- 区分真实开发部分和 Mock 部分
- 整理 Known Issues，避免把未跑通内容写成已完成
- 更新 README 索引并同步到 GitHub

## 团队进行了哪些检查或修改

团队没有直接接受 AI 输出，而是做了这些人工判断和修改：

- 把“AI 自动执行钱包”改成“AI 候选操作 + 合约守卫 + 用户确认”
- 确认 Week 1 的交易是 `CheckIn.checkIn()` 合约交互，不是部署交易
- 决定不伪造 `IntentGuard` 部署 hash
- 把本周范围压缩到 `target / selector / value`
- 明确 mock 只用于 AI 输出和展示层，合约判断逻辑不能 mock
- 保留本地 `forge` 不可用的问题，不假装测试已经通过
- 把团队分工从“Research / Ops / Dev”改成可检查成果

## 当前遇到的问题

当前问题：

- 本地 `forge` 暂时不可用，无法直接跑 Foundry 测试
- `IntentGuard.sol` 还没有正式写入 `src/`
- `test/IntentGuard.t.sol` 还没有完成
- `bytes4(data[:4])` 需要真实编译验证，可能要改成 assembly 读取 calldata 前 4 字节
- 还没有真实用户测试反馈
- 还没有部署 `IntentGuard` 到 Monad 测试网

## 下一步准备做什么

下一步：

1. 解决 Foundry 环境问题，或切换到可用 Solidity 测试环境。
2. 创建 `src/IntentGuard.sol`。
3. 创建最小测试文件，覆盖 1 个允许用例和 3 个拒绝用例。
4. 让 1–3 名新人阅读 Demo README，记录他们是否理解 AI 权限边界。
5. 根据用户反馈修改项目介绍和 README。
6. 如果测试跑通，再考虑部署到 Monad 测试网并补充真实交易 hash。

## 当前记录人

本记录由 Dev Builder 负责整理，Ops / Product Builder 和 Research Builder 分别补充了用户介绍、测试对象和问题验证相关内容。
