#!/usr/bin/env python3
"""Experimental bounded text reference for pinned Flash Next VQ candidates.

One layer's weights are materialized at a time. PLE uses checked positional
reads, and only selected full-vocabulary logit rows reach disk. The unchanged
upstream arithmetic runs with an explicit chunk schedule. This instrument
does not qualify a model or update historical fixtures or the native loader.
"""
import argparse
import ast
import ctypes
import ctypes.util
import gc
import hashlib
import importlib.metadata
import importlib.util
import json
import os
from pathlib import Path
import re
import resource
import subprocess
import sys
import threading
import time

from quantization_inventory import unique_json
from quantization_quality import VOCABULARY
from vq_fused_reference import bounded
from vq_kernel_sources import RUNTIME_SHA256
from vq_ple_stream import Archive, streaming_module, stamp

ARCH_SHA256 = 'd6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87'
ARCH_REVISION = '2097324ed04ff76078366c77148b88b9db612ba2'
ARTIFACTS = {
    'a4e1b44631619ba440d985e324d95dd106536a3d': (
        'TheDrainFlorist/Qwen3.8-Flash-Next-VQ-3.2bpw',
        '75d7d9b1bfa7762e46ef7c512f6779b43fbd1a1a7f9715684a79f6b01f07cfe5',
        '1d0a66f4382f12a3ef512b3181a6e7c01fe2d6d3c5cbd11f6ebb3d0dd6184168'),
    '0f35dc817238bdbabdac208db731470cd30a7c0a': (
        'TheDrainFlorist/Qwen3.8-Flash-Next-VQ-4.4bpw',
        '9ca97027fc253eb6ad14a2db0d0df5aec729403c8af8b4d59194c9e6a3dff458',
        '2cc5122dd575027f70f2b584f6352c70ad4328f54051ee878e2a72dc420d4228'),
}
PROCESS_LIMIT = 10_000_000_000
NORMALIZATION = 'vq-raw-zero-centered-to-pr1788-folded-bf16-v1'
_LIBPROC = None


def instrument_identity():
    """Bind traversal proofs to actual source and installed runtime bytes."""
    def digest(path):
        result = hashlib.sha256()
        with path.open('rb') as file:
            for chunk in iter(lambda: file.read(1_000_000), b''):
                result.update(chunk)
        return result.hexdigest()

    root = Path(__file__).resolve().parent
    scripts = ('vq_model_reference.py', 'vq_ple_stream.py', 'vq_fused_reference.py',
               'vq_kernel_sources.py', 'quantization_inventory.py', 'quantization_quality.py',
               'context_qualification.py', 'prefill_bench.py', 'memory_gate.py')
    sources = {name: digest(root / name) for name in scripts}
    packages = {}
    for name in ('mlx', 'mlx-metal', 'mlx-lm', 'numpy'):
        distribution = importlib.metadata.distribution(name)
        files = {str(file): digest(Path(distribution.locate_file(file)))
                 for file in distribution.files
                 if str(file).endswith(('.py', '.so', '.dylib', '.metallib'))}
        if not files:
            raise ValueError('runtime distribution has no inspectable source or binary files')
        packages[name] = {'version': distribution.version, 'files': files}
    record = {'scripts': sources, 'packages': packages, 'python': sys.version}
    canonical = json.dumps(record, sort_keys=True, separators=(',', ':')).encode()
    return dict(record, sha256=hashlib.sha256(canonical).hexdigest())


def checked_source(path, digest):
    raw = bounded(path, 1_000_000)
    if hashlib.sha256(raw).hexdigest() != digest:
        raise ValueError('reference source identity mismatch: ' + path.name)
    return raw


def recheck_owned_headroom():
    """Recheck real conditions while already owning the model lock.

    The ordinary preflight also probes that lock, so calling it recursively
    would reject this very process after full-file verification.
    """
    from prefill_bench import vm_snapshot
    state = vm_snapshot()
    if state['reclaimable_bytes'] < 13_000_000_000:
        raise RuntimeError('reference lost its required 13 GB real headroom')
    pressure = subprocess.check_output(['sysctl', '-n', 'kern.memorystatus_vm_pressure_level'],
        text=True, timeout=3).strip()
    if pressure != '1':
        raise RuntimeError('OS memory pressure is not normal')
    active = subprocess.check_output(['ps', '-axo', 'comm='], text=True, timeout=3)
    if any(Path(row.strip()).name in ('swift-frontend', 'swift-driver', 'slotstream', 'slotstream-checks')
           for row in active.splitlines()):
        raise RuntimeError('competing compiler or model process')
    return state


