#!/usr/bin/env python3
from __future__ import annotations
import argparse, json, secrets
from datetime import datetime
from pathlib import Path

def build_id():
    return f"{datetime.now().strftime('%Y%m%d-%H%M%S')}-{secrets.token_hex(3)}"

def main():
    ap = argparse.ArgumentParser(description='Send a structured progress report from Codex/Agent.')
    ap.add_argument('--state', required=True, choices=['acknowledged', 'in_progress', 'blocked', 'completed'])
    ap.add_argument('--project', required=True)
    ap.add_argument('--action', default='')
    ap.add_argument('--checking', default='')
    ap.add_argument('--targets', default='')
    ap.add_argument('--risks', default='')
    ap.add_argument('--blocked_on', default='')
    ap.add_argument('--tried', default='')
    ap.add_argument('--needs_action_from', default='')
    ap.add_argument('--out-dir', required=True, help='Directory to write the report JSON')
    
    args = ap.parse_args()
    
    payload = {
        'state': args.state,
        'project': args.project,
        'targets': args.targets,
        'action': args.action,
        'checking': args.checking,
        'risks': args.risks,
        'blocked_on': args.blocked_on,
        'tried': args.tried,
        'needs_action_from': args.needs_action_from
    }
    
    task_id = build_id()
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    
    out = out_dir / f'progress_{args.state}_{task_id}.json'
    
    obj = {
        'ok': True,
        'task_id': task_id,
        'report': payload
    }
    
    out.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({'ok': True, 'task_id': task_id, 'file': str(out)}, ensure_ascii=False))

if __name__ == '__main__': main()
