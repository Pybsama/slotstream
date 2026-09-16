---
type: run
id: 01m2n6p9n5e1f6wc4qz2kqma1a
created: 2026-09-16T13:32:24.101253+00:00
updated: 2026-09-16T13:38:51.503780+00:00
summary: 'Readout diagnostic: the readout path is exact (self-check 0.9997) and reads 0.8614 top-10 agreement against 0.7980 for the corrected tap; a correction on top comes first'
binary: ae30ae065cf72819031ef81ade68aaa9aaa8e7a7fd5d1daf643b34b98651a46a (readout build; smoke on 49d4502aed892c2a...)
captured_at: 2026-09-15
command: run-readout-diagnostic.sh (Tools/expert_lookahead.py prepare --memory-gb 10; capture of the 13 validation requests with the attention, attention-corrected, attention-readout and boundary-readout taps); run-readout-smoke.sh (one 32-output request per placement)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 11: attention readout tap, exactness and accuracy diagnostic'
tool: slotstream expert-lookahead-capture; Tools/expert_lookahead_taps.py audit and twin; analyze_readout.py
---
Forecast taps, step 11 ([[records/plan/decode-forecast-taps-2026-09-14]]): if the target layer's own attention sublayer is run early on the forecast's approximate input, against the caches as they stand, how much of the forecast's remaining error goes away, and is the engine's readout path exact? Artifacts are under `.build/expert-lookahead/xla3-readout-20260915/`, which git ignores. Nothing was installed, published or committed, and no default changed.

## Why

The offline audit puts the attention tap at 0.7292 top-10 agreement and the stride-1 boundary forecast, which knows the source layer's routed experts exactly and misses only the target's attention, at 0.7619; the learned correction reaches 0.7980 without knowing those experts. So most of the gap to 1.0 is the target's attention over the context, and a probe on the same data found a nonlinear model of the tap's input worse than the ridge at every layer tried (it overfits families; its learning curve is steep but its ceiling is the same input). The context state is resident, so the target's attention can be computed early instead of predicted.

## Registration

`readout-preregistration.md` (sha256 `1f45314dc978d115a9587aad8b5b6b09ac23951c39099a18869f43e0f8552829` at launch, written 2026-09-15 13:09:02 -05 before the readout code was built) fixes the change and the reading: `attention-readout` (tap code 4), at layer T-1's routing readback, takes T's attention-side hyper-connection read of the streams that hold T-1's attention output, runs T's attention sublayer on it against T's caches without writing them (recurrence state, convolution window and KV cache are read only), injects the output into the streams, then T's mixed read and router; `boundary-readout` (code 5) is the same readout on T's exact input after T-1's MoE add, an observer-only self-check that should reproduce T's routing. Pass: the self-check at least 0.995 on requests within the indexer budget (2048 prompt tokens, past which the forward attends sparsely while the readout attends densely) and the attention tap at 0.7292 within 0.002. Reading on the readout's agreement: at least 0.90, a registered timing design; 0.85 to 0.90, the learned correction fitted on top first; below 0.85, the lever stops. Known approximations: the PLE layer's term is not added when the target is that layer, and full-attention targets attend densely.

## Implementation

`GDNLayer.readout` repeats the forward's projections, convolution window, recurrence and gated norm on the cached state without assigning to the cache; `QSAAttention.readout` attends the pass's rows densely over the cached keys and values without appending. `Qwen4ExpModel.readoutForecast` composes them per target, `buildAttentionForecast` builds the readout tap next to the attention taps, and the self-check is built after the MoE add and rides the same readback batch. The prefetch configuration refuses `boundary-readout` as a scheduler tap; the capture command accepts both names. The forecast tap check grew to 43 assertions (stable codes 0 to 5, the refusal, both readouts evaluating as observers). The release build (binary sha256 `ae30ae065cf72819...`) needed one correction (a help string written as a concatenation, which ArgumentParser refuses), and both check tiers passed, 55 checks and 30,371 assertions (`checks-all-readout.log`, sha256 `0d1bbd670b19bdfc395d6c2e952aa2bf9382c3e990ccaa8d69b4d0647b7c3bdc`). The changes are uncommitted in the working tree next to the correction's.

