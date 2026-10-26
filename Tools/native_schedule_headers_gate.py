#!/usr/bin/env python3
"""Refuse a native MLX extension whose pinned C++ headers drift from its ABI."""
import hashlib
import json
from pathlib import Path
import re


def check(root):
    extension = root / "Sources/CNativeSchedule"
    manifest = json.loads((extension / "vendor-manifest.json").read_text())
    package = (root / "Package.swift").read_text()
    revision = re.search(r'mlx-swift\.git", revision: "([a-f0-9]{40})"', package)
    if revision is None or revision[1] != manifest["revision"]:
        raise ValueError("MLX dependency changed: refresh and requalify the native extension headers")
    actual = {str(p.relative_to(extension / "vendor")): hashlib.sha256(p.read_bytes()).hexdigest()
              for p in (extension / "vendor").rglob("*") if p.is_file()}
    if actual != manifest["files"]:
        raise ValueError("Native MLX headers differ from the pinned upstream manifest")
    splash = json.loads((extension / "splash-manifest.json").read_text())
    source = {str(p.relative_to(extension / "splash")): hashlib.sha256(p.read_bytes()).hexdigest()
              for p in (extension / "splash").rglob("*") if p.is_file()}
    if source != splash["files"] or splash["revision"] != "1482f6bbc2abf12375332725302019594150b6cb":
        raise ValueError("Native adaptive replacement differs from the pinned Splash source")
    checkout = root / ".build/checkouts/mlx-swift/Source/Cmlx"
    if checkout.exists():
        for name, digest in actual.items():
            origin = checkout / ("mlx" if name.startswith("mlx/") else "metal-cpp") / name
            if not origin.is_file() or hashlib.sha256(origin.read_bytes()).hexdigest() != digest:
                raise ValueError(f"MLX checkout header differs: {name}")
        for name, digest in manifest["context_adapters"].items():
            if hashlib.sha256((checkout / "mlx-c" / name).read_bytes()).hexdigest() != digest:
                raise ValueError(f"MLX context adapter changed: {name}")
    return len(actual)


if __name__ == "__main__":
    print(f"Native schedule ABI gate: {check(Path(__file__).resolve().parent.parent)} pinned headers PASS")
