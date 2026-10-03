#!/usr/bin/env python3
"""Refuse broken greedy fixture chains before native model execution."""
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
    raw = bounded(options.fixture / 'generation.json', 2_000_000)
    original = json.loads(raw)
    profile_raw = bounded(options.profile, 32_000)
    options.out.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_', 'VQLAB_'))}
    cases = [('profile', 'requires the frozen greedy profile'),
             ('token-range', 'does not bind the complete frozen sequence'),
             ('early-eos', 'does not bind the complete frozen sequence'),
             ('consumed', 'does not bind the complete frozen sequence'),
             ('predecessor', 'broken autoregressive chain'),
             ('sample', 'broken autoregressive chain'),
             ('step-order', 'broken autoregressive chain'),
             ('stop', 'inconsistent stop condition'),
             ('duplicate-boundary', 'invalid VQ generated boundary identity or geometry'),
             ('overflow', 'VQ generated boundary exceeds its byte bound'),
             ('artifact', 'VQ generated fixture and checkpoint differ'),
             ('conflicting-modes', '--prefill, --sparse and --greedy are exclusive')]
    results = []
    for name, expected in cases:
        root = options.out / name; root.mkdir()
        data = copy.deepcopy(original); profile = options.profile
        if name == 'profile':
            profile = root / 'profile.json'; profile.write_bytes(profile_raw + b'\n')
        elif name == 'token-range': data['generated'][0] = -1
        elif name == 'early-eos': data['generated'][0] = data['profile']['eos_token_id']
        elif name == 'consumed': data['consumed_tokens'] += 1
        elif name == 'predecessor': data['steps'][1]['input_ids'] = [(data['generated'][0] + 1) % 248320]
        elif name == 'sample': data['steps'][0]['sampled'] = (data['generated'][0] + 1) % 248320
        elif name == 'step-order': data['steps'][1]['step'] = 0
        elif name == 'stop': data['stop'] = 'inconsistent'
        elif name == 'duplicate-boundary': data['steps'][0]['boundaries'][-1] = data['steps'][0]['boundaries'][0]
        elif name == 'overflow': data['steps'][0]['boundaries'][0]['shape'] = [9223372036854775807, 2]
        elif name == 'artifact': data['artifact']['inventory_sha256'] = '0' * 64
        encoded = json.dumps(data).encode(); (root / 'generation.json').write_bytes(encoded)
        output = root / 'native-output'
        command = [str(options.binary), 'quantization-model-check', '--greedy', '--generation-profile', str(profile),
                   '--source-directory', str(options.source), '--source-inventory', str(options.inventory),
                   '--fixture-directory', str(root), '--output', str(output)]
        if name == 'conflicting-modes': command.append('--prefill')
        child = subprocess.run(command, env=env, text=True, capture_output=True, timeout=30)
        result = {'case': name, 'command': command, 'returncode': child.returncode,
                  'stdout': child.stdout, 'stderr': child.stderr, 'expected': expected,
                  'manifest_sha256': hashlib.sha256(encoded).hexdigest(),
                  'passed': child.returncode in (1, 64) and expected in child.stderr and not output.exists()}
        results.append(result)
        receipt = {'schema': 1, 'before': before, 'source_manifest_sha256': hashlib.sha256(raw).hexdigest(), 'results': results}
        (options.out / 'results.json').write_text(json.dumps(receipt, indent=2) + '\n')
        if not result['passed']: raise ValueError('greedy fixture not rejected before execution: ' + name)
    print(json.dumps({'passed': len(results), 'failed': 0}), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'source', 'inventory', 'fixture', 'profile', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    args = parser.parse_args()
    for name in ('binary', 'source', 'inventory', 'fixture', 'profile', 'out'):
        setattr(args, name, getattr(args, name).resolve())
    run(args)
