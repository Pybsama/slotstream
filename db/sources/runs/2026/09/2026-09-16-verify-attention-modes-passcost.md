---
type: run
id: 01m2r4z7spa77wrdggwtt8jdhm
created: 2026-09-17T17:00:03.254798+00:00
updated: 2026-09-17T17:00:41.892150+00:00
summary: 'Verify pass cost by attention mode from 4k to 65k tokens: dense, split and gathered keys'
binary: 'development builds of 4d66b10 plus the verify-pass diff (diff sha256 prefix 66d14635779d4696): 16:22 build for the length rungs; 21:28, 22:40, 22:48 and 22:52 builds (d991d71911ac242c) for the later rungs; earlier identities not captured'
captured_at: 2026-09-16
command: slotstream mtp-passcost --memory-gb 15|17|19 --max-context 32768|65536|70000 --prompt-file prompt_N.txt --positions 4 --max-batch 3 --max-tokens 48 --attention-modes stock,split,gather; later rungs with the row-0, cold-versus-warm and row-exact readings
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Verify pass cost by attention mode from 4k to 65k tokens: dense, split and gathered keys'
tool: slotstream mtp-passcost with the multi-row attention probes (development builds)
---
Raw output of `mtp-passcost` with the multi-row attention probes, one rung per prompt length, on the working tree at commit `4d66b10` (main, 2026-09-16) plus the uncommitted `Sources/Slotstream/Layers.swift` and `Sources/slotstream-cli/MTPCommands.swift` change (diff sha256 prefix `66d14635779d4696`): `MultiRowAttention` (`SLOTSTREAM_ATTENTION_ROWS=stock|split|gather`, default `stock`) and the passcost options `--prompt-file`, `--max-context`, `--attention-modes`. The binary that ran the rungs was the 16:22 development build of that tree; its identity was not captured before the later rebuild, so the source diff is the reproducible identity. Prompts are deterministic varied prose from `make_prompt.py` (sha256 prefix `2a629f4ca558953b`), cut with the model tokenizer to 4,056 / 16,344 / 32,728 / 65,496 tokens; the chat template adds the rest.

Each rung: `mtp-passcost --memory-gb M --max-context W --prompt-file prompt_N.txt --positions 4 --max-batch 3 --max-tokens 48 --attention-modes stock,split,gather`, with M/W = 15/32768 (4k, 16k), 17/65536 (32k), 19/70000 (65k). Every pass runs cold once (stock), then warm once per mode in rotating order from the same checkpoint; medians of 4 positions. `diff` is max |logit delta| over the stock pass's logit spread, `flips` counts top-1 changes over all rows and positions. The first 32k rung at 15 GB is kept and discarded: its 65,536-token window left a pool of 20 experts per layer, and the 3-row pass had 579 warm misses, so its 334 ms is SSD time.

Machine state: no other model process during any rung (checked before each), reclaimable memory printed at each rung start; the machine was otherwise in ordinary use (editor, browser). Between the 32k rung at 15 GB and the rerun at 17 GB, and before the 65k rung, the session paused for about four hours; timestamps are in the log.

## Log

