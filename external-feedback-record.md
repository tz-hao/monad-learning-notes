# 外部同学体验与反馈记录

## 分享方式

计划采用轻量分享方式：

- 在 Monad Builder Camp / AI x Web3 学习群发布项目介绍
- 私聊邀请 3 名团队之外的同学阅读 Demo README
- 让测试者根据 README 判断一笔 AI 候选交易为什么被允许或拒绝

当前状态：

```text
已准备分享材料，真实外部反馈待收集后补充。
```

说明：本文件不伪造同学反馈或截图。收到真实反馈后，需要把反馈内容、截图或会议记录补充到下方表格。

## 分享了什么

分享项目：

```text
IntentGuard Agent Wallet
```

一句话介绍：

```text
这是一个 AI Agent 链上执行守卫：AI 可以建议交易，但合约会先检查它有没有越权。
```

分享给同学看的核心内容：

- 项目想帮助谁：想尝试 AI x Web3，但担心 AI 越权操作钱包的新手
- 项目解决什么问题：AI 可以生成候选交易，但不能默认拥有无限链上权限
- Mini Demo 展示什么：固定用户意图 → mock policy JSON → `IntentGuard` 判断交易允许 / 拒绝
- 当前真实链上背景：Week 1 已完成 `CheckIn.checkIn()` Monad 测试网交互
- 当前 Mock 部分：AI 意图解析、前端页面、真实自动执行
- 当前 Known Issues：Foundry 未跑通，`IntentGuard` 未部署

Demo / 项目材料：

- GitHub repo: https://github.com/tz-hao/monad-learning-notes
- Mini README: `intentguard-demo-readme.md`
- Problem Card: `problem-mini-demo-card.md`
- Dev 可行性确认: `dev-feasibility-check.md`

## 可直接发布的邀请文案

```text
大家好，我这周在做一个 Monad / AI x Web3 的 Mini Demo，叫 IntentGuard Agent Wallet。

一句话：AI 可以帮用户生成候选交易，但不能直接控制钱包；交易必须先经过 IntentGuard 检查 target、selector、value 是否越权，再由用户最终确认。

现在还不是完整产品，本周只验证一个最小功能：
固定用户意图 → mock AI policy JSON → 合约判断这笔候选交易允许还是拒绝。

想邀请 3 位同学帮忙看一下 README，并回答：
1. 你能不能看懂这个项目想解决什么问题？
2. 你是否理解 target / selector / value 这三个权限字段？
3. 你觉得哪里最困惑，README 应该怎么改？

GitHub: https://github.com/tz-hao/monad-learning-notes
```

## 测试任务

请测试者完成一个具体任务：

```text
阅读 Demo 说明后，判断下面这笔 AI 候选交易为什么应该被允许或拒绝。
```

测试用例：

| 候选交易 | 期望判断 | 原因 |
| --- | --- | --- |
| 调用白名单 `CheckIn.checkIn()`，value = 0 | 允许 | target、selector、value 都符合策略 |
| 调用非白名单合约 | 拒绝 | target 不符合策略 |
| 调用白名单合约但 selector 不是 `checkIn()` | 拒绝 | selector 不符合策略 |
| 调用 `CheckIn.checkIn()` 但携带 MON | 拒绝 | value 超过 `maxValue = 0` |

## 收到的主要反馈

真实反馈待补充。

| 测试者 | 是否看懂一句话介绍 | 是否理解权限字段 | 主要反馈 | 团队准备怎么改 |
| --- | --- | --- | --- | --- |
| 同学 A | 待补充 | 待补充 | 待补充 | 待补充 |
| 同学 B | 待补充 | 待补充 | 待补充 | 待补充 |
| 同学 C | 待补充 | 待补充 | 待补充 | 待补充 |

需要至少收集 3 条真实反馈后再提交为最终版本。

## 团队准备改进什么

当前基于自查，先准备改进：

- 把 `target / selector / value` 的解释写得更像新人语言
- 在 README 中加入“允许 / 拒绝”示例表格
- 明确 AI 不签名、不广播、不持有私钥
- 把 mock 部分和真实开发部分分开，避免测试者误解项目已经完整跑通
- 如果测试者看不懂 selector，补充 `checkIn()` → `0x183ff085` 的解释

收到真实反馈后，再按优先级更新：

1. 先改影响理解的一句话介绍
2. 再改 Demo 流程说明
3. 最后补充技术细节

## 分享截图或会议记录

当前状态：

```text
待补充。
```

可补充材料：

- 微信群分享截图
- 私聊邀请截图
- 线上介绍会议纪要
- 测试者反馈截图
- Demo 讲解录屏链接

截图或会议记录补充要求：

- 至少证明项目已经分享给团队外部同学
- 至少包含 3 名测试者或 3 条反馈
- 不需要公开个人隐私，可以打码昵称和头像

## 记录人

Dev Builder 先整理分享材料和反馈记录模板；Ops / Product Builder 负责邀请和汇总真实反馈；Research Builder 负责判断反馈是否说明问题真实存在。
