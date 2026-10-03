#!/usr/bin/env python3
"""Inspect the pinned VQ draft sidecar independently of trunk quantization.

No MLX, remote-code execution, model loading or product admission occurs here.
Header-only output explicitly leaves payload authenticity unverified. This is a
cost/compatibility instrument; tensor bytes are not a process-memory estimate.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import stat

from quantization_inventory import unique_json, validate_header

FILE_BYTES = 2_297_560_747
FILE_SHA256 = '31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585'
HEADER_SHA256 = 'c39b16ad910abc919c270ef22ab2fe1c3313c7c8107022be976a5607e05a5436'
MAX_HEADER_BYTES = 64_000


def describe(header, payload_bytes):
    validate_header(header, payload_bytes)
    metadata = header.get('__metadata__')
    if (not isinstance(metadata, dict) or metadata.get('format') != 'mlx'
            or metadata.get('mtplx_compatible') != 'false'):
        raise ValueError('draft sidecar requires its independent VQLab metadata')
    recipe = unique_json(metadata.get('vqlab_mtp', '').encode())
    if (recipe != {'bits': 6, 'group_size': 32, 'fa_idx': 3}
            or any(type(value) is not int for value in recipe.values())):
        raise ValueError('uninspected draft recipe; never inherit trunk bits or group size')
    tensors = {k: v for k, v in header.items() if k != '__metadata__'}
    if len(tensors) != 71 or set(tensors) - {'fc.weight', 'norm_e.weight', 'norm_h.weight'} != {
            k for k in tensors if k.startswith(('block.', 'mixer.'))}:
        raise ValueError('draft sidecar tensor family changed')
    triples = 0
    for name, value in tensors.items():
        if value['dtype'] != 'U32':
            continue
        if not name.endswith('.weight'):
            raise ValueError('draft packed data is not a weight')
        base = name[:-len('.weight')]
        scales, biases = tensors.get(base + '.scales'), tensors.get(base + '.biases')
        if (scales is None or biases is None or scales['dtype'] != 'BF16' or biases['dtype'] != 'BF16'
                or scales['shape'] != biases['shape'] or value['shape'][:-1] != scales['shape'][:-1]
                or value['shape'][-1] != scales['shape'][-1] * 6):
            raise ValueError('draft packed shape does not match its own six-bit group-32 recipe')
        triples += 1
    if triples != 20:
        raise ValueError('draft quantized family coverage changed')
    def size(value):
        lo, hi = value['data_offsets']
        return hi - lo
    experts = {k: v for k, v in tensors.items() if '.switch_mlp.' in k}
    if len(experts) != 9 or any(v['shape'][0] != 512 for v in experts.values()):
        raise ValueError('draft expert family coverage changed')
    expert_bytes = sum(size(v) for v in experts.values())
    if expert_bytes % 512:
        raise ValueError('draft expert records are incomplete')
    return {'quantization': {'kind': 'affine', 'bits': 6, 'group_size': 32},
            'full_attention_layer_index': 3, 'tensor_count': len(tensors), 'quantized_modules': triples,
            'tensor_payload_bytes': sum(size(v) for v in tensors.values()),
            'expert_payload_bytes': expert_bytes, 'expert_record_bytes': expert_bytes // 512,
            'other_tensor_bytes': sum(size(v) for k, v in tensors.items() if k not in experts),
            'largest_tensor_bytes': max(size(v) for v in tensors.values()),
            'normalization_and_fusion': 'unqualified; raw sidecar conventions require an independent adapter',
            'trunk_binding': 'unqualified', 'legacy_mtp_loader_compatible': False}


def inspect(path, verify_payload=False):
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW)
    with os.fdopen(fd, 'rb') as file:
        before = os.fstat(file.fileno())
        if not stat.S_ISREG(before.st_mode) or before.st_size != FILE_BYTES:
            raise ValueError('draft file does not match its pinned type or size')
        prefix = file.read(8)
        length = int.from_bytes(prefix, 'little')
        if len(prefix) != 8 or not 1 <= length <= MAX_HEADER_BYTES:
            raise ValueError('draft header exceeds its byte bound')
        raw = file.read(length)
        if len(raw) != length or hashlib.sha256(prefix + raw).hexdigest() != HEADER_SHA256:
            raise ValueError('draft header differs from its pinned identity')
        result = describe(unique_json(raw), FILE_BYTES - length - 8)
        if verify_payload:
            file.seek(0)
            digest = hashlib.sha256()
            for block in iter(lambda: file.read(1_000_000), b''):
                digest.update(block)
            if digest.hexdigest() != FILE_SHA256:
                raise ValueError('draft payload differs from its pinned identity')
        after = os.fstat(file.fileno())
        if (before.st_dev, before.st_ino, before.st_size, before.st_mtime_ns, before.st_ctime_ns) != (
                after.st_dev, after.st_ino, after.st_size, after.st_mtime_ns, after.st_ctime_ns):
            raise ValueError('draft file changed during inspection')
    return {'schema': 1, 'scope': 'independent draft storage and layout inventory', 'qualification': 'unproven',
            'file_bytes': FILE_BYTES, 'expected_file_sha256': FILE_SHA256,
            'header_sha256': HEADER_SHA256, 'payload_verified': verify_payload,
            'limits': 'Storage geometry only; no process floor, draft-cache, transient, acceptance or speed qualification.',
            **result}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--sidecar', type=Path, required=True)
    parser.add_argument('--verify-payload', action='store_true')
    parser.add_argument('--out', type=Path, required=True)
    options = parser.parse_args()
    result = inspect(options.sidecar, options.verify_payload)
    with options.out.open('x') as output:
        output.write(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))
