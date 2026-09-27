"""Sampled VQ dot products against an independent high-precision oracle.

Does not import or run the checkpoint's model code or qualify its kernels.
"""
import argparse
import hashlib
import json
import math
import pathlib
import random
import shutil
import struct
import subprocess
import tempfile

from audit import audit
from test_proof import expected, real_fixtures, synthetic

if not __debug__:
    raise RuntimeError('Verification requires Python assertions; do not use -O')

ABS_TOL = 1e-4
REL_TOL = 2e-5


def digest(data):
    return hashlib.sha256(data).hexdigest()


def vectors(width, dimension, batch):
    """F16-quantized, token-distinct inputs; exact basis probes come first."""
    rng = random.Random(941 + width + batch)
    bases = [0, min(width - 1, 31 * dimension + 1),
             min(width - 1, 32 * dimension + 1), width - 1]
    values, exact = [], []
    for token in range(batch):
        if token < len(bases):
            row = [0.0] * width
            row[bases[token]] = 1.0 if token % 2 == 0 else -1.0
            exact.append(True)
        elif token == 4:
            row = [0.0] * width
            exact.append(True)
        elif token == 5:
            row = [(-0.25 if column % 2 else 0.25) for column in range(width)]
            exact.append(False)
        elif token == 6:
            row = [0.125] * width
            exact.append(False)
        else:
            row = [rng.uniform(-0.5, 0.5) for _ in range(width)]
            exact.append(False)
        values.extend(row)
    raw = b''.join(struct.pack('<e', value) for value in values)
    return raw, [v[0] for v in struct.iter_unpack('<e', raw)], exact


