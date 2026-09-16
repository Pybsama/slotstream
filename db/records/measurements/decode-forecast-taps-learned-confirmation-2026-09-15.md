---
type: measurement
id: 01m2n6t41x8yzvtvdd68wb9y79
created: 2026-09-16T13:34:29.437097+00:00
updated: 2026-09-16T13:38:53.185984+00:00
summary: 'Held-out confirmation at 20 GB: corrected over attention 1.031 (bootstrap 1.013 to 1.041), kinds 1.025 to 1.055, 30 of 30 pairs with identical outputs; every condition passes'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Registered held-out confirmation against the attention tap, not against the shipped configuration; cited by docs/EXPERT-LOOKAHEAD.md.
order: '1472'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-learned-confirmation-20gb]]'
title: 'Decode forecast taps, step 9: the learned correction passes its held-out confirmation at 1.031 over the attention tap'
status: measured
---
**Outcome: on ten held-out prompts from corpus families no earlier run had used, the learned correction decodes at 1.031 over the plain attention tap (bootstrap 1.013 to 1.041), every kind at 1.025 or above, three counted pairs per prompt, every output identical: the confirmation passes every registered condition.** Step 9 of [[records/plan/decode-forecast-taps-2026-09-14]]; run [[sources/runs/2026/09/2026-09-15-forecast-taps-learned-confirmation-20gb]].

**Prompts.** The B0 and B1 sets had informed decisions and the correction was trained on the pilot's training requests, so the prompts come from the 36 training-split families that no capture, fit, screen or cohort had used (code 16, reasoning 8, prose 6, dialogue 3, structured 3; no multilingual family remains): for each kind, its sorted family names shuffled with a fixed seed, the first two families, and from each the request with the smallest id: r0026, r0050 (code), r0304, r0292 (dialogue), r0186, r0195 (prose), r0156, r0128 (reasoning), r0268, r0271 (structured). A scan of 16,983 run files found requests from these families only in a copy of the corpus file itself.

**Run.** Three rounds at 512 outputs with a 128-token warmup at 20 GB (30.6 GB reclaimable at launch), the attention tap first and arm order alternating, 05:18 to 06:41 on 2026-09-15. No arm had a host swap-out, no arm window held a compiler, linker or second engine, and the Sevra app peaked at 6.1% CPU, so all 30 pairs counted under both readings.

| kind | tok/s ratio | duration ratio | prompt medians (counted pairs) |
| --- | ---: | ---: | --- |
| code | 1.027 | 0.988 | r0026 1.047 (3), r0050 1.008 (3) |
| dialogue | 1.026 | 1.012 | r0304 1.023 (3), r0292 1.028 (3) |
| prose | 1.025 | 0.991 | r0186 1.020 (3), r0195 1.029 (3) |
| reasoning | 1.025 | 0.977 | r0156 1.017 (3), r0128 1.034 (3) |
| structured | 1.055 | 0.971 | r0268 1.042 (3), r0271 1.068 (3) |

| condition | required | result |
| --- | --- | --- |
| identical outputs | every pair | 30 of 30 |
| aggregate ratio, equal kind weight | at least 1.02 | 1.0314 |
| bootstrap 2.5th percentile | above 1.00 | 1.0132 (median 1.0312, 97.5th 1.0409) |
| kind floor | at least 0.97 | 1.0245 (prose) |
| kind duration ratio | at most 1.02 | 1.012 (dialogue) |
| counted pairs per prompt | at least 2 | 3 for every prompt |

29 of 30 pairs were above 1 (r0304 in round 2 at 0.910). Median decode throughput over the pairs was 14.64 tok/s with the attention tap and 15.14 with the correction. Paired medians, corrected over attention: records read in decode 0.907, decode seconds 0.972, reads issued 0.922, adopted 1.084, expired unused 0.525, wasted bytes 0.523, demand misses 0.903, forecast evaluation seconds 0.996. Over these pairs demand reads take about 30% of decode time; the correction cut records read in decode by 10% and demand-read time by about 7%, which is the 3.1%.

**Standing.** This is the correction's own confirmation, against the attention tap and not against the shipped configuration; the direct measurement against the shipped configuration is [[records/measurements/decode-forecast-taps-readout-timing-confirmation-2026-09-15]]. Limits: one machine, one checkpoint, the 20 GB profile, no multilingual prompt, and a correction trained on the pilot's training requests.
