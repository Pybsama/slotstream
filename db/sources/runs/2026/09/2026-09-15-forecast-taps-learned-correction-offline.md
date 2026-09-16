---
type: run
id: 01m2n6p9n23grw7f3rmsnpyand
created: 2026-09-16T13:32:24.098345+00:00
updated: 2026-09-16T13:38:51.811047+00:00
summary: 'Learned correction offline: rank-128 raises validation agreement 0.7292 to 0.7980 and twin coverage 0.5397 to 0.6209 with 27,467 fewer wasted reads in 35.2 MiB; passes'
binary: 661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099 (taps build)
captured_at: 2026-09-15
command: run-learned-capture.sh (Tools/expert_lookahead.py prepare --memory-gb 10; capture of 56 training and 13 validation requests with the attention tap and its inputs); run-learned-analysis.sh (collect --workers 3; fit; twin)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 6: learned correction of the attention tap, capture and offline fit'
tool: slotstream expert-lookahead-capture; Tools/expert_lookahead_learned.py collect, fit and twin
---
Forecast taps, step 6 ([[records/plan/decode-forecast-taps-2026-09-14]]): can a per-layer linear correction learned on training requests, applied to the attention tap's router input, forecast the next layer's routing more accurately on held-out requests at the same delivery time? Artifacts are under `.build/expert-lookahead/xla3-learned-20260915/`, which git ignores. Nothing was installed, published or committed.

## Registration

`learned-preregistration.md` (sha256 `8bb7311521b39911...`, written 2026-09-15 00:01:07 -05, before the capture protocol existed) fixes the data, the model, lambda selection by five-fold cross-validation grouped by training request, the metrics and the gate: validation top-10 agreement at least 0.05 above the tap, twin coverage at the shipped traffic at least 0.05 above the tap with no more wasted reads, and at most 64 MiB of FP16 weights for the form that passes. The co-routing probe's negative result named this as the next step.

`Tools/expert_lookahead_learned.py` (sha256 `9146c634e34aad1463f06942baa1aee6729d4fd11e282ef801babdc3f46051fe`) was written after the registration and before the capture. One defect was fixed before it first ran: the refit unpacked the ridge solver's one-element list as a tuple.

## Capture

The B1 launcher had been waiting for 25.5 GB reclaimable (24.93 GB at 00:58) and was stopped before it launched anything, so this capture, which needs 15.5 GB, ran first. `Tools/expert_lookahead.py prepare` froze protocol `xla3-learned-20260915` at 00:59:38 as a successor of `xla-pilot-20260911`, re-verifying the pilot's shards, at a 10 GB target with the taps binary (sha256 `661632d4545af0c8...`) and 24.4 GB reclaimable. The capture ran the pilot's 56 training-split and 13 validation-split requests (request file sha256 `8c33a31140b3b4a2...`) with an observer-only attention tap and its mixed input rows, 24 candidates per row, full x2 for verification passes, start features off, no boundary strides and the decode lookahead off.

All 69 requests completed by 01:55:02: 5,428 passes (5,205 verify passes with 15,615 verify tokens, 12,882 kept, and 223 prefill passes), 260,544 route records, 244,635 forecast records, 3,837,542,400 bytes of x2, and 69 shards of 7,880,777,799 bytes. `validate-data` passed and no model process remained.

Artifacts (sha256): protocol.json `8d76d8146409822aeacb6b75c40dd832516ab54713ac55d523db8b02d8f321a1`, requests-train56-validation13.json `8c33a31140b3b4a2cbb1734e56c3542b483f4e7abf5b2787bb1f011154121eeb`, learned-preregistration.md `8bb7311521b39911eb4ec53fb2ef15abcce2afabc566a5418b5831ab9bbb2dc3`, capture/run.json `26fac92b7674190434ec7715c7dd5702af7dc69720107a9d6caf7423af11aac6`, capture/requests.jsonl `c48d8b9bdd824006643e7928d281f1520a3c54781a2503c539aac5be40e46eda`, capture/validate-data.json `cc08c4510b13bf1765ea87c78cfc612ea1d3f68a35f605f5250be525efebe394`.

## Tool checks before the analysis

While the capture ran: the ridge solver reproduced a synthetic linear map (maximum error 0.043 at a negligible lambda) and shrank toward zero at a large one; the metrics scored exact logits as 1.0; `collect` on the first six completed requests found the true router inputs reproducing the recorded routes in 99.986% to 100% of rows and the offline tap logits reproducing the recorded top 10 in 99.963% to 100%, with a largest input magnitude of 13.7, so float16 storage is safe. A fit on target layers 1 to 3 with five training requests and a sixth training request standing in for validation ran end to end in 32 s. Its numbers came from training requests only and are not a result; nothing was tuned from them.

