---
type: measurement
id: 01m5h7yp7wb4k7xaf2n47wrzex
created: 2026-10-22T07:24:35.452353+00:00
updated: 2026-10-22T07:55:15.284584+00:00
summary: Exact native Q2 passes component, bounded CLI and six real app jobs; retain Smart while speed, quality and vision tradeoffs remain
date: 2026-10-22
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1875'
runs: '[[sources/runs/2026/10/2026-10-22-native-q2-port]], [[sources/runs/2026/10/2026-10-22-native-q2-timing-exclusions]], [[sources/runs/2026/10/2026-10-22-native-q2-app]]'
title: Native exact Q2 qualification
status: measured
---
The exact upstream mixed-format Q2 checkpoint now runs inside Slotstream's
Swift/MLX/Metal engine. This is an explicit engineering candidate, selected as
`smart-q2`; it does not replace Smart, appear in normal setup, or enter automatic
selection. Fast remains the default for new app installs. No public release is
published by this work.

## What was ported

The two original GGUF shards retain their pinned SHA-256 identities. All 1,224
tensors are accounted for, including the output head, mixed-format residents,
FP16 Q2 scales, GDN head permutations and IQ4_NL PLE lookup table. There is no
requantization into the earlier approximate affine expert overlay. Experts and
large embedding rows stream from SSD into bounded native caches. Packed resident
matrices remain packed. Native Metal implements the checkpoint's thirteen
formats, FP32 accumulation and shared dense-weight tiles; it does not widen the
whole checkpoint. The original shard revisions and exact hashes are in
`PinnedQ2Model.swift` and the evidence archive.

The pinned Smart DFlash2 component runs natively with target verification,
bounded draft state and ordinary decoding when speculation costs more. A
single-request adaptation of Splash's confidence/cost verification policy is
checked against its C++ implementation. Licensing and notices accompany the
ported decoder helpers. No Splash/Python runtime, GPU spin, power-state changes
or hidden provider is used by the product.

This is the exact target artifact with native arithmetic, not proof of
whole-engine bit parity with Splash. The execution schedule, recurrent/KV
arithmetic and cache policy differ. Splash's grouped expert kernels, ARC cache
and INT8 KV implementation have not been ported. The GGUF has no vision tower;
current Smart's general image understanding is not preserved by this candidate.
Native document OCR is a separate host capability.

## Method and source identity
All physical runs use the owned M5 Pro with 48 GB unified memory. Functional
runs use an explicit 10 GB process target and a real target-plus-3 GB reclaimable
preflight. Capacity/timing diagnostics use 16 GB. Other sessions are left alone.
Global paging is recorded and excludes clean speed claims; it does not erase
successful functional and process-memory checks. No simulated availability is
used for allocation. Simulated 16/32/48/64 GB plans only test planner contracts.

Frozen v1, v2, v3 and final CLI manifests bind source archives, executable and
Metal library hashes. The functional process took 27.31 seconds to load,
including full shard verification; this is an observed startup diagnostic, not
a clean comparative latency estimate. The qualified CLI executable is
`a1413db7d9bccafc48442f33a75780e1e72c6b69d90bbb25de7dcdcfe02e4f18`.
Its inference arithmetic is the v3 arithmetic. The changes enumerated by
`final-source-comparison.json` protect normal model selection and extend
regression checks and explicit CLI pack reporting.

The later app qualification fixes selected-preference propagation in the test
harness and admits the explicit Q2 candidate at the applied-configuration
identity boundary, without admitting it to automatic selection. These changes
in commit `9488c6191fe5b020af941653dd34fd14e6731572` do not change inference
arithmetic. The successful app executable is
`8339c6066b541ad65e7968039cba0c22b4760ae186c1ba4e82e7eefe840c3c15`.
The final composer-label correction changes only `ContentView.swift`; its app
executable is `b87a9fbbca8a267c62705be53a90b15b6bdde232cbf5efaba8006f68978860ce`.
Separate source archives and build-input hashes bind both app builds in
[[sources/runs/2026/10/2026-10-22-native-q2-app]].
## Numerical, runtime and quality results

Independent real-weight block fixtures cover all thirteen decode formats,
matvec, routed gathers, and dense tiles with 2, 3 and 5 input rows. The verification
policy matches 160 cycles of the upstream C++ oracle, including refits. Tiny
admission fixtures cover wrong hashes, cancellation, truncation, overflow,
symlinks and file mutation. These checks protect component arithmetic and
loading, not broad model capability.

The frozen 24-task quality suite scores 19 semantic passes and 12 strict-format
passes, matching the earlier upstream Q2 totals. The earlier native Smart run
scored 21 semantic and 16 strict passes. The native Q2 misses are order-total,
stock, tax, Spanish and first-missing-positive coding cases. Correct values
inside an unwanted code fence remain semantic successes and strict failures.
The small suite does not establish statistical accuracy or negligible loss.

