#!/usr/bin/env python3
"""Inspect immutable checkpoint metadata without loading weights or remote code.

Range responses are bounded and validated before any payload is accepted. The
inventory is feasibility evidence, never a model-support or quality verdict.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import struct
import urllib.request

DTYPES = {"U8": 1, "I8": 1, "BOOL": 1, "U16": 2, "F16": 2, "BF16": 2,
          "U32": 4, "I32": 4, "F32": 4, "U64": 8, "I64": 8, "F64": 8}
LIMIT = (1 << 63) - 1
MAX_HEADER = 16_000_000


def relative_path(value):
    if not isinstance(value, str) or not value or "\\" in value or "\x00" in value:
        raise ValueError("invalid repository path")
    p = PurePosixPath(value)
    if p.is_absolute() or any(x in ("", ".", "..") for x in value.split("/")):
        raise ValueError("repository path escapes artifact")
    return value


def product(values):
    out = 1
    for value in values:
        if type(value) is not int or value < 0 or value > LIMIT:
            raise ValueError("invalid tensor dimension")
        out *= value
        if out > LIMIT:
            raise ValueError("tensor size overflow")
    return out


def validate_header(header, payload_bytes):
    """Reference safetensors coverage, including zero-length tensor ordering."""
    if type(header) is not dict or type(payload_bytes) is not int or not 0 <= payload_bytes <= LIMIT:
        raise ValueError("invalid header or payload size")
    ranges = []
    for name, tensor in header.items():
        if name == "__metadata__":
            continue
        if not isinstance(tensor, dict) or tensor.get("dtype") not in DTYPES:
            raise ValueError(f"unsupported tensor {name}")
        shape, offsets = tensor.get("shape"), tensor.get("data_offsets")
        if (not isinstance(shape, list) or not isinstance(offsets, list) or len(offsets) != 2
                or any(type(x) is not int for x in offsets)
                or not 0 <= offsets[0] <= offsets[1] <= payload_bytes):
            raise ValueError(f"invalid tensor range {name}")
        if product([*shape, DTYPES[tensor["dtype"]]]) != offsets[1] - offsets[0]:
            raise ValueError(f"shape/byte mismatch {name}")
        ranges.append((*offsets, name))
    cursor = 0
    for start, end, name in sorted(ranges):
        if start != cursor:
            raise ValueError(f"hole or overlap at {name}")
        cursor = end
    if cursor != payload_bytes:
        raise ValueError("uncovered shard data")


class Remote:
    def __init__(self, repo, revision, maximum_bytes=64_000_000):
        if not re.fullmatch(r"[\w.-]+/[\w.-]+", repo) or not re.fullmatch(r"[0-9a-f]{40}", revision):
            raise ValueError("an exact repository and immutable revision are required")
        self.base = f"https://huggingface.co/{repo}/resolve/{revision}/"
        self.maximum_bytes = maximum_bytes
        self.received_bytes = 0

    def get(self, path, *, start=None, count=MAX_HEADER):
        relative_path(path)
        if type(count) is not int or not 0 < count <= MAX_HEADER:
            raise ValueError("invalid bounded read")
        if start is not None and (type(start) is not int or start < 0 or start > LIMIT - count):
            raise ValueError("invalid range offset")
        if self.received_bytes + count > self.maximum_bytes:
            raise ValueError("metadata network budget exhausted")
        headers = {"Accept-Encoding": "identity"}
        if start is not None:
            headers["Range"] = f"bytes={start}-{start + count - 1}"
        # Range-specific query prevents a CDN cache returning a previous range.
        url = self.base + urllib.parse.quote(path, safe="/")
        if start is not None:
            url += f"?slotstream_range={start}-{count}"
        with urllib.request.urlopen(urllib.request.Request(url, headers=headers), timeout=60) as response:
            total = None
            if response.headers.get("Content-Encoding", "identity").lower() != "identity":
                raise ValueError("encoded response cannot represent original tensor offsets")
            if start is None and response.status != 200:
                raise ValueError("metadata response was not complete")
            if start is not None:
                match = re.fullmatch(r"bytes (\d+)-(\d+)/(\d+)", response.headers.get("Content-Range", ""))
                if response.status != 206 or not match or tuple(map(int, match.groups()[:2])) != (start, start + count - 1):
                    raise ValueError("server did not honor exact bounded range")
                total = int(match[3])
                if total < start + count or total > LIMIT:
                    raise ValueError("invalid response file size")
            data = response.read(count + 1)
            self.received_bytes += len(data)
        if len(data) > count or (start is not None and len(data) != count):
            raise ValueError("response length does not match bounded request")
        return data, total


def unique_json(data):
    def pairs(items):
        out = {}
        for key, value in items:
            if key in out:
                raise ValueError(f"duplicate JSON key: {key}")
            out[key] = value
        return out
    return json.loads(data, object_pairs_hook=pairs)


def summarize(config, headers):
    tensors = {}
    for shard, header in headers.items():
        for name, tensor in header.items():
            if name == "__metadata__":
                continue
            if name in tensors:
                raise ValueError(f"duplicate tensor: {name}")
            tensors[name] = dict(tensor, shard=shard)
    def size(t):
        return t["data_offsets"][1] - t["data_offsets"][0]
    families = Counter()
    records = Counter()
    codebooks = 0
    projections = []
    for name, t in tensors.items():
        family = ("experts" if ".switch_mlp." in name else
                  "ngram" if "ngram_embedding" in name else
                  "vision" if name.startswith(("vision_tower.", "model.visual.")) else "resident")
        families[family] += size(t)
        match = re.search(r"model.layers.(\d+).mlp.switch_mlp.", name)
        if match:
            if name.endswith(".codebook"):
                codebooks += size(t)
            else:
                if len(t["shape"]) != 3 or t["shape"][0] != 512 or size(t) % 512:
                    raise ValueError(f"unsupported expert geometry: {name}")
                records[int(match[1])] += size(t) // 512
    for name, geometry in config.get("vq_modules", {}).items():
        row = {"name": name, "geometry": geometry, "tensors": {}}
        for suffix in ("codes", "codebook", "vq_scales"):
            key = name + "." + suffix
            if key not in tensors:
                raise ValueError(f"missing VQ tensor: {key}")
            row["tensors"][suffix] = tensors[key]
        projections.append(row)
    quant = config.get("quantization", {})
    overrides = Counter((v.get("bits"), v.get("group_size")) for v in quant.values() if isinstance(v, dict))
    return {"families_bytes": dict(families), "expert_shared_codebook_bytes": codebooks,
            "expert_record_bytes_by_layer": {str(k): v for k, v in sorted(records.items())},
            "expert_record_classes": {str(k): v for k, v in sorted(Counter(records.values()).items())},
            "affine_default": {k: quant.get(k) for k in ("bits", "group_size", "mode")},
            "affine_overrides": [{"bits": b, "group_size": g, "modules": n} for (b, g), n in sorted(overrides.items())],
            "vq_projections": sorted(projections, key=lambda x: x["name"]),
            "vq_ngram": config.get("vq_ple"), "tensor_count": len(tensors)}


def inspect(repo, revision, out):
    remote = Remote(repo, revision)
    out.mkdir(parents=True, exist_ok=False)
    receipts = {}
    for name in ("config.json", "model.safetensors.index.json", "model.py", "README.md"):
        data, _ = remote.get(name)
        (out / name).write_bytes(data)
        receipts[name] = {"sha256": hashlib.sha256(data).hexdigest(), "bytes": len(data)}
    index = unique_json((out / "model.safetensors.index.json").read_bytes())
    config = unique_json((out / "config.json").read_bytes())
    headers = {}
    for shard in sorted(set(index["weight_map"].values())):
        prefix, total = remote.get(shard, start=0, count=8)
        length = struct.unpack("<Q", prefix)[0]
        if not 0 < length <= MAX_HEADER or length + 8 > total:
            raise ValueError("invalid safetensors header length")
        data, observed_total = remote.get(shard, start=8, count=length)
        if total != observed_total:
            raise ValueError("shard size changed")
        header = unique_json(data)
        validate_header(header, total - 8 - length)
        headers[shard] = header
        receipts[shard] = {"header_sha256": hashlib.sha256(data).hexdigest(), "header_bytes": length,
                           "file_bytes": total}
    if {name: shard for shard, header in headers.items() for name in header if name != "__metadata__"} != index["weight_map"]:
        raise ValueError("tensor index disagrees with actual headers")
    (out / "headers.json").write_text(json.dumps(headers, sort_keys=True) + "\n")
    result = {"schema": 1, "repo": repo, "revision": revision, "network_bytes": remote.received_bytes,
              "files": receipts, "qualification": {"runtime": "unproven", "quality": "unproven", "memory": "unproven", "speed": "unproven"},
              **summarize(config, headers)}
    (out / "inventory.json").write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", required=True)
    parser.add_argument("--revision", required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    result = inspect(args.repo, args.revision, args.out)
    print(json.dumps({k: v for k, v in result.items() if k not in ("vq_projections", "vq_ngram", "files")}, sort_keys=True))
