---
type: measurement
id: 01m5vr2695x1cjp56df19pxgrs
created: 2026-10-26T09:18:31.717740+00:00
updated: 2026-10-26T09:18:31.717740+00:00
summary: Q2 allocator diagnostics and read-latency variance
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1917'
runs: '[[sources/runs/2026/10/2026-10-26-q2-allocator-waits]]'
title: Q2 allocator diagnostics and read-latency variance
status: measured
---
The allocator investigation does not earn a runtime change. Both probes preserve exact output but fail their timing-sensitivity controls. Existing traces then locate the slow control arm primarily in longer read-completion coverage and lower forecast adoption, rather than a new large interval outside reads/GPU work. This changes the next investigation toward read-latency sensitivity; it does not establish a missing scheduler optimization or solve parity.

This follows [[records/measurements/q2-event-readiness-and-metadata]] and [[records/measurements/q2-mlx-ownership-and-graph]]. Full evidence is [[sources/runs/2026/10/2026-10-26-q2-allocator-waits]].

## Measure actual allocator boundaries

Bracket eight methods in the pinned MLX Metal allocator, preserving its original mutex, cache policy, allocation, unlock/relock, release and buffer lifetimes. Record complete API calls separately from their nested lock acquisition, held and unlock intervals. Track request-owner and background threads separately. A bounded recorder does not change model arithmetic or add GPU work.

The first recorder is undersized for the revised validation's 1,635,211 events and fails without a specific saved error code. Preserve that failure. Both the larger all-thread recorder and the later owner-only recorder pass 111 full-logit/proposal/selected-ID checks under Metal validation. Known two-thread contention self-tests pass. The owner-only revision ignores background spans before accessing counters and separates read-mostly enable state from written counters, reducing potential observer contention. Its background service is intentionally unmeasured.

Each control freezes off/on/on/off, with one warmup and one measured round per process. All arms meet the 15 GB, 4,067-slot and 8,192-context recipe and pass the environmental guards.

| Probe | Off forward, s | On forward, s | On reverse, s | Off reverse, s | Pooled on/off |
| --- | ---: | ---: | ---: | ---: | ---: |
| All threads | 11.491047 | 12.470251 | 11.673155 | 11.340668 | 1.057450 |
| Request owner only | 12.887935 | 11.589894 | 11.415521 | 11.473195 | 0.944349 |


The all-thread direction ratios are 1.085215 and 1.029318. The owner-only ratios are 0.899282 and 0.994973. Both complete protocols fail the two-percent sensitivity gate. The reverse owner-only pair alone cannot rescue the failed aggregate, and none of these ratios is a speed improvement.

For diagnostic context only, the owner-only traces record 6.873/6.715 milliseconds of request-thread allocator-lock waiting, with 2.084/2.071 milliseconds outside recorded reads and GPU encoders. Complete allocator API unions are 0.186830/0.187883 seconds, with about 0.035 seconds outside those intervals. The earlier all-thread observations are of similar scale. These are unqualified instrumented observations, not representative production costs or removable latency. No allocator rewrite, extra buffer pool or callback-ownership port follows. The scope does not cover general CPU allocation, all Swift object lifetime work or driver cleanup outside these allocator methods.

## Locate the slow arm without another model run

Both off arms use the same binary with allocator recording disabled. Their measured rounds have the same required cache misses: 45,109. The slower arm adopts 1,593 fewer forecasts and fetches that many more records on demand, while issuing fewer total successful read bytes. Read completions have a longer tail; no extra required expert work explains it.

| Captured work or coverage | Slow off arm | Later off arm |
| --- | ---: | ---: |
| Cycle wall time, s | 12.858479 | 11.444843 |
| Recorded GPU encoder union, s | 6.196094 | 5.981949 |
| Read coverage outside recorded GPU, s | 5.925194 | 4.703530 |
| Outside both recorded reads and GPU, s | 0.737191 | 0.759364 |
| Forecast records adopted | 17,604 | 19,197 |
| Records fetched on demand | 27,505 | 25,912 |
| Successful read bytes, GB | 87.354 | 89.237 |
| Read-service median, microseconds | 246.542 | 217.917 |
| Read-service p95, microseconds | 1168.375 | 746.625 |


The slow arm adds about 1.414 seconds of cycle wall time. Recorded GPU coverage grows about 0.214 seconds, read coverage outside recorded GPU grows about 1.222 seconds, and the residual outside both shrinks about 0.022 seconds. Summed concurrent read service is 76.285 versus 60.187 seconds; that sum must not be presented as request waiting. The dominant read size is identical at 475,136 bytes, and its observed median also increases. This is evidence of changed read-completion latency alongside lost forecast readiness, not proof of physical SSD throttling, background interference or causality in either direction.

These coverage categories do not prove global GPU idleness or that every outstanding forecast is a required dependency. Failed probe controls remain failed. The paired observation does explain why nominal thermal state, no paging and no competing build are insufficient to guarantee a stable timing control. Do not drop the slow arm or infer a native/Splash speed gap from these native-only runs.

## Best next controlled comparison

Test whether the native forecast handoff amplifies slower read completion. Use bounded frozen verification work, matching cache capacity and precision in both engines, with explicitly controlled read-completion latency. Separate already-started forecasts, ready adoption, actual demand work and critical waiting. Keep shared-reader scheduling a hypothesis until that experiment exposes a meaningful causal delay. Existing started-forecast reuse is only an ablation candidate; fewer duplicated reads or improvement under artificial delay would not qualify it for production. Any retained fix still requires clean, unmodified complete requests against v68 and Splash.

The pinned Splash code owns reusable decode arenas; the native allocator already caches buffers. That implementation difference alone is not a reason to port another arena. Both codebases request uncached expert-file reads, so a missing cache-bypass flag is not established either. The latest clean ordinary-request comparison remains about 9.4 percent slower for code and 6.1 percent for prose. All 509 runtime inputs and five default artifacts remain v68, Fast stays unchanged, and known Fast recall/Q2 strict-format failures remain separate. No parity, Smart promotion, release or app-readiness claim follows.
