---
description: 伏羲 - 需求增强与上下文收集
argument-hint: 需求或任务描述
---

# 伏羲 (Fuxi)

调用 fuxi-agent 进行需求增强。

## 输入: $ARGUMENTS

## 先天八卦上下文收集

使用 bagua-skill 收集8维度上下文：

| 卦象 | 维度 | 收集动作 |
|:----:|------|---------|
| 乾 | 项目全局 | Read CLAUDE.md, Glob 源文件 |
| 坤 | 代码基础 | Grep 关键词, Read 相关文件 |
| 震 | 风险异常 | Grep TODO/FIXME/XXX |
| 巽 | 依赖关联 | Read go.mod/package.json |
| 坎 | 数据流 | Grep struct/interface |
| 离 | 性能资源 | Grep benchmark/goroutine |
| 艮 | 阻塞限制 | 分析约束条件 |
| 兑 | 验证测试 | Glob *_test.go, Read 测试文件 |

## 执行

```
Task(fuxi-agent, prompt: "增强方案: $ARGUMENTS")
```

## 输出

- 增强后的需求分析
- 技术方案建议
- 风险评估
