import copy
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import vq_draft_inventory as draft


class DraftInventoryTests(unittest.TestCase):
    def setUp(self):
        self.header = json.loads((Path(__file__).resolve().parent.parent /
            'bench/quantization/draft-sidecar-v1-header.json').read_text())
        self.payload = max(v['data_offsets'][1] for k, v in self.header.items() if k != '__metadata__')

    def test_independent_recipe_and_exact_storage_ledger(self):
        value = draft.describe(self.header, self.payload)
        self.assertEqual(value['quantization'], {'kind': 'affine', 'bits': 6, 'group_size': 32})
        self.assertEqual(value['tensor_count'], 71)
        self.assertEqual(value['quantized_modules'], 20)
        self.assertEqual(value['tensor_payload_bytes'], self.payload)
        self.assertEqual(value['expert_record_bytes'] * 512, value['expert_payload_bytes'])
        self.assertEqual(value['other_tensor_bytes'] + value['expert_payload_bytes'], self.payload)
        self.assertFalse(value['legacy_mtp_loader_compatible'])
        self.assertEqual(value['trunk_binding'], 'unqualified')

    def test_main_recipe_missing_metadata_and_unknown_expert_override_refused(self):
        recipes = [{'bits': bits, 'group_size': 64, 'fa_idx': 3} for bits in (4, 8)]
        recipes += [{'bits': 6, 'group_size': 32, 'fa_idx': 3, 'expert_bits': 4},
                    {'bits': 6.0, 'group_size': 32, 'fa_idx': 3}, {}]
        for recipe in recipes:
            header = copy.deepcopy(self.header)
            header['__metadata__']['vqlab_mtp'] = json.dumps(recipe)
            with self.assertRaisesRegex(ValueError, 'draft recipe'):
                draft.describe(header, self.payload)
        header = copy.deepcopy(self.header); del header['__metadata__']
        with self.assertRaisesRegex(ValueError, 'independent VQLab metadata'):
            draft.describe(header, self.payload)

    def test_missing_family_and_damaged_extent_refused(self):
        header = copy.deepcopy(self.header); del header['norm_e.weight']
        with self.assertRaises(ValueError):
            draft.describe(header, self.payload)
        header = copy.deepcopy(self.header)
        header['block.mlp.switch_mlp.up_proj.weight']['data_offsets'][1] -= 1
        with self.assertRaises(ValueError):
            draft.describe(header, self.payload)

    def test_header_authentication_does_not_claim_payload_authentication(self):
        # Bounded stand-in exercises the file-authentication boundary without
        # allocating or hashing the real multi-GB head. Layout has its own tests.
        raw = b'{}'; prefix = len(raw).to_bytes(8, 'little'); payload = b'abcdef'
        body = prefix + raw + payload
        with tempfile.TemporaryDirectory() as directory, \
                patch.object(draft, 'FILE_BYTES', len(body)), \
                patch.object(draft, 'HEADER_SHA256', hashlib.sha256(prefix + raw).hexdigest()), \
                patch.object(draft, 'FILE_SHA256', hashlib.sha256(body).hexdigest()), \
                patch.object(draft, 'describe', return_value={}):
            path = Path(directory) / 'head'; path.write_bytes(body)
            self.assertFalse(draft.inspect(path)['payload_verified'])
            self.assertTrue(draft.inspect(path, True)['payload_verified'])
            path.write_bytes(prefix + raw + b'abcdeg')
            self.assertFalse(draft.inspect(path)['payload_verified'])
            with self.assertRaisesRegex(ValueError, 'draft payload differs'):
                draft.inspect(path, True)
            path.write_bytes(bytes(8) + raw + payload)
            with self.assertRaisesRegex(ValueError, 'header exceeds'):
                draft.inspect(path)
            link = Path(directory) / 'link'; link.symlink_to(path)
            with self.assertRaises(OSError):
                draft.inspect(link)


if __name__ == '__main__':
    unittest.main()
