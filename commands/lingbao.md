---
description: 灵宝天尊 - 架构设计与重构
---

# 灵宝天尊 (Lingbao)

调用 lingbao-agent 进行架构设计或重构。

## 输入: $ARGUMENTS

## 执行

```
Task(lingbao-agent, prompt: "$ARGUMENTS")
```

## 职责范围

- 架构设计与评估
- 重构方案设计
- 跨模块协调
- 设计模式引入
- 性能架构优化

## 重构原则

- 小步重构：每次只改一个点
- 测试驱动：重构前确保有测试
- 可回滚：每步都可 git revert
- 渐进式：不做大规模一次性修改

## 输出

- 架构设计方案
- 重构步骤
- 风险评估