```text
== rung 4096 tokens, 16:23:56, reclaimable 19.2 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (22.8 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.6s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 4068 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    51.4 ms  x1.00   [warm misses 0 | first run   147.4 ms, 236 misses]
  verify  k=2:    65.3 ms  x1.27   [warm misses 0 | first run   167.4 ms, 234 misses]
  verify  k=3:    77.6 ms  x1.51   [warm misses 0 | first run   183.9 ms, 283 misses]
  draft step:       2.5 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    51.4 ms  x1.00
  split  k=1:    51.5 ms  x1.00   diff 0.00e+00  flips 0
  gather k=1:    51.5 ms  x1.00   diff 0.00e+00  flips 0
  stock  k=2:    65.3 ms  x1.27
  split  k=2:    65.3 ms  x1.27   diff 0.00e+00  flips 0
  gather k=2:    64.9 ms  x1.26   diff 0.00e+00  flips 0
  stock  k=3:    77.6 ms  x1.51
  split  k=3:    84.7 ms  x1.65   diff 4.61e-02  flips 1
  gather k=3:    86.8 ms  x1.69   diff 3.09e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 4096 done 16:24:48
== rung 16384 tokens, 16:24:48, reclaimable 27.4 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (29.5 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.0s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    54.5 ms  x1.00   [warm misses 0 | first run   135.8 ms, 199 misses]
  verify  k=2:    69.0 ms  x1.27   [warm misses 0 | first run   155.6 ms, 212 misses]
  verify  k=3:    96.8 ms  x1.78   [warm misses 0 | first run   175.5 ms, 177 misses]
  draft step:       2.8 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 16356 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    54.5 ms  x1.00
  split  k=1:    55.6 ms  x1.02   diff 0.00e+00  flips 0
  gather k=1:    54.3 ms  x1.00   diff 0.00e+00  flips 0
  stock  k=2:    69.0 ms  x1.27
  split  k=2:    68.8 ms  x1.26   diff 0.00e+00  flips 0
  gather k=2:    68.8 ms  x1.26   diff 0.00e+00  flips 0
  stock  k=3:    96.8 ms  x1.78
  split  k=3:    81.5 ms  x1.49   diff 2.51e-02  flips 0
  gather k=3:    83.2 ms  x1.53   diff 2.25e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 16384 done 16:27:16
== rung 32768 tokens, 16:27:16, reclaimable 24.7 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (29.5 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~20 of 512 experts per layer  (959 global slots = 2.7 GB pool)
  expect: ~14.0 GB peak, ~4 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~12.9 min before its first token here, follow-up turns read only what is new
  reuse:  up to 65536 tokens across 4 conversations (~2.2 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~20/512 per layer (959 global slots = 2.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 32740 tokens; context window 65536; modes: stock,split,gather
fetch-free pass cost at ~20 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    58.5 ms  x1.00   [warm misses 0 | first run   169.7 ms, 278 misses]
  verify  k=2:    72.9 ms  x1.25   [warm misses 0 | first run   192.7 ms, 308 misses]
  verify  k=3:   334.0 ms  x5.70   [warm misses 579 | first run   305.8 ms, 469 misses]
  draft step:       3.2 ms  x0.06   (one head step + lm_head, resident)
multi-row attention modes at 32740 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    58.5 ms  x1.00
  split  k=1:    59.7 ms  x1.02   diff 0.00e+00  flips 0
  gather k=1:    58.4 ms  x1.00   diff 0.00e+00  flips 0
  stock  k=2:    72.9 ms  x1.25
  split  k=2:    73.0 ms  x1.25   diff 0.00e+00  flips 0
  gather k=2:    72.8 ms  x1.24   diff 0.00e+00  flips 0
  stock  k=3:   334.0 ms  x5.70
  split  k=3:   319.9 ms  x5.46   diff 2.72e-02  flips 0
  gather k=3:   325.2 ms  x5.56   diff 1.85e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 32768 done 16:37:10
== rung 32768 tokens, 21:04:29, reclaimable 20.9 GB, target 17 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (25.0 GB reclaimable now), 40.2 GB Metal working set
  target: 17.0 GB total for this process
  cache:  ~33 of 512 experts per layer  (1562 global slots = 4.3 GB pool)
  expect: ~16.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~8.8 min before its first token here, follow-up turns read only what is new
  reuse:  up to 65536 tokens across 4 conversations (~2.2 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.3s: expert cache ~33/512 per layer (1562 global slots = 4.3 GB), mtp draft head on, eos [248044, 248046]
prompt: 32740 tokens; context window 65536; modes: stock,split,gather
fetch-free pass cost at ~33 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    57.8 ms  x1.00   [warm misses 0 | first run   131.4 ms, 168 misses]
  verify  k=2:    74.2 ms  x1.28   [warm misses 0 | first run   158.7 ms, 193 misses]
  verify  k=3:   123.6 ms  x2.14   [warm misses 0 | first run   235.2 ms, 268 misses]
  draft step:       3.0 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 32740 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    57.8 ms  x1.00
  split  k=1:    56.8 ms  x0.98   diff 0.00e+00  flips 0
  gather k=1:    57.1 ms  x0.99   diff 0.00e+00  flips 0
  stock  k=2:    74.2 ms  x1.28
  split  k=2:    73.9 ms  x1.28   diff 0.00e+00  flips 0
  gather k=2:    73.1 ms  x1.27   diff 0.00e+00  flips 0
  stock  k=3:   123.6 ms  x2.14
  split  k=3:    84.3 ms  x1.46   diff 1.86e-02  flips 0
  gather k=3:    85.9 ms  x1.49   diff 2.23e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 32768 done 21:10:49
== rung 65536 tokens, 21:11:37, reclaimable 27.5 GB, target 19 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (29.7 GB reclaimable now), 40.2 GB Metal working set
  target: 19.0 GB total for this process
  cache:  ~39 of 512 experts per layer  (1889 global slots = 5.2 GB pool)
  expect: ~18.0 GB peak, ~7 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 70000 tokens per request (prompt + reply, +2.1 GB state and transient reserve charged above); a full-length prompt takes ~8.7 min before its first token here, follow-up turns read only what is new
  reuse:  up to 70000 tokens across 4 conversations (~2.3 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.0s: expert cache ~39/512 per layer (1889 global slots = 5.2 GB), mtp draft head on, eos [248044, 248046]
prompt: 65508 tokens; context window 70000; modes: stock,split,gather
fetch-free pass cost at ~39 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    64.2 ms  x1.00   [warm misses 0 | first run   158.3 ms, 197 misses]
  verify  k=2:    81.2 ms  x1.26   [warm misses 0 | first run   160.6 ms, 187 misses]
  verify  k=3:   180.6 ms  x2.81   [warm misses 0 | first run   259.8 ms, 178 misses]
  draft step:       3.5 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 65508 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    64.2 ms  x1.00
  split  k=1:    65.0 ms  x1.01   diff 0.00e+00  flips 0
  gather k=1:    65.9 ms  x1.03   diff 0.00e+00  flips 0
  stock  k=2:    81.2 ms  x1.26
  split  k=2:    81.0 ms  x1.26   diff 0.00e+00  flips 0
  gather k=2:    81.4 ms  x1.27   diff 0.00e+00  flips 0
  stock  k=3:   180.6 ms  x2.81
  split  k=3:    99.2 ms  x1.54   diff 2.51e-02  flips 0
  gather k=3:    91.5 ms  x1.42   diff 2.53e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 65536 done 21:27:50
```

