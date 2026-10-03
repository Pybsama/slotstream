#!/usr/bin/env python3
"""Same-composite expert shard read policy at a fixed ten-GB process bound.

Require separately passed greedy/sparse geometry gates and exact sequences
across both arms. This read-policy experiment never promotes a product pack.
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
from vq_pilot_admission import admit, STABLE_SECONDS, MAXIMUM_WAIT_SECONDS
from serve_bench import verified_build
from vq_dense_overlay import IDENTITY_SHA, VQ_INVENTORY

PROFILE_SHAS = {
    'buffered': '87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8',
    'uncached': 'f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285',
}
ARMS = ('buffered', 'uncached')


def validate_receipt(receipt, arm, profile, producer, *, measurement):
    if arm not in ARMS:
        raise ValueError('unknown shard-read-policy arm')
    factor = 3
    reference = profile['references'][IDENTITY_SHA]
    cache = receipt.get('cache_after', {})
    if (receipt.get('passed') is not True
            or receipt.get('mode') != ('measurement' if measurement else 'validation')
            or receipt.get('profile_sha256') != PROFILE_SHAS[arm]
            or receipt.get('producer') != producer or receipt.get('pack') != '3.2-dense-affine4'
            or receipt.get('inventory_sha256') != VQ_INVENTORY
            or receipt.get('composite_sha256') != IDENTITY_SHA
            or receipt.get('verified_files') != 138 or receipt.get('overlay_verified_files') != 9
            or receipt.get('resident_text', {}).get('payload_bytes') != 2_893_477_400
            or cache.get('parallel_read_lanes') != 12
            or cache.get('total_capacity') != 608 * factor
            or cache.get('reserved_bank_bytes') != 1_194_393_600 * factor
            or cache.get('maximum_bank_capacity') != 512 * factor
            or cache.get('minimum_bank_capacity') != 96 * factor
            or cache.get('occupied_records') != 608 * factor
            or cache.get('dense_savings_reinvested') != 1
            or receipt.get('expert_file_read_policy') != ('uncached-random-shards-v1' if arm == 'uncached' else 'buffered-v1')
            or receipt.get('uncached_expert_files') != (9 if arm == 'uncached' else 0)
            or cache.get('maximum_executed_slot') != 512 * factor - 1
            or cache.get('minimum_class_maximum_executed_slot') != 96 * factor - 1
            or cache.get('pinned_records') != 0
            or type(receipt.get('peak_process_bytes')) is not int
            or not 0 < receipt['peak_process_bytes'] <= 10_000_000_000):
        raise ValueError('shard-read-policy receipt changed its artifact, producer, physical range or envelope')
    generated = receipt.get('generated')
    if (not isinstance(generated, list) or generated[:16] != reference['generated']
            or any(type(t) is not int or not 0 <= t < 248_320 for t in generated)):
        raise ValueError('shard-read-policy receipt changed the independent generated prefix')
    if not measurement and (len(generated) != 16 or receipt.get('observed_logit_hashes') != [x['sha256'] for x in reference['logits']]):
        raise ValueError('shard-read-policy validation omitted full-logit references')
    if measurement and not 16 <= len(generated) <= 128:
        raise ValueError('shard-read-policy measurement changed its bounded sequence length')


def validate_gate(receipt, sparse):
    cache = receipt.get('resident_record_cache', {})
    if (receipt.get('composite_sha256') != IDENTITY_SHA
            or receipt.get('inventory_sha256') != VQ_INVENTORY
            or receipt.get('report', {}).get('passed') is not True
            or receipt.get('process_bound_bytes') != 10_000_000_000
            or type(receipt.get('peak_process_bytes')) is not int
            or not 0 < receipt['peak_process_bytes'] <= 10_000_000_000
            or cache.get('dense_savings_reinvested') != 1
            or cache.get('total_capacity') != 1824
            or cache.get('reserved_bank_bytes') != 3_583_180_800
            or cache.get('pinned_records') != 0
            or receipt.get('expert_file_read_policy') != 'uncached-random-shards-v1'
            or receipt.get('uncached_expert_files') != 9
            or len(receipt.get('observed', {})) != (984 if sparse else 2560)):
        raise ValueError('missing independent shard-read-policy parity/memory gate')
    # Supervisor identity binds the producing binary separately; numerical
    # gate receipts predate executable fields in the performance schema.
    if not sparse and (cache.get('maximum_executed_slot') != 1535
                       or cache.get('minimum_class_maximum_executed_slot') != 287):
        raise ValueError('greedy gate did not execute the enlarged physical range')


def run(options):
    root = Path(__file__).resolve().parent.parent
    research, out, binary = options.research_root.resolve(), options.out.resolve(), options.binary.resolve()
    build = verified_build(str(binary))
    identity = json.loads((binary.parent / 'build-identity.json').read_text())
    producer = {k: identity[k] for k in ('binary_sha256', 'metallib_sha256')}
    profile_paths = {'buffered': root / 'bench/quantization/dense-reinvestment-cost-v1.json',
                     'uncached': root / 'bench/quantization/uncached-expert-cost-v1.json'}
    if any(digest(path) != PROFILE_SHAS[arm] for arm, path in profile_paths.items()):
        raise ValueError('shard-read-policy protocol differs from frozen identity')
    profiles = {arm: json.loads(path.read_text()) for arm, path in profile_paths.items()}
    profile = profiles['uncached']
    gate_run = options.gates.resolve() / 'run.json'
    gate_record = json.loads(gate_run.read_text())
    if (gate_record.get('complete') is not True
            or gate_record.get('producer_sha256') != producer['binary_sha256']):
        raise ValueError('parity campaign did not complete on the timed producer')
    gate_paths = [gate_run]
    for name in ('greedy', 'sparse'):
        path = options.gates.resolve() / name / 'receipt.json'
        supervisor = options.gates.resolve() / (name + '-supervision') / 'identity.json'
        validate_gate(json.loads(path.read_text()), name == 'sparse')
        bound_identity = json.loads(supervisor.read_text())
        if bound_identity.get('command', [None])[0] != str(binary):
            raise ValueError('parity gate did not use the timed frozen binary')
        finished = options.gates.resolve() / (name + '-supervision') / 'receipt.json'
        result = json.loads(finished.read_text())
        if result.get('exit_code') != 0 or result.get('failure') is not None:
            raise ValueError('parity supervision failed')
        gate_paths += [path, supervisor, finished]

    manifest = options.manifest.resolve()
    if digest(manifest) != '4cdae0e9c26b9a0dd07659cd9d71dd025ed110b49161c152df09d5a7f75ac28b':
        raise ValueError('composite tensor map changed')
    observer = options.admission_observer.resolve()
    observer_files = [observer / name for name in ('observer', 'observer.swift', 'build.json')]
    observer_receipt = json.loads((observer / 'build.json').read_text())
    if observer_receipt.get('engine_source_sha256') != identity['source']['Sources/Slotstream/ProcessMemory.swift']:
        raise ValueError('idle admission observer differs from the timed engine memory implementation')
    inputs = [Path(__file__).resolve(), manifest] + list(profile_paths.values()) + gate_paths + observer_files
    inputs += [Path(module.__file__).resolve() for module in list(sys.modules.values())
               if getattr(module, '__file__', None) and Path(module.__file__).resolve().parent == root / 'Tools']
    bound = {str(p): digest(p) for p in inputs}
    out.mkdir(exist_ok=False)
    for arm, path in profile_paths.items(): shutil.copy2(path, out / (arm + '-profile.json'))
    record = {'schema': 1, 'scope': profile['scope'], 'qualification': 'unproven', 'complete': False,
        'started_at': datetime.now(timezone.utc).isoformat(), 'producer': producer, 'build': build,
        'source_archive_sha256': identity['source_archive_sha256'], 'bound_files': bound,
        'admission': {'required_stable_seconds': STABLE_SECONDS, 'maximum_wait_seconds_per_cell': MAXIMUM_WAIT_SECONDS,
                      'scope': 'Sampled idle precondition before every validation and measurement; no change to native or in-request checks'},
        'maximum_runs': 8, 'campaign_timeout_seconds': 14400, 'run_timeout_seconds': 1800,
        'maximum_process_bytes': 10000000000, 'minimum_reclaimable_bytes': 13000000000,
        'retry_policy': 'No automatic retry; retain failure', 'paid_compute': False, 'runs': []}
    started = time.monotonic(); sequences = {}

    def save():
        (out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')

    def verify():
        if any(digest(Path(p)) != sha for p, sha in bound.items()) or any(digest(out / (arm + '-profile.json')) != PROFILE_SHAS[arm] for arm in ARMS):
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
            '--profile', str(out / (arm + '-profile.json')), '--output', str(out / name),
            '--dense-overlay-baseline', str(options.baseline.resolve()), '--dense-overlay-manifest', str(manifest)]
        if measurement:
            command += ['--measure', '--validation-receipt', str(out / ('validation-' + arm) / 'receipt.json')]
        admit(observer, out / (name + '-admission.json'), maximum_wait=min(MAXIMUM_WAIT_SECONDS, remaining))
        verify()
        remaining = int(14400 - (time.monotonic() - started))
        if remaining <= 0: raise ValueError('campaign exhausted after idle admission')
        supervision = supervise(command, out / (name + '-supervision'), min(1800, remaining))
        path = out / name / 'receipt.json'; receipt = json.loads(path.read_text())
        validate_receipt(receipt, arm, profiles[arm], producer, measurement=measurement)
        if measurement:
            if any(sequence != receipt['generated'] for sequence in sequences.values()):
                raise ValueError('same composite changed its complete sequence across read-policy arms')
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
    for name in ('binary', 'research-root', 'baseline', 'manifest', 'gates', 'out', 'admission-observer'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
