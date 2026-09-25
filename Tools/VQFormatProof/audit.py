"""Offline audit of a pinned checkpoint's small config/index/header receipts."""
import collections
import hashlib
import json
import math
import pathlib
import sys

if not __debug__:
    raise RuntimeError('Verification requires Python assertions; do not use -O')


def audit(root):
    root = pathlib.Path(root)
    receipt = json.loads((root / 'candidate-receipt.json').read_text())
    assert receipt['model'] == 'TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw'
    assert receipt['revision'] == '8684640a3956b01c47f5d47f9b999e2ab8b985f1'
    for name in ('config.json', 'model.safetensors.index.json'):
        digest = next(entry for entry in receipt['downloaded'] if entry['path'] == name)
        data = (root / 'candidate' / name).read_bytes()
        assert len(data) == digest['bytes'] and hashlib.sha256(data).hexdigest() == digest['sha256'], name
    config = json.loads((root / 'candidate/config.json').read_text())
    index = json.loads((root / 'candidate/model.safetensors.index.json').read_text())['weight_map']
    tensors, roles, geometries = {}, collections.Counter(), collections.Counter()
    widths = {'F16': 2, 'BF16': 2, 'F32': 4, 'U8': 1, 'U16': 2, 'U32': 4, 'I32': 4, 'I64': 8}
    for item in receipt['listed_weights']:
        header = json.loads((root / 'headers' / (item['name'] + '.json')).read_text())
        raw = (root / 'headers' / (item['name'] + '.header.bin')).read_bytes()
        assert len(raw) == header['header_bytes'] and hashlib.sha256(raw).hexdigest() == header['header_sha256']
        assert json.loads(raw) == header['tensors'], item['name']
        assert header['revision'] == receipt['revision']
        assert header['file_bytes'] == item['bytes']
        assert header['file'] == item['name']
        end = 0
        entries = [(key, val) for key, val in header['tensors'].items() if key != '__metadata__']
        for key, val in sorted(entries, key=lambda entry: entry[1]['data_offsets']):
            shape, span = val['shape'], val['data_offsets']
            assert all(type(n) is int and n >= 0 for n in shape), key
            assert val['dtype'] in widths, (key, val['dtype'])
            assert span[0] == end and span[1] >= span[0], (key, span, end)
            size = math.prod(shape) * widths[val['dtype']]
            assert span[1] - span[0] == size, key
            end = span[1]
            tensors[item['name'], key] = val
            role = ('mtp' if item['name'].startswith('mtp-') else
                    'vision' if item['name'] == 'model-vision-graft.safetensors' else
                    'expert' if '.switch_mlp.' in key else
                    'ple' if '.ngram_embedding.shard_' in key else 'text_resident')
            roles[role] += size
        assert end + 8 + header['header_bytes'] == item['bytes'], item['name']
    for key, file in index.items():
        assert (file, key) in tensors, (file, key)
    non_sidecar = {(file, key) for file, key in tensors if not file.startswith('mtp-')}
    assert non_sidecar == {(file, key) for key, file in index.items()}

    def tensor(key):
        return tensors[index[key], key]

    expected_experts = {f'model.layers.{layer}.mlp.switch_mlp.{projection}'
                        for layer in range(48) for projection in ('gate_proj', 'up_proj', 'down_proj')}
    assert set(config['vq_modules']) == expected_experts
    records = collections.Counter()
    for key, geometry in config['vq_modules'].items():
        codes, book, scales = [tensor(key + suffix) for suffix in ('.codes', '.codebook', '.vq_scales')]
        d, k, group = [geometry[n] for n in ('dim', 'k', 'group')]
        expected_width, expected_height = (640, 2560) if key.endswith('.down_proj') else (2560, 640)
        assert geometry['experts'] == 512 and geometry['in'] == expected_width and geometry['out'] == expected_height
        assert geometry['in'] % d == 0 and geometry['in'] % group == 0
        bits, nsub = (k - 1).bit_length(), geometry['in'] // d
        assert (d, k, group, codes['dtype']) in ((2, 256, 64, 'U8'), (4, 256, 64, 'U32'), (8, 16384, 64, 'U32'))
        last = (nsub + 31) // 32 * bits if codes['dtype'] == 'U32' else nsub
        assert codes['shape'] == [512, geometry['out'], last]
        assert book['shape'] == [k, d] and book['dtype'] == 'F16'
        assert scales['shape'] == [512, geometry['out'], geometry['in'] // group] and scales['dtype'] == 'F16'
        geometries[f"{codes['dtype']}/d{d}/K{k}/g{group}"] += 1
        layer = key.split('.')[2]
        records[layer] += sum(t['data_offsets'][1] - t['data_offsets'][0] for t in (codes, scales)) // 512
    ple = config['vq_ple']
    expected_ple = {f'model.layers.1.ple.ple_embedding.ngram_embedding.shard_{i}' for i in range(128)}
    assert len(ple['keys']) == 128 and set(ple['keys']) == expected_ple
    assert set(ple['shapes']) == expected_ple
    assert all(ple['geometry'][key] == value for key, value in {'k': 256, 'dim': 8, 'group': 32, 'row_bytes': 20}.items())
    for key in ple['keys']:
        rows, width = ple['shapes'][key]
        assert width == 160
        for suffix, dtype, shape in [('.codes', 'U8', [rows, 20]), ('.codebook', 'F16', [256, 8]), ('.vq_scales', 'F16', [rows, 5])]:
            value = tensor(key + suffix)
            assert value['shape'] == shape and value['dtype'] == dtype, key + suffix
    assert config['quantization']['mode'] == 'affine'
    assert config['quantization_config'] == config['quantization']
    affine = 0
    for key in index:
        if not key.endswith('.scales'):
            continue
        base = key[:-len('.scales')]
        q = dict(config['quantization'])
        q.update(config['quantization'].get(base, {}))
        assert q['mode'] == 'affine' and q['bits'] == 8 and q['group_size'] == 64, base
        w, s, b = [tensor(base + suffix) for suffix in ('.weight', '.scales', '.biases')]
        assert w['dtype'] == 'U32' and s['dtype'] == b['dtype'] == 'BF16', base
        assert s['shape'] == b['shape'] and w['shape'][:-1] == s['shape'][:-1], base
        assert w['shape'][-1] * 32 == s['shape'][-1] * q['group_size'] * q['bits'], base
        affine += 1
    return {'revision': receipt['revision'], 'header_files': len(receipt['listed_weights']),
            'all_tensors': len(tensors), 'indexed_tensors': len(index), 'expert_modules': 144,
            'ple_shards': 128, 'affine_modules': affine, 'expert_geometries': dict(geometries),
            'payload_bytes_by_role': dict(roles), 'per_expert_bytes_by_layer': dict(records),
            'model_inference_validated': False}


if __name__ == '__main__':
    print(json.dumps(audit(sys.argv[1]), indent=2))
