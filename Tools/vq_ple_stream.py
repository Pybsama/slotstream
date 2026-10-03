#!/usr/bin/env python3
"""Bounded, read-only VQ PLE storage for an experimental Python reference.

This changes storage only: the reviewed upstream VQPLEEmbedding still performs
the gather, half-precision product and BF16 conversion. No whole table enters
MLX. A pinned header is not a full-payload hash; callers must independently
verify complete checkpoint payloads before claiming full-model provenance.
"""
import ast
import hashlib
import os
from pathlib import Path
import re
import stat
import struct

from quantization_inventory import MAX_HEADER, unique_json, validate_header
from vq_fused_reference import bounded
from vq_kernel_sources import RUNTIME_SHA256

MAX_ROWS = 8192  # 512 prompt tokens x 16 n-gram heads, even in one shard.
MAX_ROW_BYTES = 160


def stamp(value):
    return value.st_dev, value.st_ino, value.st_size, value.st_mtime_ns, value.st_ctime_ns


class TensorFile:
    """One owned descriptor, checked extents and bounded positional reads."""

    def __init__(self, path, *, file_bytes, header_bytes, header_sha256):
        self.fd = None
        if (type(file_bytes) is not int or not 8 < file_bytes < 200_000_000_000
                or type(header_bytes) is not int or not 0 < header_bytes <= MAX_HEADER
                or not re.fullmatch('[0-9a-f]{64}', header_sha256)):
            raise ValueError('invalid pinned safetensors identity')
        try:
            self.fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
            observed = os.fstat(self.fd)
            self.identity = stamp(observed)
            if not stat.S_ISREG(observed.st_mode) or observed.st_size != file_bytes:
                raise ValueError('safetensors must be a regular file of the pinned size')
            prefix = os.pread(self.fd, 8, 0)
            if len(prefix) != 8 or struct.unpack('<Q', prefix)[0] != header_bytes:
                raise ValueError('safetensors header extent changed')
            raw = os.pread(self.fd, header_bytes, 8)
            if hashlib.sha256(raw).hexdigest() != header_sha256:
                raise ValueError('safetensors header identity mismatch')
            self.header = unique_json(raw)
            self.base = 8 + header_bytes
            validate_header(self.header, file_bytes - self.base)
            self.verify_unchanged()
            self.bytes_read = 0
            self.reads = 0
            self.max_read_bytes = 0
            self.range_hash = hashlib.sha256(b'slotstream-vq-ple-ranges-v1\0')
        except BaseException:
            self.close()
            raise

    def verify_unchanged(self):
        if self.fd is None or stamp(os.fstat(self.fd)) != self.identity:
            raise ValueError('safetensors changed during reference execution')

    def read(self, name, relative, count):
        info = self.header[name]
        length = info['data_offsets'][1] - info['data_offsets'][0]
        if (type(relative) is not int or type(count) is not int or relative < 0
                or not 0 < count <= 1_000_000 or relative + count > length):
            raise ValueError('tensor read exceeds its bounded extent')
        self.verify_unchanged()
        offset = self.base + info['data_offsets'][0] + relative
        raw = os.pread(self.fd, count, offset)
        if len(raw) != count:
            raise ValueError('short tensor read')
        self.verify_unchanged()
        self.bytes_read += count
        self.reads += 1
        self.max_read_bytes = max(self.max_read_bytes, count)
        # Ordered digest binds exactly the ranges and bytes used without
        # retaining a length-dependent per-row evidence list in memory.
        self.range_hash.update(struct.pack('<QQ', offset, count))
        self.range_hash.update(hashlib.sha256(raw).digest())
        return raw

    def close(self):
        if self.fd is not None:
            os.close(self.fd)
            self.fd = None

    def __enter__(self):
        return self

    def __exit__(self, *_):
        self.close()


