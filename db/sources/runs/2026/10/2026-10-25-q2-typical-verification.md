---
type: run
id: 01m5rbbwxfw7a413xes3v3q31n
created: 2026-10-25T01:38:55.023720+00:00
updated: 2026-10-25T01:38:56.197808+00:00
summary: Captured typical Q2 verification, matched partial misses, tracing controls and rejected candidate evidence
binary: Frozen v68, diagnostic, direct-read candidate and Splash hashes in archive manifests
captured_at: 2026-10-25
command: python3 .build/q2-typical-20261025/run_normal.py; run_replay.py probe; run_replay.py matched; run_replay.py untraced
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Typical Q2 verification raw evidence
tool: Swift/MLX/Metal and isolated Splash instrumentation
---
The [raw archive](q2-typical-verification-2026-10-25.tar.gz) contains 278 files, 47337530 bytes, SHA-256 `db93f4d22280a7d590e7f459773b8498d746af7eba5dd0e83da14fa7deda52bf`. Every archived member passed readback verification. Four unique full-logit byte streams and a hash map preserve repeated outputs without duplicate storage.

This captures the normal 15 GB Q2 trace, captured three-row and four-row fixtures, equal logical partial-miss controls, cached/read-ahead controls, all raw timing records and guard ledgers, cross-engine logits, the trace-disabled control, one rejected direct-read candidate, relevant correctness checks, complete requests, failures and restoration proof. Native and modified upstream sources, build identities, passive Metal command-observer references and exact experiment scripts/plans are included. Original complete-request guard logs are under `external-guards/`. Executables and model weights are identified rather than embedded.

The eight matched diagnostic arms and four trace-disabled arms are clean under their declared memory, paging and thermal gates. Per-read tracing has different overhead in the two engines; traced timings are diagnostic and cannot substitute for the trace-disabled control or production request timings. The normal trace records distributions, not a representative fixed width for every request. Missing logical keys and each layer's miss counts match, but numerical differences produce slightly different additional routes. The measurements describe that limitation.

The complete six-arm production comparison is separately registered in [[sources/runs/2026/10/2026-10-25-q2-typical-complete-requests]]. The candidate's component ABBA is excluded by paging in its final baseline arm and is separately marked discarded in [[sources/runs/2026/10/2026-10-25-q2-direct-read-replay-excluded]]. These receipts share this archive; inclusion here does not remove their exclusions.

Reference source: [Splash 1.4.0 commit 1482f6b](https://github.com/incoai/splash/tree/1482f6bbc2abf12375332725302019594150b6cb). The archived `upstream/` files are modified diagnostic copies for captured target-only verification, exact expert invalidation, route capture and optional read timing. They are not a production port. Splash's Apache 2.0 license is preserved at `reference/Splash-LICENSE.txt` inside the archive. Native diagnostic copies and the rejected patch are identified separately. The complete comparison uses the existing production Splash build with host spin absent.

All 509 runtime inputs and the default build artifacts are restored to frozen v68. No production optimization, Smart promotion, release or app-readiness claim results from this study.
