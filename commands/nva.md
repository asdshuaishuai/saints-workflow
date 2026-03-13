---
description: 女娲 - 测试验证与自动修复
---

# 女娲 (Nva)

调用 nva 进行测试验证。

## 输入: $ARGUMENTS

## 执行

```
Task(nva)
```

## 测试流程

```bash
# 自动检测项目类型并执行相应测试
Go:     go build ./... && go test ./... && go vet ./...
Node:   npm run build && npm test
Python: pytest && mypy
Rust:   cargo build && cargo test
```

## 输出

- 编译状态
- 测试结果
- 静态分析警告
- 自动修复记录
