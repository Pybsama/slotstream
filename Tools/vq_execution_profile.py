"""Bind research weights and reviewed execution source independently.

Some inspected packs bundle an older VQ implementation. An explicit override
may select the one already reviewed implementation, never arbitrary model code.
The bundled file is preserved and its separate identity remains in the receipt.
This does not admit any new artifact or change production model loading.
"""
import hashlib
import json
from pathlib import Path

from vq_fused_reference import bounded
from vq_kernel_sources import RUNTIME_SHA256

OLDER_BUNDLE_SHA256 = '36de8d6ba21ff93ac3de2994eed4fd59e9cfab86b1908f72f5ee2673bd0aa5bb'
ALLOCATION_LAYERS = {
    'a4e1b44631619ba440d985e324d95dd106536a3d': [0, 2],
    '0f35dc817238bdbabdac208db731470cd30a7c0a': [0, 3],
    '8684640a3956b01c47f5d47f9b999e2ab8b985f1': [0, 2, 27],
}


def allocation_layers(config, revision):
    """One real representative per exact descriptor triple, with known coverage."""
    signatures = set()
    layers = []
    for layer in range(48):
        descriptors = [config['vq_modules'][f'model.layers.{layer}.mlp.switch_mlp.{name}']
                       for name in ('gate_proj', 'up_proj', 'down_proj')]
        signature = json.dumps(descriptors, sort_keys=True, separators=(',', ':'))
        if signature not in signatures:
            signatures.add(signature)
            layers.append(layer)
    if layers != ALLOCATION_LAYERS.get(revision):
        raise ValueError('complete-record allocation classes differ from the inspected artifact')
    return layers


def add_runtime_argument(parser):
    parser.add_argument('--runtime', type=Path,
        help='Explicit already-reviewed VQ source; required when bundled model.py differs. No arbitrary code is admitted.')


def select_runtime(model, explicit=None):
    bundled = model / 'model.py'
    bundled_hash = hashlib.sha256(bounded(bundled, 1_000_000)).hexdigest()
    if bundled_hash not in (RUNTIME_SHA256, OLDER_BUNDLE_SHA256):
        raise ValueError('uninspected bundled VQ source identity')
    if explicit is None and bundled_hash != RUNTIME_SHA256:
        raise ValueError('older bundled VQ source requires an explicit reviewed --runtime')
    selected = bundled if explicit is None else explicit
    executed_hash = hashlib.sha256(bounded(selected, 1_000_000)).hexdigest()
    if executed_hash != RUNTIME_SHA256:
        raise ValueError('selected VQ execution source is not the reviewed runtime')
    profile = {'schema': 1,
        'mode': 'bundled-reviewed-v1' if explicit is None else 'explicit-reviewed-v1',
        'bundled_runtime_sha256': bundled_hash, 'runtime_sha256': executed_hash}
    return selected, profile


def recheck_runtime(model, explicit, expected):
    if select_runtime(model, explicit)[1] != expected:
        raise ValueError('VQ execution profile changed during the reference run')
