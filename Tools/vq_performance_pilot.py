#!/usr/bin/env python3
"""Bounded paired VQ cost pilot. No qualification, activation or hidden retries."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import statistics
import sys

from quantization_logit_run import digest, supervise

PROFILE_SHA = '8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5'


def run(options):
    root = Path(__file__).resolve().parent.parent
    binary = options.binary.resolve()
    research = options.research_root.resolve()
    profile = root / 'bench/quantization/performance-pilot-v1.json'
    if digest(profile) != PROFILE_SHA:
        raise ValueError('pilot profile changed; freeze a new version before measuring')
    protocol = json.loads(profile.read_text())
    identity = json.loads((binary.parent / 'build-identity.json').read_text())
    for filename, key in [('slotstream', 'binary_sha256'), ('mlx.metallib', 'metallib_sha256'),
                          ('build-source.tar.gz', 'source_archive_sha256')]:
        if digest(binary.parent / filename) != identity[key]:
            raise ValueError('pilot producer differs from its source-bound build')
    if binary.name != 'slotstream':
        raise ValueError('expected the source-bound CLI executable')
    drivers = {str(Path(module.__file__).resolve().relative_to(root)): digest(Path(module.__file__).resolve())
               for module in list(sys.modules.values()) if getattr(module, '__file__', None)
               and Path(module.__file__).resolve().parent == root / 'Tools'}
    drivers[str(Path(__file__).resolve().relative_to(root))] = digest(Path(__file__))
    out = options.out.resolve()
    out.mkdir(parents=False, exist_ok=False)
    shutil.copy2(profile, out / 'profile.json')
    record = dict(schema=1, scope=protocol['scope'], qualification='unproven', complete=False,
                  started_at=datetime.now(timezone.utc).isoformat(), profile_sha256=PROFILE_SHA,
                  producer={k: identity[k] for k in ('binary_sha256', 'metallib_sha256', 'source_archive_sha256')},
                  drivers=drivers, runs=[], protocol_resources=protocol['resources'])

    def save():
        (out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')

    def check_identity():
        if digest(profile) != PROFILE_SHA or digest(out / 'profile.json') != PROFILE_SHA:
            raise ValueError('pilot protocol changed during execution')
        for name, expected in drivers.items():
            if digest(root / name) != expected:
                raise ValueError('pilot driver changed during execution')
        for name, key in [('slotstream', 'binary_sha256'), ('mlx.metallib', 'metallib_sha256')]:
            if digest(binary.parent / name) != identity[key]:
                raise ValueError('pilot executable or metallib changed during execution')

    def invoke(pack, name, validation=None):
        check_identity()
        command = [str(binary), 'quantization-performance-pilot',
                   '--source-directory', str(research / ('candidate-' + pack)),
                   '--source-inventory', str(research / ('inventory-' + pack) / 'inventory.json'),
                   '--profile', str(out / 'profile.json'), '--output', str(out / name)]
        if validation:
            command += ['--measure', '--validation-receipt', str(validation)]
        supervision = supervise(command, out / (name + '-supervision'), protocol['resources']['run_timeout_seconds'])
        receipt_path = out / name / 'receipt.json'
        receipt = json.loads(receipt_path.read_text())
        expected_inventory = next(key for key, ref in protocol['references'].items() if ref['pack'] == pack)
        if (not receipt['passed'] or receipt['pack'] != pack or receipt['inventory_sha256'] != expected_inventory
                or receipt['profile_sha256'] != PROFILE_SHA or receipt['producer'] != {
                    k: identity[k] for k in ('binary_sha256', 'metallib_sha256')}):
            raise ValueError('pilot output does not bind its required producer and artifact')
        if receipt['mode'] != ('measurement' if validation else 'validation'):
            raise ValueError('pilot output has the wrong operation mode')
        check_identity()
        row = dict(name=name, pack=pack, mode=receipt['mode'], receipt_sha256=digest(receipt_path),
                   supervision=supervision, timing_eligible=receipt['observed_timing_eligible'],
                   timing_exclusions=receipt['timing_exclusions'])
        for key in ('committed_tokens', 'committed_decode_tokens_per_second', 'ttft_seconds', 'load_seconds',
                    'request_seconds', 'peak_process_bytes'):
            row[key] = receipt.get(key)
        record['runs'].append(row)
        save()
        print(json.dumps(row), flush=True)

    save()
    try:
        for pack in ('3.2', '4.4'):
            invoke(pack, 'validation-' + pack)
        for round_index, order in enumerate(protocol['rounds'], 1):
            for pack in order:
                invoke(pack, f'round-{round_index}-{pack}', out / ('validation-' + pack) / 'receipt.json')
        measurements = [row for row in record['runs'] if row['mode'] == 'measurement']
        record['all_timing_observations_eligible'] = all(row['timing_eligible'] for row in measurements)
        if record['all_timing_observations_eligible']:
            record['medians'] = {pack: {
                key: statistics.median(row[key] for row in measurements if row['pack'] == pack)
                for key in ('committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds', 'load_seconds')}
                for pack in ('3.2', '4.4')}
        record['complete'] = True
        record['finished_at'] = datetime.now(timezone.utc).isoformat()
        save()
    except BaseException as error:
        record['failure'] = str(error)
        save()
        raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'research-root', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
