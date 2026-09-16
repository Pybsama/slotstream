---
type: decision
id: 01m2nvyh0y76whet55dkgs69bs
created: 2026-09-16T19:43:53.886405+00:00
updated: 2026-09-16T19:43:53.886405+00:00
summary: Slotstream is built for Macs that cannot hold the model, 16 to 64 GB; 96 GB and larger Macs run it but are not the optimization target
decided_on: 2026-09-16
evidence: '[[records/measurements/c1-mac-mini-m2-16gb-base-storage-community-2026-09-02]], [[records/measurements/c3-macbook-air-m5-32gb-community]], [[records/measurements/c2-macbook-pro-m5-max-128gb-community]], [[records/measurements/hardware-planning-ranges-2026-09-13]], [[records/measurements/decode-lookahead-default-2026-09-13]]'
reversible_if: Sevra adopts a qualified resident path for Macs that hold the model, or paired measurements show this engine matching resident engines on such Macs
title: 'Slotstream targets Macs that cannot hold the model: 16 to 64 GB'
status: standing
---
Slotstream is built for Macs that cannot hold the model in memory: 16 to 64 GB
installed. That is the segment the engineering, the measurements and the
automatic defaults serve, and the docs say so on every surface.

**Why.** Qwen3.8-Flash-Next is 105 GB on disk at 4-bit. Below 96 GB it cannot
be resident, so streaming experts from SSD is the only way to run it, and every
cost in this engine is a cost of that fact: expert reads, the per-layer cache
bookkeeping and the memory planner. From 96 GB the model fits in memory. An
engine that keeps it resident skips all of that and reports faster replies for
the same model on such Macs; the one community report on a 128 GB M5 Max reads
31.5 tok/s at a 73 GB target on 0.2.3 ([[records/measurements/c2-macbook-pro-m5-max-128gb-community]]).
Optimizing for those Macs would mean a different engine, not a faster version
of this one, and it would trade against the machines the project exists for.

**What this decides.**

- The target range is 16 to 64 GB. Work, gates and defaults are judged there;
  the measured 48 GB M5 Pro stays the reference machine.
- Macs of 96 GB and more are supported, not optimized. Their rows stay in the
  docs as evidence, labeled as the case where the model fits in memory, and the
  related-projects section points such users at engines that keep the model
  resident.
- The `big96`, `big128` and `max192` preset estimates in the plan describe Macs
  outside the range. They were never measured and are not planning targets.
- The 8 GB tier remains planned work with a smaller model; it is inside the
  bet, not outside it.

**What this does not change.** No number, default, automatic plan or ceiling
moves. The M5 Max sweep stays published because it is true within Slotstream.
Sevra's maintained model selection may later choose a resident path for large
Macs; that is a product decision recorded elsewhere, not this one.

**Surfaces updated on 2026-09-16.** README ("Who it's for", the opening
paragraph, the memory tier table, the measured-results note, status and limits,
a FAQ), `docs/HARDWARE.md`, `docs/GETTING-STARTED.md`, `docs/ENGINEERING.md`
(how it works, why this exists, related projects), `llms.txt`, `CHANGELOG.md`,
`CLAUDE.md`, and the plan records [[records/design/1-goal]],
[[records/design/slotstream-qwen3-8-flash-next-on-every-apple-silicon-mac]] and
[[records/design/presets-v1-est-columns-to-be-replaced-by-m8-measurements]].
