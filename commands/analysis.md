---
description: 耦合度分析与开发层级 · 依赖图分析与优先级排序
---

# 耦合度分析·开发层级评估

> 耦合分明，则依赖顺序可推；层级清晰，则众役知所先后。

## 天命

**「$ARGUMENTS」**

## 执行

```
Task(shengongbao, prompt: "【申公豹听令】耦合分析与层级评估: $ARGUMENTS
当前任务类型可能包括：
- analyze-coupling --task T-{id}: 生成耦合度矩阵，识别高耦合
- generate-matrix --task T-{id} [--format html|markdown|csv]: 可视化矩阵
- find-critical-path --task T-{id}: 识别关键路径
- assign-levels --task T-{id}: 计算开发层级（L1/L2/L3）
- estimate-schedule --task T-{id} [--team-size N]: 估算项目进度
- detect-cycles --task T-{id}: 检测循环依赖（设计缺陷预警）
- validate-domains --task T-{id}: 验证跨域依赖复杂度

请读取原子清单，基于coupling_keys和coupling_types计算矩阵，输出完整分析报告。")
```

---

## 支持的子命令

### analyze-coupling

生成耦合度矩阵与高耦合识别

**语法**:
```
@shengongbao analyze-coupling --task T-AUTH-001 [--threshold 2.5]
```

**参数**:
- `--task`: 任务ID（必需）
- `--threshold`: 高耦合阈值，默认2.5（强依赖及以上）

**输出示例**:
```
耦合度矩阵 - T-AUTH-001

       A-001  A-002  A-003  A-004
A-001    -      0      1      2.5
A-002    -      -      0      2
A-003    -      -      -      0
A-004    -      -      -      -

高耦合原子识别:
  🔴 A-001: 被A-004强依赖 (2.5) → 必须优先完成
  🟡 A-002: 被A-004中等依赖 (2.0) → 需API定稳
  
耦合统计:
  平均强度: 1.33 (低耦合)
  最大强度: 2.5 (强)
  高耦合原子: 2个

建议:
  - A-001 应分配为 L1 优先级
  - A-002 的API应在A-004前冻结
```

### generate-matrix

可视化耦合度矩阵

**语法**:
```
@shengongbao generate-matrix --task T-AUTH-001 --format html
```

**参数**:
- `--task`: 任务ID（必需）
- `--format`: 输出格式 `html|markdown|csv`（默认html）

**输出**: 
- HTML格式：可交互式矩阵，支持hover查看详情
- Markdown格式：表格形式，易于文档嵌入
- CSV格式：可导入分析工具

### find-critical-path

识别关键路径（决定项目总工期的路径）

**语法**:
```
@shengongbao find-critical-path --task T-AUTH-001
```

**输出示例**:
```
关键路径分析 - T-AUTH-001

关键路径1 (最长):
  A-DB-001 (0.5d) → A-AUTH-001 (2d) → A-AUTH-004 (2d)
  总耗时: 4.5d

关键路径2:
  A-AUTH-002 (1d) → A-AUTH-003 (1.5d) → A-CACHE-001 (1d)
  总耗时: 3.5d

项目工期预估: 4.5d (由路径1决定)

并行机会:
  - A-AUTH-002 可与 A-DB-001 并行 (节省0.5d)
  - A-CACHE-001 可与其他L2原子并行

优化建议:
  - 优先投入人力到关键路径上的原子
  - A-DB-001 延期1天将导致项目延期1天
```

### assign-levels

计算开发层级（L1/L2/L3）

**语法**:
```
@shengongbao assign-levels --task T-AUTH-001 [--deep-analysis]
```

**参数**:
- `--task`: 任务ID（必需）
- `--deep-analysis`: 生成详细分析报告

