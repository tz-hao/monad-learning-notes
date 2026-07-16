# Monad 学习记录

这是我的 Monad / Web3 Week 1 学习记录。当前阶段以 Tech 方向为主，目标是从最小 Solidity 合约开始，完成“写合约、理解链上状态、真实交互、记录证据”的学习闭环。

## Week 1 核心产出

本周完成了一个最小打卡合约 Demo：`CheckIn`。

合约功能：

- 每个钱包地址可以调用 `checkIn()` 打卡
- 每个地址至少间隔 `1 days` 才能再次打卡
- 合约记录最后打卡时间
- 合约记录累计打卡次数
- 成功打卡后触发 `CheckedIn` 事件

## 真实链上交互

已完成一笔 Monad 测试网合约交互：

| 字段 | 内容 |
| --- | --- |
| 交易 Hash | `0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814` |
| 状态 | Success |
| 方法 | `CheckIn` / `checkIn()` |
| 区块 | `42783408` |
| From | `0xb22a98624799ec7fb1180274b8e51789bb299e4a` |
| Contract | `0x7d465988fbe510c7b1890e822be4a66078c09b80` |
| Gas Used | `81079` |
| Transaction Fee | `0.008497451541280833 MON` |

交易截图见：

- `outputs/monad-checkin-tx.png`

## AI 辅助内容

AI 辅助完成了：

- 生成最小 Solidity 打卡合约
- 解释合约结构
- 整理 README
- 整理 Week 1 复盘
- 汇总 Mini Demo 0
- 通过 Monad 测试网 RPC 查询交易回执

人工判断部分：

- 确认合约规则采用 24 小时间隔，而不是自然日零点重置
- 确认给定交易是合约交互交易，不是部署交易
- 确认不伪造缺失的部署交易 Hash
- 确认 Week 2 主方向选择 Tech

## Week 2 方向

Week 2 主方向：

```text
Tech
```

方向说明：

- [Week 2 主方向选择：Dev](./week2-direction.md)
- [Week 2 学习记录](./week2-learning-log.md)
- [AI 协作记录](./ai-collaboration-record.md)
- [Week 3 团队角色说明](./week3-role.md)
- [开源项目阅读记录](./open-source-reading.md)
- [提案阅读记录：EIP-7702（Set Code for EOAs）](./eip-7702-reading.md)
- [最小 Web3 / AI 原型定义](./prototype-definition.md)
- [核心文档理解与最小技术骨架](./doc-ai-skeleton.md)
- [IntentGuard Demo 最小 README](./intentguard-demo-readme.md)
- [Dev Summary：最终汇总](./dev-summary.md)

后续计划：

- 搭建 Foundry 或 Hardhat 项目
- 给 `CheckIn` 合约补测试
- 补齐部署交易 Hash
- 继续在 Monad 测试网上做真实交互
- 尝试增加连续打卡、积分或排行榜逻辑

## 文件说明

| 文件 | 说明 |
| --- | --- |
| `outputs/CheckIn.sol` | 最小 Solidity 打卡合约 |
| `outputs/README.md` | 合约说明、部署、交互 |
| `outputs/MiniDemo0.md` | Mini Demo 0 汇总 |
| `outputs/week1-review.md` | Week 1 学习复盘 |
| `outputs/monad-checkin-tx.png` | MonadVision 交易截图 |

