#!/usr/bin/env python3
"""Build and independently verify a bounded, derived VQ expert read layout.

Research only. Values, codebooks and bank geometry never change. The final
manifest appears only after full reconstruction hashes match source tensors.
The output directory must be new; incomplete output has no completion manifest.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import struct
import time

from context_qualification import quiet_preflight, verification_lock
from quantization_inventory import unique_json
from vq_dense_overlay import VQ_INVENTORY, read_json
from vq_model_reference import verify_files, physical
from vq_ple_stream import TensorFile, stamp

ALIGNMENT = 16_384
EXPERTS = 512
MAXIMUM_STAGING_BYTES = 350_000_000_000
MAXIMUM_OUTPUT_BYTES = 48_000_000_000
MAXIMUM_SECONDS = 7_200
MAXIMUM_PROCESS_BYTES = 1_000_000_000
SCHEMA = 'slotstream-vq-layer-expert-six-piece-16k-v1'


def align(value, alignment=ALIGNMENT):
    if type(value) is not int or value <= 0 or type(alignment) is not int or alignment <= 0:
        raise ValueError('positive integer extent and alignment required')
    return ((value + alignment - 1) // alignment) * alignment


def header(rows, stride):
    if type(rows) is not int or not 1 <= rows <= EXPERTS or type(stride) is not int or not 0 < stride <= 3_000_000:
        raise ValueError('record extent exceeds the admitted bound')
    value = {'records': {'dtype': 'U8', 'shape': [rows, stride], 'data_offsets': [0, rows * stride]}}
    raw = json.dumps(value, sort_keys=True, separators=(',', ':')).encode()
    if len(raw) > ALIGNMENT - 8: raise ValueError('packed header exceeds alignment')
    return struct.pack('<Q', ALIGNMENT - 8) + raw + b' ' * (ALIGNMENT - 8 - len(raw))


def exact(fd, offset, count):
    if type(offset) is not int or type(count) is not int or offset < 0 or not 0 < count <= 3_000_000:
        raise ValueError('bounded read extent required')
    chunks = []; done = 0
    while done < count:
        part = os.pread(fd, count - done, offset + done)
        if not part: raise ValueError('short derived layout read')
        chunks.append(part); done += len(part)
    return b''.join(chunks)


def sha_file(path, check, expected_stamp):
    digest = hashlib.sha256()
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
    with os.fdopen(fd, 'rb') as f:
        if stamp(os.fstat(f.fileno())) != expected_stamp: raise ValueError('derived hash input changed')
        for value in iter(lambda: f.read(1_000_000), b''):
            check(); digest.update(value)
        if stamp(os.fstat(f.fileno())) != expected_stamp: raise ValueError('derived input changed during hashing')
    return digest.hexdigest()


def plan(inventory):
    projections = {p['name']: p for p in inventory['vq_projections']}
    if len(projections) != 144: raise ValueError('incomplete expert projection inventory')
    layers = []
    for layer in range(48):
        pieces = []; offset = 0
        for family in ('gate_proj', 'up_proj', 'down_proj'):
            name = f'model.layers.{layer}.mlp.switch_mlp.{family}'
            projection = projections[name]
            for suffix in ('codes', 'vq_scales'):
                value = projection['tensors'][suffix]
                lo, hi = value['data_offsets']
                if (value['shape'][0] != EXPERTS or hi <= lo or (hi - lo) % EXPERTS):
                    raise ValueError('source tensor does not contain complete expert pieces')
                count = (hi - lo) // EXPERTS
                if not 0 < count <= 1_500_000: raise ValueError('expert piece exceeds its bound')
                pieces.append({'name': name + '.' + suffix, 'shard': value['shard'],
                               'bytes': count, 'offset': offset, 'source_tensor': value})
                offset += count
        if offset != inventory['expert_record_bytes_by_layer'][str(layer)]:
            raise ValueError('record reconstruction disagrees with source geometry')
        stride = align(offset)
        layers.append({'layer': layer, 'filename': f'experts-{layer:02d}.safetensors',
                       'record_bytes': offset, 'stride_bytes': stride, 'pieces': pieces,
                       'file_bytes': ALIGNMENT + EXPERTS * stride})
    total = sum(v['file_bytes'] for v in layers)
    if total != 47_866_183_680 or total > MAXIMUM_OUTPUT_BYTES:
        raise ValueError('derived output exceeds its frozen byte plan')
    return layers


def write_layer(path, *, rows, pieces, stride, read_piece, check=lambda: None):
    if sum(pieces) > stride or not pieces or any(type(n) is not int or not 0 < n <= 1_500_000 for n in pieces):
        raise ValueError('record pieces exceed their stride')
    padding = b'\0' * (stride - sum(pieces))
    with path.open('xb') as out:
        out.write(header(rows, stride))
        for row in range(rows):
            check()
            for piece, count in enumerate(pieces):
                raw = read_piece(piece, row)
                if len(raw) != count: raise ValueError('source piece was short')
                out.write(raw)
            out.write(padding)
        out.flush(); os.fsync(out.fileno())


def verify_layer(path, *, rows, pieces, stride, source_hashes, check=lambda: None, expected_stamp=None):
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
    try:
        before = os.fstat(fd)
        if expected_stamp is not None and stamp(before) != expected_stamp: raise ValueError('derived verification input changed')
        import stat
        if not stat.S_ISREG(before.st_mode) or before.st_size != ALIGNMENT + rows * stride:
            raise ValueError('derived layout length or file type changed')
        if exact(fd, 0, ALIGNMENT) != header(rows, stride):
            raise ValueError('derived layout header changed')
        digests = [hashlib.sha256() for _ in pieces]
        for row in range(rows):
            check(); record = exact(fd, ALIGNMENT + row * stride, stride)
            offset = 0
            for h, count in zip(digests, pieces): h.update(record[offset:offset+count]); offset += count
            if any(record[offset:]): raise ValueError('record alignment padding is not zero')
        hashes = [h.hexdigest() for h in digests]
        if hashes != source_hashes: raise ValueError('derived layout changes reconstructed source tensor bytes')
        if stamp(os.fstat(fd)) != stamp(before): raise ValueError('derived layout changed during verification')
        return hashes
    finally: os.close(fd)


def run(options):
    root = options.research_root.resolve(); out = options.out.absolute()
    if out.is_symlink() or out.exists() or not out.parent.resolve().is_relative_to(root):
        raise ValueError('new derived layout must be contained by the research directory')
    inventory = read_json(options.inventory, VQ_INVENTORY)
    layers = plan(inventory); total = sum(v['file_bytes'] for v in layers)
    # Conservatively count every path, including hard-link duplicates. Never
    # follow a link out of the bounded research area or credit reclaimable files.
    used = sum(p.stat().st_size for p in root.rglob('*') if p.is_file() and not p.is_symlink())
    fs = os.statvfs(root)
    if used + total > MAXIMUM_STAGING_BYTES or fs.f_bavail * fs.f_frsize < total + 10_000_000_000:
        raise ValueError('derived layout exceeds staging cap or disk headroom')
    start = time.monotonic()
    def check():
        if time.monotonic() - start > MAXIMUM_SECONDS: raise TimeoutError('derived layout time bound exceeded')
        if max(physical().values()) > MAXIMUM_PROCESS_BYTES: raise RuntimeError('derived layout process bound exceeded')
    before = quiet_preflight(13)
    with verification_lock():
        provenance = verify_files(options.model, options.inventory)
        out.mkdir(mode=0o700)
        receipt = {'schema': 1, 'complete': False, 'qualification': 'unproven', 'layout': SCHEMA,
                   'parent_inventory_sha256': VQ_INVENTORY, 'before': before,
                   'source_provenance': provenance, 'maximum_seconds': MAXIMUM_SECONDS,
                   'output_file_bytes': total, 'staging_bytes_before': used, 'maximum_process_bytes': MAXIMUM_PROCESS_BYTES, 'layers': []}
        def save(): (out / 'build.json').write_text(json.dumps(receipt, indent=2) + '\n')
        save(); owners = {}; output_stamps = {}
        try:
            for layer in layers:
                check(); pieces = layer['pieces']; counts = [p['bytes'] for p in pieces]
                for piece in pieces:
                    shard = piece['shard']
                    if shard not in owners:
                        identity = inventory['files'][shard]
                        owner = TensorFile(options.model / shard, **identity)
                        if owner.identity != tuple(provenance['stamps'][shard]):
                            owner.close(); raise ValueError('source changed after full verification')
                        owners[shard] = owner
                    expected = {k:v for k,v in piece['source_tensor'].items() if k != 'shard'}
                    if owners[shard].header[piece['name']] != expected:
                        raise ValueError('source tensor header differs from pinned record map')
                def read_piece(index, row):
                    p = pieces[index]; owner = owners[p['shard']]; count = p['bytes']
                    return b''.join(owner.read(p['name'], row*count+pos, min(1_000_000,count-pos)) for pos in range(0,count,1_000_000))
                path = out / layer['filename']
                write_layer(path, rows=EXPERTS, pieces=counts, stride=layer['stride_bytes'], read_piece=read_piece, check=check)
                output_stamp = stamp(os.stat(path, follow_symlinks=False)); output_stamps[path] = output_stamp
                # Independently hash original contiguous tensors, then
                # reconstruct their order from the derived record layout.
                expected_hashes = []
                for p in pieces:
                    h = hashlib.sha256(); owner = owners[p['shard']]; length = p['bytes'] * EXPERTS
                    for pos in range(0,length,1_000_000):
                        check(); h.update(owner.read(p['name'],pos,min(1_000_000,length-pos)))
                    expected_hashes.append(h.hexdigest())
                verify_layer(path, rows=EXPERTS, pieces=counts, stride=layer['stride_bytes'], source_hashes=expected_hashes, check=check, expected_stamp=output_stamp)
                row = {**layer, 'source_tensor_sha256': expected_hashes, 'sha256': sha_file(path,check,output_stamp)}
                receipt['layers'].append(row); save()
                print(json.dumps({'layer':layer['layer'],'file_bytes':layer['file_bytes'],'verified':True}),flush=True)
            for owner in owners.values(): owner.verify_unchanged()
            if any(stamp(os.stat(p, follow_symlinks=False)) != value for p,value in output_stamps.items()):
                raise ValueError('derived layout changed before manifest publication')
            receipt['data_verified'] = True; receipt['seconds'] = time.monotonic()-start; save()
            final = {'schema':1,'layout':SCHEMA,'parent_inventory_sha256':VQ_INVENTORY,'layers':receipt['layers']}
            temporary = out / '.manifest.tmp'
            with temporary.open('x') as f:
                f.write(json.dumps(final,sort_keys=True,indent=2)+'\n');f.flush();os.fsync(f.fileno())
            os.link(temporary, out / 'manifest.json')  # Atomic visibility, existing paths refused.
            temporary.unlink()
            directory = os.open(out,os.O_RDONLY)
            try: os.fsync(directory)
            finally: os.close(directory)
            check(); receipt['complete'] = True; receipt['memory'] = physical(); save()
        except BaseException as error:
            receipt['failure']=repr(error);save();raise
        finally:
            for owner in owners.values():owner.close()


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    for name in ('model','inventory','research-root','out'):p.add_argument('--'+name,type=Path,required=True)
    run(p.parse_args())
