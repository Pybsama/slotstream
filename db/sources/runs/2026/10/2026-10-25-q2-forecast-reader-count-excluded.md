---
type: run
id: 01m5t6nwmbexsszmby4tkf438t
created: 2026-10-25T18:55:28.395331+00:00
updated: 2026-10-25T18:55:29.526260+00:00
summary: Q2 forecast-reader count and offline demand-lane analysis
binary: Identified v68 baseline, two-reader candidate and Splash1482f6b
captured_at: 2026-10-25
command: Commands, source snapshots, guards and offline analysis scripts in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 forecast-reader count and offline demand-lane analysis
tool: Native Q2 candidate and pinned Splash fixed-verification harness
---
Evidence: [q2-forecast-reader-count-2026-10-25.tar.gz](q2-forecast-reader-count-2026-10-25.tar.gz), 66 files,
3112924 bytes, SHA-256 `6cf8c3b878b2a456e41a10456a0895043d14c8337561a02fc070768027c08aff`. All members pass hash readback
and credential-pattern screening. Executables and weights are identified,
not embedded. Earlier physical-read data, fixtures and demand observations
are in the two referenced prior archives.

The Q2-only candidate reduces forecast queues/lanes from four to two, preserving
demand lanes, copies, staging, reservation and actual cache capacity. Diagnostic
identity reports actual lanes. Generic lifetime and installed original-byte Q2
checks pass with Metal validation. The ordinary piece-reader lifetime check
uses four queues, so it is not dedicated two-queue cancellation proof. The
prepared parameterized test did not run after the component gate failed.

One ABSSBA protocol uses 15 GB, 4,067 slots, 8,192 context and two rounds of
the frozen 111-pass continuation per process. All 888 native full-logit hashes
match v68, including both actual two-queue arms. Splash repeats within its own
engine. Actual footprint, headroom, thermal and competing-build gates pass.
Final A records 924 global swap-in pages and zero swap-outs, excluding the
entire timing protocol. Raw pair directions also reverse. No complete-request
or smaller-cache comparison follows; those scripts/plans remain unexecuted.
All 509 runtime inputs and five default artifacts match v68.

Offline read-lane analysis maps original GGUF extents to logical pieces and
validates every native demand count and observed static lane order. A model
of recorded pread service times predicts no dynamic-lane advantage, but omits
copying, task overhead, changed I/O latency and GPU overlap. Forecast accounting
finds substantial completed-but-unused work, motivating this bounded trial
without proving that read concurrency caused the remaining delay.
