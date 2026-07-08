# Week 1 学习与实践记录

## 1. 本周完成的链上实践

Week 1 我主要围绕 Monad / EVM 的基础开发流程做了一个最小闭环练习：从理解链上状态，到编写 Solidity 合约，再到整理部署和交互说明。

已完成内容：

- 理解钱包地址、交易、合约部署、合约调用之间的关系
- 设计并生成一个最小 Solidity 打卡合约 `CheckIn`
- 梳理合约的状态变量、事件和核心函数
- 整理合约 README，说明合约用途、部署方式和交互方式
- 初步理解 Remix、Foundry、Hardhat 三种部署路径的差异

本周合约实践：

```solidity
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

这个合约的目标是让每个地址每天只能打卡一次，并记录累计打卡次数。它覆盖了入门合约里最基础但很重要的几个点：`mapping`、`msg.sender`、`block.timestamp`、`require`、状态更新和事件。

## 2. 钱包和交易记录

目前需要补充真实链上证据：

| 类型 | 记录 |
| --- | --- |
| 钱包地址 | `0xb22a98624799ec7fb1180274b8e51789bb299e4a` |
| 网络 | Monad 测试网，Chain ID `10143` |
| 合约地址 | `0x7d465988fbe510c7b1890e822be4a66078c09b80` |
| 部署交易 Hash | `TODO: 填写部署交易哈希` |
| 打卡交易 Hash | `0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814` |
| 区块浏览器链接 | `https://testnet.monadvision.com/tx/0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814` |

已确认的打卡交易信息：

| 字段 | 值 |
| --- | --- |
| 状态 | 成功 |
| 区块号 | `42783408` |
| 区块时间 | `2026-07-06 14:18:26 UTC` / MonadVision 显示 `Jul-06-2026 22:18:26 PM` |
| From | `0xb22a98624799ec7fb1180274b8e51789bb299e4a` |
| To | `0x7d465988fbe510c7b1890e822be4a66078c09b80` |
| Input | `0x183ff085`，对应 `checkIn()` |
| Gas Used | `81079` |
| Gas Price | `104.804592327 Gwei` |
| Transaction Fee | `0.008497451541280833 MON` |
| Burnt Fee | `0.0081079 MON` |
| Txn Savings | `0.002837765 MON` |
| Nonce | `3` |
| Position in Block | `2` |
| 事件 count | `1` |
| 截图 | `monad-checkin-tx.png` |

下一步需要继续补齐：

- 部署交易 Hash
- 区块浏览器截图
- 事件日志截图

## 3. 合约或交互记录

我目前整理出的交互方式包括三类：

1. 直接调用 `checkIn()` 完成打卡
2. 调用 `lastCheckInAt(address)` 查询最后一次打卡时间
3. 调用 `checkInCount(address)` 查询累计打卡次数

预期交互结果：

- 第一次调用 `checkIn()` 应该成功
- 同一地址在 24 小时内再次调用应该失败
- 成功调用后，`checkInCount` 应该增加 1
- 成功调用后，合约应该触发 `CheckedIn` 事件

当前还缺少的真实交互记录：

- Remix 或脚本调用截图
- 成功交易 Hash
- 失败交易或 revert 信息
- 事件日志截图

## 4. 遇到的问题

Week 1 中暴露出的主要问题不是复杂代码问题，而是链上开发的基础概念还需要建立：

- 合约状态和普通后端数据库不一样，状态写入需要交易和 gas
- `msg.sender` 不是一个普通参数，而是由调用交易决定
- `block.timestamp` 是链上区块时间，不是用户本地时间
- “每天一次”有不同实现方式：按 24 小时间隔，或按自然日重置
- 部署工具有多种路径，Remix 适合入门，Foundry / Hardhat 更适合工程化
- README 中不能写入私钥，真实部署需要用环境变量或钱包签名

这些问题让我意识到，Web3 开发不只是写合约函数，还要理解交易、钱包、网络、浏览器、事件和安全边界。

## 5. AI 帮我解决了什么

AI 在 Week 1 中主要帮我完成了以下事情：

- 生成了一个最小可运行的 Solidity 打卡合约
- 解释了合约结构，包括状态变量、事件、函数和 `require` 校验
- 整理了 README，说明合约做什么、如何部署、如何交互
- 帮我把零散学习内容归纳成一个可复盘的链上实践路径
- 提醒我区分学习合约和生产合约，例如私钥安全、时间判断、部署证据等