def check(binary, fixture, inputs, batch, modes, output_root):
    g = json.loads((fixture / 'geometry.json').read_text())
    decoded = expected(fixture)
    weights = [v[0] for v in struct.iter_unpack('<e', decoded)]
    raw, x, exact = vectors(g['input'], g['dimension'], batch)
    inputs.write_bytes(raw)
    oracle = []
    for token in range(batch):
        start = token * g['input']
        xv = x[start:start + g['input']]
        for row in range(g['rows']):
            at = row * g['input']
            # Whole-row arbitrary-precision decoding and fsum intentionally
            # differ from word extraction / serial native FP32 FMA.
            oracle.append(math.fsum(a * b for a, b in
                                    zip(xv, weights[at:at + g['input']])))
    oracle_bytes = b''.join(struct.pack('<d', value) for value in oracle)
    results = []
    for mode in modes:
        run = subprocess.run([str(binary), str(fixture), str(inputs), str(batch), mode],
                             capture_output=True)
        label = fixture.name + '-b' + str(batch) + '-' + mode
        (output_root / (label + '.stdout.bin')).write_bytes(run.stdout)
        (output_root / (label + '.stderr.txt')).write_bytes(run.stderr)
        assert run.returncode == 0, (label, run.stderr.decode())
        assert len(run.stdout) == batch * g['rows'] * 4, (label, 'wrong output length')
        actual = [v[0] for v in struct.iter_unpack('<f', run.stdout)]
        assert all(math.isfinite(v) for v in actual), (label, 'non-finite output')
        maximum = 0.0
        for index, (want, got) in enumerate(zip(oracle, actual)):
            error = abs(got - want)
            maximum = max(maximum, error)
            if exact[index // g['rows']]:
                assert struct.pack('<f', got) == struct.pack('<f', want), (
                    label, index, 'basis/zero mismatch', got, want)
            else:
                assert error <= ABS_TOL + REL_TOL * abs(want), (
                    label, index, 'fixed numerical budget exceeded', got, want, error)
        metadata = json.loads(run.stderr)
        expected_bytes = (g['rows'] * (g['input'] // g['dimension'] if g['storage'] == 'u8'
                          else ((g['input'] // g['dimension'] + 31) // 32) *
                          (g['codebookSize'] - 1).bit_length() * 4)
                          + g['codebookSize'] * g['dimension'] * 2
                          + g['rows'] * (g['input'] // g['groupSize']) * 2
                          + len(raw) + len(run.stdout))
        assert metadata['explicit_metal_buffer_bytes'] == (expected_bytes if mode == 'metal' else 0)
        if mode == 'metal':
            assert metadata['explicit_metal_buffer_bytes'] < 2 * 1024 * 1024
        results.append({'case': label, 'mode': mode, 'batch': batch, 'rows': g['rows'],
                        'input_width': g['input'], 'values': len(actual),
                        'max_abs_error': maximum, 'input_sha256': digest(raw),
                        'decoded_weight_sha256': digest(decoded),
                        'oracle_f64_sha256': digest(oracle_bytes),
                        'output_f32_sha256': digest(run.stdout), **metadata})
    return results


def reject_cases(binary, fixture, temp, modes, output_root):
    rejected = []
    g = json.loads((fixture / 'geometry.json').read_text())
    good = b'\0\0' * g['input']
    inputs = temp / 'reject-input.bin'
    inputs.write_bytes(good)
    cases = [(label, str(batch), good, fixture) for label, batch in
             [('zero_batch', 0), ('negative_batch', -1), ('over_batch', 129),
              ('huge_batch', 2**63 - 1)]]
    cases += [('malformed_batch', 'not-int', good, fixture),
              ('short_input', '1', good[:-1], fixture),
              ('extra_input', '1', good + b'\0', fixture),
              ('nan_input', '1', struct.pack('<H', 0x7e00) + good[2:], fixture),
              ('inf_input', '1', struct.pack('<H', 0x7c00) + good[2:], fixture)]
    ple = temp / 'reject-ple'
    synthetic(ple, 8, 256, 32, 160, 'u8', 'bf16')
    cases.append(('ple_not_projection', '1', b'\0\0' * 160, ple))
    overflow = temp / 'reject-overflow'
    shutil.copytree(fixture, overflow)
    (overflow / 'codebook.bin').write_bytes(struct.pack('<e', 65504.0) * g['codebookSize'] * g['dimension'])
    (overflow / 'scales.bin').write_bytes(struct.pack('<e', 2.0) * g['rows'] * (g['input'] // g['groupSize']))
    cases.append(('decoded_weight_overflow', '1', good, overflow))
    for label, batch, data, path in cases:
        inputs.write_bytes(data)
        for mode in modes:
            run = subprocess.run([str(binary), str(path), str(inputs), batch, mode], capture_output=True)
            (output_root / (label + '-' + mode + '.stderr.txt')).write_bytes(run.stderr)
            assert run.returncode != 0 and run.stdout == b'', (label, mode, 'accepted malformed input')
            rejected.append({'case': label, 'mode': mode, 'exit': run.returncode})
    return rejected


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('binary', type=pathlib.Path)
    parser.add_argument('--real-root', type=pathlib.Path)
    parser.add_argument('--out', type=pathlib.Path, required=True)
    parser.add_argument('--mode', choices=['cpu', 'metal', 'both'], default='both')
    parser.add_argument('--smoke', action='store_true')
    args = parser.parse_args()
    args.binary = args.binary.resolve()
    args.out.mkdir(parents=True, exist_ok=True)
    modes = ['cpu', 'metal'] if args.mode == 'both' else [args.mode]
    verified, audit_result, reference = {}, None, None
    if args.real_root:
        audit_result = audit(args.real_root)
        receipt = json.loads((args.real_root / 'candidate-receipt.json').read_text())
        wanted = next(r for r in receipt['downloaded'] if r['path'] == 'model.py')
        data = (args.real_root / 'candidate/model.py').read_bytes()
        assert len(data) == wanted['bytes'] and digest(data) == wanted['sha256']
        reference = {'path': 'candidate/model.py', 'sha256': digest(data), 'executed': False}
        # Verify every original fixture, even though PLE has no projection.
        verified = real_fixtures(args.real_root / 'real-fixtures')
    results = []
    with tempfile.TemporaryDirectory(prefix='slotstream-vq-projection-') as name:
        temp = pathlib.Path(name)
        fixture = temp / 'u8_d2'
        synthetic(fixture, 2, 256, 64, 2560, 'u8', 'f16')
        results += check(args.binary, fixture, temp / 'input.bin', 1, modes, args.out)
        if not args.smoke:
            cases = [(fixture, [7, 32])]
            for label, dimension, k, width in [('packed8_d4', 4, 256, 640),
                                              ('packed14_d8', 8, 16384, 2560),
                                              ('packed14_tail', 8, 16384, 640)]:
                path = temp / label
                synthetic(path, dimension, k, 64, width, 'packed32', 'f16')
                cases.append((path, [1, 7, 32]))
            maximum = temp / 'maximum'
            synthetic(maximum, 8, 16384, 64, 4096, 'packed32', 'f16', rows=64)
            cases.append((maximum, [128]))
            cases.extend((path, [1, 7, 32]) for path in sorted(verified) if path.name != 'ple')
            for path, batches in cases:
                for batch in batches:
                    results += check(args.binary, path, temp / 'input.bin', batch, modes, args.out)
            rejected = reject_cases(args.binary, fixture, temp, modes, args.out)
        else:
            rejected = []
    report = {'contract': 'sampled F16 weights/inputs, F32 outputs; no model/reference-kernel parity',
              'abs_tolerance': ABS_TOL, 'rel_tolerance': REL_TOL,
              'basis_and_zero_exact': True, 'passed': results, 'rejected': rejected,
              'verified_real_sources': [v for p, v in sorted(verified.items()) if p.name != 'ple'],
              'header_audit': audit_result, 'reference_text': reference,
              'binary_sha256': digest(args.binary.read_bytes()),
              'full_projection_validated': False, 'model_inference_validated': False,
              'performance_validated': False, 'process_peak_memory_validated': False}
    (args.out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'passed': len(results), 'output_values': sum(r['values'] for r in results),
                      'rejected': len(rejected), 'real_cases': sum(r['case'].split('-b')[0] in
                        [p.name for p in verified] for r in results),
                      'max_abs_error': max(r['max_abs_error'] for r in results)}))


if __name__ == '__main__':
    main()
