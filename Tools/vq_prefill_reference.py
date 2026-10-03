#!/usr/bin/env python3
"""Pinned large-prefill expert composition, with actual fused segmented dispatch.

Two prompt lengths cross the fused-decode boundary. Skewed routes exercise
partial and full tiles across more experts than one native staging batch.
Run under quantization_logit_run.supervise; this is not model qualification.
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
        mx.set_memory_limit(2_000_000_000)
        mx.set_cache_limit(64_000_000)
        _, runtime = references(options.architecture, options.model / 'model.py')
        expected_flags = {'_FUSED_GEMM': True, '_FUSED_GEMM_V2': True, '_GEMMSEG_RTILE': 32,
                          '_GEMMSEG_BF16IO': False, '_GEMMSEG_OT2': True, '_GEMMSEG_PH2V': True,
                          '_GEMMSEG_DSTORE': False, '_GEMMSEG_PIPE': False, '_GEMMSEG_XT_PAD': False,
                          '_SPEC_KERNELS': True, 'VQ_FUSED_MAX_N': 4096}
        if any(runtime[k] != v for k, v in expected_flags.items()):
            raise ValueError('pinned segmented-prefill dispatch flags changed')
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
            if not 0 < stride <= 2_000_000 or len(selected) * stride > 128_000_000:
                raise ValueError('record tensor exceeds its frozen bound')
            payload = b''.join(file.read(key, r * stride + off, min(1_000_000, stride - off))
                               for r in selected for off in range(0, stride, 1_000_000))
            return mx.array(np.frombuffer(payload, dtype=dtype).copy().reshape([len(selected)] + shape[1:]))

        layers = [0, 2]
        if options.allocation_classes:
            signatures = set(); layers = []
            for layer in range(48):
                descriptors = [config['vq_modules'][f'model.layers.{layer}.mlp.switch_mlp.{name}']
                               for name in ('gate_proj', 'up_proj', 'down_proj')]
                signature = json.dumps(descriptors, sort_keys=True, separators=(',', ':'))
                if signature not in signatures:
                    signatures.add(signature); layers.append(layer)
            if len(layers) != 2:
                raise ValueError('inspected artifacts require exactly two complete-record allocation classes')
        fixtures = []
        try:
            for layer in layers:
                ids = [i * 8 for i in range(63)] + [511]
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
                for count in (410, 512):
                    x = mx.array(np.sin(np.arange(count * 2560, dtype=np.float32) * .031).reshape(count, 2560), dtype=mx.bfloat16)
                    local = mx.array([[0] + [1 + (row * 3 + k) % 63 for k in range(9)] for row in range(count)], dtype=mx.uint32)
                    expected = module(x[None], local[None])[0]
                    mx.eval(expected)
                    if not bool(mx.all(mx.isfinite(expected)).item()):
                        raise ValueError('nonfinite complete routed expert output')
                    arrays[f'x{count}'] = x
                    arrays[f'routes{count}'] = mx.array(ids, dtype=mx.uint32)[local]
                    arrays[f'expected{count}'] = expected
                filename = f'prefill-{layer}.safetensors'
                mx.save_safetensors(str(options.out / filename), arrays)
                data = bounded(options.out / filename, 320_000_000)
                fixtures.append({'path': filename, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest(),
                                 'layer': layer, 'expert_ids': ids, 'projections': layouts})
                del module, arrays, codes, scales, book, x, local, expected
                gc.collect(); mx.clear_cache()
                if max(physical().values()) > 4_000_000_000:
                    raise ValueError('record reference exceeded its 4 GB prefill component bound')
            for file in files.values(): file.verify_unchanged()
            if instrument_identity()['sha256'] != instrument['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own_hash:
                raise ValueError('record reference instrument changed')
            kernel_names = sorted(runtime['_KERNELS'])
            if not any(name.startswith('vq_gemmseg2') for name in kernel_names):
                raise ValueError('reference did not execute the fused segmented prefill')
            result = {'schema': 1, 'scope': 'segmented prefill component; not model qualification',
                      'prefill_flags': expected_flags, 'kernel_names': kernel_names,
                      'runtime_sha256': inv['files']['model.py']['sha256'], 'artifact': {k:v for k,v in provenance.items() if k!='stamps'},
                      'instrument': instrument, 'record_script_sha256': own_hash, 'fixtures': fixtures,
                      'before': before, 'process_memory': physical(), 'peak_mlx_bytes': mx.get_peak_memory(),
                      'ranges': {name: {'bytes_read': f.bytes_read, 'range_sha256': f.range_hash.hexdigest()} for name,f in files.items()}}
            if options.allocation_classes: result['layer_coverage'] = 'allocation-classes-v1'
            (options.out / 'records.json').write_text(json.dumps(result, indent=2) + '\n')
            print(json.dumps({'fixtures': len(fixtures), 'cases': len(fixtures) * 2, 'memory': physical()}))
        finally:
            for file in files.values(): file.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('model', 'inventory', 'architecture', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--allocation-classes', action='store_true', help='One real layer per complete-record allocation class; preserves legacy fixtures by default')
    run(parser.parse_args())
