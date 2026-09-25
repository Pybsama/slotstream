# VQ checkpoint format and native decoding proof

This standalone tool investigates [issue #7](https://github.com/carloslfu/slotstream/issues/7).
It does **not** add model support to Slotstream or modify the existing engine.
It checks the exact file layout, then compares Swift CPU and native Metal
row decoding to a separate Python binary16 oracle. It does not validate
matrix multiplication, inference, quality, throughput or end-to-end memory.

Target: [`TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw` at
`8684640a3956b01c47f5d47f9b999e2ab8b985f1`](https://huggingface.co/TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw/tree/8684640a3956b01c47f5d47f9b999e2ab8b985f1).
The format has mixed U8 and packed U32 expert codes, F16 codebooks/scales,
and VQ PLE rows. Packed codes use row-local, LSB-first blocks of 32 indices.
The reference is the pinned checkpoint's `model.py`, specifically
`_decode_chunk`, `VQSwitchLinear`, and `VQPLEEmbedding`.
Model code is downloaded only as reference text and is never imported or run.

## Synthetic checks (no downloads)

Requires Apple Silicon macOS with Command Line Tools and Python 3.9+.
From the repository root:

```sh
xcrun swiftc -O Tools/VQFormatProof/Decoder.swift Tools/VQFormatProof/main.swift -o /tmp/slotstream-vq-proof
python3 Tools/VQFormatProof/test_proof.py /tmp/slotstream-vq-proof
```

Use `--mode cpu` if Metal is unavailable; do not report this as a GPU result.
Both native paths compare exact binary16/BF16 output bits to the independent
oracle. Tests cover mixed geometries, cross-word extraction, padded tails,
signed zero, subnormals, rounding, one-row and maximum bounded tiles, and
malformed inputs. Python verification must run without `-O`.

## Real checkpoint rows and header audit

The following explicitly performs small public downloads into a directory
you choose. It fetches metadata, all139safetensors headers, and350,864bytes
of real row/codebook payload. No complete weight file is downloaded.
HTTP range responses must have the exact206status, Content-Range and length.

```sh
python3 Tools/VQFormatProof/fetch_metadata.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/fetch_headers.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/audit.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/fetch_rows.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/test_proof.py /tmp/slotstream-vq-proof --real /tmp/slotstream-vq-data/real-fixtures
```

The six real fixtures sample first/middle/last experts or PLE shard rows;
each has24rows. Receipts retain revision, byte ranges and local hashes.
Those partial hashes establish repeatability, not verification of a complete
weight file against its LFS hash. Metadata/header audit covers all tensors,
but numerical evidence covers only the sampled rows and synthetic cases.
The downloaded model files retain their upstream LICENSE; they are not
redistributed as part of this source tool.

Proof bounds are64rows, input width4096, and512KiB decoded output per call.
These keep the experiment small; they are not production allocator defaults.
The GPU uses shared codebooks, performs one F16 product rounding, and rounds
PLE output to BF16 afterwards. This does not yet implement SSD expert
scheduling, the model's GEMM reductions, cache identity or planner policy.

Full support still requires maintainer design alignment, format-aware
streaming and resident quantization, reference model parity, existing4-bit
regressions and real-machine acceptance. Images and the optional MTP sidecar
have separate qualification gates.
