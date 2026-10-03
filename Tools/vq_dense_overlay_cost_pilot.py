#!/usr/bin/env python3
"""Bounded cross-artifact dense-composite cost comparison, never promotion.

Each arm must match its own independent logits and repeat its own sequence.
Cross-artifact identity is deliberately not an output-equality assertion.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import statistics
import sys
import time

from quantization_logit_run import digest, supervise
from serve_bench import verified_build
from vq_dense_overlay import IDENTITY_SHA, VQ_INVENTORY

PROFILE_SHA = 'a1b2edc29e0b1a5a3a668d9b8c26ff8533523f0045e98970e5e5efc54badaa88'
ARMS = ('3.2', '3.2-dense-affine4')


def validate_receipt(receipt, arm, profile, producer, *, measurement):
    if arm not in ARMS:
        raise ValueError('unknown composite cost arm')
    identity = IDENTITY_SHA if arm == ARMS[1] else None
    reference = profile['references'][identity or VQ_INVENTORY]
    if (arm not in ARMS or receipt.get('passed') is not True
            or receipt.get('mode') != ('measurement' if measurement else 'validation')
            or receipt.get('profile_sha256') != PROFILE_SHA
            or receipt.get('producer') != producer or receipt.get('pack') != arm
            or receipt.get('inventory_sha256') != VQ_INVENTORY
            or receipt.get('composite_sha256') != identity
            or receipt.get('verified_files') != 138
            or receipt.get('overlay_verified_files') != (9 if identity else 0)
            or receipt.get('resident_text', {}).get('payload_bytes') != (2_893_477_400 if identity else 5_318_309_400)
            or receipt.get('cache_after', {}).get('parallel_read_lanes') != 12
            or receipt.get('cache_after', {}).get('total_capacity') != 608
            or receipt.get('cache_after', {}).get('pinned_records') != 0
            or type(receipt.get('peak_process_bytes')) is not int
            or not 0 < receipt['peak_process_bytes'] <= 10_000_000_000):
        raise ValueError('cost receipt does not bind its artifact, producer or resource envelope')
    generated = receipt.get('generated')
    if (not isinstance(generated, list) or generated[:16] != reference['generated']
            or any(type(t) is not int or not 0 <= t < 248_320 for t in generated)):
        raise ValueError('cost receipt changed its own independently validated token prefix')
    if not measurement and (len(generated) != 16 or receipt.get('observed_logit_hashes') != [x['sha256'] for x in reference['logits']]):
        raise ValueError('cost validation omitted its full-logit references')
    if measurement and not 16 <= len(generated) <= 128:
        raise ValueError('cost measurement changed its bounded sequence length')


def run(options):
    root = Path(__file__).resolve().parent.parent
    research, out, binary = options.research_root.resolve(), options.out.resolve(), options.binary.resolve()
    build = verified_build(str(binary))
    identity = json.loads((binary.parent / 'build-identity.json').read_text())
    producer = {k: identity[k] for k in ('binary_sha256', 'metallib_sha256')}
    profile_path = root / 'bench/quantization/dense-overlay-cost-v1.json'
    if digest(profile_path) != PROFILE_SHA:
        raise ValueError('composite cost protocol differs from its frozen identity')
    profile = json.loads(profile_path.read_text())
    manifest = options.manifest.resolve()
    if digest(manifest) != '4cdae0e9c26b9a0dd07659cd9d71dd025ed110b49161c152df09d5a7f75ac28b':
        raise ValueError('composite tensor map changed')
    inputs = [Path(__file__).resolve(), profile_path, manifest]
    inputs += [Path(module.__file__).resolve() for module in list(sys.modules.values())
               if getattr(module, '__file__', None) and Path(module.__file__).resolve().parent == root / 'Tools']
    bound = {str(p): digest(p) for p in inputs}
    out.mkdir(exist_ok=False)
    shutil.copy2(profile_path, out / 'profile.json')
    record = {'schema': 1, 'scope': profile['scope'], 'qualification': 'unproven', 'complete': False,
        'started_at': datetime.now(timezone.utc).isoformat(), 'producer': producer, 'build': build,
        'source_archive_sha256': identity['source_archive_sha256'], 'bound_files': bound,
        'maximum_runs': 8, 'campaign_timeout_seconds': 14400, 'run_timeout_seconds': 1800,
        'maximum_process_bytes': 10000000000, 'minimum_reclaimable_bytes': 13000000000,
        'retry_policy': 'No automatic retry; retain failure', 'paid_compute': False, 'runs': []}
    started = time.monotonic(); sequences = {}

    def save():
        (out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')

    def verify():
        if any(digest(Path(p)) != sha for p, sha in bound.items()) or digest(out / 'profile.json') != PROFILE_SHA:
            raise ValueError('cost experiment inputs changed')
        for name, key in [('slotstream', 'binary_sha256'), ('mlx.metallib', 'metallib_sha256'), ('build-source.tar.gz', 'source_archive_sha256')]:
            if digest(binary.parent / name) != identity[key]:
                raise ValueError('cost producer changed')

    def invoke(arm, name, *, measurement=False):
        verify()
        remaining = int(14400 - (time.monotonic() - started))
        if remaining <= 0: raise ValueError('cost experiment exhausted its campaign bound')
        command = [str(binary), 'quantization-performance-pilot', '--source-directory', str(research / 'candidate-3.2'),
            '--source-inventory', str(research / 'inventory-3.2/inventory.json'),
            '--profile', str(out / 'profile.json'), '--output', str(out / name)]
        if arm == ARMS[1]:
            command += ['--dense-overlay-baseline', str(options.baseline.resolve()), '--dense-overlay-manifest', str(manifest)]
        if measurement:
            command += ['--measure', '--validation-receipt', str(out / ('validation-' + arm) / 'receipt.json')]
        supervision = supervise(command, out / (name + '-supervision'), min(1800, remaining))
        path = out / name / 'receipt.json'; receipt = json.loads(path.read_text())
        validate_receipt(receipt, arm, profile, producer, measurement=measurement)
        if measurement:
            if arm in sequences and sequences[arm] != receipt['generated']:
                raise ValueError('an unchanged artifact produced a different sequence')
            sequences[arm] = receipt['generated']
        row = {'name': name, 'arm': arm, 'measurement': measurement, 'supervision': supervision,
            'receipt_sha256': digest(path), 'generated_sha256': hashlib.sha256(json.dumps(receipt['generated']).encode()).hexdigest()}
        for key in ('committed_tokens', 'committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds',
                    'peak_process_bytes', 'observed_timing_eligible', 'timing_exclusions', 'stop'):
            row[key] = receipt.get(key)
        record['runs'].append(row); save(); verify()
        print(json.dumps({k:v for k,v in row.items() if k != 'supervision'}), flush=True)

    save()
    try:
        for arm in ARMS: invoke(arm, 'validation-' + arm)
        for index, order in enumerate(profile['rounds'], 1):
            for arm in order: invoke(arm, f'round-{index}-{arm}', measurement=True)
        timing = [r for r in record['runs'] if r['measurement']]
        record['all_observed_timings_eligible'] = all(r['observed_timing_eligible'] for r in timing)
        if record['all_observed_timings_eligible']:
            metrics = ('committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds')
            record['medians'] = {arm:{k:statistics.median(r[k] for r in timing if r['arm']==arm) for k in metrics} for arm in ARMS}
            by_name = {r['name']:r for r in timing}
            record['paired_ratios'] = {k:[by_name[f'round-{i}-{ARMS[1]}'][k]/by_name[f'round-{i}-{ARMS[0]}'][k] for i in range(1,4)] for k in metrics}
            record['median_paired_ratios'] = {k:statistics.median(v) for k,v in record['paired_ratios'].items()}
        record['complete'] = True; record['finished_at'] = datetime.now(timezone.utc).isoformat(); save()
    except BaseException as error:
        record['failure'] = repr(error); save(); raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'research-root', 'baseline', 'manifest', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
