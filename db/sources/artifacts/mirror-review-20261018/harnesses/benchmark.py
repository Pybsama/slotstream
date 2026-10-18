#!/usr/bin/env python3
"""Frozen six-round, three-arm mirror comparison; all permutations, no retries."""
import hashlib
import itertools
import json
import os
import plistlib
import re
from pathlib import Path
import statistics
import subprocess
import sys
import time
import threading

ROOT = Path('/Volumes/external/slotstream')
OUT = Path('/Volumes/external/review-evidence/benchmark')
BINARY = ROOT / '.build/release/slotstream'
EXTERNAL = Path('/Volumes/external/model')
INTERNAL = Path('/Volumes/internal/model')
sys.path.insert(0, str(ROOT / 'Tools'))
from prefill_bench import digest, vm_snapshot, host_conditions, validate_metrics, run_child, model_identity, terminate_child_tree
from context_qualification import quiet_preflight, verification_lock
from memory_gate import check_memory
from thermal_readiness import observe
from serve_bench import verified_build


def dump(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def auxiliary_identity(directory):
    return {str(path.relative_to(directory)): {'bytes': path.stat().st_size, 'sha256': digest(path)}
            for path in sorted(directory.rglob('*.safetensors')) if path.parent != directory}


def timed_child(command, env, cell):
    # Observe the public CLI's first output as well as its internal token clock.
    # All startup banners/progress are on stderr; stdout is generated text.
    with (cell / 'stdout.txt').open('wb') as output, (cell / 'stderr.txt').open('wb') as errors:
        stamps = {'started_ns': time.monotonic_ns(), 'first_output_ns': None}
        child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=subprocess.PIPE,
                                 stderr=errors, start_new_session=True)
        def read_output():
            while True:
                data = os.read(child.stdout.fileno(), 65536)
                if not data:
                    break
                if stamps['first_output_ns'] is None:
                    stamps['first_output_ns'] = time.monotonic_ns()
                output.write(data)
        reader = threading.Thread(target=read_output)
        reader.start()
        try:
            code = child.wait(timeout=900)
        finally:
            if child.poll() is None:
                terminate_child_tree(child)
            stamps['exited_ns'] = time.monotonic_ns()
            reader.join(timeout=5)
            child.stdout.close()
            dump(cell / 'process-timing.json', stamps)
            if reader.is_alive():
                raise RuntimeError('stdout reader did not finish')
    first = None if stamps['first_output_ns'] is None else (stamps['first_output_ns']-stamps['started_ns'])/1e9
    return code, (stamps['exited_ns']-stamps['started_ns'])/1e9, first


