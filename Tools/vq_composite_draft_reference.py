#!/usr/bin/env python3
"""Independent on-manifold input and draft-head fixture for the dense composite.

One authenticated main-model prefill matches the existing complete greedy
fixture before any draft computation. The main model is released before the
separately configured original four-bit head loads. No speculative generation,
acceptance-rate or quality/performance qualification follows from this probe.
"""
import argparse
import gc
import hashlib
import importlib.metadata
import importlib.util
import json
import os
from pathlib import Path
import sys
import threading
import time

from context_qualification import quiet_preflight, verification_lock
from quantization_inventory import unique_json
from vq_dense_overlay import Overlay, IDENTITY_SHA, BASE_CONFIG
from vq_dense_overlay_reference import instrument_identity, check_proof
from vq_execution_profile import select_runtime, recheck_runtime
from vq_fused_reference import bounded
from vq_model_reference import load_model, physical, references, recheck_owned_headroom, verify_files
from vq_ple_stream import Archive, TensorFile

PROFILE_SHA = '8e9ffd40c71d34bca08a55e7af55fda8ac7d45429f3ff7febef077d31bface7c'
MAIN_FIXTURE_SHA = '10003d625b179bdddfb6bd03d7544f1becf27f5beec2551cb71467af7639b68d'
DRAFT_BYTES = 1_470_955_171
DRAFT_SHA = 'c80b58faae46eeacb94dea49dd3453566ee05597fbd28c7c647eccb2862ab744'
HEADER_BYTES = 8347
HEADER_SHA = '836ae4156c99452e932c7a81322bcca959ac6f7ed86d6270cfd56ff94c62f4b9'
REFERENCE_SOURCES = {
    'qwen4_exp.py': '6fae4ec0decbf77ca4a4571de683bc5580ec75e84325ecb432dfcd2fc81df75e',
    'mtp_ref.py': 'f28827ac0409fe58b9c255f16add5ecb00b17a2310a3521d75a677f2d4a84f24',
}
LIMIT = 4_000_000_000


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def pinned_json(path, expected, limit):
    raw = bounded(path, limit)
    if hashlib.sha256(raw).hexdigest() != expected:
        raise ValueError('draft fixture input identity changed: ' + path.name)
    return unique_json(raw)


def owned_draft(directory):
    owner = TensorFile(directory / 'mtp.safetensors', file_bytes=DRAFT_BYTES,
                       header_bytes=HEADER_BYTES, header_sha256=HEADER_SHA)
    try:
        digest = hashlib.sha256()
        for position in range(0, DRAFT_BYTES, 1_000_000):
            owner.verify_unchanged()
            count = min(1_000_000, DRAFT_BYTES-position)
            raw = os.pread(owner.fd, count, position)
            if len(raw) != count: raise ValueError('short complete draft authentication')
            digest.update(raw)
        owner.verify_unchanged()
        if digest.hexdigest() != DRAFT_SHA: raise ValueError('draft payload identity changed')
        return owner
    except BaseException:
        owner.close(); raise


def load_draft(owner, module, args):
    import mlx.core as mx
    import mlx.nn as nn
    import numpy as np
    model = module.MTPModule(args)
    tensors = {k: v for k, v in owner.header.items() if k != '__metadata__'}
    if len(tensors) != 68: raise ValueError('draft tensor coverage changed')
    nn.quantize(model, group_size=64, bits=4,
                class_predicate=lambda p, m: 'mtp.' + p + '.scales' in tensors)
    values = []
    for name, tensor in tensors.items():
        recheck_owned_headroom()
        count = tensor['data_offsets'][1] - tensor['data_offsets'][0]
        if not 0 < count <= 419_430_400 or tensor['dtype'] not in ('BF16', 'U32'):
            raise ValueError('draft tensor exceeds the pinned materialization bound')
        raw = bytearray(count)
        for offset in range(0, count, 1_000_000):
            size = min(1_000_000, count-offset)
            raw[offset:offset+size] = owner.read(name, offset, size)
        dtype = np.uint16 if tensor['dtype'] == 'BF16' else np.uint32
        value = mx.array(np.frombuffer(raw, dtype=dtype))
        if tensor['dtype'] == 'BF16': value = value.view(mx.bfloat16)
        value = value.reshape(tensor['shape']); mx.eval(value)
        values.append((name.removeprefix('mtp.'), value)); del raw
        if max(physical().values()) > LIMIT: raise ValueError('draft load exceeded the four-GB process bound')
    model.load_weights(values); model.eval(); mx.eval(model.parameters())
    owner.verify_unchanged()
    return model


