#!/usr/bin/env python3
"""Compile a frozen Q2 shader fixture for an isolated performance experiment.

This does not change the app, engine, model selection or runtime shader lookup.
Every source and compiler option comes from the hashed fixture. The resulting
libraries still require local exact-output and complete-request qualification.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import tarfile
import time


def digest(data):
    return hashlib.sha256(data).hexdigest()


def flags(options):
    expected = {
        "dynamic_libraries": [], "install_name": "", "language": 262144,
        "library_type": 0, "macros": {}, "max_threads": 0, "optimization": 0,
        "preserve_invariance": False, "required_threads": [0, 0, 0],
        "undefined_symbols": False, "visibility": 0,
    }
    if any(options.get(k) != v for k, v in expected.items()):
        raise ValueError("Unqualified compiler options in shader fixture")
    if set(options) != set(expected) | {"fast_math", "math_mode", "math_functions", "logging"}:
        raise ValueError("Unknown compiler option")
    mode = {0: "safe", 1: "relaxed", 2: "fast"}[options["math_mode"]]
    functions = {0: "fast", 1: "precise"}[options["math_functions"]]
    if options["fast_math"] != (mode == "fast") or type(options["logging"]) is not bool:
        raise ValueError("Inconsistent legacy math flag or logging value")
    result = ["-std=metal4.0", "-mmacosx-version-min=26.1",
              "-fmetal-math-mode=" + mode,
              "-fmetal-math-fp32-functions=" + functions]
    if options["logging"]:
        result.append("-fmetal-enable-logging")
    return result


def read_fixture(path):
    receipt = json.loads(path.read_text())
    name = receipt["archive"]
    if Path(name).name != name or receipt["schema_version"] != 1:
        raise ValueError("Invalid fixture path or version")
    archive = path.parent / name
    data = archive.read_bytes()
    if len(data) != receipt["bytes"] or digest(data) != receipt["sha256"]:
        raise ValueError("Shader archive identity mismatch")
    files = {}
    total = 0
    with tarfile.open(archive, "r:xz") as source:
        for member in source:
            if not member.isfile() or member.name in files:
                raise ValueError("Fixture contains a link, directory or duplicate")
            total += member.size
            if len(files) >= 260 or member.size > 2_000_000 or total > 32 * 1024 * 1024:
                raise ValueError("Fixture exceeds bounded source capacity")
            files[member.name] = source.extractfile(member).read()
    manifest = json.loads(files["manifest.json"])
    if manifest["schema_version"] != 1 or not 1 <= len(manifest["units"]) <= 256:
        raise ValueError("Invalid source manifest")
    if len(manifest["units"]) != receipt["units"]:
        raise ValueError("Shader count mismatch")
    ids = set()
    for unit in manifest["units"]:
        blob = files["sources/" + unit["source_sha256"] + ".metal"]
        if digest(blob) != unit["source_sha256"] or len(blob) != unit["source_bytes"]:
            raise ValueError("Shader source identity mismatch")
        options = json.dumps(unit["options"], sort_keys=True, separators=(",", ":"))
        identity = digest(blob) + "-" + digest(options.encode())[:16]
        if identity != unit["id"] or identity in ids:
            raise ValueError("Shader unit identity mismatch")
        ids.add(identity)
        flags(unit["options"])
    return receipt, manifest, files


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fixture", type=Path, required=True)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--validate-only", action="store_true")
    args = parser.parse_args()
    receipt, manifest, files = read_fixture(args.fixture)
    if args.validate_only:
        print(f"Validated {len(manifest['units'])} original shader sources and options")
        return
    if args.output is None:
        parser.error("--output is required for compilation")
    out = args.output
    out.mkdir(parents=True, exist_ok=False)
    source_dir = out / "sources"
    source_dir.mkdir()
    libraries = out / "libraries"
    libraries.mkdir()
    for name, data in files.items():
        if name.startswith("LICENSE-") or name == "NOTICE-splash.txt":
            if Path(name).name != name:
                raise ValueError("Invalid notice path")
            (out / name).write_bytes(data)
    result = {"complete": False, "fixture": receipt, "units": [], "toolchain": {}}
    report = out / "result.json"
    report.write_text(json.dumps(result, indent=2))
    for name, command in [("xcode", ["xcodebuild", "-version"]),
                          ("sdk", ["xcrun", "--show-sdk-version"]),
                          ("metal", ["xcrun", "metal", "--version"]),
                          ("metal-help", ["xcrun", "metal", "--help"])]:
        proc = subprocess.run(command, capture_output=True, text=True, timeout=60)
        (out / (name + ".log")).write_text(proc.stdout + proc.stderr)
        result["toolchain"][name] = {"command": command, "exit_code": proc.returncode}
        if proc.returncode:
            report.write_text(json.dumps(result, indent=2))
            raise RuntimeError("Metal toolchain check failed: " + name)
    for unit in manifest["units"]:
        identity = unit["id"]
        source = source_dir / (identity + ".metal")
        source.write_bytes(files["sources/" + unit["source_sha256"] + ".metal"])
        library = libraries / (identity + ".metallib")
        command = ["xcrun", "-sdk", "macosx", "metal", *flags(unit["options"]),
                   str(source), "-o", str(library)]
        start = time.monotonic()
        proc = subprocess.run(command, capture_output=True, text=True, timeout=120)
        (out / (identity + ".log")).write_text(proc.stdout + proc.stderr)
        row = {**unit, "command": command, "seconds": time.monotonic() - start,
               "exit_code": proc.returncode}
        if proc.returncode == 0 and library.is_file():
            blob = library.read_bytes()
            row.update(library="libraries/" + library.name,
                       library_sha256=digest(blob), library_bytes=len(blob))
        result["units"].append(row)
        report.write_text(json.dumps(result, indent=2))
        if proc.returncode or "library_sha256" not in row:
            raise RuntimeError("Shader compilation failed: " + identity)
        print(f"Compiled {len(result['units'])}/{len(manifest['units'])}", flush=True)
    result["complete"] = True
    report.write_text(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
