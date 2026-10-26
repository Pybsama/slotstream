---
type: run
id: 01m5t51qkt46k88ymaa0sv5ay0
created: 2026-10-25T18:26:59.321892+00:00
updated: 2026-10-25T18:27:00.500112+00:00
summary: Q2 adaptive-cost replay and demand-shape diagnosis
binary: Pinned diagnostic builds and unchanged v68 baseline
captured_at: 2026-10-25
command: Exact commands and source identities in archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 adaptive-cost replay and demand-shape diagnosis
tool: Native Swift/MLX/Metal and offline trace analysis
---
Evidence: [q2-cost-and-demand-diagnosis-2026-10-25.tar.gz](q2-cost-and-demand-diagnosis-2026-10-25.tar.gz), 110 files,
8162219 bytes, SHA-256 `a499a8b99ec28775e5b75ac4243d4fb009c13f43e2f9c0dd15b52417053f90cf`. Every member passes hash readback
and credential-pattern screening. The archive includes source snapshots,
build identities, guards, commands, traces, analyses and preserved harness
failures. Prior large read traces are referenced by verified archived hashes
in reference/prior-inputs.json; their source archive is linked from
[[sources/runs/2026/10/2026-10-25-q2-continuation-diagnostics]].

A 15 GB cost-trace launch is refused before loading a model because reclaimable
memory is below the required 18 GB. The pre-result amendment uses 12 GB and
1,892 actual slots, with 15 GB reclaimable preflight. One frozen-choice AB and
one ordinary-adaptive AB preserve all arms. Both use original copies versus
aligned direct reads in the same padded diagnostic executable. Every frozen
request matches captured ordinary outputs and core verification work. All
four model processes pass memory, headroom, paging and external-build guards.
Trace-enabled timing is not production speed qualification or 15 GB evidence.

The actual Swift policy replays all 2,290 recorded snapshots exactly. A typed
JSON decoder fixes an initial diagnostic parser's one-ULP coefficient change;
the original failures and strict equality gate remain. Counterfactual omission
of the preparation sample holds all observed work and labels fixed. It is not
an alternate execution or a speed prediction. The earlier v60 omission
experiment remains timing-excluded and rejected.

Offline accounting uses the prior paging-excluded symmetric physical-read
trace. Duplicate extents are observations, not causal wall-time losses.
Native and Splash demand counters have different semantics, documented in
read-traffic-accounting.json. Both filter resident forecast candidates.

A later 15 GB native demand observer captures the actual 111-pass continuation,
two rounds, 4,067 slots, 8,192 context. All 222 full-logit hashes match v68;
all gates pass. In the measured round only 14 of 5,328 layer demand events
cross 32 records after forecast adoption. Their complete host spans total
66.418 ms. The existing batching is retained; no batch-size experiment runs.

All 509 runtime inputs and five default artifacts match v68 after restoration.
Fast and production behavior are unchanged. These are diagnostic/functional
results, not broad model quality, app qualification or a release.
