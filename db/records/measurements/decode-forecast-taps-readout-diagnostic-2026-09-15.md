---
type: measurement
id: 01m2n6t439x2vrs5ypq6e49n3n
created: 2026-09-16T13:34:29.481318+00:00
updated: 2026-09-16T13:38:52.877008+00:00
summary: 'Attention readout: exact (self-check 0.9997), 0.8614 agreement against 0.7980 for the corrected tap; its own correction reaches 0.8790, short of the 0.90 bar, so the lever stopped'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Offline accuracy and exactness at 10 GB, no timing; the twin cannot price the readout's GPU work.
order: '1476'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-readout-diagnostic]], [[sources/runs/2026/09/2026-09-15-forecast-taps-readout-learned-correction]]'
title: 'Decode forecast taps, steps 11 and 12: the attention readout is exact and reads 0.86, its correction 0.88'
status: measured
---
**Outcome: running the target layer's own attention sublayer early, on the forecast's approximate input against the resident caches, is exact (self-check 0.9997) and lifts offline top-10 agreement to 0.8614, against 0.7980 for the corrected tap; a correction fitted on top reaches 0.8790, short of the registered 0.90 bar, so the readout lever stopped at the offline result until it was reopened for a timing run.** Steps 11 and 12 of [[records/plan/decode-forecast-taps-2026-09-14]]; runs [[sources/runs/2026/09/2026-09-15-forecast-taps-readout-diagnostic]] and [[sources/runs/2026/09/2026-09-15-forecast-taps-readout-learned-correction]].

**Why.** The stride-1 boundary forecast, which knows the previous layer's routed experts exactly and misses only the target's attention, reads 0.7619, while the corrected tap reaches 0.7980 without knowing those experts; so most of the remaining error is the target's attention over the context, and that state is resident. A nonlinear probe of the tap's input was worse than the ridge at every layer tried (it overfits families), so the attention was computed rather than predicted.

**Implementation.** `attention-readout` (tap 4), at layer T-1's routing readback, takes T's attention-side read of the streams holding T-1's attention output, runs T's attention sublayer on it against T's caches without writing them (recurrence state, convolution window and KV cache are read only), injects the output into the streams, then T's mixed read and router. `boundary-readout` (tap 5) is the same readout on T's exact input, an observer-only self-check. Two follow-up builds added an `after-demand` placement that submits the readout's GPU work asynchronously at the readback and consumes it after the source layer's demand reads, and `attention-readout-corrected` (tap 6); the correction file's header names the tap it was fitted on and a file fitted on the other tap is refused. All three builds passed both check tiers.

**Diagnostic**, the 13 validation requests at 10 GB, 141,450 rows over targets 2 to 47:

| forecast | top-10 agreement | exact top-10 | recall at 16 | recall at 24 |
| --- | ---: | ---: | ---: | ---: |
| boundary, stride 2 (shipped) | 0.6171 | 0.0223 | 0.7389 | 0.8125 |
| attention tap | 0.7292 | 0.0530 | 0.8565 | 0.9162 |
| corrected tap | 0.7980 | 0.1012 | 0.9163 | 0.9585 |
| readout tap | 0.8614 | 0.2055 | 0.9656 | 0.9881 |
| readout self-check | 0.9997 | 0.9970 | 1.0000 | 1.0000 |

The self-check is 0.99998 over the eleven requests within the 2,048-token indexer budget and 0.9947 on r0178 (5,231 prompt tokens), where the forward attends sparsely and the readout densely. The readout gains on every request and every layer group. The twin projects timely coverage 0.687 at the shipped traffic against 0.620 for the corrected tap, before the readout's own GPU work, which the twin cannot price.

**Correction on the readout.** A 3,360-second capture of the 69 requests with the readout tap and its inputs, then the same collect, fit and twin as the attention tap's correction: the rank-128 form lifts the readout from 0.8614 to 0.8790 (bar 0.90) and twin coverage from 0.688 to 0.716 (bar +0.03) with 9,266 fewer wasted reads. With the target's attention computed early the correction has less left to learn (+0.018 against +0.069 on the attention tap); the remaining 0.12 of agreement is the previous layer's routed experts, which no forecast can know before reading them. As registered the lever stopped here; the timing run that followed was a separate decision with its own registration ([[records/measurements/decode-forecast-taps-readout-timing-screen-2026-09-15]]).
