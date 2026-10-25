---
type: run
id: 01m5sycar9frnh1vv3a45jth0d
created: 2026-10-25T16:30:26.569468+00:00
updated: 2026-10-25T16:30:53.023207+00:00
summary: Excluded Q2 continuation protocols and diagnostic harness failures
binary: v68 plus diagnostic candidate and Splash identities in the archive
captured_at: 2026-10-25
command: Frozen protocols and exact commands in the q2-frozen-sequence archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Excluded Q2 continuation protocols and diagnostic harness failures
tool: Swift/MLX/Metal and bounded Splash diagnostics
---
The [raw archive](q2-frozen-sequence-2026-10-25.tar.gz) contains 797 files,
52891637 bytes, SHA-256 `b74f4fbdeca0cf68cea1bbdfa55e1070091a1a2015524e88e201c9507319f2a9`. Every member passed hash readback.
Scripts, inputs, rejected patches, diagnostic source, commands, binary identities,
guards and failures are preserved. Model weights and executables are identified,
not embedded. Original Splash source excerpts and its license are included.

These phases are preserved without clean timing claims. The pending-state
ablation has 47 global swap-in pages in its last native control. The symmetric
read/GPU observation protocol has four swap-in pages in its native arm. Entire
protocols are excluded, not just their unfavorable arms. Their arithmetic and
overlap observations remain explicitly diagnostic.

The first CPU sampler uses an invalid PID selection; the next marker samples
prefill rather than verification. Neither establishes verification CPU repacking.
cpu-profile3 waits for an explicit post-prefill marker and is the valid sample.
Early dedicated-worker harness versions fail Swift noescape-block lifetime and
fallback-recursion contracts; the corrected version has a separate exact-once
completion check and completed clean timing protocol. Initial upstream fixture
and build-lock self-contention errors are retained; neither is a production
regression or a successful comparison. Guarded cancellation and failure receipts
remain alongside successful runs. See the individual ledgers and launcher logs.
