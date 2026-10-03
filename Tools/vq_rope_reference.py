#!/usr/bin/env python3
"""Freeze pinned rotary frequencies and the first 512 FP32 angle rows.

Compare Metal fast and precise power with the unchanged pinned architecture.
This binds the arithmetic microscope; it does not qualify longer contexts.
"""
import argparse
import hashlib
import json
from pathlib import Path

from context_qualification import quiet_preflight, verification_lock
from vq_model_reference import ARCH_SHA256, instrument_identity, physical, references

EXPECTED = {
    'inverse': '2fb3c351f0a3fc12c0b204e77660cca2c1bc373dae37f5d0a2bfe2b92cef1248',
    'cosine': '20be5bf2cc1ff4c4208827d99c0f95adb511816556777bc1e965fe782703fd60',
    'sine': '3887752075ec29f866d82da8322cba01421caec5a6c257aa1eaa6f708280aba7',
}


def run(options):
    identity = instrument_identity()
    own = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    before = quiet_preflight(13)
    with verification_lock():
        options.out.mkdir(parents=True, exist_ok=False)
        import mlx.core as mx
        import numpy as np
        mx.set_memory_limit(100_000_000); mx.set_cache_limit(16_000_000)
        if mx.default_device() != mx.gpu:
            raise ValueError('rotary reference requires the GPU default')
        arch, _ = references(options.architecture, options.runtime)
        rope = arch.RotaryEmbedding(64, 10_000_000.0)
        cosine, sine = rope(mx.arange(512)[None])
        arrays = {'inverse': rope.inv_freq, 'cosine': cosine, 'sine': sine}
        hashes = {}
        for name, value in arrays.items():
            mx.eval(value)
            raw = np.array(value.view(mx.uint32), dtype='<u4').tobytes()
            hashes[name] = hashlib.sha256(raw).hexdigest()
        if hashes != EXPECTED:
            raise ValueError('pinned rotary reference changed')
        observations = []
        exponents = mx.arange(0, 64, 2, dtype=mx.float32) / 64
        for mode in ('fast', 'precise'):
            source = ('uint i=thread_position_in_grid.x; '
                      f'output[i]=metal::{mode}::pow(base[0], -exponents[i]);')
            kernel = mx.fast.metal_kernel(name='slotstream_reference_rope_' + mode,
                input_names=['exponents', 'base'], output_names=['output'], source=source)
            actual = kernel(inputs=[exponents, mx.array([10_000_000.0], dtype=mx.float32)],
                grid=(32, 1, 1), threadgroup=(32, 1, 1), output_shapes=[(32,)], output_dtypes=[mx.float32])[0]
            mx.eval(actual)
            different = np.array(actual.view(mx.uint32)) != np.array(rope.inv_freq.view(mx.uint32))
            observations.append({'mode': mode, 'source': source, 'different': int(different.sum())})
            arrays[mode] = actual
        if observations[1]['different'] != 0:
            raise ValueError('precise power does not match the pinned rotary reference')
        fixture = options.out / 'rope.safetensors'
        mx.save_safetensors(str(fixture), arrays)
        if instrument_identity()['sha256'] != identity['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own:
            raise ValueError('rotary producer changed')
        result = {'schema': 1, 'producer_sha256': own, 'instrument': identity,
                  'architecture_sha256': ARCH_SHA256, 'before': before, 'memory': physical(),
                  'dim': 64, 'base': 10_000_000, 'start': 0, 'rows': 512, 'reference_sha256': hashes,
                  'fixture_sha256': hashlib.sha256(fixture.read_bytes()).hexdigest(),
                  'observations': observations, 'qualification': 'unproven'}
        (options.out / 'rope.json').write_text(json.dumps(result, indent=2) + '\n')
        print(json.dumps(result), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('architecture', 'runtime', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
