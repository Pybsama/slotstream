#!/usr/bin/env python3
"""Bind complete experimental producer runs to the strict full-vocabulary scorer.

No preprocessing identities are borrowed from a downloaded derivative. Every
arm uses the original tokenizer recorded by the frozen pilot input receipt.
This comparison never qualifies a pack or relaxes same-artifact equality.
"""
import argparse
import hashlib
import json
from pathlib import Path
import shutil

from quantization_inventory import unique_json
from quantization_logit_run import digest, inputs
from quantization_quality import compare
from vq_fused_reference import bounded
from vq_model_reference import ARTIFACTS, ARCH_SHA256, RUNTIME_SHA256, NORMALIZATION


def producer_artifact(run, receipts, identity):
    if not receipts:
        raise ValueError('producer has no completed cases')
    first = receipts[0]
    if run['arm'] == 'native':
        if any(r.get('pack_repo') != 'pipenetwork/Qwen3.8-Flash-Next-MLX-4bit'
               or r.get('pack_revision') != 'aa7c790e804bbf9d491ddb109c3d61bc4a555f7c'
               or r.get('pinned_manifest_sha256') != first['pinned_manifest_sha256']
               or r.get('optimizations') != first['optimizations']
               or r.get('mtp') is not False or r.get('vision') is not False for r in receipts):
            raise ValueError('native cases do not share the frozen baseline configuration')
        runtime = hashlib.sha256(json.dumps({'producer': run['producer'], 'optimizations': first['optimizations']},
            sort_keys=True, separators=(',', ':')).encode()).hexdigest()
        pack = first['pinned_manifest_sha256']
        arithmetic = first['arithmetic'] + '; MTP and vision off; prompt chunk 512'
    elif run['arm'] == 'vq':
        if any(r.get('layers') != 48 or r.get('architecture_sha256') != ARCH_SHA256
               or r.get('runtime_sha256') != RUNTIME_SHA256 or r.get('vq_decode_chunk') != 32
               or r.get('normalization') != NORMALIZATION
               or r.get('instrument', {}).get('sha256') != first['instrument']['sha256']
               or r.get('artifact') != first['artifact'] for r in receipts):
            raise ValueError('VQ cases do not share the complete pinned reference configuration')
        runtime = first['instrument']['sha256']
        # This binds the full-file verification and inventory digests, rather
        # than pretending the runtime source digest identifies the weights.
        pack = hashlib.sha256(json.dumps(first['artifact'], sort_keys=True, separators=(',', ':')).encode()).hexdigest()
        arithmetic = ('Pinned VQ reference, default F16 I/O, decoded-expert chunk 32, prompt chunk 512; '
                      'full head; no MTP or vision; normalization ' + NORMALIZATION)
    else:
        raise ValueError('unknown pilot producer')
    return {**identity, 'pack_sha256': pack, 'runtime_sha256': runtime, 'arithmetic': arithmetic,
            'preprocessing_choice': 'Original tokenizer, frozen literal token contexts; derivative tokenizer unused',
            'producer_run_sha256': run['_sha256']}


