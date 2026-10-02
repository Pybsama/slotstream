#!/usr/bin/env python3
import array
import hashlib
import json
import math
from pathlib import Path
import sys
import tempfile
import unittest
from quantization_quality import compare, metrics, VOCABULARY


class QualityChecks(unittest.TestCase):
    def test_full_distribution_and_shift(self):
        ref, candidate = [2.0, 1.0, 0.0, -1.0], [2.0, 1.0, -0.5, -0.5]
        self.assertEqual(metrics(ref, ref)['kl_reference_to_other'], 0)
        result = metrics(ref, candidate)
        self.assertTrue(result['top1_agrees'])
        self.assertGreater(result['kl_reference_to_other'], 0)  # unchanged top two still lose tail mass
        shifted = metrics([x + 10000 for x in ref], [x - 10000 for x in candidate])
        self.assertAlmostEqual(result['kl_reference_to_other'], shifted['kl_reference_to_other'], places=12)
        for other in ([1], [math.nan, 0, 0, 0], [math.inf, 0, 0, 0]):
            with self.assertRaises(ValueError): metrics(ref, other)

    def fixture(self, directory, name):
        root = directory / name; root.mkdir()
        data = array.array('f', [0]) * VOCABULARY
        data[1] = 1
        if sys.byteorder != 'little': data.byteswap()
        payload = data.tobytes()
        (root / 'a.f32').write_bytes(payload)
        manifest = {'schema': 1, 'vocabulary': VOCABULARY, 'format': 'f32le', 'scope': 'pilot',
                    'artifact': {'checkpoint': 'same-checkpoint', 'checkpoint_revision': '1' * 40, 'tokenizer_sha256': 'a' * 64,
                                 'template_sha256': 'b' * 64, 'pack_sha256': hashlib.sha256(name.encode()).hexdigest(),
                                 'runtime_sha256': 'd' * 64, 'arithmetic': 'test-only'},
                    'cases': [{'id': 'a', 'family': 'tools', 'tokens': [1, 2, 3], 'positions': [2],
                               'file': 'a.f32', 'sha256': hashlib.sha256(payload).hexdigest()}]}
        path = root / 'manifest.json'; path.write_text(json.dumps(manifest))
        return path, manifest

    def test_context_identity_and_digest_binding(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            ref, _ = self.fixture(root, 'ref')
            base, _ = self.fixture(root, 'base')
            cand, data = self.fixture(root, 'candidate')
            result = compare(ref, base, cand)
            self.assertEqual(result['mean_case_delta_kl'], 0)
            self.assertEqual(result['qualification'], 'unproven')
            for mutate in [lambda d: d['cases'][0]['tokens'].__setitem__(0, 4),
                           lambda d: d['cases'][0].__setitem__('positions', [1]),
                           lambda d: d['artifact'].__setitem__('template_sha256', 'e' * 64),
                           lambda d: d.__setitem__('scope', 'held-out'),
                           lambda d: d['cases'][0].__setitem__('file', '../a.f32'),
                           lambda d: d['cases'][0].__setitem__('sha256', 'f' * 64)]:
                changed = json.loads(json.dumps(data)); mutate(changed)
                cand.write_text(json.dumps(changed))
                with self.assertRaises(ValueError): compare(ref, base, cand)
            cand.write_text(json.dumps(data))
            (cand.parent / 'a.f32').write_bytes(b'wrong size')
            with self.assertRaises(ValueError): compare(ref, base, cand)


if __name__ == '__main__':
    unittest.main()
