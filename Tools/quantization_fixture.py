#!/usr/bin/env python3
"""Extract small VQ row fixtures at pinned HTTP ranges; never execute model.py.

Each fixture includes a scalar CPU half-precision decoding oracle and hashes
of the exact ranges. Header identities are bound to the inspected inventory.
This does not verify a complete upstream payload or qualify the full model.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct
from quantization_inventory import Remote, unique_json, validate_header, DTYPES, product


def decode(codes, book, scales, *, columns, dim, entries, group, packing, code_stride):
    bits = (entries - 1).bit_length()
    result = bytearray()
    rows = len(codes) // code_stride
    for row in range(rows):
        raw = codes[row * code_stride:(row + 1) * code_stride]
        integer = int.from_bytes(raw, 'little')
        width = 8 if packing == 'unpacked8' else 16 if packing == 'unpacked16' else bits
        for column in range(columns):
            code = (integer >> ((column // dim) * width)) & ((1 << width) - 1)
            if code >= entries:
                raise ValueError('code is outside codebook')
            weight = struct.unpack_from('<e', book, (code * dim + column % dim) * 2)[0]
            scale = struct.unpack_from('<e', scales, (row * (columns // group) + column // group) * 2)[0]
            result += struct.pack('<e', weight * scale)
    return bytes(result)


def safetensors(arrays):
    header = {}; payload = bytearray()
    for name, dtype, shape, data in arrays:
        if len(data) != product([*shape, DTYPES[dtype]]):
            raise ValueError('fixture tensor shape mismatch')
        header[name] = {'dtype': dtype, 'shape': shape, 'data_offsets': [len(payload), len(payload) + len(data)]}
        payload += data
    encoded = json.dumps(header, separators=(',', ':')).encode()
    encoded += b' ' * (-len(encoded) % 8)
    return struct.pack('<Q', len(encoded)) + encoded + payload


def extract(inventory_path, out):
    inv = unique_json(inventory_path.read_bytes())
    remote = Remote(inv['repo'], inv['revision'], maximum_bytes=768_000_000)
    headers = unique_json((inventory_path.parent / 'headers.json').read_bytes())
    tensors = {k: (shard, v) for shard, h in headers.items() for k, v in h.items() if k != '__metadata__'}
    config_data = (inventory_path.parent / 'config.json').read_bytes()
    if hashlib.sha256(config_data).hexdigest() != inv['files']['config.json']['sha256']:
        raise ValueError('local config identity changed')
    config = unique_json(config_data)
    seen = set(); selected = []
    for name, geometry in sorted(config['vq_modules'].items()):
        signature = tuple(geometry.get(k, 0) for k in ['in', 'out', 'dim', 'k', 'group', 'pack_bits'])
        if signature in seen:
            continue
        seen.add(signature)
        packing = 'words32' if geometry.get('pack_bits') else 'unpacked8' if geometry['k'] <= 256 else 'unpacked16'
        selected.append((name, geometry, packing))
    name = config['vq_ple']['keys'][0]; g = config['vq_ple']['geometry']
    selected.append((name, {'in': config['vq_ple']['shapes'][name][1], 'dim': g['dim'], 'k': g['k'], 'group': g['group']}, 'bytes'))
    out.mkdir(parents=True, exist_ok=False)
    fixtures = []; verified = set()
    for i, (name, g, packing) in enumerate(selected):
        arrays = []; ranges = []; values = {}
        for suffix in ['codes', 'codebook', 'vq_scales']:
            shard, tensor = tensors[name + '.' + suffix]
            receipt = inv['files'][shard]
            if shard not in verified:
                prefix, total = remote.get(shard, start=0, count=8)
                length = struct.unpack('<Q', prefix)[0]
                if length != receipt['header_bytes'] or total != receipt['file_bytes']:
                    raise ValueError('upstream shard identity changed')
                data, _ = remote.get(shard, start=8, count=length)
                if hashlib.sha256(data).hexdigest() != receipt['header_sha256']:
                    raise ValueError('upstream header digest changed')
                observed = unique_json(data)
                validate_header(observed, total - 8 - length)
                if observed != headers[shard]:
                    raise ValueError('local headers disagree with pinned upstream')
                verified.add(shard)
            shape = tensor['shape'] if suffix == 'codebook' else [7, tensor['shape'][-1]]
            count = product([*shape, DTYPES[tensor['dtype']]])
            offset = 8 + receipt['header_bytes'] + tensor['data_offsets'][0]
            data, total = remote.get(shard, start=offset, count=count)
            if total != receipt['file_bytes']:
                raise ValueError('upstream file size changed')
            values[suffix] = data
            arrays.append((suffix, tensor['dtype'], shape, data))
            ranges.append({'shard': shard, 'tensor': name + '.' + suffix, 'offset': offset,
                           'bytes': count, 'sha256': hashlib.sha256(data).hexdigest()})
        oracle = decode(values['codes'], values['codebook'], values['vq_scales'], columns=g['in'], dim=g['dim'],
                        entries=g['k'], group=g['group'], packing=packing, code_stride=len(values['codes']) // 7)
        arrays.append(('expected', 'F16', [7, g['in']], oracle))
        payload = safetensors(arrays); filename = f'fixture-{i}.safetensors'
        (out / filename).write_bytes(payload)
        fixtures.append({'path': filename, 'sha256': hashlib.sha256(payload).hexdigest(), 'bytes': len(payload),
                         'module': name, 'columns': g['in'], 'dimensions': g['dim'], 'entries': g['k'],
                         'group_size': g['group'], 'packing': packing, 'ranges': ranges})
    result = {'schema': 1, 'repo': inv['repo'], 'revision': inv['revision'],
              'inventory_sha256': hashlib.sha256(inventory_path.read_bytes()).hexdigest(), 'fixtures': fixtures,
              'network_bytes': remote.received_bytes, 'scope': 'selected real rows, not full artifact parity'}
    (out / 'fixtures.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--inventory', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    result = extract(args.inventory, args.out)
    print(json.dumps({'revision': result['revision'], 'fixtures': len(result['fixtures']), 'network_bytes': result['network_bytes']}))
