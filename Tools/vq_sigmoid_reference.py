#!/usr/bin/env python3
"""Freeze every finite BF16 sigmoid value from the pinned Python GPU runtime.

Compare the literal scalar Metal expression with explicit precise exponential
and BF16 intermediate rounding. This is arithmetic evidence, not a pack gate.
"""
import argparse
import hashlib
import json
from pathlib import Path

from context_qualification import quiet_preflight, verification_lock
from vq_model_reference import instrument_identity

ORIGINAL = ('auto x=input[i]; auto y=1/(1+metal::exp(metal::abs(x))); '
            'output[i]=(x<0)?y:1-y;')
PRECISE = ('float x=float(input[i]); bfloat16_t e=bfloat16_t(metal::precise::exp(metal::abs(x))); '
           'bfloat16_t d=bfloat16_t(1.0f+float(e)); bfloat16_t y=bfloat16_t(1.0f/float(d)); '
           'output[i]=bfloat16_t((x<0)?float(y):1.0f-float(y));')


def run(output):
    identity = instrument_identity()
    own = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    before = quiet_preflight(13)
    with verification_lock():
        output.mkdir(parents=True, exist_ok=False)
        import mlx.core as mx
        import numpy as np
        mx.set_memory_limit(100_000_000); mx.set_cache_limit(16_000_000)
        if mx.default_device() != mx.gpu:
            raise ValueError('sigmoid reference requires the GPU default')
        bits = np.arange(65536, dtype=np.uint16)
        bits = bits[(bits & 0x7f80) != 0x7f80]
        x = mx.array(bits).view(mx.bfloat16); expected = mx.sigmoid(x)
        mx.eval(expected)
        raw = np.array(expected.view(mx.uint16), dtype='<u2').tobytes()
        expected_hash = hashlib.sha256(raw).hexdigest()
        if expected_hash != 'c487ccb3208e0ad603a280dd5b17a28910f9487929a0ba9bdfb1f782b3722b32':
            raise ValueError('pinned finite BF16 reference changed')
        observations = []
        for name, source in [('original', ORIGINAL), ('precise', PRECISE)]:
            kernel = mx.fast.metal_kernel(name='slotstream_reference_sigmoid_' + name,
                input_names=['input'], output_names=['output'], source='uint i=thread_position_in_grid.x;' + source)
            actual = kernel(inputs=[x], grid=(x.size, 1, 1), threadgroup=(256, 1, 1),
                            output_shapes=[x.shape], output_dtypes=[mx.bfloat16])[0]
            mx.eval(actual)
            different = np.array(actual.view(mx.uint16)) != np.array(expected.view(mx.uint16))
            observations.append({'variant': name, 'source': source, 'different': int(different.sum()),
                                 'differing_inputs': np.array(x.astype(mx.float32))[different].tolist()})
        if observations[1]['different'] != 0:
            raise ValueError('precise BF16 candidate does not match reference')
        fixture = output / 'sigmoid.safetensors'
        mx.save_safetensors(str(fixture), {'x': x, 'expected': expected})
        if instrument_identity()['sha256'] != identity['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own:
            raise ValueError('sigmoid reference producer changed')
        result = {'schema': 1, 'producer_sha256': own, 'instrument': identity, 'before': before,
                  'values': len(bits), 'expected_output_sha256': expected_hash,
                  'fixture_sha256': hashlib.sha256(fixture.read_bytes()).hexdigest(),
                  'observations': observations, 'qualification': 'unproven'}
        (output / 'sigmoid.json').write_text(json.dumps(result, indent=2) + '\n')
        print(json.dumps(result), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, required=True)
    run(parser.parse_args().out)
