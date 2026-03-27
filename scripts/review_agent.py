#!/usr/bin/env python3
"""
简单的审查代理样例：接收 job json，生成审查结果（模拟）

用法：
  python3 scripts/review_agent.py data/reviews/T-1234/job-xxxx.json
"""
import json
import sys
from pathlib import Path
from datetime import datetime
import uuid


def run_job(job_path):
    p = Path(job_path)
    if not p.exists():
        print('job not found', job_path)
        return 2
    j = json.loads(p.read_text(encoding='utf-8'))
    task_id = j.get('task_id')
    review = {
        'review_id': uuid.uuid4().hex[:8],
        'task_id': task_id,
        'job_id': j.get('job_id'),
        'status': 'approved',
        'notes': '自动审查通过（示例）',
        'reviewed_at': datetime.utcnow().isoformat() + 'Z'
    }
    out_dir = p.parent
    out_path = out_dir / f'review-{review["review_id"]}.json'
    out_path.write_text(json.dumps(review, ensure_ascii=False, indent=2), encoding='utf-8')
    print('Wrote review', out_path)
    return 0


def main():
    if len(sys.argv) < 2:
        print('Usage: review_agent.py <job.json>')
        raise SystemExit(2)
    raise SystemExit(run_job(sys.argv[1]))


if __name__ == '__main__':
    main()
