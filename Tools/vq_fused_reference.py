#!/usr/bin/env python3
"""Bounded Python-MLX oracle for the native VQ binding, not full-model parity.

Executes only five hash-verified, reviewed Metal strings. Does not import the
upstream model.py. Selected real rows come from quantization_fixture.py.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import tempfile
from quantization_inventory import unique_json, validate_header
from vq_kernel_sources import extract, RUNTIME_SHA256


def bounded(path, maximum):
    with path.open('rb') as handle:
        data = handle.read(maximum + 1)
    if not data or len(data) > maximum:
        raise ValueError('file exceeds bounded input size')
    return data


def validate_fixture(fixture, header):
    columns, dim, entries = fixture['columns'], fixture['dimensions'], fixture['entries']
    packing = fixture['packing']
    if columns not in (640, 2560) or fixture['group_size'] != 64:
        raise ValueError('unsupported expert columns or group size')
    if (dim, entries, packing) not in ((2, 256, 'unpacked8'), (2, 1024, 'words32'),
            (4, 256, 'words32'), (4, 2048, 'words32'), (8, 16384, 'words32')):
        raise ValueError('unsupported expert kernel family')
    words = ((columns // dim + 31) // 32) * (entries - 1).bit_length()
    expected = {
        'codes': ('U8', [7, columns // dim]) if packing == 'unpacked8' else ('U32', [7, words]),
        'codebook': ('F16', [entries, dim]), 'vq_scales': ('F16', [7, columns // 64]),
        'expected': ('F16', [7, columns]),
    }
    if set(header) - {'__metadata__'} != set(expected):
        raise ValueError('unexpected fixture tensors')
    if any((header[k]['dtype'], header[k]['shape']) != value for k, value in expected.items()):
        raise ValueError('fixture tensor metadata does not match its bounded layout')


def run(runtime, fixture_dirs, out):
    from context_qualification import verification_lock, quiet_preflight
    sources = extract(runtime)
    quiet_preflight(5)
    with verification_lock():
        import mlx.core as mx
        import numpy as np
        if mx.__version__ != '0.32.2':
            raise ValueError('reference requires MLX 0.32.2')
        mx.set_cache_limit(128_000_000)
        mx.set_memory_limit(512_000_000)
        out.mkdir(parents=True, exist_ok=False)
        cases = []
        for directory in fixture_dirs:
            manifest_bytes = bounded(directory / 'fixtures.json', 1_000_000)
            manifest = unique_json(manifest_bytes)
            if manifest['schema'] != 1 or len(manifest['fixtures']) > 32:
                raise ValueError('unsupported row manifest')
            for fixture in manifest['fixtures']:
                if fixture['columns'] not in (640, 2560):
                    continue  # PLE has a different operation and no fused expert.
                if not re.fullmatch(r'fixture-[0-9]+\.safetensors', fixture['path']):
                    raise ValueError('invalid row fixture filename')
                raw = bounded(directory / fixture['path'], 8_000_000)
                if hashlib.sha256(raw).hexdigest() != fixture['sha256'] or len(raw) != fixture['bytes']:
                    raise ValueError('row fixture identity mismatch')
                header_size = struct.unpack_from('<Q', raw)[0]
                if header_size > 1_000_000 or header_size + 8 > len(raw):
                    raise ValueError('invalid safetensors header extent')
                header = unique_json(raw[8:8 + header_size])
                validate_header(header, len(raw) - header_size - 8)
                validate_fixture(fixture, header)
                with tempfile.TemporaryDirectory() as temp:
                    verified = Path(temp) / 'verified.safetensors'; verified.write_bytes(raw)
                    a = mx.load(str(verified)); mx.eval(*a.values())
                columns, dim, entries = fixture['columns'], fixture['dimensions'], fixture['entries']
                packing = fixture['packing']; bits = (entries - 1).bit_length()
                if fixture['group_size'] != 64 or a['codes'].shape[0] != 7:
                    raise ValueError('unexpected expert geometry')
                codes = mx.stack([a['codes'], a['codes'][::-1]], axis=0)
                scales = mx.stack([a['vq_scales'], a['vq_scales'][::-1]], axis=0)
                book = a['codebook']
                for tokens in (1, 2, 3):
                    for pairing in ('broadcast', 'per-expert'):
                        n = tokens * 10
                        xrows, repeat = (tokens, 10) if pairing == 'broadcast' else (n, 1)
                        # Exactly representable bounded inputs, both signs and
                        # nontrivial routing. No random-library version drift.
                        values = ((np.arange(xrows * columns, dtype=np.int32) * 17 + 3) % 127 - 63) / 64
                        x = mx.array(values.astype(np.float32).reshape(xrows, columns)).astype(mx.bfloat16)
                        indices = mx.array(((np.arange(n, dtype=np.uint32) * 7 + 1) % 2).reshape(xrows, repeat))
                        simd = dim == 8 and n <= 20 and columns // 64 >= 32
                        key = ('d2u8' if packing == 'unpacked8' else 'd2packed') if dim == 2 else (
                            'd4packed' if dim == 4 else ('d8simd' if simd else 'd8scalar'))
                        original = 'const device T* xrow = x + (size_t)t * IN;'
                        source = sources[key]
                        if source.count(original) != 1:
                            raise ValueError('input row contract changed')
                        source = source.replace(original, 'const device T* xrow = x + (size_t)(t / (uint)XKREP) * IN;')
                        constants = {'T': 'half', 'BITS': bits, 'MAX_K': entries,
                                     'MAX_NSUB': columns // dim, 'MAX_NX4': columns // 4,
                                     'MAX_TILE': 512, 'SZ': 0, 'XKREP': repeat}
                        header = ''.join('#define %s %s\n' % p for p in constants.items())
                        kernel = mx.fast.metal_kernel(name='vq_reference_' + key + '_' + str(repeat),
                            input_names=['x', 'eidx', 'codes', 'codebook', 'scales', 'dims'],
                            output_names=['y'], source=source, header=header)
                        code_input = codes.view(mx.uint32) if packing == 'unpacked8' else codes
                        dims = mx.array([7, columns, dim, 64, n, entries], dtype=mx.int32)
                        result, = kernel(inputs=[x.astype(mx.float16), indices.reshape(-1), code_input, book, scales, dims],
                            grid=(32, 8, n) if simd else (7, n, 1),
                            threadgroup=(32, 8, 1) if simd else (7, 1, 1),
                            output_shapes=[(xrows, repeat, 7)], output_dtypes=[mx.float16])
                        expected = result.astype(mx.bfloat16)
                        mx.eval(expected)
                        if not bool(mx.all(mx.isfinite(expected)).item()):
                            raise ValueError('nonfinite reference output')
                        name = 'fused-%03d.safetensors' % len(cases)
                        mx.save_safetensors(str(out / name), {'x': x, 'indices': indices, 'codes': codes,
                            'codebook': book, 'vq_scales': scales, 'expected': expected})
                        data = bounded(out / name, 8_000_000)
                        cases.append({'path': name, 'sha256': hashlib.sha256(data).hexdigest(), 'bytes': len(data),
                            'columns': columns, 'dimensions': dim, 'entries': entries, 'group_size': 64,
                            'packing': packing, 'source_row_sha256': fixture['sha256'],
                            'source_manifest_sha256': hashlib.sha256(manifest_bytes).hexdigest(),
                            'source_repo': manifest['repo'], 'source_revision': manifest['revision'],
                            'kernel': key, 'tokens': tokens, 'pairing': pairing})
                        if len(cases) > 128 or mx.get_peak_memory() > 512_000_000:
                            raise ValueError('fused reference exceeds its pilot resource bound')
        record = {'schema': 1, 'runtime_sha256': RUNTIME_SHA256, 'mlx': mx.__version__,
            'scope': 'native binding parity for selected rows with the reviewed VQ 3.2/4.4 arithmetic; not full-model or VQ 2.1 runtime parity',
            'peak_mlx_bytes': mx.get_peak_memory(), 'fixtures': cases}
        (out / 'fused.json').write_text(json.dumps(record, indent=2) + '\n')
        print(json.dumps({'cases': len(cases), 'peak_mlx_bytes': record['peak_mlx_bytes']}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--runtime', type=Path, required=True)
    parser.add_argument('--fixtures', type=Path, action='append', required=True)
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    if len(args.fixtures) > 3:
        parser.error('at most three selected-row collections')
    run(args.runtime, args.fixtures, args.out)
