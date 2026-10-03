import hashlib
import json
from pathlib import Path
import tempfile
from types import SimpleNamespace
from types import ModuleType
import sys
import unittest
from unittest.mock import patch

from vq_model_reference import ARTIFACTS, checked_source, put, resolve, verify_files, recheck_owned_headroom, references


class ModelReferenceTests(unittest.TestCase):
    def test_expert_chunk_is_frozen_after_import(self):
        package = ModuleType('mlx_lm'); package.__path__ = []
        models = ModuleType('mlx_lm.models'); models.__path__ = []
        package.models = models
        with patch.dict(sys.modules, {'mlx_lm': package, 'mlx_lm.models': models}), \
                patch('vq_model_reference.checked_source', side_effect=[b'x = 1\n',
                    b'_DECODE_CHUNK = None\nclass VQPLEEmbedding:\n    pass\n']), \
                patch.dict('os.environ', {}, clear=True):
            _, runtime = references(Path('architecture.py'), Path('model.py'))
            self.assertEqual(runtime['_DECODE_CHUNK'], 32)
            self.assertNotIn('VQ_DECODE_CHUNK', __import__('os').environ)

    def test_owned_recheck_does_not_reacquire_the_process_lock(self):
        from context_qualification import verification_lock
        with tempfile.TemporaryDirectory() as directory:
            # Isolate from a real user's model lock; still use its actual
            # context manager and flock semantics in this regression.
            with patch('context_qualification.MODEL_LOCK', Path(directory) / 'lock'):
                with verification_lock(), patch('prefill_bench.vm_snapshot', return_value={'reclaimable_bytes': 14_000_000_000}), \
                        patch('vq_model_reference.subprocess.check_output', side_effect=['1', 'python3\n']), \
                        patch('prefill_bench.fcntl.flock', side_effect=AssertionError('recursive lock probe')):
                    self.assertEqual(recheck_owned_headroom()['reclaimable_bytes'], 14_000_000_000)
        with patch('prefill_bench.vm_snapshot', return_value={'reclaimable_bytes': 12_999_999_999}):
            with self.assertRaisesRegex(RuntimeError, 'headroom'):
                recheck_owned_headroom()

    def test_metadata_cannot_replace_the_pinned_file_digests(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            revision = next(iter(ARTIFACTS))
            repo, config, _ = ARTIFACTS[revision]
            hub = json.dumps({'sha': revision, 'siblings': []}).encode()
            (root / 'hub-files.json').write_bytes(hub)
            (root / 'verified.json').write_text(json.dumps({'schema': 1, 'repo': repo,
                'revision': revision, 'hub_metadata_sha256': hashlib.sha256(hub).hexdigest(), 'files': []}))
            inventory = root / 'inventory.json'
            inventory.write_text(json.dumps({'schema': 1, 'repo': repo, 'revision': revision,
                'files': {'config.json': {'sha256': config}}}))
            with self.assertRaisesRegex(ValueError, 'full-file digests differ'):
                verify_files(root, inventory)

    def test_source_hash_precedes_execution(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'source.py'
            path.write_text("raise RuntimeError('must never run')")
            with self.assertRaisesRegex(ValueError, 'source identity mismatch'):
                checked_source(path, '0' * 64)

    def test_layout_mapping_requires_existing_module(self):
        shard = SimpleNamespace(book=1)
        root = SimpleNamespace(model=SimpleNamespace(layers=[SimpleNamespace(ple=SimpleNamespace(
            ple_embedding=SimpleNamespace(ngram_embedding=SimpleNamespace(shards=[shard]))))]))
        key = 'model.layers.0.ple.ple_embedding.ngram_embedding.shard_0'
        owner, leaf, normalized = resolve(root, key)
        self.assertEqual((owner, leaf), ([shard], '0'))
        self.assertTrue(normalized.endswith('.shards.0'))
        replacement = SimpleNamespace(book=2)
        put(root, key, replacement)
        self.assertIs(root.model.layers[0].ple.ple_embedding.ngram_embedding.shards[0], replacement)
        with self.assertRaises(ValueError):
            put(root, 'model.missing', replacement)
        with self.assertRaises(IndexError):
            put(root, key.replace('shard_0', 'shard_1'), replacement)


if __name__ == '__main__':
    unittest.main()