def manifest(directory, frozen_path, output, role, inventory=None):
    frozen, frozen_hash = inputs(frozen_path)
    raw = bounded(directory / 'run.json', 1_000_000)
    run = unique_json(raw)
    if (run.get('complete') is not True or run.get('scope') != 'pilot'
            or run.get('inputs_sha256') != frozen_hash
            or [c['id'] for c in run.get('cases', [])] != [c['id'] for c in frozen['cases']]):
        raise ValueError('complete producer run for these frozen contexts is required')
    run['_sha256'] = hashlib.sha256(raw).hexdigest()
    if role == 'baseline':
        if run['arm'] != 'native':
            raise ValueError('the baseline must be the deployed native affine producer')
        inventory_raw = None
    else:
        if run['arm'] != 'vq' or inventory is None:
            raise ValueError('VQ comparison arms require their pinned inventory')
        inventory_raw = bounded(inventory, 4_000_000)
        inv = unique_json(inventory_raw)
        expected = {'reference': '0f35dc817238bdbabdac208db731470cd30a7c0a',
                    'candidate': 'a4e1b44631619ba440d985e324d95dd106536a3d'}[role]
        if inv.get('revision') != expected or inv.get('repo') != ARTIFACTS[expected][0]:
            raise ValueError('pilot reference must be VQ 4.4 and candidate must be VQ 3.2')
    receipts, cases = [], []
    for case, completed in zip(frozen['cases'], run['cases']):
        parent = directory / case['id']
        receipt_raw = bounded(parent / 'receipt.json', 1_000_000)
        receipt = unique_json(receipt_raw)
        if (hashlib.sha256(receipt_raw).hexdigest() != completed['receipt_sha256']
                or completed['exit_code'] != 0 or completed['failure'] is not None or completed['samples'] <= 0
                or completed['sampled_peak_bytes'] > 10_000_000_000
                or receipt['tokens'] != case['tokens'] or receipt['positions'] != case['positions']
                or receipt['tokens_sha256'] != case['tokens_sha256'] or receipt['prompt_chunk'] != 512
                or receipt['logits']['path'] != 'logits.f32'):
            raise ValueError('producer case identity, supervision or context mismatch')
        path = parent / 'logits.f32'
        if (path.is_symlink() or path.stat().st_size != len(case['positions']) * 248_320 * 4
                or path.stat().st_size != receipt['logits']['bytes'] or digest(path) != receipt['logits']['sha256']):
            raise ValueError('complete-vocabulary producer bytes changed')
        receipts.append(receipt)
        cases.append({k: case[k] for k in ('id', 'family', 'tokens', 'positions')})
        cases[-1].update(file=case['id'] + '.f32', sha256=receipt['logits']['sha256'])
    artifact = producer_artifact(run, receipts, frozen['identity'])
    if inventory_raw is not None:
        if receipts[0]['artifact']['inventory_sha256'] != hashlib.sha256(inventory_raw).hexdigest():
            raise ValueError('VQ producer does not belong to the required comparison artifact')
        artifact.update(pack_repo=inv['repo'], pack_revision=inv['revision'],
                        full_file_map_sha256=ARTIFACTS[inv['revision']][2])
    output.mkdir(parents=True, exist_ok=False)
    for case in cases:
        shutil.copyfile(directory / case['id'] / 'logits.f32', output / case['file'])
    record = {'schema': 1, 'scope': 'pilot', 'format': 'f32le', 'vocabulary': 248_320,
              'artifact': artifact, 'cases': cases}
    target = output / 'manifest.json'
    target.write_text(json.dumps(record, indent=2, ensure_ascii=False) + '\n')
    return target


def main(options):
    options.out.mkdir(parents=True, exist_ok=False)
    paths = {role: manifest(getattr(options, role), options.inputs, options.out / role, role,
                           getattr(options, role + '_inventory', None))
             for role in ('reference', 'baseline', 'candidate')}
    result = compare(paths['reference'], paths['baseline'], paths['candidate'])
    result['limitation'] = 'Six owned teacher-forced contexts, last sixteen positions each. Native candidate parity, generation, complete tasks, held-out confidence, MTP/vision and speed are unproven.'
    (options.out / 'comparison.json').write_text(json.dumps(result, indent=2, allow_nan=False) + '\n')
    print(json.dumps({'qualification': result['qualification'], 'mean_case_delta_kl': result['mean_case_delta_kl'],
                     'cases': [{k: c[k] for k in ('id', 'baseline', 'candidate', 'mean_delta_kl')} for c in result['cases']]}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for key in ('inputs', 'reference', 'baseline', 'candidate', 'out'):
        parser.add_argument('--' + key, type=Path, required=True)
    for key in ('reference-inventory', 'candidate-inventory'):
        parser.add_argument('--' + key, type=Path, required=True)
    main(parser.parse_args())