## Analysis

`run-learned-analysis.sh` ran from 01:57:11 to 02:04:31, CPU only, after the B1 launcher, waiting at 24.58 GB reclaimable, was stopped before it launched anything. No timed run overlapped it.

**Collect.** 56 training and 13 validation requests. Over every cached row the true router inputs reproduced the recorded routes in 99.996% of rows, and the tap logits recomputed offline reproduced the recorded top 10 in 99.996%.

**Fit.** 12,540 training rows per target layer. Cross-validation chose a lambda factor of 1 for 29 layers, 0.1 for 17 and 0.01 for 1. The rank-128 truncation keeps 87% to 98% of each correction's squared singular values (median 94%).

**Validation**, targets 2 to 47, 141,450 rows:

| forecast | top-10 agreement | exact top-10 | recall at 16 | recall at 24 |
| --- | ---: | ---: | ---: | ---: |
| attention tap | 0.7292 | 0.0530 | 0.8565 | 0.9162 |
| full correction | 0.8023 | 0.1062 | 0.9195 | 0.9604 |
| rank-128 correction | 0.7980 | 0.1012 | 0.9163 | 0.9585 |

The tap reproduces the taps audit exactly. Every target layer gains under the rank-128 form, from +0.030 (T=9) to +0.241 (T=47). By eight-layer group it goes from 0.696 to 0.774 (layers 0 to 7), 0.727 to 0.786, 0.751 to 0.806, 0.717 to 0.784, 0.740 to 0.803 and 0.735 to 0.829 (layers 40 to 47).

**Twin**, at the shipped setting's 284,812 issued reads:

| forecast | timely coverage | wasted reads | projected |
| --- | ---: | ---: | ---: |
| boundary, stride 2 (shipped) | 0.4389 | 136,416 | 1.161 |
| attention tap (taps capture or this capture) | 0.5397 | 102,326 | 1.206 |
| full correction | 0.6269 | 72,821 | 1.252 |
| rank-128 correction | 0.6209 | 74,859 | 1.249 |

At threshold 0.062 the rank-128 form issues 223,307 reads at 0.822 precision against the tap's 244,766 at 0.691.

## Outcome

The rank-128 form passes all three registered conditions: top-10 agreement +0.0688 (bar 0.05), coverage at the shipped traffic +0.0812 with 27,467 fewer wasted reads (bar 0.05, no more waste), and 35.2 MiB of FP16 weights (bar 64 MiB). The full form passes the first two (+0.0731, +0.0873 with 29,506 fewer wasted reads) and fails the memory bound at 117.5 MiB. As registered, a native implementation of the rank-128 form follows. Its factors are in `fit/tap-correction-rank128.safetensors` (37,540,708 bytes, sha256 `37b00d3a32d1e1889a1794bbb8e97905a157a77c0508db620c1a11f2a895f7f5`), whose largest FP16 round-trip error is 0.00048. Projected ratios are the twin's, never claims, and the twin counts reads rather than in-flight joins, so the native gain has to be measured.

Artifacts (sha256): cache/collect.json `ff16d5b604b2c70957c2c956ea05eec7e2a97e7415f3577681a7b04dae64a118`, fit/fit.json `2730d7aa290e6411a85eefcdf030464fb3da121f5967dc8fa92b31abd6e5bdc3`, fit/rank128.npz `795b5fd1088ecb575e632e6e2ef97ef8092916230d3790620759c4f2bd43f5e8`, twin.json `07833448bd5b90a16061fcdc574e23861328da4a280af089941d56b3c7dcac80`, and the logs collect.log, fit.log and twin.log beside them.

## Collect, fit and twin

