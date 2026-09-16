---
type: run
id: 01m2n6p9n5wwre7f2w9sfazphv
created: 2026-09-16T13:32:24.101758+00:00
updated: 2026-09-16T13:32:24.101758+00:00
summary: 'Readout correction offline: rank-128 lifts the readout 0.8614 to 0.8790 (bar 0.90) and twin coverage +0.0274 (bar +0.03); the gate fails and the lever stops at the offline result'
binary: 'ae30ae065cf72819031ef81ade68aaa9aaa8e7a7fd5d1daf643b34b98651a46a (readout build)'
captured_at: 2026-09-15
command: 'run-readout-learned.sh (Tools/expert_lookahead.py prepare --memory-gb 10; capture of 56 training and 13 validation requests with the readout tap and its inputs; collect, fit, twin)'
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 12: learned correction on the readout tap, offline'
tool: 'slotstream expert-lookahead-capture; Tools/expert_lookahead_learned.py collect, fit and twin (--tap 4)'
---
Forecast taps, step 12 ([[records/plan/decode-forecast-taps-2026-09-14]]): does the learned correction, fitted on the readout tap's input, lift the readout to the registered bar for a timing design? Artifacts are under `.build/expert-lookahead/xla3-readout-learned-20260915/`, which git ignores. Nothing was installed, published or committed, and no default changed.

## Registration

