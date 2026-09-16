---
type: measurement
id: 01m2n6t3z2g8k6fsj49eg7qe6b
created: 2026-09-16T13:34:29.346826+00:00
updated: 2026-09-16T13:38:53.332187+00:00
summary: 'Attention tap on B1 at 20 GB: 1.058 against the qualified configuration (bootstrap 1.031 to 1.088), 36 of 36 outputs identical; fails only the pairs condition after host swap-outs'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Every effect condition passes; the hygiene condition fails. Changed no default; the tap's default evidence came directly from the readout timing confirmation.
order: '1464'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-b1-cohort-20gb]]'
title: 'Decode forecast taps, step 3: B1 at 1.058 against the qualified configuration, not passed as registered'
status: measured
---
**Outcome: on the twelve held-out B1 prompts at 20 GB the attention tap decodes at 1.058 against the qualified configuration (bootstrap 1.031 to 1.088), every family at 1.019 or above, every output identical, but the run does not pass as registered: host swap-outs excluded six pairs and left r0033 with one counted pair, which fails the pairs condition.** Step 3 of [[records/plan/decode-forecast-taps-2026-09-14]]; run [[sources/runs/2026/09/2026-09-15-forecast-taps-b1-cohort-20gb]].

**Registration.** Written 36 seconds after the screen launched and before its first cell finished, the B1 gate for one change inside the qualified configuration: outputs identical in every pair; aggregate paired ratio (median of rounds per prompt, geometric mean per family, equal family weight) at least 1.02; bootstrap 2.5th percentile above 1.00; no family below 0.97; no family duration regression above 2%; at least two clean pairs per prompt. The hygiene rule added before the screen was analyzed counts a pair only when the cohort tool counts it under process-pageins-v1 and neither arm's window holds a compiler, linker or second engine.

**Run.** Three rounds of twelve prompts at 512 outputs with a 128-token warmup, alternating arm order, 02:35 to 04:26 on 2026-09-15 with 26.2 GB reclaimable at launch. No arm window held a compiler, linker or second engine; the Sevra app peaked at 5.9% CPU, so the sensitivity reading equals the rule as written.

| family | tok/s ratio | duration ratio | prompt medians (counted pairs) |
| --- | ---: | ---: | --- |
| code | 1.059 | 0.931 | r0062 1.049 (3), r0033 1.070 (1) |
| dialogue | 1.028 | 0.976 | r0296 1.028 (3), r0295 1.028 (3) |
| multilingual | 1.019 | 0.959 | r0244 1.066 (3), r0245 0.974 (3) |
| prose | 1.105 | 1.005 | r0171 1.040 (3), r0173 1.173 (2) |
| reasoning | 1.070 | 0.941 | r0124 1.088 (3), r0125 1.052 (2) |
| structured | 1.068 | 0.955 | r0256 1.065 (2), r0257 1.072 (2) |

| condition | required | result |
| --- | --- | --- |
| identical outputs | every pair | 36 of 36 |
| aggregate ratio | at least 1.02 | 1.0578 |
| bootstrap lower bound | above 1.00 | 1.0311 (upper 1.0880) |
| family floor | at least 0.97 | 1.019 (multilingual) |
| family duration | at most 1.02 | 1.005 (prose) |
| counted pairs per prompt | at least 2 | r0033 has 1 |

Median decode throughput over counted pairs was 12.17 tok/s for the qualified configuration and 12.98 with the tap. Paired medians, tap over qualified: records read in decode 0.878, reads issued 0.880, adopted 1.123, expired unused 0.569, wasted bytes 0.568, forecast evaluation seconds 0.545.

**Standing.** Every effect condition passes and the mechanism matches the screen, but the registration makes a prompt with one counted pair a failed run, so this measurement changed no default and supports no public number on its own. The tap's default evidence came later, directly, from [[records/measurements/decode-forecast-taps-readout-timing-confirmation-2026-09-15]], which measured the corrected tap against the same qualified configuration on fresh prompts.