```text
B1 launcher stopped while waiting for memory, before launching anything (01:57:10); starting the learned analysis
== collect (01:57:11) ==
56 training and 13 validation requests, stride0 0.99996, offline tap 0.99996
== fit (01:57:35) ==
form               rows   top10   exact   rec16   rec24
tap              141450  0.7292  0.0530  0.8565  0.9162
tap_recorded     141450  0.7292  0.0530  0.8565  0.9162
full             141450  0.8023  0.1062  0.9195  0.9604
rank             141450  0.7980  0.1012  0.9163  0.9585
gains: full +0.0731, rank-128 +0.0688; FP16 weights full 117.5 MiB, rank 35.2 MiB
== twin (02:04:15) ==
1025 passes, 338147 misses, shipped issued 284812
  boundary-s2-k4               coverage 0.4389, wasted 136416, projected 1.161
  attention                    coverage 0.5397, wasted 102326, projected 1.206
  attention-this-capture       coverage 0.5397, wasted 102326, projected 1.206
  attention-learned-full       coverage 0.6269, wasted 72821, projected 1.252
  attention-learned-rank128    coverage 0.6209, wasted 74859, projected 1.249
  attention-learned-full: coverage +0.0873, wasted -29506
  attention-learned-rank128: coverage +0.0812, wasted -27467
ff16d5b604b2c70957c2c956ea05eec7e2a97e7415f3577681a7b04dae64a118  .build/expert-lookahead/xla3-learned-20260915/cache/collect.json
2730d7aa290e6411a85eefcdf030464fb3da121f5967dc8fa92b31abd6e5bdc3  .build/expert-lookahead/xla3-learned-20260915/fit/fit.json
795b5fd1088ecb575e632e6e2ef97ef8092916230d3790620759c4f2bd43f5e8  .build/expert-lookahead/xla3-learned-20260915/fit/rank128.npz
07833448bd5b90a16061fcdc574e23861328da4a280af089941d56b3c7dcac80  .build/expert-lookahead/xla3-learned-20260915/twin.json
LEARNED ANALYSIS DONE (02:04:31)

[exited with code 0]
```

## Fit log, per target layer

