---
type: run
id: 01m5ttw64k65jxtgsj43s683x5
created: 2026-10-26T00:48:26.259256+00:00
updated: 2026-10-26T00:48:26.875130+00:00
summary: Q2 demand lifecycle and buffer triage evidence
binary: v68 unchanged; independent io-buffer-probe; compiled OS read-ahead candidate never run with a model
captured_at: 2026-10-25
command: Scripts, fixed input batches, failed setup receipts, source snapshots, build/restoration identities and analyses in archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 demand lifecycle and buffer triage evidence
tool: Offline read/copy/event trace correlation, bounded Objective-C++ read/copy probe, public XNU source review
---
[Raw archive](q2-demand-lifecycle-triage-2026-10-25.tar.xz): 59 files, 415188 bytes, SHA-256 `3e98ab4eb851620e7b52fbb8d074023a8f3a46a364b2700c7582ad5c40ff414c`.
Every member is read back and hash-checked; credential-pattern matches are zero.
Prior ordinary read/copy/Metal traces, readiness matches and typical route
capture are referenced by verified archive/member hashes in `prior-evidence.json`.

The read/copy probe completes all ten rounds without paging. Its two warmups
and eight timed rounds preserve every original-byte batch hash. It allocates
79,626,240 bytes of controlled buffers; that is not a sampled process peak.
No model, forecast or GPU computation runs in this probe. It cannot qualify
inference performance, 15 GB parity or task quality.

A driver lock-preflight error and an extent validator that initially refused
valid unaligned tensor-edge reads both occurred before timing. Their logs and
refusal receipt remain. The repaired probe accepts the actual recorded extents.
The lane analyzer initially mistook CPU-repacked prefill reads for missing raw
copies; independent counters and ordering now separate all prefill from decode.
No timed arm is selected or discarded to obtain a favorable result.

The OS read-ahead candidate compiles but is abandoned before model execution
following source review. It is not a measured speed rejection. The public XNU
source snapshot and exact revision are archived; they do not identify the
installed closed APFS implementation. All 509 runtime inputs and five default
artifacts match v68. Fast remains unchanged.
