# 最小 Web3 / AI 原型定义：AI CheckIn Copilot

## 我要做的最小功能是什么？

我要做一个最小 Web3 / AI 原型：

```text
AI CheckIn Copilot
```

它的核心功能是：用户输入“我要在 Monad 测试网上打卡”，系统生成一次 `CheckIn` 合约交互，并在交易前后用 AI 帮用户解释这笔交易做了什么、风险是什么、结果是否成功。

最小版本不追求完整 Agent 自动交易，而是做一个“AI 辅助理解 + 人工确认执行”的 Demo。

## 谁会使用它？

目标用户是：

- Monad 新学习者
- 第一次接触智能合约交互的人
- 想理解交易 Hash、Gas、合约地址、事件日志含义的 Builder
- Week 3 团队中需要快速验证链上交互 Demo 的成员

用户不需要先理解 ABI、calldata、event log，AI Copilot 负责解释，但最终签名和确认仍由用户自己完成。

## 用户完成的一个动作是什么？

用户完成的最小动作：

```text
连接钱包 → 点击 / 输入“打卡” → 人工确认交易 → 查看 AI 解释的交易结果
```

用户视角流程：

1. 打开 Demo 页面或脚本
2. 连接 Monad 测试网钱包
3. 点击 `Check In`
4. 钱包弹出交易确认
5. 用户确认交易
6. 系统显示交易 Hash
7. AI 解释：
   - 调用了哪个合约
   - 调用了哪个方法
   - 这笔交易是否成功
   - 消耗了多少 Gas
   - 事件里记录了什么

## 我需要读哪 1–3 个文档？

本周只读最关键的 3 类文档，避免发散：

1. Monad Developer Docs  
   https://docs.monad.xyz/

   用途：确认 Monad 测试网、RPC、Gas、浏览器和开发注意事项。

2. Foundry Book  
   https://book.getfoundry.sh/

   用途：搭建合约项目、写测试、写部署脚本。

3. Moss / Agent 安全执行参考  
   https://github.com/nishuzumi/moss

   用途：学习“AI 不直接签名、不直接广播，只负责构建、解释和风险提示”的边界设计。

## 本周真实实现什么？

本周真实实现的范围：

- 搭建一个最小 Foundry 项目
- 放入升级版 `CheckIn` 合约
- 写最小测试：
  - 第一次打卡成功
  - 24 小时内重复打卡失败
  - 间隔后再次打卡成功
  - 打卡次数或连续天数更新
- 写一个交互脚本或最小前端：
  - 调用 `checkIn()`
  - 输出交易 Hash
  - 查询 `checkInCount`
- 保留 Monad 测试网真实交易证据：
  - 合约地址
  - 交易 Hash
  - MonadVision 截图
  - README 说明
- 写一份 AI 解释模板：
  - 输入交易 Hash / 回执字段
  - 输出自然语言说明

真实链上部分必须最小但可验证：至少保留一条真实 Monad 测试网交互记录。

## 哪些可以 mock？

可以 mock 的部分：

- AI 模型调用可以先 mock：先用固定 Prompt 模板和静态解释文本，不一定接真实 LLM API
- 前端 UI 可以先 mock：不做完整产品级界面，只要能展示按钮、Hash 和解释结果
- 用户画像可以 mock：先假设用户是 Monad 新学习者
- 风险评分可以 mock：先用规则写死，例如“这是测试网交易，Value 为 0，风险较低”
- 多协议交互可以 mock：本周只支持 `CheckIn`，不接 DEX、NFT、借贷协议

不能 mock 的部分：

- 合约测试不能 mock
- 交易 Hash 不能 mock
- 合约地址不能 mock
- 截图和区块浏览器链接不能 mock
- 用户签名确认不能交给 AI 自动完成

## 我如何证明它做出来了？

Proof of Work：

- GitHub repo 中有可读代码
- `forge test` 可以跑通
- README 写清楚如何安装、测试、部署、交互
- 有至少一条 Monad 测试网真实交易 Hash
- 有 MonadVision 截图
- 有 AI 解释示例，说明交易做了什么
- 有错误 / 修复记录，说明不是只写了文档

最小验收标准：

```text
一个队友打开 repo，可以看到合约、测试、交互说明、真实交易证据，并理解 AI 在这个 Demo 里负责解释而不是替用户签名。
```

## 当前取舍

我选择先做 `CheckIn` 场景，而不是复杂 DeFi 场景。

理由：

- 打卡合约足够小，适合快速验证 Monad 开发闭环
- 交易 Value 为 0，风险较低
- 状态变化清晰，适合 AI 解释
- 可以自然扩展到积分、连续打卡、排行榜
- 更适合 Week 3 组队时作为 Dev Builder 的基础 Proof of Work

