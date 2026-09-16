---
type: measurement
id: 01m2n6t3y98e4eecmh8qhbsgzr
created: 2026-09-16T13:34:29.321276+00:00
updated: 2026-09-16T13:34:29.321276+00:00
summary: Attention tap offline gate 0.7292 against 0.6171 agreement, twin coverage 0.539 against 0.439; native screen at 18 GB 1.054 on the first twelve pairs with identical outputs; the confirmation runs
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Offline audit and twin on the 13 validation requests, then a mechanism screen at a forced 18 GB profile on four exploration prompts; decides only whether the confirmation runs.
order: '1462'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-offline-stage]], [[sources/runs/2026/09/2026-09-15-forecast-taps-screen-18gb]]'
title: 'Decode forecast taps, steps 1 and 2: the attention tap passes its offline gate and the 18 GB screen'
status: measured
---
**Outcome: forecasting from the streams after the previous layer's attention, at the same lead time as the shipped forecast, raises offline top-10 agreement from 0.6171 to 0.7292, and the native screen at 18 GB decodes 1.054 over the qualified configuration on the first twelve counted pairs with identical outputs, so the B1 confirmation runs.** Steps 1 and 2 of [[records/plan/decode-forecast-taps-2026-09-14]].

**Where the forecast reads.** The shipped forecast for target layer T applies T's own hyper-connection read and router to the streams after layer T-2's expert add, and reaches the scheduler on layer T-1's routing readback. At that readback the streams already hold T-1's attention output, so a forecast built on them (the `attention` tap) arrives just as early and misses only T-1's routed experts and T's attention; `attention-shared` adds T-1's resident shared expert. The capture command records any tap without a scheduler, and `SLOTSTREAM_EXPERT_PREFETCH_TAP` selects one for the router policy.

**Offline gate** ([[sources/runs/2026/09/2026-09-15-forecast-taps-offline-stage]]): the 13 pilot validation requests captured at a 10 GB target with every tap as an observer, 141,450 rows over targets 2 to 47.

| forecast | top-10 agreement | exact top-10 | recall at 16 | twin coverage at the shipped traffic | wasted reads |
| --- | ---: | ---: | ---: | ---: | ---: |
| boundary, stride 2 (shipped) | 0.6171 | 0.0223 | 0.7389 | 0.4389 | 136,416 |
| attention tap | 0.7292 | 0.0530 | 0.8565 | 0.5393 | 102,443 |
| attention tap with the shared expert | 0.7398 | 0.0603 | 0.8655 | 0.5492 | 99,104 |
| boundary, stride 1 (one attention block late) | 0.7619 | 0.0885 | 0.8819 | 0.5785 | 89,203 |

The gate asked for agreement at least 0.03 above stride 2 and matched-traffic coverage at least 0.03 above the shipped setting with no more wasted reads; the attention tap passes both by a wide margin. The shared-expert variant added 0.0099 of coverage against the registered 0.01 margin, so the plain attention tap went forward by rule. Adding the tap to the stride-2 forecast was below the tap alone at matched traffic.

**Native screen at 18 GB** ([[sources/runs/2026/09/2026-09-15-forecast-taps-screen-18gb]]): the qualified configuration set explicitly (`combined`) against the same with each tap, on r0005, r0206, r0096 and r0074 at 256 outputs, interleaved. The 20 GB profile needed 25 GB reclaimable and 23.65 GB was available, so the screen ran at 18 GB as a mechanism screen. A first attempt stopped when `docs/LIBRARY.md` had been edited since the corpus froze; the corpus tool now reads every code and prose source from the git blob recorded at freeze. Another session compiled and ran its app on the same Mac, so a contention rule was registered before the screen resumed: a sampler records compiler, linker and engine processes every 5 s, a cell whose window holds one is excluded, and rounds are added until each arm has 12 counted pairs. Four rounds, 48 cells, every output identical to its reference.

| configuration | counted cells | median tok/s | paired ratio (all pairs) | first 12 pairs | above 1 of 12 |
| --- | ---: | ---: | ---: | ---: | ---: |
| combined (reference) | 15 | 11.26 | | | |
| attention tap | 15 | 11.97 | 1.047 (14) | 1.054 | 11 |
| attention tap with the shared expert | 14 | 12.15 | 1.077 (14) | 1.078 | 11 |

The reading needed a paired ratio of at least 1.01 with at least 8 of the first 12 pairs above 1 for the tap chosen offline; the attention tap passes. Mechanism, medians over pairs: records read in decode 0.869, reads issued 0.898, adopted 1.140, expired unused 0.563, wasted bytes 0.562. A screen decides only whether the confirmation runs; its ratios are not claims.
