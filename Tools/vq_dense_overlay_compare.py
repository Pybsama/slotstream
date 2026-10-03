#!/usr/bin/env python3
"""Score the composite pilot against preserved, independently bound controls."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil

from quantization_logit_run import digest, inputs
from quantization_logit_compare import producer_artifact
from quantization_inventory import unique_json
from quantization_quality import compare
from vq_dense_overlay import IDENTITY_SHA, POLICY, canonical_sha
from vq_dense_overlay_reference import check_proof, instrument_identity
from vq_model_reference import ARTIFACTS, RUNTIME_SHA256
from vq_fused_reference import bounded


def reused_control(directory, manifest, frozen, frozen_sha, role, bound_files):
    raw = bounded(directory / 'run.json', 1_000_000); run = unique_json(raw)
    data = unique_json(bounded(manifest, 1_000_000))
    if (not run.get('complete') or run.get('scope') != 'pilot' or run.get('inputs_sha256') != frozen_sha
            or run.get('arm') != ('native' if role == 'baseline' else 'vq')
            or [c['id'] for c in run['cases']] != [c['id'] for c in frozen['cases']]):
        raise ValueError('control run is not the frozen completed producer')
    run['_sha256'] = hashlib.sha256(raw).hexdigest(); receipts = []
    if bound_files.get(str((directory / 'run.json').resolve())) != run['_sha256']:
        raise ValueError('control run was not frozen before the candidate')
    for case, completed, derived in zip(frozen['cases'], run['cases'], data['cases']):
        parent = directory / case['id']; receipt_path = parent / 'receipt.json'
        receipt = unique_json(bounded(receipt_path, 1_000_000)); blob = parent / 'logits.f32'
        if (digest(receipt_path) != completed['receipt_sha256'] or completed['exit_code'] != 0
                or completed['failure'] is not None or completed['samples'] <= 0 or completed['sampled_peak_bytes'] > 10_000_000_000
                or bound_files.get(str(receipt_path.resolve())) != digest(receipt_path)
                or bound_files.get(str(blob.resolve())) != digest(blob)
                or any(receipt[k] != case[k] for k in ('tokens', 'positions', 'tokens_sha256'))
                or receipt['prompt_chunk'] != 512 or receipt['logits']['path'] != 'logits.f32'
                or receipt['logits']['bytes'] != len(case['positions']) * 248_320 * 4
                or receipt['logits']['sha256'] != digest(blob)
                or any(derived[k] != case[k] for k in ('id', 'family', 'tokens', 'positions'))
                or derived['sha256'] != receipt['logits']['sha256']):
            raise ValueError('preserved control differs from the frozen producer or contexts')
        receipts.append(receipt)
    if len(data['cases']) != 6:
        raise ValueError('preserved control has incomplete case coverage')
    artifact = producer_artifact(run, receipts, frozen['identity'])
    if role == 'reference':
        revision = '0f35dc817238bdbabdac208db731470cd30a7c0a'
        artifact.update(pack_repo=ARTIFACTS[revision][0], pack_revision=revision, full_file_map_sha256=ARTIFACTS[revision][2])
    if data['artifact'] != artifact:
        raise ValueError('preserved control artifact does not bind its original producer')
    return manifest


def main(options):
    frozen, frozen_sha = inputs(options.inputs)
    source = options.candidate.resolve()
    run = unique_json(bounded(source / 'run.json', 1_000_000))
    protocol = unique_json(bounded(source / 'protocol.json', 1_000_000))
    if (run.get('complete') is not True or run['protocol_sha256'] != digest(source / 'protocol.json')
            or protocol['composite_sha256'] != IDENTITY_SHA or protocol['inputs_sha256'] != frozen_sha
            or [r['case'] for r in run['runs']] != ['traversal'] + [c['id'] for c in frozen['cases']]):
        raise ValueError('composite run is incomplete or belongs to another protocol')
    proof_path = source / 'traversal/receipt.json'
    proof = unique_json(bounded(proof_path, 4_000_000)); instrument = instrument_identity()
    expected_execution = {'schema': 1, 'mode': 'bundled-reviewed-v1',
        'bundled_runtime_sha256': RUNTIME_SHA256, 'runtime_sha256': RUNTIME_SHA256}
    check_proof(proof, instrument, expected_execution)
    receipts = []
    for row in run['runs']:
        path = source / row['case'] / 'receipt.json'
        receipt = unique_json(bounded(path, 4_000_000)); observed = row['supervision']
        composite = receipt['composite']; hashed = {k: v for k, v in composite.items() if k != 'sha256'}
        if (digest(path) != row['receipt_sha256'] or observed['exit_code'] != 0 or observed['failure'] is not None
                or observed['samples'] <= 0 or observed['sampled_peak_bytes'] > 10_000_000_000
                or canonical_sha(hashed) != IDENTITY_SHA or composite['sha256'] != IDENTITY_SHA
                or receipt['composite_sha256'] != IDENTITY_SHA or receipt['policy'] != POLICY
                or receipt['instrument']['sha256'] != instrument['sha256']
                or receipt['runtime_sha256'] != RUNTIME_SHA256
                or receipt['overlay_application'] != proof['overlay_application']
                or receipt['overlay_verification'] != proof['overlay_verification']
                or receipt['execution_profile'] != proof['execution_profile']
                or receipt['vq_parent'] != proof['vq_parent']):
            raise ValueError('composite output is not bound to this producer and authenticated pair of parents')
        if row['case'] == 'traversal': continue
        case = next(c for c in frozen['cases'] if c['id'] == row['case'])
        if (any(receipt[k] != case[k] for k in ('tokens', 'positions', 'tokens_sha256'))
                or receipt['layers'] != 48 or receipt['prompt_chunk'] != 512 or receipt['vq_decode_chunk'] != 32
                or receipt['normalization'] != proof['normalization']
                or receipt['order_proof_sha256'] != digest(proof_path)
                or receipt['logits']['path'] != 'logits.f32'
                or receipt['logits']['bytes'] != len(case['positions']) * 248_320 * 4
                or digest(source / row['case'] / 'logits.f32') != receipt['logits']['sha256']):
            raise ValueError('composite output does not cover the frozen full-vocabulary context')
        receipts.append(receipt)
    paths = {role: reused_control(getattr(options, role), getattr(options, role + '_manifest'), frozen,
                                 frozen_sha, role, protocol['bound_files']) for role in ('reference', 'baseline')}
    research = source.parent
    if not options.out.resolve().is_relative_to(research):
        raise ValueError('comparison output must stay inside the bounded research directory')
    existing = [p for p in research.rglob('*') if p.is_file()]
    copied_bytes = sum(r['logits']['bytes'] for r in receipts)
    storage = sum(p.stat().st_size for p in existing)
    logits = sum(p.stat().st_size for p in existing if p.name.endswith('.f32'))
    if (storage + copied_bytes + 10_000_000 > protocol['maximum_staged_bytes']
            or logits + copied_bytes > protocol['maximum_logit_bytes']):
        raise ValueError('comparison copies exceed the frozen storage envelope')
    options.out.mkdir(parents=True, exist_ok=False)
    (options.out / 'storage-admission.json').write_text(json.dumps({
        'staged_bytes_before': storage, 'logit_bytes_before': logits, 'new_copy_bytes': copied_bytes,
        'maximum_staged_bytes': protocol['maximum_staged_bytes'], 'maximum_logit_bytes': protocol['maximum_logit_bytes'],
        'tool_sha256': digest(Path(__file__))}, indent=2) + '\n')
    cases = []
    for case, receipt in zip(frozen['cases'], receipts):
        entry = {k: case[k] for k in ('id', 'family', 'tokens', 'positions')}
        entry.update(file=case['id'] + '.f32', sha256=receipt['logits']['sha256'])
        shutil.copyfile(source / case['id'] / 'logits.f32', options.out / entry['file'])
        cases.append(entry)
    manifest = {'schema': 1, 'scope': 'pilot', 'format': 'f32le', 'vocabulary': 248_320,
        'artifact': {**frozen['identity'], 'pack_sha256': IDENTITY_SHA, 'runtime_sha256': instrument['sha256'],
            'arithmetic': POLICY + '; pinned VQ reference, original tokens, chunk 512, F16 VQ I/O, BF16 norm fold; no MTP or vision',
            'producer_run_sha256': digest(source / 'run.json')}, 'cases': cases}
    candidate_manifest = options.out / 'manifest.json'
    candidate_manifest.write_text(json.dumps(manifest, indent=2) + '\n')
    result = compare(paths['reference'], paths['baseline'], candidate_manifest)
    result['limitation'] = 'Six owned pilot contexts, correlated positions, quantized reference proxy; no held-out, complete-task, native, performance or product qualification.'
    result['controls_reused_without_copy'] = {role: str(path) for role, path in paths.items()}
    (options.out / 'comparison.json').write_text(json.dumps(result, indent=2, allow_nan=False) + '\n')
    print(json.dumps({'qualification': result['qualification'], 'mean_case_delta_kl': result['mean_case_delta_kl'],
        'cases': [{k: c[k] for k in ('id', 'baseline', 'candidate', 'mean_delta_kl')} for c in result['cases']]}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('inputs', 'candidate', 'reference', 'baseline', 'reference-manifest', 'baseline-manifest', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    main(parser.parse_args())
