#!/usr/bin/env python3
"""Bounded dense-trunk parity fixture for the pinned VQ arithmetic profile.

Full artifact verification precedes lazy model loading. Only the first linear
attention block and its hyper-connection are evaluated and exported. This is
not full-model, mutable-cache, performance or quality qualification.
"""
import argparse
import hashlib
import json
from pathlib import Path

from context_qualification import quiet_preflight, verification_lock
from vq_model_reference import (ARCH_SHA256, NORMALIZATION, instrument_identity,
    load_model, physical, references, recheck_owned_headroom, verify_files)
from vq_ple_stream import Archive


def run(options):
    instrument = instrument_identity()
    own = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    before = quiet_preflight(13)
    with verification_lock():
        options.out.mkdir(parents=True, exist_ok=False)
        provenance = verify_files(options.model, options.inventory)
        recheck_owned_headroom()
        import mlx.core as mx
        import numpy as np
        from mlx.utils import tree_flatten
        mx.set_memory_limit(1_000_000_000)
        mx.set_cache_limit(64_000_000)
        arch, vq = references(options.architecture, options.model / 'model.py')
        archive = Archive(options.model, options.inventory)
        try:
            model = load_model(options.model, archive, arch, vq)
            block = model.model.layers[0]
            arrays = {}
            for name in ('linear_attn', 'attn_hyper_connection'):
                module = getattr(block, name)
                for key, value in tree_flatten(module.parameters()):
                    arrays['model.layers.0.' + name + '.' + key] = value
            if sum(a.nbytes for a in arrays.values()) > 128_000_000:
                raise ValueError('trunk payload exceeds component bound')
            for count in (1, 3, 17):
                h = mx.array(np.sin(np.arange(count * 10240, dtype=np.float32) * .013)
                             .reshape(1, count, 10240), dtype=mx.bfloat16)
                x, _, injection = block.attn_hyper_connection(h)
                cache = model.make_cache()[0]
                out = block.linear_attn(x, None, cache)
                values = {'hyper': h, 'mixed': x, 'inject': injection, 'output': out,
                          'conv': cache[0], 'state': cache[1]}
                # Same last input row after the completed first pass, exercising
                # retained convolution and recurrence rather than fresh zeros.
                continuation = block.linear_attn(x[:, -1:], None, cache)
                values.update({'continued': continuation, 'continued_conv': cache[0],
                               'continued_state': cache[1]})
                for name, value in values.items():
                    mx.eval(value)
                    if not bool(mx.all(mx.isfinite(value)).item()):
                        raise ValueError('nonfinite trunk fixture ' + name)
                    arrays[f'{name}{count}'] = value
            path = options.out / 'trunk.safetensors'
            mx.save_safetensors(str(path), arrays)
            if path.stat().st_size > 160_000_000 or max(physical().values()) > 2_000_000_000:
                raise ValueError('trunk fixture exceeds its bounded component envelope')
            for file in archive.files.values(): file.verify_unchanged()
            if instrument_identity()['sha256'] != instrument['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own:
                raise ValueError('trunk reference instrument changed')
            receipt = {'schema': 1, 'architecture_sha256': ARCH_SHA256,
                       'normalization': NORMALIZATION, 'artifact': provenance,
                       'instrument': instrument, 'producer_sha256': own,
                       'before': before, 'memory': physical(), 'mlx_peak_bytes': mx.get_peak_memory(),
                       'fixture': {'path': path.name, 'bytes': path.stat().st_size,
                                   'sha256': hashlib.sha256(path.read_bytes()).hexdigest()},
                       'token_rows': [1, 3, 17], 'qualification': 'unproven'}
            (options.out / 'trunk.json').write_text(json.dumps(receipt, indent=2) + '\n')
            print(json.dumps({'complete': True, 'fixture': receipt['fixture'], 'memory': receipt['memory']}), flush=True)
        finally:
            archive.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('model', 'inventory', 'architecture', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
