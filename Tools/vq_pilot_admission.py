"""Bounded idle admission for a new VQ timing campaign, never a retry loop.

Use the exact native ProcessMemory implementation in a small separate observer.
No model is loaded while waiting. Successful admission is only a precondition;
the native allocator and every in-request eligibility check remain authoritative.
"""
import hashlib
import json
from pathlib import Path
import subprocess
import time

from context_qualification import quiet_preflight
from prefill_bench import vm_snapshot

STABLE_SECONDS = 30
MAXIMUM_WAIT_SECONDS = 600
MINIMUM_BYTES = 13_000_000_000


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def build_observer(root, out):
    before = quiet_preflight(13)
    out.mkdir(exist_ok=False)
    original = root / 'Sources/Slotstream/ProcessMemory.swift'
    source = original.read_text()
    marker = '/// Loading two copies'
    if source.count(marker) != 1:
        raise ValueError('native ProcessMemory extraction boundary changed')
    text = source.split(marker)[0] + '''
let enc = JSONEncoder(); enc.outputFormatting = [.sortedKeys]
var output: [String: Any] = ["conditions": try JSONSerialization.jsonObject(with: enc.encode(ProcessMemory.operatingConditions()))]
output["vm"] = try ProcessMemory.vmActivity().map { try JSONSerialization.jsonObject(with: enc.encode($0)) }
print(String(decoding: try JSONSerialization.data(withJSONObject: output, options: [.sortedKeys]), as: UTF8.self))
'''
    swift = out / 'observer.swift'; binary = out / 'observer'
    swift.write_text(text)
    command = ['swiftc', '-O', str(swift), '-o', str(binary)]
    result = subprocess.run(command, capture_output=True, text=True, timeout=120)
    receipt = {'schema': 1, 'command': command, 'before': before,
               'engine_source_sha256': digest(original), 'observer_source_sha256': digest(swift),
               'returncode': result.returncode, 'stdout': result.stdout, 'stderr': result.stderr}
    if result.returncode == 0: receipt['observer_sha256'] = digest(binary)
    (out / 'build.json').write_text(json.dumps(receipt, indent=2) + '\n')
    if result.returncode: raise RuntimeError('native admission observer build failed')
    return binary


def eligible(sample):
    native = sample.get('native', {})
    conditions = native.get('conditions', {})
    vm = native.get('vm') or {}
    external = sample.get('external', {})
    values = (vm.get('reclaimableBytes'), external.get('reclaimable_bytes'))
    return (conditions.get('thermalState') == 'nominal'
            and conditions.get('lowPowerModeEnabled') is False
            and all(type(v) is int and v >= MINIMUM_BYTES for v in values))


def wait_until_stable(sample, *, now=time.monotonic, sleep=time.sleep, publish=lambda _: None,
                      maximum_wait=MAXIMUM_WAIT_SECONDS, stable_seconds=STABLE_SECONDS):
    if not 0 < stable_seconds <= maximum_wait <= MAXIMUM_WAIT_SECONDS:
        raise ValueError('invalid admission interval')
    start = now(); stable_since = None; snapshots = []
    while True:
        value = sample(); current = now(); good = eligible(value)
        if not good: stable_since = None
        elif stable_since is None: stable_since = current
        stable = 0 if stable_since is None else current - stable_since
        row = {'elapsed_seconds': current - start, 'stable_seconds': stable, 'eligible': good, **value}
        snapshots.append(row)
        report = {'schema': 1, 'passed': False, 'maximum_wait_seconds': maximum_wait,
                  'required_stable_seconds': stable_seconds, 'samples': snapshots}
        # Sampling or tool overhead counts toward the deadline. A final sample
        # after the deadline cannot confer admission.
        if current - start > maximum_wait:
            report['failure'] = 'admission deadline exceeded'; publish(report)
            raise TimeoutError(report['failure'])
        if good and stable >= stable_seconds:
            report['passed'] = True; publish(report); return report
        if current - start >= maximum_wait:
            report['failure'] = 'conditions never remained eligible for the required interval'; publish(report)
            raise TimeoutError(report['failure'])
        publish(report)
        sleep(min(5, maximum_wait - (current - start)))


def admit(directory, output, *, maximum_wait=MAXIMUM_WAIT_SECONDS):
    receipt = json.loads((directory / 'build.json').read_text())
    binary = directory / 'observer'
    if (receipt.get('returncode') != 0 or digest(binary) != receipt.get('observer_sha256')
            or digest(directory / 'observer.swift') != receipt.get('observer_source_sha256')):
        raise ValueError('admission observer differs from its source-bound producer')
    if output.exists(): raise ValueError('admission receipt must be new')
    def sample():
        observed = subprocess.run([str(binary)], capture_output=True, text=True, check=True, timeout=10)
        return {'native': json.loads(observed.stdout), 'external': vm_snapshot()}
    def publish(value):
        value['observer_sha256'] = receipt['observer_sha256']
        value['engine_source_sha256'] = receipt['engine_source_sha256']
        output.write_text(json.dumps(value, indent=2) + '\n')
    result = wait_until_stable(sample, maximum_wait=maximum_wait, publish=publish)
    # No model/compiler may have appeared while conditions were observed.
    quiet_preflight(13)
    return result


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, required=True, help='New source-bound observer directory')
    args = parser.parse_args()
    print(build_observer(Path(__file__).resolve().parent.parent, args.out.resolve()))