def references(architecture, runtime):
    """Pinned architecture plus the VQ runtime before its model-file shim.

    The architecture imports only installed mlx-lm components. The prefix
    contains the reviewed VQ operations and kernels; model discovery, config
    file reads and the import-stack-dependent architecture resolver are not
    executed. Environment-sensitive kernel switches are forbidden at entry.
    """
    for name in os.environ:
        if name.startswith(('VQ_', 'VQLAB_')):
            raise ValueError('reference requires no ambient VQ kernel overrides')
    raw = checked_source(architecture, ARCH_SHA256)
    import mlx_lm.models
    name = 'mlx_lm.models.qwen4_exp'
    spec = importlib.util.spec_from_file_location(name, architecture)
    arch = importlib.util.module_from_spec(spec)
    sys.modules[name] = arch
    # Compile the verified bytes, not a second read of a mutable path.
    exec(compile(raw, str(architecture), 'exec'), arch.__dict__)
    source = checked_source(runtime, RUNTIME_SHA256)
    tree = ast.parse(source.decode())
    end = next(node.end_lineno for node in tree.body
               if isinstance(node, ast.ClassDef) and node.name == 'VQPLEEmbedding')
    prefix = ast.Module(body=[n for n in tree.body if n.lineno <= end], type_ignores=[])
    os.environ['VQ_DECODE_CHUNK'] = '32'  # Fixed reference arithmetic, not adaptive free-RAM tiling.
    try:
        namespace = {'__name__': 'slotstream_reviewed_vq_runtime'}
        exec(compile(prefix, '<reviewed VQ runtime operations>', 'exec'), namespace)
        # Upstream resolves this lazily on first prefill, after import-time
        # environment is gone. Freeze the runtime value itself as well.
        namespace['_DECODE_CHUNK'] = 32
    finally:
        del os.environ['VQ_DECODE_CHUNK']
    return arch, namespace


def resolve(root, key):
    key = re.sub(r'\.ngram_embedding\.shard_(\d+)(?=\.|$)', r'.ngram_embedding.shards.\1', key)
    parts = key.split('.')
    owner = root
    for part in parts[:-1]:
        owner = owner[int(part)] if part.isdigit() else getattr(owner, part)
    return owner, parts[-1], key


def put(root, key, value):
    owner, leaf, normalized = resolve(root, key)
    if leaf.isdigit():
        owner[int(leaf)] = value
    else:
        if not hasattr(owner, leaf):
            raise ValueError('VQ module does not exist in the reference: ' + key)
        setattr(owner, leaf, value)
    return normalized


