---
type: decision
id: 01m5wpcjbwwafrk10cy4bdnxab
created: 2026-10-26T18:08:29.052124+00:00
updated: 2026-10-26T18:08:29.052124+00:00
summary: Maintain Qwen3.8-Flash-Next 4-bit only; archive Fast, Q2 and associated runtime work without releasing.
decided_on: 2026-10-26
reversible_if: Carlos explicitly reopens model work, with complete native quality, latency and resource evidence for a successor.
title: One maintained model
status: standing
---
# One maintained model

Carlos chose one maintained model at a time on October 26, 2026: currently
Qwen3.8-Flash-Next 4-bit. The objective is capability on owned Macs, with the
whole native stack optimized around that model. A separate Fast tier and the
Q2 target add maintenance work that the product will no longer carry.

## Active scope

Keep the original pinned checkpoint, native Swift/MLX/Metal engine, SSD expert
streaming, memory-aware MTP, expert lookahead, context and prefix caches.
Preserve released CLI/API/Swift behavior. The native app uses the same model
without a Fast/Smart picker. Hardware profiles tune resources, not model tiers.

The archive removes Fast, Q2, Smart DFlash and their dedicated runtime branches,
setup paths, commands, kernels, tests and active CI. Their full source and
licenses remain at `df208489af2ef5378444727172b6dfcf8ee1ed10`, named by
`archive-fast-q2-2026-10-26`. The [archive index](../../../experiments/fast-q2/README.md)
links the fixed tree and evidence. Measured results and failures remain dated
and unchanged; retiring the work does not invalidate those observations.

Keep the unrelated Home data integration, relevant conversation retrieval and
literal JSON storage fixes. Retire experimental app preferences with a visible
notice and preserve memory settings, Homes, conversations and downloaded files.
Do not relabel historical activation receipts, grant download permission or
reuse incompatible inference caches during migration.

A more capable successor can replace the maintained model after complete-task,
quality, latency, context and memory evidence on the supported Macs. There is
no parallel Fast tier or active compressed-target qualification queue. New
model work needs a new owner decision. Language choice and parameter count do
not prove superiority over every alternative.

## Documentation and release state

README, repository description, app controls, guides, tests, plans and agent
instructions must describe this one-model scope. Keep SSD streaming, fully
native Swift/MLX/Metal, local offline inference and no Python runtime prominent.
Use concrete language and retain the qualifications attached to measurements.

No release is authorized. v0.2.30 remains the latest public engine release;
the app remains available from source without a published installer. Current
source changes belong under Unreleased.

This supersedes the multi-model direction in
[[records/design/sevra-maintained-model-integration]], the active roles in
[[records/decisions/fast-and-smart]], and the continuation instructions in
[[records/decisions/smart-dflash-and-target-quantization]],
[[records/decisions/native-input-read-ahead]] and
[[records/decisions/q2-precompilation-stays-experimental]].
