---
type: measurement
id: 01m4xfqzt8y1h6gh2zckmcpy4e
created: 2026-10-14T15:15:55.848904+00:00
updated: 2026-10-14T15:15:55.848904+00:00
summary: Six public-release full-model requests on M5 do not reproduce the sustained 32k cliff; M4 cause and release-fix status remain unresolved
date: 2026-10-14
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1830'
runs: '[[sources/runs/2026/10/2026-10-14-issue54-full-model]]'
title: Issue 54 full-model reproduction across 32k
status: measured
---
**Verdict.** Treat issue #54 as a credible unresolved performance report, not intentional behavior or a confirmed fix. A sustained threefold decode loss across a tiny context change is not the expected gradual cost of a longer conversation. The reporter supplied repeated boundary measurements and controls for cache sizing, elasticity and maximum configured context. Those are useful evidence, although the affected M4 has not been independently profiled.

Evidence: [[sources/runs/2026/10/2026-10-14-issue54-full-model]]. Prior component coverage: [[records/measurements/issue54-native-boundary-probe-2026-10-13]] and [[records/measurements/issue54-boundary-followup-2026-10-13]].

**What this follow-up adds.** Actual full-model API generation against the exact public v0.2.29 binary, with the reporter's templated German repetition prompts, MTP off, temperature zero and 500 output tokens. The two prompts tokenize to precisely 32,320 and 32,770 tokens. The first crosses the boundary during generation; the second starts above it. Both have per-token intervals, returned IDs/counts, process memory samples and global operating-condition observations. No generation request ran in the earlier component-only studies.

**Important scope.** The local hardware is M5 Pro. The 640-slot, 9 GB test plan cannot reproduce the reporter's 24–26 GB pool, near-working-set allocation, long retained prefixes, exact prefill chunk or M4 driver scheduling. Default prefix retention was enabled but neither long request stored a checkpoint or reused a prefix. Portable overrides select the ordinary M4 rotation and prefill branches on M5; they do not emulate M4 hardware. The source/header identities are captured, but this session did not repeat the prior full checkpoint payload verification.

**Boundary audit.** The existing source analysis still finds real transitions: SDPA work partitioning at 32,769 keys on the relevant backend family; stepped KV/indexer allocation at the same key; and an additional indexer sort merge stage at 32,772 keys. Small costs at those boundaries do not by themselves establish the reporter's sustained loss. Both release tags pin the same mlx-swift revision. GPU keepalive is absent in the tested release, so a successful new-version M5 run cannot establish whether removing it fixed the old-version M4 report.

**Read-ahead coverage matters.** `--mtp off` does not imply decode lookahead is off. The planner independently enables plain-decode lookahead from 20 experts per layer before its charge. The first 640-slot tests do not engage it. A fixed 960-slot configuration can engage the real automatic corrected forecast with MTP off while remaining below a 10 GB planned envelope. The older top-level comments in DecodeLookahead.swift incorrectly described a draft-head requirement; this follow-up corrects those comments and links the standing plain-decode decision, with all noncomment lines unchanged. The default corrected attention tap does not perform the separate dense attention readout measured in the earlier component probe.

**Interpretation discipline.** Keep complete API execution separate from clean performance qualification. Global paging and thermal variation exclude the live-desktop timings from published speed claims. Preserve interrupted attempts and actual OS warnings separately from the reported 32k symptom. Do not call an externally stopped prefill a reproduced decode cliff. Likewise, selected fallback branches and successful low-memory runs do not certify another GPU or a large-memory profile. Change runtime behavior only after identifying a failing path and verifying a remedy.

**Completed results.** Six requests complete with 500 output tokens each, for 3,000 output tokens. Each reports the expected rendered prompt length, MTP off, 256-token prefill, the intended pool size and 499 plain forward passes. No request returns an inference error. Responses contain German explanations of Rayleigh scattering, ending at the requested output limit; this is a basic completion check, not an independent quality evaluation.

The following are observed diagnostic rates on this live desktop, excluded from clean performance qualification. They are not speed guarantees or a causal comparison between configurations, which differ in cache size, arithmetic path and retained-state settings.

| Configuration on M5 Pro | 32,320-token prompt, 500 output | 32,770-token prompt, 500 output | Largest reported process peak |
| --- | --- | --- | --- |
| Deployment defaults, 640 slots | 5.06 tok/s | 5.68 tok/s | 7.824 GB |
| Portable rotation/prefill, 640 slots | 5.44 tok/s | 5.49 tok/s | 7.647 GB |
| Portable paths and automatic corrected lookahead, 960 slots | 7.22 tok/s | 7.92 tok/s | 8.893 GB |

The 32,320-token requests each contain 448 observed forward intervals at or below 32,768 active keys and 51 above. Median intervals before/after are approximately 196/194 ms for deployment, 180/171 ms for portable paths and 134/125 ms with lookahead. Narrow adjacent windows and every boundary interval are preserved too; their small changes do not form the sustained threefold regime in the report. Each 32,770-token request then observes 499 intervals entirely above the boundary without the reported slower regime.

The lookahead arm actually runs the automatic `attention-corrected` forecast, with the pinned correction file, router cache, issued reads and adopted experts. Both portable arms return identical output IDs for each matched prompt. The deployment and portable output IDs differ because those tests select different prefill arithmetic; this study does not claim equivalence across those branches or a speed gain from switching them. The small-cache requests store and reuse no full-prompt checkpoints, so large retained-prefix interactions remain untested.

**Interrupted attempt and memory safety.** Four model processes were launched sequentially: the deployment pair, an interrupted lookahead prefill, the portable pair and the successful guarded lookahead retry. The initial lookahead attempt met its 12.66 GB launch gate, but subsequent observations recorded an OS warning. It was stopped during prefill before any decode result. The cause of that global warning is not established, and it is not evidence for the reported 32k cliff. The later portable and lookahead processes monitor OS pressure and process footprint every two seconds and stop on a warning or their respective 9/10 GB footprint ceilings. Both complete without triggering the monitor. All owned servers, observers and drivers exit.

Global swap-ins changed in five of the six completed requests, with no new swap-outs. Fair thermal states are present. Keep these measurements outside clean timing qualification, even for the one request without paging. Functional completion and observed absence of the large cliff remain distinct evidence; the measurements cannot rule out smaller regressions or certify performance on M4.

**Disposition and next discriminating observation.** The maintainer has now completed the full-model work that earlier memory refusals prevented. No sustained cliff reproduces in these three bounded configurations on the local M5. Keep #54 open, retain the reporter's controls, and do not claim a release fix, dismiss the report, change context limits or remove unrelated mechanisms based on these negatives. The next decisive check is the same comparison on the affected M4 with v0.2.29 and its original memory settings. If it persists, record macOS, the actual planner output and per-token/memory observations before choosing a targeted kernel, allocation or read-ahead comparison. The lower-context workaround remains based on the reporter's own observations, not a new independently verified M4 remedy.

Prior replies were read again before posting the [new full-model follow-up](https://github.com/carloslfu/slotstream/issues/54#issuecomment-6171643768). Its body and the still-open state are verified and archived. No inference default, installed CLI or release changed. The only source edit corrects stale lookahead comments; all noncomment lines are identical. The six payload/runtime validations, binary/helper identities, archive hashes and process cleanup pass.