```text
[01:57:44] T=1: lambda x0.01, cv 0.6291, validation tap 0.4124 full 0.5973 rank 0.5785 (8.6 s)
[01:57:53] T=2: lambda x0.1, cv 0.7617, validation tap 0.6632 full 0.7504 rank 0.7410 (8.7 s)
[01:58:01] T=3: lambda x0.1, cv 0.7116, validation tap 0.5784 full 0.6904 rank 0.6835 (8.4 s)
[01:58:10] T=4: lambda x0.1, cv 0.7880, validation tap 0.7139 full 0.7708 rank 0.7662 (8.4 s)
[01:58:18] T=5: lambda x0.1, cv 0.8128, validation tap 0.6909 full 0.7941 rank 0.7852 (8.5 s)
[01:58:27] T=6: lambda x0.1, cv 0.8481, validation tap 0.7522 full 0.8369 rank 0.8306 (8.5 s)
[01:58:35] T=7: lambda x0.1, cv 0.8614, validation tap 0.7792 full 0.8382 rank 0.8358 (8.6 s)
[01:58:44] T=8: lambda x0.1, cv 0.8377, validation tap 0.7604 full 0.8273 rank 0.8254 (8.7 s)
[01:58:53] T=9: lambda x1.0, cv 0.7967, validation tap 0.7549 full 0.7873 rank 0.7851 (8.5 s)
[01:59:01] T=10: lambda x1.0, cv 0.8266, validation tap 0.7744 full 0.8202 rank 0.8168 (8.5 s)
[01:59:10] T=11: lambda x1.0, cv 0.7928, validation tap 0.7114 full 0.7870 rank 0.7847 (8.5 s)
[01:59:18] T=12: lambda x1.0, cv 0.8838, validation tap 0.8333 full 0.8690 rank 0.8673 (8.5 s)
[01:59:27] T=13: lambda x0.1, cv 0.7917, validation tap 0.6940 full 0.7767 rank 0.7727 (8.5 s)
[01:59:35] T=14: lambda x1.0, cv 0.7682, validation tap 0.6785 full 0.7444 rank 0.7413 (8.4 s)
[01:59:43] T=15: lambda x1.0, cv 0.7357, validation tap 0.6102 full 0.7016 rank 0.6957 (8.4 s)
[01:59:52] T=16: lambda x1.0, cv 0.7905, validation tap 0.7366 full 0.7762 rank 0.7718 (8.4 s)
[02:00:00] T=17: lambda x1.0, cv 0.7999, validation tap 0.7338 full 0.7942 rank 0.7907 (8.4 s)
[02:00:09] T=18: lambda x0.1, cv 0.8750, validation tap 0.8023 full 0.8566 rank 0.8518 (8.5 s)
[02:00:17] T=19: lambda x1.0, cv 0.7996, validation tap 0.7025 full 0.7807 rank 0.7776 (8.5 s)
[02:00:25] T=20: lambda x1.0, cv 0.8223, validation tap 0.7246 full 0.7903 rank 0.7861 (8.2 s)
[02:00:34] T=21: lambda x0.1, cv 0.8161, validation tap 0.7242 full 0.7876 rank 0.7847 (8.1 s)
[02:00:42] T=22: lambda x1.0, cv 0.8869, validation tap 0.8235 full 0.8684 rank 0.8669 (8.3 s)
[02:00:50] T=23: lambda x1.0, cv 0.8506, validation tap 0.7595 full 0.8197 rank 0.8171 (8.1 s)
[02:00:58] T=24: lambda x0.1, cv 0.8600, validation tap 0.7663 full 0.8366 rank 0.8334 (8.1 s)
[02:01:06] T=25: lambda x1.0, cv 0.8182, validation tap 0.7320 full 0.7992 rank 0.7953 (8.2 s)
[02:01:15] T=26: lambda x0.1, cv 0.8257, validation tap 0.7421 full 0.7993 rank 0.7917 (8.4 s)
[02:01:23] T=27: lambda x1.0, cv 0.8118, validation tap 0.7077 full 0.7844 rank 0.7807 (8.5 s)
[02:01:32] T=28: lambda x1.0, cv 0.8684, validation tap 0.7945 full 0.8409 rank 0.8394 (8.4 s)
[02:01:40] T=29: lambda x1.0, cv 0.8307, validation tap 0.7524 full 0.8135 rank 0.8100 (8.4 s)
[02:01:48] T=30: lambda x0.1, cv 0.7834, validation tap 0.6634 full 0.7545 rank 0.7486 (8.4 s)
[02:01:57] T=31: lambda x1.0, cv 0.7229, validation tap 0.5779 full 0.6793 rank 0.6734 (8.4 s)
[02:02:05] T=32: lambda x1.0, cv 0.8207, validation tap 0.7515 full 0.7942 rank 0.7921 (8.6 s)
[02:02:14] T=33: lambda x1.0, cv 0.8284, validation tap 0.7424 full 0.8130 rank 0.8102 (8.4 s)
[02:02:22] T=34: lambda x1.0, cv 0.8758, validation tap 0.7971 full 0.8483 rank 0.8452 (8.6 s)
[02:02:31] T=35: lambda x1.0, cv 0.8207, validation tap 0.7282 full 0.7973 rank 0.7935 (8.6 s)
[02:02:40] T=36: lambda x1.0, cv 0.8000, validation tap 0.6896 full 0.7684 rank 0.7634 (8.7 s)
[02:02:48] T=37: lambda x0.1, cv 0.8329, validation tap 0.7147 full 0.8062 rank 0.7986 (8.7 s)
[02:02:57] T=38: lambda x1.0, cv 0.8897, validation tap 0.8236 full 0.8628 rank 0.8605 (8.7 s)
[02:03:06] T=39: lambda x1.0, cv 0.8110, validation tap 0.6748 full 0.7668 rank 0.7596 (8.7 s)
[02:03:14] T=40: lambda x1.0, cv 0.8669, validation tap 0.8009 full 0.8387 rank 0.8355 (8.6 s)
[02:03:23] T=41: lambda x1.0, cv 0.8603, validation tap 0.7930 full 0.8324 rank 0.8298 (8.8 s)
[02:03:32] T=42: lambda x1.0, cv 0.8699, validation tap 0.8017 full 0.8513 rank 0.8461 (8.7 s)
[02:03:40] T=43: lambda x1.0, cv 0.8711, validation tap 0.8029 full 0.8461 rank 0.8447 (8.5 s)
[02:03:49] T=44: lambda x1.0, cv 0.8641, validation tap 0.7440 full 0.8410 rank 0.8383 (8.6 s)
[02:03:58] T=45: lambda x0.1, cv 0.8465, validation tap 0.7003 full 0.8163 rank 0.8105 (8.6 s)
[02:04:06] T=46: lambda x0.1, cv 0.8396, validation tap 0.6610 full 0.8195 rank 0.8101 (8.6 s)
[02:04:15] T=47: lambda x0.1, cv 0.8539, validation tap 0.5784 full 0.8278 rank 0.8189 (8.4 s)
form               rows   top10   exact   rec16   rec24
tap              141450  0.7292  0.0530  0.8565  0.9162
tap_recorded     141450  0.7292  0.0530  0.8565  0.9162
full             141450  0.8023  0.1062  0.9195  0.9604
rank             141450  0.7980  0.1012  0.9163  0.9585
gains: full +0.0731, rank-128 +0.0688; FP16 weights full 117.5 MiB, rank 35.2 MiB
```
