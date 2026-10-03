#!/usr/bin/env python3
import copy
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import quantization_logit_pilot as pilot
import quantization_logit_run as run
import quantization_logit_compare as comparison


class PilotTests(unittest.TestCase):
    def test_mixed_producer_arithmetic_refused(self):
        record = {'arm': 'vq', 'producer': {}, '_sha256': 'a' * 64}
        receipt = {'layers': 48, 'architecture_sha256': comparison.ARCH_SHA256,
                   'runtime_sha256': comparison.RUNTIME_SHA256, 'vq_decode_chunk': 32,
                   'instrument': {'sha256': 'b' * 64}, 'artifact': {'inventory_sha256': 'c' * 64}}
        good = comparison.producer_artifact(record, [receipt, copy.deepcopy(receipt)], {})
        self.assertEqual(good['runtime_sha256'], 'b' * 64)
        for field, value in [('layers', 4), ('vq_decode_chunk', 16), ('artifact', {}),
                             ('instrument', {'sha256': 'd' * 64})]:
            bad = copy.deepcopy(receipt); bad[field] = value
            with self.assertRaises(ValueError): comparison.producer_artifact(record, [receipt, bad], {})

    def test_owned_corpus_bounds_and_retrieval_answer(self):
        protocol = json.loads((Path(__file__).resolve().parents[1] / 'bench/quantization/logit-pilot-v1.json').read_text())
        rows = pilot.texts(protocol)
        self.assertEqual(len(rows), 6)
        retrieval = rows[-1][1]
        self.assertIn('Record 37: item code R1369; shelf 2; status checked.', retrieval)
        bad = copy.deepcopy(protocol); bad['cases'][-1]['records'] = True
        with self.assertRaises(ValueError): pilot.texts(bad)
        bad = copy.deepcopy(protocol); bad['cases'][1]['id'] = bad['cases'][0]['id']
        with self.assertRaises(ValueError): pilot.texts(bad)

    def test_wrong_tokenizer_refused_before_output(self):
        protocol = Path(__file__).resolve().parents[1] / 'bench/quantization/logit-pilot-v1.json'
        with tempfile.TemporaryDirectory() as name:
            root = Path(name); tokenizer = root / 'tokenizer.json'; tokenizer.write_text('{}')
            with patch.object(pilot.importlib.metadata, 'version', return_value='0.23.1'):
                with self.assertRaisesRegex(ValueError, 'original tokenizer'):
                    pilot.prepare(protocol, tokenizer, root / 'output')
            self.assertFalse((root / 'output').exists())

    def test_changed_context_or_positions_refused(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name); raw = b'[1, 2]\n'
            cases = []
            for suffix in 'abcdef':
                filename = suffix + '.json'; (root / filename).write_bytes(raw)
                cases.append({'id': suffix, 'file': filename, 'tokens': [1, 2], 'positions': [0, 1],
                              'tokens_sha256': hashlib.sha256(raw).hexdigest()})
            original = {'schema': 1, 'scope': 'pilot', 'cases': cases}
            path = root / 'inputs.json'; path.write_text(json.dumps(original))
            self.assertEqual(len(run.inputs(path)[0]['cases']), 6)
            for field, value in [('positions', [1]), ('tokens', [1, 3]), ('file', '../a.json')]:
                bad = copy.deepcopy(original); bad['cases'][0][field] = value; path.write_text(json.dumps(bad))
                with self.assertRaises(ValueError): run.inputs(path)
            path.write_text(json.dumps(original)); (root / 'a.json').write_bytes(b'[1, true]\n')
            with self.assertRaises(ValueError): run.inputs(path)


if __name__ == '__main__':
    unittest.main()
