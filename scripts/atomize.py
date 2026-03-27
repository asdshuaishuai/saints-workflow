#!/usr/bin/env python3
"""
简单的“太上老君”原子化脚本样例

用法示例:
  python3 scripts/atomize.py --spec specs/example_spec.md --task-id T-1234 --owner @someone

输出: data/atoms/T-1234.json
"""
import argparse
import json
import os
import uuid
from pathlib import Path


def parse_spec_to_atoms(text, owner, task_id):
    atoms = []
    lines = text.splitlines()
    current = None
    for ln in lines:
        ln = ln.strip()
        if not ln:
            continue
        # 标题作为新 atom
        if ln.startswith('## '):
            if current:
                atoms.append(current)
            title = ln[3:].strip()
            current = {
                'id': f"{task_id}-{uuid.uuid4().hex[:8]}",
                'title': title,
                'description': '',
                'owner': owner,
                '院子': '',
                'priority': 'P2',
                'complexity': 'M',
                'estimate': None,
                'coupling_keys': [],
                'acceptance_criteria': []
            }
        elif ln.startswith('- '):
            # 将短列表作为描述或验收标准
            if current:
                current.setdefault('acceptance_criteria', []).append(ln[2:].strip())
            else:
                # 如果还没开始 atom，则创建一个默认 atom
                current = {
                    'id': f"{task_id}-{uuid.uuid4().hex[:8]}",
                    'title': ln[2:][:40],
                    'description': ln[2:].strip(),
                    'owner': owner,
                    '院子': '',
                    'priority': 'P2',
                    'complexity': 'M',
                    'estimate': None,
                    'coupling_keys': [],
                    'acceptance_criteria': []
                }
        else:
            if current:
                desc = current.get('description','')
                if desc:
                    desc += '\n' + ln
                else:
                    desc = ln
                current['description'] = desc
            else:
                # 文本开头未用标题，作为单一 atom
                current = {
                    'id': f"{task_id}-{uuid.uuid4().hex[:8]}",
                    'title': ln[:40],
                    'description': ln,
                    'owner': owner,
                    '院子': '',
                    'priority': 'P2',
                    'complexity': 'M',
                    'estimate': None,
                    'coupling_keys': [],
                    'acceptance_criteria': []
                }

    if current:
        atoms.append(current)

    # 简单去重与序号化
    for i, a in enumerate(atoms, start=1):
        a['seq'] = i

    return atoms


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--spec', required=True, help='路径到 spec markdown 文件')
    p.add_argument('--task-id', required=True, help='任务 id，例如 T-1234')
    p.add_argument('--owner', default='@unknown', help='原子 owner')
    args = p.parse_args()

    spec_path = Path(args.spec)
    if not spec_path.exists():
        print('spec not found:', spec_path)
        raise SystemExit(2)

    text = spec_path.read_text(encoding='utf-8')
    atoms = parse_spec_to_atoms(text, args.owner, args.task_id)

    out_dir = Path('data/atoms')
    out_dir.mkdir(parents=True, exist_ok=True)
    out_path = out_dir / f"{args.task_id}.json"
    out_path.write_text(json.dumps({'task_id': args.task_id, 'atoms': atoms}, ensure_ascii=False, indent=2), encoding='utf-8')

    print('Wrote', out_path)


if __name__ == '__main__':
    main()
