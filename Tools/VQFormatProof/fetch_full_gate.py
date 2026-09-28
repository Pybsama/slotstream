"""Fetch exactly one expert's packed14 gate payload from a pinned checkpoint.

The three requested ranges total 671,744 bytes. No model code is imported.
"""

import argparse
import hashlib
import json
import os
import pathlib
import tempfile
import urllib.parse
import urllib.request
from datetime import datetime, timezone

if not __debug__:
    raise RuntimeError("Full-gate proof requires Python assertions; do not use -O")

from audit import audit


MODEL = "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw"
REVISION = "8684640a3956b01c47f5d47f9b999e2ab8b985f1"
FILE = "model-00012.safetensors"
MODULE = "model.layers.2.mlp.switch_mlp.gate_proj"
FILE_BYTES = 4_216_376_100
HEADER_BYTES = 45_540
HEADER_SHA256 = "bfd18ce5181df0df90b3bc44551768e9ea0720111b5cc4b8029fdb5b9a37d463"
# name, tensor suffix, absolute offset, length, dtype, complete tensor shape
PARTS = (
    ("codes", "codes", 286_271_020, 358_400, "U32", [512, 640, 140]),
    ("scales", "vq_scales", 1_689_201_348, 51_200, "F16", [512, 640, 40]),
    ("codebook", "codebook", 994_538_148, 262_144, "F16", [16384, 8]),
)


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def source_check(root):
    """Verify the saved raw header and metadata before any network request."""
    summary = audit(root)  # Includes all 139 raw-header hashes and config/index checks.
    receipt_bytes = (root / "candidate-receipt.json").read_bytes()
    receipt = json.loads(receipt_bytes)
    assert receipt["model"] == MODEL and receipt["revision"] == REVISION
    listed = next(x for x in receipt["listed_weights"] if x["name"] == FILE)
    assert listed["bytes"] == FILE_BYTES
    header_path = root / "headers" / (FILE + ".json")
    header_bytes = header_path.read_bytes()
    header = json.loads(header_bytes)
    raw = (root / "headers" / (FILE + ".header.bin")).read_bytes()
    assert (len(raw), sha256(raw)) == (HEADER_BYTES, HEADER_SHA256)
    assert header["header_bytes"] == HEADER_BYTES and header["header_sha256"] == HEADER_SHA256
    assert header["revision"] == REVISION and header["file_bytes"] == FILE_BYTES
    assert json.loads(raw) == header["tensors"]
    index_bytes = (root / "candidate/model.safetensors.index.json").read_bytes()
    index = json.loads(index_bytes)["weight_map"]
    config_bytes = (root / "candidate/config.json").read_bytes()
    geometry = json.loads(config_bytes)["vq_modules"][MODULE]
    assert geometry == {"dim": 8, "k": 16384, "group": 64, "in": 2560,
                        "out": 640, "experts": 512, "pack_bits": 14}
    for _, suffix, offset, count, dtype, shape in PARTS:
        key = MODULE + "." + suffix
        assert index[key] == FILE
        tensor = header["tensors"][key]
        assert tensor["dtype"] == dtype and tensor["shape"] == shape
        assert offset == 8 + HEADER_BYTES + tensor["data_offsets"][0]
        assert offset + count <= 8 + HEADER_BYTES + tensor["data_offsets"][1]
        assert offset + count <= FILE_BYTES
    return {
        "model": MODEL, "revision": REVISION, "file": FILE,
        "file_bytes": FILE_BYTES, "source_lfs_sha256_unverified": listed["lfs"]["sha256"],
        "raw_header_bytes": len(raw), "raw_header_sha256": sha256(raw),
        "header_json_sha256": sha256(header_bytes),
        "candidate_receipt_sha256": sha256(receipt_bytes),
        "config_sha256": sha256(config_bytes), "index_sha256": sha256(index_bytes),
        "audit": {k: summary[k] for k in ("header_files", "all_tensors", "expert_modules", "ple_shards")},
    }


