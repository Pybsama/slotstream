---
type: run
id: 01m5t5485dsmwv8n5x4azmffm3
created: 2026-10-25T18:28:21.805536+00:00
updated: 2026-10-25T18:28:22.440474+00:00
summary: Q2 aligned forecast-only continuation preserves arithmetic; timing excluded
binary: Identified v68 baseline, forecast-only candidate and Splash1482f6b
captured_at: 2026-10-25
command: Exact commands, source snapshots and process ledgers in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 aligned forecast-only continuation preserves arithmetic; timing excluded
tool: Native Q2 candidate and pinned Splash fixed-verification harness
---
Evidence: [q2-forecast-only-sequence-2026-10-25.tar.gz](q2-forecast-only-sequence-2026-10-25.tar.gz), 66 files,
2958588 bytes, SHA-256 `07b451362b10bc91a2411c8cdea7759511f2c232794eb2e3e30bb83a15acedf3`. Every member passes hash readback
and credential-pattern screening. Model weights and executables are identified,
not embedded. The older 111-pass fixture and baseline reference are preserved
in the prior sequence archive, identified in reference/frozen-sequence-archive.json.

The existing aligned forecast-only patch is tested on evolving frozen work,
following new sustained-copy evidence. Its previous single-state protocol is
not erased. Demand storage/copies, cache capacity and controller remain original;
only forecast storage padding, payload offsets and direct page reads change.
The seven-file runtime patch and diagnostic CLI source are frozen separately.

Installed-weight, original-byte, mixed demand/forecast, cancel/retry/resize and
Metal API validation checks pass with no paging. The ABSSBA continuation uses
15 GB, 4,067 actual slots, 8,192 context and two rounds per process. Every one
of the native arms' 888 full-logit hashes matches the prior v68 reference;
Splash hashes repeat within its own engine. Its fixed harness disables CPU
polling. All actual memory, headroom, thermal and external-build checks pass.

Reverse B records 14 global swap-in pages, no swap-outs. The entire protocol
is excluded for timing, including the favorable first pair. Neither the pages
nor the larger reverse-B duration is causally attributed to the model. The
component gate fails, so the prepared complete-request runner does not run.
No benchmark repeat or production change follows. The restoration receipt
verifies all 509 runtime inputs and five default artifacts equal v68.
