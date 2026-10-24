#!/usr/bin/env python3
"""Check that the native bridge refuses dependency and ABI drift."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest

from native_schedule_headers_gate import check


class NativeHeadersGateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.extension = self.root / "Sources/CNativeSchedule"
        self.checkout = self.root / ".build/checkouts/mlx-swift/Source/Cmlx"
        self.revision = "a" * 40
        self.write("Package.swift", f'mlx-swift.git", revision: "{self.revision}"')
        headers = {"mlx/array.h": b"array ABI", "Metal/Metal.hpp": b"Metal ABI"}
        for name, content in headers.items():
            self.write("Sources/CNativeSchedule/vendor/" + name, content)
            source = "mlx/" if name.startswith("mlx/") else "metal-cpp/"
            self.write(".build/checkouts/mlx-swift/Source/Cmlx/" + source + name, content)
        self.write(".build/checkouts/mlx-swift/Source/Cmlx/mlx-c/array.cpp", b"array context")
        self.manifest = {
            "revision": self.revision,
            "files": {name: self.sha(content) for name, content in headers.items()},
            "context_adapters": {"array.cpp": self.sha(b"array context")},
        }
        self.write("Sources/CNativeSchedule/vendor-manifest.json", json.dumps(self.manifest))
        self.write("Sources/CNativeSchedule/splash/model/SlotRecycler.cpp", b"cache metadata")
        self.write("Sources/CNativeSchedule/splash-manifest.json", json.dumps({
            "revision": "1482f6bbc2abf12375332725302019594150b6cb",
            "files": {"model/SlotRecycler.cpp": self.sha(b"cache metadata")},
        }))

    @staticmethod
    def sha(content):
        return hashlib.sha256(content).hexdigest()

    def write(self, relative, content):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content if isinstance(content, bytes) else content.encode())

    def test_matching_dependency_and_context(self):
        self.assertEqual(check(self.root), 2)

    def test_dependency_revision_change(self):
        self.write("Package.swift", 'mlx-swift.git", revision: "' + "b" * 40 + '"')
        with self.assertRaisesRegex(ValueError, "dependency changed"):
            check(self.root)

    def test_vendored_header_change(self):
        self.write("Sources/CNativeSchedule/vendor/mlx/array.h", b"different array ABI")
        with self.assertRaisesRegex(ValueError, "headers differ"):
            check(self.root)

    def test_manifest_cannot_hide_checkout_mismatch(self):
        content = b"different array ABI"
        self.write("Sources/CNativeSchedule/vendor/mlx/array.h", content)
        self.manifest["files"]["mlx/array.h"] = self.sha(content)
        self.write("Sources/CNativeSchedule/vendor-manifest.json", json.dumps(self.manifest))
        with self.assertRaisesRegex(ValueError, "checkout header differs"):
            check(self.root)

    def test_c_context_adapter_change(self):
        self.write(".build/checkouts/mlx-swift/Source/Cmlx/mlx-c/array.cpp", b"new context ABI")
        with self.assertRaisesRegex(ValueError, "context adapter changed"):
            check(self.root)

    def test_upstream_recycler_change(self):
        self.write("Sources/CNativeSchedule/splash/model/SlotRecycler.cpp", b"new algorithm")
        with self.assertRaisesRegex(ValueError, "adaptive replacement differs"):
            check(self.root)


if __name__ == "__main__":
    unittest.main()
