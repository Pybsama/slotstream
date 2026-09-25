"""Small, pinned real-weight samples: at most 2 MiB; no model code execution."""
import hashlib
import json
import pathlib
from fetch_headers import byte_range, RECEIPT, ROOT

config = json.loads((ROOT / 'candidate/config.json').read_text())
index = json.loads((ROOT / 'candidate/model.safetensors.index.json').read_text())['weight_map']
targets = [('protected_gate', 'model.layers.0.mlp.switch_mlp.gate_proj'),
           ('protected_down', 'model.layers.0.mlp.switch_mlp.down_proj'),
           ('packed14_gate', 'model.layers.2.mlp.switch_mlp.gate_proj'),
           ('packed8_down', 'model.layers.2.mlp.switch_mlp.down_proj'),
           ('packed8_gate', 'model.layers.27.mlp.switch_mlp.gate_proj'),
           ('ple', 'model.layers.1.ple.ple_embedding.ngram_embedding.shard_127')]
downloaded = 0
sources = []


def read_tensor(key, row_start=None, row_count=None):
    global downloaded
    file = index[key]
    header = json.loads((ROOT / 'headers' / (file + '.json')).read_text())
    tensor = header['tensors'][key]
    start, end = tensor['data_offsets']
    if row_start is not None:
        # Flatten leading expert/output axes for experts; PLE has only rows.
        rows = 1
        for size in tensor['shape'][:-1]: rows *= size
        row_bytes = (end - start) // rows
        assert 0 <= row_start < rows and 0 < row_count <= rows - row_start
        start += row_start * row_bytes
        end = start + row_count * row_bytes
    offset = 8 + header['header_bytes'] + start
    length = end - start
    assert downloaded + length <= 2 << 20, 'proof download limit'
    cache_key = hashlib.sha256(f"{RECEIPT['revision']}:{file}:{offset}:{length}".encode()).hexdigest()
    cache = ROOT / 'sample-ranges' / cache_key
    cache.parent.mkdir(exist_ok=True)
    checksum = cache.with_suffix('.sha256')
    if cache.exists() and checksum.exists():
        data = cache.read_bytes()
        if len(data) != length or hashlib.sha256(data).hexdigest() != checksum.read_text():
            raise ValueError('cached sample bytes changed')
    else:
        data = byte_range(file, offset, length, header['file_bytes'])
        cache.write_bytes(data)
        checksum.write_text(hashlib.sha256(data).hexdigest())
    downloaded += length
    sources.append({'tensor': key, 'file': file, 'offset': offset, 'count': length,
                    'sha256': hashlib.sha256(data).hexdigest(), 'range_cache': str(cache.relative_to(ROOT))})
    return data


for label, module in targets:
    dest = ROOT / 'real-fixtures' / label
    dest.mkdir(parents=True, exist_ok=True)
    if label == 'ple':
        rows, width = config['vq_ple']['shapes'][module]
        g = {'input': width, 'dimension': 8, 'groupSize': 32, 'codebookSize': 256,
             'storage': 'u8', 'output': 'bf16'}
        spans = [(0, 8), (rows // 2, 8), (rows - 8, 8)]
    else:
        q = config['vq_modules'][module]
        g = {'input': q['in'], 'dimension': q['dim'], 'groupSize': q['group'],
             'codebookSize': q['k'], 'storage': 'u8' if q['dim'] == 2 else 'packed32', 'output': 'f16'}
        spans = [(0, 8), (255 * q['out'] + 7, 8), (512 * q['out'] - 8, 8)]
    g['rows'] = sum(n for _, n in spans)
    (dest / 'geometry.json').write_text(json.dumps(g, indent=2) + '\n')
    (dest / 'codebook.bin').write_bytes(read_tensor(module + '.codebook'))
    for suffix, name in [('.codes', 'codes.bin'), ('.vq_scales', 'scales.bin')]:
        (dest / name).write_bytes(b''.join(read_tensor(module + suffix, first, count) for first, count in spans))
    (dest / 'source.json').write_text(json.dumps({'revision': RECEIPT['revision'], 'module': module, 'flattened_row_spans': spans}, indent=2) + '\n')

result = {'revision': RECEIPT['revision'], 'real_fixture_cases': len(targets),
          'total_range_bytes': downloaded, 'full_model_downloaded': False, 'ranges': sources}
(ROOT / 'samples-receipt.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({k: v for k, v in result.items() if k != 'ranges'}, indent=2))