Two follow-up builds, made after the diagnostic and before any timing run, add what a timing design needs. `SLOTSTREAM_EXPERT_PREFETCH_READOUT=after-demand` submits the readout's GPU work asynchronously at the readback and consumes it after the source layer's demand reads, so it runs while they are in flight instead of delaying the readback (binary sha256 `f201a74646e0e1c9...`, 55 checks and 30,375 assertions). `attention-readout-corrected` (code 6) applies a correction fitted on the readout's input to the readout's logits; the correction file's header names the tap it was fitted on, and the configuration, the capture command and the session refuse a file fitted on the other tap (binary sha256 `49d4502aed892c2a...`, 55 checks and 30,379 assertions, the forecast tap check at 51). Neither build changes any number above.

## Capture

The launcher (`run-readout-diagnostic.sh`, sha256 `5a401c43886f63ebd635c9bc3de0926c15a22d1bc08f7f4840bec0c5a4f9a4ed`) waited for no build or model process, a free per-user model lock (the Sevra app held it from about 13:50 to about 14:15) and 15.5 GB reclaimable, then froze protocol `xla3-readout-20260915` (sha256 `f1b64f9717f1b9d8316650a5b8e75537adb7eb54d518bb7e41c380960167a0f9`) at 14:16:04 with 27.9 GB reclaimable, a 10 GB target, as a successor of `xla-pilot-20260911`. The capture ran the 13 pilot validation requests (request file sha256 `ce8dffd7fef1e97296441c3719896bada6202e256f84747dda6fcf525a513643`) with the decode lookahead off, start features and x2 off, the boundary stride-2 forecast recorded for the twin, and the attention, corrected, readout and self-check taps recorded side by side with 24 candidates per row. It exited 0 after 676 s: 13 valid requests, 1,072 passes (1,025 verify, 47 prefill), 51,456 route records, 239,850 forecast records in 145,696,670 bytes of shards; `validate-data` passed and no model process remained.

## Results

Targets 2 to 47, 141,450 rows (`tap-audit.json`, sha256 `6628e2d064fcd92e6010831ebf71d4c43c37df29cb6f00d2200c02a363de7652`; `readout-diagnostic.json`, sha256 `0238c5f46bbb3569a45963960fa2f5d51c702d52eb204411220dd20fdd8df7f6`):

| forecast | top-10 agreement | exact top-10 | recall at 16 | recall at 24 | precision at 0.062 |
| --- | ---: | ---: | ---: | ---: | ---: |
| boundary, stride 2 (shipped) | 0.6171 | 0.0223 | 0.7389 | 0.8125 | 0.710 |
| attention tap | 0.7292 | 0.0530 | 0.8565 | 0.9162 | 0.824 |
| corrected tap | 0.7980 | 0.1012 | 0.9163 | 0.9585 | 0.894 |
| readout tap | 0.8614 | 0.2055 | 0.9656 | 0.9881 | 0.941 |
| readout self-check | 0.9997 | 0.9970 | 1.0000 | 1.0000 | 1.000 |

The self-check is 0.99998 over the eleven requests within the indexer budget and 0.9947 on r0178 (5,231 prompt tokens), where the forward attends sparsely; r0177 (1,934) gives 0.9997. The readout gains on every request (from +0.045 on r0298 to +0.093 on r0250 over the corrected tap) and on every layer group (0.852 to 0.872); full-attention targets go from 0.772 to 0.845 and linear-attention targets from 0.807 to 0.867. The twin (`tap-twin.json`, sha256 `b3a492f361f3960d016a9c57056c075e8b12464216c18e26ca8ffa5cfabb7285`), at the shipped setting's 284,812 issued reads, projects timely coverage 0.687 with 52,457 wasted reads for the readout against 0.620 and 75,301 for the corrected tap and 0.539 and 102,443 for the attention tap (projected ratios 1.290, 1.249, 1.207 against the shipped 1.161); the twin does not count the readout's own GPU work.

## Placement smoke

