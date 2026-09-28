"""All 640 rows of one VQ gate expert, in ten independently bounded tiles.

Reference: exact binary16 decode plus Python math.fsum, not the checkpoint's
fused/simdgroup prefill/decode kernel or its F16/BF16 I/O contract.
"""

import argparse
import hashlib
import json
import math
import pathlib
import platform
import re
import struct
import subprocess
import sys
from datetime import datetime, timezone

if not __debug__:
    raise RuntimeError("Full-gate proof requires Python assertions; do not use -O")

from fetch_full_gate import FILE, MODEL, MODULE, PARTS, REVISION
from test_projection import ABS_TOL, REL_TOL, vectors
from test_proof import expected


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def verified_parts(root):
    receipt = json.loads((root / "fetch-receipt.json").read_text())
    assert (receipt["model"], receipt["revision"], receipt["file"],
            receipt["module"], receipt["range_count"], receipt["total_payload_bytes"]) == (
                MODEL, REVISION, FILE, MODULE, 3, 671744)
    assert receipt["raw_header_sha256"] == "bfd18ce5181df0df90b3bc44551768e9ea0720111b5cc4b8029fdb5b9a37d463"
    assert receipt["fetch_script_sha256"] == sha256((pathlib.Path(__file__).parent / "fetch_full_gate.py").read_bytes())
    assert len(receipt["ranges"]) == len(PARTS)
    parts = {}
    for expected_part, record in zip(PARTS, receipt["ranges"]):
        name, suffix, offset, count, dtype, shape = expected_part
        assert record["tensor"] == MODULE + "." + suffix
        assert (record["revision"], record["file"], record["offset"],
                record["count"], record["dtype"], record["full_shape"]) == (
                    REVISION, FILE, offset, count, dtype, shape)
        response = record["response"]
        assert response["status"] == 206
        assert response["headers"]["Content-Range"] == f"bytes {offset}-{offset + count - 1}/4216376100"
        assert response["received_body_bytes"] == count
        blob = (root / "parts" / (name + ".bin")).read_bytes()
        assert len(blob) == count and sha256(blob) == record["sha256"]
        parts[name] = blob
    return receipt, parts


def make_tile(root, parts, start, end):
    rows = end - start
    assert 0 <= start < end <= 640 and 1 <= rows <= 64
    dest = root / "fixtures" / f"tile-{start:03d}-{end - 1:03d}"
    dest.mkdir(parents=True, exist_ok=True)
    geometry = {"rows": rows, "input": 2560, "dimension": 8, "groupSize": 64,
                "codebookSize": 16384, "storage": "packed32", "output": "f16"}
    (dest / "geometry.json").write_text(json.dumps(geometry, indent=2) + "\n")
    codes = parts["codes"][start * 560:end * 560]
    scales = parts["scales"][start * 80:end * 80]
    assert len(codes) == rows * 560 and len(scales) == rows * 80
    (dest / "codes.bin").write_bytes(codes)
    (dest / "scales.bin").write_bytes(scales)
    book = dest / "codebook.bin"
    if book.is_symlink():
        assert book.readlink() == pathlib.Path("../../parts/codebook.bin")
    elif book.exists():
        raise ValueError("tile codebook path is not the expected shared symlink")
    else:
        book.symlink_to("../../parts/codebook.bin")
    assert book.read_bytes() == parts["codebook"]
    source = {"module": MODULE, "expert": 0, "flattened_output_row_span": [start, end],
              "codes_absolute_offset": PARTS[0][2] + start * 560,
              "scales_absolute_offset": PARTS[1][2] + start * 80,
              "shared_codebook_absolute_offset": PARTS[2][2],
              "geometry_sha256": sha256((dest / "geometry.json").read_bytes()),
              "codes_sha256": sha256(codes), "scales_sha256": sha256(scales),
              "codebook_sha256": sha256(parts["codebook"])}
    (dest / "source.json").write_text(json.dumps(source, indent=2) + "\n")
    return dest


