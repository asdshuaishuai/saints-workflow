---
description: 太极 - 需求原子化拆分
---

# 太极 (Taig)

调用 taig-agent 进行需求原子化拆分。

## 输入: $ARGUMENTS

## 执行

```
Task(taig-agent, prompt: "原子化拆分: $ARGUMENTS")
```

## 输出

- 原子任务列表
- 依赖关系图
- 执行顺序建议
