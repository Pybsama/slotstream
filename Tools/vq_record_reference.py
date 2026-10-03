#!/usr/bin/env python3
"""Complete real VQ expert records through the pinned routed SwiGLU.

This extends selected-output-row binding checks to gate, compiled activation,
up and down composed together. Fixed routes include duplicate experts and
both ends of the checkpoint domain. It is not model or task qualification.
The owning supervisor must enforce the shared 10 GB process envelope.
"""
import argparse
import gc
import hashlib
import json
from pathlib import Path
import struct

from context_qualification import quiet_preflight, verification_lock
from quantization_inventory import unique_json
from vq_fused_reference import bounded
from vq_model_reference import instrument_identity, physical, references, recheck_owned_headroom, verify_files
from vq_ple_stream import TensorFile


def run(options):
    instrument = instrument_identity()
    own_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    before = quiet_preflight(13)
    with verification_lock():
        options.out.mkdir(parents=True, exist_ok=False)
        provenance = verify_files(options.model, options.inventory)
        recheck_owned_headroom()
        import mlx.core as mx
        import numpy as np
        from mlx_lm.models.switch_layers import SwitchGLU
        mx.set_memory_limit(1_000_000_000)
        mx.set_cache_limit(64_000_000)
        _, runtime = references(options.architecture, options.model / 'model.py')
        config = unique_json(bounded(options.model / 'config.json', 1_000_000))
        inv = unique_json(bounded(options.inventory, 4_000_000))
        index = unique_json(bounded(options.model / 'model.safetensors.index.json', 4_000_000))['weight_map']
        files = {}

        def tensor(key, rows=None):
            filename = index[key]
            if filename not in files:
                f = inv['files'][filename]
                files[filename] = TensorFile(options.model / filename,
                    **{k: f[k] for k in ('file_bytes', 'header_bytes', 'header_sha256')})
            file = files[filename]; meta = file.header[key]
            shape = meta['shape']; nbytes = meta['data_offsets'][1] - meta['data_offsets'][0]
            dtype = {'U8': np.uint8, 'U32': np.dtype('<u4'), 'F16': np.dtype('<f2')}[meta['dtype']]
            selected = list(range(shape[0])) if rows is None else rows
            stride = nbytes // shape[0]
            if not 0 < stride <= 2_000_000 or len(selected) * stride > 32_000_000:
                raise ValueError('record tensor exceeds its frozen bound')
            payload = b''.join(file.read(key, r * stride + off, min(1_000_000, stride - off))
                               for r in selected for off in range(0, stride, 1_000_000))
            return mx.array(np.frombuffer(payload, dtype=dtype).copy().reshape([len(selected)] + shape[1:]))

        fixtures = []
        try:
            for layer in (0, 2):
                ids = [0, 1, 7, 511]
                module = SwitchGLU(2560, 640, len(ids))
                arrays = {}; layouts = []
                for projection in ('gate_proj', 'up_proj', 'down_proj'):
                    key = f'model.layers.{layer}.mlp.switch_mlp.{projection}'
                    g = config['vq_modules'][key]
                    codes = tensor(key + '.codes', ids)
                    scales = tensor(key + '.vq_scales', ids)
                    book = tensor(key + '.codebook')
                    setattr(module, projection, runtime['VQSwitchLinear'](codes, book, scales,
                        group_size=g['group'], pack_bits=g.get('pack_bits', 0),
                        in_features=g['in'] if g.get('pack_bits') else None))
                    for suffix, value in [('codes', codes), ('codebook', book), ('vq_scales', scales)]:
                        arrays[projection + '.' + suffix] = value
                    layouts.append({'columns': g['in'], 'dimensions': g['dim'], 'entries': g['k'],
                                    'group_size': g['group'], 'packing': 'words32' if g.get('pack_bits') else 'unpacked8'})
                module.eval()
                for count in (1, 2, 3):
                    x = mx.array(np.sin(np.arange(count * 2560, dtype=np.float32) * .031).reshape(count, 2560), dtype=mx.bfloat16)
                    local = mx.array([[(row + k) % len(ids) for k in range(10)] for row in range(count)], dtype=mx.uint32)
                    expected = module(x[None], local[None])[0]
                    mx.eval(expected)
                    if not bool(mx.all(mx.isfinite(expected)).item()):
                        raise ValueError('nonfinite complete routed expert output')
                    arrays[f'x{count}'] = x
                    arrays[f'routes{count}'] = mx.array(ids, dtype=mx.uint32)[local]
                    arrays[f'expected{count}'] = expected
                filename = f'record-{layer}.safetensors'
                mx.save_safetensors(str(options.out / filename), arrays)
                data = bounded(options.out / filename, 64_000_000)
                fixtures.append({'path': filename, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest(),
                                 'layer': layer, 'expert_ids': ids, 'projections': layouts})
                del module, arrays, codes, scales, book, x, local, expected
                gc.collect(); mx.clear_cache()
                if max(physical().values()) > 2_000_000_000:
                    raise ValueError('record reference exceeded its tighter 2 GB component bound')
            for file in files.values(): file.verify_unchanged()
            if instrument_identity()['sha256'] != instrument['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own_hash:
                raise ValueError('record reference instrument changed')
            result = {'schema': 1, 'scope': 'complete routed-expert component; not model qualification',
                      'runtime_sha256': inv['files']['model.py']['sha256'], 'artifact': {k:v for k,v in provenance.items() if k!='stamps'},
                      'instrument': instrument, 'record_script_sha256': own_hash, 'fixtures': fixtures,
                      'before': before, 'process_memory': physical(), 'peak_mlx_bytes': mx.get_peak_memory(),
                      'ranges': {name: {'bytes_read': f.bytes_read, 'range_sha256': f.range_hash.hexdigest()} for name,f in files.items()}}
            (options.out / 'records.json').write_text(json.dumps(result, indent=2) + '\n')
            print(json.dumps({'fixtures': len(fixtures), 'cases': len(fixtures) * 3, 'memory': physical()}))
        finally:
            for file in files.values(): file.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('model', 'inventory', 'architecture', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
