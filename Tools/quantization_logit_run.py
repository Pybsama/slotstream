#!/usr/bin/env python3
"""Run a frozen logit pilot sequentially, preserving producer and memory evidence.

This orchestrates experimental producers only. It never selects an app pack,
activates weights, retries a failed case or assigns a qualification verdict.
"""
import argparse
import ctypes
import ctypes.util
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time

from context_qualification import quiet_preflight
from prefill_bench import terminate_child_tree, vm_snapshot
from quantization_inventory import unique_json
from vq_fused_reference import bounded
from vq_execution_profile import add_runtime_argument, recheck_runtime, select_runtime


def digest(path):
    result = hashlib.sha256()
    with path.open('rb') as file:
        for chunk in iter(lambda: file.read(1_000_000), b''):
            result.update(chunk)
    return result.hexdigest()


def inputs(path):
    raw = bounded(path, 1_000_000)
    data = unique_json(raw)
    if data.get('schema') != 1 or data.get('scope') != 'pilot' or len(data.get('cases', [])) != 6:
        raise ValueError('the frozen six-case input receipt is required')
    seen = set()
    for case in data['cases']:
        name = case['id']
        if not re.fullmatch('[a-z][a-z-]{0,63}', name) or name in seen or case['file'] != name + '.json':
            raise ValueError('invalid frozen case identity or filename')
        seen.add(name)
        token_raw = bounded(path.parent / case['file'], 32_000)
        tokens = unique_json(token_raw)
        if (not isinstance(tokens, list) or not 1 <= len(tokens) <= 2048
                or any(type(t) is not int or not 0 <= t < 248_320 for t in tokens)
                or tokens != case['tokens'] or hashlib.sha256(token_raw).hexdigest() != case['tokens_sha256']
                or case['positions'] != list(range(max(0, len(tokens) - 16), len(tokens)))):
            raise ValueError('frozen token contexts or output positions changed')
    return data, hashlib.sha256(raw).hexdigest()


