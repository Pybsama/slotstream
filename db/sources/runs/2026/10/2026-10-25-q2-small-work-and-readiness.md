---
type: run
id: 01m5trxrznskh50eyrp08j57z0
created: 2026-10-26T00:14:21.173443+00:00
updated: 2026-10-26T00:14:21.804771+00:00
summary: Q2 small-work controls and dependency attribution
binary: v68 plus diagnostic CLI for baseline; isolated Q2 embedding or greedy candidates; published Splash1.4.0; separately bounded host-probe builds. Production restored.
captured_at: 2026-10-25
command: Exact commands, frozen plans, source snapshots, build identities, raw outputs, guards, ledgers and analyses in linked archives
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 small-work controls and dependency attribution
tool: Native diagnostic builds, bounded host/read/Metal observers, passive macmon, uninstrumented complete-request comparisons
---
- [q2-graph-and-small-read-attribution-2026-10-25.tar.xz](q2-graph-and-small-read-attribution-2026-10-25.tar.xz): 58 files, 25065548 bytes, SHA-256 `e7971f00417c52d582f2db213a2738e00ee60d840e7fd09a4959d04cd8bceeb6`.
- [q2-embedding-dedup-rejected-2026-10-25.tar.xz](q2-embedding-dedup-rejected-2026-10-25.tar.xz): 82 files, 4322540 bytes, SHA-256 `a3b9c041f67fdecf5c6cfc421d3873a43e55cdc8db5b2b1f8d1874157aa3b669`.
- [q2-joint-greedy-rejected-2026-10-25.tar.xz](q2-joint-greedy-rejected-2026-10-25.tar.xz): 72 files, 4059248 bytes, SHA-256 `67b0beb09c39fb139e67084eb0fd970dab6e85b387764bebf30f8d096751b74e`.
- [q2-critical-readiness-attribution-2026-10-25.tar.xz](q2-critical-readiness-attribution-2026-10-25.tar.xz): 12 files, 2550492 bytes, SHA-256 `65e15d9c645f447c380b3f2454b1d02540ada3b43a9be9b834e24f99575b8f1a`.
- [q2-demand-and-tail-attribution-2026-10-25.tar.xz](q2-demand-and-tail-attribution-2026-10-25.tar.xz): 52 files, 24800196 bytes, SHA-256 `106b3f068a78af9cdc501c7cc342c6ab8ef7395172e54be5c19de10dbdd31117`.

Archive members are read back and hash-checked, with no credential-pattern
matches. Executables, libraries, metallibs, weights and transient windows are
excluded. Prior read/encoder traces and helper sources are referenced by
verified archive and member hashes in `prior-evidence.json`.

Both ABCCBA complete-request protocols are clean; their candidates fail the
frozen repeatability gate. A failed optimization is not an environmental
exclusion. Neither is retained. The dedup test helper's initial compile failure
and repaired source are preserved; the runtime candidate did not change.

Host/read/encoder diagnostics are attribution only. Scopes and CPU workers
overlap. Metal intervals include scheduling and stalls. Missing upstream stage
timestamps are explicitly counted. The short greedy component test's sampled
process footprint misses its true peak and must not be presented as that peak.
Its bounded arithmetic checks and the complete-request memory guards are separate.

The record links these experiments without claiming numerical identity between
engines, quantization quality, full task-quality success or app readiness.
