# 天道命令说明

`tiandao` 调度器负责按策略抽样任务并触发西方双审。仓库中提供了两个示例脚本：

- `scripts/tiandao_scheduler.py`：扫描 `data/atoms` 并生成 `data/reviews/job-*.json` 与 `data/reviews/jobs.json`。
- `scripts/review_agent.py`：接收 job 文件并模拟生成审查结果 `review-*.json`。

示例：

```bash
python3 scripts/tiandao_scheduler.py --run-once
ls data/reviews/T-1234
python3 scripts/review_agent.py data/reviews/T-1234/job-<id>.json
```

后续可以将 `tiandao_scheduler.py` 以 Cron 任务运行，并把 `review_agent.py` 替换为实际的审查执行实现（调用准提道人/接引道人 agent）。

GitHub Actions 示例：仓库已提供一个示例工作流 `.github/workflows/tiandao.yml`，会定期运行调度器并将 `data/reviews` 上传为构件。可在 GitHub Actions 页面查看运行结果并下载审查产物。
---
description: 天道 · 洪荒至高监管者，因果循环，拨乱反正
---

# 天道 · 因果监察

> 天道无亲，常与善人。
> 吾乃天道，今日降临，监察因果。

## 执行

召唤天道进行因果监察：

```
Task(tiandao)
```

## 天道法眼

| 检测项 | 触发条件 | 天罚 |
|--------|---------|------|
| 懈怠之罪 | 停滞 > 5分钟 | 雷罚催促 |
| 轮回之困 | 重复 > 3次 | 斩断轮回 |
| 迷途之惑 | 犹豫 > 2次 | 天音指路 |
| 停滞之劫 | 无进展 > 10分钟 | 简化渡劫 |

## 输出

- 因果监察报告
- 异常检测
- 干预决策
