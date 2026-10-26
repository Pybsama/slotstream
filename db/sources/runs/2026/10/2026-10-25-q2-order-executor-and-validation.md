---
type: run
id: 01m5tgw382yhsge24v97dztgys
created: 2026-10-25T21:53:37.538481+00:00
updated: 2026-10-25T21:53:46.992385+00:00
summary: Q2 condition order, execution context and validation placement
binary: Original v68 runtime with diagnostic CLIs; pinned Splash; archived source and build identities
captured_at: 2026-10-25
command: Exact commands and frozen protocols in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 condition order, execution context and validation placement
tool: Native and pinned Splash verification harnesses with passive macmon
---
Evidence: [q2-order-executor-and-validation-2026-10-25.tar.xz](q2-order-executor-and-validation-2026-10-25.tar.xz), 178 files, 22074340 bytes, SHA-256 `23b6a237ddd0455cc33943141ad8d637dc4645dc518546ed4976fd1b6111c899`. Every member passes sequential hash readback, and credential-pattern screening finds no matches. The archive preserves diagnostic sources, build identities and source archives, protocols, all raw outputs and guards, passive clock samples, analyses and restoration proof. Fifty-six full-logit files are hash-verified and represented by two unique payloads. Executables and model weights are excluded.

This combined source is marked discarded because two protocols have whole-protocol timing exclusions. The phase-order comparison is clean; keep each protocol's verdict separate.

1. Phase-order NSSN: same four-row input, 393 common missing keys, 4,067 slots, 8,192 context, BF16 activation/KV and FP32 recurrent state, under 15 GB. Each process seeds the routed keys with one ordinary untimed pass, then runs two warmups and 64 measured passes for each of cached/off, partial/off, cached/on and partial/on. N0/S1 run forward and S2/N3 reverse. All four processes pass no-paging, no competing-build, nominal thermal, actual footprint and headroom checks. Peak is 12.65 GB and sampled headroom exceeds 13.94 GB. All 528 native outputs match the frozen native full-logit hash; all 528 Splash outputs retain their separate exact reference.
2. Native execution context ABCCBA: A runs on the existing Swift task at QoS25, B on a dedicated serial queue at QoS25, C on a dedicated serial queue at QoS33. The harness asserts the actual executing thread's class. First three processes use forward conditions, final three reverse. It does not mutate shared executor priorities. B1 records eight global swap-in pages, excluding the entire timing aggregate. The other five processes are individually clean. All 1,584 outputs match the native reference. No context or priority change is adopted.
3. Validation-placement ABBA: A reads and hashes full logits between passes; B retains evaluated output arrays and performs the same full checks after each 66-pass condition. First two processes use forward conditions and final two reverse. B1 records four global swap-in pages, excluding the entire timing aggregate. Every output is checked after its phase; all 1,056 match the native reference. The peak, including retained arrays, is 11.90 GB. A preliminary fast segment of B1 does not persist, and clean B2 does not repeat it. No runtime optimization follows from this control.

The previous fixed-pass readiness trace is also reanalyzed structurally. Both native partial/off and partial/on put all 144 CPU-published readiness waits before the first compute encoder. Command-buffer address reuse is separated by submission timestamps. This rules out that placement difference as an explanation of this particular fixed-pass case; it is not a new timing result or proof about every evolving continuation.

Rootless macmon 0.10.0 samples at 200 ms. No injected GPU/read tracing, GPU spin or power-setting change is used in these new protocols. Frequency is associated with whole-device samples over verification intervals, not an instruction count or proof of a governor defect. Sampling shifts retain their coverage limits. No process is stopped on Carlos's behalf and no other chat is messaged.

All 509 runtime source inputs and five default build artifacts match frozen v68. The only source differences in diagnostic builds are the test command and preexisting explicit cache-key eviction seam. Fast remains unchanged. No new complete-request comparison, broad quality pass, Smart promotion or app-readiness claim is made here.