def supervise(command, directory, timeout):
    before = quiet_preflight(13)
    env = {k: v for k, v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_', 'VQLAB_'))}
    directory.mkdir(exist_ok=False)
    identity = {'command': command, 'before': before, 'removed_override_names': sorted(set(os.environ) - set(env)),
                'scope': 'functional distribution pilot; no timing qualification'}
    (directory / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')
    lib = ctypes.CDLL(ctypes.util.find_library('proc'))
    samples = peak = 0
    last_pressure = 0
    failure = None
    with (directory / 'stdout.txt').open('w') as stdout, (directory / 'stderr.txt').open('w') as stderr:
        child = subprocess.Popen(command, env=env, stdout=stdout, stderr=stderr, start_new_session=True)
        started = time.monotonic()
        try:
            while child.poll() is None:
                usage = ctypes.create_string_buffer(296)  # Darwin rusage_info_v4, same observer as the initial producer pilots.
                if lib.proc_pid_rusage(child.pid, 4, usage) == 0:
                    footprint = max(int.from_bytes(usage.raw[72:80], 'little'), int.from_bytes(usage.raw[240:248], 'little'))
                    peak = max(peak, footprint); samples += 1
                    if footprint > 10_000_000_000:
                        raise RuntimeError('pilot exceeded its 10 GB process envelope')
                elif child.poll() is None:
                    raise RuntimeError('cannot observe pilot process memory')
                now = time.monotonic()
                if now - last_pressure >= 1:
                    if subprocess.check_output(['sysctl', '-n', 'kern.memorystatus_vm_pressure_level'], text=True).strip() != '1':
                        raise RuntimeError('pilot cancelled under OS memory pressure')
                    last_pressure = now
                if now - started > timeout:
                    raise RuntimeError('pilot exceeded its execution bound')
                time.sleep(.05)
        except BaseException as error:
            failure = str(error)
            raise
        finally:
            if child.poll() is None:
                terminate_child_tree(child)
            receipt = {'exit_code': child.returncode, 'failure': failure, 'sampled_peak_bytes': peak,
                       'samples': samples, 'after': vm_snapshot(), 'seconds': time.monotonic() - started}
            (directory / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
    if child.returncode or not samples:
        raise RuntimeError('pilot producer failed; preserved output must be inspected')
    return receipt


def run(options):
    frozen, frozen_hash = inputs(options.inputs)
    root = Path(__file__).resolve().parent
    if options.arm == 'native':
        if getattr(options, 'runtime', None) is not None:
            raise ValueError('native baseline does not accept a VQ runtime override')
        if options.binary is None:
            raise ValueError('native arm requires a frozen source-bound binary')
        binary = options.binary.resolve()
        producer = {name: digest(binary.parent / name) for name in
                    ('slotstream', 'mlx.metallib', 'build-identity.json', 'build-source.tar.gz')}
        if binary.name != 'slotstream':
            raise ValueError('use the source-bound slotstream executable')
    else:
        if any(x is None for x in (options.inventory, options.architecture, options.order_proof)):
            raise ValueError('VQ arm requires inventory, architecture and successful traversal proof')
        runtime_path, execution_profile = select_runtime(options.model, getattr(options, 'runtime', None))
        producer = {'reference_script': digest(root / 'vq_model_reference.py'),
                    'execution_profile': execution_profile, 'runtime_source': digest(runtime_path),
                    'architecture': digest(options.architecture), 'order_proof': digest(options.order_proof)}
    options.out.mkdir(parents=True, exist_ok=False)
    record = {'schema': 1, 'scope': 'pilot', 'arm': options.arm, 'inputs_sha256': frozen_hash,
              'runner_sha256': digest(Path(__file__)), 'producer': producer, 'cases': []}
    (options.out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')
    for case in frozen['cases']:
        tokens = options.inputs.parent / case['file']
        output = options.out / case['id']
        if options.arm == 'native':
            command = [str(binary), 'quantization-logits', '--model', str(options.model.resolve()),
                       '--tokens', str(tokens.resolve()), '--output', str(output.resolve())]
        else:
            command = [sys.executable, str(root / 'vq_model_reference.py'), '--model', str(options.model.resolve()),
                       '--tokens', str(tokens.resolve()), '--out', str(output.resolve()),
                       '--inventory', str(options.inventory.resolve()), '--architecture', str(options.architecture.resolve()),
                       '--order-proof', str(options.order_proof.resolve())]
            if getattr(options, 'runtime', None) is not None:
                command += ['--runtime', str(options.runtime.resolve())]
        observed = supervise(command, options.out / (case['id'] + '-supervision'), 900 if options.arm == 'native' else 14400)
        receipt = unique_json(bounded(output / 'receipt.json', 1_000_000))
        if options.arm == 'vq' and receipt.get('execution_profile') != execution_profile:
            raise ValueError('producer execution source differs from the selected reference profile')
        if (receipt['tokens_sha256'] != case['tokens_sha256'] or receipt['positions'] != case['positions']
                or receipt['prompt_chunk'] != 512 or receipt['tokens'] != case['tokens']
                or receipt['logits']['path'] != 'logits.f32'
                or receipt['logits']['bytes'] != len(case['positions']) * 248_320 * 4
                or (output / 'logits.f32').stat().st_size != receipt['logits']['bytes']
                or digest(output / 'logits.f32') != receipt['logits']['sha256']):
            raise ValueError('producer receipt does not match the frozen complete-vocabulary request')
        record['cases'].append({'id': case['id'], 'receipt_sha256': digest(output / 'receipt.json'), **observed})
        (options.out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')
        print(json.dumps({'completed': len(record['cases']), 'of': 6, 'case': case['id'], 'peak_bytes': observed['sampled_peak_bytes']}), flush=True)
    if inputs(options.inputs)[1] != frozen_hash or digest(Path(__file__)) != record['runner_sha256']:
        raise ValueError('pilot inputs or runner changed during execution')
    if options.arm == 'vq':
        recheck_runtime(options.model, getattr(options, 'runtime', None), execution_profile)
    record['complete'] = True
    (options.out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--arm', choices=('native', 'vq'), required=True)
    for key in ('inputs', 'model', 'out'):
        parser.add_argument('--' + key, type=Path, required=True)
    for key in ('binary', 'inventory', 'architecture', 'order-proof'):
        parser.add_argument('--' + key, type=Path)
    add_runtime_argument(parser)
    run(parser.parse_args())