The final arithmetic also passes streamed-output equality, conversation recall,
cancellation and subsequent recovery, stop buffering, real tool-call decoding,
and long-document retrieval. Its 32-request diagnostic has an observed lifetime
physical peak of 8.13 GB. A repeated long prompt reuses 2,304 tokens; a fresh
process restores the same prefix and retrieves the correct audit code. Prefix
receipts preserve payload sizes and counts. The existing Smart elastic-cache
check keeps identical tokens across shrink/grow transitions after the shared
expert-store changes.

## Speed evidence and remaining bottleneck

Three native 16 GB coding diagnostics generate to the same 1,024-token cap:
8.69, 8.59 and 8.72 decode tokens/s, with physical peaks around 12.9 GB. Every
run has global paging, so all are excluded from clean timing. They demonstrate
completion within the envelope, not a causal speedup or a matched clean
comparison against upstream. The earlier Splash measurements around 43–44
at this requested budget and the publisher's fully resident headline are
separate evidence, not results reproduced by this port.

In the final diagnostic, demand I/O accounts for about 16.6 of 117.5 decode
seconds. Disk waits alone therefore cannot explain the whole gap. Routed expert
compute still executes independent vector operations per route instead of
reusing expert weights across verified tokens. The shared-weight dense kernel
does not solve that expert path. Dispatch/synchronization and packed compute
remain candidates for profiling; residual time is not proof of one exact cause.
Speculation falls back to ordinary decode when measured cost exceeds its benefit.

The shorter dense-batch trial does not materially improve sustained generation.
Do not attribute its different prompt time to that change: the performance
prompt already used a larger batch and the environment was not controlled.
The next useful optimization is to profile and amortize routed expert work,
then repeat complete-work comparisons under eligible conditions. Smaller
checkpoint bytes alone are not a whole-engine speed claim.

## Adoption and limits

Keep Q2 explicit until useful-work benefits justify its measured capability
losses and missing vision, and until native speed is competitive. Preserve
failed tasks and normal product settings. Do not weaken the existing model
selection checks to admit an unqualified candidate. New capabilities require
complete app and delivery evidence; format fixtures, CLI output and simulated
RAM plans answer narrower questions. Actual 16 GB and 64 GB hardware remains
untested. A new candidate does not change the Fast/Smart product contract.

## App and regression qualification status
The full v2 native UI/runtime suite passed. The qualified CLI passes the
107-check engine catalogue, numerical reference command, 97 planner checks,
420 simulated memory-override cases, installer gates and resumed static
transport checks. The corrected production app builds successfully and its
scripted runtime checks pass. The initial local static-gate entry was resumed
after source-list/fixture fixes; hosted full-entry verification is separate.

Six real Q2 app jobs pass with actual loaded-model identity and the 10 GB
ceiling asserted: writing, PDF citations, receipt OCR, CSV calculations,
reviewed code edits and history recall outside the initial context. PDF work
selects the current source over an obsolete figure; OCR yields valid requested
JSON; CSV uses deterministic calculation. Code remains unchanged until review,
then the approved patch passes bounded execution. The combined physical peak
is 7.78 GB. These are six selected cases from the larger task map, not a claim
that every app capability is qualified with Q2.

The first app arm accidentally loaded Fast because its harness constructed the
inference owner without selected preferences. Identity assertions rejected all
six cases, preserving the mistake instead of counting them as Q2 successes.
After fixing the harness, the next arm found a production activation guard
that rejected the explicit candidate because it was outside the normal
supported list. The corrected activation admits the exact pinned candidate
while preserving setup and automatic-selection isolation. Both failures and
the passing rerun remain in the immutable app archive.

A visible isolated app instance answered exactly `NATIVE-Q2-READY` and showed
the candidate ready under the saved 10 GB limit, with an observed 7.60 GB peak.
The composer initially mislabeled it Smart. A display-only fix was rebuilt and
visibly verified as `Q2 candidate`; normal new-user options remain Fast/Smart.
Test processes exited, the owned activation journal returned to its original
absence, and the separate defaults domain was removed. User Homes and saved
preferences were untouched.

Keep this result as functional integration on one Mac. Global paging excludes
comparative app latency claims. Current Smart remains unchanged because the
quality, missing-vision and native-speed tradeoffs are unresolved. Neither
ad-hoc development signing nor passing workflows is a public release.

Evidence: [[sources/runs/2026/10/2026-10-22-native-q2-port]],
[[sources/runs/2026/10/2026-10-22-native-q2-timing-exclusions]] and
[[sources/runs/2026/10/2026-10-22-native-q2-app]]. Prior upstream comparisons:
[[records/measurements/exact-q2-performance-and-quality-followup]].
