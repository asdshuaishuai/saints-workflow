---
description: 三清会审 · 组织深度评审（需求/设计/实现多维度）
---

# 三清会审 · 深度评审协调

> 三清齐聚，从需求、设计、实现三维度勘破天机。
> 会审一轮，则大计方有所据。

## 天命

**「$ARGUMENTS」**

## 执行

```
Task(yuanshi, prompt: "【元始听令】三清会审: $ARGUMENTS
当前任务类型可能包括：
- start-review --task T-{id} [--atoms A-1,A-2] [--phase triage|design|implementation]: 启动会审流程
- get-review --task T-{id}: 查询会审状态与纪要
- update-decision --task T-{id} --decision approved|approved_with_comments|need_revision|rejected [--comments '...']:  更新会审决议
- list-reviews [--status open|closed|pending]: 列出待审/已审任务
- schedule-followup --task T-{id} --date {date}: 安排后续会审

请根据命令类型，组织对应的圣人参与（准提·接引·需求方），生成会审纪要。")
```

---

## 支持的子命令

### start-review

启动三清会审流程

**语法**:
```
@yuanshi start-review --task T-AUTH-001 [--atoms A-AUTH-001,A-AUTH-002] [--phase design]
```

**参数**:
- `--task`: 任务ID（必需）
- `--atoms`: 参与会审的原子列表（可选）
- `--phase`: 会审阶段，`triage|design|implementation|all` （默认all）
- `--intensive`: 高风险标记，触发多轮会审

**工作流程**:
1. 验证任务与原子存在
2. 识别涉及的院子与负责人
3. 邀请三清圣人（准提/接引/设计/需求方）
4. 生成会审议程与资料包
5. 创建会审纪要模板 `docs/reviews/{task_id}/minutes.md`

**输出示例**:
```
会审已启动: T-AUTH-001
涉及院子: auth, database
参会圣人: 准提(CODE), 接引(BUSINESS), @auth-owner(REQUIREMENT)
会审阶段: design
预计耗时: 2小时
会审纪要: docs/reviews/T-AUTH-001/minutes.md

下一步: 等待参会圣人提交评审意见
```

### get-review

查询会审状态与纪要

**语法**:
```
@yuanshi get-review --task T-AUTH-001 [--format summary|detailed|raw]
```

**参数**:
- `--task`: 任务ID（必需）
- `--format`: 输出格式（默认summary）

**输出示例**:
```
会审状态: IN-PROGRESS (开始于 2024-03-27 10:00)

参会角色进度:
  需求清 (@auth-owner): ✅ 已提交意见
  设计清 (@design-owner): ⏳ 进行中
  实现清 (准提): ⏳ 待提交

关键问题:
  1. OAuth2流程中的令牌可靠性需补充测试用例
  
决议: [待定]

完整纪要: docs/reviews/T-AUTH-001/minutes.md
```

### update-decision

更新会审决议

**语法**:
```
@yuanshi update-decision --task T-AUTH-001 --decision approved [--comments '通过，请补充单测覆盖率到80%']
```

**参数**:
- `--task`: 任务ID（必需）
- `--decision`: 决议结果，`approved|approved_with_comments|need_revision|rejected` （必需）
- `--comments`: 决议理由或条件（可选）

**工作流程**:
1. 更新会审纪要中的决议字段
2. 若decision=approved，标题任务可进入下一阶段
3. 若decision=need_revision，将action items分配给对应责任人
4. 生成决议通知

**输出示例**:
```
会审决议已更新: T-AUTH-001

决议: ✅ APPROVED
条件: 
  - 补充单测覆盖率至80%（负责人: @auth-owner, 截止: 2024-03-31）
  - 使用TLS 1.3加密令牌传输（负责人: @security-lead, 截止: 2024-03-31）

下一步: Action Items 已分配，预计3天内完成。完成后可启动代码审查。
```

### list-reviews

列出待审/已审任务

**语法**:
```
@yuanshi list-reviews [--status open|closed|pending] [--domain auth] [--limit 10]
```

**参数**:
- `--status`: 筛选状态（默认all）
- `--domain`: 筛选院子（默认all）
- `--limit`: 返回数量（默认10）

**输出示例**:
```
待审任务 (3个):
  T-AUTH-001: OAuth2登录迭代 (design) ← 3天未回复
  T-PAY-002: 支付分账新增 (triage) ← 需求阶段
  T-SEARCH-001: ES升级方案 (design) ← 1天前启动

已审任务 (12个):
  T-DB-001: MySQL字段扩展 → ✅ APPROVED
  T-LOG-002: 日志系统优化 → ✅ APPROVED (with conditions)
  ...
```

### schedule-followup

安排后续会审

**语法**:
```
@yuanshi schedule-followup --task T-AUTH-001 --date 2024-03-31 --agenda '补充单测评审'
```

**参数**:
- `--task`: 任务ID（必需）
- `--date`: 后续会审日期（必需）
- `--agenda`: 会审议题（必需）

**工作流程**:
1. 记录后续会审日程
2. 发送提醒给参会圣人
3. 准备后续会审资料包

---

## 会审纪要模板

自动生成位置: `docs/reviews/{task_id}/minutes.md`

**内容**:
- 会审基本信息（日期/参会人员）
- 三维度评审意见（需求/设计/实现）
- 共识要点与分歧点
- 决议结果
- Action Items 清单

---

## 特殊场景

### 高风险原子 (coupling > 3)

自动标记为"需多轮会审"，触发：
- 邀请安全/性能专家
- 扩大参审范围
- 增加会审轮数

### 跨院子原子

自动触发：
- 涉及院子的负责人全部参加
- 依赖关系验证
- 风险评估与分散

### 会审延期

若超过SLA（普通需求1周，高风险3天），触发：
- 自动预警
- 升级给管理层
- 启动加急流程

---

三清会审一启，则群策群力，万无一失。决议既下，则众生各得其所。

