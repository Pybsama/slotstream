---
type: measurement
id: 01m5vy0s942qdyf0eyph9tbzc5
created: 2026-10-26T11:02:37.092570+00:00
updated: 2026-10-26T11:02:37.092570+00:00
summary: Q2 completion cleanup is too small to explain the remaining gap
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1919'
runs: '[[sources/runs/2026/10/2026-10-26-q2-completion-cleanup]]'
title: Q2 completion cleanup is too small to explain the remaining gap
status: measured
---
MLX completion cleanup and its output-map mutex do not account for a meaningful part of the remaining Q2 slowdown. Keep this path unchanged. This closes the specific coverage gap from [[records/measurements/q2-controlled-read-latency]]; evidence is [[sources/runs/2026/10/2026-10-26-q2-completion-cleanup]].

The bounded diagnostic preserves container copy/move ownership and destroys the whole original container at the original capture-lifetime boundary, including bucket storage. It brackets callback bodies, temporary arrays, captured data owners, fence/output sets, event vectors and the existing submission/completion mutex. A standalone lifetime and known-contention check passes. Under Metal validation, all 111 full-logit hashes, proposals and selected IDs match the native reference.

At 15 GB, 8,192 context and 4,067 actual expert slots, the original-baseline/new-instrument off/on/on/off control measures 11.4111/11.5309/11.5705/11.4394 seconds. Both directions pass the two-percent sensitivity bound; the pooled instrument cost is 1.10 percent. All environmental gates pass. Each process has one warmup and one measured 111-cycle round. This is frozen complete-cycle diagnosis, not normal adaptive request qualification.

Both instrumented rounds resolve every one of 5,328 required jobs. Request-thread destruction totals 11.26/12.05 milliseconds, with only 0.970/0.981 milliseconds outside the union of recorded GPU work and actual required-read dependencies. Output-map acquisition waiting totals 0.285/0.396 milliseconds; only 0.033/0.031 milliseconds lie outside that union. No request-thread wait overlaps a recorded background holder of the same mutex. Background destruction covers 130.1/128.3 milliseconds, of which 46.2/44.7 lie outside that union. Concurrent background work is not request waiting. Nested intervals are unioned, never added.

The recorder covers cleanup that starts during the measured request; it drains already-active writes afterward. Later-starting cleanup is unmeasured. Recorded GPU intervals are not kernel utilization, and this result does not prove every reference-management operation free. It rejects this concrete cleanup/mutex hypothesis as the large direct cause. No allocator, fence, buffer-pool or ownership rewrite is justified.

The next useful observation is normal adaptive requests with aligned forecast-only reads, preserving the original demand path and cache capacity. That candidate has exact arithmetic evidence but has never completed ordinary request qualification. Its old component protocol remains paging-excluded, and its original conditional follow-up remains unrun. A separately frozen ordinary-request experiment directly tests the missing user-facing question; it must not reinterpret that excluded prerequisite as passed or reuse favorable historical timing arms. The independent Splash extra-copy intervention motivates this scope after the reader, delay and cleanup hypotheses failed to explain enough of the gap.

Fast remains unchanged. Existing Fast recall and Q2 strict-format failures stay separate; no release or Smart-default promotion follows.
