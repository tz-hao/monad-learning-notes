# Mini Demo 0: CheckIn 打卡合约

## 1. 我做了什么

我完成了一个最小 Solidity 合约 Demo：`CheckIn` 打卡合约。

这个 Demo 的目标不是做完整产品，而是完成 Monad / EVM 入门阶段的最小闭环：

- 写一个可以部署的 Solidity 合约
- 理解合约状态如何记录在链上
- 理解用户如何通过钱包地址调用合约
- 整理部署和交互说明
- 为 Week 2 的 Tech 方向继续深入做准备

合约功能：

- 每个钱包地址可以调用 `checkIn()` 打卡
- 每个地址至少间隔 `1 days` 才能再次打卡
- 合约记录每个地址最后一次打卡时间
- 合约记录每个地址累计打卡次数
- 每次成功打卡触发 `CheckedIn` 事件

核心文件：

- `CheckIn.sol`：最小打卡合约源码
- `README.md`：合约说明、部署方式、交互方式
- `week1-review.md`：Week 1 学习与实践复盘
- `MiniDemo0.md`：本次 Mini Demo 0 汇总

## 2. Demo 合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CheckIn {
    mapping(address => uint256) public lastCheckInAt;
    mapping(address => uint256) public checkInCount;

    event CheckedIn(address indexed user, uint256 time, uint256 count);

    function checkIn() external {
        require(
            block.timestamp >= lastCheckInAt[msg.sender] + 1 days,
            "Already checked in today"
        );

        lastCheckInAt[msg.sender] = block.timestamp;
        checkInCount[msg.sender] += 1;

        emit CheckedIn(msg.sender, block.timestamp, checkInCount[msg.sender]);
    }
}
```

## 3. 哪部分是真实链上操作

当前已经完成：

- 合约设计
- Solidity 源码整理
- 合约结构解释
- 部署方式梳理
- 交互方式梳理
- Week 1 学习复盘

当前待补充真实链上证据：

| 类型 | 状态 |
| --- | --- |
| 钱包地址 | `0xb22a98624799ec7fb1180274b8e51789bb299e4a` |
| 网络 | Monad 测试网，Chain ID `10143` |
| 合约地址 | `0x7d465988fbe510c7b1890e822be4a66078c09b80` |
| 部署交易 Hash | `TODO: 填写部署交易哈希` |
| `checkIn()` 交易 Hash | `0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814` |
| 区块浏览器链接 | `https://testnet.monadvision.com/tx/0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814` |
| 截图 | `monad-checkin-tx.png` |

已通过 Monad 测试网 JSON-RPC 查询到一笔真实 `checkIn()` 交互交易。该交易不是部署交易，因为回执中的 `contractAddress` 为 `null`，并且交易 `to` 字段指向已存在合约。

链上交互详情：

| 字段 | 值 |
| --- | --- |
| 交易状态 | 成功，`status = 0x1` |
| 交易类型 | EIP-1559，`type = 0x2` |
| 区块号 | `42783408` |
| 区块 Hash | `0x0e6f88c69cf91fce6945445d1482c39375d292af30e7f93cb48c958bd365be1a` |
| 区块时间 | `2026-07-06 14:18:26 UTC` / MonadVision 显示 `Jul-06-2026 22:18:26 PM` |
| From | `0xb22a98624799ec7fb1180274b8e51789bb299e4a` |
| To / 合约地址 | `0x7d465988fbe510c7b1890e822be4a66078c09b80` |
| Value | `0` |
| Input | `0x183ff085`，对应 `checkIn()` 函数选择器 |
| Gas Used | `81079` |
| Gas Price | `104.804592327 Gwei` |
| Transaction Fee | `0.008497451541280833 MON` |
| Burnt Fee | `0.0081079 MON` |
| Txn Savings | `0.002837765 MON` |
| Nonce | `3` |
| Position in Block | `2` |
| 事件合约地址 | `0x7d465988fbe510c7b1890e822be4a66078c09b80` |
| 事件用户地址 | `0xb22a98624799ec7fb1180274b8e51789bb299e4a` |
| 事件 time | `1783347506` |
| 事件 count | `1` |

