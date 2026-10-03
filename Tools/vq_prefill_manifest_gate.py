#!/usr/bin/env python3
"""Reject corrupted full-prefill reference manifests before model execution.

Only bounded metadata copies change. The valid reference and weight artifacts
are read-only; every rejected case must leave its native output absent.
"""
import argparse
import copy
import hashlib
import json
import os
from pathlib import Path
import subprocess

from context_qualification import quiet_preflight
from vq_fused_reference import bounded


def run(options):
    before = quiet_preflight(13)
    raw = bounded(options.fixture / 'model.json', 2_000_000)
    original = json.loads(raw)
    options.out.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_', 'VQLAB_'))}
    cases = [('profile', 'does not bind the fixed reference profile'),
             ('missing', 'does not bind the fixed reference profile'),
             ('duplicate', 'invalid VQ prefill boundary identity or geometry'),
             ('overflow', 'VQ prefill boundary exceeds its byte bound'),
             ('negative', 'invalid VQ prefill boundary identity or geometry'),
             ('dtype', 'invalid VQ prefill boundary identity or geometry'),
             ('bytes', 'VQ prefill boundary byte count mismatch'),
             ('artifact', 'VQ prefill fixture and checkpoint differ')]
    results = []
    for name, expected in cases:
        root = options.out / name; root.mkdir()
        data = copy.deepcopy(original)
        if name == 'profile': data['profile'] = 'unqualified-other-profile'
        elif name == 'missing': data['boundaries'].pop()
        elif name == 'duplicate': data['boundaries'][-1] = data['boundaries'][0]
        elif name == 'overflow': data['boundaries'][0]['shape'] = [9223372036854775807, 2]
        elif name == 'negative': data['boundaries'][0]['shape'][0] = -1
        elif name == 'dtype': data['boundaries'][0]['dtype'] = 'F64'
        elif name == 'bytes': data['boundaries'][0]['bytes'] += 1
        else: data['artifact']['inventory_sha256'] = '0' * 64
        encoded = json.dumps(data).encode(); (root / 'model.json').write_bytes(encoded)
        output = root / 'native-output'
        command = [str(options.binary), 'quantization-model-check', '--prefill',
                   '--source-directory', str(options.source), '--source-inventory', str(options.inventory),
                   '--fixture-directory', str(root), '--output', str(output)]
        child = subprocess.run(command, env=env, text=True, capture_output=True, timeout=30)
        result = {'case': name, 'command': command, 'returncode': child.returncode,
                  'stdout': child.stdout, 'stderr': child.stderr, 'expected': expected,
                  'manifest_sha256': hashlib.sha256(encoded).hexdigest(),
                  'passed': child.returncode == 1 and expected in child.stderr and not output.exists()}
        results.append(result)
        receipt = {'schema': 1, 'before': before, 'source_manifest_sha256': hashlib.sha256(raw).hexdigest(),
                   'results': results}
        (options.out / 'results.json').write_text(json.dumps(receipt, indent=2) + '\n')
        if not result['passed']:
            raise ValueError('prefill manifest was not rejected before execution: ' + name)
    print(json.dumps({'passed': len(results), 'failed': 0}), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'source', 'inventory', 'fixture', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    args = parser.parse_args()
    for name in ('binary', 'source', 'inventory', 'fixture', 'out'):
        setattr(args, name, getattr(args, name).resolve())
    run(args)
