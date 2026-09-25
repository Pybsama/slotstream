"""Fetch bounded safetensors headers at the pinned revision, never payloads."""
import concurrent.futures
import hashlib
import json
import pathlib
import struct
import sys
import urllib.parse
import urllib.request

if len(sys.argv) != 2: raise SystemExit('usage: fetch_headers.py <data-directory>')
ROOT = pathlib.Path(sys.argv[1]).resolve()
RECEIPT = json.loads((ROOT / "candidate-receipt.json").read_text())
OUT = ROOT / "headers"
OUT.mkdir(exist_ok=True)


def byte_range(name, start, count, total):
    # Separate cache keys for distinct byte ranges; every response is checked.
    url = ("https://huggingface.co/" + RECEIPT["model"] + "/resolve/"
           + RECEIPT["revision"] + "/" + urllib.parse.quote(name)
           + "?header_range=" + str(start) + "_" + str(count))
    request = urllib.request.Request(url, headers={
        "Range": f"bytes={start}-{start + count - 1}",
        "Accept-Encoding": "identity", "User-Agent": "Slotstream-format-audit/1"})
    with urllib.request.urlopen(request, timeout=45) as response:
        expected = f"bytes {start}-{start + count - 1}/{total}"
        if response.status != 206 or response.headers.get("Content-Range") != expected:
            raise ValueError(f"{name}: refusing non-exact range response")
        data = response.read(count + 1)
        if len(data) != count:
            raise ValueError(f"{name}: unexpected response length")
        return data


def fetch(item):
    name, size = item["name"], item["bytes"]
    saved = OUT / (name + ".json")
    if saved.exists():
        cached = json.loads(saved.read_text())
        if cached['revision'] != RECEIPT['revision'] or cached['file_bytes'] != size:
            raise ValueError('cached header identity mismatch')
        return cached
    prefix = byte_range(name, 0, 8, size)
    length = struct.unpack("<Q", prefix)[0]
    if not 2 <= length <= min(2 << 20, size - 8):
        raise ValueError(f"{name}: header length exceeds bound")
    header = byte_range(name, 8, length, size)
    tensors = json.loads(header)
    result = {"file": name, "file_bytes": size, "revision": RECEIPT["revision"],
              "header_bytes": length, "header_sha256": hashlib.sha256(header).hexdigest(),
              "bytes_downloaded": length + 8, "payload_downloaded": False,
              "tensors": tensors}
    saved.write_text(json.dumps(result, indent=2) + "\n")
    return result


if __name__ == "__main__":
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
        results = list(pool.map(fetch, RECEIPT["listed_weights"]))
    summary = {"revision": RECEIPT["revision"], "files": len(results),
               "header_bytes_downloaded": sum(r["bytes_downloaded"] for r in results),
               "tensor_count": sum(len(r["tensors"]) - ("__metadata__" in r["tensors"]) for r in results),
               "payload_downloaded": False}
    (ROOT / "headers-receipt.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))
