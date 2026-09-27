# VQ checkpoint format and native decoding proof

This standalone tool investigates [issue #7](https://github.com/carloslfu/slotstream/issues/7).
It does **not** add model support to Slotstream or modify the existing engine.
It checks the exact file layout, then compares Swift CPU and native Metal
row decoding to a separate Python binary16 oracle. A separate sampled
projection arithmetic probe is described below. Full expert/reference-kernel
matrix multiplication, inference, quality, throughput and end-to-end memory
remain unqualified.

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
you choose. It fetches metadata, all 139 safetensors headers, and 350,864 bytes
of real row/codebook payload. No complete weight file is downloaded.
HTTP range responses must have the exact 206 status, Content-Range and length.

```sh
python3 Tools/VQFormatProof/fetch_metadata.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/fetch_headers.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/audit.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/fetch_rows.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/test_audit.py /tmp/slotstream-vq-data
python3 Tools/VQFormatProof/test_provenance.py /tmp/slotstream-vq-data/real-fixtures
python3 Tools/VQFormatProof/test_proof.py /tmp/slotstream-vq-proof --real /tmp/slotstream-vq-data/real-fixtures
```

The six real fixtures sample first/middle/last experts or PLE shard rows;
each has 24 rows. Receipts retain revision, byte ranges and local hashes.
The harness requires all six, verifies their component hashes and pinned
identities before computing an oracle, and includes those receipts in its
result. The header cache retains original raw JSON bytes and verifies their
digest and parsed contents; the audit also checks config/index hashes.
Those partial hashes establish repeatability, not verification of a complete
weight file against its LFS hash. Metadata/header audit covers all tensors,
but numerical evidence covers only the sampled rows and synthetic cases.
The downloaded model files retain their upstream LICENSE; they are not
redistributed as part of this source tool.

Proof bounds are 64 rows, input width 4096, and 512 KiB decoded output per call.
These keep the experiment small; they are not production allocator defaults.
The GPU uses shared codebooks, performs one F16 product rounding, and rounds
PLE output to BF16 afterwards. This does not yet implement SSD expert
scheduling, the model's GEMM reductions, cache identity or planner policy.

Full support still requires maintainer design alignment, format-aware
streaming and resident quantization, reference model parity, existing 4-bit
regressions and real-machine acceptance. Images and the optional MTP sidecar
have separate qualification gates.

## Separate sampled projection arithmetic probe

This additional standalone probe multiplies input vectors by the five expert
fixtures' sampled rows. The samples span different experts; these rows are
not a whole expert matrix, and this does not perform routing or a MoE layer.
PLE is an embedding and is excluded from multiplication. Existing decoding
checks and their entry point are unchanged.

```sh
xcrun swiftc -O Tools/VQFormatProof/Decoder.swift \
  Tools/VQFormatProof/Projection.swift Tools/VQFormatProof/projection/main.swift \
  -o /tmp/slotstream-vq-projection
python3 Tools/VQFormatProof/test_projection.py /tmp/slotstream-vq-projection \
  --real-root /tmp/slotstream-vq-data --out /tmp/slotstream-vq-projection-results
```

Use the metadata/header/fixture commands above first, or omit `--real-root`
to run synthetic cases only. The harness verifies the existing pinned
metadata, headers, fixture provenance and model.py text hash before real
checks. It never imports or executes the downloaded model code. `--mode cpu`
is available without Metal and cannot establish a GPU result.

The native CLI accepts `fixture input-f16.bin batch cpu|metal`. Inputs are
little-endian F16 `[batch,input]`; outputs are little-endian F32 `[batch,rows]`.
Rows and input width retain the decoder's bounds; batch is limited to 128.
BF16/PLE weights, invalid batch, wrong input length, non-finite inputs and
overflowing decoded F16 products are rejected before Metal allocation.

The CPU accumulates in Double. Metal reads compressed codes, codebooks and
scales directly without making a decoded weight matrix, rounds each decoded
product to F16, and accumulates F32 FMA in increasing input-column order.
This is a deliberately simple arithmetic probe, without a performance claim.
A quiet-NaN output sentinel detects unwritten GPU outputs.

The separate Python oracle uses whole-row integer decoding and `math.fsum`
over exactly rounded F16 inputs/weights. Basis and zero vectors require exact
F32 outputs. Dense vectors use the fixed, predeclared budget
`abs(error) <= 1e-4 + 2e-5 * abs(reference)`; this is tolerance-based arithmetic
evidence, not bitwise parity. The cases use single-vector and batched shapes,
packed tails, differing token results and maximum bounded sizes. Rejection
checks run in both native modes. Raw outputs and machine-readable results
are saved under `--out`.

`explicit_metal_buffer_bytes` reports the sum of the five requested MTLBuffer
lengths (codes, codebook, scales, input and output). It excludes host arrays,
driver/compiler allocations, internal constant storage and process peak
memory. It is not a production memory cap or an admission-policy measurement.

A pass does not qualify the checkpoint reference's fused, simdgroup or
grouped-prefill reductions, BF16 dispatch, full expert projection, decode/
prefill equivalence, model inference or throughput. Those remain separate
gates before any engine integration or model-support claim.
