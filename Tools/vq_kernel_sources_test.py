#!/usr/bin/env python3
import hashlib
from pathlib import Path
import re
import unittest
from vq_kernel_sources import literal_strings, SOURCES
from vq_fused_reference import validate_fixture


class SourceExtractionTests(unittest.TestCase):
    def test_no_calls_imports_or_stale_assignments(self):
        code = '''
import nonexistent_module
a = "old"
b = a + " value"
c = b.replace("old", "new")
a = __import__("os").system("must never execute")
d = a
def ignored():
    raise RuntimeError("must never execute")
'''
        self.assertEqual(literal_strings(code), {'b': 'old value', 'c': 'new value'})

    def test_replacement_expansion_is_bounded(self):
        code = 'a = ' + repr('x' * 1000) + '\nb = ' + repr('y' * 1000) + '\nc = a.replace("", b)'
        self.assertNotIn('c', literal_strings(code))

    def test_checked_in_kernels_and_license_match_reviewed_bytes(self):
        root = Path(__file__).resolve().parent.parent
        swift = (root / 'Sources/Slotstream/VQKernelSources.swift').read_text()
        sources = dict(re.findall(r'static let (\w+) = #"""\n(.*?)\n"""#', swift, re.S))
        self.assertEqual(set(sources), set(SOURCES))
        for key, (_, digest) in SOURCES.items():
            self.assertEqual(hashlib.sha256(sources[key].encode()).hexdigest(), digest, key)
        license_bytes = (root / 'Licenses/VQLab-Apache-2.0.txt').read_bytes()
        self.assertEqual(hashlib.sha256(license_bytes).hexdigest(),
                         'cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30')
        self.assertEqual(license_bytes, (root / 'apps/macos/Resources/Licenses/VQLab-Apache-2.0.txt').read_bytes())

    def test_fused_reference_refuses_shape_and_dtype_before_metal(self):
        f = {'columns': 640, 'dimensions': 2, 'entries': 256, 'group_size': 64, 'packing': 'unpacked8'}
        h = {k: {'dtype': dtype, 'shape': shape} for k, dtype, shape in [
            ('codes', 'U8', [7, 320]), ('codebook', 'F16', [256, 2]),
            ('vq_scales', 'F16', [7, 10]), ('expected', 'F16', [7, 640])]}
        validate_fixture(f, h)
        h['codes']['shape'] = [7, 319]
        with self.assertRaises(ValueError): validate_fixture(f, h)
        h['codes']['shape'] = [7, 320]
        h['vq_scales']['dtype'] = 'F32'
        with self.assertRaises(ValueError): validate_fixture(f, h)


if __name__ == '__main__':
    unittest.main()
