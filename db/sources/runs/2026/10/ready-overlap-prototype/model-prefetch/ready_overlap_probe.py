#!/usr/bin/env python3
"""Prospective screen of earlier ready-ticket compute and joined CPU copies.

Uses the normal prefetch scheduler. Its read counts may change with timing;
they are reported as outcomes, not held equal as in the prefetch-off study.
The protocol and all raw cells are preserved before any summary is written.
"""
import argparse
import json
import os
from pathlib import Path
import shutil
import statistics

from prefill_bench import ROOT, digest, host_conditions
from routing_handoff_probe import native, write
from routing_handoff_followup import invoke


def run(out, binary):
    base = {k: v for k, v in os.environ.items() if not k.startswith('SLOTSTREAM_')}
    arms = {
        'reference': (False, []),
        'resident_staged': (True, []),
        'ready_staged': (True, ['--ready-tickets']),
        'ready_direct': (True, ['--ready-tickets', '--joined-copies']),
        'reference_repeat': (False, []),
    }
    write(out / 'protocol.json', {
        'binary_sha256': digest(binary), 'rounds': 4, 'arms': list(arms),
        'budget_gb': 10, 'tokens': 64, 'prefetch': 'automatic, required active', 'mtp': 'off', 'vision': 'off',
        'warmup': 'one unscored reference request for each prompt, preserved separately',
        'memory_gate': '13 GB reclaimable at launcher and independently inside native process before loading: fixed 10 GB target plus 3 GB spare',
        'host': host_conditions(),
        'eligibility': 'exact output IDs, prompt, planned pool and forward/token counts; zero global paging; nominal sampled thermal; normal power',
        'disk_work': 'prefetch timing is part of the treatment; demand/adoption/prefetch counts are reported, not equal-work gates',
        'screen': 'at least 3 eligible blocks, median decode and request ratios >=1.05, at least 3 blocks improve both, A/A median within 2% of one',
        'reference': 'mean of bracketing references; A/A compares the two reference cells directly',
        'limits': 'exploratory M5 Pro screen; no release, frequency, energy, M1 or hardware-portability claim',
    })
    for prompt in ['hash', 'sky']:
        result = invoke(binary, ['--model-cell'] + (['--sky'] if prompt == 'sky' else []),
            out, f'warmup-{prompt}', {**base, 'SLOTSTREAM_OPT_RESIDENT_OVERLAP': '0',
            'SLOTSTREAM_OPT_DIRECT_DEMAND': '1'}, 13)
        assert result[0]['plan']['decode_lookahead'] and result[0]['stats'].get('expertPrefetch', {}).get('mode') == 'on', 'prefetch was not exercised'
    cells = []
    for round_id in range(4):
        order = list(arms) if round_id % 2 == 0 else list(reversed(arms))
        for arm in order:
            overlap, flags = arms[arm]
            env = {**base, 'SLOTSTREAM_OPT_RESIDENT_OVERLAP': str(int(overlap)),
                   'SLOTSTREAM_OPT_DIRECT_DEMAND': '1'}
            arguments = ['--model-cell', *flags] + (['--sky'] if round_id % 2 else [])
            result = invoke(binary, arguments, out, f'r{round_id}-{arm}', env, 13)
            assert len(result) == 1 and result[0]['kind'] == 'model_cell'
            cell = {'round': round_id, 'arm': arm, **result[0]}
            assert cell['plan']['decode_lookahead'] and cell['stats'].get('expertPrefetch', {}).get('mode') == 'on', 'prefetch was not exercised'
            if arm in ['ready_staged', 'ready_direct']:
                assert cell['ready_ticket_prelaunch_records'] > 0, 'ready-ticket path was not exercised'
            if arm == 'ready_direct':
                assert cell['overlap_direct_batches'] > 0, 'joined-copy path was not exercised'
            cell['eligible'] = (cell['swapins_delta'] == cell['swapouts_delta'] == 0
                and cell['thermal_before'] == cell['thermal_after'] == 'nominal' and cell['normal_power'])
            cells.append(cell)
            print(json.dumps({k: cell[k] for k in ['round', 'arm', 'eligible',
                'ready_ticket_prelaunch_records', 'overlap_direct_batches']} | {
                'decode_seconds': cell['stats']['decodeSeconds'],
                'request_seconds': cell['stats']['requestSeconds'],
                'decode_records': cell['stats']['decodeRecords']}), flush=True)
    comparisons = {}
    for arm in list(arms)[1:]:
        pairs = []
        for round_id in range(4):
            block = {c['arm']: c for c in cells if c['round'] == round_id}
            a, b, c = block['reference'], block['reference_repeat'], block[arm]
            exact = a['output_ids'] == b['output_ids'] == c['output_ids']
            equal_forward_work = all(a['stats'][k] == b['stats'][k] == c['stats'][k]
                for k in ['decodeTokens', 'prefillTokens', 'decodeForwardPasses', 'prefillRecords'])
            equal_prompt = a['prompt_ids'] == b['prompt_ids'] == c['prompt_ids']
            # The whole planner JSON includes transient available-memory fields.
            equal_pool = a['plan']['pool_slots'] == b['plan']['pool_slots'] == c['plan']['pool_slots']
            eligible = all(x['eligible'] for x in [a, b, c]) and exact and equal_forward_work and equal_prompt and equal_pool
            ratios = {}
            for field in ['decodeSeconds', 'requestSeconds']:
                reference = a['stats'][field] if arm == 'reference_repeat' else (a['stats'][field] + b['stats'][field]) / 2
                ratios[field] = reference / c['stats'][field]
            pairs.append({'round': round_id, 'eligible': eligible, 'exact': exact,
                'equal_forward_work': equal_forward_work, 'equal_pool': equal_pool, 'equal_prompt': equal_prompt, **ratios})
        qualified = [p for p in pairs if p['eligible']]
        comparisons[arm] = {'pairs': pairs, 'eligible_pairs': len(qualified),
            'medians': {f: statistics.median(p[f] for p in qualified) if qualified else None
                        for f in ['decodeSeconds', 'requestSeconds']},
            'positive_blocks': sum(all(p[f] > 1 for f in ['decodeSeconds', 'requestSeconds']) for p in qualified)}
    aa = comparisons['reference_repeat']
    for arm, result in comparisons.items():
        result['passes_screen'] = (arm != 'reference_repeat' and result['eligible_pairs'] >= 3
            and result['positive_blocks'] >= 3 and all(v is not None and v >= 1.05 for v in result['medians'].values())
            and aa['eligible_pairs'] >= 3 and all(v is not None and abs(v - 1) <= .02 for v in aa['medians'].values()))
    write(out / 'summary.json', {'comparisons': comparisons})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['compile', 'model'])
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--binary', type=Path)
    args = parser.parse_args()
    if args.mode == 'model' and (args.binary is None or not args.binary.is_file()):
        parser.error('model requires the freshly compiled native probe')
    args.out.mkdir(parents=True, exist_ok=False)
    for name in ['ready_overlap_probe.py', 'routing_handoff_probe.py', 'routing_handoff_probe.swift', 'routing_handoff_followup.py']:
        shutil.copy2(ROOT / 'Tools' / name, args.out / name)
    try:
        if args.mode == 'compile': print(native(args.out, compile_only=True), flush=True)
        else: run(args.out, args.binary.resolve())
    finally:
        write(args.out / 'host-after.json', host_conditions())


if __name__ == '__main__':
    main()
