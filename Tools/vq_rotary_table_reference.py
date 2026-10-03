#!/usr/bin/env python3
"""Freeze every FP32 rotary coefficient in the bounded native research horizon.

This is a finite reference table, not a new transcendental approximation.
It preserves the pinned GPU's exact FP32 outputs, including values adjacent
 to BF16 rounding boundaries. It does not extend model/context qualification.
"""
import argparse
import hashlib
import json
from pathlib import Path

from context_qualification import quiet_preflight, verification_lock
from vq_model_reference import instrument_identity, physical, references
from vq_rope_reference import EXPECTED


def run(options):
    own = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    identity = instrument_identity()
    before = quiet_preflight(13)
    with verification_lock():
        import mlx.core as mx
        import numpy as np
        mx.set_memory_limit(100_000_000)
        mx.set_cache_limit(16_000_000)
        arch, _ = references(options.architecture, options.runtime)
        rope = arch.RotaryEmbedding(64, 10_000_000.0)
        cosine, sine = rope(mx.arange(2054)[None])
        mx.eval(cosine, sine)
        values = [np.array(v.view(mx.uint32), dtype='<u4') for v in (cosine, sine)]
        inverse = np.array(rope.inv_freq.view(mx.uint32), dtype='<u4').tobytes()
        if hashlib.sha256(inverse).hexdigest() != EXPECTED['inverse']:
            raise ValueError('inverse reference changed')
        hashes = {}
        for name, value in zip(('cosine', 'sine'), values):
            if value.shape != (1, 2054, 64) or not np.array_equal(value[:, :, :32], value[:, :, 32:]):
                raise ValueError('unexpected rotary geometry or duplicated half')
            if hashlib.sha256(value[:, :512].tobytes()).hexdigest() != EXPECTED[name]:
                raise ValueError('original FP32 reference changed')
            hashes[name] = hashlib.sha256(value.tobytes()).hexdigest()
        raw = np.stack([v[0, :, :32] for v in values], axis=1).tobytes()
        if len(raw) != 2054 * 2 * 32 * 4:
            raise ValueError('rotary table byte count differs')
        if instrument_identity()['sha256'] != identity['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own:
            raise ValueError('rotary producer changed')
        options.out.mkdir(parents=True, exist_ok=False)
        (options.out / 'angles-f32le.bin').write_bytes(raw)
        result = {'schema': 1, 'producer_sha256': own, 'instrument': identity,
                  'before': before, 'memory': physical(), 'rows': 2054,
                  'shape': [2054, 2, 32], 'dtype': 'F32LE',
                  'table_sha256': hashlib.sha256(raw).hexdigest(),
                  'full_duplicated_fp32_sha256': hashes, 'qualification': 'unproven'}
        (options.out / 'table.json').write_text(json.dumps(result, indent=2) + '\n')
        print(json.dumps({k: result[k] for k in ('table_sha256', 'full_duplicated_fp32_sha256', 'qualification')}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('architecture', 'runtime', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
