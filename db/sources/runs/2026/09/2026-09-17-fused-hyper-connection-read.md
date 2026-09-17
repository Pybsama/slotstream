---
type: run
id: 01m2r4z7x8gw3mvbzahfjstqea
created: 2026-09-17T17:00:03.368961+00:00
updated: 2026-09-17T17:00:42.770775+00:00
summary: Fused hyper-connection read against the eager read at 16k and 4k tokens
binary: f9e23f6cf3e31b29a1c83a9aec5bc64a8b0cf1543e1eb0ca9cdf3ce86536d9a8
captured_at: 2026-09-17
command: slotstream mtp-passcost --memory-gb 13 --max-context 32768|8192 --prompt-file prompt_16384.txt|prompt_4096b.txt --positions 8 --max-batch 3 --attention-modes stock,stock-hc,split,split-hc
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Fused hyper-connection read against the eager read at 16k and 4k tokens
tool: slotstream mtp-passcost --attention-modes stock,stock-hc,split,split-hc
---
Raw output of `mtp-passcost` with the fused hyper-connection read toggled pass by pass in one process (`--attention-modes stock,stock-hc,split,split-hc`; `-hc` runs the read's pointwise work as three compiled kernels, the gate `silu(down / 4)`, the stream mix `mean(sigmoid(up) * normed)` and the inject `2 * sigmoid(p / 4)`, between the unchanged projections), 13 GB target, eight positions per rung, binary sha256 prefix `f9e23f6cf3e31b29` (build identity and source archive preserved in the artifact [speculative-verify-pass-2026-09-17](../../../artifacts/speculative-verify-pass-2026-09-17/manifest.json)), 2026-09-17. The fused read is built only after a self-test finds each stage bit-identical to the eager arithmetic on synthetic bf16 values.

The 16,356-token run (10:05, 32,768-token window) ran while the whole machine was slower than in earlier rungs: its one-row pass read 94.9 ms and its draft step 4.7 ms, against 58.5 and 2.6 ms in the 00:35 rung with the same prompt, and two variants that are the same computation at two rows (`stock` and `split`) differ by 7.7 ms. No build or model process ran, the Mac was on AC power with no thermal or performance warning recorded, and the cause was not found. The run is kept for its bit-equality result (every `-hc` variant 0 difference from its eager twin at every k) and not used for timing. A first 4,068-token attempt (10:01) stopped because that prompt's reply was 16 tokens, too short for eight positions; the 4k rung below uses the same prompt with an appended request to summarize it.

## 16,356 tokens (10:05)

```text
== fused read A/B 16384 (attempt 1) 10:05:25 reclaimable 30.5 GB target 13 GB load { 2.42 3.06 3.84 } total = 7168.00M  used = 6262.81M  free = 905.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (33.4 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~27 of 512 experts per layer  (1296 global slots = 3.6 GB pool)
  expect: ~12.0 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 18446 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~27/512 per layer (1296 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; modes: stock,stock-hc,split,split-hc
fetch-free pass cost at ~27 experts/layer, median of 8 positions (ms; ratio to the 1-token pass):
  verify  k=1:    94.9 ms  x1.00   [warm misses 0 | first run   253.8 ms, 248 misses]
  verify  k=2:   123.6 ms  x1.30   [warm misses 0 | first run   269.9 ms, 232 misses]
  verify  k=3:   172.9 ms  x1.82   [warm misses 0 | first run   332.8 ms, 242 misses]
  draft step:       4.7 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 16356 prompt tokens (warm ms, median of 8 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock    k=1:    94.9 ms  x1.00
  stock-hc k=1:    94.1 ms  x0.99   diff 0.00e+00  flips 0
  split    k=1:    97.1 ms  x1.02   diff 0.00e+00  flips 0
  split-hc k=1:    95.6 ms  x1.01   diff 0.00e+00  flips 0
  stock    k=2:   123.6 ms  x1.30
  stock-hc k=2:   116.7 ms  x1.23   diff 0.00e+00  flips 0
  split    k=2:   115.9 ms  x1.22   diff 0.00e+00  flips 0
  split-hc k=2:   117.1 ms  x1.23   diff 0.00e+00  flips 0
  stock    k=3:   172.9 ms  x1.82
  stock-hc k=3:   164.6 ms  x1.73   diff 0.00e+00  flips 0
  split    k=3:   148.0 ms  x1.56   diff 2.56e-02  flips 0
  split-hc k=3:   133.2 ms  x1.40   diff 2.56e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock    k=2 row0: diff 1.55e-02  flips 0
  stock-hc k=2 row0: diff 1.55e-02  flips 0
  split    k=2 row0: diff 1.55e-02  flips 0
  split-hc k=2 row0: diff 1.55e-02  flips 0
  stock    k=3 row0: diff 1.29e-02  flips 0
  stock-hc k=3 row0: diff 1.29e-02  flips 0
  split    k=3 row0: diff 1.55e-02  flips 0
  split-hc k=3 row0: diff 1.55e-02  flips 0
  engaged: split 216 layer passes; row-invariant matmul off, 0 calls; fused hyper-connection read 5268 calls
== fused read A/B 16384 exit 0 10:09:24 load { 3.11 3.56 3.91 }
```

## 4,068 tokens, first attempt (10:01)

```text
== fused read A/B 4096 (attempt 1) 10:01:29 reclaimable 30.0 GB target 13 GB load { 1.80 3.18 4.07 } total = 7168.00M  used = 6262.81M  free = 905.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (33.6 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~29 of 512 experts per layer  (1399 global slots = 3.9 GB pool)
  expect: ~12.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 8192 tokens per request (prompt + reply); a full-length prompt takes ~1.1 min before its first token here, follow-up turns read only what is new
  reuse:  up to 8192 tokens across 4 conversations (~0.6 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.4s: expert cache ~29/512 per layer (1399 global slots = 3.9 GB), mtp draft head on, eos [248044, 248046]
Error: continuation too short: 16 tokens; lower --positions or raise --max-tokens
prompt: 4068 tokens; context window 8192; modes: stock,stock-hc,split,split-hc
== fused read A/B 4096 exit 1 10:02:23 load { 4.00 3.60 4.17 }
```

## 4,068 tokens with the appended summary request (10:44)

Command: `mtp-passcost --memory-gb 13 --max-context 8192 --prompt-file prompt_4096b.txt --positions 8 --max-batch 3 --max-tokens 64 --attention-modes stock,stock-hc,split,split-hc`. Quiet machine; no interference logged.

```text
#### seq8 start 10:42:50; binary f9e23f6cf3e31b29
#### quiet (load 1.60) after 90s at 10:44:21
== fused read A/B 4096b (attempt 1) 10:44:21 reclaimable 29.9 GB target 13 GB load { 1.24 2.65 3.36 } total = 7168.00M  used = 6238.81M  free = 929.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (33.3 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~29 of 512 experts per layer  (1399 global slots = 3.9 GB pool)
  expect: ~12.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 8192 tokens per request (prompt + reply); a full-length prompt takes ~1.1 min before its first token here, follow-up turns read only what is new
  reuse:  up to 8192 tokens across 4 conversations (~0.6 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.0s: expert cache ~29/512 per layer (1399 global slots = 3.9 GB), mtp draft head on, eos [248044, 248046]
prompt: 4087 tokens; context window 8192; modes: stock,stock-hc,split,split-hc
fetch-free pass cost at ~29 experts/layer, median of 8 positions (ms; ratio to the 1-token pass):
  verify  k=1:    50.9 ms  x1.00   [warm misses 0 | first run   129.2 ms, 198 misses]
  verify  k=2:    65.2 ms  x1.28   [warm misses 0 | first run   154.3 ms, 243 misses]
  verify  k=3:    77.1 ms  x1.52   [warm misses 0 | first run   165.1 ms, 236 misses]
  draft step:       2.5 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4087 prompt tokens (warm ms, median of 8 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock    k=1:    50.9 ms  x1.00
  stock-hc k=1:    50.7 ms  x1.00   diff 0.00e+00  flips 0
  split    k=1:    51.2 ms  x1.01   diff 0.00e+00  flips 0
  split-hc k=1:    50.5 ms  x0.99   diff 0.00e+00  flips 0
  stock    k=2:    65.2 ms  x1.28
  stock-hc k=2:    65.0 ms  x1.28   diff 0.00e+00  flips 0
  split    k=2:    64.9 ms  x1.28   diff 0.00e+00  flips 0
  split-hc k=2:    65.1 ms  x1.28   diff 0.00e+00  flips 0
  stock    k=3:    77.1 ms  x1.52
  stock-hc k=3:    76.6 ms  x1.51   diff 0.00e+00  flips 0
  split    k=3:    76.8 ms  x1.51   diff 1.50e-02  flips 0
  split-hc k=3:    72.6 ms  x1.43   diff 1.50e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock    k=2 row0: diff 1.47e-02  flips 0
  stock-hc k=2 row0: diff 1.47e-02  flips 0
  split    k=2 row0: diff 1.47e-02  flips 0
  split-hc k=2 row0: diff 1.47e-02  flips 0
  stock    k=3 row0: diff 1.03e-02  flips 0
  stock-hc k=3 row0: diff 1.03e-02  flips 0
  split    k=3 row0: diff 1.47e-02  flips 0
  split-hc k=3 row0: diff 1.47e-02  flips 0
  engaged: split 216 layer passes; row-invariant matmul off, 0 calls; fused hyper-connection read 5268 calls
== fused read A/B 4096b exit 0 10:45:35 load { 3.11 2.96 3.42 }
#### seq8 done 10:45:35
```
