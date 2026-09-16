---
type: measurement
id: 01m2n6t40epty39ncgpdfxj0cs
created: 2026-09-16T13:34:29.390601+00:00
updated: 2026-09-16T13:38:53.031860+00:00
summary: 'Rank-128 correction of the attention tap: validation agreement 0.7292 to 0.7980, twin coverage 0.5397 to 0.6209, 35.2 MiB; the native form matches offline in 99.90% of rows'
date: 2026-09-15
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Offline fit on the pilot's training requests and a native correctness diagnostic without timing; produced the file 0.2.19 ships.
order: '1468'
runs: '[[sources/runs/2026/09/2026-09-15-forecast-taps-learned-correction-offline]], [[sources/runs/2026/09/2026-09-15-forecast-taps-learned-correction-native-diagnostic]]'
title: 'Decode forecast taps, steps 6 and 7: the learned correction passes offline and natively'
status: measured
---
**Outcome: a per-layer ridge correction of the attention tap's router logits, truncated to rank 128 and fitted on the pilot's training requests, raises validation top-10 agreement from 0.7292 to 0.7980 and twin coverage at the shipped traffic from 0.5397 to 0.6209 with 27,467 fewer wasted reads, in 35.2 MiB of FP16 weights; the engine's native form reproduces it (top-10 sets equal in 99.90% of rows, agreement 0.79799), so timing runs followed.** Steps 6 and 7 of [[records/plan/decode-forecast-taps-2026-09-14]]; runs [[sources/runs/2026/09/2026-09-15-forecast-taps-learned-correction-offline]] and [[sources/runs/2026/09/2026-09-15-forecast-taps-learned-correction-native-diagnostic]].

**Offline.** A 10 GB capture recorded the tap's router input and every layer's true router input for the pilot's 56 training and 13 validation requests (5,428 passes, 244,635 forecast records, 7.88 GB of shards). Per target layer, a ridge regression on 12,540 training rows corrects the tap's logits, with lambda chosen by five-fold cross-validation grouped by request (factor 1 for 29 layers, 0.1 for 17, 0.01 for 1); the rank-128 truncation keeps 87% to 98% of each correction's squared singular values.

| forecast, validation rows | top-10 agreement | exact top-10 | recall at 16 | twin coverage | wasted reads | FP16 weights |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| attention tap | 0.7292 | 0.0530 | 0.8565 | 0.5397 | 102,326 | |
| full correction | 0.8023 | 0.1062 | 0.9195 | 0.6269 | 72,821 | 117.5 MiB |
| rank-128 correction | 0.7980 | 0.1012 | 0.9163 | 0.6209 | 74,859 | 35.2 MiB |

The registered gate asked for agreement at least 0.05 above the tap, coverage at least 0.05 above the tap with no more wasted reads, and at most 64 MiB; the rank-128 form passes all three (+0.0688, +0.0812), the full form fails only the memory bound. Every target layer gains, from +0.030 (T=9) to +0.241 (T=47). The factors are `tap-correction-attention-rank128-v1.safetensors` (37,540,708 bytes, SHA-256 `37b00d3a32d1e1889a1794bbb8e97905a157a77c0508db620c1a11f2a895f7f5`), the file 0.2.19 ships as a sidecar.

**Native.** `RouterTapCorrection` loads a `slotstream-tap-correction-v1` safetensors file (FP16 factors a and b, FP32 mu and delta, I32 targets), checks schema, tap, dtypes, shapes, target window and finite values, and identifies it by the file's SHA-256. The `attention-corrected` tap shares the attention tap's mixed input and router product and adds ((mixed - mu) a) b + delta per target, the wide product in FP16 and the narrow one in FP32; its factors stay resident and join the lookahead reserve in whole MiB. A capture of the 13 validation requests recorded the plain and corrected taps side by side: over all 141,450 rows the native corrected top-10 set equals the offline one in 99.90% (bar 99%), native corrected agreement is 0.79799 (0.7980 within 0.005) and the plain tap 0.72918 (0.7292 within 0.002). The forecast tap check grew to cover parsing, refusals, the reserve, the formula against a hand reference and loading against in-memory factors.
