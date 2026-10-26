---
type: design
id: 01m21xw595ac9n303q61m8kvtq
created: 2026-09-09T01:52:44.837037+00:00
updated: 2026-10-26T18:09:26.256106+00:00
summary: One maintained Qwen3.8-Flash-Next 4-bit model across the app and engine, with preserved interfaces and qualified future replacement.
date: 2026-09-08
doc: plan
level: '2'
order: '5'
title: 'Slotstream integration: one maintained model'
---
# One model, one native stack

[[records/decisions/one-maintained-model]] sets the current scope as of October
26, 2026. Maintain Qwen3.8-Flash-Next 4-bit across the Mac app and independent
engine. A future successor may replace it after qualification; there is no
separate Fast tier, compressed candidate or hardware-specific model catalog.
The earlier September multi-model direction and October Fast/Q2 implementation
are archived. This replaces their active selection and continuation policy.

- Pin the model, quantization, tokenizer, template and native runtime identity.
  Hardware profiles vary memory and context limits for that same model.
- Optimize complete useful tasks, prompt processing, latency, memory, storage
  and sustained behavior. Numerical and resource gates remain exact.
- Bind derived caches to actual model, arithmetic and execution identities.
  Preserve durable data, permissions and conversations across changes.
- Keep model setup explicit, verified and recoverable. Never retarget a running
  request, silently download a replacement or route work to a remote provider.
- Preserve documented CLI/API/Swift behavior and the independent engine.
  Public breaking changes require their own approved migration.
- Qualify a future successor through the production app, tools, review and
  supported hardware before changing the maintained model.

Documentation is part of implementation: update current guides, tests and
canonical plans together, regenerate projections, preserve old links and keep
historical evidence clearly dated. No release or public app installer follows
from this decision.

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
