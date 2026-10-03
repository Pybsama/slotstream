#!/usr/bin/env python3
"""Compare bounded disk PLE reads to resident upstream arithmetic and CPU rows."""
import argparse
import hashlib
import json
from pathlib import Path
import struct

from quantization_inventory import unique_json, validate_header
from vq_fused_reference import bounded
from vq_kernel_sources import RUNTIME_SHA256
from vq_ple_stream import Table, TensorFile, reference_class, streaming_module


def run(runtime, fixture_dirs, out):
    from context_qualification import verification_lock, quiet_preflight
    quiet_preflight(5)
    with verification_lock():
        import mlx.core as mx
        import numpy as np
        if mx.__version__ != '0.32.2':
            raise ValueError('PLE reference requires MLX 0.32.2')
        mx.set_cache_limit(128_000_000)
        mx.set_memory_limit(512_000_000)
        reference = reference_class(runtime)
        out.mkdir(parents=True, exist_ok=False)
        cases = []
        for directory in fixture_dirs:
            manifest_raw = bounded(directory / 'fixtures.json', 1_000_000)
            manifest = unique_json(manifest_raw)
            fixtures = [f for f in manifest['fixtures'] if f['columns'] == 160]
            if len(fixtures) != 1:
                raise ValueError('one inspected PLE fixture per collection required')
            f = fixtures[0]
            import re
            if not re.fullmatch('fixture-[0-9]+\\.safetensors', f['path']):
                raise ValueError('invalid fixture filename')
            raw = bounded(directory / f['path'], 1_000_000)
            if len(raw) != f['bytes'] or hashlib.sha256(raw).hexdigest() != f['sha256']:
                raise ValueError('PLE fixture identity mismatch')
            size = struct.unpack_from('<Q', raw)[0]
            if not 0 < size <= 100_000 or 8 + size > len(raw):
                raise ValueError('invalid PLE fixture header extent')
            header = unique_json(raw[8:8 + size])
            validate_header(header, len(raw) - size - 8)
            # Preserve the exact verified bytes in our new run directory.
            path = out / ('ple-%d.safetensors' % len(cases)); path.write_bytes(raw)
            with TensorFile(path, file_bytes=len(raw), header_bytes=size,
                    header_sha256=hashlib.sha256(raw[8:8 + size]).hexdigest()) as file:
                table = Table({k: (file, k) for k in ('codes', 'codebook', 'vq_scales')},
                    columns=160, dimensions=f['dimensions'], entries=f['entries'], group_size=f['group_size'])
                if table.row_count != 7 or header['expected']['dtype'] != 'F16' or header['expected']['shape'] != [7, 160]:
                    raise ValueError('unexpected PLE row oracle')
                a = mx.load(str(path)); mx.eval(*a.values())
                resident = reference(a['codes'], a['codebook'], a['vq_scales'],
                    group_size=32, packed_nsub=160 // f['dimensions'])
                streamed = streaming_module(table, reference)
                for shape, ids in [([1], [6]), ([2, 3], [6, 0, 6, 2, 1, 5]),
                        ([512], [i % 7 for i in range(512)]), ([8192], [6 - i % 7 for i in range(8192)])]:
                    indices = mx.array(ids, dtype=mx.int64).reshape(shape)
                    x, y = resident(indices), streamed(indices)
                    z = a['expected'][indices].astype(mx.bfloat16)
                    mx.eval(x, y, z)
                    raw_values = [np.array(v.view(mx.uint16)) for v in (x, y, z)]
                    if not np.array_equal(raw_values[0], raw_values[1]) or not np.array_equal(raw_values[0], raw_values[2]):
                        raise ValueError('PLE storage/reference/CPU product mismatch')
                    cases.append({'revision': manifest['revision'], 'fixture_sha256': f['sha256'],
                        'manifest_sha256': hashlib.sha256(manifest_raw).hexdigest(),
                        'dimensions': f['dimensions'], 'entries': f['entries'], 'shape': shape,
                        'equal_bf16_bits': True, 'output_sha256': hashlib.sha256(raw_values[0].tobytes()).hexdigest(),
                        'cumulative_payload_bytes_read': file.bytes_read,
                        'max_rows': table.max_rows, 'max_result_bytes': table.max_result_bytes})
                # Neither codes nor scales are retained as complete parameters.
                parameters = streamed.parameters()
                if set(parameters) != {'book'}:
                    raise ValueError('streaming module retained full-table parameters')
                file.verify_unchanged()
        receipt = {'schema': 1, 'runtime_sha256': RUNTIME_SHA256, 'mlx': mx.__version__,
            'scope': 'selected real PLE rows, storage and F16-product/BF16 parity; not full model quality',
            'peak_mlx_bytes': mx.get_peak_memory(), 'cases': cases}
        if receipt['peak_mlx_bytes'] > 512_000_000:
            raise ValueError('PLE reference exceeded its allocation bound')
        (out / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
        print(json.dumps({'cases': len(cases), 'peak_mlx_bytes': receipt['peak_mlx_bytes']}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--runtime', type=Path, required=True)
    parser.add_argument('--fixtures', type=Path, action='append', required=True)
    parser.add_argument('--out', type=Path, required=True)
    options = parser.parse_args()
    if not 1 <= len(options.fixtures) <= 3:
        parser.error('one to three selected-row collections required')
    run(options.runtime, options.fixtures, options.out)