## Later rungs on the same tree (row-0 comparison, determinism, row-exact matmuls)

The passcost tool gained two more readings: row 0 of a k-row pass against the same position's 1-row stock pass (how far a multi-row pass sits from plain decode), and the stock pass's cold run against its warm run at the same k (run-to-run determinism). `SLOTSTREAM_ROW_EXACT_MATMUL=1` routes the three small dense matmuls per layer (fp32 router, bf16 hyper-connection down/up, bf16 inject) through one GEMV call per row instead of the split-K GEMM the backend picks at two rows or more. Each rung ran the latest development build of the same tree at its start: the 21:28 build for the row-0 rungs, the 22:40 build for the cold-versus-warm rung, the 22:48 build for the collapsed batched form and the 22:52 build (binary sha256 prefix `d991d71911ac242c`, recorded with the dispatch census) for the one-GEMV-per-row rungs; the identities of the earlier builds were not captured.

### row-0 rungs, 4k and 16k, flag off (22:33 to 22:36)

```text
== rung 4096 tokens, 22:33:44, reclaimable 33.5 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (35.7 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 4068 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    51.6 ms  x1.00   [warm misses 0 | first run   143.9 ms, 236 misses]
  verify  k=2:    65.5 ms  x1.27   [warm misses 0 | first run   150.2 ms, 234 misses]
  verify  k=3:    77.8 ms  x1.51   [warm misses 0 | first run   178.7 ms, 283 misses]
  draft step:       2.5 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    51.6 ms  x1.00
  split  k=1:    52.2 ms  x1.01   diff 0.00e+00  flips 0
  gather k=1:    51.3 ms  x0.99   diff 0.00e+00  flips 0
  stock  k=2:    65.5 ms  x1.27
  split  k=2:    65.7 ms  x1.27   diff 0.00e+00  flips 0
  gather k=2:    65.5 ms  x1.27   diff 0.00e+00  flips 0
  stock  k=3:    77.8 ms  x1.51
  split  k=3:    83.4 ms  x1.62   diff 4.61e-02  flips 1
  gather k=3:    86.4 ms  x1.67   diff 3.09e-02  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 3.04e-02  flips 1
  split  k=2 row0: diff 3.04e-02  flips 1
  gather k=2 row0: diff 3.04e-02  flips 1
  stock  k=3 row0: diff 2.78e-02  flips 0
  split  k=3 row0: diff 3.04e-02  flips 1
  gather k=3 row0: diff 3.18e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 4096 done 22:34:33
== rung 16384 tokens, 22:34:33, reclaimable 34.6 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (38.5 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    53.7 ms  x1.00   [warm misses 0 | first run   128.8 ms, 199 misses]
  verify  k=2:    68.4 ms  x1.27   [warm misses 0 | first run   147.2 ms, 212 misses]
  verify  k=3:    95.5 ms  x1.78   [warm misses 0 | first run   163.5 ms, 177 misses]
  draft step:       2.7 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 16356 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    53.7 ms  x1.00
  split  k=1:    53.3 ms  x0.99   diff 0.00e+00  flips 0
  gather k=1:    53.7 ms  x1.00   diff 0.00e+00  flips 0
  stock  k=2:    68.4 ms  x1.27
  split  k=2:    68.4 ms  x1.27   diff 0.00e+00  flips 0
  gather k=2:    68.6 ms  x1.28   diff 0.00e+00  flips 0
  stock  k=3:    95.5 ms  x1.78
  split  k=3:    80.3 ms  x1.49   diff 2.51e-02  flips 0
  gather k=3:    83.0 ms  x1.55   diff 2.25e-02  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 1.84e-02  flips 0
  split  k=2 row0: diff 1.84e-02  flips 0
  gather k=2 row0: diff 1.84e-02  flips 0
  stock  k=3 row0: diff 1.30e-02  flips 0
  split  k=3 row0: diff 1.84e-02  flips 0
  gather k=3 row0: diff 1.23e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 16384 done 22:36:46
```

