import hashlib
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from vq_execution_profile import allocation_layers, recheck_runtime, select_runtime


class ExecutionProfileTests(unittest.TestCase):
    def test_coverage_refuses_missing_third_class_and_wrong_boundary(self):
        revision = '8684640a3956b01c47f5d47f9b999e2ab8b985f1'
        def config(third):
            return {'vq_modules': {
                f'model.layers.{layer}.mlp.switch_mlp.{projection}':
                    {'class': 0 if layer < 2 else 1 if layer < third else 2}
                for layer in range(48) for projection in ('gate_proj', 'up_proj', 'down_proj')}}
        self.assertEqual(allocation_layers(config(27), revision), [0, 2, 27])
        for third in (26, 28, 48):
            with self.assertRaisesRegex(ValueError, 'allocation classes differ'):
                allocation_layers(config(third), revision)
        with self.assertRaisesRegex(ValueError, 'allocation classes differ'):
            allocation_layers(config(27), 'uninspected')

    def test_older_bundle_requires_explicit_reviewed_source_and_is_preserved(self):
        # These files are deliberately not executable Python. Selection is
        # bounded hashing only; actual execution keeps its independent hash gate.
        old, reviewed = b'older bundled data', b'reviewed source data'
        with tempfile.TemporaryDirectory() as directory, \
                patch('vq_execution_profile.OLDER_BUNDLE_SHA256', hashlib.sha256(old).hexdigest()), \
                patch('vq_execution_profile.RUNTIME_SHA256', hashlib.sha256(reviewed).hexdigest()):
            model = Path(directory); bundled = model / 'model.py'; bundled.write_bytes(old)
            override = model / 'reviewed.py'; override.write_bytes(reviewed)
            with self.assertRaisesRegex(ValueError, 'explicit reviewed'):
                select_runtime(model)
            with self.assertRaisesRegex(ValueError, 'not the reviewed runtime'):
                select_runtime(model, bundled)
            selected, profile = select_runtime(model, override)
            self.assertEqual(selected, override)
            self.assertEqual(profile['mode'], 'explicit-reviewed-v1')
            self.assertNotEqual(profile['runtime_sha256'], profile['bundled_runtime_sha256'])
            self.assertEqual(bundled.read_bytes(), old)
            recheck_runtime(model, override, profile)
            override.write_bytes(b'changed')
            with self.assertRaisesRegex(ValueError, 'not the reviewed runtime'):
                recheck_runtime(model, override, profile)

    def test_default_profile_remains_bound_to_bundle_and_rechecks_both_sources(self):
        reviewed = b'reviewed source data'
        with tempfile.TemporaryDirectory() as directory, \
                patch('vq_execution_profile.RUNTIME_SHA256', hashlib.sha256(reviewed).hexdigest()):
            model = Path(directory); bundled = model / 'model.py'; bundled.write_bytes(reviewed)
            selected, profile = select_runtime(model)
            self.assertEqual(selected, bundled)
            self.assertEqual(profile['mode'], 'bundled-reviewed-v1')
            self.assertEqual(profile['runtime_sha256'], profile['bundled_runtime_sha256'])
            explicit = model / 'separate.py'; explicit.write_bytes(reviewed)
            explicit_profile = select_runtime(model, explicit)[1]
            self.assertNotEqual(profile, explicit_profile)
            with self.assertRaisesRegex(ValueError, 'profile changed'):
                recheck_runtime(model, explicit, profile)
            bundled.write_bytes(b'uninspected remote code')
            with self.assertRaisesRegex(ValueError, 'uninspected bundled'):
                recheck_runtime(model, explicit, explicit_profile)


if __name__ == '__main__':
    unittest.main()
