"""Mutation regressions for the offline pinned-format audit."""
import json
import hashlib
import pathlib
import shutil
import sys
import tempfile
from audit import audit

source = pathlib.Path(sys.argv[1])
passed = []
with tempfile.TemporaryDirectory(prefix='vq-audit-') as tmp:
    root = pathlib.Path(tmp)
    shutil.copytree(source / 'candidate', root / 'candidate')
    shutil.copytree(source / 'headers', root / 'headers')
    shutil.copy2(source / 'candidate-receipt.json', root / 'candidate-receipt.json')
    audit(root)
    header_file = root / 'headers/model-00012.safetensors.json'
    original = header_file.read_bytes()
    raw_file = root / 'headers/model-00012.safetensors.header.bin'
    original_raw = raw_file.read_bytes()
    fixture = json.loads(original)
    key = 'model.layers.2.mlp.switch_mlp.gate_proj.codes'
    tests = [
        ('revision', lambda d: d.update(revision='0' * 40)),
        ('file_size', lambda d: d.update(file_bytes=d['file_bytes'] + 1)),
        ('dtype', lambda d: d['tensors'][key].update(dtype='UNKNOWN')),
        ('shape_length', lambda d: d['tensors'][key]['shape'].__setitem__(-1, 139)),
        ('offset_overlap', lambda d: d['tensors'][key]['data_offsets'].__setitem__(0, 0)),
        ('out_of_file', lambda d: d['tensors'][key]['data_offsets'].__setitem__(1, d['file_bytes'] + 8)),
        ('negative_dimension', lambda d: d['tensors'][key]['shape'].__setitem__(0, -512)),
        ('same_width_dtype_corruption', lambda d: d['tensors']['model.layers.1.attn_hyper_connection.block_inject_weight.scales'].update(dtype='F16')),
    ]
    for name, mutate in tests:
        data = json.loads(original); mutate(data); header_file.write_text(json.dumps(data))
        try: audit(root)
        except (AssertionError, KeyError, ValueError): passed.append(name)
        else: raise RuntimeError('audit accepted ' + name)
        header_file.write_bytes(original)
    for name, file, mutate in [
        ('missing_index', 'model.safetensors.index.json', lambda d: d['weight_map'].pop(key)),
        ('wrong_index_file', 'model.safetensors.index.json', lambda d: d['weight_map'].__setitem__(key, 'model-00001.safetensors')),
        ('wrong_vq_geometry', 'config.json', lambda d: d['vq_modules']['model.layers.2.mlp.switch_mlp.gate_proj'].update(dim=4)),
        ('nondivisible_vq_input', 'config.json', lambda d: d['vq_modules']['model.layers.0.mlp.switch_mlp.gate_proj'].update(**{'in': 2561})),
        ('wrong_expert_count', 'config.json', lambda d: d['vq_modules']['model.layers.0.mlp.switch_mlp.gate_proj'].update(experts=511)),
        ('duplicate_ple_shard', 'config.json', lambda d: d['vq_ple']['keys'].__setitem__(0, d['vq_ple']['keys'][1])),
        ('unsupported_affine_mode', 'config.json', lambda d: d['quantization'].update(mode='mxfp4')),
        ('wrong_ple_shape', 'config.json', lambda d: d['vq_ple']['shapes'][d['vq_ple']['keys'][0]].__setitem__(1, 128)),
        ('wrong_affine_override', 'config.json', lambda d: d['quantization']['model.embed_tokens'].update(group_size=32)),
    ]:
        path = root / 'candidate' / file; previous = path.read_bytes()
        data = json.loads(previous); mutate(data); path.write_text(json.dumps(data))
        # Refresh only the mutation's metadata checksum to reach semantic
        # validation. Separate cases below prove unchanged receipts reject edits.
        receipt_path = root / 'candidate-receipt.json'; previous_receipt = receipt_path.read_bytes()
        receipt = json.loads(previous_receipt)
        for entry in receipt['downloaded']:
            if entry['path'] == file:
                entry['bytes'] = path.stat().st_size
                entry['sha256'] = hashlib.sha256(path.read_bytes()).hexdigest()
        receipt_path.write_text(json.dumps(receipt))
        try: audit(root)
        except (AssertionError, KeyError, ValueError): passed.append(name)
        else: raise RuntimeError('audit accepted ' + name)
        path.write_bytes(previous)
        receipt_path.write_bytes(previous_receipt)
    for file in ('config.json', 'model.safetensors.index.json'):
        path = root / 'candidate' / file; previous = path.read_bytes()
        path.write_bytes(previous + b' ')
        try: audit(root)
        except AssertionError: passed.append('changed_metadata_' + file)
        else: raise RuntimeError('changed metadata accepted')
        path.write_bytes(previous)
    raw_file.write_bytes(bytes([original_raw[0] ^ 1]) + original_raw[1:])
    try: audit(root)
    except AssertionError: passed.append('changed_raw_header')
    else: raise RuntimeError('changed raw header accepted')
    raw_file.write_bytes(original_raw)
print(json.dumps({'valid_checkpoint_passed': True, 'malformed_rejected': passed}, indent=2))
