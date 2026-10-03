#!/usr/bin/env python3
"""The embedded coefficient payload must reproduce exactly and reject damage."""
import base64
from pathlib import Path
import tempfile
import unittest

from vq_rotary_table_source import render


class TableSourceTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.source = Path(__file__).resolve().parents[1].joinpath('Sources/Slotstream/VQRotaryTable.swift').read_text()
        encoded = cls.source.split('private static let encoded = """\n', 1)[1].split('"""', 1)[0]
        cls.payload = base64.b64decode(encoded)

    def test_exact_source(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'table.bin'
            path.write_bytes(self.payload)
            self.assertEqual(render(path), self.source)

    def test_corruption_and_extents(self):
        corrupt = bytearray(self.payload)
        corrupt[len(corrupt) // 2] ^= 1
        for payload in (self.payload[:-1], self.payload + b'\0', corrupt):
            with self.subTest(size=len(payload)), tempfile.TemporaryDirectory() as directory:
                path = Path(directory) / 'table.bin'
                path.write_bytes(payload)
                with self.assertRaisesRegex(ValueError, 'authenticated bounded rotary table'):
                    render(path)


if __name__ == '__main__':
    unittest.main()
