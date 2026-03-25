# Saints-Workflow 架构优化方案

## 1. 现状分析
Saints-Workflow 是一个深度融合中国神话背景的多 Agent 协作框架。目前采用 8 阶段工作流，通过 CLI 和 Skills 扩展能力。

## 2. 优化目标
- 提升 Agent 协作的灵活性。
- 增强输出质量的稳定性（引入 Self-Reflection）。
- 优化上下文利用率。

## 3. 实施方案
- **动态路由**：在 `tiandao` Agent 中引入任务分发逻辑。
- **自我反思**：为核心 Agent 增加 `verify` 阶段，利用 `hooks/` 进行校验。
- **上下文压缩**：由 `review` Agent 提取关键决策点，减少 Token 消耗。
- **Skills 集成**：建立 Skill 索引，按需挂载。

---
*本方案旨在提升 Saints-Workflow 的工业级协作水平。*