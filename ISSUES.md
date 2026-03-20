# 已知问题

## V2.0 更新说明

### 已完成的变更

1. **组织架构重构**
   - 引入新的分组机制：需求分析组、阐教、截教、测试修复组、西方教
   - 太清天尊 -> 太上老君（需求分析组组长）
   - lingbao -> tongtian（截教掌教）

2. **新增 Agents**
   - taishang (太上老君) - 需求分析总控
   - guangchengzi (广成子) - 阐教金仙之首
   - tongtian (通天教主) - 截教掌教，对抗性开发
   - yunxiao (云霄娘娘) - 接口设计
   - qiongxiao (琼霄娘娘) - 业务逻辑
   - bixiao (碧霄娘娘) - 前端实现
   - zhaogongming (赵公明) - 数据存储
   - duobao (多宝道人) - 核心架构
   - jieyin (接引道人) - 业务审查

3. **职责变更**
   - fuxi (伏羲)：方案增强 -> 漏洞探查测试
   - nva (女娲)：测试验证 -> 补天修复
   - puti (准提道人)：综合审查 -> 代码审查

4. **新增 Commands**
   - 所有新 Agent 对应的 Command

5. **删除的 Agents/Commands**
   - taiqing -> taishang（替换）
   - lingbao -> tongtian（替换）

### 待验证

- [ ] 确保所有 Agent 的 Task() 调用正确
- [ ] 验证 workflow 流程完整性
- [ ] 测试阐截对抗机制

---

## 历史问题

### 2026-03-13: 本地插件加载失败

已在 V1.2.0 中解决，使用 `saints-workflow-local` 作为插件标识。
