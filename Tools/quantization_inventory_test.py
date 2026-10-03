#!/usr/bin/env python3
import unittest
from unittest.mock import patch
import io
from quantization_inventory import validate_header, unique_json, relative_path, product, Remote


class InventoryChecks(unittest.TestCase):
    def test_range_response_and_budget(self):
        class Response(io.BytesIO):
            def __init__(self, body, status=206, content_range="bytes 4-7/8", encoding="identity"):
                super().__init__(body)
                self.status = status
                self.headers = {"Content-Range": content_range, "Content-Encoding": encoding}
        remote = Remote("owner/repo", "a" * 40, maximum_bytes=4)
        with patch("urllib.request.urlopen", return_value=Response(b"abcd")):
            self.assertEqual(remote.get("weights.safetensors", start=4, count=4), (b"abcd", 8))
        with patch("urllib.request.urlopen") as request:
            with self.assertRaises(ValueError): remote.get("weights.safetensors", start=4, count=1)
            request.assert_not_called()
        for response in [Response(b"abcd", status=200), Response(b"abcd", content_range="bytes 0-3/8"),
                         Response(b"abcd", content_range="bytes 4-7/6"), Response(b"abc"),
                         Response(b"abcde"), Response(b"abcd", encoding="gzip")]:
            with patch("urllib.request.urlopen", return_value=response):
                with self.assertRaises(ValueError):
                    Remote("owner/repo", "a" * 40).get("weights", start=4, count=4)
        for offset in [-1, True, 1 << 63]:
            with self.assertRaises(ValueError): remote.get("weights", start=offset, count=4)

    def test_coverage_and_overflow(self):
        valid = {"w": {"dtype": "U32", "shape": [2, 3], "data_offsets": [0, 24]},
                 "empty": {"dtype": "F16", "shape": [0], "data_offsets": [0, 0]}}
        validate_header(valid, 24)
        for shape, offsets, payload in [([2, 3], [1, 25], 25), ([2, 3], [0, 23], 24),
                                        ([1 << 62, 8], [0, 24], 24), ([True], [0, 4], 4),
                                        ([-1], [0, 0], 0)]:
            with self.assertRaises(ValueError):
                validate_header({"w": {"dtype": "U32", "shape": shape, "data_offsets": offsets}}, payload)
        with self.assertRaises(ValueError):
            validate_header({"a": valid["w"], "b": valid["w"]}, 24)

    def test_identity_and_paths(self):
        Remote("owner/repo", "a" * 40)
        for pin in ("main", "../../escape", "A" * 40, "a" * 39):
            with self.assertRaises(ValueError):
                Remote("owner/repo", pin)
        for path in ("/absolute", "../escape", "a/../b", "a//b", "a\\b", "./a"):
            with self.assertRaises(ValueError):
                relative_path(path)
        with self.assertRaises(ValueError):
            unique_json('{"weight": 1, "weight": 2}')
        self.assertEqual(product([512, 640, 140, 4]), 183500800)


if __name__ == "__main__":
    unittest.main()
