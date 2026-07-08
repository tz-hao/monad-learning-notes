# CheckIn 打卡合约

这是一个最小 Solidity 打卡合约示例，适合作为 Monad / EVM 合约入门练习。

合约允许每个钱包地址每天打卡一次，并记录：

- 用户最后一次打卡时间
- 用户累计打卡次数
- 每次成功打卡的链上事件

## 合约代码

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

## 合约做什么

`CheckIn` 合约提供一个 `checkIn()` 函数，用户调用后完成一次链上打卡。

核心规则：

- 每个地址独立计算打卡状态
- 同一个地址两次打卡必须间隔至少 `1 days`
- 打卡成功后，`checkInCount` 增加 1
- 打卡成功后，`lastCheckInAt` 更新为当前区块时间
- 打卡成功后，触发 `CheckedIn` 事件

主要状态：

| 名称 | 类型 | 说明 |
| --- | --- | --- |
| `lastCheckInAt` | `mapping(address => uint256)` | 地址最后一次打卡时间戳 |
| `checkInCount` | `mapping(address => uint256)` | 地址累计打卡次数 |

主要事件：

| 事件 | 说明 |
| --- | --- |
| `CheckedIn(address indexed user, uint256 time, uint256 count)` | 用户成功打卡时触发 |

## 如何部署

### 方法一：Remix 部署

1. 打开 [Remix IDE](https://remix.ethereum.org/)
2. 新建文件 `CheckIn.sol`
3. 粘贴上面的合约代码
4. 在 Solidity Compiler 中选择 `0.8.20` 或更高的 `0.8.x` 版本
5. 点击 `Compile CheckIn.sol`
6. 在 Deploy & Run Transactions 中选择部署环境
7. 点击 `Deploy`

如果要部署到 Monad 测试网，需要先在钱包中添加 Monad 测试网，并在 Remix 中选择 `Injected Provider`。

### 方法二：Foundry 部署

如果你使用 Foundry，可以把合约放到：

```text
src/CheckIn.sol
```

然后编译：

```bash
forge build
```

部署示例：

```bash
forge create src/CheckIn.sol:CheckIn \
  --rpc-url <RPC_URL> \
  --private-key <PRIVATE_KEY>
```

参数说明：

- `<RPC_URL>`：目标网络 RPC，例如 Monad 测试网 RPC
- `<PRIVATE_KEY>`：部署钱包私钥，注意不要提交到 Git 仓库

### 方法三：Hardhat 部署

如果你使用 Hardhat，可以把合约放到：

```text
contracts/CheckIn.sol
```

编译：

```bash
npx hardhat compile
```

部署脚本示例：

```javascript
const hre = require("hardhat");

async function main() {
  const CheckIn = await hre.ethers.getContractFactory("CheckIn");
  const checkIn = await CheckIn.deploy();

  await checkIn.waitForDeployment();

  console.log("CheckIn deployed to:", await checkIn.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

运行部署：

```bash
npx hardhat run scripts/deploy.js --network <network>
```

## 如何交互

### 打卡

调用：

```solidity
checkIn()
```

成功后，合约会：

- 更新你的最后打卡时间
- 增加你的累计打卡次数
- 触发 `CheckedIn` 事件

如果当天已经打卡，再次调用会失败：

```text
Already checked in today
```

### 查询最后打卡时间

调用：

```solidity
lastCheckInAt(address user)
```

返回该地址最后一次打卡的 Unix 时间戳。

### 查询累计打卡次数

调用：

```solidity
checkInCount(address user)
```

返回该地址累计打卡次数。

### 前端交互示例

使用 ethers.js 调用：

```javascript
const contract = new ethers.Contract(contractAddress, abi, signer);

const tx = await contract.checkIn();
await tx.wait();
```

查询次数：

```javascript
const count = await contract.checkInCount(userAddress);
console.log(count.toString());
```

监听事件：

```javascript
contract.on("CheckedIn", (user, time, count) => {
  console.log("user:", user);
  console.log("time:", time.toString());
  console.log("count:", count.toString());
});
```

## 注意事项

- `block.timestamp` 由区块时间决定，不是用户本地时间
- 当前版本按 24 小时间隔限制，不是按自然日零点重置
- 私钥只能放在本地环境变量或安全密钥管理工具中，不能写入代码或 README 示例
- 这是学习合约，生产环境可以继续增加权限控制、暂停机制、前端签名校验或积分逻辑