Written after the diagnostic and before any timing run, `run-readout-smoke.sh` runs one 32-output request (r0005, 16 warmup tokens) per placement on the diagnostic's 10 GB protocol with the third build (binary sha256 `49d4502aed892c2a...`): `readback` and `after-demand`, both the learned screen's attention arm with the tap changed to `attention-readout`. It measures nothing and gates nothing registered. Three launches (15:53:12, 16:04:07 and 16:18:55) ended at the sweep's readiness limit without running a cell: the smoke protocol was derived from the capture's, which `prepare` had frozen without a timing-eligibility rule, so the sweep applied the older swap-stable-120s rule, which needs the host's swap-in counter unchanged over 120 s, and the machine's apps touched swapped pages in every window while 24 to 25 GB stayed reclaimable. The fourth launch, at 16:30:50 with 23.83 GB reclaimable, carried process-pageins-v1, the rule every timed screen and confirmation in this program has used. Both arms exited 0 with the same 32 outputs and the identity `router-reuse:tap=attention-readout`, 15 forecast passes each, 11,913 and 11,915 reads issued, 11,521 and 11,422 adopted, and both cells clean. They ran at 7.71 and 6.18 tok/s; one 32-token cell per arm at 10 GB is not a comparison, and whether the after-demand placement costs or saves time is what a registered timing design would measure. No model process remained. Artifacts (sha256): configs-smoke.json `0e4cdc70918bbaa8f5fe77772b0ac14440e9006b5b1ef7abca6db8c1c02882c3`, protocol.json `e9b62108c792307de67fc9bb067e3535f8dfafdb35a83fbb9d50e7df232c3171`, smoke.log `3e573a0ffa6fd60b9f1f991ae7a7d8c5179b2f8b539788d0b8e4902f4b611f84`, cells.jsonl `779c157875ac3e2c60edc1b7368a200b42fa4b52d2e249e6cf2781ae52c7749c`.

## Outcome

Both exactness checks pass, so the readout path computes what the forward computes. The readout reads 0.8614, in the registered band that fits the learned correction on top before any timing; step 2 of the registration, written at 14:29 before its capture, fixes that fit and its gate (corrected readout at least 0.90 on validation, twin coverage at least 0.03 above the plain readout with no more wasted reads, at most 64 MiB). Two limits stand: the twin cannot price the readout's GPU work, which is hidden only if it runs while the source layer's demand reads are in flight, and the residual 0.14 of agreement is the source layer's routed experts, which no forecast can know before reading them.

## Audit and twin

