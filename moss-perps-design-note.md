# Moss 永续合约语义设计建议

**对应 Issue：** [nishuzumi/moss#15](https://github.com/nishuzumi/moss/issues/15)  
**身份：** Research Builder  
**状态：** 讨论稿；不包含 adapter 实现

## 结论

建议将永续合约作为独立的 `perps` 分类，并引入 `open` / `close` 两个仓位生命周期动词。保证金管理继续复用 `supply` / `withdraw`，由 `category: perps` 和账户/市场参数消除语义歧义。

| 用户意图 | 建议 verb | 关键参数 | 为什么 |
| --- | --- | --- | --- |
| 开多或开空 | `open` | `market`、`side`、`collateral`、`leverage`、`size` 或 `sizeUsd` | 开仓不是兑换，也不能用普通 transfer 代替。 |
| 平仓 | `close` | `market`、`size` 或 `sizePercent`、`reduceOnly` | 明确表达减少或终止仓位。 |
| 存入保证金 | `supply` | `market` 或 `marginAccount`、`token`、`amount` | 本质是用户向已有保证金账户放入资产。 |
| 提取保证金 | `withdraw` | `market` 或 `marginAccount`、`token`、`amount` | 本质是从保证金账户提取资产。 |

## 分类建议

新增闭集分类 `perps`，而不是使用 `dex` 加 `perps` tag。

理由：永续合约有独有的仓位状态、杠杆、清算和资金费风险；它们不只是交易场所的长尾属性。独立分类能让 `discover`、风险提示和 Agent 意图对齐直接识别高风险操作。协议实现细节仍可放入 tags，例如 `cross-margin`、`isolated-margin`、`orderbook`。

## 验证模型

`expects` 继续只承担可机械对账的资产效果；仓位状态不能伪装成代币流，应该由 protocol observation 描述并通过 `confirms` 变成必需回执。

| 操作 | `expects` 应覆盖 | observation 必须说明 |
| --- | --- | --- |
| `open` | 保证金最大流出、授权上限、明确费用或接收方 | 市场、方向、名义仓位、杠杆、开仓价或执行价、保证金模式 |
| `close` | 已知手续费上限、结算资产的预期流入/流出边界 | 已平仓数量、剩余仓位、已实现盈亏、结算价格 |
| `supply` / `withdraw` | 资产流出/流入、授权上限 | 更新后的保证金、可用保证金或健康度（若协议提供） |

建议 capability 声明 `confirms: ["positionOpened"]` 或 `confirms: ["positionClosed"]`。若事件/回执未在模拟中出现，触发 `CONFIRMATION_MISSING`；observation 不能覆盖任何 reconciliation warning。

## 风险标签与 Agent 规则

- `open` 必须至少带 `fundOut`、`leverage`、`liquidation`；有授权时带 `approval`。
- `close` 和保证金提取也应保留 `liquidation`，因为部分平仓或提取会改变健康度。
- Agent 在零 warning 后仍必须进行 intent alignment：核对方向、市场、杠杆、保证金、仓位规模和剩余仓位是否符合用户原话。
- 未声明资金流、授权超限、回滚或缺少确认回执时，必须停止，不能交给签名器。

## 仍需维护者决策的问题

1. `open` 的规模参数应优先使用标的数量、USD 名义价值，还是由 adapter 按协议选择。
2. 在浮动手续费、资金费和盈亏场景下，`close` 的动态结算边界如何以保守方式写入 `expects`。
3. 只存在事件、不存在标准化仓位视图的协议，最小 confirmation 要求是什么。
4. `supply` / `withdraw` 是否需要为保证金账户增加统一参数名。

## 下一步

先将本建议提交到 #15 讨论；在 ADR 0003 的词汇与验证原则获得维护者确认前，不启动 Perpl、LeverUp 或其他永续协议 adapter 的代码实现。
