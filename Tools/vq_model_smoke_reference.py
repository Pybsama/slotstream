#!/usr/bin/env python3
"""Bounded complete-stack reference, three tokens then one real continuation.

Calls every unmodified pinned decoder block, preserving its exact pass shape.
Only one layer is evaluated at a time. Native execution may traverse all layers
per pass; layer-local state and every boundary are compared independently.
This is a functional parity fixture, not quality or throughput qualification.
Run under quantization_logit_run.supervise for pressure/process/time bounds.
"""
import argparse
import gc
import hashlib
import json
from pathlib import Path

from context_qualification import quiet_preflight, verification_lock
from vq_execution_profile import add_runtime_argument, recheck_runtime, select_runtime
from vq_model_reference import (ARCH_SHA256, NORMALIZATION, instrument_identity,
    load_model, physical, references, recheck_owned_headroom, verify_files)
from vq_ple_stream import Archive

PASSES = [[100, 248044, 101], [102]]
BATCHED_PASSES = [[100, 101, 248044, 102, 103, 104, 105, 106], [107, 108, 109]]


def run(options):
    passes = BATCHED_PASSES if options.batched else PASSES
    runtime_path, execution_profile = select_runtime(options.model, getattr(options, 'runtime', None))
    instrument = instrument_identity()
    own = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    before = quiet_preflight(13)
    with verification_lock():
        options.out.mkdir(parents=True, exist_ok=False)
        provenance = verify_files(options.model, options.inventory)
        recheck_owned_headroom()
        import mlx.core as mx
        mx.set_memory_limit(8_000_000_000)
        mx.set_cache_limit(128_000_000)
        arch, vq = references(options.architecture, runtime_path)
        archive = Archive(options.model, options.inventory)
        files, total = [], 0

        def save(layer, step, arrays):
            nonlocal total
            for value in arrays.values():
                mx.eval(value)
                if not bool(mx.all(mx.isfinite(value)).item()):
                    raise ValueError('nonfinite full-stack fixture')
            path = options.out / f'layer-{layer}-pass-{step}.safetensors'
            mx.save_safetensors(str(path), arrays)
            size = path.stat().st_size
            total += size
            if size > 16_000_000 or total > 512_000_000:
                raise ValueError('full-stack fixture exceeds frozen output bounds')
            files.append({'path': path.name, 'layer': layer, 'step': step, 'bytes': size,
                          'sha256': hashlib.sha256(path.read_bytes()).hexdigest(), 'keys': sorted(arrays)})

        try:
            model = load_model(options.model, archive, arch, vq)
            core, caches = model.model, model.make_cache()
            ids = [mx.array([p], dtype=mx.int64) for p in passes]
            hidden = [mx.tile(core.embed_tokens(tokens), (1, 1, core.hc)) for tokens in ids]
            for step, value in enumerate(hidden): save(-1, step, {'embedded': value})
            for layer in range(48):
                recheck_owned_headroom()
                block, cache = core.layers[layer], caches[layer]
                mx.eval(block.parameters())
                linear = block.layer_type == 'linear_attention'
                history = mx.full((1, 2), 248044, mx.int64)
                for step, tokens in enumerate(ids):
                    mask = None if linear else arch.create_attention_mask(hidden[step], cache)
                    conv = arch.create_ssm_mask(hidden[step], cache) if linear else None
                    indexer = cache.indexer if hasattr(cache, 'indexer') else None
                    hidden[step] = block(hidden[step], core.rope, mask, conv, cache, indexer, tokens, history)
                    history = mx.concatenate([history, tokens], axis=1)[:, -2:]
                    arrays = {'hidden': hidden[step]}
                    if linear:
                        arrays.update({'conv': cache[0], 'state': cache[1]})
                        if layer == 1: arrays['ple_conv'] = cache[2]
                    else:
                        arrays.update({'keys': cache.keys[:, :, :cache.offset],
                                       'values': cache.values[:, :, :cache.offset],
                                       'indexer': cache.indexer.keys})
                    save(layer, step, arrays)
                core.layers[layer] = None; caches[layer] = None
                del block, cache, arrays, indexer, mask, conv
                gc.collect(); mx.clear_cache()
                print(json.dumps({'layer': layer, 'memory': physical()}), flush=True)
                if max(physical().values()) > 4_000_000_000:
                    raise ValueError('full-stack reference exceeded its 4 GB process bound')
            for step, value in enumerate(hidden):
                mixed = core.hyper_connection_mixer(value)
                save(48, step, {'mixed': mixed, 'logits': model.lm_head(mixed).astype(mx.float32)})
            for file in archive.files.values(): file.verify_unchanged()
            recheck_runtime(options.model, getattr(options, 'runtime', None), execution_profile)
            if instrument_identity()['sha256'] != instrument['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own:
                raise ValueError('full-stack reference instrument changed')
            receipt = {'schema': 1, 'architecture_sha256': ARCH_SHA256, 'normalization': NORMALIZATION,
                'runtime_sha256': execution_profile['runtime_sha256'], 'execution_profile': execution_profile,
                       'artifact': provenance, 'instrument': instrument, 'producer_sha256': own,
                       'passes': passes, 'files': files, 'fixture_bytes': total,
                       'before': before, 'memory': physical(), 'mlx_peak_bytes': mx.get_peak_memory(),
                       'qualification': 'unproven', 'scope': 'complete stack arithmetic and continuation only'}
            (options.out / 'model.json').write_text(json.dumps(receipt, indent=2) + '\n')
            print(json.dumps({'complete': True, 'fixture_bytes': total, 'memory': receipt['memory']}), flush=True)
        finally:
            archive.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('model', 'inventory', 'architecture', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--batched', action='store_true', help='Eight-token pass and three-token continuation, requiring multiple native record batches')
    add_runtime_argument(parser)
    run(parser.parse_args())
