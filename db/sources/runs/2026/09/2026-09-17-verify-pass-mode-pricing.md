---
type: run
id: 01m2reht9h71948vaw8jz3rp1k
created: 2026-09-17T19:47:29.201121+00:00
updated: 2026-09-17T19:47:29.614831+00:00
summary: Fetch-free verify pass cost of the stock, split and exact modes at 4k and 16k tokens
binary: 8d86f10f5b6696d444769308c07d678447b80a531476b48fb70a50988102dbc6
captured_at: 2026-09-17
command: slotstream mtp-passcost --memory-gb 13 --max-context 8192|32768 --prompt-file prompt_4096b.txt|prompt_16384b.txt --positions 6 --max-batch 3 --max-tokens 64 --attention-modes stock,split,exact
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Fetch-free verify pass cost of the stock, split and exact modes at 4k and 16k tokens
tool: slotstream mtp-passcost --attention-modes stock,split,exact under a quiet-machine runner
---
Raw output of `mtp-passcost` with the three verify-pass modes on the final build, binary 8d86f10f5b6696d444769308c07d678447b80a531476b48fb70a50988102dbc6 (run 1 from `.build/release`, the later rungs from the frozen copy of the same build), at a 13 GB target, six measurement positions after a warm-up, 2026-09-17 from 13:05 local under the quiet runner (no build, app check, serve gate or model-lock holder, 1-minute load under 3.0 for 90 s before the step). Each mode sets the verify-pass controls itself and the split threshold is lifted, so every mode is timed at every context: `stock` is the dense pass, `split` the two-row vector-kernel calls, `exact` the exact mode (row-invariant matmuls, one attention call per row from two rows up, per-row index selection). `diff` is the largest logit delta against the stock pass over the stock spread; `row0` compares row 0 of a k-row pass with the same position's one-row stock pass.

## 4,087-token prompt, 8,192-token window (run 1, 13:05)

Reading: the split matches the stock pass exactly at one and two rows, where it does not engage, and costs 0.5 ms at three rows on this short prompt, below the 6,144-token threshold where the dense kernel is still ahead. The exact mode costs 3.2 ms at one row (6%), 8.4 ms at two (13%) and 2.7 ms at three (3.5%) against the stock pass. Row 0 of an exact two-row or three-row pass is bit-identical to the one-row pass at its position; the stock and split rows sit 1.0% and 1.5% of the logit spread away from it.

```text
== pricing 4096b modes run 1 (attempt 3) 13:05:35 reclaimable 33.7 GB target 13 GB load { 1.43 2.26 2.73 } total = 7168.00M  used = 5966.81M  free = 1201.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (36.3 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~29 of 512 experts per layer  (1399 global slots = 3.9 GB pool)
  expect: ~12.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 8192 tokens per request (prompt + reply); a full-length prompt takes ~1.1 min before its first token here, follow-up turns read only what is new
  reuse:  up to 8192 tokens across 4 conversations (~0.6 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.1s: expert cache ~29/512 per layer (1399 global slots = 3.9 GB), mtp draft head on, eos [248044, 248046]
prompt: 4087 tokens; context window 8192; modes: stock,split,exact
fetch-free pass cost at ~29 experts/layer, median of 6 positions (ms; ratio to the 1-token pass):
  verify  k=1:    51.5 ms  x1.00   [warm misses 0 | first run   126.6 ms, 198 misses]
  verify  k=2:    65.0 ms  x1.26   [warm misses 0 | first run   142.8 ms, 213 misses]
  verify  k=3:    77.4 ms  x1.50   [warm misses 0 | first run   155.2 ms, 220 misses]
  draft step:       2.4 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4087 prompt tokens (warm ms, median of 6 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock    k=1:    51.5 ms  x1.00
  split    k=1:    51.4 ms  x1.00   diff 0.00e+00  flips 0
  exact    k=1:    54.7 ms  x1.06   diff 0.00e+00  flips 0
  stock    k=2:    65.0 ms  x1.26
  split    k=2:    65.0 ms  x1.26   diff 0.00e+00  flips 0
  exact    k=2:    73.4 ms  x1.42   diff 1.63e-02  flips 0
  stock    k=3:    77.4 ms  x1.50
  split    k=3:    77.9 ms  x1.51   diff 1.46e-02  flips 0
  exact    k=3:    80.1 ms  x1.55   diff 1.23e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock    k=2 row0: diff 1.54e-02  flips 0
  split    k=2 row0: diff 1.54e-02  flips 0
  exact    k=2 row0: diff 0.00e+00  flips 0
  stock    k=3 row0: diff 1.03e-02  flips 0
  split    k=3 row0: diff 1.54e-02  flips 0
  exact    k=3 row0: diff 0.00e+00  flips 0
  engaged: split or exact attention in 252 layer passes; row-invariant matmul in 5826 calls
== pricing 4096b modes run 1 exit 0 13:06:51 load { 3.20 2.70 2.86 }
```

## 4,087-token prompt, 8,192-token window (run 2, 14:07)

The same rung an hour later: every mode within about 1 ms of run 1.