class Table:
    """Codes/scales may be in different files. Codebooks are small and shared."""

    def __init__(self, tensors, *, columns, dimensions, entries, group_size):
        if (columns != 160 or group_size != 32 or (dimensions, entries) not in
                ((8, 256), (4, 2048), (2, 256))):
            raise ValueError('unsupported inspected VQ PLE layout')
        self.tensors = tensors
        self.columns, self.dimensions = columns, dimensions
        self.entries, self.group_size = entries, group_size
        bits = (entries - 1).bit_length()
        self.code_stride = (columns // dimensions * bits + 7) // 8
        self.scale_stride = columns // group_size * 2
        if self.code_stride > MAX_ROW_BYTES:
            raise ValueError('PLE row exceeds its storage bound')
        metadata = {key: file.header[name] for key, (file, name) in tensors.items()}
        if set(metadata) != {'codes', 'codebook', 'vq_scales'}:
            raise ValueError('PLE tensor triple required')
        shape = metadata['codes']['shape']
        if len(shape) != 2 or type(shape[0]) is not int or not 1 <= shape[0] <= 3_000_000:
            raise ValueError('unsupported PLE row count')
        self.row_count = shape[0]
        expected = {'codes': ('U8', [self.row_count, self.code_stride]),
                    'vq_scales': ('F16', [self.row_count, columns // group_size]),
                    'codebook': ('F16', [entries, dimensions])}
        if any((metadata[k]['dtype'], metadata[k]['shape']) != v for k, v in expected.items()):
            raise ValueError('PLE tensors disagree with the declared layout')
        file, name = tensors['codebook']
        self.book = file.read(name, 0, entries * dimensions * 2)
        self.calls = self.rows_requested = self.unique_rows_read = 0
        self.max_rows = self.max_result_bytes = 0

    def gather(self, rows):
        if (not isinstance(rows, list) or not 1 <= len(rows) <= MAX_ROWS
                or any(type(row) is not int or not 0 <= row < self.row_count for row in rows)):
            raise ValueError('PLE row IDs must fit the bounded table request')
        # No persistent row cache. Deduplicate only this call, retaining the
        # requested ordering and duplicates when assembling the result.
        unique = dict.fromkeys(rows)
        outputs = []
        for suffix, stride in [('codes', self.code_stride), ('vq_scales', self.scale_stride)]:
            file, name = self.tensors[suffix]
            pieces = {row: file.read(name, row * stride, stride) for row in unique}
            outputs.append(b''.join(pieces[row] for row in rows))
        self.calls += 1
        self.rows_requested += len(rows)
        self.unique_rows_read += len(unique)
        self.max_rows = max(self.max_rows, len(rows))
        self.max_result_bytes = max(self.max_result_bytes, sum(map(len, outputs)))
        return tuple(outputs)


def reference_class(runtime):
    """Execute just the reviewed PLE class, never the runtime's import shim.

    The hash pins its complete source before AST selection. Only this class
    (already reviewed, including its nested NumPy import) is compiled. The
    kernel/model loader, environment knobs and import-time code do not run.
    """
    raw = bounded(runtime, 1_000_000)
    if hashlib.sha256(raw).hexdigest() != RUNTIME_SHA256:
        raise ValueError('PLE reference source is not the reviewed VQ revision')
    tree = ast.parse(raw.decode())
    nodes = [node for node in tree.body if isinstance(node, ast.ClassDef) and node.name == 'VQPLEEmbedding']
    if len(nodes) != 1:
        raise ValueError('reviewed PLE class missing or ambiguous')
    import mlx.core as mx
    import mlx.nn as nn
    namespace = {'mx': mx, 'nn': nn}
    exec(compile(ast.Module(body=nodes, type_ignores=[]), '<reviewed VQPLEEmbedding>', 'exec'), namespace)
    return namespace['VQPLEEmbedding']


def streaming_module(table, reference):
    import mlx.core as mx
    import mlx.nn as nn
    import numpy as np

    class StreamingPLE(nn.Module):
        def __init__(self):
            super().__init__()
            # These are storage handles, not model parameters. No full table
            # can be found or eagerly evaluated by nn.Module.parameters().
            object.__setattr__(self, 'table', table)
            self.book = mx.array(np.frombuffer(table.book, dtype=np.float16).copy().reshape(
                table.entries, table.dimensions))

        def __call__(self, ids):
            if (ids.dtype not in (mx.int32, mx.int64, mx.uint32, mx.uint64)
                    or not 1 <= ids.size <= MAX_ROWS):
                raise ValueError('PLE indices must be bounded integers')
            shape = ids.shape
            rows = np.array(ids).reshape(-1).tolist()
            codes, scales = table.gather(rows)
            c = mx.array(np.frombuffer(codes, dtype=np.uint8).copy().reshape(len(rows), table.code_stride))
            s = mx.array(np.frombuffer(scales, dtype=np.float16).copy().reshape(len(rows), table.columns // 32))
            local = reference(c, self.book, s, group_size=32, packed_nsub=table.columns // table.dimensions)
            return local(mx.arange(len(rows), dtype=mx.int32).reshape(shape))

    return StreamingPLE()


class Archive:
    """Inventory-bound PLE handles, opened lazily and closed by the owner."""

    def __init__(self, directory, inventory_path):
        self.directory = Path(directory)
        raw = bounded(inventory_path, 4_000_000)
        self.inventory_sha256 = hashlib.sha256(raw).hexdigest()
        self.inventory = unique_json(raw)
        inv = self.inventory
        if inv['schema'] != 1 or not re.fullmatch('[0-9a-f]{40}', inv['revision']):
            raise ValueError('immutable VQ inventory required')
        cfg_raw = bounded(inventory_path.parent / 'config.json', 1_000_000)
        if hashlib.sha256(cfg_raw).hexdigest() != inv['files']['config.json']['sha256']:
            raise ValueError('VQ config no longer matches its inventory')
        self.ple = unique_json(cfg_raw)['vq_ple']
        index_raw = bounded(inventory_path.parent / 'model.safetensors.index.json', 4_000_000)
        if hashlib.sha256(index_raw).hexdigest() != inv['files']['model.safetensors.index.json']['sha256']:
            raise ValueError('VQ weight map no longer matches its inventory')
        self.index = unique_json(index_raw)['weight_map']
        self.files, self.tables = {}, {}

    def table(self, key):
        if key not in self.ple['keys'] or len(self.ple['keys']) != 128:
            raise ValueError('unknown VQ PLE table')
        if key not in self.tables:
            tensors = {}
            for suffix in ('codes', 'codebook', 'vq_scales'):
                name = key + '.' + suffix
                path = self.index[name]
                if not re.fullmatch(r'[a-zA-Z0-9_-]+\.safetensors', path):
                    raise ValueError('checkpoint shard must be a plain filename')
                if path not in self.files:
                    record = self.inventory['files'][path]
                    self.files[path] = TensorFile(self.directory / path,
                        **{k: record[k] for k in ('file_bytes', 'header_bytes', 'header_sha256')})
                tensors[suffix] = (self.files[path], name)
            g = self.ple['geometry']
            table = Table(tensors, columns=160, dimensions=g['dim'], entries=g['k'], group_size=g['group'])
            if self.ple['shapes'][key] != [table.row_count, table.columns] or g['row_bytes'] != table.code_stride:
                raise ValueError('VQ PLE shape does not match its storage')
            self.tables[key] = table
        return self.tables[key]

    def receipt(self):
        for file in self.files.values():
            file.verify_unchanged()
        return {'inventory_sha256': self.inventory_sha256, 'revision': self.inventory['revision'],
            'scope': 'pinned headers and selected bytes; full-payload provenance is a separate gate',
            'files': {name: {'bytes_read': file.bytes_read, 'reads': file.reads,
                'max_read_bytes': file.max_read_bytes, 'ordered_ranges_sha256': file.range_hash.hexdigest()}
                for name, file in self.files.items()},
            'tables': {name: {k: getattr(table, k) for k in
                ('calls', 'rows_requested', 'unique_rows_read', 'max_rows', 'max_result_bytes')}
                for name, table in self.tables.items()}}

    def close(self):
        for file in self.files.values():
            file.close()

    def __enter__(self):
        return self

    def __exit__(self, *_):
        self.close()
