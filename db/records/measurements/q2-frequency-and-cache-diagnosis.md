---
type: measurement
id: 01m5tevb0xgk4pz30rp7cdav2g
created: 2026-10-25T21:18:15.581170+00:00
updated: 2026-10-25T21:18:15.581170+00:00
summary: Q2 streaming interaction and passive GPU frequency
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1901'
runs: '[[sources/runs/2026/10/2026-10-25-q2-frequency-and-cache-diagnosis]]'
title: Q2 streaming interaction and passive GPU frequency
status: measured
---
Q2 complete-request parity remains unachieved. No production change is retained and Fast remains unchanged. The clean control localizes an additional slowdown to partial misses combined with read-ahead; it does not establish the underlying scheduler or hardware cause. This follows [[records/measurements/q2-decoder-and-metadata-diagnosis]]. Raw evidence and individual exclusions are in [[sources/runs/2026/10/2026-10-25-q2-frequency-and-cache-diagnosis]].

## Exact-window observations and tracing control

The existing rootless macmon monitor works without administrator access. Its 200 ms whole-device samples are aligned to exact frozen verification windows. The first NSSN adds symmetric named GPU-stage/read observations. Native's measured stage intervals total about 7.51 and 7.23 seconds at stage-weighted frequencies around 711 and 749 MHz. Splash totals about 5.01 and 4.93 seconds around 1,374 and 1,410 MHz. Both native arms record global swap-ins, excluding the whole timing protocol. These are localization observations, not a qualified speed comparison or proof of GPU utilization.

A second NSSN removes both injected observers. Native verification-window frequencies remain about 776 and 704 MHz; Splash observes about 1,384 and 1,286 MHz. Shifting sample boundaries by one interval does not remove the frequency separation. One Splash arm records four global swap-in pages, so this whole timing aggregate is also excluded. The repeated association without injected tracing argues against tracing alone causing the low native frequencies. It does not establish clock frequency as an independently controllable cause of the complete-request gap.

## Clean cached and controlled-miss comparison

Both engines replay the same four-row input at the same prefix, with BF16 activation/KV, FP32 recurrent state, 8,192 context and 4,067 slots under a 15 GB ceiling. The partial condition discards the same 393 common routed keys before each pass. Each condition has two warmups and 64 measured passes; process order is NSSN. All four arms pass the complete guard protocol. Native peaks at about 11.63 GB and Splash at about 12.65 GB; sampled headroom stays above 11 GB.

Every native full logit hash equals the previous reference, and every Splash pass retains its separate exact reference. The native diagnostic changes only the test command and eviction seam. No inference kernel, cache capacity, precision or Fast path changes.

| Condition | Native median pass ms | Splash median pass ms | Native observed MHz | Splash observed MHz |
| --- | ---: | ---: | ---: | ---: |
| Cached, read-ahead off | 39.59 | 39.41 | 1,601 | 1,606 |
| Partial misses, off | 94.06 | 94.36 | 1,418 | 1,484 |
| Cached, on | 40.84 | 38.92 | 1,603 | 1,603 |
| Partial misses, on | 111.39 | 96.03 | 630 | 917 |

Each row reports the median of the two process medians, rather than treating repeated passes as independent machines. Frequencies are weighted over the measured verification intervals. Cached/off is effectively equal. Demand-only partial misses are also effectively equal. Partial/on leaves native about 16% slower in this controlled workload and shows a deeper frequency reduction in both native processes. Both engines slow as that sustained condition continues; Splash also enters the lower-frequency regime.

Cached/on still issues unused forecasts. It is not a pure compute control. Native partial/on adopts roughly half its demanded records, preserving exactly 393 logical misses per pass. Demand counts alone therefore cannot explain elapsed time, and adoption is not automatically a useful-work speedup.

## What this establishes and what remains open

A general native arithmetic or demand-read deficiency does not explain this particular controlled gap: those isolated controls match. The interaction among streaming forecasts, useful GPU work and execution rate is the stronger remaining lead. A frequency reading is an outcome of the workload and OS scheduling, not proof of a defective governor, GPU idleness or a reason to force higher clocks.

The fixed condition order is a remaining confound. Partial/on follows cached/on, and the longer sustained replay differs from the earlier short controls. GPU temperature falls during partial/on as observed GPU power falls, but nominal thermal state and these temperatures cannot exclude other power-management effects. Counterbalance that phase order before assigning causality to the read-ahead transition.

Do not remove read-ahead based on this single-state control. The clean evolving continuation in [[records/measurements/q2-continuation-and-copy-diagnosis]] found that it helps both engines. Complete adaptive requests remain the adoption gate. The rejected decoder, direct-copy, delayed-submission, priority and reader-count experiments do not become qualified because this new association is suggestive.

The next bounded experiment should separate sustained phase/order effects from the forecast/readiness interaction while preserving the same useful work, actual slots and exact logits. Then change only the demonstrated source of delay and compare complete requests against v68 and published Splash. Do not add power tricks, broaden the port, or rewrite a shared reader on the strength of clock association alone. Existing Fast recall and Q2 formatting failures remain separate app-quality gates.
