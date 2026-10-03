import hashlib
import os
from pathlib import Path
import struct
import tempfile
import unittest

from quantization_fixture import safetensors
from vq_ple_stream import MAX_ROWS, Table, TensorFile


def fixture(path, rows=7, dim=4, entries=2048, sparse=False):
    stride = (160 // dim * (entries - 1).bit_length() + 7) // 8
    if sparse:
        import json
        header = {}; end = 0
        for name, dtype, shape, count in [('codes', 'U8', [rows, stride], rows * stride),
                ('codebook', 'F16', [entries, dim], entries * dim * 2),
                ('vq_scales', 'F16', [rows, 5], rows * 10)]:
            header[name] = {'dtype': dtype, 'shape': shape, 'data_offsets': [end, end + count]}
            end += count
        raw = json.dumps(header).encode()
        with path.open('wb') as f:
            f.write(struct.pack('<Q', len(raw)) + raw)
            f.truncate(8 + len(raw) + end)
    else:
        raw = safetensors([('codes', 'U8', [rows, stride], bytes(i % 256 for i in range(rows * stride))),
            ('codebook', 'F16', [entries, dim], struct.pack('<e', .5) * entries * dim),
            ('vq_scales', 'F16', [rows, 5], b''.join(struct.pack('<e', (i + 1) / 8) * 5 for i in range(rows)))])
        path.write_bytes(raw)
    return identity(path)


def identity(path):
    with path.open('rb') as f:
        size = struct.unpack('<Q', f.read(8))[0]
        header = f.read(size)
    return dict(file_bytes=path.stat().st_size, header_bytes=size, header_sha256=hashlib.sha256(header).hexdigest())


def table(file, dim=4, entries=2048):
    return Table({k: (file, k) for k in ('codes', 'codebook', 'vq_scales')},
                 columns=160, dimensions=dim, entries=entries, group_size=32)


class PLEStorageTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name) / 'rows.safetensors'

    def test_exact_order_duplicates_and_all_pinned_layouts(self):
        for dim, entries in [(8, 256), (4, 2048), (2, 256)]:
            info = fixture(self.path, dim=dim, entries=entries)
            with TensorFile(self.path, **info) as file:
                t = table(file, dim, entries)
                c, s = t.gather([6, 0, 6, 2])
                raw = self.path.read_bytes()
                for actual, name, stride in [(c, 'codes', t.code_stride), (s, 'vq_scales', 10)]:
                    base = file.base + file.header[name]['data_offsets'][0]
                    self.assertEqual(actual, b''.join(raw[base + i * stride:base + (i + 1) * stride] for i in [6, 0, 6, 2]))
                self.assertEqual(t.unique_rows_read, 3)
                self.assertEqual(file.reads, 7)  # one book plus each unique row twice
                self.assertEqual(file.bytes_read, entries * dim * 2 + 3 * (t.code_stride + 10))

    def test_full_sized_table_reads_only_requested_rows(self):
        info = fixture(self.path, rows=2_500_012, sparse=True)
        with TensorFile(self.path, **info) as file:
            t = table(file)
            c, s = t.gather([2_500_011, 0, 2_500_011])
            self.assertEqual((len(c), len(s)), (165, 30))
            self.assertEqual(file.bytes_read, 16_384 + 130)
            self.assertEqual(file.max_read_bytes, 16_384)
            self.assertEqual(t.max_result_bytes, 195)

    def test_bounds_fail_before_reading(self):
        info = fixture(self.path)
        with TensorFile(self.path, **info) as file:
            t = table(file)
            for rows in [[], [-1], [7], [True], [1.0], [0] * (MAX_ROWS + 1), (1, 2)]:
                with self.assertRaises(ValueError):
                    t.gather(rows)
            for offset, count in [(-1, 1), (0, 1_000_001), (384, 2), (True, 1), (0, 0)]:
                with self.assertRaises(ValueError):
                    file.read('codes', offset, count)
            self.assertEqual(file.reads, 1)

    def test_corruption_and_concurrent_change(self):
        info = fixture(self.path)
        with self.assertRaises(ValueError):
            TensorFile(self.path, **dict(info, header_sha256='0' * 64))
        with self.assertRaises(ValueError):
            TensorFile(self.path, **dict(info, file_bytes=info['file_bytes'] + 1))
        with TensorFile(self.path, **info) as file:
            t = table(file)
            with self.path.open('r+b') as f:
                f.seek(-1, os.SEEK_END); f.write(b'\xff')
            with self.assertRaisesRegex(ValueError, 'changed'):
                t.gather([0])
        with TensorFile(self.path, **info) as file:
            with self.path.open('r+b') as f:
                f.truncate(info['file_bytes'] - 1)
            with self.assertRaises(ValueError):
                file.read('codes', 0, 1)

    def test_symlinks_and_wrong_geometry(self):
        info = fixture(self.path)
        link = self.path.with_name('link.safetensors'); link.symlink_to(self.path)
        with self.assertRaises(OSError):
            TensorFile(link, **info)
        with TensorFile(self.path, **info) as file:
            with self.assertRaises(ValueError):
                table(file, 2, 256)
            with self.assertRaises(ValueError):
                Table({k: (file, k) for k in ('codes', 'codebook', 'vq_scales')},
                      columns=160, dimensions=4, entries=2048, group_size=64)


if __name__ == '__main__':
    unittest.main()
