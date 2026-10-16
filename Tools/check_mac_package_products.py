#!/usr/bin/env python3
"""Keep local package products distinct in Xcode's combined dependency graph."""
import json
from pathlib import Path
import subprocess
import sys


def main():
    root = Path(__file__).resolve().parent.parent
    owners = {}
    collisions = []
    for package in [root, root / "apps/macos"]:
        manifest = json.loads(subprocess.check_output(
            ["swift", "package", "--package-path", str(package), "dump-package"], text=True))
        for product in manifest["products"]:
            name = product["name"]
            owner = str(package.relative_to(root))
            if name in owners:
                collisions.append(f"{name}: {owners[name]} and {owner}")
            owners[name] = owner
    if collisions:
        sys.exit("Xcode package product names collide: " + "; ".join(collisions))
    print("PASS: local package product names are distinct in Xcode's dependency graph")


if __name__ == "__main__":
    main()
