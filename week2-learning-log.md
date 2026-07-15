# Week 2 学习记录

> 目标：持续记录资料链接、Prompt、截图、错误、判断变化和下一步计划，形成可复盘的 Dev Builder 学习轨迹。

## 本周主线

```text
方向：Dev Builder
主题：Monad CheckIn Demo 1
目标：把 Week 1 的最小打卡合约升级成更标准、更可验证的 Dev Demo
```

本周关注：

- Foundry / Solidity 项目结构
- Monad 测试网部署与交互
- 合约测试与错误复盘
- AI-assisted 开发工作流
- AI Agent x Web3 的链上执行安全

## 资料链接

| 日期 | 类型 | 链接 | 学到什么 | 后续动作 |
| --- | --- | --- | --- | --- |
| 2026-07-15 | Monad Docs | https://docs.monad.xyz/ | Monad 开发入口文档 | 继续看 Best Practices 和 Gas Pricing |
| 2026-07-15 | Solidity Docs | https://docs.soliditylang.org/ | Solidity 语言和合约基础 | 对照 `CheckIn` 合约补语法理解 |
| 2026-07-15 | Foundry Book | https://book.getfoundry.sh/ | Foundry 项目、测试、脚本流程 | 用 Foundry 搭 Demo 1 |
| 2026-07-15 | MonadVision Tx | https://testnet.monadvision.com/tx/0xd35c2b5174aa72e757ec6aef8d8a352c81391b0b453a507102f367896555d814 | 已有真实 `checkIn()` 交互证据 | 作为 Demo 1 README 证据 |
| 2026-07-15 | Moss Repo | https://github.com/nishuzumi/moss | AI Agent 链上执行框架思路 | 作为 AI x Web3 方向参考 |

## Prompt 记录

| 日期 | Prompt | AI 输出 | 人工判断 / 修改 |
| --- | --- | --- | --- |
| 2026-07-15 | 选择 Research / Ops / Dev 一个主方向，说明选择理由、服务的问题、本周最小产出、参考资料和 Week 3 角色。 | 生成 Dev 方向选择说明 | 改成更强的 `Role Choice Card — Dev Builder` |
| 2026-07-15 | 补充一下第四点，提交这个版本的 | 补全 Week 2 Minimum Deliverable 并提交 | 确认正确仓库是 `monad-learning-notes` |
| 2026-07-15 | 建立本周学习记录，持续记录资料链接、Prompt、截图、错误、判断变化和下一步计划。 | 创建本文件 | 用表格保留持续追加空间 |

## 截图 / 证据

| 日期 | 文件 / 链接 | 说明 | 状态 |
| --- | --- | --- | --- |
| 2026-07-15 | `outputs/monad-checkin-tx.png` | MonadVision `checkIn()` 交易截图 | 已保存 |
| 2026-07-15 | `outputs/MiniDemo0.md` | Week 1 Mini Demo 0 汇总 | 已完成 |
| 2026-07-15 | `week2-direction.md` | Dev Builder Role Choice Card | 已完成 |

## 错误 / 卡点记录

| 日期 | 问题 | 原因判断 | 处理方式 | 结果 |
| --- | --- | --- | --- | --- |
| 2026-07-15 | 仓库上传目标混乱 | 本地同时存在 `monad` 和 `monad-learning-notes` 两个 Git 仓库 | 重新检查 `git remote -v`，确认学习笔记仓库是 `tz-hao/monad-learning-notes` | 已修正并推送正确仓库 |
| 2026-07-15 | `gh auth status` 提示 token 失效 | GitHub CLI keyring 凭据无效 | 改用已有 Git remote + `git push` | 成功推送 |
| 2026-07-15 | MonadVision 页面不易直接抓取 | 页面有动态渲染 / Cloudflare | 改用 Monad 测试网 JSON-RPC 查询交易回执 | 拿到交易状态、区块、Gas、事件 |

## 判断变化

| 日期 | 原判断 | 新判断 | 变化原因 |
| --- | --- | --- | --- |
| 2026-07-15 | Week 2 可以继续 Tech / Research 混合 | Week 2 主方向明确为 Dev Builder | 已有合约、真实交易和 AI x Web3 基础，更适合用代码产出证明能力 |
| 2026-07-15 | 只整理学习记录即可 | 需要形成可验证 Demo | Week 3 组队和 Hackathon 更看重 repo、交易 hash、测试、截图 |
| 2026-07-15 | AI 可以帮忙完成大部分内容 | AI 负责辅助，人工负责最终判断 | 链上交易、私钥安全、仓库目标、方向选择都必须人工确认 |

## 下一步计划

### 今日 / 最近

- [ ] 确认 Foundry 是否已安装
- [ ] 创建 `checkin-demo-1` 项目结构
- [ ] 把 `CheckIn.sol` 放入 `src/`
- [ ] 编写最小测试：首次打卡、重复打卡失败、间隔后再次打卡
- [ ] 整理 Demo 1 README 初稿

### 本周

- [ ] 跑通 `forge test`
- [ ] 准备 Monad 测试网部署脚本
- [ ] 补充新的交易 hash 或复用已有交互证据
- [ ] 记录至少一个真实错误和修复过程
- [ ] 总结 AI-assisted Dev 工作流

## 每日追加区

### 2026-07-15

- 建立 Week 2 Dev Builder 方向卡片
- 确认正确 GitHub 仓库为 `tz-hao/monad-learning-notes`
- 建立本周学习记录文件
- 当前重点从“说明自己选择 Dev”转向“交付可运行 Demo 1”

