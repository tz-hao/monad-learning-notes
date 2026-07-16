# 核心文档理解与最小技术骨架

## 文档链接

核心文档：

- Moss Agent Skill Guide: https://github.com/nishuzumi/moss/blob/main/docs/agent-skill.md

辅助参考：

- Moss MCP Tools Reference: https://github.com/nishuzumi/moss/blob/main/docs/mcp-tools.md

## 我让 AI 帮我理解了什么

我让 AI 帮我理解 Moss 如何约束 AI Agent 的链上执行流程。

核心理解：

- Agent 不能直接拼 calldata
- 用户自然语言要先转成结构化 intent
- 标准流程是 `discover → load → action → simulate`
- `action` 返回的是未签名交易 Plan，不是直接执行
- `simulate` 是强制步骤，不能跳过
- 出现 warning 必须停止，不能交给用户签名
- 即使没有 warning，也要人工核对 Plan 是否真的符合用户原意
- Moss / Agent 都不能签名、不能广播、不能索要私钥

这给我的 `IntentGuard Agent Wallet` 原型提供了安全边界：AI 只负责解释、生成候选策略和候选交易；链上合约和用户确认负责最终约束。

## AI 生成了什么代码骨架 / 技术方案

AI 帮我生成了一个最小技术方案：用 `IntentGuard` 合约检查 AI 候选交易是否符合用户授权策略。

最小合约骨架：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IntentGuard {
    struct Policy {
        address allowedTarget;
        bytes4 allowedSelector;
        uint256 maxValue;
        bool enabled;
    }

    mapping(address => Policy) public policies;

    error PolicyDisabled();
    error TargetNotAllowed();
    error SelectorNotAllowed();
    error ValueTooHigh();

    event PolicyUpdated(
        address indexed owner,
        address indexed allowedTarget,
        bytes4 allowedSelector,
        uint256 maxValue
    );

    function setPolicy(
        address allowedTarget,
        bytes4 allowedSelector,
        uint256 maxValue
    ) external {
        policies[msg.sender] = Policy({
            allowedTarget: allowedTarget,
            allowedSelector: allowedSelector,
            maxValue: maxValue,
            enabled: true
        });

        emit PolicyUpdated(
            msg.sender,
            allowedTarget,
            allowedSelector,
            maxValue
        );
    }

    function validateTransaction(
        address owner,
        address target,
        uint256 value,
        bytes calldata data
    ) external view returns (bool) {
        Policy memory policy = policies[owner];

        if (!policy.enabled) revert PolicyDisabled();
        if (target != policy.allowedTarget) revert TargetNotAllowed();
        if (value > policy.maxValue) revert ValueTooHigh();
        if (data.length < 4) revert SelectorNotAllowed();

        bytes4 selector = bytes4(data[:4]);
        if (selector != policy.allowedSelector) revert SelectorNotAllowed();

        return true;
    }
}
```

最小测试计划：

- `testAllowsWhitelistedCheckIn()`：允许调用白名单合约 + 白名单 selector
- `testRejectsWrongTarget()`：拒绝非白名单合约
- `testRejectsWrongSelector()`：拒绝非白名单函数
- `testRejectsValueAboveLimit()`：拒绝超过 `maxValue` 的交易
- `testRejectsDisabledPolicy()`：没有策略时拒绝

最小 AI mock：

```json
{
  "userIntent": "只允许 AI 调用 CheckIn 合约，禁止转出 MON",
  "policy": {
    "allowedTarget": "0x7d465988fbe510c7b1890e822be4a66078c09b80",
    "allowedSelector": "0x183ff085",
    "maxValue": "0"
  },
  "explanation": "这条策略只允许 AI 触发 CheckIn.checkIn()，不允许携带 MON 转账。"
}
```

## 我手动改了什么

我没有直接接受 AI 的完整方案，而是做了这些人工调整：

- 把“自动执行钱包”改成“执行前守卫”，降低风险
- 明确 AI 不签名、不广播，只生成候选策略 / 候选交易
- 把真实实现范围压缩到一个 `IntentGuard` 合约和 5 个 Foundry 测试
- 手动加入 `owner` 参数，避免只按 `msg.sender` 检查，方便后续接 Safe / Session Key 场景
- 把多协议、多 token、多 Agent 全部推迟，当前只验证单一 target + selector + value limit
- 明确不能 mock 的部分：合约规则、测试、交易 Hash、截图和安全边界

## 当前是否跑通

当前状态：

```text
未跑通
```

原因：目前只是文档理解和最小代码骨架，还没有创建 Foundry 项目，也没有把 `IntentGuard.sol` 写入 `src/` 并运行测试。

环境检查：

```text
forge --version
```

结果：本地未识别 `forge` 命令，说明当前环境还没有可用的 Foundry CLI。

## 如果没跑通，卡在哪里

当前卡点：

- 还没有初始化 Foundry 项目结构
- 还没有写 `test/IntentGuard.t.sol`
- 本地 `forge` 当前不可用，需要安装 Foundry 或切换到已有 Foundry 环境
- `bytes4(data[:4])` 这种写法需要在真实 Solidity 编译时验证；如果编译不过，需要改成 assembly 或手动读取 calldata 前 4 字节
- 还没有部署到 Monad 测试网

下一步：

1. 确认 `forge --version`
2. 创建最小 Foundry 项目
3. 写入 `IntentGuard.sol`
4. 写 5 个测试
5. 跑 `forge test`
6. 根据错误修改代码
