---
type: measurement
id: 01m2n6t44092ehhqzsa30hvnbn
created: 2026-09-16T13:34:29.504744+00:00
updated: 2026-09-16T13:38:52.573817+00:00
summary: 'Readout timing screen at 20 GB: no readout arm has a pair above 1 against the corrected tap (readback 0.952, after-demand 0.737); 113 cells with identical outputs; lever closed'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Registered screen with the corrected tap as reference and two long-prompt observation cells; cited by docs/EXPERT-LOOKAHEAD.md.
order: '1478'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-readout-timing-screen-20gb]]'
title: 'Decode forecast taps, step 13: computing the next layer''s attention early loses 5% to 26%'
status: measured
---
**Outcome: negative. Over four rounds and 77 counted cells with identical outputs, no readout arm had a single pair above 1 against the corrected attention tap: 0.952 in the readback placement (with or without its correction), 0.737 and 0.742 in the after-demand placement, and 0.85 to 0.89 or 0.70 on the long observation prompts. The readout reads fewer records but its GPU work costs more than the reads it saves, and the after-demand placement synchronizes the GPU at every layer. The lever closes.** Section 1 of the readout timing registration, step 13 of [[records/plan/decode-forecast-taps-2026-09-14]]; run [[sources/runs/2026/09/2026-09-15-forecast-taps-readout-timing-screen-20gb]].

**Registration and run.** Written after the readout correction's offline gate failed and before any configuration existed, stating the smoke's prior (7.71 against 6.18 tok/s on one cell) and the twin's projections (1.290 and 1.307 against 1.249) so neither could be read post hoc. Five arms at 20 GB, identical to the learned confirmation's corrected arm except the tap, the placement, the correction file and the reserve: `corrected` (reference), `readout-readback`, `readout-after`, `readout-corrected-readback`, `readout-corrected-after`. r0005, r0206, r0096 and r0074 at 256 outputs, rounds until 12 counted pairs per arm; the observation cells r0178 (5,231 prompt tokens) and r0222 (about 7,000) after each sweep. Three cells were unclean for host swap-outs; no arm window held a compiler, linker or second engine.

| arm | counted pairs | first 12 | above 1 | all pairs | median tok/s | r0178 | r0222 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| corrected (reference) | | | | | 14.56 | | |
| readout-readback | 15 | 0.949 | 0 | 0.952 | 13.67 | 0.888 | 0.849 |
| readout-corrected-readback | 15 | 0.952 | 0 | 0.952 | 13.48 | 0.886 | 0.846 |
| readout-after | 16 | 0.738 | 0 | 0.737 | 10.71 | 0.712 | 0.699 |
| readout-corrected-after | 15 | 0.745 | 0 | 0.742 | 10.36 | 0.702 | 0.706 |

**Why.** The readout does what the offline audit said: 8% fewer records read in decode (13% with its correction), half the speculative reads expiring unused, half the wasted bytes. It loses because its GPU work is not free. In the readback placement the forecast evaluation grows by 0.56 to 0.70 s and the build by 0.19 to 0.22 s per 256-output cell, about 0.8 s on a 17.6 s decode, and the routing readback it rides returns later, so the source layer's own demand reads start later. Demand reads take about 30% of decode time at this profile, so an 8% cut in records is worth about 2.4% of decode, less than the readout costs; at long context the readout attends densely on the twelve full-attention layers past the indexer budget and the loss grows to 11% to 15%. The after-demand placement submits the readout with `asyncEval` and consumes it after the source layer's experts; consumption materializes the logits, which waits for every queued GPU operation, so each layer ends with a full synchronization that the deferred four-layer barrier exists to avoid (7.6 s in the selection and scheduling timers per cell against 0.14 s and 0.08 s). The engine keeps the readout taps as observer and opt-in tools; nothing recommends them.
