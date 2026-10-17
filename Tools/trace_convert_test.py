"""Tiny binary-to-npz routing conversions; requires the converter's NumPy."""
import struct
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

import numpy as np


LAYERS, TOPK = 48, 10
SCRIPT = Path(__file__).with_name('trace_convert.py')


class TraceConvertChecks(unittest.TestCase):
    def convert(self, passes, *, keep_all=False):
        """Write the production RouterTrace wire format, including partial passes."""
        raw = bytearray()
        expected = []
        for number, (tokens, layers) in enumerate(passes):
            ids = np.array([[[((number * 71 + token * 97 + layer * TOPK + slot) % 512)
                              for slot in range(TOPK)] for layer in range(LAYERS)]
                            for token in range(tokens)], dtype=np.int16)
            for layer in layers:
                raw.extend(struct.pack('<iii', layer, tokens, TOPK))
                raw.extend(ids[:, layer, :].astype('<i2').tobytes())
            if len(layers) == LAYERS and (keep_all or tokens == 1):
                expected.extend(ids)
        with tempfile.TemporaryDirectory() as folder:
            source, output = Path(folder) / 'trace.bin', Path(folder) / 'trace.npz'
            source.write_bytes(raw)
            result = subprocess.run([sys.executable, str(SCRIPT), str(source), str(output)]
                                    + (['--all'] if keep_all else []),
                                    capture_output=True, text=True, check=True, timeout=10)
            with np.load(output, allow_pickle=False) as archive:
                self.assertEqual(archive.files, ['decode'])
                observed = archive['decode']
        wanted = np.array(expected, dtype=np.int16).reshape(-1, LAYERS, TOPK)
        self.assertEqual(observed.dtype, np.dtype('int16'))
        np.testing.assert_array_equal(observed, wanted)
        self.assertIn(f'{len(wanted)} complete steps x {LAYERS} layers x {TOPK}', result.stdout)

    def test_all_preserves_single_token_pass(self):
        self.convert([(1, range(LAYERS))], keep_all=True)

    def test_default_keeps_only_single_token_passes(self):
        self.convert([(2, range(LAYERS)), (1, range(LAYERS)),
                      (3, range(LAYERS)), (1, range(LAYERS))])

    def test_partial_single_token_passes_are_dropped(self):
        self.convert([(1, range(7)), (1, range(LAYERS)), (1, range(7))])

    def test_only_partial_pass_keeps_empty_output(self):
        self.convert([(2, range(7))], keep_all=True)

    def test_all_preserves_every_token_from_one_pass(self):
        self.convert([(2, range(LAYERS))], keep_all=True)

    def test_all_preserves_variable_length_pass_order(self):
        self.convert([(2, range(LAYERS)), (1, range(LAYERS)),
                      (3, range(LAYERS))], keep_all=True)

    def test_all_drops_partial_passes_around_complete_tokens(self):
        self.convert([(2, range(7)), (3, range(LAYERS)),
                      (2, range(7))], keep_all=True)

    def test_all_rejects_pruned_layer_instead_of_broadcasting_it(self):
        # Terminal-prefill pruning records only the final token at the last
        # layer. The dense npz format cannot represent that ragged pass.
        raw = bytearray()
        for layer in range(LAYERS):
            tokens = [1] if layer == LAYERS - 1 else [0, 1]
            raw.extend(struct.pack('<iii', layer, len(tokens), TOPK))
            for token in tokens:
                raw.extend(struct.pack('<' + 'h' * TOPK,
                    *[(token * 97 + layer * TOPK + slot) % 512 for slot in range(TOPK)]))
        with tempfile.TemporaryDirectory() as folder:
            source, output = Path(folder) / 'trace.bin', Path(folder) / 'trace.npz'
            source.write_bytes(raw)
            result = subprocess.run([sys.executable, str(SCRIPT), str(source), str(output), '--all'],
                                    capture_output=True, text=True, timeout=10)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('same token count and topK', result.stderr)
            self.assertFalse(output.exists())


if __name__ == '__main__':
    unittest.main()
