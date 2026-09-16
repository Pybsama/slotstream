---
type: measurement
id: 01m2n6t42hy8kgjp6w5x28qr2n
created: 2026-09-16T13:34:29.457715+00:00
updated: 2026-09-16T13:38:52.422799+00:00
summary: 'Lower issue thresholds at 16 GB: 0.031 reads 1.015 on the first twelve pairs, below the 1.02 confirmation bar, and 0.0 reads 0.994; outputs identical; the 0.062 threshold stays'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Mechanism screen at a forced 16 GB profile; cited by docs/EXPERT-LOOKAHEAD.md.
order: '1474'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-threshold-screen-16gb]]'
title: 'Decode forecast taps, step 10: a lower issue threshold does not earn a confirmation'
status: measured
---
**Outcome: with the correction on, a lower issue threshold does not earn a confirmation. At 0.031 the screen reads 1.015 on the first twelve counted pairs (10 above 1) and 1.013 over 16, below the registered 1.02 bar; at 0.0 it reads 0.994: every top-10 read issued arrives late and wastes 2.4 times the bytes. The threshold stays at 0.062.** Step 10 of [[records/plan/decode-forecast-taps-2026-09-14]]; run [[sources/runs/2026/09/2026-09-15-forecast-taps-threshold-screen-16gb]].

**Why it was tried.** With the correction, issued reads are adopted at a median 0.83 against the attention tap's 0.70, and the twin's threshold curve for the corrected forecast gives coverage 0.543 at 0.062, 0.582 at 0.031 and 0.670 at 0.0 with no traffic bound, while decode serialization round 2 had found natively that extra speculative reads did not reduce demand reads for the boundary forecast ([[records/measurements/decode-path-serialization-round-2-2026-09-12]]).

**Run.** Another session's virtual machine held 9 GB at launch, leaving 22.35 GB reclaimable, so the screen ran at 16 GB as a mechanism screen (an expert cache of 2,746 slots against 4,206 at 20 GB, hit rates about 0.57 against 0.70). Arms identical except the threshold: t062 (reference), t031 and t000, on r0005, r0206, r0096 and r0074 at 256 outputs under the contention rule, rounds until 12 counted pairs per candidate. The Sevra app took the model lock at 13:50 and the sweep stopped at its 35th cell; it resumed at 14:28 and ran a fourth round, ending 14:47. 48 cells, 47 counted (one host swap-out exclusion), every output identical.

| candidate | counted pairs | first-12 ratio | above 1 of 12 | all-pairs ratio | above 1 | reading |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| t031 (0.031) | 16 | 1.015 | 10 | 1.013 | 13 | passes the screen reading, below the 1.02 confirmation bar |
| t000 (0.0) | 15 | 0.994 | 6 | 0.992 | 6 | fails |

Median counters per counted cell, t062 then t031 then t000: records read in decode 17,780, 15,960, 10,670; reads issued 32,270, 36,510, 44,080; expired unused 3,832, 5,356, 9,033; wasted bytes 10.6 GB, 14.9 GB, 25.1 GB; reads still in flight when demanded 4,610, 5,978, 10,702; join seconds 0.074, 0.107, 0.365. Issuing every candidate cuts demand reads by 40% and still slows decode: the extra reads arrive late (twice the in-flight reads at demand time, five times the join time). The middle threshold buys a small, consistent gain that shrank over the rounds (1.026 in round 0, 1.005 in round 3) and would likely be smaller at 20 GB, where demand reads are rarer. The lever closes at this result.