def fetch(name, offset, count):
    url = ("https://huggingface.co/" + MODEL + "/resolve/" + REVISION + "/"
           + urllib.parse.quote(FILE) + "?header_range=" + str(offset) + "_" + str(count))
    request = urllib.request.Request(url, headers={
        "Range": f"bytes={offset}-{offset + count - 1}",
        "Accept-Encoding": "identity", "User-Agent": "Slotstream-VQ-fullgate-proof/1",
    })
    with urllib.request.urlopen(request, timeout=60) as response:
        wanted = f"bytes {offset}-{offset + count - 1}/{FILE_BYTES}"
        received = response.headers.get("Content-Range")
        encoded = response.headers.get("Content-Encoding")
        length = response.headers.get("Content-Length")
        if response.status != 206 or received != wanted or encoded not in (None, "identity"):
            raise ValueError(f"{name}: non-exact HTTP range response: {response.status} {received}")
        if length is not None and length != str(count):
            raise ValueError(f"{name}: wrong Content-Length {length}")
        data = response.read(count + 1)
        if len(data) != count:
            raise ValueError(f"{name}: wrong body length {len(data)}")
        selected = {key: response.headers.get(key) for key in
                    ("Content-Range", "Content-Length", "Content-Encoding", "ETag", "Date")}
        return data, {"status": response.status, "requested_url": url,
                      "final_host": urllib.parse.urlsplit(response.geturl()).hostname,
                      "headers": selected, "received_body_bytes": len(data)}


def atomic_bytes(path, data):
    with tempfile.NamedTemporaryFile(dir=path.parent, prefix=".range-", delete=False) as handle:
        temporary = pathlib.Path(handle.name)
        try:
            handle.write(data)
            handle.flush()
            os.fsync(handle.fileno())
        except BaseException:
            temporary.unlink(missing_ok=True)
            raise
    os.replace(temporary, path)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--source-root", type=pathlib.Path, required=True)
    parser.add_argument("--out", type=pathlib.Path, required=True)
    parser.add_argument("--check-source", action="store_true")
    args = parser.parse_args()
    root = args.source_root.resolve()
    source = source_check(root)
    if args.check_source:
        print(json.dumps({"source_verified": True, **source}, indent=2))
        return
    out = args.out.resolve()
    parts = out / "parts"
    parts.mkdir(parents=True, exist_ok=True)
    records = []
    for name, suffix, offset, count, dtype, shape in PARTS:
        path = parts / (name + ".bin")
        receipt_path = parts / (name + ".receipt.json")
        if path.exists() or receipt_path.exists():
            if not (path.exists() and receipt_path.exists()):
                raise ValueError(f"{name}: partial cached state; refusing overwrite")
            record = json.loads(receipt_path.read_text())
            cached = path.read_bytes()
            expected_range = f"bytes {offset}-{offset + count - 1}/{FILE_BYTES}"
            response = record["response"]
            if (len(cached) != count or sha256(cached) != record["sha256"] or
                record["offset"] != offset or record["count"] != count or
                record["revision"] != REVISION or record["tensor"] != MODULE + "." + suffix or
                record["file"] != FILE or record["dtype"] != dtype or record["full_shape"] != shape or
                response["status"] != 206 or response["headers"]["Content-Range"] != expected_range or
                response["received_body_bytes"] != count):
                raise ValueError(f"{name}: cached range identity mismatch")
        else:
            data, response = fetch(name, offset, count)
            record = {"tensor": MODULE + "." + suffix, "dtype": dtype, "full_shape": shape,
                      "expert": 0, "row_span": [0, 640] if name != "codebook" else None,
                      "revision": REVISION, "file": FILE, "offset": offset,
                      "count": count, "sha256": sha256(data), "response": response}
            atomic_bytes(path, data)
            receipt_path.write_text(json.dumps(record, indent=2) + "\n")
        records.append(record)
    result = {"validated_at_utc": datetime.now(timezone.utc).isoformat(), **source,
              "module": MODULE, "expert": 0, "all_output_rows": 640,
              "total_payload_bytes": sum(item["count"] for item in records),
              "range_count": len(records), "ranges": records,
              "fetch_script_sha256": sha256(pathlib.Path(__file__).read_bytes()),
              "full_file_lfs_hash_verified": False, "full_checkpoint_downloaded": False}
    assert result["total_payload_bytes"] == 671744 and result["range_count"] == 3
    (out / "fetch-receipt.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"range_count": 3, "payload_bytes": 671744,
                      "sha256": {x["tensor"].split(".")[-1]: x["sha256"] for x in records}}))


if __name__ == "__main__":
    main()
