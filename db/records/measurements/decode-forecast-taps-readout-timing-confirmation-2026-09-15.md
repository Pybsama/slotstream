---
type: measurement
id: 01m2n6t44n5dgq870tj9r93vjy
created: 2026-09-16T13:34:29.525850+00:00
updated: 2026-09-16T13:38:52.730297+00:00
summary: 'Corrected tap against the shipped configuration on eight held-out prompts at 20 GB: 1.111 (bootstrap 1.102 to 1.123), all 23 pairs above 1, outputs identical, 13.10 to 14.83 tok/s'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Registered default-evidence contrast of the readout timing registration, environment-configured arms on the readout build at 20 GB; cited by docs/EXPERT-LOOKAHEAD.md and the 0.2.19 decision.
order: '1480'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-readout-timing-confirmation-20gb]]'
title: 'Decode forecast taps, step 13: the corrected tap decodes 1.111 over the shipped configuration on held-out prompts'
status: measured
---
**Outcome: the corrected attention tap decodes 11.1% faster than the configuration 0.2.16 to 0.2.18 ship, on eight held-out prompts from families no earlier run had used: aggregate 1.111 (bootstrap 1.102 to 1.123), all 23 counted pairs above 1, every kind at 1.079 or above, every kind's request duration shorter, outputs identical in 60 of 60 cells. Median decode throughput over counted cells rose from 13.10 to 14.83 tok/s. This is the measurement behind the 0.2.19 default.** Section 2 of the readout timing registration, step 13 of [[records/plan/decode-forecast-taps-2026-09-14]]; run [[sources/runs/2026/09/2026-09-15-forecast-taps-readout-timing-confirmation-20gb]].

**Registration.** With no readout arm qualifying at the screen, the confirmation ran its registered default-evidence contrast: `corrected` (the learned confirmation's corrected arm: tap attention-corrected with the rank-128 file, reserve 164 MiB) against `qualified` (the B1 plan's combined arm, the shipped boundary forecast at stride 2), nothing else differing. Prompts by rule over the 26 training-split families no capture, fit, screen or cohort had used: r0058 and r0067 (code), r0289 (dialogue), r0189 and r0211 (prose), r0092 and r0132 (reasoning), r0265 (structured); dialogue and structured hold one prompt each, a stated limit. Reading: outputs identical in every cell; aggregate paired ratio (median of rounds per prompt, geometric mean per kind, equal kind weight) at least 1.02; bootstrap 2.5th percentile above 1.00; no kind below 0.97; no kind duration ratio above 1.02; at least two counted pairs per prompt; under the contention rule as written and the Sevra sensitivity.

**Run.** A first launch stopped before any configuration on a launcher defect (the screen's "no candidate" passed as the word none) and its directory was set aside unused. The corrected launcher froze the protocol at 20 GB with 26.4 GB reclaimable (about 87 experts per layer, 4,193 slots) on the readout build. 48 cells at 512 outputs with 128 warmup tokens, arm order rotating every cell, 21:26 to 22:36 on 2026-09-15, then the observation cells r0178 and r0222 to 23:13. One cell was unclean for host swap-outs (r0289 round 2, corrected); no arm window held a compiler, linker or second engine.

| kind | tok/s ratio | duration ratio | prompt medians (counted pairs) |
| --- | ---: | ---: | --- |
| code | 1.112 | 0.928 | r0058 1.115 (3), r0067 1.110 (3) |
| dialogue | 1.079 | 0.937 | r0289 1.079 (2) |
| prose | 1.096 | 0.956 | r0189 1.089 (3), r0211 1.104 (3) |
| reasoning | 1.134 | 0.889 | r0092 1.137 (3), r0132 1.130 (3) |
| structured | 1.136 | 0.903 | r0265 1.136 (3) |

| condition | required | result |
| --- | --- | --- |
| identical outputs | every cell | 60 of 60 |
| aggregate ratio, equal kind weight | at least 1.02 | 1.1114 |
| bootstrap 2.5th percentile | above 1.00 | 1.1017 (median 1.1127, 97.5th 1.1232) |
| kind floor | at least 0.97 | 1.079 (dialogue) |
| kind duration ratio | at most 1.02 | 0.956 (prose) |
| counted pairs per prompt | at least 2 | 2 for r0289, 3 for the rest |

All 23 pairs were above 1, from 1.048 to 1.169, identically under the Sevra sensitivity. Paired medians, corrected over qualified: records read in decode 0.794, decode seconds 0.897, request seconds 0.918, prefill seconds 0.998, reads issued 0.796, adopted 1.283, expired unused 0.275, wasted bytes 0.274, demand misses 0.838, forecast evaluation seconds 0.523. Observation cells, outside the reading: r0178 ran 1.067, 0.994 and 1.088 over the three rounds and r0222 1.073 and 1.068 in rounds 0 and 1; the round-2 corrected cell on r0222 did not complete because the engine's memory-pressure guard stopped its prefill commit while the host swapped pages in, the guard doing its job under a host event, recorded and excluded.

**Standing.** This is the direct measurement the default decision needed, consistent with and replacing the product of the two earlier links (1.058 for the tap on B1, 1.031 for the correction over the tap). It became the default in 0.2.19 ([[records/decisions/corrected-decode-forecast-default-with-the-sidecar]]); the shipping build's own default-path benchmark is recorded separately. Limits: one machine, one checkpoint, the 20 GB profile, no multilingual prompt, one dialogue and one structured family, observation prompts of at most about 7,000 tokens, a correction trained on the pilot's training requests.