def run(options):
    root = Path(__file__).resolve().parent
    profile = pinned_json(options.profile, PROFILE_SHA, 32_000)
    main_fixture = pinned_json(options.main_fixture, MAIN_FIXTURE_SHA, 4_000_000)
    config = pinned_json(options.baseline / 'config.json', BASE_CONFIG, 64_000)
    source_raw = {name: bounded(root / 'reference' / name, 1_000_000) for name in REFERENCE_SOURCES}
    if any(hashlib.sha256(raw).hexdigest() != REFERENCE_SOURCES[name] for name, raw in source_raw.items()):
        raise ValueError('draft reference source differs from the reviewed baseline implementation')
    if (main_fixture['composite_sha256'] != IDENTITY_SHA or len(profile['prompt']) != 44
            or main_fixture['steps'][0]['input_ids'] != profile['prompt']):
        raise ValueError('independent main-model prefill fixture differs')
    execution_path, execution = select_runtime(options.model, None)
    instrument = instrument_identity()
    check_proof(unique_json(bounded(options.order_proof, 4_000_000)), instrument, execution)
    own_sha = sha(Path(__file__))
    inputs = [options.profile, options.main_fixture, options.order_proof, options.architecture, options.inventory,
              options.baseline / 'config.json'] + [root / 'reference' / p for p in REFERENCE_SOURCES]
    input_hashes = {str(p.resolve()): sha(p) for p in inputs}
    before = quiet_preflight(13)
    with verification_lock():
        options.out.mkdir(parents=True, exist_ok=False)
        record = {'schema': 1, 'passed': False, 'qualification': 'unproven', 'phase': 'authentication',
                  'scope': __doc__, 'before': before, 'composite_sha256': IDENTITY_SHA,
                  'draft_sha256': DRAFT_SHA, 'draft_quantization': {'bits': 4, 'group_size': 64},
                  'producer_sha256': own_sha, 'bound_inputs': input_hashes, 'instrument': instrument,
                  'execution_profile': execution, 'process_limit_bytes': LIMIT,
                  'maximum_fixture_bytes': 8_000_000, 'maximum_seconds': 7200}
        def save(): (options.out / 'receipt.json').write_text(json.dumps(record, indent=2) + '\n')
        save(); started = time.monotonic(); stop = threading.Event(); archive = draft_owner = None
        def monitor():
            while not stop.wait(.05):
                observed_memory = None
                try:
                    observed_memory = physical()
                    if max(observed_memory.values()) > LIMIT: raise RuntimeError('reference exceeded its four-GB process bound')
                    if time.monotonic()-started > 7200: raise RuntimeError('reference exceeded its time bound')
                except BaseException as error:
                    try:
                        (options.out / 'resource-refusal.json').write_text(json.dumps({'failure':str(error),'memory':observed_memory})+'\n')
                    finally:
                        os._exit(99)
        worker = threading.Thread(target=monitor, daemon=True); worker.start()
        try:
            record['parent'] = verify_files(options.model, options.inventory)
            overlay = Overlay(options.baseline, options.model, options.inventory)
            record['overlay'] = overlay.verify()
            draft_owner = owned_draft(options.baseline)
            import mlx.core as mx
            import numpy as np
            if mx.__version__ != '0.32.2' or importlib.metadata.version('mlx-lm') != '0.31.3':
                raise ValueError('draft probe requires the pinned current MLX versions')
            mx.set_memory_limit(3_500_000_000); mx.set_cache_limit(128_000_000)
            arch, vq = references(options.architecture, execution_path)
            archive = Archive(options.model, options.inventory)
            model = load_model(options.model, archive, arch, vq); overlay.apply(model)
            core = model.model; caches = model.make_cache()
            tokens = mx.array([profile['prompt']], dtype=mx.int64)
            history = mx.full((1,2),248044,mx.int64)
            embedded = core.embed_tokens(tokens); hidden = mx.tile(embedded,(1,1,core.hc))
            expected = {(x['layer'], x['name']): x for x in main_fixture['steps'][0]['boundaries']}
            observed = []
            tags = {mx.bfloat16:'BF16',mx.float32:'F32',mx.float16:'F16'}
            def observe(layer, arrays):
                for name, value in arrays.items():
                    mx.eval(value); entry=expected[(layer,name)]
                    if not bool(mx.all(mx.isfinite(value)).item()): raise ValueError('nonfinite main-model boundary')
                    raw=np.array(value.view(mx.uint8),copy=False).tobytes(order='C')
                    digest=hashlib.sha256(raw).hexdigest()
                    if (list(value.shape)!=entry['shape'] or tags[value.dtype]!=entry['dtype']
                            or len(raw)!=entry['bytes'] or digest!=entry['sha256']):
                        raise ValueError(f'independent main-model input changed at {layer}:{name}')
                    observed.append({'layer':layer,'name':name,'sha256':digest})
            record['phase']='main prefill';save();observe(-1,{'embedded':hidden})
            for layer in range(48):
                recheck_owned_headroom();block,cache=core.layers[layer],caches[layer];mx.eval(block.parameters())
                linear=block.layer_type=='linear_attention'
                mask=None if linear else arch.create_attention_mask(hidden,cache)
                conv=arch.create_ssm_mask(hidden,cache) if linear else None
                indexer=cache.indexer if hasattr(cache,'indexer') else None
                hidden=block(hidden,core.rope,mask,conv,cache,indexer,tokens,history)
                arrays={'hidden':hidden}
                if linear:
                    arrays.update(conv=cache[0],state=cache[1])
                    if layer==1:arrays['ple_conv']=cache[2]
                else:arrays.update(keys=cache.keys[:,:,:cache.offset],values=cache.values[:,:,:cache.offset],indexer=cache.indexer.keys)
                observe(layer,arrays);core.layers[layer]=None
                del block,cache,arrays,indexer,mask,conv;gc.collect();mx.clear_cache()
            mixed=core.hyper_connection_mixer(hidden);logits=model.lm_head(mixed).astype(mx.float32)
            observe(48,{'mixed':mixed,'logits':logits})
            token=int(mx.argmax(logits[0,-1]).item())
            if len(observed)!=160 or token!=main_fixture['generated'][0]:raise ValueError('main prefill omitted a boundary or changed its next token')
            embedded2=core.embed_tokens(mx.array([[token]],dtype=mx.int64));mx.eval(embedded,hidden,embedded2)
            fixtures={'embedded':embedded[:,1:,:],'hidden':hidden[:,:-1,:],
                      'embedded2':embedded2,'hidden2':hidden[:,-1:,:]}
            mx.eval(fixtures)
            del model,core,caches,tokens,history,embedded,hidden,embedded2,mixed,logits
            gc.collect();mx.clear_cache()
            record['main_boundaries']=observed;record['main_next_token']=token
            record['after_main_release']=physical();record['phase']='draft';save()
            for name in ('qwen4_exp.py','mtp_ref.py'):
                module_name=Path(name).stem
                spec=importlib.util.spec_from_file_location(module_name,root/'reference'/name)
                module=importlib.util.module_from_spec(spec);sys.modules[module_name]=module
                exec(compile(source_raw[name],str(root/'reference'/name),'exec'),module.__dict__)
            baseline_arch=sys.modules['qwen4_exp'];draft_module=sys.modules['mtp_ref']
            args=baseline_arch.ModelArgs.from_dict(config).text
            draft=load_draft(draft_owner,draft_module,args)
            rope=baseline_arch.RotaryEmbedding(int(args.head_dim*args.partial_rotary_factor),args.rope_theta)
            cache=baseline_arch._AttnCache()
            out1,multi1=draft(fixtures['embedded'],fixtures['hidden'],rope,cache);mx.eval(out1,multi1)
            if cache.offset!=43:raise ValueError('draft prefill cache misaligned')
            out2,multi2=draft(fixtures['embedded2'],fixtures['hidden2'],rope,cache);mx.eval(out2,multi2)
            if cache.offset!=44:raise ValueError('draft continuation cache misaligned')
            fixtures.update(out1=out1,multi1=multi1,out2=out2,multi2=multi2)
            if sum(v.nbytes for v in fixtures.values())>7_900_000:raise ValueError('draft fixture exceeds its byte bound')
            for value in fixtures.values():
                if value.dtype!=mx.bfloat16 or not bool(mx.all(mx.isfinite(value)).item()):raise ValueError('draft fixture dtype or finiteness changed')
            for owner in archive.files.values():owner.verify_unchanged()
            draft_owner.verify_unchanged();overlay.recheck();recheck_runtime(options.model,None,execution)
            if instrument_identity()['sha256']!=instrument['sha256'] or sha(Path(__file__))!=own_sha or any(sha(Path(p))!=h for p,h in input_hashes.items()):
                raise ValueError('draft producer input changed')
            target=options.out/'comparison.safetensors'
            mx.save_safetensors(str(target),fixtures,metadata={'scope':'composite main inputs and independent original four-bit MTP head'})
            if target.stat().st_size>8_000_000:raise ValueError('written fixture exceeds its bound')
            record.update(passed=True,phase='complete',fixture_sha256=sha(target),fixture_bytes=target.stat().st_size,
                          memory=physical(),seconds=time.monotonic()-started,
                          tensors={k:{'shape':list(v.shape),'dtype':'BF16','bytes':v.nbytes} for k,v in fixtures.items()},
                          cache_offsets=[43,44],native_comparison_relative_tolerance=0.02)
            save();print(json.dumps({k:record[k] for k in ['passed','fixture_sha256','fixture_bytes','memory','seconds']}),flush=True)
        except BaseException as error:
            record['failure']=repr(error);save();raise
        finally:
            stop.set();worker.join(timeout=1)
            if archive is not None:archive.close()
            if draft_owner is not None:draft_owner.close()


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    for key in ('model','baseline','inventory','architecture','profile','main-fixture','order-proof','out'):
        parser.add_argument('--'+key,type=Path,required=True)
    run(parser.parse_args())