我不会把没有实际发生的部署写成已完成记录。当前部署交易 Hash 仍需要继续补齐。

## 4. 哪部分由 AI 辅助完成

AI 辅助完成了：

- 生成最小 Solidity 打卡合约
- 解释合约结构和关键语法
- 整理 README 文档
- 整理 Week 1 学习复盘
- 把实践内容归纳成 Mini Demo 0 提交格式

使用过的 Prompt：

```text
生成一个最小 Solidity 合约，打卡合约
```

```text
解释合约结构
```

```text
整理一版 README，说明这个合约做什么、如何部署、如何交互
```

```text
整理 Week 1 的学习和实践记录，为 Week 2 的 Tech / Ops / Research 分轨做准备
```

## 5. 我做了哪些人工判断和修改

人工判断部分：

- 选择打卡合约作为 Week 1 Mini Demo 0，因为它足够小，但能覆盖链上状态、交易、事件和用户地址
- 确认当前合约按 `24 小时间隔` 限制，而不是按自然日零点重置
- 确认 README 中只写部署方式，不写任何私钥
- 确认给定交易是一次合约交互交易，不是部署交易
- 确认 Week 2 主方向选择 Tech，而不是 Ops 或 Research

人工需要继续补充的部分：

- 补充部署交易 Hash
- 补充部署截图和事件详情截图
- 根据 Week 2 要求决定使用 Remix、Foundry 还是 Hardhat

## 6. 遇到的问题和修复过程

问题 1：合约 Demo 很小，但需要说明清楚“链上状态”的意义。

处理方式：

- 在 README 中单独解释 `lastCheckInAt`、`checkInCount`、`CheckedIn` 事件
- 把交互分成打卡、查询时间、查询次数三类

问题 2：没有真实链上交易记录时，容易把文档写得像已经部署完成。

处理方式：

- 在 Mini Demo 0 中明确区分“已完成代码和文档”和“待补真实链上证据”
- 已补充真实 `checkIn()` 交互交易和 MonadVision 交易截图；部署交易 Hash 仍保留 `TODO`

问题 3：“每天打卡一次”的语义可能不精确。

处理方式：

- 当前版本采用 `1 days`，也就是距离上次打卡至少 24 小时
- Week 2 可以进一步研究自然日打卡、连续打卡、积分和排行榜

## 7. Week 2 主方向确认

我确认 Week 2 主方向选择：

```text
Tech
```

选择 Tech 的原因：

- Week 1 的核心产出是 Solidity 合约和链上交互流程
- 我目前最需要提升的是合约开发、部署、测试和调试能力
- 打卡合约可以自然扩展成更完整的 DApp
- Tech 方向能让我继续完成从“写合约”到“部署、测试、前端交互”的闭环

辅助方向：

```text
Research
```

Research 作为辅助，用来记录 Monad 生态、开发工具、测试网交互路径和产品启发。

暂不作为主方向：

```text
Ops
```

Ops 暂时用于辅助输出学习记录和内容整理，不作为 Week 2 主线。

## 8. Week 2 计划

Week 2 我希望沿着 Tech 方向继续推进：

- 搭建 Foundry 或 Hardhat 项目
- 把 `CheckIn.sol` 放入标准项目结构
- 编写最小测试
- 部署到 Monad 测试网
- 调用 `checkIn()`
- 保存合约地址、交易 Hash 和截图
- 尝试加入连续打卡或积分逻辑

Week 2 最小目标：

```text
完成一个有真实部署记录、有测试、有交互记录的 CheckIn Demo 1
```

## 9. 提交摘要

Mini Demo 0 提交内容：

| 文件 | 说明 |
| --- | --- |
| `CheckIn.sol` | 最小 Solidity 打卡合约 |
| `README.md` | 合约说明、部署、交互 |
| `week1-review.md` | Week 1 学习与实践复盘 |
| `MiniDemo0.md` | Mini Demo 0 汇总与 Week 2 方向确认 |

当前结论：

```text
Week 1 核心产出：CheckIn 最小打卡合约 Demo
Week 2 主方向：Tech
Week 2 辅助方向：Research
下一步重点：真实部署、测试、交互记录
```
