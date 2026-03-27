#!/usr/bin/env python3
"""
简单的天道调度器样例：扫描 `data/atoms` 中的 atoms，按策略选取待审查任务，生成 review job

用法：
  python3 scripts/tiandao_scheduler.py --run-once

输出：`data/reviews/jobs.json`（列表）和 `data/reviews/{task_id}/job-{id}.json`
"""
import json
import os
import argparse
from pathlib import Path
from datetime import datetime
import uuid


def load_atoms(folder='data/atoms'):
    p = Path(folder)
    atoms = []
    if not p.exists():
        return atoms
    for f in p.glob('*.json'):
        try:
            j = json.loads(f.read_text(encoding='utf-8'))
            atoms.append(j)
        except Exception:
            continue
    return atoms


def select_tasks(atoms):
    # 简单策略：选择 priority 为 P0 或 P1 的任务；若无优先级则采样长任务
    jobs = []
    for t in atoms:
        task_id = t.get('task_id')
        atoms_list = t.get('atoms', [])
        # if any atom has priority P0/P1, schedule
        schedule = False
        for a in atoms_list:
            if a.get('priority') in ('P0', 'P1'):
                schedule = True
                break
            # 长描述或多验收条目判定为高风险
            if len(a.get('acceptance_criteria', [])) >= 3:
                schedule = True
        if schedule:
            jobs.append({'task_id': task_id, 'atoms': [a['id'] for a in atoms_list]})
    return jobs


def write_job(task_id, payload, out_base='data/reviews'):
    base = Path(out_base)
    base.mkdir(parents=True, exist_ok=True)
    task_dir = base / task_id
    task_dir.mkdir(parents=True, exist_ok=True)
    job_id = uuid.uuid4().hex[:8]
    job = {
        'job_id': job_id,
        'task_id': task_id,
        'payload': payload,
        'created_at': datetime.utcnow().isoformat() + 'Z'
    }
    out = task_dir / f'job-{job_id}.json'
    out.write_text(json.dumps(job, ensure_ascii=False, indent=2), encoding='utf-8')
    return job


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--run-once', action='store_true', help='扫描一次并生成 job')
    args = p.parse_args()

    atoms = load_atoms()
    jobs = select_tasks(atoms)

    out = Path('data/reviews')
    out.mkdir(parents=True, exist_ok=True)
    jobs_list = []
    for j in jobs:
        job = write_job(j['task_id'], j)
        jobs_list.append(job)

    jobs_path = out / 'jobs.json'
    jobs_path.write_text(json.dumps(jobs_list, ensure_ascii=False, indent=2), encoding='utf-8')
    print('Wrote', jobs_path)


if __name__ == '__main__':
    main()
