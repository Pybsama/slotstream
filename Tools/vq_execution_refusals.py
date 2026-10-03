#!/usr/bin/env python3
"""Exercise execution-source binding at the actual native diagnostic boundaries.

Only small metadata is copied. Deliberately absent source paths ensure no
weight payload can be opened even if a guard regresses. These are refusal
fixtures, never numerical references or artifact admission evidence.
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

SMALL = '4f63194dec2e4c3bec31289d6503cc7c886685e16e7c4aac58116d4cf0c7f037'
REVIEWED = '1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8'
OLDER = '36de8d6ba21ff93ac3de2994eed4fd59e9cfab86b1908f72f5ee2673bd0aa5bb'


def run(options):
    before = quiet_preflight(13)
    options.out.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items()
           if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_', 'VQLAB_'))}
    cases = []
    for kind in ('records', 'greedy', 'sparse', 'model'):
        filename = 'records.json' if kind == 'records' else 'generation.json' if kind == 'greedy' else 'model.json'
        raw = bounded(getattr(options, kind) / filename, 2_000_000)
        base = json.loads(raw)
        base['artifact']['inventory_sha256'] = SMALL
        base['runtime_sha256'] = REVIEWED
        base['execution_profile'] = {'schema': 1, 'mode': 'explicit-reviewed-v1',
            'bundled_runtime_sha256': OLDER, 'runtime_sha256': REVIEWED}
        if kind == 'records':
            assert len(base['fixtures']) == 2 and {f['layer'] for f in base['fixtures']} == {0, 2}
            base['layer_coverage'] = 'allocation-classes-v1'
            last = copy.deepcopy(base['fixtures'][1]); last['layer'] = 27; last['path'] = 'record-27.safetensors'
            base['fixtures'].append(last)
        for failure in ('missing-profile', 'wrong-schema', 'wrong-mode', 'wrong-bundle', 'wrong-execution'):
            value = copy.deepcopy(base)
            if failure == 'missing-profile':
                del value['execution_profile']
                expected = 'VQ reference requires its explicit reviewed execution profile'
            else:
                key, bad = {'wrong-schema': ('schema', 2), 'wrong-mode': ('mode', 'bundled-reviewed-v1'),
                    'wrong-bundle': ('bundled_runtime_sha256', REVIEWED),
                    'wrong-execution': ('runtime_sha256', OLDER)}[failure]
                value['execution_profile'][key] = bad
                expected = 'VQ reference execution profile does not bind the reviewed source'
            cases.append((kind, filename, failure, value, expected, hashlib.sha256(raw).hexdigest()))
        if kind == 'records':
            for failure in ('missing-class', 'legacy-coverage'):
                value = copy.deepcopy(base)
                if failure == 'missing-class':
                    value['fixtures'].pop()
                    expected = 'VQ record fixtures need the pinned runtime and specified layer set'
                else:
                    del value['layer_coverage']
                    expected = 'VQ 2.1 fixtures require all three allocation classes'
                cases.append((kind, filename, failure, value, expected, hashlib.sha256(raw).hexdigest()))
    results = []
    for kind, filename, failure, value, expected, original_hash in cases:
        root = options.out / (kind + '-' + failure); root.mkdir()
        payload = (json.dumps(value, indent=2) + '\n').encode(); (root / filename).write_bytes(payload)
        if kind == 'records':
            command = [str(options.binary), 'quantization-check', '--record-fixture-directory', str(root)]
        else:
            command = [str(options.binary), 'quantization-model-check', '--fixture-directory', str(root),
                '--source-directory', str(root / 'absent-source'), '--source-inventory', str(root / 'absent-inventory.json'),
                '--output', str(root / 'output')]
            if kind != 'model': command += ['--' + kind]
            if kind == 'greedy': command += ['--generation-profile', str(options.profile)]
        child = subprocess.run(command, env=env, text=True, capture_output=True, timeout=30)
        row = {'kind': kind, 'case': failure, 'command': command, 'returncode': child.returncode,
            'expected': expected, 'stdout': child.stdout, 'stderr': child.stderr,
            'passed': child.returncode == 1 and expected in child.stderr and not (root / 'output').exists(),
            'original_metadata_sha256': original_hash, 'mutated_metadata_sha256': hashlib.sha256(payload).hexdigest()}
        results.append(row)
        (options.out / 'results.json').write_text(json.dumps({'before': before, 'results': results}, indent=2) + '\n')
        if not row['passed']:
            raise ValueError('execution identity guard did not refuse at the expected boundary: ' + kind + '/' + failure)
    print(json.dumps({'passed': len(results), 'failed': 0}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for key in ('binary', 'records', 'greedy', 'sparse', 'model', 'profile', 'out'):
        parser.add_argument('--' + key, type=Path, required=True)
    options = parser.parse_args()
    for key, value in vars(options).items(): setattr(options, key, value.resolve())
    run(options)
