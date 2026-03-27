# 使用说明（快速上手）

本文档说明如何通过 Claude Code 标准插件模式使用圣人工作流：原子化分析、天道调度、西方双审。

## 前提
- 在 VS Code 或 Claude IDE 中集成本插件
- 了解基本的Agent/Skill/Command概念

## 快速上手

### 1. 完整工作流
使用完整的圣人工作流处理需求：

```
/saints-workflow:saints 实现用户登录功能
```

自动执行：
- **太上老君**: 需求分析与原子化
- **阐教/截教**: 对抗开发方案
- **伏羲/女娲**: 测试与缺陷修复
- **准提/接引**: 代码与业务审查
- **天道**: 最终确认与监管

### 2. 单阶段调用

#### 需求分析与原子化
```
/saints-workflow:taishang 分析登录功能需求并原子化拆分
```

#### 天道调度审查
```
/saints-workflow:tiandao 对完成的登录模块进行动态审查调度
```

#### 代码审查
```
/saints-workflow:puti 对登录模块代码进行深度审查
```

#### 业务审查
```
/saints-workflow:jieyin 对登录流程进行业务逻辑审查
```

### 3. 技能查询

#### 先天八卦（8维度上下文）
```
/bagua 登录模块
```

了解登录模块的全局/基础/风险/依赖/数据/性能/约束/测试8个维度。

### 4. 审查设计

查阅 `docs/review-design.md` 了解多角度审查体系：
- 太上老君的需求原子化
- 院子划分与三清会审
- 天道动态调度西方双审
- 耦合度矩阵与开发层级

## 工作流指南

| 场景 | 命令 | 说明 |
|------|------|------|
| 新功能开发 | `/saints:saints 需求描述` | 完整工作流 |
| 需求分析 | `/saints:taishang 需求` | 太上老君分析 |
| 原子化拆分 | `/saints:taig 需求` | 太极图原子化 |
| 正面方案 | `/saints:yuanshi 实现方案` | 元始天尊评审 |
| 激进方案 | `/saints:tongtian 创新思路` | 通天教主评审 |
| 架构设计 | `/saints:duobao 架构方案` | 多宝道人评审 |
| 测试设计 | `/saints:fuxi 模块` | 伏羲8维测试 |
| 缺陷修复 | `/saints:nva BUG描述` | 女娲修复建议 |
| 代码审查 | `/saints:puti 代码` | 准提代码评审 |
| 业务审查 | `/saints:jieyin 流程` | 接引业务评审 |
| 上下文收集 | `/bagua 模块` | 8维度上下文 |
| 定时监管 | `/saints:tiandao` | 天道动态调度 |

## 产物记录

审查结果与会审纪要存放在：
- `docs/reviews/{task_id}/` - 会审纪要、落地设计、审查结论
- `data/atoms/{task_id}.json` - 原子化输出（如有）
- `data/reviews/{task_id}/` - 审查任务与结果（如有）

## 下一步

- 参阅 `README.md` 了解完整的Agent体系与技能
- 查看 `skills/saints/SKILL.md` 深入了解工作流法阵
- 参考各Agent的markdown文件（`agents/` 目录）获取详细功能说明