def oracle_for_tile(fixture, x, batch):
    rows = json.loads((fixture / "geometry.json").read_text())["rows"]
    decoded = expected(fixture)
    weights = [v[0] for v in struct.iter_unpack("<e", decoded)]
    assert len(weights) == rows * 2560
    values = []
    for token in range(batch):
        xv = x[token * 2560:(token + 1) * 2560]
        for row in range(rows):
            weights_at = row * 2560
            values.append(math.fsum(xv[col] * weights[weights_at + col] for col in range(2560)))
    return decoded, values, b"".join(struct.pack("<d", v) for v in values)


def max_rss(log):
    match = re.search(r"^\s*(\d+)\s+maximum resident set size\s*$", log, re.M)
    if not match:
        raise ValueError("/usr/bin/time did not report maximum resident set size")
    return int(match.group(1))


def native_decode(binary, fixture, oracle_bytes, mode, out):
    rows = json.loads((fixture / "geometry.json").read_text())["rows"]
    label = fixture.name + "-decode-" + mode
    stdout_path = out / (label + ".stdout.bin")
    stderr_path = out / (label + ".stderr.txt")
    time_path = out / (label + ".time.txt")
    run = subprocess.run(["/usr/bin/time", "-l", "-o", str(time_path),
                          str(binary), str(fixture), mode], capture_output=True)
    stdout_path.write_bytes(run.stdout)
    stderr_path.write_bytes(run.stderr)
    if run.returncode != 0:
        raise ValueError(f"{label}: native exit {run.returncode}: {run.stderr.decode(errors='replace')}")
    if len(run.stdout) != rows * 2560 * 2 or run.stdout != oracle_bytes:
        differences = sum(a != b for a, b in zip(run.stdout, oracle_bytes))
        raise ValueError(f"{label}: binary16 decoder mismatch, bytes={len(run.stdout)}, differing={differences}")
    explicit_metal = rows * 560 + 262144 + rows * 80 + rows * 2560 * 2
    assert explicit_metal <= 2 * 1024 * 1024
    return {"label": label, "mode": mode, "decoded_f16_values": rows * 2560,
            "differing_binary16_words": 0, "output_f16_sha256": sha256(run.stdout),
            "analytic_metal_buffer_bytes": explicit_metal if mode == "metal" else 0,
            "process_max_rss_bytes": max_rss(time_path.read_text())}


