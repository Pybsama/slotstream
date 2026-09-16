---
type: measurement
id: 01m2n6t3zs35kjwt5gcdzfzc60
created: 2026-09-16T13:34:29.369195+00:00
updated: 2026-09-16T13:34:29.369195+00:00
summary: 'Co-routing prior from the previous layer''s routed experts: +0.0032 agreement and +0.0094 twin coverage against 0.03 bars; negative, no native diagnostic'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Offline only, CPU, registered before any number existed.
order: '1466'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-coroute-prior]]'
title: 'Decode forecast taps, step 5: the co-routing prior fails its offline gate'
status: measured
---
**Outcome: negative. A co-routing prior built from the previous layer's routed experts, which the host holds when the attention tap's forecast arrives, raises leave-one-request-out top-10 agreement by 0.0032 and matched-traffic twin coverage by 0.0094 against registered bars of 0.03 each, so no native diagnostic was built.** Step 5 of [[records/plan/decode-forecast-taps-2026-09-14]]; run [[sources/runs/2026/09/2026-09-15-forecast-taps-coroute-prior]]. CPU only, run between two rounds of the taps screen so no timed cell overlapped it.

A per-layer pointwise mutual information table over pairs (expert routed at T-1, expert routed at T) was counted on the pilot's 56 training requests (4,180 verify passes, 12,540 rows per layer, alpha 20 smoothing as registered) and used to rescore the tap's 24 recorded candidates on the 13 validation requests as margin plus beta times the summed PMI over T-1's ten routed experts.

| beta | top-10 agreement | exact top-10 | recall at 16 |
| ---: | ---: | ---: | ---: |
| 0 (the tap) | 0.7292 | 0.0530 | 0.8565 |
| 0.02 | 0.7323 | 0.0465 | 0.8612 |
| 0.05 | 0.7019 | 0.0272 | 0.8421 |
| 0.1 | 0.6652 | 0.0139 | 0.8223 |
| 1 | 0.5869 | 0.0023 | 0.7817 |

Leave-one-request-out chose beta 0.02 in every fold (0.7323); alpha 5 gives 0.7251 and alpha 80 gives 0.7346. In the twin at the shipped setting's 284,812 issued reads, coverage is 0.5397 for the tap and 0.5490 with the prior, with 3,165 fewer wasted reads. Agreement peaks at the smallest nonzero beta and falls below the tap from 0.05 on, and exact rows fall at every nonzero beta: consistent with T-1's routes carrying little about T's choices beyond what the tap already reads from the same streams, though this probe does not test that explanation. The next accuracy step was the learned correction.
