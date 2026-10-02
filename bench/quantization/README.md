# Candidate screening

`screen-v1.json` freezes the bounded feasibility protocol. It is not a release
qualification protocol. Run only one model or native kernel process at a time,
with the real memory preflight required by `AGENTS.md`. Do not run a build,
download or storage study during timings.

The baseline tool saves its executable and metallib hashes, model metadata,
exact commands, raw outputs, sampled footprint and generation conditions. Its
host contention observations are endpoint snapshots, not continuous isolation.
The first implementation run predates removal of ambient developer overrides;
its original receipts remain unchanged and must not be promoted into a release
benchmark. The baseline's fixed `--memory-gb` is a compatibility control, not
the adaptive-ceiling Auto policy.

The inventory requires an exact Hugging Face revision and validates every
safetensors header and range response. It does not verify full weight payloads.
The fixture extractor checks header/config identity and fetches representative
expert/PLE rows for a separate scalar decoding oracle. These rows establish
storage decoding, not model-logit or fused-dot parity.

The native kernel screen includes both expert projection shapes, ten routed
experts, and one, four and thirty-two input rows. Affine arms share a synthetic
dense source and rotate order. VQ arms use spread synthetic codebook accesses
and materialize bounded decoded weights before a gathered matrix multiply.
Those VQ arms are cost probes, not equivalent quantizations of the affine
source. They do not establish the performance of an optimized fused VQ kernel.

## Full-vocabulary pilot scorer

Generate each artifact's logits sequentially using its separately verified
runtime, then run:

```sh
python3 Tools/quantization_quality.py \
  --reference /path/to/vq-reference/manifest.json \
  --baseline /path/to/current/manifest.json \
  --candidate /path/to/candidate/manifest.json \
  --out /path/to/new-result.json
```

Each directory contains a manifest and raw row-major little-endian float32
logits. A row is the next-token distribution **after**
`tokens[:positions[row] + 1]`. All vocabulary entries must be present; top-k
files cannot be relabeled. The format is:

```json
{
  "schema": 1,
  "vocabulary": 248320,
  "format": "f32le",
  "scope": "pilot",
  "artifact": {
    "checkpoint": "Qwen/Qwen3.8-Flash-Next",
    "checkpoint_revision": "EXACT_ORIGINAL_40_HEX_REVISION",
    "tokenizer_sha256": "64_HEX_DIGEST",
    "template_sha256": "64_HEX_DIGEST",
    "pack_sha256": "64_HEX_VERIFIED_PACK_MANIFEST_DIGEST",
    "runtime_sha256": "64_HEX_RUNTIME_IDENTITY_DIGEST",
    "arithmetic": "exact pinned arithmetic mode and preprocessing"
  },
  "cases": [{
    "id": "tool-pilot-a",
    "family": "tools",
    "tokens": [9707, 11],
    "positions": [1],
    "file": "tool-pilot-a.f32",
    "sha256": "64_HEX_FILE_DIGEST"
  }]
}
```

Replace placeholders with verified identities. Equal identity fields are a
consistency check, not proof of their truth. Producers must preserve their
source, pack provenance, prompts, arithmetic settings and raw generation
receipts. The scorer checks raw sizes, hashes, token bounds, exact contexts and
concurrent changes, uses stable full-vocabulary KL(reference || other), and
preserves each evaluated position. Its storage ceiling is the frozen protocol's
reference-logit budget, enforced independently for each artifact. It reads one
logit row at a time and has no model dependency.

Matching top predictions do not establish equal distributions. KL and top-1
agreement do not establish completed-task quality. No synthetic scorer fixture
is model-quality evidence. The selected reference must be the pinned VQ
reference required by the project decision, and remains a quantized proxy.

The scorer deliberately emits no pass/fail quality decision. Pilot estimates
must precede frozen held-out examples, sample counts, paired confidence methods,
noninferiority and latency margins. Complete app tasks, tool traces, exact
native reference parity, memory/governor checks and actual hardware qualification
remain independent gates in the canonical plan.
## Fused expert pilot

`fused-v1.json` freezes the first fused projection pilot. `fused-v2.json`
keeps its arithmetic and shapes while preparing checked CPU routing before
timing, removing a redundant GPU bounds-reduction synchronization. The CLI
currently runs the second pilot; the first receipts stay unchanged. Extract only the
reviewed Metal strings from the exact pinned runtime with
`Tools/vq_kernel_sources.py`. The tool parses string expressions; it never
imports or executes upstream Python. The checked-in source and Apache license
are digest-checked by its test.

After the usual single-process/headroom preflight, generate binding fixtures:

```sh
.venv/bin/python Tools/vq_fused_reference.py --runtime <pinned-model.py> \
  --fixtures <row-fixtures> --out <new-fused-fixtures>
.build/release/slotstream quantization-check --kernels \
  --fused-fixture-directory <new-fused-fixtures>
.build/release/slotstream quantization-bench \
  --fused-fixture-directory <new-fused-fixtures>
```

Repeat `--fixtures` for the inspected row collections to cover every family.
The Python oracle and native wrapper use the same reviewed Metal source.
Bit equality checks input conversion, packing, routing, dispatch and binding;
it does not independently establish the kernel arithmetic or full-model
parity. PLE, full checkpoints, mixed caches and quality are separate gates.

The pinned D8 profile switches reductions at the routed-pair boundary. A draft
verification batch can therefore use different arithmetic from single-token
decode. Matching this reference binding does not prove speculative row parity;
the full draft/state gates must qualify that interaction independently.