def native_run(binary, fixture, input_path, batch, mode, out, oracle, exact):
    rows = json.loads((fixture / "geometry.json").read_text())["rows"]
    label = fixture.name + "-b" + str(batch) + "-" + mode
    stdout_path = out / (label + ".stdout.bin")
    stderr_path = out / (label + ".stderr.txt")
    time_path = out / (label + ".time.txt")
    run = subprocess.run(["/usr/bin/time", "-l", "-o", str(time_path),
                          str(binary), str(fixture), str(input_path), str(batch), mode],
                         capture_output=True)
    stdout_path.write_bytes(run.stdout)
    stderr_path.write_bytes(run.stderr)
    if run.returncode != 0:
        raise ValueError(f"{label}: native exit {run.returncode}: {run.stderr.decode(errors='replace')}")
    if len(run.stdout) != rows * batch * 4:
        raise ValueError(f"{label}: wrong output length {len(run.stdout)}")
    actual = [v[0] for v in struct.iter_unpack("<f", run.stdout)]
    max_abs_error = 0.0
    for i, (want, got) in enumerate(zip(oracle, actual)):
        if not math.isfinite(got):
            raise ValueError(f"{label}: non-finite output at {i}")
        error = abs(want - got)
        max_abs_error = max(max_abs_error, error)
        if exact[i // rows]:
            if struct.pack("<f", got) != struct.pack("<f", want):
                raise ValueError(f"{label}: basis/zero mismatch at {i}: {got} vs {want}")
        elif error > ABS_TOL + REL_TOL * abs(want):
            raise ValueError(f"{label}: fixed budget exceeded at {i}: {got} vs {want}; error={error}")
    metadata = json.loads(run.stderr)
    expected_buffers = rows * 560 + rows * 80 + 262144 + batch * 2560 * 2 + batch * rows * 4
    if metadata["explicit_metal_buffer_bytes"] != (expected_buffers if mode == "metal" else 0):
        raise ValueError(f"{label}: unexpected explicit Metal allocation")
    if mode == "metal" and expected_buffers >= 2 * 1024 * 1024:
        raise ValueError(f"{label}: allocation exceeds 2 MiB proof ceiling")
    return {"label": label, "mode": mode, "values": len(actual),
            "max_abs_error": max_abs_error, "output_f32_sha256": sha256(run.stdout),
            "explicit_metal_buffer_bytes": metadata["explicit_metal_buffer_bytes"],
            "process_max_rss_bytes": max_rss(time_path.read_text())}, run.stdout


def assemble(rows):
    # rows is ten token-major tile outputs. This yields token-major full 640-row output.
    assert len(rows) == 10
    width = len(rows[0]) // 7
    assert all(len(tile) == 7 * width for tile in rows)
    return b"".join(rows[tile][token * width:(token + 1) * width]
                    for token in range(7) for tile in range(10))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("decoder_binary", type=pathlib.Path)
    parser.add_argument("projection_binary", type=pathlib.Path)
    parser.add_argument("--root", type=pathlib.Path, required=True)
    args = parser.parse_args()
    decoder_binary = args.decoder_binary.resolve()
    projection_binary = args.projection_binary.resolve()
    root = args.root.resolve()
    _, parts = verified_parts(root)
    raw_x, x, exact = vectors(2560, 8, 7)
    assert len(raw_x) == 7 * 2560 * 2 and exact == [True, True, True, True, True, False, False]
    input_path = root / "input-b7-f16.bin"
    input_path.write_bytes(raw_x)
    runs = root / "runs"
    runs.mkdir(exist_ok=True)
    primary_tiles = []
    extra_tiles = []
    outputs = {"cpu": [], "metal": []}
    oracle_tiles = []
    spans = [(n, n + 64, True) for n in range(0, 640, 64)]
    spans.append((639, 640, False))  # One-row overlapping tail; not new coverage.
    for start, end, primary in spans:
        fixture = make_tile(root, parts, start, end)
        decoded, oracle, oracle_bytes = oracle_for_tile(fixture, x, 7)
        (runs / (fixture.name + "-b7.oracle-f64.bin")).write_bytes(oracle_bytes)
        if primary:
            oracle_tiles.append(oracle_bytes)
        result = {"row_span": [start, end], "primary_unique_coverage": primary,
                  "fixture": fixture.name,
                  "decoded_f16_sha256": sha256(decoded),
                  "oracle_f64_sha256": sha256(oracle_bytes),
                  "decode_modes": [], "projection_modes": []}
        for mode in ("cpu", "metal"):
            result["decode_modes"].append(native_decode(decoder_binary, fixture, decoded, mode, runs))
        # Do not run a dot product until both native decoders match every F16 bit.
        for mode in ("cpu", "metal"):
            entry, data = native_run(projection_binary, fixture, input_path, 7, mode, runs, oracle, exact)
            result["projection_modes"].append(entry)
            if primary:
                outputs[mode].append(data)
        (primary_tiles if primary else extra_tiles).append(result)
    assert [x["row_span"] for x in primary_tiles] == [[n, n + 64] for n in range(0, 640, 64)]
    assert [x["row_span"] for x in extra_tiles] == [[639, 640]]
    assert b"".join((root / "fixtures" / t["fixture"] / "codes.bin").read_bytes()
                    for t in primary_tiles) == parts["codes"]
    assert b"".join((root / "fixtures" / t["fixture"] / "scales.bin").read_bytes()
                    for t in primary_tiles) == parts["scales"]
    assert (root / "fixtures" / extra_tiles[0]["fixture"] / "codes.bin").read_bytes() == parts["codes"][-560:]
    assert (root / "fixtures" / extra_tiles[0]["fixture"] / "scales.bin").read_bytes() == parts["scales"][-80:]
    assembled = {}
    oracle_all = assemble(oracle_tiles)
    (root / "full-expert-b7.oracle-f64.bin").write_bytes(oracle_all)
    for mode, pieces in outputs.items():
        all_bytes = assemble(pieces)
        assert len(all_bytes) == 7 * 640 * 4
        (root / ("full-expert-b7-" + mode + ".f32.bin")).write_bytes(all_bytes)
        assembled[mode] = sha256(all_bytes)
    script_dir = pathlib.Path(__file__).resolve().parent
    source_names = ("Decoder.swift", "main.swift", "Projection.swift", "projection/main.swift",
                    "test_proof.py", "test_projection.py", "fetch_full_gate.py", "test_full_gate.py")
    report = {
        "time_utc": datetime.now(timezone.utc).isoformat(),
        "status": "research_proof_local", "model": MODEL, "revision": REVISION,
        "module": MODULE, "expert": 0, "all_640_output_rows_covered": True,
        "tile_rows_max": 64, "primary_tiles": len(primary_tiles),
        "extra_overlapping_tail_row_span": [639, 640], "batch": 7,
        "output_values_per_mode": 7 * 640,
        "exact_binary16_decode_values_per_mode": 640 * 2560 + 2560,
        "contract": "binary16 decoded weights/input; Python whole-row fsum F64 oracle; native F32 output",
        "basis_zero_exact": True, "abs_tolerance": ABS_TOL, "rel_tolerance": REL_TOL,
        "input_f16_sha256": sha256(raw_x), "oracle_full_f64_sha256": sha256(oracle_all),
        "assembled_output_f32_sha256": assembled,
        "max_abs_error": {mode: max(t["projection_modes"][0 if mode == "cpu" else 1]["max_abs_error"]
                                     for t in primary_tiles + extra_tiles) for mode in outputs},
        "max_explicit_metal_buffer_bytes": max(t["projection_modes"][1]["explicit_metal_buffer_bytes"]
                                               for t in primary_tiles + extra_tiles),
        "max_analytic_decoder_metal_buffer_bytes": max(t["decode_modes"][1]["analytic_metal_buffer_bytes"]
                                                   for t in primary_tiles + extra_tiles),
        "max_observed_native_process_rss_bytes": max(r["process_max_rss_bytes"]
                                                     for t in primary_tiles + extra_tiles
                                                     for r in t["decode_modes"] + t["projection_modes"]),
        "source_hashes": {name: sha256((script_dir / name).read_bytes()) for name in source_names},
        "binary_sha256": {"decoder": sha256(decoder_binary.read_bytes()),
                          "projection": sha256(projection_binary.read_bytes())},
        "fetch_receipt_sha256": sha256((root / "fetch-receipt.json").read_bytes()),
        "python": sys.version, "platform": platform.platform(),
        "swift": subprocess.check_output(["xcrun", "swiftc", "--version"], text=True).strip(),
        "tested_default_checkpoint_kernel": False,
        "tested_f16_or_bf16_output_bit_parity": False,
        "tested_routing_prefill_decode_or_model": False,
        "tested_inference_quality_speed_or_production_memory": False,
        "source_file_lfs_sha256_verified": False,
        "primary_tiles_detail": primary_tiles,
        "extra_overlapping_tail_detail": extra_tiles,
    }
    (root / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({key: report[key] for key in ("status", "primary_tiles", "batch",
                      "output_values_per_mode", "exact_binary16_decode_values_per_mode",
                      "max_abs_error", "max_explicit_metal_buffer_bytes",
                      "max_observed_native_process_rss_bytes")}))


if __name__ == "__main__":
    main()
