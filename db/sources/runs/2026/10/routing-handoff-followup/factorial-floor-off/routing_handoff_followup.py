#!/usr/bin/env python3
"""Prospective follow-up: logical-miss lookup costs and controlled inference.

The component mode freezes and links the native probe, then runs immutable
all-hit and logical-miss workloads. Factorial mode compares existing engine
paths with two reference cells bracketing each block; it changes no defaults.
"""
import argparse
import json
import os
from pathlib import Path
import shutil
import statistics
import subprocess

from prefill_bench import ROOT, digest, host_conditions, preflight
from routing_handoff_probe import native, write


def invoke(binary, arguments, out, name, env, required_gb):
    before = preflight(required_gb)
    command = [str(binary), *arguments]
    write(out / (name + '.launch.json'), {'command': command, 'before': before,
          'environment': {k: v for k, v in env.items() if k.startswith('SLOTSTREAM_')}})
    with (out / (name + '.jsonl')).open('x') as stdout, (out / (name + '.stderr.txt')).open('x') as stderr:
        result = subprocess.run(command, env=env, cwd=ROOT, stdout=stdout, stderr=stderr, timeout=180)
    if result.returncode:
        raise RuntimeError(f'{name} exited {result.returncode}; raw failure preserved')
    return [json.loads(line) for line in (out / (name + '.jsonl')).read_text().splitlines()]


def component(out):
    binary = native(out)
    env = {k: v for k, v in os.environ.items() if not k.startswith('SLOTSTREAM_')}
    rows = invoke(binary, ['--mixed-lookup'], out, 'mixed', env, 4)
    cells = [r for r in rows if r['kind'] == 'mixed_timing']
    comparisons = {}
    for ready in [0, 3, 12, 48]:
        comparisons[ready] = {}
        for mode in ['device_checked', 'device_checked_rebuild']:
            ratios = []
            for round_id in range(6):
                pair = {c['mode']: c for c in cells if c['ready_layers'] == ready and c['round'] == round_id}
                if pair['host']['eligible'] and pair[mode]['eligible']:
                    ratios.append(pair['host']['seconds'] / pair[mode]['seconds'])
            comparisons[ready][mode] = {'ratios': ratios, 'eligible_pairs': len(ratios),
                'median_speed_ratio': statistics.median(ratios) if ratios else None}
    summary = {'comparisons': comparisons, 'correctness_checks': len([r for r in rows if r['kind'] == 'mixed_correctness']),
               'limit': 'logical miss/fallback cost; no physical miss I/O or mutable slot ownership'}
    write(out / 'mixed-summary.json', summary)
    print(json.dumps(summary), flush=True)


