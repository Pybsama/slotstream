---
type: measurement
id: 01m5vjnzhf2fwm8w0njdpdw0bs
created: 2026-10-26T07:44:28.719844+00:00
updated: 2026-10-26T07:44:28.719844+00:00
summary: Q2 routing work, read issuance and staging ablation
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1915'
runs: '[[sources/runs/2026/10/2026-10-26-q2-routing-and-read-issuance]]'
title: Q2 routing work, read issuance and staging ablation
status: measured
---
The same frozen Q2 inputs do not produce identical internal routes, but the aggregate required expert work is almost equal. This does not explain the remaining speed gap. A clean ablation also finds no repeatable penalty from the rejected early candidate's common staging machinery alone. No production change is retained, Fast remains unchanged and complete-request parity is still open.

This follows [[records/measurements/q2-early-expert-preparation]] and [[records/measurements/q2-required-dependencies-and-preparation]]. New evidence is [[sources/runs/2026/10/2026-10-26-q2-routing-and-read-issuance]].

## First required read is not a new large native delay

Use the previously resolved exact payload ancestry, including useful forecast reads. For a job with a required read beginning after job creation, measure creation to its first such read. The union is 0.246050/0.235274 seconds native versus 0.278348/0.257226 seconds Splash in the two observed rounds. Almost all lies outside recorded GPU encoder intervals. The corresponding native medians are 51.5/49.4 microseconds versus 15.3/14.5 upstream, but Splash has a longer tail; choosing only the median would misrepresent the aggregate.

The boundaries differ: native C job creation versus Splash load entry. Neither is a shared router-ready timestamp, and the first required read can be a forecast. This comparison does not establish equivalent handoffs, recoverable idle time or an advantage for native scheduling. It fails to expose a larger native aggregate delay after these particular job boundaries. The earlier unresolved interval before job creation remains relevant.

## Isolate the rejected candidate's common machinery

The original early-preparation ABBA slowed draft and commit phases too, even though it directly changes expert verification. Across that protocol, mean extra phase time is about 0.062 seconds draft, 0.146 verification and 0.009 commit. That makes a single padded-kernel explanation insufficient.

Run the same final candidate binary with early preparation disabled. This keeps its common staging-owner accounting and compiled layout while taking the normal schedule. All 111 full-logit hashes, proposals and selected tokens match v68 under Metal validation; early prepared/refused/bound counts and final live reservations are zero. One ABBA, each process with one warmup and two observed rounds, passes all environmental and physical-memory guards.

| Arm | Mean observed cycle time, s |
| --- | ---: |
| Baseline forward | 11.540983 |
| Disabled candidate forward | 11.426069 |
| Disabled candidate reverse | 11.360658 |
| Baseline reverse | 11.308726 |


Candidate/baseline ratios are 0.990043 forward and 1.004592 reverse, pooled 0.997244. Direction reverses and the pooled difference is under one percent. This does not establish a common-machinery slowdown or a retained improvement. It does not overturn the original early-scheduling rejection or justify keeping its extra complexity.

## Compare the work actually routed

Both engines execute the same 111 frozen cycles with real draft proposals, fixed target inputs/retained prefixes, BF16 activations/KV, FP32 recurrence and 4,067 expert slots. The capture uses existing CPU-visible values, without additional GPU waits or the public native observer that changes execution policy. Each instrument exactly matches its own full-logit, proposal and selected-token reference. Both are clean and remain below the 15 GB physical ceiling.

Native records ranked IDs plus a histogram and pre-demand residency. Splash exposes grouped descriptors, so compare their expert counts, not invented per-token ranks. Forecast lists preserve their order. There are 5,328 current route events and 5,217 forecasts per engine. Splash passes eight capacity rows and masks inactive rows; native passes the actual one-to-eight rows. Assert every current histogram against the frozen active width. Equal live expert rows do not imply identical GPU launch geometry or full arithmetic.

| Observed work | Native | Splash |
| --- | ---: | ---: |
| Actual expert-row selections | 226,560 | 226,560 |
| Unique demanded experts | 144,844 | 144,862 |
| Cache misses | 45,487 | 45,452 |
| Forecast candidates | 138,878 | 138,911 |
| Nonresident forecast candidates | 53,377 | 53,335 |
| Current misses covered by a forecast | 25,859 | 25,801 |


Native has only 35 additional cache misses out of roughly 45,000. Its route sets differ in 1,508 layer passes, with 1,473 native-only versus 1,491 Splash-only expert selections. Those substitutions nearly balance; they do not establish a large increase in required SSD work. Both forecasts cover about 25,800 actual misses, with nearly equal useful-candidate rank. The full ordered prediction lists differ in 3,919 events, so do not call the executions internally identical.

This capture adopts 20,237 forecast records natively and 22,339 in Splash; demand supplies 25,250 versus 23,113. Read readiness and ownership handoff still differ despite similar possible coverage. These are instrumented work counts, not representative timing controls or proof that all extra demand reads delay the critical path. The already tested started-forecast candidate removes duplicate reads, but its prior request protocol is excluded and offers no qualified gain; see [[records/measurements/q2-started-forecast-reuse]] and [[records/measurements/q2-forecast-requests-and-mask-reuse]]. Do not substitute the adoption-count difference for evidence supporting a shared-reader rewrite.

Across the own-reference files, 34 of 777 draft IDs and one of 384 selected target IDs differ between engines. This is a numerical implementation difference, not by itself a semantic quality regression or an explanation for required work. Own-reference exactness is deliberately distinct from cross-engine identity.

## Preserve the remaining question

An offline join of the prior dependency trace places only 0.039/0.031 seconds of residual time before encoders containing native expert combination, with less than two milliseconds before their construction. Earlier combination submission therefore lacks a large measured opportunity in this trace. It is not implemented speculatively. These following-encoder categories can overlap and locate intervals rather than prove causes.

The larger known residual remains before expert encoder construction, including route synchronization and host preparation. The failed early-submission experiment demonstrates that simply moving preparation earlier does not solve it. The next useful comparison should resolve that specific transition under matched actual route/cache work, separating event readiness, host wakeup and metadata/submission work. Keep already rejected broad graph, polling and reader changes rejected unless new causal evidence changes their case.

All 509 runtime source inputs and five default artifacts remain v68. No Fast performance change, Smart promotion, release or app-readiness claim follows. Fast recall and Q2 strict-format failures stay separate. The latest clean ordinary-request comparison remains about 9.4 percent slower for code and 6.1 percent for prose; this diagnostic does not replace it. The parity goal remains active and incomplete.