def verify_files(directory, inventory_path):
    """Rehash every required tensor file before lazy mapping or PLE reads."""
    raw = bounded(directory / 'verified.json', 1_000_000)
    receipt = unique_json(raw)
    inv = unique_json(bounded(inventory_path, 4_000_000))
    if (receipt.get('schema') != 1 or receipt['revision'] not in ARTIFACTS
            or receipt['revision'] != inv['revision'] or receipt['repo'] != inv['repo']):
        raise ValueError('complete pinned VQ artifact verification required')
    pinned_repo, pinned_config, pinned_files = ARTIFACTS[receipt['revision']]
    if receipt['repo'] != pinned_repo or inv['files']['config.json']['sha256'] != pinned_config:
        raise ValueError('artifact is not an inspected candidate')
    hub_raw = bounded(inventory_path.parent / 'hub-files.json', 4_000_000)
    if hashlib.sha256(hub_raw).hexdigest() != receipt['hub_metadata_sha256']:
        raise ValueError('full-file digest source changed')
    hub = unique_json(hub_raw)
    if hub['sha'] != inv['revision']:
        raise ValueError('artifact revision differs from its full-file metadata')
    expected = {f['rfilename']: {'path': f['rfilename'], 'bytes': f['size'], 'sha256': f['lfs']['sha256']}
                for f in hub['siblings'] if f['rfilename'].endswith('.safetensors')}
    canonical = json.dumps(expected, sort_keys=True, separators=(',', ':')).encode()
    if hashlib.sha256(canonical).hexdigest() != pinned_files:
        raise ValueError('artifact full-file digests differ from the inspected immutable revision')
    observed = {f['path']: f for f in receipt['files']}
    if expected != observed or len(observed) != len(receipt['files']):
        raise ValueError('incomplete or duplicate artifact file verification')
    stamps = {}
    for filename, f in sorted(expected.items()):
        if not re.fullmatch(r'[a-zA-Z0-9_-]+\.safetensors', filename):
            raise ValueError('artifact file must be a plain filename')
        import stat
        fd = os.open(directory / filename, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
        with os.fdopen(fd, 'rb') as file:
            before = os.fstat(file.fileno())
            if not stat.S_ISREG(before.st_mode) or before.st_size != f['bytes']:
                raise ValueError('artifact file size mismatch')
            h = hashlib.sha256()
            while True:
                chunk = file.read(8_000_000)
                if not chunk:
                    break
                h.update(chunk)
            if h.hexdigest() != f['sha256'] or stamp(os.fstat(file.fileno())) != stamp(before):
                raise ValueError('artifact payload digest mismatch or concurrent change')
            stamps[filename] = stamp(before)
        print(json.dumps({'verified': filename}), flush=True)
    for name in ('config.json', 'model.py', 'model.safetensors.index.json'):
        if hashlib.sha256(bounded(directory / name, 4_000_000)).hexdigest() != inv['files'][name]['sha256']:
            raise ValueError('artifact metadata identity mismatch')
    return {'verification_sha256': hashlib.sha256(raw).hexdigest(), 'stamps': stamps,
            'inventory_sha256': hashlib.sha256(bounded(inventory_path, 4_000_000)).hexdigest()}


def fold_raw_vq_norms(weights, model, arch):
    """Adapt the inspected packs' raw norms to the pinned PR's convention.

    PR 1788 folds +1 only for raw HF *names*. These packs retain the raw
    zero-centered values under converted model.* names, so sanitize alone
    silently drops +1. All 148 affected tensors in each pinned pack, folded
    once in BF16, match the deployed checkpoint's norm bytes exactly. This
    is an explicit artifact adapter, never a value-based guess. The gated
    delta-net norm already stores its scale and must stay untouched.
    """
    import mlx.core as mx
    expected = {name + '.weight' for name, module in model.named_modules()
                if isinstance(module, arch.RMSNorm)}
    selected = {key for key in weights if key.endswith(arch.Model._FOLD_ONE)}
    if len(expected) != 148 or selected != expected:
        raise ValueError('pinned VQ raw normalization family is incomplete or changed')
    for key in sorted(expected):
        if weights[key].dtype != mx.bfloat16:
            raise ValueError('pinned VQ raw normalization must be BF16')
        weights[key] = 1.0 + weights[key]


def load_model(directory, archive, arch, vq):
    import mlx.core as mx
    import mlx.nn as nn
    cfg = unique_json(bounded(directory / 'config.json', 1_000_000))
    if cfg.get('vq_skipzero') or cfg.get('vq_linear') or cfg.get('vq_embed'):
        raise ValueError('reference does not admit other VQ families')
    args = arch.ModelArgs.from_dict(cfg)
    if args.text.num_hidden_layers != 48 or args.text.vocab_size != VOCABULARY:
        raise ValueError('reference architecture geometry changed')
    model = arch.Model(args)
    for key, g in cfg['vq_modules'].items():
        bits = g.get('pack_bits', 0)
        count = (g['in'] // g['dim'] + 31) // 32 * bits if bits else g['in'] // g['dim']
        dtype = mx.uint32 if bits else mx.uint8
        module = vq['VQSwitchLinear'](mx.zeros((g['experts'], g['out'], count), dtype=dtype),
            mx.zeros((g['k'], g['dim']), dtype=mx.float16),
            mx.zeros((g['experts'], g['out'], g['in'] // g['group']), dtype=mx.float16),
            group_size=g['group'], pack_bits=bits, in_features=g['in'] if bits else None)
        put(model, key, module)
    ple_books = {}
    for key in cfg['vq_ple']['keys']:
        module = streaming_module(archive.table(key), vq['VQPLEEmbedding'])
        normalized = put(model, key, module)
        ple_books[normalized + '.book'] = module.book
    selected = {k: s for k, s in archive.index.items() if '.ngram_embedding.' not in k
                and not k.startswith(('mtp.', 'model.mtp.', 'vision_tower.', 'model.visual.', 'visual.'))}
    weights = {}
    for shard in sorted(set(selected.values())):
        arrays = mx.load(str(directory / shard))
        weights.update({k: arrays[k] for k, s in selected.items() if s == shard})
        del arrays
    weights = model.sanitize(weights)
    fold_raw_vq_norms(weights, model, arch)
    qcfg = cfg['quantization']

    def predicate(name, module):
        if not hasattr(module, 'to_quantized') or name + '.scales' not in weights:
            return False
        return qcfg.get(name, {'bits': qcfg['bits'], 'group_size': qcfg['group_size']})

    nn.quantize(model, bits=qcfg['bits'], group_size=qcfg['group_size'], class_predicate=predicate)
    weights.update(ple_books)
    # strict=True is essential: missing dense weights or a misnamed VQ module
    # must not leave random initialization and produce plausible bad logits.
    model.load_weights(list(weights.items()), strict=True)
    model.eval()
    del weights, ple_books
    gc.collect()
    return model


def physical():
    global _LIBPROC
    if _LIBPROC is None:
        _LIBPROC = ctypes.CDLL(ctypes.util.find_library('proc'))
    buffer = ctypes.create_string_buffer(296)
    if _LIBPROC.proc_pid_rusage(os.getpid(), 4, buffer) != 0:
        raise RuntimeError('physical footprint unavailable')
    return {'current_bytes': int.from_bytes(buffer.raw[72:80], 'little'),
            'lifetime_peak_bytes': int.from_bytes(buffer.raw[240:248], 'little'),
            'rss_peak_bytes': resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}


def streamed(model, arch, tokens, positions, out, layers=48, expected=None):
    import mlx.core as mx
    import numpy as np
    core = model.model
    caches = model.make_cache()
    ids = mx.array([tokens], dtype=mx.int64)
    chunk = 512
    h = mx.tile(core.embed_tokens(ids), (1, 1, core.hc))
    mx.eval(h)
    # Embedding/head remain loaded for this short pilot, well inside its
    # explicit process bound. Every block and its state is released in turn.
    eos = core.args.eos_token_id
    eos = eos[0] if isinstance(eos, list) else eos
    ctx = core.args.ngram_size - 1
    history = mx.concatenate([mx.full((1, ctx), eos, ids.dtype), ids], axis=1)
    for i in range(layers):
        started = time.monotonic()
        block, cache = core.layers[i], caches[i]
        mx.eval(block.parameters())
        parts = []
        for start in range(0, len(tokens), chunk):
            end = min(len(tokens), start + chunk)
            x = h[:, start:end]
            linear = block.layer_type == 'linear_attention'
            mask = None if linear else arch.create_attention_mask(x, cache)
            conv = arch.create_ssm_mask(x, cache) if linear else None
            indexer = cache.indexer if hasattr(cache, 'indexer') else None
            parts.append(block(x, core.rope, mask, conv, cache, indexer,
                               ids[:, start:end], history[:, start:start + ctx]))
            mx.eval(parts[-1])
        h = mx.concatenate(parts, axis=1) if len(parts) > 1 else parts[0]
        mx.eval(h)
        if not bool(mx.all(mx.isfinite(h)).item()):
            raise ValueError('nonfinite hidden state at layer %s' % i)
        core.layers[i] = None
        caches[i] = None
        del block, cache, parts, x, indexer, mask, conv
        gc.collect()
        mx.clear_cache()
        print(json.dumps({'layer': i, 'seconds': time.monotonic() - started,
                          'memory': physical(), 'mlx_peak_bytes': mx.get_peak_memory()}), flush=True)
    if layers < 48:
        mx.save_safetensors(str(out / 'hidden.safetensors'), {'hidden': h})
        if expected is not None:
            mixed = mx.concatenate([core.hyper_connection_mixer(h[:, s:s + chunk])
                                    for s in range(0, len(tokens), chunk)], axis=1)
            mx.eval(mixed)
            # No tolerance: this is the same arithmetic with storage and
            # traversal changed, not a comparison between quantizations.
            if not bool(mx.array_equal(mixed.view(mx.uint16), expected.view(mx.uint16)).item()):
                delta = float(mx.max(mx.abs(mixed.astype(mx.float32) - expected.astype(mx.float32))).item())
                raise ValueError('layer streaming changed chunked reference outputs; max error %s' % delta)
            return {'traversal_equal_bits': True, 'layers': layers, 'tokens': len(tokens),
                    'output_sha256': hashlib.sha256(np.array(mixed.view(mx.uint16)).tobytes()).hexdigest()}
        return None
    path = out / 'logits.f32'
    hasher = hashlib.sha256()
    with path.open('xb') as file:
        # A selected row retains its position's exact upstream head GEMM
        # shape: compute each original chunk and select afterward. Slicing h
        # first can change MLX's reduction order and invalidate parity.
        for start in range(0, len(tokens), chunk):
            selected = [p for p in positions if start <= p < start + chunk]
            if not selected:
                continue
            logits = model.lm_head(core.hyper_connection_mixer(h[:, start:start + chunk])).astype(mx.float32)[0]
            mx.eval(logits)
            if not bool(mx.all(mx.isfinite(logits)).item()):
                raise ValueError('nonfinite reference logits')
            for p in selected:
                raw = np.array(logits[p - start], dtype='<f4').tobytes()
                if len(raw) != VOCABULARY * 4:
                    raise ValueError('incomplete vocabulary')
                file.write(raw); hasher.update(raw)
            del logits
    return {'path': path.name, 'bytes': path.stat().st_size, 'sha256': hasher.hexdigest()}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--model', type=Path, required=True)
    parser.add_argument('--inventory', type=Path, required=True)
    parser.add_argument('--architecture', type=Path, required=True)
    parser.add_argument('--tokens', type=Path, required=True, help='frozen JSON list, at most 2048 tokens for this pilot')
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--layers', type=int, choices=(2, 4, 48), default=48)
    parser.add_argument('--prove-order', action='store_true', help='exact direct-vs-streamed first-four-layer gate')
    parser.add_argument('--order-proof', type=Path, help='successful same-candidate first-four-layer receipt, required for 48 layers')
    options = parser.parse_args()
    token_raw = bounded(options.tokens, 32_000)
    tokens = unique_json(token_raw)
    if (not isinstance(tokens, list) or not 1 <= len(tokens) <= 2048
            or any(type(t) is not int or not 0 <= t < VOCABULARY for t in tokens)):
        raise ValueError('bounded, frozen public pilot tokens required')
    if options.prove_order and (options.layers != 4 or not 512 < len(tokens) <= 1024):
        raise ValueError('traversal proof requires four layers and a boundary-crossing 513..1024-token input')
    instrument = instrument_identity()
    proof_hash = None
    if options.layers == 48:
        if options.order_proof is None:
            raise ValueError('full-model run requires a successful traversal proof first')
        proof_raw = bounded(options.order_proof, 1_000_000)
        proof = unique_json(proof_raw)
        inv_digest = hashlib.sha256(bounded(options.inventory, 4_000_000)).hexdigest()
        if (proof.get('architecture_sha256') != ARCH_SHA256 or proof.get('runtime_sha256') != RUNTIME_SHA256
                or proof.get('mlx') != '0.32.2' or proof.get('mlx_lm') != '0.31.3'
                or proof.get('prompt_chunk') != 512 or proof.get('vq_decode_chunk') != 32
                or proof.get('normalization') != NORMALIZATION
                or proof.get('artifact', {}).get('inventory_sha256') != inv_digest
                or proof.get('instrument', {}).get('sha256') != instrument['sha256']
                or proof.get('traversal_proof', {}).get('traversal_equal_bits') is not True
                or proof['traversal_proof'].get('layers') != 4 or proof['traversal_proof'].get('tokens', 0) <= 512):
            raise ValueError('traversal proof does not cover this reference configuration')
        proof_hash = hashlib.sha256(proof_raw).hexdigest()
    from context_qualification import verification_lock, quiet_preflight
    from prefill_bench import vm_snapshot
    before = quiet_preflight(13)
    with verification_lock():
        options.out.mkdir(parents=True, exist_ok=False)
        provenance = verify_files(options.model, options.inventory)
        allocation_before = recheck_owned_headroom()
        import mlx.core as mx
        if mx.__version__ != '0.32.2' or importlib.metadata.version('mlx-lm') != '0.31.3':
            raise ValueError('reference requires MLX 0.32.2 and mlx-lm 0.31.3')
        mx.set_cache_limit(128_000_000)
        mx.set_memory_limit(8_000_000_000)
        stop = threading.Event()

        def monitor():
            last_pressure = 0
            started = time.monotonic()
            while not stop.wait(.05):
                try:
                    observed = physical()
                    if max(observed.values()) > PROCESS_LIMIT:
                        reason = {'reason': 'process footprint exceeds 10 GB', 'memory': observed}
                    elif time.monotonic() - started > 14_400:
                        reason = {'reason': 'reference exceeded its four-hour experiment time bound'}
                    else:
                        if time.monotonic() - last_pressure >= 1:
                            pressure = subprocess.check_output(['sysctl', '-n', 'kern.memorystatus_vm_pressure_level'],
                                text=True, timeout=3).strip()
                            if pressure != '1':
                                raise RuntimeError('OS memory pressure interrupted the reference')
                            last_pressure = time.monotonic()
                        continue
                except Exception as error:
                    reason = {'reason': str(error)}
                (options.out / 'memory-refusal.json').write_text(json.dumps(reason) + '\n')
                os._exit(99)

        thread = threading.Thread(target=monitor, daemon=True); thread.start()
        try:
            arch, vq = references(options.architecture, options.model / 'model.py')
            with Archive(options.model, options.inventory) as archive:
                model = load_model(options.model, archive, arch, vq)
                print('strict model loading complete', flush=True)
                positions = list(range(max(0, len(tokens) - 16), len(tokens)))
                expected = None
                if options.prove_order:
                    model.model.layers = model.model.layers[:4]
                    caches = model.make_cache()
                    pieces = []
                    for start in range(0, len(tokens), 512):
                        pieces.append(model.model(mx.array([tokens[start:start + 512]], dtype=mx.int64), cache=caches))
                        mx.eval(pieces[-1])
                    expected = mx.concatenate(pieces, axis=1); mx.eval(expected)
                    del caches, pieces
                    gc.collect(); mx.clear_cache()
                    print('direct chunked traversal complete', flush=True)
                result = streamed(model, arch, tokens, positions, options.out, options.layers, expected)
                for name, identity in provenance['stamps'].items():
                    if stamp((options.model / name).stat()) != identity:
                        raise ValueError('artifact file changed during the model run')
                receipt = {'schema': 1, 'scope': 'pilot feasibility, not native parity or quality qualification',
                    'architecture_revision': ARCH_REVISION, 'architecture_sha256': ARCH_SHA256,
                    'runtime_sha256': RUNTIME_SHA256, 'mlx': mx.__version__, 'mlx_lm': '0.31.3',
                    'instrument': instrument, 'normalization': NORMALIZATION,
                    'vq_decode_chunk': 32, 'prompt_chunk': 512, 'tokens': tokens, 'positions': positions,
                    'tokens_sha256': hashlib.sha256(token_raw).hexdigest(), 'layers': options.layers,
                    'logits': result if options.layers == 48 else None,
                    'traversal_proof': result if options.prove_order else None,
                    'order_proof_sha256': proof_hash, 'before': before,
                    'allocation_before': allocation_before, 'after': vm_snapshot(),
                    'process_memory': physical(), 'peak_mlx_bytes': mx.get_peak_memory(),
                    'artifact': {k: v for k, v in provenance.items() if k != 'stamps'}, 'ple': archive.receipt()}
                if max(receipt['process_memory'].values()) > PROCESS_LIMIT:
                    raise ValueError('reference process footprint exceeded its bound')
                if instrument_identity()['sha256'] != instrument['sha256']:
                    raise ValueError('reference sources or runtime bytes changed during the run')
                (options.out / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
                print(json.dumps({'layers': options.layers, 'logits': result, 'memory': receipt['process_memory']}), flush=True)
        finally:
            stop.set(); thread.join(timeout=1)


if __name__ == '__main__':
    main()