```text
screen finished; building (13:56:39)
[3/3] Compiling plugin CudaBuild
[7/9] Compiling slotstream_cli CheckRendering.swift
Build complete! (15.50s)

41 passed, 0 failed, 0 skipped (28281 assertions)
binary ae30ae065cf72819 copied to .build/expert-lookahead/bin-readout-ae30ae065cf72819
diagnostic launches with 28.04 GB reclaimable (14:16:02)
[14:16:04] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-20260915/protocol.json: memory 10.0 GB (reclaimable 28.0 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-readout-20260915", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-20260915/protocol.json", "memory_gb": 10.0}
[14:16:04] preflight ok: 27.9 GB reclaimable for a 10.0 GB target
[14:27:20] capture exited 0 after 676 s
{
 "run": ".build/expert-lookahead/xla3-readout-20260915/capture",
 "requests": 13,
 "valid": 13,
 "incomplete": [],
 "totals": {
  "executables": [
   "ae30ae065cf72819031ef81ade68aaa9aaa8e7a7fd5d1daf643b34b98651a46a"
  ],
  "passes": 1072,
  "verify": 1025,
  "plain": 0,
  "prefill": 47,
  "features": 0,
  "layers": 51456,
  "routes": 51456,
  "demands": 49824,
  "x2_bytes": 0,
  "verify_tokens": 3075,
  "kept": 2616,
  "hits": 2003,
  "misses": 1221386,
  "adopted": 0,
  "residency": 13,
  "forecasts": 239850
 },
 "bytes": 145696670
}
VALIDATE-DATA PASS
no model process
1025 passes, targets >= 2
variant                rows   top10   exact   rec16   rec24
attention            141450  0.7292  0.0530  0.8565  0.9162
attention-corrected   141450  0.7980  0.1012  0.9163  0.9585
attention-readout    141450  0.8614  0.2055  0.9656  0.9881
boundary-readout     141450  0.9997  0.9970  1.0000  1.0000
s2                   141450  0.6171  0.0223  0.7389  0.8125
r0065: prompt   543, rows  12006, attention 0.6319, attention-corrected 0.7329, attention-readout 0.8186, boundary-readout 1.0000
r0151: prompt    61, rows  12558, attention 0.6784, attention-corrected 0.7656, attention-readout 0.8325, boundary-readout 1.0000
r0178: prompt  5231, rows   7866, attention 0.7699, attention-corrected 0.8452, attention-readout 0.8931, boundary-readout 0.9947
r0241: prompt   176, rows  10212, attention 0.7446, attention-corrected 0.8097, attention-readout 0.8665, boundary-readout 1.0000
r0251: prompt   250, rows  11178, attention 0.7056, attention-corrected 0.7934, attention-readout 0.8530, boundary-readout 1.0000
r0300: prompt   111, rows   7728, attention 0.8010, attention-corrected 0.8484, attention-readout 0.8980, boundary-readout 1.0000
r0066: prompt   603, rows  14490, attention 0.7807, attention-corrected 0.8398, attention-readout 0.8874, boundary-readout 1.0000
r0163: prompt    47, rows  13524, attention 0.7570, attention-corrected 0.8152, attention-readout 0.8667, boundary-readout 1.0000
r0177: prompt  1934, rows   8694, attention 0.7678, attention-corrected 0.8290, attention-readout 0.8877, boundary-readout 0.9997
r0243: prompt   188, rows   9246, attention 0.7593, attention-corrected 0.7944, attention-readout 0.8725, boundary-readout 1.0000
r0250: prompt   297, rows   8142, attention 0.6219, attention-corrected 0.7327, attention-readout 0.8104, boundary-readout 1.0000
r0298: prompt   122, rows  14214, attention 0.7951, attention-corrected 0.8347, attention-readout 0.8908, boundary-readout 1.0000
r0013: prompt   731, rows  11592, attention 0.6633, attention-corrected 0.7370, attention-readout 0.8273, boundary-readout 1.0000
{
 "rows": 141450,
 "agreement": {
  "attention": 0.7291841640155416,
  "attention-corrected": 0.7979886885825072,
  "attention-readout": 0.8613990809472635,
  "boundary-readout": 0.9996861081654289
 },
 "agreement_within_budget": {
  "attention": 0.7267846448676363,
  "attention-corrected": 0.7952067612887451,
  "attention-readout": 0.8595295843812932,
  "boundary-readout": 0.9999782908132708
 },
 "by_layer_type": {
  "attention:full": 0.6842601626016157,
  "attention:linear": 0.7450396939264939,
  "attention-corrected:full": 0.7720948509485369,
  "attention-corrected:linear": 0.8071276901006093,
  "attention-readout:full": 0.8451273712738283,
  "attention-readout:linear": 0.8671420373026588,
  "boundary-readout:full": 0.9987967479674771,
  "boundary-readout:linear": 1.0
 },
 "checks": {
  "self_check_within_budget": true,
  "attention_reproduced": true
 },
 "exact": true,
 "readout_reading": "correction on top first"
}
== twin (14:27:34)
1025 passes, 338147 misses, decode 233.6 s, service 0.271 ms
variant                             thr   issued   timely   late   wasted    cov   prec   amp  ratio
boundary-s2-k4                     none   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k4                    0.000   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k4                    0.031   323646   157295      0   166351  0.465  0.486  1.49  1.173
boundary-s2-k4                    0.062   284812   148396      0   136416  0.439  0.521  1.40  1.161
boundary-s2-k4                    0.100   244360   137808      0   106552  0.408  0.564  1.32  1.147
boundary-s2-k4                    0.150   202045   124672      0    77373  0.369  0.617  1.23  1.130
boundary-s2-k4                    0.214   161015   109247      0    51768  0.323  0.678  1.15  1.112
boundary-s2-k4                    0.300   121923    91164      0    30759  0.270  0.748  1.09  1.091
boundary-s2-k4                    0.500    70459    59916      0    10543  0.177  0.850  1.03  1.058
boundary-s2-k4                    0.750    38779    35120      0     3659  0.104  0.906  1.01  1.033
boundary-s2-k4                    1.000    21742    20064      0     1678  0.059  0.923  1.00  1.019
boundary-s2-k1                     none   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k1                    0.000   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k1                    0.031   323646   157295      0   166351  0.465  0.486  1.49  1.173
boundary-s2-k1                    0.062   284812   148396      0   136416  0.439  0.521  1.40  1.161
boundary-s2-k1                    0.100   244360   137808      0   106552  0.408  0.564  1.32  1.147
boundary-s2-k1                    0.150   202045   124672      0    77373  0.369  0.617  1.23  1.130
boundary-s2-k1                    0.214   161015   109247      0    51768  0.323  0.678  1.15  1.112
READOUT DIAGNOSTIC DONE (14:27:48)
```