```text
== pricing 4096b modes run 2 (attempt 1) 14:07:10 reclaimable 32.9 GB target 13 GB load { 1.97 2.36 3.27 } total = 7168.00M  used = 5996.00M  free = 1172.00M  (encrypted)
engine ready in 0.9s: expert cache ~29/512 per layer (1399 global slots = 3.9 GB), mtp draft head on, eos [248044, 248046]
prompt: 4087 tokens; context window 8192; modes: stock,split,exact
fetch-free pass cost at ~29 experts/layer, median of 6 positions (ms; ratio to the 1-token pass):
  verify  k=1:    52.6 ms  x1.00   [warm misses 0 | first run   127.9 ms, 198 misses]
  verify  k=2:    64.7 ms  x1.23   [warm misses 0 | first run   144.0 ms, 213 misses]
  verify  k=3:    77.1 ms  x1.47   [warm misses 0 | first run   155.7 ms, 220 misses]
  draft step:       2.4 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4087 prompt tokens (warm ms, median of 6 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock    k=1:    52.6 ms  x1.00
  split    k=1:    51.7 ms  x0.98   diff 0.00e+00  flips 0
  exact    k=1:    55.3 ms  x1.05   diff 0.00e+00  flips 0
  stock    k=2:    64.7 ms  x1.23
  split    k=2:    65.5 ms  x1.25   diff 0.00e+00  flips 0
  exact    k=2:    72.3 ms  x1.38   diff 1.63e-02  flips 0
  stock    k=3:    77.1 ms  x1.47
  split    k=3:    76.3 ms  x1.45   diff 1.46e-02  flips 0
  exact    k=3:    79.4 ms  x1.51   diff 1.23e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock    k=2 row0: diff 1.54e-02  flips 0
  split    k=2 row0: diff 1.54e-02  flips 0
  exact    k=2 row0: diff 0.00e+00  flips 0
  stock    k=3 row0: diff 1.03e-02  flips 0
  split    k=3 row0: diff 1.54e-02  flips 0
  exact    k=3 row0: diff 0.00e+00  flips 0
  engaged: split or exact attention in 252 layer passes; row-invariant matmul in 5826 calls
== pricing 4096b modes run 2 exit 0 14:08:19 load { 2.73 2.62 3.31 }
```

## 16,375-token prompt, 32,768-token window (14:09)

Above the threshold the split is ahead: 148.8 ms against 167.3 at three rows (11% cheaper), and 115.2 against 121.0 at two rows, where it does not engage and the difference is run-to-run noise. The exact mode costs 6.5% at one row and 15% at two, and at three rows it measured 144.4 ms, below both the split and the dense pass in this rung; the decode comparison at 22 GB put a whole exact verification round 1 to 2% above a split one, so treat the three-row cell as this rung's reading, not a general claim. Row 0 of an exact pass is again bit-identical to the one-row pass at its position, while the stock and split rows sit about 1% of the logit spread away, with one top-1 flip over the recorded rows.

```text
== pricing 16384b modes (attempt 1) 14:09:50 reclaimable 34.1 GB target 13 GB load { 1.16 2.13 3.04 } total = 7168.00M  used = 5996.00M  free = 1172.00M  (encrypted)
engine ready in 0.9s: expert cache ~27/512 per layer (1296 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
prompt: 16375 tokens; context window 32768; modes: stock,split,exact
fetch-free pass cost at ~27 experts/layer, median of 6 positions (ms; ratio to the 1-token pass):
  verify  k=1:    97.9 ms  x1.00   [warm misses 0 | first run   224.0 ms, 198 misses]
  verify  k=2:   121.0 ms  x1.24   [warm misses 0 | first run   224.5 ms, 217 misses]
  verify  k=3:   167.3 ms  x1.71   [warm misses 0 | first run   337.0 ms, 256 misses]
  draft step:       4.0 ms  x0.04   (one head step + lm_head, resident)
multi-row attention modes at 16375 prompt tokens (warm ms, median of 6 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock    k=1:    97.9 ms  x1.00
  split    k=1:    96.6 ms  x0.99   diff 0.00e+00  flips 0
  exact    k=1:   104.3 ms  x1.07   diff 0.00e+00  flips 0
  stock    k=2:   121.0 ms  x1.24
  split    k=2:   115.2 ms  x1.18   diff 0.00e+00  flips 0
  exact    k=2:   139.7 ms  x1.43   diff 1.30e-02  flips 0
  stock    k=3:   167.3 ms  x1.71
  split    k=3:   148.8 ms  x1.52   diff 1.39e-02  flips 1
  exact    k=3:   144.4 ms  x1.47   diff 1.63e-02  flips 1
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock    k=2 row0: diff 1.05e-02  flips 0
  split    k=2 row0: diff 1.05e-02  flips 0
  exact    k=2 row0: diff 0.00e+00  flips 0
  stock    k=3 row0: diff 1.06e-02  flips 0
  split    k=3 row0: diff 1.05e-02  flips 0
  exact    k=3 row0: diff 0.00e+00  flips 0
  engaged: split or exact attention in 252 layer passes; row-invariant matmul in 5826 calls
== pricing 16384b modes exit 0 14:13:42 load { 3.12 2.82 3.14 }
```