**输出示例**:
```
开发层级分配 - T-AUTH-001

L1 原子 (立即启动，优先完成，优先级 P0):
  A-AUTH-002: 令牌续期机制 (1d, 独立)
  A-DB-001: 用户表扩展 (0.5d, 无依赖)
  [建议同时启动，预计1d完成]

L2 原子 (待L1完成后启动，优先级 P1):
  A-AUTH-001: OAuth2登录 (2d, 依赖A-DB-001)
  A-AUTH-003: 登录日志 (1.5d, 依赖A-AUTH-001,A-LOG-001)
  [预计启动时间: 第2天，完成时间: 第4.5天]

L3 原子 (高耦合，需协调，优先级 P2/特殊处理):
  A-AUTH-004: 单点登录SSO (2d, 跨域耦合)
    依赖: A-AUTH-001, A-AUTH-002, A-PAY-001
    跨域: payment (高风险)
  [建议和payment团队联合规划，可先实现兼容层]

进度预估:
  总工期: 4.5d (关键路径决定)
  并行度: 60% (L1可2d完成，节省0.5d工期)
  风险等级: 中 (L3跨域耦合)
```

### estimate-schedule

估算项目进度（基于团队规模）

**语法**:
```
@shengongbao estimate-schedule --task T-AUTH-001 --team-size 5 [--buffer 20%]
```

**参数**:
- `--task`: 任务ID（必需）
- `--team-size`: 团队人数（默认3）
- `--buffer`: 预留缓冲时间（默认20%风险余量）

**输出示例**:
```
项目进度规划 - T-AUTH-001 (5人团队)

基础估算: 4.5d (关键路径)
并行优化: -0.5d (L1并行)
风险缓冲: +1.0d (20%)
→ 最终预估: 5.0d

周计划:
  第1周 (5d):
    Day1-2: L1原子并行开发 (2人: A-DB-001, 2人: A-AUTH-002, 1人: setup)
    Day3-4: L2原子开发 (3人: A-AUTH-001, 2人: A-AUTH-003)
    Day5: L3预研与协调 (1人: A-AUTH-004 架构评审)

分队配置:
  Database小组 (1人): A-DB-001 → 支持
  Auth小组 (3人): A-AUTH-001, A-AUTH-002, A-AUTH-003 主力
  Platform小组 (1人): A-AUTH-004 & payment协调

风险预警:
  ⚠️ A-AUTH-004 跨域风险高，建议Day2就启动与payment的对齐讨论
  ⚠️ 若A-DB-001延期超1d，整个项目延期1d
```

### detect-cycles

检测循环依赖（设计红旗警告）

**语法**:
```
@shengongbao detect-cycles --task T-AUTH-001
```

**输出示例**:
```
循环依赖检测 - T-AUTH-001

✅ 未发现循环依赖

但检测到的复杂依赖链:
  A-AUTH-001 → A-AUTH-004 → A-PAY-001 → A-DB-001 → A-AUTH-001
  (这不是循环，但形成了复杂的相互依赖关系)

建议: 考虑引入中间层或API网关来解耦
```

**警告示例** (若发现循环):
```
🚨 发现循环依赖!

循环: A-001 → A-002 → A-003 → A-001

这是严重的设计缺陷，必须立即修复：
  选项1: 重新拆分原子，明确功能边界
  选项2: 引入第三方服务提供某项功能，打破循环
  选项3: 实现事件驱动或发布-订阅模式来解耦

建议立即启动架构评审会。
```

### validate-domains

验证跨域依赖复杂度

**语法**:
```
@shengongbao validate-domains --task T-AUTH-001 [--strict]
```

**参数**:
- `--strict`: 严谨模式，限制跨域依赖数量

**输出示例**:
```
跨域依赖验证 - T-AUTH-001

跨域原子识别:
  🟡 A-AUTH-004 (SSO): 跨3个域 (auth, payment, platform)
     依赖关系: auth→pay, pay→db, pay→cache
     
跨域原子风险评估:
  依赖域数: 3 (中风险，建议 <= 2)
  依赖深度: 2 (权接受)
  并行度: 20% (低，需协调)
  
建议:
  - 将A-AUTH-004 拆分为L3+ (特殊优先级)
  - 需3方团队参与: auth-owner, payment-owner, platform-owner
  - 建议多轮会审确保接口兼容性
```

---

## 输出文件

所有分析结果自动生成到:
- `docs/reviews/{task_id}/coupling_analysis.md` - 耦合度详细报告
- `docs/reviews/{task_id}/level_assignment.md` - 层级分配方案
- `docs/reviews/{task_id}/critical_path.md` - 关键路径分析
- `docs/reviews/{task_id}/schedule_plan.md` - 进度规划

---

耦合明晰，则并行可期；层级清晰，则优先无误。申公豹之学，非但破阵，更能理顺众役之序。

