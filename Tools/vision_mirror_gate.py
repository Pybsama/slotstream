#!/usr/bin/env python3
"""Positive vision I/O regression using a tiny synthetic tower, not model weights.

Run the real CLI and MLX loader with one, two and three identical copies.
Require actual routed byte counts and byte-identical pixels/embeddings. Header
validation alone cannot pass this gate. Uses small MLX allocations, not Engine.
"""
import argparse
import json
import math
import os
from pathlib import Path
import shutil
import struct
import subprocess
import tempfile

from checkpoint_mirror_cli import fixture


def vision_fixture(directory, dtype):
    fixture(directory)
    path = directory / 'model.safetensors'
    original = path.read_bytes()
    length, = struct.unpack('<Q', original[:8])
    header = json.loads(original[8:8 + length])
    data = bytearray(original[8 + length:])
    shapes = {
        'patch_embed.proj.weight': [8, 3, 2, 16, 16], 'patch_embed.proj.bias': [8],
        'pos_embed.weight': [16, 8], 'merger.norm.weight': [8], 'merger.norm.bias': [8],
        'merger.linear_fc1.weight': [32, 32], 'merger.linear_fc1.bias': [32],
        'merger.linear_fc2.weight': [2560, 32], 'merger.linear_fc2.bias': [2560],
    }
    shapes.update({'blocks.0.' + name: shape for name, shape in {
        'norm1.weight': [8], 'norm1.bias': [8], 'norm2.weight': [8], 'norm2.bias': [8],
        'attn.qkv.weight': [24, 8], 'attn.qkv.bias': [24],
        'attn.proj.weight': [8, 8], 'attn.proj.bias': [8],
        'mlp.linear_fc1.weight': [16, 8], 'mlp.linear_fc1.bias': [16],
        'mlp.linear_fc2.weight': [8, 16], 'mlp.linear_fc2.bias': [8],
    }.items()})
    start = len(data)
    for name, shape in shapes.items():
        values = [1.0 if 'norm' in name and name.endswith('.weight') else (i % 7 - 3) / 64
                  for i in range(math.prod(shape))]
        if dtype == 'BF16':
            payload = b''.join(struct.pack('<f', v)[2:] for v in values)
        else:
            payload = struct.pack('<' + ('f' if dtype == 'F32' else 'e') * len(values), *values)
        header['vision_tower.' + name] = {'dtype': dtype, 'shape': shape,
                                         'data_offsets': [len(data), len(data) + len(payload)]}
        data.extend(payload)
    encoded = json.dumps(header).encode()
    path.write_bytes(struct.pack('<Q', len(encoded)) + encoded + data)
    (directory / 'config.json').write_text(json.dumps({'text_config': {}, 'vision_config': {
        'hidden_size': 8, 'num_heads': 2, 'depth': 1, 'patch_size': 16,
        'spatial_merge_size': 2, 'temporal_patch_size': 2, 'num_position_embeddings': 16,
    }}))
    (directory / 'preprocessor_config.json').write_text(json.dumps({
        'size': {'shortest_edge': 1024, 'longest_edge': 1024}}))
    return len(data) - start


def check(binary):
    root = Path(__file__).resolve().parent.parent
    env = {k: v for k, v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_'))}
    results = []
    with tempfile.TemporaryDirectory(prefix='slotstream-vision-mirror-') as temp:
        folder = Path(temp)
        for dtype in ['F32', 'F16', 'BF16']:
            primary = folder / dtype
            expected_bytes = vision_fixture(primary, dtype)
            replicas = [primary, folder / (dtype + '-copy1'), folder / (dtype + '-copy2')]
            for replica in replicas[1:]:
                shutil.copytree(primary, replica)
            baseline = None
            for copies in [1, 2, 3]:
                output = folder / f'{dtype}-{copies}-output'
                command = [str(binary), 'vision-parity', '--model', str(primary),
                           '--image', str(root / 'Tools/assets/vision_test/secret1.jpg'), '--out', str(output)]
                for replica in replicas[1:copies]:
                    command += ['--mirror', str(replica)]
                child = subprocess.run(command, env=env, capture_output=True, text=True, timeout=90)
                if child.returncode:
                    raise RuntimeError(f'{dtype}/{copies}: {child.stderr}')
                manifest = json.loads((output / 'manifest.json').read_text())
                served = manifest.pop('mirror_bytes', [])
                if copies > 1:
                    assert len(served) == copies and all(n > 0 for n in served), (dtype, copies, served)
                    assert sum(served) == expected_bytes, (served, expected_bytes)
                else:
                    assert served == [], served
                pixels = (output / 'pixels.bin').read_bytes()
                embed = (output / 'embed.bin').read_bytes()
                values = struct.unpack('<' + 'f' * (len(embed) // 4), embed)
                assert values and all(math.isfinite(v) for v in values) and any(v != 0 for v in values)
                current = (pixels, embed, manifest)
                if baseline is None:
                    baseline = current
                else:
                    assert current == baseline, f'{dtype}/{copies}: output differs from primary-only'
                results.append({'dtype': dtype, 'copies': copies, 'mirror_bytes': served,
                                'expected_bytes': expected_bytes, 'output_equal': True})
    print(json.dumps({'passed': True, 'runs': results}, indent=2))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary', type=Path, default=os.environ.get('SLOTSTREAM_TEST_BINARY', '.build/release/slotstream'))
    args = parser.parse_args()
    check(args.binary.resolve())
