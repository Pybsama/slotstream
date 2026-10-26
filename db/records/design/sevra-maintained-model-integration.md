---
type: design
id: 01m21xw595ac9n303q61m8kvtq
created: 2026-09-09T01:52:44.837037+00:00
updated: 2026-10-26T19:14:46.106002+00:00
summary: Maintain one Qwen3.8-Flash-Next 4-bit native engine, CLI, APIs and Swift library; the Mac app and other model tracks are archived.
date: 2026-09-08
doc: plan
level: '2'
order: '5'
title: 'Slotstream engine: one maintained model'
---
# One model, native engine

[[records/decisions/engine-only-maintenance]] sets the current scope: native
Swift/MLX/Metal inference, the CLI, serving APIs and public Swift library for
Qwen3.8-Flash-Next 4-bit. The Mac app, Fast tier and Q2 model track are archived.
A future successor may replace the maintained model after qualification.

- Pin the checkpoint, quantization, tokenizer, template and runtime identity.
  Hardware profiles tune memory and context for that same model.
- Optimize useful completed requests, prompt processing, latency, memory and
  SSD reads. Numerical, resource and lifecycle gates remain exact.
- Bind caches to actual model, arithmetic and execution identities. Preserve
  request ownership, privacy, cancellation and serving boundaries.
- Keep model setup explicit, verified and recoverable. Never silently retarget
  a request, download another model or route work to a remote provider.
- Preserve documented CLI/API/Swift behavior. Public breaking changes require
  their own approved migration.
- Qualify changes through the engine and actual client workflows on supported
  hardware. Archived app delivery gates do not constrain engine releases.

Update active docs, tests and canonical plans together. Preserve links and
historical evidence. No release is authorized by this scope change.

## Historical scope notes

The dated notes below describe earlier work, not active promises or a second
model maintenance track.

## Compatibility-tier support, September 13, 2026

Carlos requested that the public memory table state that Compatibility-tier
support is coming soon. README.md, the hardware guide and llms.txt now carry
that roadmap status while retaining the current model limitation. The present
8 GB plan still does not fit; no runtime support, selected future model,
release date or performance result is established by this wording change.

## Same model quantization workstream October 2 2026

[[records/plan/same-model-quantization-and-automatic-memory-2026-10-02]] records the Mac implementation and research effort closed on October 7. Initial Auto selection and independent supported-pack, memory-ceiling and live-memory controls are implemented and tested; the separate governor adapts allocations without changing the chosen pack. Original four-bit remains the only supported pack, and the full same-checkpoint speed target across the intended hardware range remains unmet. The closed plan links the accepted implementation and scoped measurements; it does not qualify an alternative pack or unmeasured hardware. The control decision is [[records/decisions/same-model-automatic-quantization-with-overrides]], and the broader model policy is now superseded by [[records/decisions/one-maintained-model]].