### cold-versus-warm rung, 4k, flag off (22:42)

```text
== rung 4096 tokens, 22:42:50, reclaimable 30.3 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (35.7 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 4068 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    51.6 ms  x1.00   [warm misses 0 | first run   142.3 ms, 236 misses]
  verify  k=2:    65.7 ms  x1.27   [warm misses 0 | first run   154.8 ms, 234 misses]
  verify  k=3:    79.2 ms  x1.54   [warm misses 0 | first run   179.0 ms, 283 misses]
  draft step:       2.5 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    51.6 ms  x1.00
  split  k=1:    52.9 ms  x1.03   diff 0.00e+00  flips 0
  gather k=1:    51.9 ms  x1.01   diff 0.00e+00  flips 0
  stock  k=2:    65.7 ms  x1.27
  split  k=2:    66.0 ms  x1.28   diff 0.00e+00  flips 0
  gather k=2:    65.9 ms  x1.28   diff 0.00e+00  flips 0
  stock  k=3:    79.2 ms  x1.54
  split  k=3:    82.6 ms  x1.60   diff 4.61e-02  flips 1
  gather k=3:    91.0 ms  x1.77   diff 3.09e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 3.04e-02  flips 1
  split  k=2 row0: diff 3.04e-02  flips 1
  gather k=2 row0: diff 3.04e-02  flips 1
  stock  k=3 row0: diff 2.78e-02  flips 0
  split  k=3 row0: diff 3.04e-02  flips 1
  gather k=3 row0: diff 3.18e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes)
== rung 4096 done 22:43:38
```

### row-exact rungs, 4k with the collapsed batched form (no effect) and 4k, 16k with one GEMV per row

