# IntentGuard Agent Wallet — Mini README

## 项目一句话介绍

`IntentGuard Agent Wallet` 是一个 AI x Web3 安全执行原型：AI 可以生成候选交易或策略，但真正能不能执行，要先经过链上 `IntentGuard` 策略合约检查。

核心目标：

```text
让 AI Agent 有能力协助链上操作，但不能无限制控制钱包。
```

## 如何运行或如何查看

当前阶段还没有完整可运行项目，先查看以下材料：

- 原型定义：`prototype-definition.md`
- 文档理解与代码骨架：`doc-ai-skeleton.md`
- AI 协作记录：`ai-collaboration-record.md`
- 既有 Monad 测试网交易截图：`outputs/monad-checkin-tx.png`

计划中的运行方式：

```bash
forge test
```

当前本地检查结果：

```text
forge --version
```

结果：本地未识别 `forge` 命令，所以 Foundry 测试尚未跑通。

## 当前完成了什么

已完成：

- 定义了更有创新度的 Web3 / AI 原型：`IntentGuard Agent Wallet`
- 阅读 Moss `agent-skill.md`，理解 AI Agent 链上执行边界
- 整理了最小技术方案
- 生成了 `IntentGuard` 合约代码骨架
- 设计了最小测试计划：
  - 允许白名单 target + selector
  - 拒绝非白名单合约
  - 拒绝非白名单函数
  - 拒绝超过 `maxValue` 的交易
  - 没有策略时拒绝
- 明确 AI 只负责生成候选策略 / 候选交易，不负责签名和广播

代码骨架摘要：

```solidity
struct Policy {
    address allowedTarget;
    bytes4 allowedSelector;
    uint256 maxValue;
    bool enabled;
}

function validateTransaction(
    address owner,
    address target,
    uint256 value,
    bytes calldata data
) external view returns (bool);
```

## 哪些是 mock

当前 mock 的部分：

- AI 意图解析：先用固定 JSON 表示 AI 输出
- 前端 UI：暂时不做完整页面
- 多协议支持：暂时只围绕 `CheckIn` 场景
- session key：暂时不接真实 session key
- 交易模拟服务：先用 Foundry 测试计划代替

mock 示例：

```json
{
  "userIntent": "只允许 AI 调用 CheckIn 合约，禁止转出 MON",
  "policy": {
    "allowedTarget": "0x7d465988fbe510c7b1890e822be4a66078c09b80",
    "allowedSelector": "0x183ff085",
    "maxValue": "0"
  }
}
```

不能 mock 的部分：

- 合约策略判断逻辑
- 测试结果
- 交易 hash
- 截图
- 私钥、签名和钱包确认

## 截图 / 录屏 / hash

已有证据：

- Monad 测试网交易 Hash：
  ```text
  0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814
  ```

- MonadVision 链接：
  ```text
  https://testnet.monadvision.com/tx/0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814
  ```

- 交易截图：
  ```text
  outputs/monad-checkin-tx.png
  ```

说明：这笔交易来自 Week 1 的 `CheckIn` 交互，用作当前原型的真实链上背景证据。`IntentGuard` 本身尚未部署。

## Known Issues

当前已知问题：

- 本地未安装 / 未识别 `forge`，因此暂时无法运行 Foundry 测试
- `IntentGuard.sol` 还没有落到 `src/` 目录
- `test/IntentGuard.t.sol` 还没有编写
- `bytes4(data[:4])` 需要真实编译验证，可能需要改成 assembly 读取 calldata 前 4 字节
- 尚未部署 `IntentGuard` 到 Monad 测试网
- AI 意图解析目前是 mock JSON，不是真实 LLM 输出

下一步最小动作：

1. 安装或切换到可用 Foundry 环境
2. 创建 `src/IntentGuard.sol`
3. 创建 `test/IntentGuard.t.sol`
4. 跑通 `forge test`
5. 再决定是否部署到 Monad 测试网

