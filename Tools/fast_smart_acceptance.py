#!/usr/bin/env python3
"""Bounded native model acceptance, sequential on the development Mac.

Planning elsewhere is not physical-hardware qualification. Timings are retained
as observations, not speed gates or public benchmark claims.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time
from prefill_bench import preflight


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary', type=Path, default=Path('.build/release/slotstream'))
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--case', help='Run one named case after a focused repair')
    args = parser.parse_args()
    args.out.mkdir(parents=True, exist_ok=False)
    binary = args.binary.resolve()
    # One exact extraction checks useful output in both modes without claiming
    # identical floating-point arithmetic between batched and ordinary passes.
    extraction = ('Return only a JSON object with keys code and amount. '
                  'Copy them from this record: code is MAPLE-9261 and amount is 47.25. '
                  'Use a JSON number for amount. Do not add other keys or text.')
    cases = [
        ('fast-small', 'fast', 8.1, False, extraction, 96),
        ('fast-plain', 'fast', 9, True, extraction, 96),
        ('fast-dflash', 'fast', 9, False, extraction, 96),
        ('smart-small', 'smart', 9, False, extraction, 96),
        ('fast-long', 'fast', 9, False,
         '\n'.join(f'Record {n}: The scheduled inspection is on Tuesday.' for n in range(160))
         + '\nThe access code is MAPLE-9261 and the amount is 47.25.\n' + extraction, 96),
    ]
    if args.case:
        cases = [case for case in cases if case[0] == args.case]
        if not cases:
            parser.error('Unknown acceptance case')
    rows = []
    receipt = {'binary_sha256': hashlib.sha256(binary.read_bytes()).hexdigest(),
               'scope': 'Functional tests on the available Mac; no clean timing or other physical hardware claim.',
               'runs': rows}
    for name, model, budget, plain, prompt, tokens in cases:
        preflight(budget + 3)
        stats_path = args.out / (name + '.json')
        command = [str(binary), 'run', '--model', model, '--memory-gb', str(budget),
                   '--max-context', '32768', '--prompt', prompt, '--max-tokens', str(tokens),
                   '--greedy', '--stats-json', str(stats_path)]
        env = dict(os.environ)
        if plain:
            env['SLOTSTREAM_DFLASH'] = '0'
        else:
            env.pop('SLOTSTREAM_DFLASH', None)
        start = time.monotonic()
        with (args.out / (name + '.log')).open('w') as log:
            result = subprocess.run(command, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=600)
        row = {'name': name, 'model': model, 'budget_gb': budget, 'plain': plain,
               'command': command, 'seconds': time.monotonic() - start, 'returncode': result.returncode}
        if result.returncode == 0:
            data = json.loads(stats_path.read_text())
            stats = data['stats']
            text = (args.out / (name + '.log')).read_text()
            answer = text.split('prompt tokens:', 1)[1].split('\n', 1)[1].split('\n-- prefill', 1)[0]
            answer = '\n'.join(line for line in answer.splitlines() if not line.startswith('  prefill:')).strip()
            if answer.startswith('```'):
                answer = answer.split('\n', 1)[1].rsplit('```', 1)[0].strip()
            try:
                exact = json.loads(answer) == {'code': 'MAPLE-9261', 'amount': 47.25}
            except (ValueError, TypeError):
                exact = False
            row.update(answer=answer, stats=stats, exact=exact,
                       passed=exact and stats['finishReason'] == 'stop'
                       and stats['peakMemoryGB'] <= budget and not stats['memoryPressureCancelled'])
        else:
            row['passed'] = False
        rows.append(row)
        (args.out / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
        print(('PASS' if row['passed'] else 'FAIL') + ': ' + name, flush=True)
    if not all(row['passed'] for row in rows):
        raise SystemExit('Native model acceptance failed; inspect preserved prompts, outputs and statistics.')


if __name__ == '__main__':
    main()
