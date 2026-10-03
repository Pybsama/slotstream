#!/usr/bin/env python3
"""Exercise actual CLI pilot refusals with complete arguments and no allocation."""
import argparse
import copy
import json
import os
from pathlib import Path
import subprocess


def run(options):
    root = Path(__file__).resolve().parent.parent
    binary = options.binary.resolve()
    research = options.research_root.resolve()
    receipt = json.loads(options.validation_receipt.read_text())
    out = options.out.resolve()
    out.mkdir(exist_ok=False)
    profile = root / 'bench/quantization/performance-pilot-v1.json'
    cases = []
    wrong_profile = out / 'changed-profile.json'
    wrong_profile.write_bytes(profile.read_bytes() + b' ')
    oversized = out / 'oversized-profile.json'
    oversized.write_bytes(b' ' * 64_001)
    for name, path, message in [('profile-change', wrong_profile, 'frozen performance profile'),
                                ('profile-bound', oversized, 'metadata exceeds its bound')]:
        cases.append((name, path, None, [], message, {}))
    cases += [
        ('missing-validation', profile, None, ['--measure'], '--measure requires --validation-receipt', {}),
        ('orphan-validation', profile, options.validation_receipt.resolve(), [], '--measure requires --validation-receipt', {}),
        ('ambient-override', profile, None, [], 'requires no developer overrides', {'VQLAB_TEST_OVERRIDE': '1'})]
    mutations = [
        ('wrong-mode', lambda d: d.update(mode='measurement')),
        ('failed-validation', lambda d: d.update(passed=False)),
        ('wrong-profile-binding', lambda d: d.update(profile_sha256='0' * 64)),
        ('wrong-inventory', lambda d: d.update(inventory_sha256='0' * 64)),
        ('wrong-binary', lambda d: d['producer'].update(binary_sha256='0' * 64)),
        ('wrong-metallib', lambda d: d['producer'].update(metallib_sha256='0' * 64)),
        ('short-sequence', lambda d: d['generated'].pop()),
        ('short-logit-proof', lambda d: d['observed_logit_hashes'].pop()),
        ('wrong-logit-proof', lambda d: d['observed_logit_hashes'].__setitem__(0, '0' * 64)),
        ('over-budget-validation', lambda d: d.update(peak_process_bytes=10_000_000_001)),
        ('negative-peak', lambda d: d.update(peak_process_bytes=-1))]
    for name, mutate in mutations:
        altered = copy.deepcopy(receipt)
        mutate(altered)
        path = out / (name + '.json')
        path.write_text(json.dumps(altered) + '\n')
        cases.append((name, profile, path, ['--measure'], 'successful matching lean-path validation receipt', {}))
    results = []
    for name, profile_path, validation, flags, expected, override in cases:
        output = out / (name + '-output')
        command = [str(binary), 'quantization-performance-pilot', '--source-directory', str(research / 'candidate-3.2'),
                   '--source-inventory', str(research / 'inventory-3.2/inventory.json'),
                   '--profile', str(profile_path), '--output', str(output), *flags]
        if validation:
            command += ['--validation-receipt', str(validation)]
        environment = {k: v for k, v in os.environ.items()
                       if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_', 'VQLAB_'))}
        environment.update(override)
        result = subprocess.run(command, env=environment, capture_output=True, text=True, timeout=30)
        passed = result.returncode != 0 and expected in result.stderr and not output.exists()
        results.append(dict(case=name, passed=passed, code=result.returncode, stdout=result.stdout,
                            stderr=result.stderr, expected_error=expected, output_exists=output.exists()))
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
        if not passed:
            raise RuntimeError('pilot refusal failed: ' + name)
    print(json.dumps({'passed': len(results), 'output': str(out)}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'research-root', 'validation-receipt', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