def main():
    OUT.mkdir(exist_ok=False)
    os.chdir(ROOT)
    head = subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
    sha = digest(BINARY)
    build = verified_build(BINARY)
    from build_identity import source_files, sha as source_sha
    assert {str(p.relative_to(ROOT)): source_sha(p) for p in source_files(ROOT)} == build['identity']['source'], 'source differs from compiled image'
    env = {k: v for k, v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_'))}
    repeated = OUT / 'repeated.txt'
    repeated.write_text('The sky appears blue because molecules in the atmosphere scatter sunlight. ' * 96 + '\n\nExplain the physics of why the daytime sky is blue and sunsets are red. Write a detailed answer of at least 500 words, covering Rayleigh scattering, wavelength dependence, the path through the atmosphere, and the role of aerosols. Use complete paragraphs.')
    prose = OUT / 'prose.txt'
    original = (ROOT / 'Tools/fixtures/optimization/prose.txt').read_text()
    prose.write_text(original.replace('Explain the main engineering lessons from this account in three sentences.', 'Write a detailed analysis of at least 500 words explaining the engineering lessons from this account, including missing data, clock selection, traceable measurements, memory reuse, and numerical equivalence. Use complete paragraphs with concrete examples.'))
    profiles = [{'name': f'{name}-{mtp}', 'prompt': str(prompt), 'mtp': mtp, 'memory_gb': budget}
                for name, prompt in [('repeated', repeated), ('prose', prose)]
                for mtp, budget in [('off', 10), ('on', 12)]]
    order = [['external', 'internal', 'both'], ['both', 'internal', 'external'],
             ['internal', 'both', 'external'], ['external', 'both', 'internal'],
             ['both', 'external', 'internal'], ['internal', 'external', 'both']]
    assert set(map(tuple, order)) == set(itertools.permutations(['external', 'internal', 'both']))
    protocol = {'schema': 1, 'head': head, 'binary_sha256': sha,
                'upstream': '159b43e', 'profiles': profiles, 'round_order': order,
                'warmup_order': ['external', 'internal', 'both'], 'max_tokens': 128,
                'context': 32768, 'vision': 'off', 'greedy': True,
                'sampling_ms': 20, 'per_run_timeout_seconds': 900,
                'cache_policy': 'Fresh process and application caches each run; OS file cache not flushed or controlled.',
                'eligibility': 'Exact prompt/output IDs and text; equal effective pool, prefill chunk, MTP and optimizations within each triplet; complete 128-token output; process peak within budget; nominal thermals, low-power off, and no global swap counter increase across the process for clean timing. Preserve every failure and excluded result. No retries or selection of best runs.',
                'timing': 'ttft = Generator entry to first sampled non-EOS token; first_text = Engine entry to first nonempty decoded callback; request = generation request including prefill/decode but excluding model loading; process_first_text = process launch to first stdout bytes observed by the harness; process_wall includes model loading, generation and process exit.',
                'comparison': 'Separate arm medians and paired ratios. Each round compares both against each single disk and the faster of the two singles for that metric. Report positive-round counts and full ranges; no assumed winning disk.',
                'scope': 'One M4 Mac mini, identical original checkpoint copies, these prompts and explicit budgets. MTP comparisons change memory budget and are not MTP speedup claims.'}
    dump(OUT / 'protocol.json', protocol)
    (OUT / 'harness.py').write_bytes(Path(__file__).read_bytes())
    dump(OUT / 'host-before.json', host_conditions())
    # Physical backing must differ, including APFS synthesized vs physical IDs.
    for name, directory in [('external', EXTERNAL), ('internal', INTERNAL)]:
        device = subprocess.check_output(['df', '-P', str(directory)], text=True).splitlines()[-1].split()[0]
        subprocess.run(['diskutil', 'info', '-plist', device], check=True,
                       stdout=(OUT / f'{name}-disk.plist').open('wb'))
    apfs = plistlib.loads(subprocess.check_output(['diskutil', 'apfs', 'list', '-plist']))
    topology = {}
    for name in ['external', 'internal']:
        info = plistlib.loads((OUT / f'{name}-disk.plist').read_bytes())
        volume = info['DeviceIdentifier']
        container = next(c for c in apfs['Containers']
                         if any(v['DeviceIdentifier'] == volume for v in c['Volumes']))
        stores = container['PhysicalStores']
        topology[name] = {'volume': volume, 'physical_stores': [
                             {key: store[key] for key in ['DeviceIdentifier', 'Size'] if key in store}
                             for store in stores],
                          'physical_disks': sorted({re.sub(r's[0-9]+$', '', x['DeviceIdentifier']) for x in stores})}
    assert not set(topology['external']['physical_disks']) & set(topology['internal']['physical_disks']), 'copies share a physical disk'
    dump(OUT / 'disk-topology.json', topology)
    rows, triplets, summaries = [], [], []

    def save():
        dump(OUT / 'runs.json', rows)
        dump(OUT / 'triplets.json', triplets)
        dump(OUT / 'summary.json', summaries)

    def launch(profile, arm, round_number):
        label = f"{profile['name']}-{'warmup' if round_number == 0 else 'r'+str(round_number)}-{arm}"
        cell = OUT / label
        cell.mkdir()
        vm_before = quiet_preflight(profile['memory_gb'] + 3)
        thermal = observe()
        if not thermal['ready']:
            raise RuntimeError('non-nominal conditions before ' + label)
        model = INTERNAL if arm == 'internal' else EXTERNAL
        command = [str(BINARY), 'run', '--model', str(model), '--max-context', '32768',
                   '--max-tokens', '128', '--greedy', '--vision', 'off',
                   '--memory-gb', str(profile['memory_gb']), '--mtp', profile['mtp'],
                   '--prompt-file', profile['prompt'], '--sample-footprint',
                   '--stats-json', str(cell / 'stats.json')]
        if arm == 'both':
            command += ['--mirror', str(INTERNAL)]
        dump(cell / 'command.json', command)
        code, wall, process_first_text = timed_child(command, env, cell)
        vm_after = vm_snapshot()
        row = {'name': label, 'profile': profile['name'], 'arm': arm, 'round': round_number,
               'warmup': round_number == 0, 'exit': code, 'vm_before': vm_before, 'vm_after': vm_after,
               'preflight_conditions': thermal, 'process_wall_s': wall}
        rows.append(row)
        save()
        if code:
            raise RuntimeError(f'{label}: exit {code}')
        assert process_first_text is not None, label + ': no visible output'
        payload = json.loads((cell / 'stats.json').read_text())
        assert (cell / 'stdout.txt').read_text().rstrip('\n') == payload['text'].rstrip('\n'), label + ': stdout is not just generated text'
        stats = validate_metrics(payload)
        row['memory'] = check_memory(payload, profile['memory_gb'])
        assert stats['decodeTokens'] == 128 and stats['reusedPrefixTokens'] == 0, label
        assert stats['firstTokenSeconds'] > 0 and stats['firstTextSeconds'] > 0, label
        assert payload['effective_mtp'] == (profile['mtp'] == 'on'), label
        if profile['mtp'] == 'on':
            assert stats['draftedTokens'] > 0, label
        assert stats['decodeSlotDirectBatches'] > 0, label
        served = stats['mirrorBytes']
        assert (len(served) == 2 and all(v > 0 for v in served)) if arm == 'both' else not served, label
        row['mirror_bytes'] = served
        row['metrics'] = {'ttft_s': stats['firstTokenSeconds'], 'first_text_s': stats['firstTextSeconds'],
                          'request_s': stats['requestSeconds'], 'process_wall_s': wall, 'process_first_text_s': process_first_text,
                          'prefill_tps': stats['prefillTokens']/stats['prefillSeconds'],
                          'decode_tps': stats['decodeTokens']/stats['decodeSeconds']}
        row['tokens'] = {'prompt': stats['promptTokens'], 'output': stats['decodeTokens']}
        row['effective'] = {k: payload[k] for k in ['effective_pool_slots', 'effective_prefill_chunk', 'effective_mtp', 'optimizations']}
        row['eligible'] = (vm_before['swapins'] == vm_after['swapins'] and vm_before['swapouts'] == vm_after['swapouts']
                           and all(stats[k]['thermalState'] == 'nominal' and stats[k]['lowPowerModeEnabled'] is False
                                   for k in ['generatorSystemBefore', 'generatorSystemAfter']))
        save()
        print('RUN', label, json.dumps(row['metrics']), 'eligible', row['eligible'], flush=True)
        return row, payload

    try:
        for name, directory in [('external', EXTERNAL), ('internal', INTERNAL)]:
            cell = OUT / ('verify-' + name)
            cell.mkdir()
            quiet_preflight(13)
            with verification_lock():
                code = run_child([str(BINARY), 'pull', '--verify', '--dir', str(directory)], env, cell, 900)
            dump(cell / 'result.json', {'exit': code})
            assert code == 0, name + ' payload verification failed'
            print('VERIFIED', name, flush=True)
        identities = {str(p): model_identity(p) for p in (EXTERNAL, INTERNAL)}
        dump(OUT / 'model-identities-before.json', identities)
        comparable = [{name: {k: v for k, v in details.items() if k != 'mtime_ns'}
                       for name, details in identity.items()} for identity in identities.values()]
        assert comparable[0] == comparable[1], 'checkpoint metadata differs between copies'
        draft_hashes = {name: digest(directory / 'mtp.safetensors')
                        for name, directory in [('external', EXTERNAL), ('internal', INTERNAL)]}
        dump(OUT / 'draft-payload-sha256.json', draft_hashes)
        assert draft_hashes['external'] == draft_hashes['internal'], 'optional draft payload differs'
        auxiliary = {name: auxiliary_identity(directory)
                     for name, directory in [('external', EXTERNAL), ('internal', INTERNAL)]}
        dump(OUT / 'auxiliary-payloads-before.json', auxiliary)
        assert auxiliary['external'] == auxiliary['internal'], 'auxiliary payloads differ'
        for profile in profiles:
            reference = None
            for round_number, arms in enumerate([protocol['warmup_order'], *order]):
                results = {arm: launch(profile, arm, round_number) for arm in arms}
                base_row, base = results['external']
                for arm in ['internal', 'both']:
                    row, payload = results[arm]
                    for key in ['prompt_ids', 'output_ids', 'text', 'effective_pool_slots',
                                'effective_prefill_chunk', 'effective_mtp', 'optimizations']:
                        assert payload[key] == base[key], f'{profile["name"]} r{round_number}: mismatch {arm} {key}'
                if reference is not None:
                    for key, value in reference.items():
                        assert base[key] == value, f'{profile["name"]}: {key} changed between rounds'
                reference = {key: base[key] for key in ['prompt_ids', 'output_ids', 'text',
                             'effective_pool_slots', 'effective_prefill_chunk', 'effective_mtp', 'optimizations']}
                if round_number:
                    metrics = {arm: result[0]['metrics'] for arm, result in results.items()}
                    comparison = {}
                    for key, value in metrics['both'].items():
                        singles = [metrics[arm][key] for arm in ['external', 'internal']]
                        faster = max(singles) if key.endswith('_tps') else min(singles)
                        comparison[key] = value/faster - 1 if key.endswith('_tps') else 1-value/faster
                    triplets.append({'profile': profile['name'], 'round': round_number, 'order': arms,
                                     'eligible': all(v[0]['eligible'] for v in results.values()),
                                     'exact_output': True, 'metrics': metrics, 'benefit_vs_best_single': comparison})
                    save()
            group = [t for t in triplets if t['profile'] == profile['name']]
            eligible = [t for t in group if t['eligible']]
            summary = {'profile': profile['name'], 'eligible_rounds': len(eligible),
                       'excluded_rounds': [t['round'] for t in group if not t['eligible']],
                       'arm_medians': {arm: {key: statistics.median(t['metrics'][arm][key] for t in eligible)
                                            for key in metrics[arm]} for arm in metrics} if eligible else {},
                       'best_single_comparison': {key: {'median_benefit': statistics.median(t['benefit_vs_best_single'][key] for t in eligible),
                                                         'minimum_benefit': min(t['benefit_vs_best_single'][key] for t in eligible),
                                                         'maximum_benefit': max(t['benefit_vs_best_single'][key] for t in eligible),
                                                         'positive_rounds': sum(t['benefit_vs_best_single'][key] > 0 for t in eligible)}
                                                  for key in comparison} if eligible else {}}
            summaries.append(summary)
            save()
            print('PROFILE', json.dumps(summary), flush=True)
            assert len(eligible) == 6, 'requires all six clean triplets; retain contaminated cohort without retrying'
        after = {str(p): model_identity(p) for p in (EXTERNAL, INTERNAL)}
        dump(OUT / 'model-identities-after.json', after)
        assert identities == after, 'checkpoint changed'
        auxiliary_after = {name: auxiliary_identity(directory)
                           for name, directory in [('external', EXTERNAL), ('internal', INTERNAL)]}
        dump(OUT / 'auxiliary-payloads-after.json', auxiliary_after)
        assert auxiliary == auxiliary_after, 'auxiliary payloads changed'
        assert sha == digest(BINARY), 'binary changed'
        assert head == subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(), 'source revision changed'
        verified_build(BINARY)
        dump(OUT / 'result.json', {'passed': True, 'head': head, 'binary_sha256': sha,
                                 'runs': len(rows), 'measured_triplets': len(triplets), 'summary': summaries})
        print('MIRROR_THREE_ARM_BENCHMARK_PASS', flush=True)
    except BaseException as error:
        save()
        dump(OUT / 'failure.json', {'passed': False, 'error': str(error), 'type': type(error).__name__})
        raise


if __name__ == '__main__':
    main()
