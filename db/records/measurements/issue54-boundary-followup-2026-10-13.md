---
type: measurement
id: 01m4v0q2f9a88az7swysmh00ne
created: 2026-10-13T16:14:48.297223+00:00
updated: 2026-10-13T16:14:48.297223+00:00
summary: Issue 54 remains unverified after expanded path probes; full-model attempt refused before launch for insufficient headroom
date: 2026-10-13
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1810'
runs: '[[sources/runs/2026/10/2026-10-13-issue54-boundary-followup]]'
title: Issue 54 expanded boundary audit and full-model reproduction gap
status: measured
---
**Status.** We have not reproduced the reporter's threefold full-model slowdown, have not established its cause, and have not demonstrated that v0.2.29 fixes it. The release could already remove the cause through keepalive removal; neither the prior attention test nor this broader component test answers that question. Keep [issue #54](https://github.com/carloslfu/slotstream/issues/54) open. The earlier [[records/measurements/issue54-context-boundary-triage-2026-10-12]] remains limited evidence, not an end-to-end diagnosis.

**What was actually tried.** [[sources/runs/2026/10/2026-10-13-issue54-boundary-followup]] preserves the expanded source audit, component measurements and a full-model reproduction attempt against the exact published v0.2.29 executable. That attempt stopped at its preflight: 11.63 GB reclaimable versus a 12 GB requirement for a fixed 9 GB target. No server launched, no prompt ran, and there is no decode result. This is a measured resource refusal, not a failed reproduction or proof that the bug disappeared. Smaller planner probes did not admit the requested above-32k window. No other application was closed and no memory guard was bypassed.

The frozen full-model protocol keeps the reporter's original model, MTP off, templated German repetition prompt, temperature zero and 500 requested output tokens. It samples 10,750 and 10,900 repetitions with a 36,864 configured window. Vision is disabled, memory is bounded to 9 GB, and prefill is bounded to 256 tokens. Those resource differences and the local M5 Pro mean even a completed run would be an exploratory reproduction, not the reporter's M4 Pro 40 GB-target configuration. Existing benchmark metadata captures the actual prompt/output IDs, inter-token intervals, I/O, allocations and process observations. A later run needs a fresh output directory and identity/memory checks rather than overwriting this refusal.

**Relevant execution paths.** Audited public release source `5728fc2`, comparing v0.2.27 and current main where necessary. Main's later ready-overlap prototypes are not evidence about the published executable.

| Path | Boundary and implication | Evidence limit |
| --- | --- | --- |
| One-query MLX vector attention | On the applicable `s` GPU architecture branch, partition count changes from 256 to 512 at 32,769 keys. | Plausible sustained dispatch change; no threefold component slowdown measured on this M5 Pro. |
| QSA indexer selection | Four-token compression means 8,193 blocks at 32,772 keys. MLX implements `argPartition` by sorting; this changes four sort blocks to five and adds a merge stage. | Newly identified lead missed by the attention-only probe. Reporter points cannot distinguish 32,769 from 32,772. |
| KV and indexer backing storage | Grows in 1,024-row steps, including at 32,769. Capacity changes strides and can temporarily retain old and new allocations. | New component probe uses capacity-backed KV views. Actual cache mutation and process pressure still need a full-model run; growth alone does not explain a permanent slower mode. |
| Context planning and allocation guards | 32,768 is a fixed-footprint baseline, and larger configured windows reserve more memory before serving. Actual dispatches also check allocation/headroom. | No intentional slower decode tier found. Cannot exclude runtime memory pressure or driver behavior from static inspection. |
| Prefill and experimental selection | `SelectedAttention`'s 32,768-key guard requires more than eight query rows. Experimental block selection is off by default. | Neither is the ordinary one-query decode branch; prefill performance is excluded from the reporter's decode metric. |
| MTP and expert residency | MTP is explicitly off; a fixed memory target pins the expert pool. The reporter also tested no-elastic and a larger fixed pool. | Speculative verification is not the reported path. Full-model routing, I/O waits and cache behavior remain unmeasured locally for this workload. |
| API metrics and prefix reuse | `eval_duration` is timed over decode, separate from prefill. Prefix reuse affects prompt processing; non-streaming output avoids streamed-client stalls. The 32,768 output ceiling is a response-length ceiling, not active context. | Need actual per-token intervals to distinguish a one-time stall from a sustained change and actual output lengths to confirm boundary crossings. |

The pinned MLX dependency, deployment optimization configuration, attention wrapper, experimental selectors and context constants are unchanged between v0.2.27 and v0.2.29. Original-model indexer/cache implementation has no targeted boundary fix in that comparison. Keepalive removal is relevant, but inspecting a diff cannot certify the user's outcome.

**Broader component probe.** Production-shaped synthetic score computation, reference partition, mask assembly and attention were run separately and together. It covers 32,320, 32,767, 32,768, 32,769, 32,771, 32,772, 32,776 and 33,070 keys, with four alternating sweeps and thirty evaluations after five warmups. The combined mask/attention median is approximately 0.416 ms at 32,768 and 0.470 ms at 32,769; reference partition is approximately 0.185 ms at 8,192 blocks and 0.191 ms at 8,193. This does not reproduce the reported threefold complete-model cliff. Every mask has the expected cardinality, all observed outputs are finite, peak tracked MLX allocation is about 212 MB, and global paging counters stay unchanged. These live-desktop Python timings are excluded from clean performance qualification. Synthetic operands, finite outputs and mask counts do not establish model parity or M4 behavior. The probe excludes projection, pooling/normalization/rotary preparation, cache writes, expert I/O and full generation.

**Next experiment and communication.** Once real headroom clears, execute the frozen public-release workload and inspect per-token timing on both sides, completed output, actual memory, I/O and routing. A same-configuration v0.2.29 retest on the reporter's M4 Pro remains the direct check of whether keepalive removal already resolved it. If the cliff persists, distinguish attention's 32,769 boundary, indexer sorting's 32,772 boundary and storage growth with tightly spaced active-token samples, then isolate the responsible operation on that hardware. Do not recommend `MLX_SDPA_BLOCKS`, enable an experimental selector, delete another feature or announce a fix without causal and completed-request evidence. No additional GitHub comment is needed while the existing retest request is unanswered and no end-to-end result is available.

**Investigation lesson.** A component probe is useful to isolate a mechanism but cannot stand in for reproducing the user's workload. Record separately whether a test was planned, refused before launch, executed, reproduced the symptom, or verified a fix. A matching numeric threshold is a lead; follow every applicable operation around it before promoting it to the explanation.
