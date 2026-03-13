---
name: bagua
description: 先天八卦 - 8维度上下文收集技能。用于全面分析项目状态，为决策提供完整上下文。
---

# 先天八卦 (Bagua)

先天八卦是一个上下文收集技能，从8个维度全面分析项目状态。

## 使用场景

- 需求增强前收集上下文
- 架构设计前了解现状
- 代码审查前的准备
- 问题诊断时的信息收集

## 八卦维度

```
                    ☰ 乾 (项目全局)
                          │
        ☵ 坎 (数据流) ───┼─── ☲ 离 (性能资源)
                          │
    ☳ 震 (风险异常) ──────┼───── ☴ 巽 (依赖关联)
                          │
        ☶ 艮 (阻塞限制) ─┼─ ☱ 兑 (验证测试)
                          │
                    ☷ 坤 (代码基础)
```

## 收集动作

| 卦象 | 维度 | 收集命令 | 目的 |
|:----:|------|---------|------|
| ☰ 乾 | 项目全局 | `Read CLAUDE.md/README`<br>`Glob **/*`<br>`Bash git log --oneline -10` | 了解项目结构、历史 |
| ☷ 坤 | 代码基础 | `Grep "关键词"`<br>`Read 相关文件` | 理解现有实现 |
| ☳ 震 | 风险异常 | `Grep "TODO\|FIXME\|XXX\|HACK"` | 发现潜在问题 |
| ☴ 巽 | 依赖关联 | `Glob *依赖文件*`<br>`Read 依赖配置` | 了解依赖关系 |
| ☵ 坎 | 数据流 | `Grep "类型定义\|接口\|数据结构"`<br>`Glob *model/entity/schema*` | 理解数据结构 |
| ☲ 离 | 性能资源 | `Grep "性能相关代码"`<br>`Glob *test/benchmark*` | 评估性能状况 |
| ☶ 艮 | 阻塞限制 | 分析约束条件、技术债务 | 识别限制因素 |
| ☱ 兑 | 验证测试 | `Glob *test/spec*`<br>`Read 测试文件` | 了解测试覆盖 |

**常见依赖文件**: go.mod, package.json, requirements.txt, Cargo.toml, pom.xml, Gemfile, composer.json, build.gradle 等

## 输出格式

```markdown
## 八卦上下文报告

### ☰ 乾 - 项目全局
- 项目类型: {type}
- 主要技术栈: {stack}
- 近期变更: {changes}

### ☷ 坤 - 代码基础
- 相关文件: {files}
- 核心模块: {modules}

### ☳ 震 - 风险异常
- 待处理: {todos}
- 已知问题: {issues}

### ☴ 巽 - 依赖关联
- 直接依赖: {deps}
- 依赖风险: {risks}

### ☵ 坎 - 数据流
- 数据结构: {structs}
- 接口定义: {interfaces}

### ☲ 离 - 性能资源
- 性能关键点: {points}
- 资源消耗: {resources}

### ☶ 艮 - 阻塞限制
- 技术约束: {constraints}
- 待解决: {blocks}

### ☱ 兑 - 验证测试
- 测试覆盖: {coverage}
- 测试状态: {status}

### 综合评估
{summary}
```

## 使用方式

```
# 直接调用技能
/bagua 收集用户认证模块的上下文

# 或在 fuxi-agent 中自动调用
```
