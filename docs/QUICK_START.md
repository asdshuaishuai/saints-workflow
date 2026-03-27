# 核心功能快速参考

## 🎯 新增功能概览

本次修复实现了5大缺失功能模块，补齐了设计与实现的落差：

### ✅ DEFECT-001: 原子化执行逻辑
**位置**: [agents/taishang.md](../agents/taishang.md#原子化执行规则)

补充了原子化拆分的完整规则，包含：
- 原子属性定约 (owner/domain/priority/complexity/coupling)
- 拆分法则 (依赖分析/单一职责/跨域识别)
- 原子化执行流程示例

**使用**:
```
@taishang 分析需求，进行原子化拆分，标注每个原子的owner、domain、priority、complexity、coupling_keys
```

**输出格式**: atoms.json
```json
{
  "task_id": "T-{id}",
  "atoms": [
    {
      "atom_id": "A-001",
      "owner": "@someone",
      "domain": "auth",
      "priority": "P0",
      "complexity": "medium",
      "coupling_keys": ["A-002"],
      "coupling_types": {"A-002": "contract"}
    }
  ]
}
```

---

### ✅ DEFECT-002: 院子管理系统
**位置**: [agents/yuanshi.md#第一部分](../agents/yuanshi.md#第一部分院子管理系统)
**配置文件**: [data/domains.json](../data/domains.json)
**命令**: [commands/domains.md](../commands/domains.md)

院子系统包含：
- 7个标准院子定义（auth, payment, database, search, mq, log, cache）
- 院子属性维护（负责人/技术栈/依赖/组件清单）
- 院子分配法则（技术栈亲和度/依赖检查/负载均衡）

**使用**:
```
@yuanshi list-domains                                    # 列出所有院子
@yuanshi get-domain auth                                 # 查询特定院子
@yuanshi assign-atoms T-AUTH-001                        # 为原子分配院子
@yuanshi check-dependency auth payment                  # 检查院子依赖
@yuanshi validate-coupling T-AUTH-001                   # 检查原子的跨院子耦合
```

**院子配置示例**:
```json
{
  "id": "auth",
  "name": "身份认证",
  "owner": "@auth-owner",
  "tech_stack": ["backend", "oauth", "jwt"],
  "dependencies": ["cache", "db"],
  "components": ["login", "token_refresh", "mfa"]
}
```

---

### ✅ DEFECT-003: 三清会审工作流
**位置**: [agents/yuanshi.md#第二部分](../agents/yuanshi.md#第二部分三清会审流程)
**命令**: [commands/review.md](../commands/review.md)

三清会审包含：
- 会前准备 → 同步会审 → 决议 三阶段流程
- 需求/设计/实现三维度深度评审
- 会审纪要自动生成与决议记录

**使用**:
```
@yuanshi start-review --task T-AUTH-001 --atoms A-001,A-002 --phase design
# 启动会审流程，参会圣人: 准提(Code Review) + 接引(Business Review) + 需求方

@yuanshi get-review --task T-AUTH-001
# 查询会审状态与进展

@yuanshi update-decision --task T-AUTH-001 --decision approved --comments '通过，需补充单测'
# 更新会审决议

@yuanshi list-reviews --status open
# 列出待审任务

@yuanshi schedule-followup --task T-AUTH-001 --date 2024-03-31 --agenda '补充单测评审'
# 安排后续会审
```

**会审纪要存储**: `docs/reviews/{task_id}/minutes.md`

---

### ✅ DEFECT-004: 耦合度矩阵生成
**位置**: [agents/shengongbao.md#第一部分](../agents/shengongbao.md#第一部分耦合度矩阵生成)
**命令**: [commands/analysis.md](../commands/analysis.md#analyze-coupling)

耦合度分析包含：
- 耦合度矩阵计算（行列为atom，值为耦合强度 0-3）
- 耦合类型分类（read/write/contract/timing）
- 高耦合原子识别与风险预警

**使用**:
```
@shengongbao analyze-coupling --task T-AUTH-001
# 生成耦合度矩阵，识别高耦合原子

@shengongbao generate-matrix --task T-AUTH-001 --format html
# 可视化矩阵，支持html/markdown/csv格式

@shengongbao detect-cycles --task T-AUTH-001
# 检测循环依赖（设计缺陷预警）

@shengongbao validate-domains --task T-AUTH-001
# 验证跨域依赖复杂度
```

**耦合矩阵示例**:
```
       A-001  A-002  A-003
A-001    -      0      1
A-002    -      -      2.5  (强耦合)
A-003    -      -      -
```

---

### ✅ DEFECT-005: 开发层级评估
**位置**: [agents/shengongbao.md#第二部分](../agents/shengongbao.md#第二部分开发层级评估)
**命令**: [commands/analysis.md](../commands/analysis.md#assign-levels)

开发层级评估包含：
- L1 (独立可交付，优先启动) - 无入向依赖
- L2 (轻依赖协调，待L1完成) - 依赖 <= 3个L1原子
- L3 (高耦合关键，需协调发布) - 复杂依赖或跨域

**使用**:
```
@shengongbao assign-levels --task T-AUTH-001
# 计算开发层级（L1/L2/L3），输出详细方案

@shengongbao find-critical-path --task T-AUTH-001
# 识别关键路径（决定项目总工期的路径）

@shengongbao estimate-schedule --task T-AUTH-001 --team-size 5
# 基于团队规模估算项目进度
```

**层级分配示例**:
```
L1 (立即启动):
  A-DB-001: 用户表扩展 (0.5d, 独立)
  A-AUTH-002: 令牌续期 (1d, 独立)

L2 (待L1完成):
  A-AUTH-001: OAuth2登录 (2d, 依赖A-DB-001)

L3 (高耦合，需协调):
  A-AUTH-004: SSO (2d, 跨3个域，需多轮会审)
```

---

## 📋 完整工作流程

```
【1】太上老君原子化
  ↓
  @taishang 分析需求，拆分原子并标注属性
  输出: atoms.json (含owner/domain/priority/coupling)
  
【2】元始·院子分配 + 耦合检查
  ↓
  @yuanshi assign-atoms T-001          # 为原子分配院子
  @shengongbao validate-coupling T-001  # 检查跨域耦合
  
【3】元始·三清会审启动
  ↓
  @yuanshi start-review --task T-001 --phase design
  (参会: 准提Code + 接引Business + 需求方)
  输出: docs/reviews/T-001/minutes.md
  
【4】申公豹·耦合度分析 + 层级评估
  ↓
  @shengongbao analyze-coupling --task T-001
  @shengongbao assign-levels --task T-001
  @shengongbao find-critical-path --task T-001
  输出: coupling矩阵、L1/L2/L3分配、进度规划
  
【5】更新会审决议 → 启动开发
  ↓
  @yuanshi update-decision --task T-001 --decision approved
  L1原子立即启动开发，L2待L1完成...
```

---

## 📁 新增文件清单

### Agents
- [agents/taishang.md](../agents/taishang.md) ✏️ 补充原子化执行规则
- [agents/yuanshi.md](../agents/yuanshi.md) ✏️ 补充院子管理与三清会审
- [agents/shengongbao.md](../agents/shengongbao.md) ✏️ 补充耦合度分析与层级评估

### Commands
- [commands/domains.md](../commands/domains.md) ✨ 院子管理命令
- [commands/review.md](../commands/review.md) ✨ 三清会审命令
- [commands/analysis.md](../commands/analysis.md) ✨ 耦合分析命令

### Data
- [data/domains.json](../data/domains.json) ✨ 院子配置表（7个标准院子）

### Documentation
- [docs/IMPLEMENTATION_GAPS.md](../docs/IMPLEMENTATION_GAPS.md) ✨ 详细缺陷分析报告
- [docs/DEFECT_TRACKER.md](../docs/DEFECT_TRACKER.md) ✨ 缺陷追踪表与进度管理
- [docs/reviews/](../docs/reviews/) ✨ 会审纪要存储目录

---

## 🎓 核心概念

### 原子 (Atom)
最小的可独立执行的业务/技术单位，包含：
- atom_id: 唯一标识
- owner: 负责人
- domain: 所属院子
- priority: P0/P1/P2 优先级
- complexity: low/medium/high 复杂度
- coupling: 依赖关系与耦合类型

### 院子 (Domain)
按业务域/技术栈/发布频率组织的协作单元，维护：
- 负责人与支持团队
- 技术栈
- 依赖的其他院子
- 可复用组件清单

### 三清会审 (Three-Pure Review)
由需求/设计/实现三方组成的深度评审：
- 从多维度检查需求完整性、设计可行性、实现质量
- 输出决议与action items
- 支持多轮会审

### 耦合度 (Coupling)
原子间依赖关系的定量表示：
- 强度: 0(无) → 1(弱) → 2(中) → 2.5(强) → 3(极强)
- 类型: read(弱) / contract(中) / write(强) / timing(极强)

### 开发层级 (Level)
基于依赖关系的开发优先级：
- L1: 独立可交付，优先启动
- L2: 轻依赖，待L1完成
- L3: 高耦合，需特殊协调

---

## 🔗 关键链接

- **设计文档**: [docs/review-design.md](../docs/review-design.md)
- **缺陷分析**: [docs/IMPLEMENTATION_GAPS.md](../docs/IMPLEMENTATION_GAPS.md)
- **缺陷追踪**: [docs/DEFECT_TRACKER.md](../docs/DEFECT_TRACKER.md)
- **插件规范**: [.claude-plugin/plugin.json](../.claude-plugin/plugin.json)

---

## ✨ 下一步

1. **测试工作流**：使用示例任务验证端到端流程
2. **补充示例**：在各命令中添加真实案例
3. **性能优化**：优化矩阵计算以支持大规模原子（1000+）
4. **可视化增强**：增加图表展示（依赖拓扑图、甘特图）
5. **自动化集成**：与CI/CD系统集成，自动触发会审

---

核心功能已补全。从原子化、院子管理、三清会审，到耦合度分析、开发层级评估，整套工作流程已形成完整闭环。

去开发吧，诸圣已为汝安排好序次！

