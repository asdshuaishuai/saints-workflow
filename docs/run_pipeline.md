# 一键流水线说明

本文件说明如何使用 `scripts/run_pipeline.py` 在本地运行完整样例流水线：原子化 -> 调度 -> 审查。

示例：

```bash
python3 scripts/run_pipeline.py --spec specs/example_spec.md --task-id T-1234 --owner @someone --clean
```

选项：
- `--skip-review`：只执行到生成 job，不运行审查代理
- `--clean`：清理 `data/reviews/{task_id}` 后再运行

产物：
- 原子化：`data/atoms/{task_id}.json`
- 审查作业：`data/reviews/{task_id}/job-*.json`
- 审查结果：`data/reviews/{task_id}/review-*.json`

该脚本为示例流水线，适合本地验证。可根据实际需求替换 `review_agent.py`，以接入真正的准提道人/接引道人审查逻辑。