Step 2 of `readout-preregistration.md` (sha256 `4bce4fc336e8d561b1aeea8c3b3a4a3afb7714ed7b01e7c62e152814f1d1017d`, written 2026-09-15 14:29 -05 after step 1 and before this capture) fixes the data (the pilot's 56 training and 13 validation requests, the readout tap with its mixed inputs and every layer's true router input), the model (the same per-layer ridge and rank-128 truncation as the attention tap's correction, with the tap code as an argument to the tool) and the gate before any timing design: validation top-10 agreement of the rank-128 corrected readout at least 0.90, twin timely coverage at the shipped traffic at least 0.03 above the plain readout's with no more wasted reads, at most 64 MiB of FP16 weights. If the gate fails, the lever stops at the offline result.

## Capture and analysis

`run-readout-learned.sh` waited for the threshold screen, a free model lock and 15.5 GB reclaimable, then froze protocol `xla3-readout-learned-20260915` (sha256 `ecd35e554af4091fc02069c58dc117ea00120cc3bf7c5b65230d23ddcceaeebc`) at 14:50:02 with 33.0 GB reclaimable, at a 10 GB target on the readout build (binary sha256 `ae30ae065cf72819...`, the diagnostic's). The capture ran the 69 requests (request file sha256 `8c33a31140b3b4a2...`) with the readout tap and its inputs, full x2, 24 candidates per row, start features off and the decode lookahead off, and exited 0 after 3,360 s: 69 valid requests, 5,428 passes (5,205 verify with 15,615 verify tokens, 12,882 kept; 223 prefill), 260,544 route records, 244,635 forecast records, 7,879,349,706 bytes of shards; `validate-data` passed and no model process remained. `Tools/expert_lookahead_learned.py` (sha256 `f78d031901efe0232635ad32108b93f23444fbe432e4fedc045001bd4b9a0682`, the attention tap's tool with a `--tap` argument for collect and twin) ran collect, fit and twin from 15:46:10 to 15:52:57, CPU only, with no timed run active.

Collect: the true router inputs reproduced the recorded routes in 99.996% of rows and the readout's offline logits reproduced the recorded top 10 in 99.996%. Fit: 12,540 training rows per target layer; cross-validation chose a lambda factor of 1 for 46 layers and 0.1 for one; the rank-128 truncation keeps 85% to 96% of each correction's squared singular values (median 90%).

## Results

Validation, targets 2 to 47, 141,450 rows (`fit/fit.json`, sha256 `c77d44ca83a0b73efb7f5a289dec096e66cf9cea325c9e8c01960e89d91e94c0`):

| forecast | top-10 agreement | exact top-10 | recall at 16 | recall at 24 |
| --- | ---: | ---: | ---: | ---: |
| readout tap | 0.8614 | 0.2055 | 0.9656 | 0.9881 |
| full correction on the readout | 0.8799 | 0.2499 | 0.9746 | 0.9915 |
| rank-128 correction on the readout | 0.8790 | 0.2470 | 0.9742 | 0.9914 |

Every target gains under the rank-128 form, from +0.004 (T=18) to +0.055 (T=47); full-attention targets go from 0.845 to 0.866 and linear-attention targets from 0.867 to 0.884. Twin at the shipped setting's 284,812 issued reads (`twin.json`, sha256 `879a859d9d43cec0d97ea99c161e2d436d6899fafbdc80e157171b122deabc26`): timely coverage 0.7155 with 42,877 wasted reads for the rank-128 corrected readout against 0.6881 and 52,143 for the plain readout (projected ratios 1.307 and 1.290; the corrected attention tap sits at 0.620 and 1.249, the shipped boundary at 0.439 and 1.161). The FP16 weights take 35.25 MiB; `fit/tap-correction-rank128.safetensors` (37,540,712 bytes, sha256 `8d815db6741386778708f09c60e00716cc60c2b1f8565c0eea48ad594507a48b`, header tap `attention-readout`) was written by `write_correction.py`, which reproduces the attention correction's file tensor for tensor.

## Outcome

The gate fails on two of its three conditions: agreement 0.8790 against the 0.90 bar, and coverage +0.0274 against the 0.03 bar (waste did fall, by 9,266 reads; the memory bound holds). As registered, the readout lever stops at the offline result. What the result says: with the target's attention computed early, the correction has less left to learn (+0.018 against +0.069 on the attention tap), and the remaining 0.12 of agreement is the source layer's routed experts, which no forecast can know before reading them. What it does not say: whether the readout pays natively. The twin projects 1.290 to 1.307 against the corrected tap's 1.249 before the readout's own GPU work, which only a timing run measures, and the engine now carries both the readout tap and a placement that runs that work while the source layer's demand reads are in flight. Testing that would be a new decision with its own registration; this one is closed.

## Capture, collect, fit and twin

```text
capture launches with 33.06 GB reclaimable (14:50:01)
[14:50:02] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-learned-20260915/protocol.json: memory 10.0 GB (reclaimable 32.9 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-readout-learned-20260915", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-learned-20260915/protocol.json", "memory_gb": 10.0}
[14:50:02] preflight ok: 33.0 GB reclaimable for a 10.0 GB target
[15:46:02] capture exited 0 after 3360 s
{
 "run": ".build/expert-lookahead/xla3-readout-learned-20260915/capture",
 "requests": 69,
 "valid": 69,
 "incomplete": [],
 "totals": {
  "executables": [
   "ae30ae065cf72819031ef81ade68aaa9aaa8e7a7fd5d1daf643b34b98651a46a"
  ],
  "passes": 5428,
  "verify": 5205,
  "plain": 0,
  "prefill": 223,
  "features": 0,
  "layers": 260544,
  "routes": 260544,
  "demands": 253152,
  "x2_bytes": 3837542400,
  "verify_tokens": 15615,
  "kept": 12882,
  "hits": 19854,
  "misses": 6189266,
  "adopted": 0,
  "residency": 69,
  "forecasts": 244635
 },
 "bytes": 7879349706
}
VALIDATE-DATA PASS
no model process
== collect (15:46:10)
56 training and 13 validation requests, stride0 0.99996, offline tap 0.99996
== fit (15:46:36)
form               rows   top10   exact   rec16   rec24
tap              141450  0.8614  0.2055  0.9656  0.9881
tap_recorded     141450  0.8614  0.2055  0.9656  0.9881
full             141450  0.8799  0.2499  0.9746  0.9915
rank             141450  0.8790  0.2470  0.9742  0.9914
gains: full +0.0185, rank-128 +0.0176; FP16 weights full 117.5 MiB, rank 35.2 MiB
== twin (15:52:45)
1025 passes, 338147 misses, shipped issued 284812
  boundary-s2-k4               coverage 0.4389, wasted 136416, projected 1.161
  attention                    outside the swept range
  attention-this-capture       coverage 0.6881, wasted 52143, projected 1.290
  attention-learned-full       coverage 0.7170, wasted 42353, projected 1.309
  attention-learned-rank128    coverage 0.7155, wasted 42877, projected 1.307
  attention-learned-full: coverage +0.0290, wasted -9790
  attention-learned-rank128: coverage +0.0274, wasted -9266
ecd35e554af4091fc02069c58dc117ea00120cc3bf7c5b65230d23ddcceaeebc  .build/expert-lookahead/xla3-readout-learned-20260915/protocol.json
639719244b362866f8f72a6b33ce8603118cb2c1941c07ec038943195f95a393  .build/expert-lookahead/xla3-readout-learned-20260915/capture/run.json
90ccb09ed65901c748ac79e469ae045f1b9fd71349f10dab6e332b5b5c12e873  .build/expert-lookahead/xla3-readout-learned-20260915/cache/collect.json
c77d44ca83a0b73efb7f5a289dec096e66cf9cea325c9e8c01960e89d91e94c0  .build/expert-lookahead/xla3-readout-learned-20260915/fit/fit.json
50be8a00d2324a545c51d968136692966a8e4c138426b520a74232c3783fe746  .build/expert-lookahead/xla3-readout-learned-20260915/fit/rank128.npz
879a859d9d43cec0d97ea99c161e2d436d6899fafbdc80e157171b122deabc26  .build/expert-lookahead/xla3-readout-learned-20260915/twin.json
f78d031901efe0232635ad32108b93f23444fbe432e4fedc045001bd4b9a0682  Tools/expert_lookahead_learned.py
READOUT LEARNED DONE (15:52:57)
```
