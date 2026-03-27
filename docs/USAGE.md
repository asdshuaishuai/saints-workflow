# 使用说明（快速上手）

本文档演示如何在本仓库本地运行审查流程样例：原子化（太上老君）、天道调度与西方双审代理的运行与调试步骤。

## 前提
- 本地安装 Python 3.8+，并能运行 `python3`。
- 仓库已克隆到本地：`git clone <repo>` 并切换到仓库根目录。

## 快速步骤（示例）

1. 将需求写为 Markdown spec，例如 `specs/example_spec.md`（仓库已包含示例）。

2. 运行原子化脚本生成 atoms（示例任务 id `T-1234`）：

```bash
python3 scripts/atomize.py --spec specs/example_spec.md --task-id T-1234 --owner @someone
```

输出：`data/atoms/T-1234.json`。

3. 运行 `天道` 调度器（一次性扫描并生成 job）：

```bash
python3 scripts/tiandao_scheduler.py --run-once
```

输出：`data/reviews/jobs.json` 和 `data/reviews/{task_id}/job-*.json`。

4. 使用审查代理处理 job（示例为自动模拟通过）：

```bash
python3 scripts/review_agent.py data/reviews/T-1234/job-<id>.json
```

输出：`data/reviews/T-1234/review-*.json`。

## 本地调试建议
- 若想重复运行，请清理 `data/reviews` 或使用不同 `task_id`。
- 脚本为样例实现，可替换 `review_agent.py` 来接入实际审查逻辑（调用准提道人/接引道人 agent）。

## 集成建议
- 项目当前不包含 CI 自动调度（按仓库策略保留开发/测试/审查阶段）。如需周期性本地运行，可使用系统 `cron` 或外部调度器运行 `scripts/tiandao_scheduler.py`。

## 产物存放约定
- 原子化输出：`data/atoms/{task_id}.json`
- 审查作业：`data/reviews/{task_id}/job-*.json`
- 审查结果：`data/reviews/{task_id}/review-*.json`

## 下一步（可选）
- 将原子化脚本封装为命令行工具并添加参数校验
- 实现耦合度矩阵生成器并加入 `docs/reviews/{task_id}/`
- 集成真正的 `西方双审` agent（准提道人/接引道人）以替换模拟审查
