#!/usr/bin/env python3
"""
一键流水线：原子化 -> 调度 -> 审查（示例）

用法示例：
  python3 scripts/run_pipeline.py --spec specs/example_spec.md --task-id T-1234 --owner @someone --clean

选项：
  --skip-review 只运行到生成 job，不执行审查代理
  --clean 清理旧的 review 目录（对应 task_id）后再运行
"""
import argparse
import subprocess
import sys
import shutil
from pathlib import Path


def run_cmd(cmd):
    print('>',' '.join(cmd))
    p = subprocess.run(cmd)
    if p.returncode != 0:
        print('Command failed:', cmd)
        raise SystemExit(p.returncode)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--spec', required=True)
    p.add_argument('--task-id', required=True)
    p.add_argument('--owner', default='@unknown')
    p.add_argument('--skip-review', action='store_true')
    p.add_argument('--clean', action='store_true')
    args = p.parse_args()

    task_dir = Path('data/reviews') / args.task_id
    if args.clean and task_dir.exists():
        print('Cleaning', task_dir)
        shutil.rmtree(task_dir)

    # 1. 原子化
    run_cmd(['python3', 'scripts/atomize.py', '--spec', args.spec, '--task-id', args.task_id, '--owner', args.owner])

    # 2. 调度（生成 job）
    run_cmd(['python3', 'scripts/tiandao_scheduler.py', '--run-once'])

    # 3. 审查代理（可选）
    if not args.skip_review:
        if not task_dir.exists():
            print('No jobs generated for', args.task_id)
            return
        jobs = sorted(task_dir.glob('job-*.json'))
        if not jobs:
            print('No job files found for', args.task_id)
            return
        for j in jobs:
            run_cmd(['python3', 'scripts/review_agent.py', str(j)])

    print('Pipeline completed for', args.task_id)


if __name__ == '__main__':
    main()
