# 实现缺陷跟踪 · DEFECT_TRACKER

**更新时间**: 2024
**状态**: 活跃跟踪中

---

## P0 缺陷（紧急 - 阻塞核心工作流）

### DEFECT-001: 原子化执行逻辑缺失

**状态**: 🔴 OPEN

**模块**: 太上老君原子化能力

**问题描述**:
- `agents/taishang.md` 有法阵评估框架，但无拆分规则实现
- 无atom输出数据结构（缺owner/domain/priority/complexity/coupling_keys）
- 无依赖分析算法

**影响范围**:
- 无法生成"需求原子清单" (设计目标§IV)
- 無法进行并行识别 (dependent on taig)
- 无法进行院子划分 (dependent on DEFECT-002)

**关联文件**:
- 设计: [docs/review-design.md L19](../docs/review-design.md) 
- 框架: [agents/taishang.md](../agents/taishang.md)
- 框架: [agents/taig.md](../agents/taig.md)

**解决方案**:
```
1. 编辑 agents/taishang.md 补充"原子化执行规则"章节
2. 定义atoms JSON Schema (atom_id, owner, domain, priority, complexity, coupling_keys)
3. 实现拆分规则示例（依赖分析、粒度评估、优先级计算）
```

**阻塞任务**: DEFECT-002, DEFECT-003, DEFECT-004, DEFECT-005

---

### DEFECT-002: 院子管理系统缺失

**状态**: 🔴 OPEN

**模块**: 需求院子划分

**问题描述**:
- 无院子配置表（应维护：负责人、技术栈、依赖、可复用组件）
- 无院子管理Agent/Command
- 无动态院子分配机制

**影响范围**:
- 无法向atoms分配domain
- 无法识别跨院子依赖
- 三清会审无法按院子组织 (阻塞DEFECT-003)

**关联文件**:
- 设计: [docs/review-design.md L46-52](../docs/review-design.md)
- 缺失: `data/domains.json` / `agents/configs/domains.md`
- 缺失: `agents/yuanshi.md` (元始·院子管理Agent)
- 缺失: `commands/domains.md`

**解决方案**:
```
1. 创建 data/domains.json 或 agents/configs/domains.md 维护院子信息
2. 创建 agents/yuanshi.md 第一section编写院子管理逻辑
3. 创建 commands/domains.md 提供查询/更新院子入口
4. 实现域分配算法（基于技术栈/依赖）
```

**阻塞任务**: DEFECT-003

**阻塞自**: DEFECT-001

---

### DEFECT-003: 三清会审工作流无入口

**状态**: 🔴 OPEN

**模块**: 三清会审流程

**问题描述**:
- 无Three-Q-Review Agent（需求/设计/实现三方会审）
- 无 `/saints review` 或 `/tiandao schedule-review` 命令入口
- 无会审纪要生成逻辑
- 无会审结果存储结构

**影响范围**:
- 整套深度会审工作流无法启动
- 准提/接引无法组织三方会审
- 会审决议无法记录和溯源

**关联文件**:
- 设计: [docs/review-design.md L53-61](../docs/review-design.md)
- 缺失: `agents/yuanshi.md` (元始·会审Agent，第二section)
- 缺失: `commands/review.md`
- 缺失: 会审纪要Schema定义
- 缺失: `docs/reviews/{task_id}/` 存储结构

**解决方案**:
```
1. 编辑/创建 agents/yuanshi.md 第二section编写三清会审逻辑
2. 创建 commands/review.md 提供会审启动/查询入口
3. 定义会审纪要JSON Schema (task_id, phase, reviewers, decision, design_doc_link)
4. 实现会审流程调度（一轮/多轮、参与者分配、结果记录）
5. 创建会审结果存储目录 docs/reviews/
```

**阻塞自**: DEFECT-001, DEFECT-002

---

## P1 缺陷（中等 - 影响深度分析）

### DEFECT-004: 耦合度矩阵生成缺失

**状态**: 🟡 OPEN

