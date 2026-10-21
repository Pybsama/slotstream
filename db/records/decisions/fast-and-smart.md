---
type: decision
id: 01m5fjxv27w5ch7he3qj0qw3jb
created: 2026-10-21T15:57:53.095657+00:00
updated: 2026-10-21T16:58:31.842514+00:00
summary: Fast and Smart integration, preserved choices, native DFlash, bounded streaming, and practical qualification limits.
decided_on: 2026-10-21
reversible_if: Complete native workflow and hardware evidence supports changing the maintained models or defaults.
title: Fast and Smart
status: standing
---
# Fast and Smart

Carlos authorized integrating both roles into the native Slotstream app and
engine on October 21, 2026, with Fast as the new-install default, practical
end-to-end tests on the owned 48 GB Mac, and planning for the 16–64 GB range.
There is no task router. Preserve existing saved choices and independent APIs.

## Maintained choices

Fast is `mlx-community/Qwen3.6-35B-A3B-4bit` at
`38740b847e4cb78f352aba30aa41c76e08e6eb46`, with Inco DFlash 2 at
`51ef7b6923ad6c14cb1bb41c37a9041446496ab6`. Smart remains the existing pinned
Qwen3.8-Flash-Next checkpoint and its established memory-aware MTP policy.
The `fast` and `smart` aliases select these deployments. The native app exposes
both beside the composer and in settings. Existing CLI commands retain their
previous Smart default. Explicit saved IDs remain explicit.

Both use the native Swift/MLX engine and shared bounded expert streaming.
Fast adds its own dense gated attention, regular residual blocks, quantized
router and smaller expert geometry. Smart's numerical and public interfaces
remain independently usable. Prefix state distinguishes layouts with and
without a sparse attention indexer. Switching unloads the old model and retains
conversation data, attachment permissions, memory and review boundaries.

## Operating policy

Fast uses the existing 33 GB startup ceiling, capped by hardware and real available memory. Its expert slots stop at the actual model size, allowing fully resident inference when there is room and SSD streaming otherwise. It admits
32,768 context tokens and prefill passes up to 512 tokens. These are initial
conservative operating limits, not measurements of a speed optimum. The
planner retains Smart's conservative fixed and context allowances, covering
the smaller target plus the draft network and bounded draft context. Its expert
pool uses the actual 40-layer, 256-expert geometry and 1,769,472-byte records.
Do not reuse Smart's speed curve for this different architecture.

DFlash keeps at most 2,047 prior feature positions and proposes within an
eight-row block. Target verification owns every emitted token. Rejected state
rolls back through the existing checked recurrent/KV path. The request samples
plain decoding cost, then reduces draft depth or stops drafting if its measured
cost per emitted token is worse. Short requests can still pay calibration cost.
The development `SLOTSTREAM_DFLASH=0` control exists for comparisons, not as a
product requirement or a remedy for unreliable scheduling.

No GPU keepalive, host-step spin or undocumented scheduling mechanism is
ported. The source/reference licenses are recorded in THIRD_PARTY_NOTICES.md.
Smart has not been changed to DFlash merely because an upstream benchmark
reports a faster result. Changing it requires a complete native comparison.

## Evidence and release state

The first native runs are preserved at
[[sources/runs/2026/10/2026-10-21-fast-native-first]]. They establish functional
text generation under a small explicit budget. The short DFlash example was
slower than its plain control and produced a different valid answer. Those
runs are exploratory, not a clean paired benchmark or a throughput promise.
Batched kernels can change floating-point rounding and model decisions; target
verification does not imply byte-identical text across different pass shapes.

The [[sources/runs/2026/10/2026-10-21-fast-smart-integration]] preserve the native app, server, cache and workflow results. The complete native UI/runtime checks pass, as do live Fast/Smart switches. The capability suite also exposes model-quality limits: Fast exceeded two word limits and missed a history lookup inside deliberately repetitive prior messages. Smart retrieved that fact, and Fast could use it after switching back. Two other reported failures were overly narrow fixtures, not incorrect answers. The corrected OCR and reviewed-edit reruns passed, and the actual built app completed Fast/Smart/Fast conversation switches at a 9 GB ceiling. Its complete installation verified through Settings, its ad hoc signature passed, and its embedded input manifest matched current sources. Receipt: [[sources/runs/2026/10/2026-10-21-fast-smart-delivered-app]]. The isolated history miss also occurred with DFlash disabled, so it is not a demonstrated DFlash-specific defect. Exact-commit hosted checks are tracked separately. Do not represent this as a clean quality sweep or a public release receipt.
Physical tests on 16 GB and 64 GB machines are unavailable in this session.
Simulated planning and small budgets on the 48 GB Mac are narrower evidence.

## Lessons

A model choice is a complete product change: install and verify every required
component, account for its actual geometry, identify its caches, preserve
settings, exercise tools and review, and test the delivered application.
A working command-line answer does not prove the app's setup or lifecycle.

Measure complete work and include calibration, loading and fallback costs.
Do not transfer an upstream tokens-per-second result across models,
quantization, residency, hardware or implementations. Faster speculative
batches can still make a short request slower. Keep rollback and memory
bounds independent of whether speculation is beneficial.

The existing useful-work and complete-workflow decisions remain binding:
[[records/decisions/remove-gpu-keepalive]] and
[[records/decisions/qualify-complete-native-workflows]].

## Storage and acceptance lessons

A table-tool result exposed a generic storage boundary bug: literal JSON array brackets were interpreted as Markdown links by db.md. Encode JSON data as literal data at the storage boundary, preserve exact decoded values and validate ordinary prose normally. Do not special-case CSV, weaken link validation or ask the user to repair a runtime serialization mistake. Recovery must accept only the exact intended original bytes or their exact literal encoding, and retain external-edit conflict checks. Tests cover normal saves, interrupted saves, Unicode and link-looking user text; a copy of the original failed Home also recovered.

Acceptance checks must match the user contract. An unspecified JSON amount may correctly be a numeric string, and an inclusive range starting at one can be as correct as a range starting at zero. Preserve these raw outputs, correct the fixtures, and test the actual review/apply operation. Keep genuine model-quality misses visible. Do not claim generic language constraints are deterministic guarantees or add prompt-specific runtime hacks to turn a benchmark green.
