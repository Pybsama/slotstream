---
type: run
id: 01m5r74avgmvdn1nkw6p7h52he
created: 2026-10-25T00:24:52.848472+00:00
updated: 2026-10-25T00:25:29.462193+00:00
summary: Focused Q2 cached/miss diagnosis, exact rejected repack candidate and excluded 15 GB comparison
binary: Frozen baseline, diagnostic and candidate hashes in archive manifests
captured_at: 2026-10-24
command: python3 .build/q2-bottleneck-20261024/run_matched.py; run_trace.py; run_candidate_protocol_v2.py
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Focused Q2 bottleneck raw evidence
tool: Swift/MLX/Metal and isolated Splash instrumentation
---
The [raw diagnostic archive](q2-focused-bottleneck-2026-10-24.tar.gz) contains 184 files, 19078738 bytes, SHA-256 `ff3e567f4b4f5595706666e6b7e7bcda28c4794d23288a41385bd33c66ceca31`. All members passed readback verification. Two unique full-logit byte streams and a hash map preserve every repeated logit output without duplicate storage.

The archive includes frozen experiment plans, isolated native and upstream instrumentation, source/binary hashes, all six controlled verification runs, Metal command timestamps, expert-read/copy intervals, kernel probes, failures, original-byte and state checks, the complete six-arm request protocol, the rejected patch, and proof that all 509 runtime source inputs and the default binary were restored to v68. The original complete-request guard logs and supporting scripts are included under `external-guards/` and `reference/`.

The 12 GB controlled NSSN comparison and separate traced pair pass their memory, paging and thermal checks. The complete 15 GB request comparison is **discarded for timing claims**: both candidate arms have global swap-ins, including one warmup. Preserve all arms; no retry or clean subset substitutes for that protocol. Its diagnostic request-time aggregate also fails the predeclared improvement gate. The candidate is reverted.

Reference source: [Splash commit 1482f6b](https://github.com/incoai/splash/tree/1482f6bbc2abf12375332725302019594150b6cb). Included `upstream/Runtime.cpp`, `upstream/ExpertStore.cpp` and corresponding headers are modified diagnostic copies: fixed eight-row target-only verification, cache invalidation/read-ahead controls, route capture and optional read timing. `fixed_verify.mm` is a modified diagnostic driver. They are not production ports. Splash source and the referenced kernels are distributed under the accompanying [Apache 2.0 license](q2-focused-bottleneck-splash-LICENSE-2026-10-24.txt). Native instrumentation and the one-expert-per-row candidate are likewise explicitly diagnostic or rejected; the archive scripts document their changes.

This evidence does not establish 15 GB parity, negligible target-quantization loss, full app readiness, or a new release. The prior passing CI checkpoint remains separately bound to unchanged production source.
