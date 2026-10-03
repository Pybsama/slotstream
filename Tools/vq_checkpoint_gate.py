#!/usr/bin/env python3
"""Fault injection for experimental VQ checkpoint metadata authentication.

Only metadata is copied. Each case must fail at its expected authentication
boundary before any absent tensor payload can be opened. Sequential children
own the ordinary model lock; no alternative is installed or activated.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess

from context_qualification import quiet_preflight


def run(options):
    before = quiet_preflight(13)
    options.out.mkdir(parents=True, exist_ok=False)
    original = {name: (options.source / name).read_bytes() for name in
                ('config.json', 'model.safetensors.index.json', 'verified.json')}
    if any(len(value) > 4_000_000 for value in original.values()):
        raise ValueError('metadata fault fixture is not bounded')
    env = {k: v for k, v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_', 'VQLAB_'))}
    cases = [('config', 'VQ metadata differs from the pinned inventory: config.json'),
             ('index', 'VQ metadata differs from the pinned inventory: model.safetensors.index.json'),
             ('digest', 'VQ complete-file identities do not match the pinned artifact'),
             ('duplicate', 'VQ complete-file map is missing, duplicated or from another artifact'),
             ('missing-draft-entry', 'VQ complete-file map is missing, duplicated or from another artifact'),
             ('inventory', 'native VQ research loader requires an exact inspected inventory')]
    results = []
    for name, expected in cases:
        root = options.out / name; root.mkdir()
        files = dict(original)
        if name in ('config', 'index'):
            key = 'config.json' if name == 'config' else 'model.safetensors.index.json'
            files[key] += b'\n'
        if name in ('digest', 'duplicate', 'missing-draft-entry'):
            receipt = json.loads(files['verified.json'])
            if name == 'digest': receipt['files'][0]['sha256'] = '0' * 64
            if name == 'duplicate': receipt['files'][-1] = receipt['files'][0]
            if name == 'missing-draft-entry': receipt['files'] = [f for f in receipt['files'] if f['path'] != 'mtp-head-q6.safetensors']
            files['verified.json'] = json.dumps(receipt).encode()
        for filename, data in files.items(): (root / filename).write_bytes(data)
        inventory = options.inventory
        if name == 'inventory':
            inventory = root / 'inventory.json'
            inventory.write_bytes(options.inventory.read_bytes() + b'\n')
        command = [str(options.binary), 'quantization-check', '--source-directory', str(root),
                   '--source-inventory', str(inventory), '--record-fixture-directory', str(options.records)]
        child = subprocess.run(command, env=env, text=True, capture_output=True, timeout=30)
        result = {'case': name, 'command': command, 'returncode': child.returncode, 'stdout': child.stdout,
                  'stderr': child.stderr, 'expected': expected,
                  'passed': child.returncode == 1 and expected in child.stderr,
                  'metadata_sha256': {k: hashlib.sha256(v).hexdigest() for k, v in files.items()}}
        results.append(result)
        (options.out / 'results.json').write_text(json.dumps({'before': before, 'results': results}, indent=2) + '\n')
        if not result['passed']: raise ValueError('metadata failure did not occur at the expected boundary: ' + name)
    print(json.dumps({'passed': len(results), 'failed': 0}), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'source', 'inventory', 'records', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    args = parser.parse_args()
    for name in ('binary', 'source', 'inventory', 'records', 'out'):
        setattr(args, name, getattr(args, name).resolve())
    run(args)
