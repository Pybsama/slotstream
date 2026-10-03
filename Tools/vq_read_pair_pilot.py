#!/usr/bin/env python3
"""Frozen same-artifact serial/parallel read comparison, with no promotion."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import statistics
import sys

from quantization_logit_run import digest, supervise

PROTOCOL_SHA = '8009cdf7ff516f8159e35ef03343bfa27d64564ba147553b59acc8a2d4f71f10'


def run(options):
    root = Path(__file__).resolve().parent.parent
    binary, research, out = options.binary.resolve(), options.research_root.resolve(), options.out.resolve()
    source = root / 'bench/quantization/read-pair-v1.json'
    if digest(source) != PROTOCOL_SHA:
        raise ValueError('read-pair protocol differs from its frozen identity')
    protocol = json.loads(source.read_text())
    identity = json.loads((binary.parent / 'build-identity.json').read_text())
    producer = {k: identity[k] for k in ('binary_sha256', 'metallib_sha256')}
    drivers = {str(Path(module.__file__).resolve().relative_to(root)): digest(Path(module.__file__).resolve())
               for module in list(sys.modules.values()) if getattr(module, '__file__', None)
               and Path(module.__file__).resolve().parent == root / 'Tools'}
    drivers[str(Path(__file__).resolve().relative_to(root))] = digest(Path(__file__))
    if binary.name != 'slotstream':
        raise ValueError('use the source-bound CLI executable')
    out.mkdir(parents=False, exist_ok=False)
    shutil.copy2(source, out / 'protocol.json')
    for name, expected in protocol['profiles'].items():
        profile = root / 'bench/quantization' / name
        if digest(profile) != expected:
            raise ValueError('native comparison profile changed')
        shutil.copy2(profile, out / name)
    record = dict(schema=1, scope=protocol['scope'], qualification='unproven', complete=False,
                  started_at=datetime.now(timezone.utc).isoformat(), protocol_sha256=PROTOCOL_SHA,
                  producer=producer, source_archive_sha256=identity['source_archive_sha256'], drivers=drivers, runs=[])
    expected_tokens = None

    def save():
        (out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')

    def verify():
        for name, key in [('slotstream', 'binary_sha256'), ('mlx.metallib', 'metallib_sha256'),
                          ('build-source.tar.gz', 'source_archive_sha256')]:
            if digest(binary.parent / name) != identity[key]:
                raise ValueError('comparison producer changed')
        if digest(source) != PROTOCOL_SHA or digest(out / 'protocol.json') != PROTOCOL_SHA:
            raise ValueError('comparison protocol changed')
        for name, expected in protocol['profiles'].items():
            if digest(out / name) != expected:
                raise ValueError('native comparison profile changed')
        for name, expected in drivers.items():
            if digest(root / name) != expected:
                raise ValueError('comparison driver changed')

    def invoke(arm, name, measurement=False):
        nonlocal expected_tokens
        verify()
        profile_name = protocol['arms'][arm]
        native = json.loads((out / profile_name).read_text())
        reference_inventory = next(key for key, value in native['references'].items() if value['pack'] == protocol['pack'])
        command = [str(binary), 'quantization-performance-pilot', '--source-directory', str(research / 'candidate-3.2'),
                   '--source-inventory', str(research / 'inventory-3.2/inventory.json'),
                   '--profile', str(out / profile_name), '--output', str(out / name)]
        if measurement:
            command += ['--measure', '--validation-receipt', str(out / ('validation-' + arm) / 'receipt.json')]
        observed = supervise(command, out / (name + '-supervision'), protocol['resources']['run_timeout_seconds'])
        path = out / name / 'receipt.json'
        receipt = json.loads(path.read_text())
        if (not receipt['passed'] or receipt['producer'] != producer
                or receipt['profile_sha256'] != protocol['profiles'][profile_name]
                or receipt['inventory_sha256'] != reference_inventory
                or receipt['mode'] != ('measurement' if measurement else 'validation')
                or receipt['cache_after']['parallel_read_lanes'] != (12 if arm == 'parallel' else 0)):
            raise ValueError('comparison receipt changed its artifact, profile, mode or producer')
        same_tokens = True
        if measurement:
            if expected_tokens is None:
                expected_tokens = receipt['generated']
            same_tokens = receipt['generated'] == expected_tokens
        row = dict(name=name, arm=arm, mode=receipt['mode'], receipt_sha256=digest(path), supervision=observed,
                   timing_eligible=receipt['observed_timing_eligible'], timing_exclusions=receipt['timing_exclusions'],
                   exact_generated_sequence=same_tokens,
                   generated_sha256=hashlib.sha256(json.dumps(receipt['generated']).encode()).hexdigest())
        for key in ('committed_tokens', 'committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds', 'peak_process_bytes'):
            row[key] = receipt.get(key)
        record['runs'].append(row)
        save()
        if not same_tokens:
            raise ValueError('serial and parallel complete generated sequences differ')
        verify()
        print(json.dumps({key: value for key, value in row.items() if key != 'supervision'}), flush=True)

    save()
    try:
        for arm in protocol['arms']:
            invoke(arm, 'validation-' + arm)
        for index, order in enumerate(protocol['rounds'], 1):
            for arm in order:
                invoke(arm, f'round-{index}-{arm}', measurement=True)
        timings = [row for row in record['runs'] if row['mode'] == 'measurement']
        record['all_observed_timings_eligible'] = all(row['timing_eligible'] for row in timings)
        if record['all_observed_timings_eligible']:
            record['medians'] = {arm: {
                key: statistics.median(row[key] for row in timings if row['arm'] == arm)
                for key in ('committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds')}
                for arm in protocol['arms']}
            by_name = {row['name']: row for row in timings}
            record['paired_decode_ratios'] = [
                by_name[f'round-{i}-parallel']['committed_decode_tokens_per_second'] /
                by_name[f'round-{i}-serial']['committed_decode_tokens_per_second'] for i in range(1, 4)]
            record['median_paired_decode_ratio'] = statistics.median(record['paired_decode_ratios'])
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