```text
== rung 4096 tokens, 22:51:16, reclaimable 33.0 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (35.9 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 4068 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    53.8 ms  x1.00   [warm misses 0 | first run   140.3 ms, 236 misses]
  verify  k=2:    73.1 ms  x1.36   [warm misses 0 | first run   160.2 ms, 234 misses]
  verify  k=3:    80.3 ms  x1.49   [warm misses 0 | first run   178.9 ms, 283 misses]
  draft step:       2.6 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    53.8 ms  x1.00
  split  k=1:    55.3 ms  x1.03   diff 0.00e+00  flips 0
  gather k=1:    55.8 ms  x1.04   diff 0.00e+00  flips 0
  stock  k=2:    73.1 ms  x1.36
  split  k=2:    69.4 ms  x1.29   diff 0.00e+00  flips 0
  gather k=2:    67.7 ms  x1.26   diff 0.00e+00  flips 0
  stock  k=3:    80.3 ms  x1.49
  split  k=3:    84.8 ms  x1.58   diff 4.61e-02  flips 1
  gather k=3:    88.9 ms  x1.65   diff 3.09e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 3.04e-02  flips 1
  split  k=2 row0: diff 3.04e-02  flips 1
  gather k=2 row0: diff 3.04e-02  flips 1
  stock  k=3 row0: diff 2.78e-02  flips 0
  split  k=3 row0: diff 3.04e-02  flips 1
  gather k=3 row0: diff 3.18e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes); row-exact matmul on, 13830 calls
== rung 4096 done 22:52:06

== rung 4096 tokens, 22:53:21, reclaimable 33.8 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (36.4 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 4068 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    52.1 ms  x1.00   [warm misses 0 | first run   141.0 ms, 223 misses]
  verify  k=2:    66.8 ms  x1.28   [warm misses 0 | first run   156.5 ms, 237 misses]
  verify  k=3:    81.8 ms  x1.57   [warm misses 0 | first run   195.6 ms, 319 misses]
  draft step:       2.6 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    52.1 ms  x1.00
  split  k=1:    52.7 ms  x1.01   diff 0.00e+00  flips 0
  gather k=1:    51.7 ms  x0.99   diff 0.00e+00  flips 0
  stock  k=2:    66.8 ms  x1.28
  split  k=2:    66.9 ms  x1.28   diff 0.00e+00  flips 0
  gather k=2:    66.9 ms  x1.29   diff 0.00e+00  flips 0
  stock  k=3:    81.8 ms  x1.57
  split  k=3:    84.7 ms  x1.63   diff 3.42e-02  flips 1
  gather k=3:   103.6 ms  x1.99   diff 2.90e-02  flips 1
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  gather k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 2.59e-02  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  gather k=3 row0: diff 2.41e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes); row-exact matmul on, 13830 calls
== rung 4096 done 22:54:36
== rung 16384 tokens, 22:55:10, reclaimable 32.7 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (35.0 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
```

### row-exact rung, 16k, one GEMV per row (22:55 to 22:58)

```text
== rung 16384 tokens, 22:55:10, reclaimable 32.7 GB, target 15 GB
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (35.0 GB reclaimable now), 40.2 GB Metal working set
  target: 15.0 GB total for this process
  cache:  ~36 of 512 experts per layer  (1706 global slots = 4.7 GB pool)
  expect: ~14.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 25679 tokens across 4 conversations (~1.0 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.0s: expert cache ~36/512 per layer (1706 global slots = 4.7 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; modes: stock,split,gather
fetch-free pass cost at ~36 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    54.4 ms  x1.00   [warm misses 0 | first run   126.2 ms, 205 misses]
  verify  k=2:    69.6 ms  x1.28   [warm misses 0 | first run   148.4 ms, 199 misses]
  verify  k=3:   102.0 ms  x1.88   [warm misses 0 | first run   172.8 ms, 174 misses]
  draft step:       2.8 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 16356 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    54.4 ms  x1.00
  split  k=1:    54.8 ms  x1.01   diff 0.00e+00  flips 0
  gather k=1:    54.1 ms  x1.00   diff 0.00e+00  flips 0
  stock  k=2:    69.6 ms  x1.28
  split  k=2:    69.4 ms  x1.28   diff 0.00e+00  flips 0
  gather k=2:    70.5 ms  x1.30   diff 0.00e+00  flips 0
  stock  k=3:   102.0 ms  x1.88
  split  k=3:    87.1 ms  x1.60   diff 2.65e-02  flips 0
  gather k=3:    90.0 ms  x1.65   diff 2.63e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  gather k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 1.29e-02  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  gather k=3 row0: diff 1.68e-02  flips 0
  engaged: split 60 calls, gather 60 calls (attention layers x passes); row-exact matmul on, 17142 calls
== rung 16384 done 23:00:16
```
