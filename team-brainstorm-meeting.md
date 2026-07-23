# 团队脑暴会议记录：Week Mini Demo 方向选择

## 会议时间

2026-07-23，30–45 分钟

## 参与成员

- Dev Builder：负责合约、测试、链上交互和技术可行性判断
- Ops / Product Builder：负责用户场景、Demo 叙事、测试用户反馈
- Research Builder：负责问题验证、相似产品和安全边界资料

## 每位成员提出的想法

### Dev Builder 想法

```text
IntentGuard Agent Wallet
```

面向想尝试 AI Agent 链上操作、但担心资产安全的 Monad 新人。AI 只生成候选交易或策略，`IntentGuard` 合约检查 target、selector、value 是否符合用户授权。

### Ops / Product Builder 想法

```text
Monad 新人交易解释助手
```

面向第一次使用 Monad 测试网的新人。用户贴入交易 hash 后，页面用简单语言解释这笔交易做了什么、是否成功、调用了哪个合约、花了多少 gas。

### Research Builder 想法

```text
AI Agent 链上权限风险笔记
```

面向 AI x Web3 学习者。整理 AI Agent 参与链上操作时的风险：私钥、签名、calldata、simulation、warning、人类确认，并对比 Moss / session key / wallet guard 等思路。

### 备选想法

```text
CheckIn 连续打卡积分
```

基于已有 `CheckIn` 合约增加连续打卡、积分或排行榜，用来展示 Monad 测试网低成本交互。

## 整理后的想法

| 方向 | 目标用户 | 核心问题 | 可能解决方式 |
| --- | --- | --- | --- |
| IntentGuard Agent Wallet | AI x Web3 新人、Dev Builder 团队 | AI 能生成交易，但不能拥有无限钱包权限 | 用合约检查 target / selector / value |
| 交易解释助手 | Monad 测试网新人 | 看不懂交易 hash 和钱包弹窗 | 输入 hash，输出交易解释 |
| 权限风险笔记 | Research / 安全学习者 | 不理解 AI Agent 上链边界 | 输出风险清单和案例 |
| CheckIn 积分 | 初学 Solidity 的新人 | 需要低门槛链上 Demo | 扩展打卡合约功能 |

## 讨论筛选

### 问题是否真实？

`IntentGuard Agent Wallet` 的问题更真实：AI 可以生成代码、calldata 和交易建议，但新人容易误以为 AI 可以直接控制钱包。这个问题直接关系到资产安全和签名权限。

已有证据：

- Week 1 已完成真实 `CheckIn.checkIn()` 链上交互
- Moss 文档强调 Agent 不签名、不广播、必须模拟和人工确认
- 当前 AI x Web3 场景普遍需要解释“AI 辅助”和“链上执行”的边界

### 团队是否有能力完成？

可以完成最小版本。

Dev Builder 能负责：

- `IntentGuard.sol`
- Foundry 测试
- mock policy JSON
- README 和 Known Issues

Ops / Product Builder 可以负责：

- 用户场景描述
- Demo 叙事
- 找 3 位新人测试理解成本

Research Builder 可以负责：

- 整理 Moss / session key / wallet guard 资料
- 补充风险边界和替代方案

### 能否在本周做出可展示版本？

可以，但必须缩小范围。

本周只做：

```text
固定用户意图 → mock policy JSON → IntentGuard 判断候选交易允许 / 拒绝
```

不做完整 AI、不做完整钱包、不做自动交易。

## 最终选择的方向

最终选择：

```text
IntentGuard Agent Wallet：AI Agent 链上执行守卫
```

本周 Mini Demo 方向：

```text
让 AI 生成一笔候选 CheckIn 交易，由 IntentGuard 判断是否符合用户设置的权限边界。
```

## 选择它的原因

选择原因：

- 问题足够具体：AI Agent 上链时，权限边界必须明确
- 和已有 Week 1 成果连续：可以复用 `CheckIn` 合约和真实 Monad 测试网交易 hash
- 技术范围可控：只检查 target、selector、value 三个字段
- 适合 Dev Builder 展示 Proof of Work：合约、测试、README、交易证据都可以被验证
- 比单纯交易解释助手更接近 AI x Web3 的核心问题

## 暂时放弃的想法

暂时不做：

- Monad 交易解释助手：更适合作为后续前端功能，不是本周核心
- AI Agent 权限风险长报告：可作为 README 背景，但不作为 Mini Demo
- CheckIn 连续打卡积分：太偏普通合约练习，和 AI x Web3 主线关联不够强
- 自动交易 Agent：风险和范围过大，本周不做
- 完整钱包 / session key：实现复杂度高，先用 mock 和策略合约验证核心逻辑

## 下一步行动与负责人

| 行动 | 负责人 | 本周验收 |
| --- | --- | --- |
| 创建 `IntentGuard.sol` | Dev Builder | 合约包含 `setPolicy` 和 `validateTransaction` |
| 写最小 Foundry 测试 | Dev Builder | 允许 1 个合法调用，拒绝 3 个越权调用 |
| 整理 mock policy JSON | Dev Builder | README 中能看懂 AI 输出了什么 |
| 补充用户场景 | Ops / Product Builder | 一句话说明新人为什么需要它 |
| 补充风险边界资料 | Research Builder | 说明 AI 不签名、不广播、不持有私钥 |
| 整理 Demo README | 全员协作 | 外部成员能看懂项目想做什么、做到哪一步 |

## 会议结论

本周不追求最酷的 AI x Web3 产品，而是先验证一个最小但关键的问题：

```text
当 AI 参与链上操作时，谁来限制它能做什么？
```

团队选择用 `IntentGuard` 做最小回答：

```text
AI 生成候选操作，合约检查权限边界，用户保留最终确认权。
```
