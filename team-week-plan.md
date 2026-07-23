# 团队本周计划：IntentGuard Agent Wallet

## 团队目标

本周团队要完成一个可展示的 Mini Demo：

```text
IntentGuard Agent Wallet：AI 生成候选链上操作，IntentGuard 检查权限边界，用户保留最终确认权。
```

本周不追求完整产品，只完成一个能讲清楚、能检查、能展示的最小版本。

最终交付物：

- Problem & Mini Demo Card
- `IntentGuard` 最小技术方案
- mock policy JSON
- 可展示的 README / Demo 说明
- 至少一份用户测试记录
- Known Issues 和下一步计划

全部内容在 Day 5 前完成并提交。

## 成员分工

| 要完成的事情 | 负责人 | 具体成果 | 截止时间 | 协作对象 |
| --- | --- | --- | --- | --- |
| 了解用户与类似产品 | Research Builder | 记录 3 条用户问题证据，整理 1–2 个类似方案或替代方案 | Day 2 | Ops / Product Builder |
| 准备项目介绍和测试邀请 | Ops / Product Builder | 一句话项目介绍、3 名测试用户招募渠道、测试邀请文案 | Day 2 | Research Builder |
| 制作核心功能 | Dev Builder | `IntentGuard.sol` 方案、mock policy JSON、允许 / 拒绝逻辑说明 | Day 3 | Research Builder |
| 准备最小测试或演示流程 | Dev Builder | 1 个合法交易通过、3 个越权交易拒绝的测试计划或本地结果 | Day 4 | Ops / Product Builder |
| 邀请用户测试 | 全队 | 至少 1–3 条用户反馈记录：是否看懂项目、是否理解 AI 权限边界 | Day 4 | Ops / Product Builder 负责汇总 |
| 准备 Demo 展示 | 全队 | Demo README、项目介绍、Known Issues、Week 3 继续开发角色 | Day 5 | Dev Builder 负责最终整理 |

## Day 1：确认方向和范围

负责人：全队

具体成果：

- 确认 Mini Demo 方向为 `IntentGuard Agent Wallet`
- 确认目标用户是 AI x Web3 新人和 Monad Builder Camp 团队
- 确认本周只做 `target / selector / value` 三个权限检查
- 明确不做完整钱包、不做真实自动交易、不接真实 LLM API

检查标准：

```text
团队成员能用一句话说清楚项目帮助谁、解决什么问题。
```

## Day 2：用户与问题验证

### Research Builder

具体成果：

- 找到 3 条问题证据：
  - 新人看不懂交易 calldata / selector
  - AI 生成交易建议后仍需要人工核查
  - Agent 不应持有私钥或直接广播交易
- 整理 1–2 个类似方案或替代方案：
  - Moss 的 agent plan / simulate / human confirmation 思路
  - session key / wallet guard / Safe module 类权限控制方案
- 输出一个待验证问题：
  ```text
  新人是否能通过 target、selector、value 三个字段理解 AI 交易权限边界？
  ```

### Ops / Product Builder

具体成果：

- 写一句话项目介绍：
  ```text
  这是一个 AI Agent 链上执行守卫：AI 可以建议交易，但合约会先检查它有没有越权。
  ```
- 准备测试邀请文案
- 找到 3 名潜在测试者来源：
  - Monad Builder Camp 新人群
  - AI x Web3 学习群
  - 身边正在学习 Solidity / 钱包交互的同伴

## Day 3：核心功能方案

负责人：Dev Builder

具体成果：

- 确认 `IntentGuard` 最小合约接口：
  - `setPolicy(address allowedTarget, bytes4 allowedSelector, uint256 maxValue)`
  - `validateTransaction(address owner, address target, uint256 value, bytes calldata data)`
- 准备 mock policy JSON：
  ```json
  {
    "allowedTarget": "0x7d465988fbe510c7b1890e822be4a66078c09b80",
    "allowedSelector": "0x183ff085",
    "maxValue": "0"
  }
  ```
- 写清楚 4 个判断结果：
  - 白名单 `CheckIn.checkIn()`：允许
  - 非白名单合约：拒绝
  - 非白名单函数：拒绝
  - 携带 MON 转账：拒绝

协作方式：

- Dev Builder 遇到合约边界不清楚时找 Research Builder
- Dev Builder 需要 Demo 文案时找 Ops / Product Builder

## Day 4：测试与反馈

负责人：全队

具体成果：

- Dev Builder 准备测试计划或本地测试结果
- Ops / Product Builder 找 1–3 名测试者看 README / Demo 说明
- Research Builder 观察用户是否理解：
  - AI 不签名
  - AI 不广播
  - 用户保留最终确认
  - 合约负责权限检查

用户测试任务：

```text
请测试者阅读 Demo 说明，然后判断这笔 AI 候选交易为什么被允许或拒绝。
```

反馈记录至少包含：

- 测试者是否看懂项目一句话介绍
- 测试者是否理解 `target / selector / value`
- 测试者最困惑的地方
- README 需要修改的一点

## Day 5：整理提交

负责人：全队，Dev Builder 负责最终整合

具体成果：

- 更新 Demo README
- 汇总 Problem Card、Dev 可行性、团队计划、Known Issues
- 补充 mock 与真实开发部分说明
- 提交 GitHub repo 链接
- 明确 Week 3 继续分工：
  - Dev Builder：合约和测试
  - Ops / Product Builder：用户测试与 Demo 叙事
  - Research Builder：相似方案和安全边界验证

最终检查标准：

```text
外部成员打开 GitHub 后，能在 3 分钟内看懂：
1. 项目想帮助谁；
2. 本周实际做到哪一步；
3. 每位成员负责了什么具体成果。
```

## 遇到问题时找谁协作

| 问题类型 | 先找谁 | 处理方式 |
| --- | --- | --- |
| 合约逻辑或测试写不出来 | Dev Builder | 缩小测试范围，只保留最小允许 / 拒绝逻辑 |
| 用户场景说不清楚 | Ops / Product Builder | 改写一句话介绍和 Demo 叙事 |
| 不确定问题是否真实 | Research Builder | 补充用户证据或相似方案 |
| Demo 范围变大 | 全队 | 回到 Day 1 范围，只做 target / selector / value |
| 本地工具不可用 | Dev Builder | 记录 Known Issues，用代码骨架和测试计划替代 |

## 本周不做

- 不开发完整 AI Agent
- 不接真实 LLM API
- 不做自动签名和自动广播
- 不做完整钱包或 session key
- 不做复杂前端
- 不做主网部署
- 不伪造交易 hash、截图或测试结果
