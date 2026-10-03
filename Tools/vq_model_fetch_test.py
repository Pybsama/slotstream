import hashlib
from pathlib import Path
import tempfile
import unittest

from vq_model_fetch import atomic, file_map, verify
from vq_model_reference import ARTIFACTS


class ResearchFetchTests(unittest.TestCase):
    def test_incomplete_and_malformed_file_maps_are_refused(self):
        revision = next(iter(ARTIFACTS))
        with self.assertRaisesRegex(ValueError, 'full-file map differs'):
            file_map({'sha': revision, 'siblings': []}, revision)
        for name, size, digest in [('../weights.safetensors', 5, '0' * 64),
                                   ('weights.safetensors', True, '0' * 64),
                                   ('weights.safetensors', 5, 'wrong')]:
            with self.assertRaises(ValueError):
                file_map({'sha': revision, 'siblings': [{'rfilename': name, 'size': size,
                    'lfs': {'size': size, 'sha256': digest}}]}, revision)

    def test_complete_hash_and_no_symlink(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'weights.safetensors'; path.write_bytes(b'payload')
            expected = {'path': path.name, 'bytes': 7, 'sha256': hashlib.sha256(b'payload').hexdigest()}
            self.assertEqual(verify(path, expected), expected)
            path.write_bytes(b'changed')
            with self.assertRaises(ValueError):
                verify(path, expected)
            link = path.with_name('link.safetensors'); link.symlink_to(path)
            with self.assertRaises(OSError):
                verify(link, expected)

    def test_atomic_receipt_replaces_only_after_complete_write(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'verified.json'
            atomic(path, b'first')
            atomic(path, b'second')
            self.assertEqual(path.read_bytes(), b'second')
            temporary = path.with_name(path.name + '.tmp'); temporary.write_bytes(b'interrupted')
            with self.assertRaises(FileExistsError):
                atomic(path, b'third')
            self.assertEqual(path.read_bytes(), b'second')
            self.assertEqual(temporary.read_bytes(), b'interrupted')


if __name__ == '__main__':
    unittest.main()
