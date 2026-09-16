---
type: measurement
id: 01m2n6t3wye04eg4fmbaeneqfr
created: 2026-09-16T13:34:29.278370+00:00
updated: 2026-09-16T13:34:29.278370+00:00
summary: 'Decode forecast taps: a more accurate expert forecast at the same lead time decodes 1.111 over the 0.2.16 to 0.2.18 configuration with identical outputs and becomes the 0.2.19 default'
date: 2026-09-15
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Program summary over the sections below; the number that stands is the held-out confirmation of the corrected tap against the shipped configuration at 20 GB.
order: '1460'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-readout-timing-confirmation-20gb]]'
title: 'Decode forecast taps: a more accurate forecast at the same lead time'
status: measured
---
**Outcome: a more accurate expert forecast at the same lead time raises decode throughput by 11.1% over the configuration 0.2.16 to 0.2.18 shipped, with identical outputs, and becomes the 0.2.19 default.** The shipped decode lookahead forecast a layer's routing from the model's state two layers back. Reading the state after the previous layer's attention step instead, at the same point in time, raised top-10 forecast agreement from 0.62 to 0.73; a rank-128 linear correction of that forecast's router logits, fitted on the benchmark corpus's training requests, raised it to 0.80. On eight held-out prompts at a 20 GB target the corrected forecast decoded at 1.111 against the shipped configuration (bootstrap 1.102 to 1.123), all 23 counted pairs above 1, reading 21% fewer expert records during decode and wasting 73% fewer speculative bytes ([[records/measurements/decode-forecast-taps-readout-timing-confirmation-2026-09-15]]). The plan is [[records/plan/decode-forecast-taps-2026-09-14]]; the default change is [[records/decisions/corrected-decode-forecast-default-with-the-sidecar]].

Every step was registered before its data existed and read under a fixed gate. The sections below record them in dependency order: the offline gate and the native screen of the attention taps, the B1 confirmation that passed every effect condition but one hygiene condition, a co-routing prior that failed offline, the learned correction offline and natively, its screen and held-out confirmation, the issue-threshold screen that closed at 0.062, the attention readout that reached 0.86 agreement offline but lost natively, and the timing confirmation that produced the default's number. Four levers closed on their registered readings (the shared-expert variant by rule, the co-routing prior, the lower threshold and the readout); two passed (the attention tap and its learned correction) and ship together.

Limits that apply to every section: one 48 GB M5 Pro, one checkpoint, the 20 GB profile with two drafts unless a section says otherwise, no multilingual prompt in the later held-out sets, and a correction trained on the pilot's 56 training requests. The prefetch twin projects read coverage and never counts in-flight joins or GPU cost, so its ratios are never claims; the numbers that stand are the native paired measurements.