def factorial(out, binary, prefetch, floor):
    base = {k: v for k, v in os.environ.items() if not k.startswith('SLOTSTREAM_')}
    if prefetch == 'off':
        base['SLOTSTREAM_OPT_EXPERT_PREFETCH'] = '0'
    controls = {
        'reference': {'SLOTSTREAM_OPT_DIRECT_DEMAND': '1'},
        'staged': {'SLOTSTREAM_OPT_DIRECT_DEMAND': '0'},
        'resident': {'SLOTSTREAM_OPT_DIRECT_DEMAND': '0', 'SLOTSTREAM_OPT_RESIDENT_OVERLAP': '1'},
        'shared': {'SLOTSTREAM_OPT_DIRECT_DEMAND': '1', 'SLOTSTREAM_OPT_SHARED_OVERLAP': '1'},
        'reference_repeat': {'SLOTSTREAM_OPT_DIRECT_DEMAND': '1'},
    }
    cells = []
    for round_id in range(4):
        order = list(controls) if round_id % 2 == 0 else list(reversed(controls))
        for arm in order:
            env = {**base, **controls[arm]}
            arguments = ['--model-cell'] + (['--sky'] if round_id % 2 else [])
            if floor: arguments.append('--floor')
            result = invoke(binary, arguments, out, f'r{round_id}-{arm}', env, 12.5 if floor else 14.5)
            assert len(result) == 1 and result[0]['kind'] == 'model_cell'
            cell = {'round': round_id, 'arm': arm, **result[0]}
            cell['eligible'] = (cell['swapins_delta'] == cell['swapouts_delta'] == 0
                and cell['thermal_before'] == cell['thermal_after'] == 'nominal' and cell['normal_power'])
            cells.append(cell)
            print(json.dumps({'round': round_id, 'arm': arm, 'eligible': cell['eligible'],
                'decode_seconds': cell['stats']['decodeSeconds'], 'request_seconds': cell['stats']['requestSeconds'],
                'decode_records': cell['stats']['decodeRecords']}), flush=True)
    comparisons = {}
    for arm in ['reference_repeat', 'staged', 'resident', 'shared']:
        pairs = []
        for round_id in range(4):
            block = {c['arm']: c for c in cells if c['round'] == round_id}
            a, b, c = block['reference'], block['reference_repeat'], block[arm]
            exact = a['output_ids'] == b['output_ids'] == c['output_ids']
            equal_work = all(a['stats'][k] == b['stats'][k] == c['stats'][k]
                             for k in ['decodeTokens', 'decodeRecords', 'prefillRecords', 'decodeForwardPasses'])
            eligible = all(x['eligible'] for x in [a, b, c]) and exact and equal_work
            ratios = {}
            for field in ['decodeSeconds', 'requestSeconds']:
                reference = a['stats'][field] if arm == 'reference_repeat' else (a['stats'][field] + b['stats'][field]) / 2
                ratios[field] = reference / c['stats'][field]
            pairs.append({'round': round_id, 'eligible': eligible, 'exact': exact,
                          'equal_work': equal_work, **ratios})
        qualified = [p for p in pairs if p['eligible']]
        comparisons[arm] = {'pairs': pairs, 'eligible_pairs': len(qualified),
            'medians': {f: statistics.median(p[f] for p in qualified) if qualified else None
                        for f in ['decodeSeconds', 'requestSeconds']}}
    write(out / 'factorial-summary.json', {'comparisons': comparisons, 'prefetch': prefetch,
        'memory_target_gb': 8.1 if floor else 10,
        'limit': 'screen existing paths, two short prompts, plain decode; no adoption or GPU-directory implementation'})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['component', 'factorial'])
    parser.add_argument('--out', required=True, type=Path)
    parser.add_argument('--binary', type=Path)
    parser.add_argument('--prefetch', choices=['off', 'automatic'], default='off')
    parser.add_argument('--floor', action='store_true', help='factorial: fixed 8.1 GB budget instead of 10 GB')
    args = parser.parse_args()
    if args.mode == 'factorial' and (args.binary is None or not args.binary.is_file()):
        parser.error('factorial requires the component executable')
    args.out.mkdir(parents=True, exist_ok=False)
    for name in ['routing_handoff_followup.py', 'routing_handoff_probe.py', 'routing_handoff_probe.swift']:
        shutil.copy2(ROOT / 'Tools' / name, args.out / name)
    write(args.out / 'followup-protocol.json', {
        'mode': args.mode, 'prefetch': args.prefetch, 'rounds': 4 if args.mode == 'factorial' else 6,
        'memory_target_gb': 8.1 if args.floor else 10,
        'binary_sha256': digest(args.binary) if args.binary else None, 'host': host_conditions(),
        'eligibility': 'exact tokens and equal demand records/forward count; zero paging; nominal sampled thermal and normal power',
        'screen': 'minimum 3 eligible blocks; median decode and whole-request ratio >=1.05, at least 3 blocks improve both; reference-repeat median within 2% of 1',
        'reference': 'mean of two reference times bracketing each block; A/A compares reference with repeat directly',
        'limit': 'exploration only; no confirmation, release, M1 or energy claim'})
    try:
        if args.mode == 'component': component(args.out)
        else: factorial(args.out, args.binary.resolve(), args.prefetch, args.floor)
    finally:
        write(args.out / 'followup-host-after.json', host_conditions())


if __name__ == '__main__':
    main()