使用过的 Prompt 类型：

```text
生成一个最小 Solidity 合约，打卡合约
```

```text
解释合约结构
```

```text
整理一版 README，说明这个合约做什么、如何部署、如何交互
```

AI 输出后，我需要人工检查的地方包括：

- 合约逻辑是否符合“每天一次”的真实需求
- README 是否适合自己的提交格式
- 部署方式是否匹配我实际使用的工具
- 是否有真实交易记录可以支撑实践过程

## 6. 必须由我人工判断的地方

AI 可以生成代码和文档，但以下内容必须由我自己判断：

- 是否真的完成了链上部署，而不是只停留在代码层面
- 钱包地址、交易 Hash、合约地址是否真实有效
- 使用 Monad 测试网时 RPC、浏览器、测试币来源是否正确
- 合约规则是否符合产品语义，例如“24 小时一次”还是“每天自然日一次”
- 是否要继续走技术实现，还是转向运营、研究、内容表达
- Week 2 选择哪个方向更符合自己的兴趣和能力

尤其是方向选择，AI 只能辅助分析，不能替我决定。因为 Tech、Ops、Research 对人的要求不同：Tech 更看重持续动手和调试能力，Ops 更看重组织和表达，Research 更看重信息检索、判断和结构化输出。

## 7. 对 Monad / Web3 的理解变化

Week 1 之前，我对 Web3 的理解更偏概念：钱包、链、交易、合约这些词是分散的。

完成这个打卡合约后，我的理解变得更具体：

- 钱包不只是登录工具，它也是交易签名者
- 合约不是普通脚本，部署后会成为链上的可调用对象
- 每一次状态变化都需要交易确认
- 事件是合约和链下系统沟通的重要方式
- 一个很小的功能，也需要考虑 gas、时间、失败回滚和用户交互
- Monad 对我来说不只是一个高性能链概念，而是一个可以实际部署和交互的 EVM 环境

这让我意识到，Web3 学习最重要的是从“看概念”转成“做闭环”：钱包、部署、调用、查询、记录证据。

## 8. Week 2 分轨判断

我目前更适合优先进入 Tech 方向。

原因：

- Week 1 的主要实践集中在 Solidity 合约、部署和交互
- 我对“一个链上功能如何从代码变成交易”更感兴趣
- 当前最需要补齐的是工程化能力，而不是纯内容传播或宏观研究
- 打卡合约虽然简单，但已经暴露出状态、事件、时间判断、部署工具等技术问题

Ops 和 Research 也有价值，但我当前更适合以 Tech 为主线，再补一点 Research：

- Tech：继续写合约、部署、交互、测试
- Research：记录 Monad 生态项目、开发工具、常见交互路径
- Ops：暂时作为辅助，用于整理学习笔记和分享实践过程

建议 Week 2 方向：

```text
主方向：Tech
辅助方向：Research
暂不主攻：Ops
```

## 9. Week 2 希望深入的方向

Week 2 我希望继续深入以下内容：

- 用 Foundry 或 Hardhat 搭建一个最小合约项目
- 给 `CheckIn` 合约补测试
- 把合约真实部署到 Monad 测试网
- 用脚本或前端调用 `checkIn()`
- 学会读取事件日志
- 学会在区块浏览器里核对交易、合约、事件
- 对比“24 小时间隔”和“自然日打卡”的不同实现方式

可选进阶：

- 增加连续打卡天数
- 增加积分机制
- 增加排行榜
- 增加前端页面
- 增加合约测试和部署脚本

## 10. 需要助教或同伴帮助的问题

我希望 Week 2 能得到帮助的问题：

- Monad 测试网 RPC、浏览器、测试币领取的标准入口是什么
- Remix、Foundry、Hardhat 在训练营里推荐优先使用哪一个
- 合约部署后，如何正确验证合约和查看事件
- 如果交易失败，应该从哪些地方排查问题
- `block.timestamp` 用来做每日打卡是否足够合适
- 一个入门合约项目最低需要哪些测试
- Week 2 Tech 方向的提交物应该包含哪些证据

## 11. 当前材料清单

已有材料：

- `outputs/README.md`：`CheckIn` 打卡合约说明文档
- 本文档：Week 1 学习与实践复盘

待补充材料：

- 部署交易 Hash
- Remix / Foundry / Hardhat 操作截图
- 事件日志截图
