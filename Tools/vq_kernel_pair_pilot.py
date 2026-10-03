#!/usr/bin/env python3
"""Frozen two-binary VQ code-object reuse experiment; never promotes a pack."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import statistics
import sys

from quantization_logit_run import digest, supervise

PROTOCOL_SHA = 'ac0a703534577137c79e3d1de094df5d15f5e49d71e12919efa872812e578bee'


def run(options):
    root = Path(__file__).resolve().parent.parent
    research, out = options.research_root.resolve(), options.out.resolve()
    binaries = {arm: getattr(options, arm).resolve() for arm in ('before', 'after')}
    source = root / 'bench/quantization/kernel-pair-v1.json'
    if digest(source) != PROTOCOL_SHA:
        raise ValueError('kernel-reuse protocol differs from its frozen identity')
    protocol = json.loads(source.read_text())
    identities = {arm: json.loads((binary.parent / 'build-identity.json').read_text()) for arm, binary in binaries.items()}
    producers = {arm: {key: identity[key] for key in ('binary_sha256', 'metallib_sha256')}
                 for arm, identity in identities.items()}
    before, after = (identities[arm]['source'] for arm in ('before', 'after'))
    changed = sorted(path for path in set(before) | set(after) if before.get(path) != after.get(path))
    if changed != sorted(protocol['allowed_source_changes']):
        raise ValueError('binary sources contain changes outside the frozen kernel-reuse hypothesis')
    if (producers['before']['binary_sha256'] == producers['after']['binary_sha256']
            or producers['before']['metallib_sha256'] != producers['after']['metallib_sha256']):
        raise ValueError('experiment requires different executables and the same Metal library')
    drivers = {str(Path(module.__file__).resolve().relative_to(root)): digest(Path(module.__file__).resolve())
               for module in list(sys.modules.values()) if getattr(module, '__file__', None)
               and Path(module.__file__).resolve().parent == root / 'Tools'}
    drivers[str(Path(__file__).resolve().relative_to(root))] = digest(Path(__file__))
    if any(binary.name != 'slotstream' for binary in binaries.values()):
        raise ValueError('use source-bound CLI executables')
    profile = root / 'bench/quantization' / protocol['profile_file']
    if digest(profile) != protocol['profile_sha256']:
        raise ValueError('native comparison profile changed')
    out.mkdir(parents=False, exist_ok=False)
    shutil.copy2(source, out / 'protocol.json')
    shutil.copy2(profile, out / 'profile.json')
    record = dict(schema=1, scope=protocol['scope'], qualification='unproven', complete=False,
                  started_at=datetime.now(timezone.utc).isoformat(), protocol_sha256=PROTOCOL_SHA,
                  producers=producers, source_changes=changed,
                  source_archives={arm: identity['source_archive_sha256'] for arm, identity in identities.items()},
                  drivers=drivers, runs=[])
    expected_tokens = None

    def save():
        (out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')

    def verify():
        for arm, binary in binaries.items():
            for name, key in [('slotstream', 'binary_sha256'), ('mlx.metallib', 'metallib_sha256'),
                              ('build-source.tar.gz', 'source_archive_sha256')]:
                if digest(binary.parent / name) != identities[arm][key]:
                    raise ValueError('comparison producer changed')
        if digest(source) != PROTOCOL_SHA or digest(out / 'protocol.json') != PROTOCOL_SHA:
            raise ValueError('comparison protocol changed')
        if digest(out / 'profile.json') != protocol['profile_sha256']:
            raise ValueError('native comparison profile changed')
        for name, expected in drivers.items():
            if digest(root / name) != expected:
                raise ValueError('comparison driver changed')

    def invoke(arm, name, measurement=False):
        nonlocal expected_tokens
        verify()
        native = json.loads((out / 'profile.json').read_text())
        inventory = next(key for key, value in native['references'].items() if value['pack'] == protocol['pack'])
        command = [str(binaries[arm]), 'quantization-performance-pilot', '--source-directory', str(research / 'candidate-3.2'),
                   '--source-inventory', str(research / 'inventory-3.2/inventory.json'),
                   '--profile', str(out / 'profile.json'), '--output', str(out / name)]
        if measurement:
            command += ['--measure', '--validation-receipt', str(out / ('validation-' + arm) / 'receipt.json')]
        observed = supervise(command, out / (name + '-supervision'), protocol['resources']['run_timeout_seconds'])
        path = out / name / 'receipt.json'
        receipt = json.loads(path.read_text())
        if (not receipt['passed'] or receipt['producer'] != producers[arm]
                or receipt['profile_sha256'] != protocol['profile_sha256']
                or receipt['inventory_sha256'] != inventory
                or receipt['mode'] != ('measurement' if measurement else 'validation')
                or receipt['cache_after']['parallel_read_lanes'] != 12):
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
            raise ValueError('complete generated sequences differ')
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
            ratios = {key: [by_name[f'round-{i}-after'][key] / by_name[f'round-{i}-before'][key]
                           for i in range(1, 4)] for key in ('committed_decode_tokens_per_second', 'ttft_seconds')}
            record['paired_ratios'] = ratios
            record['median_paired_ratios'] = {key: statistics.median(values) for key, values in ratios.items()}
            record['pilot_adoption_gate'] = (
                record['median_paired_ratios']['committed_decode_tokens_per_second'] >= protocol['adoption']['minimum_median_paired_decode_ratio']
                and record['median_paired_ratios']['ttft_seconds'] <= protocol['adoption']['maximum_median_paired_ttft_ratio'])
        record['complete'] = True
        record['finished_at'] = datetime.now(timezone.utc).isoformat()
        save()
    except BaseException as error:
        record['failure'] = str(error)
        save()
        raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('before', 'after', 'research-root', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