**模块**: 耦合度分析

**问题描述**:
- 无耦合度计算Agent
- 无矩阵生成逻辑（行/列为atom id，值为耦合强度）
- 无耦合分类规则实现（读/写/契约/时序）
- 无可视化展示

**影响范围**:
- 无法识别高耦合原子、评估发布风险
- 无法指导院子间的协调
- 无法生成"目标产出"中的"耦合度矩阵"

**关联文件**:
- 设计: [docs/review-design.md L69-75](../docs/review-design.md)
- 缺失: 耦合分析Agent（可复用shengongbao或新建）
- 缺失: `commands/analysis.md` 或类似命令

**解决方案** (后续):
```
1. 创建/编辑耦合分析Agent
2. 实现矩阵计算规则（基于coupling_keys/coupling_types）
3. 生成HTML/Markdown可视化展示
4. 创建命令入口（/saints analyze-coupling）
```

**阻塞自**: DEFECT-001

---

### DEFECT-005: 开发层级自动评估缺失

**状态**: 🟡 OPEN

**模块**: 开发层级分配

**问题描述**:
- 无开发层级评估Agent
- 无L1/L2/L3自动分配逻辑
- 无优先级排序规则
- 无blocker任务识别

**影响范围**:
- 无法指导开发顺序
- 无法识别critical path
- 无法生成"目标产出"中的"开发层级分配"

**关联文件**:
- 设计: [docs/review-design.md L73-76](../docs/review-design.md)
- 缺失: 层级评估Agent（可复用shengongbao或新建）
- 缺失: 命令入口

**解决方案** (后续):
```
1. 创建/编辑层级评估Agent
2. 实现层级计算算法（递归依赖分析）
   - L1: 无依赖 OR 仅依赖已完成的原子
   - L2: 依赖<= 3个L1原子
   - L3: 高耦合 OR 跨院子 OR 复杂依赖
3. 创建命令入口（/saints assign-levels）
```

**阻塞自**: DEFECT-001

---

## 依赖关系图

```
DEFECT-001 (原子化)
    ↓ blocks
    ├─→ DEFECT-002 (院子划分)
    │       ↓ blocks
    │       └─→ DEFECT-003 (三清会审)
    │
    ├─→ DEFECT-004 (耦合度矩阵)
    │
    └─→ DEFECT-005 (开发层级)
```

**关键路径**: DEFECT-001 → DEFECT-002 → DEFECT-003

---

## 实现进度表

| 缺陷ID | 优先级 | 状态 | 完成度 | 预期完成时间 | 责任人 |
|--------|------|------|--------|---------|--------|
| DEFECT-001 | P0 🔴 | OPEN | 0% | 待分配 | - |
| DEFECT-002 | P0 🔴 | OPEN | 0% | 待分配 | - |
| DEFECT-003 | P0 🔴 | OPEN | 0% | 待分配 | - |
| DEFECT-004 | P1 🟡 | OPEN | 0% | 待分配 | - |
| DEFECT-005 | P1 🟡 | OPEN | 0% | 待分配 | - |

---

## 检查清单（解决DEFECT-001案例）

- [ ] 编辑 `agents/taishang.md` 补充"## 原子化执行规则"章节
- [ ] 定义atoms输出JSON Schema (包含atom_id, owner, domain等字段)
- [ ] 编写拆分规则示例（依赖分析、粒度评估、优先级计算）
- [ ] 编辑 `agents/taig.md` 补充"## 并行任务识别"实现细节
- [ ] 创建示例输出 `examples/atoms_output.json`
- [ ] 更新 `docs/review-design.md` 第四章补充输出样例
- [ ] 测试原子化执行（手动或通过Agent调用）
- [ ] 更新 `commands/taishang.md` 补充原子化输出说明
- [ ] 标记DEFECT-001为CLOSED

---

## 更新日志

**2024-XX-XX**: 初始化缺陷追踪，记录5个缺陷（3个P0，2个P1），明确依赖关系

