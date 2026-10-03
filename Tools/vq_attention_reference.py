#!/usr/bin/env python3
"""Isolate the first full-attention boundary after the full VQ parity probe.

Uses the authenticated layer-two output, the pinned unmodified attention call,
and a separately expanded version of that same call to localize differences.
This diagnostic does not replace the full-stack parity gate.
"""
import argparse
import hashlib
import json
from pathlib import Path

from context_qualification import quiet_preflight, verification_lock
from vq_fused_reference import bounded
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
        source = json.loads(bounded(options.fixture / 'model.json', 2_000_000))
        if source['artifact']['inventory_sha256'] != provenance['inventory_sha256'] or source['passes'] != [[100, 248044, 101], [102]]:
            raise ValueError('attention input reference identifies another artifact')
        entry = next(f for f in source['files'] if f['layer'] == 2 and f['step'] == 0)
        raw = bounded(options.fixture / entry['path'], 16_000_000)
        if len(raw) != entry['bytes'] or hashlib.sha256(raw).hexdigest() != entry['sha256']:
            raise ValueError('attention reference input digest mismatch')
        recheck_owned_headroom()
        import mlx.core as mx
        mx.set_memory_limit(1_000_000_000); mx.set_cache_limit(64_000_000)
        input_path = options.out / 'verified-input.safetensors'; input_path.write_bytes(raw)
        h = mx.load(str(input_path))['hidden']
        arch, vq = references(options.architecture, options.model / 'model.py')
        archive = Archive(options.model, options.inventory)
        try:
            model = load_model(options.model, archive, arch, vq)
            block = model.model.layers[3]; attn = block.self_attn; rope = model.model.rope
            x, _, injection = block.attn_hyper_connection(h)
            hc = block.attn_hyper_connection
            normalized = hc.hc_norm(h); down = hc.input_mix_weight_down(normalized)
            activated = arch.nn.silu(down / 4); up = hc.input_mix_weight_up(activated)
            qg = attn.q_proj(x).reshape(1, 3, 24, 512)
            q, gate = mx.split(qg, 2, axis=-1)
            q = attn.q_norm(q).transpose(0, 2, 1, 3)
            k = attn.k_norm(attn.k_proj(x).reshape(1, 3, 2, 256)).transpose(0, 2, 1, 3)
            v = attn.v_proj(x).reshape(1, 3, 2, 256).transpose(0, 2, 1, 3)
            arrays = {'attnInput': x, 'attnInject': injection, 'qgRaw': qg, 'qNormed': q, 'kNormed': k, 'v': v}
            arrays.update({'hcInput': h, 'hcWeight': hc.hc_norm.weight, 'hcNormalized': normalized,
                           'hcDown': down, 'hcActivated': activated, 'hcUp': up, 'hcGates': mx.sigmoid(up)})
            cos, sin = rope(mx.arange(3)[None])
            q, k = arch._rope_partial(q, cos[:, None], sin[:, None]), arch._rope_partial(k, cos[:, None], sin[:, None])
            arrays.update({'qRoped': q, 'kRoped': k})
            out = arch.scaled_dot_product_attention(q, k, v, cache=None, scale=attn.scale, mask='causal')
            arrays['sdpaOut'] = out
            expanded = attn.o_proj(out.transpose(0, 2, 1, 3).reshape(1, 3, -1) * mx.sigmoid(gate.reshape(1, 3, -1)))
            cache = model.make_cache()[3]
            actual = attn(x, rope, 'causal', cache, cache.indexer)
            mx.eval(expanded, actual)
            if not bool(mx.array_equal(expanded.view(mx.uint16), actual.view(mx.uint16)).item()):
                raise ValueError('expanded attention does not match the pinned whole call')
            arrays['attnOutput'] = actual
            after = h + (actual[..., None, :] * injection[..., None]).reshape(h.shape)
            arrays['afterAttn'] = after
            mixed, _, _ = block.mlp_hyper_connection(after)
            arrays['mlpInput'] = mixed
            path = options.out / 'attention.safetensors'
            mx.save_safetensors(str(path), arrays)
            if path.stat().st_size > 2_000_000 or max(physical().values()) > 2_000_000_000:
                raise ValueError('attention microscope exceeded its component bound')
            if instrument_identity()['sha256'] != instrument['sha256'] or hashlib.sha256(Path(__file__).read_bytes()).hexdigest() != own:
                raise ValueError('attention instrument changed')
            receipt = {'schema': 1, 'architecture_sha256': ARCH_SHA256, 'normalization': NORMALIZATION,
                       'artifact': provenance, 'instrument': instrument, 'producer_sha256': own, 'before': before,
                       'source_fixture': entry, 'expanded_equals_whole': True, 'memory': physical(),
                       'fixture': {'path': path.name, 'bytes': path.stat().st_size, 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()},
                       'qualification': 'unproven'}
            (options.out / 'attention.json').write_text(json.dumps(receipt, indent=2) + '\n')
            print(json.dumps(receipt), flush=True)
        finally:
            archive.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('model', 'inventory', 'architecture', 'fixture', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
