---
type: measurement
id: 01m2n6t416eg6052se61f2qc0k
created: 2026-09-16T13:34:29.414056+00:00
updated: 2026-09-16T13:34:29.414056+00:00
summary: 'Corrected tap over the attention tap on the exploration prompts at 20 GB: 1.036 on the first twelve counted pairs (9 above 1), 32 cells with identical outputs; the confirmation runs'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Screen on prompts earlier decisions have seen; decides only whether the confirmation runs.
order: '1470'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-learned-screen-20gb]]'
title: 'Decode forecast taps, step 8: the corrected tap screens at 1.036 over the attention tap'
status: measured
---
**Outcome: the corrected tap screens at 1.036 over the plain attention tap on the exploration prompts at 20 GB, 9 of the first 12 counted pairs above 1, every output identical, so the held-out confirmation runs.** Step 8 of [[records/plan/decode-forecast-taps-2026-09-14]]; run [[sources/runs/2026/09/2026-09-15-forecast-taps-learned-screen-20gb]].

A smoke of one 32-output request per arm at 10 GB first showed both arms starting with identical outputs and the corrected arm's identity naming the file (`correction=37b00d3a32d1e188`). The screen froze at 20 GB with 30.4 GB reclaimable: `attention` against `attention-corrected`, which differs only in the tap, the correction file and the reserve (128 to 164 MiB), on r0005, r0206, r0096 and r0074 at 256 outputs, interleaved, under the contention rule. Host swap-outs made three r0074 cells unclean, so the rule added a fourth round; 32 cells, 29 counted, 13 pairs.

| round | r0005 | r0074 | r0096 | r0206 |
| --- | ---: | ---: | ---: | ---: |
| 0 | 1.047 | excluded | 1.043 | 1.017 |
| 1 | 0.996 | excluded | 1.042 | 1.024 |
| 2 | 0.963 | excluded | 1.086 | 1.290 |
| 3 | 0.928 | 1.040 | 1.001 | 1.033 |

The first 12 counted pairs in round order give 1.036 with 9 above 1 (bars 1.01 and 8); all 13 give 1.036 with 10 above 1. Median tok/s over counted cells: 14.17 for the attention tap, 14.30 with the correction. Median counters per counted cell, attention then corrected: records read in decode 13,760 and 12,370, reads issued 23,870 and 21,020, adopted 15,950 and 17,530, expired unused 5,650 and 2,420, wasted bytes 15.6 GB and 6.7 GB. The screen decides only whether the confirmation runs; its ratios are not claims.
