#!/usr/bin/env python3
"""Stage an inspected VQ research artifact; never activate a product model.

Uses the installed Hub downloader with Xet disabled, one file at a time, then
checks every original payload digest. The final receipt is consumed and fully
rechecked by vq_model_reference.py. It is not a product distribution format.
"""
import argparse
import fcntl
import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import re
import shutil
import stat
import urllib.request

from quantization_inventory import unique_json
from vq_fused_reference import bounded
from vq_model_reference import ARTIFACTS as REFERENCE_ARTIFACTS
from vq_ple_stream import stamp

# Download admission is weaker than reference or production admission. The
# 2.1-bit payload must still pass the independent norm, traversal and numerical
# audits before vq_model_reference accepts it. These immutable hashes authorize
# staging bytes only; they do not activate a model or certify its arithmetic.
STAGING_ARTIFACTS = {
    **REFERENCE_ARTIFACTS,
    '8684640a3956b01c47f5d47f9b999e2ab8b985f1': (
        'TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw',
        '4299e87dc3b2d11e53c683d4f17f1196ccf95b75399ddd77d470e148aae1d929',
        '58d59c3b849ca303cece916f930a15e8583455e1566611133597513b0245a565'),
}


def file_map(hub, revision):
    if hub.get('sha') != revision or revision not in STAGING_ARTIFACTS:
        raise ValueError('immutable inspected Hub revision required')
    result = {}
    for item in hub['siblings']:
        name = item['rfilename']
        if not name.endswith('.safetensors'):
            continue
        if (not re.fullmatch(r'[a-zA-Z0-9_-]+\.safetensors', name) or name in result
                or type(item.get('size')) is not int or not 0 < item['size'] < 12_000_000_000
                or item.get('lfs', {}).get('size') != item['size']
                or not re.fullmatch('[0-9a-f]{64}', item.get('lfs', {}).get('sha256', ''))):
            raise ValueError('invalid bounded artifact file metadata')
        result[name] = {'path': name, 'bytes': item['size'], 'sha256': item['lfs']['sha256']}
    encoded = json.dumps(result, sort_keys=True, separators=(',', ':')).encode()
    if hashlib.sha256(encoded).hexdigest() != STAGING_ARTIFACTS[revision][2]:
        raise ValueError('Hub full-file map differs from the inspected artifact')
    return result


def verify(path, expected):
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
    with os.fdopen(fd, 'rb') as source:
        before = os.fstat(source.fileno())
        if not stat.S_ISREG(before.st_mode) or before.st_size != expected['bytes']:
            raise ValueError('download is not the expected regular file')
        digest = hashlib.sha256()
        while True:
            chunk = source.read(8_000_000)
            if not chunk:
                break
            digest.update(chunk)
        if digest.hexdigest() != expected['sha256'] or stamp(os.fstat(source.fileno())) != stamp(before):
            raise ValueError('download digest mismatch or concurrent change')
    return expected


def atomic(path, data):
    temporary = path.with_name(path.name + '.tmp')
    fd = os.open(temporary, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    try:
        with os.fdopen(fd, 'wb') as file:
            file.write(data); file.flush(); os.fsync(file.fileno())
        os.replace(temporary, path)
    finally:
        temporary.unlink(missing_ok=True)


def fetch(inventory, out):
    inv = unique_json(bounded(inventory, 4_000_000))
    revision = inv['revision']
    if revision not in STAGING_ARTIFACTS or inv['repo'] != STAGING_ARTIFACTS[revision][0]:
        raise ValueError('candidate is not in the inspected research allowlist')
    cfg = bounded(inventory.parent / 'config.json', 1_000_000)
    if hashlib.sha256(cfg).hexdigest() != STAGING_ARTIFACTS[revision][1]:
        raise ValueError('candidate config differs from the inspected artifact')
    metadata = inventory.parent / 'hub-files.json'
    if not metadata.exists():
        url = 'https://huggingface.co/api/models/%s/revision/%s?blobs=true' % (inv['repo'], revision)
        with urllib.request.urlopen(url, timeout=60) as response:
            data = response.read(4_000_001)
        if len(data) > 4_000_000:
            raise ValueError('Hub metadata exceeds its bound')
        file_map(unique_json(data), revision)
        atomic(metadata, data)
    raw = bounded(metadata, 4_000_000)
    files = file_map(unique_json(raw), revision)
    if out.is_symlink():
        raise ValueError('research output must not be a symlink')
    out.mkdir(parents=True, exist_ok=True)
    lock_fd = os.open(out / '.research-download.lock', os.O_CREAT | os.O_RDWR | os.O_NOFOLLOW, 0o600)
    with os.fdopen(lock_fd, 'r+') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        # Conservative: require room for another complete artifact plus 50 GB
        # even on resume. This is a research bound, not the product estimator.
        if shutil.disk_usage(out).free < sum(f['bytes'] for f in files.values()) + 50_000_000_000:
            raise ValueError('insufficient disk for a complete research artifact and reserve')
        for name in ('config.json', 'model.safetensors.index.json', 'model.py'):
            data = bounded(inventory.parent / name, 4_000_000)
            if hashlib.sha256(data).hexdigest() != inv['files'][name]['sha256']:
                raise ValueError('local inventory metadata identity mismatch')
            target = out / name
            if target.exists():
                if target.is_symlink() or bounded(target, 4_000_000) != data:
                    raise ValueError('output belongs to a different artifact')
            else:
                atomic(target, data)
        # No Hub credential is passed, and no second Xet cache duplicates the
        # model. The pinned library owns interrupted-download resumption.
        os.environ['HF_HUB_DISABLE_XET'] = '1'
        os.environ['HF_HUB_DOWNLOAD_TIMEOUT'] = '60'
        os.environ['HF_HUB_DISABLE_PROGRESS_BARS'] = '1'
        if importlib.metadata.version('huggingface-hub') != '1.29.0':
            raise ValueError('research fetch requires the inspected huggingface-hub 1.29.0')
        from huggingface_hub import hf_hub_download
        verified = []
        for filename, expected in sorted(files.items()):
            path = Path(hf_hub_download(inv['repo'], filename, revision=revision, local_dir=out, token=False))
            if path.resolve() != (out / filename).resolve():
                raise ValueError('Hub download returned an unexpected path')
            verified.append(verify(path, expected))
            record = {'schema': 1, 'repo': inv['repo'], 'revision': revision,
                      'hub_metadata_sha256': hashlib.sha256(raw).hexdigest(), 'files': verified}
            atomic(out / 'verified-progress.json', (json.dumps(record, indent=2) + '\n').encode())
            print(json.dumps({'verified': len(verified), 'of': len(files), 'path': filename, 'bytes': expected['bytes']}), flush=True)
        atomic(out / 'verified.json', (json.dumps(record, indent=2) + '\n').encode())
        print('complete', flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--inventory', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    fetch(args.inventory, args.out)
