#!/usr/bin/env python3
import unittest
from quantization_baseline import rates, validate_observations
import copy
from quantization_fixture import decode, safetensors
from quantization_inventory import unique_json, validate_header
import struct


class ScreenChecks(unittest.TestCase):
    def fixture(self):
        return {'schema_version': 1, 'prompt_ids': [1, 2], 'output_ids': [3, 4, 5], 'stats': {
            'prefillSeconds': 1, 'decodeSeconds': 0.3, 'requestSeconds': 1.3, 'imageEncodeSeconds': 0,
            'prefillRecords': 1, 'decodeRecords': 2, 'prefillTokens': 2, 'decodeTokens': 3,
            'lifetimeRSSPeakBytes': 1024, 'promptTokens': 2, 'prefillPasses': [2],
            'interTokenSeconds': [0.1, 0.1]}}

    def test_distinct_timing_contracts(self):
        actual = rates(self.fixture())
        self.assertEqual(actual['steady_committed_tok_s'], 10)
        self.assertEqual(actual['legacy_decode_tok_s'], 10)
        d = self.fixture(); d['stats']['decodeSeconds'] = 0.4
        self.assertEqual(rates(d)['steady_committed_tok_s'], 10)
        self.assertEqual(rates(d)['legacy_decode_tok_s'], 7.5)
        for intervals in ([0.1], [0, 0], [float('nan'), 1], [True, 1], [-1, 1]):
            d = self.fixture(); d['stats']['interTokenSeconds'] = intervals
            with self.assertRaises(ValueError): rates(d)

    def test_byte_packed_oracle_word_crossings(self):
        # Deliberately cross both byte and UInt32 boundaries with 11-bit codes.
        codes = [0, 1, 2047, 1023, 999, 17, 1888, 2]
        packed = sum(value << (i * 11) for i, value in enumerate(codes)).to_bytes(11, 'little')
        book = b''.join(struct.pack('<e', i / 4096) * 4 for i in range(2048))
        expected = b''.join(struct.pack('<e', i / 4096 * 2) * 4 for i in codes)
        self.assertEqual(decode(packed, book, struct.pack('<e', 2), columns=32, dim=4,
                                entries=2048, group=32, packing='bytes', code_stride=11), expected)
        payload = safetensors([('expected', 'F16', [1, 32], expected)])
        length = struct.unpack('<Q', payload[:8])[0]
        validate_header(unique_json(payload[8:8 + length]), len(payload) - 8 - length)

    def test_memory_and_generation_observations(self):
        good = self.fixture()
        good['stats'].update(generatorSystemBefore={'thermalState': 'nominal', 'lowPowerModeEnabled': False},
                             generatorSystemAfter={'thermalState': 'nominal', 'lowPowerModeEnabled': False},
                             peakMemoryGB=6, lifetimePhysicalFootprintPeakBytes=6_000_000_000,
                             sampledFootprint={'samples': 100, 'peakBytes': 6_000_000_000})
        validate_observations(good)
        for key, value in [('generatorSystemAfter', {'thermalState': 'fair', 'lowPowerModeEnabled': False}),
                           ('sampledFootprint', {'samples': 0, 'peakBytes': 6_000_000_000}),
                           ('peakMemoryGB', 10.01), ('peakMemoryGB', float('nan')),
                           ('lifetimePhysicalFootprintPeakBytes', 0), ('memoryPressureCancelled', True)]:
            changed = copy.deepcopy(good); changed['stats'][key] = value
            with self.assertRaises(ValueError): validate_observations(changed)


if __name__ == '__main__':
    unittest.main()
