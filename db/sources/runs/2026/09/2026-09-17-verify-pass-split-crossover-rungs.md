---
type: run
id: 01m2r4z7w03cd65pyejx09japy
created: 2026-09-17T17:00:03.328122+00:00
updated: 2026-09-17T17:00:44.664626+00:00
summary: Split verify attention crossover rungs at 13 GB, 4k to 16k tokens
binary: 60820d93c83f871f (00:06 development build) for the night rungs; f9e23f6cf3e31b29a1c83a9aec5bc64a8b0cf1543e1eb0ca9cdf3ce86536d9a8 for the 8,192-token rung
captured_at: 2026-09-17
command: slotstream mtp-passcost --memory-gb 13 --max-context 8192|16384|32768 --prompt-file prompt_N.txt --positions 4 --max-batch 3 --max-tokens 48 --attention-modes stock,split, with SLOTSTREAM_OPT_ROW_INVARIANT and SLOTSTREAM_OPT_COMPILED_HC per phase
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Split verify attention crossover rungs at 13 GB, 4k to 16k tokens
tool: slotstream mtp-passcost --attention-modes stock,split under a quiet-machine runner
---
Raw output of `mtp-passcost` rungs at a 13 GB target, each with the smallest context window that holds its prompt, on 2026-09-17 between 00:11 and 00:44 local time, plus one later 8,192-token rung. Purpose: place the context threshold for the split verify attention, price the row-invariant matmuls in their first form, and screen the fused hyper-connection read across processes.

Binary: sha256 prefix `60820d93c83f871f`, built 2026-09-17 00:06 from commit `6e25b00` plus the uncommitted verify-pass change (diff sha256 prefix `3a6271349faa55c4` over `Sources` and `Tools/verify.sh`, taken at 00:11; the build identity file was overwritten by later builds, so the diff hash is the identity). In this binary the row-invariant matmuls applied to passes of two to eight rows only, with one-row passes on the stock kernel. The later 8,192-token rung (09:45) ran on binary `f9e23f6cf3e31b29`, whose build identity and source archive are preserved in the verify-pass artifact.

Command per rung: `mtp-passcost --memory-gb 13 --max-context W --prompt-file prompt_N.txt --positions 4 --max-batch 3 --max-tokens 48 --attention-modes stock,split`, with W = 8192 for 4k and 6k, 16384 for 8k and 12k, 32768 for 16k. Environment per phase: A none; B `SLOTSTREAM_OPT_ROW_INVARIANT=1`; C `SLOTSTREAM_OPT_ROW_INVARIANT=1 SLOTSTREAM_OPT_COMPILED_HC=1`. Prompts: the deterministic prose of the earlier rungs (`make_prompt.py`); the 8k and 12k prompts carry an appended request to summarize the text, because the unmodified 8k prompt stopped after 4 tokens of reply.

Kept: phase A 4,068 tokens (00:19); phase B 4,068 (00:20), 6,116 (00:21), 12,279 (00:33), 16,356 (00:35); phase C 4,068 (00:39). Discarded, and kept here: the first phase A and B attempts (00:11 to 00:13), which ran beside another session's Swift build at load 7.4 (one-row pass 112.5 ms against about 52); the 00:25 8k attempt, stopped for the same reason; the 00:31 8k rung (one-row pass 112.2 ms and a two-row pass faster than it; reclaimable memory was 16.1 GB at its start against 27.6 to 32.9 GB for the neighboring rungs, a sign that another large process was running); the 00:40 phase C 16k rung (one-row pass 91.0 ms against 58.5); and the 09:45 8k rung, which overlapped another session's Mac app build (load 4.9 to 5.1; one-row pass 118.9 ms). The quiet waiter's rule for the kept rungs: no build or model process and a 1-minute load under 2.5 for 90 seconds before the rung.

## Log, 00:11 to 00:44

```text
#### phase A 00:11:20
== rung 4096 tokens, 00:11:20, reclaimable 30.6 GB, target 13 GB, total = 8192.00M  used = 6943.31M  free = 1248.69M  (encrypted), env ROW_INVARIANT=unset COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (32.8 GB reclaimable now), 40.2 GB Metal working set
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
prompt: 4068 tokens; context window 8192; modes: stock,split
fetch-free pass cost at ~29 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:   112.5 ms  x1.00   [warm misses 0 | first run   195.4 ms, 263 misses]
  verify  k=2:    94.8 ms  x0.84   [warm misses 0 | first run   276.4 ms, 249 misses]
  verify  k=3:   119.7 ms  x1.06   [warm misses 0 | first run   246.1 ms, 282 misses]
  draft step:       3.5 ms  x0.03   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:   112.5 ms  x1.00
  split  k=1:   108.9 ms  x0.97   diff 0.00e+00  flips 0
  stock  k=2:    94.8 ms  x0.84
  split  k=2:    95.4 ms  x0.85   diff 0.00e+00  flips 0
  stock  k=3:   119.7 ms  x1.06
  split  k=3:   126.7 ms  x1.13   diff 2.81e-02  flips 2
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 3.04e-02  flips 1
  split  k=2 row0: diff 3.04e-02  flips 1
  stock  k=3 row0: diff 1.49e-02  flips 0
  split  k=3 row0: diff 3.04e-02  flips 1
  engaged: split 60 layer passes; row-invariant matmul off, 0 calls; fused hyper-connection read 0 calls
== rung 4096 done 00:12:24, total = 8192.00M  used = 6943.31M  free = 1248.69M  (encrypted)
#### phase B 00:12:24
== rung 4096 tokens, 00:12:24, reclaimable 31.7 GB, target 13 GB, total = 8192.00M  used = 6943.31M  free = 1248.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (33.7 GB reclaimable now), 40.2 GB Metal working set
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
rung 4096 failed; stop
#### discarded at 00:13:19: rungs ran beside another session's swift-build (load average 7.4, k=1 at 112 ms against a 51 ms reference); rerun after the machine is quiet
#### machine quiet (load 2.12) after 390s; starting rungs 00:19:55
#### phase A 00:19:55
== rung 4096 tokens, 00:19:55, reclaimable 28.9 GB, target 13 GB, total = 8192.00M  used = 6919.31M  free = 1272.69M  (encrypted), env ROW_INVARIANT=unset COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (31.9 GB reclaimable now), 40.2 GB Metal working set
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
prompt: 4068 tokens; context window 8192; modes: stock,split
fetch-free pass cost at ~29 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    52.6 ms  x1.00   [warm misses 0 | first run   148.8 ms, 263 misses]
  verify  k=2:    65.9 ms  x1.25   [warm misses 0 | first run   164.1 ms, 249 misses]
  verify  k=3:    77.8 ms  x1.48   [warm misses 0 | first run   181.2 ms, 282 misses]
  draft step:       2.4 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    52.6 ms  x1.00
  split  k=1:    53.1 ms  x1.01   diff 0.00e+00  flips 0
  stock  k=2:    65.9 ms  x1.25
  split  k=2:    70.5 ms  x1.34   diff 0.00e+00  flips 0
  stock  k=3:    77.8 ms  x1.48
  split  k=3:    84.6 ms  x1.61   diff 2.81e-02  flips 2
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 3.04e-02  flips 1
  split  k=2 row0: diff 3.04e-02  flips 1
  stock  k=3 row0: diff 1.49e-02  flips 0
  split  k=3 row0: diff 3.04e-02  flips 1
  engaged: split 60 layer passes; row-invariant matmul off, 0 calls; fused hyper-connection read 0 calls
== rung 4096 done 00:20:54, total = 8192.00M  used = 6919.31M  free = 1272.69M  (encrypted)
#### phase B 00:20:54
== rung 4096 tokens, 00:20:54, reclaimable 32.9 GB, target 13 GB, total = 8192.00M  used = 6919.31M  free = 1272.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.7 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~29 of 512 experts per layer  (1399 global slots = 3.9 GB pool)
  expect: ~12.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 8192 tokens per request (prompt + reply); a full-length prompt takes ~1.1 min before its first token here, follow-up turns read only what is new
  reuse:  up to 8192 tokens across 4 conversations (~0.6 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~29/512 per layer (1399 global slots = 3.9 GB), mtp draft head on, eos [248044, 248046]
prompt: 4068 tokens; context window 8192; modes: stock,split
fetch-free pass cost at ~29 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    52.2 ms  x1.00   [warm misses 1 | first run   149.9 ms, 263 misses]
  verify  k=2:    67.4 ms  x1.29   [warm misses 0 | first run   159.7 ms, 254 misses]
  verify  k=3:    79.6 ms  x1.53   [warm misses 0 | first run   183.6 ms, 268 misses]
  draft step:       2.4 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    52.2 ms  x1.00
  split  k=1:    53.2 ms  x1.02   diff 0.00e+00  flips 0
  stock  k=2:    67.4 ms  x1.29
  split  k=2:    67.7 ms  x1.30   diff 0.00e+00  flips 0
  stock  k=3:    79.6 ms  x1.53
  split  k=3:    85.7 ms  x1.64   diff 2.51e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 2.81e-02  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 9685 calls; fused hyper-connection read 0 calls
== rung 4096 done 00:21:53, total = 8192.00M  used = 6775.31M  free = 1416.69M  (encrypted)
== rung 6144 tokens, 00:21:53, reclaimable 31.7 GB, target 13 GB, total = 8192.00M  used = 6775.31M  free = 1416.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.1 GB reclaimable now), 40.2 GB Metal working set
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
prompt: 6116 tokens; context window 8192; modes: stock,split
fetch-free pass cost at ~29 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    57.4 ms  x1.00   [warm misses 0 | first run   137.7 ms, 202 misses]
  verify  k=2:    77.1 ms  x1.34   [warm misses 0 | first run   153.1 ms, 189 misses]
  verify  k=3:    93.9 ms  x1.63   [warm misses 0 | first run   176.3 ms, 220 misses]
  draft step:       2.7 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 6116 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    57.4 ms  x1.00
  split  k=1:    57.6 ms  x1.00   diff 0.00e+00  flips 0
  stock  k=2:    77.1 ms  x1.34
  split  k=2:    77.0 ms  x1.34   diff 0.00e+00  flips 0
  stock  k=3:    93.9 ms  x1.63
  split  k=3:    92.2 ms  x1.61   diff 2.06e-02  flips 1
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 1.10e-02  flips 1
  split  k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 9685 calls; fused hyper-connection read 0 calls
== rung 6144 done 00:23:17, total = 8192.00M  used = 6775.31M  free = 1416.69M  (encrypted)
== rung 8192 tokens, 00:23:18, reclaimable 31.7 GB, target 13 GB, total = 8192.00M  used = 6775.31M  free = 1416.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.1 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~27 of 512 experts per layer  (1317 global slots = 3.6 GB pool)
  expect: ~12.0 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 16384 tokens per request (prompt + reply); a full-length prompt takes ~2.2 min before its first token here, follow-up turns read only what is new
  reuse:  up to 16384 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.2s: expert cache ~27/512 per layer (1317 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
Error: continuation too short: 4 tokens; lower --positions or raise --max-tokens
prompt: 8164 tokens; context window 16384; modes: stock,split
rung 8192 failed; stop
#### phase B failed
#### phase B resumed 00:25:23 (8k and 12k prompts carry an appended summary request so the plain continuation is long enough)
== rung 8192 tokens, 00:25:23, reclaimable 29.3 GB, target 13 GB, total = 8192.00M  used = 6767.31M  free = 1424.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (32.0 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~27 of 512 experts per layer  (1317 global slots = 3.6 GB pool)
  expect: ~12.0 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 16384 tokens per request (prompt + reply); a full-length prompt takes ~2.2 min before its first token here, follow-up turns read only what is new
  reuse:  up to 16384 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.5s: expert cache ~27/512 per layer (1317 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
#### discarded at 00:25:43: the resumed 8k rung started beside another session's swift-build (load 6.5); rerun after the machine is quiet
#### machine quiet (load 2.08) after 330s; starting rungs 00:31:14
#### phase B resumed 00:31:14 (8k and 12k prompts carry an appended summary request so the plain continuation is long enough)
== rung 8192 tokens, 00:31:14, reclaimable 16.1 GB, target 13 GB, total = 8192.00M  used = 6759.31M  free = 1432.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (24.3 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~27 of 512 experts per layer  (1317 global slots = 3.6 GB pool)
  expect: ~12.0 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 16384 tokens per request (prompt + reply); a full-length prompt takes ~2.2 min before its first token here, follow-up turns read only what is new
  reuse:  up to 16384 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.4s: expert cache ~27/512 per layer (1317 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
prompt: 8183 tokens; context window 16384; modes: stock,split
fetch-free pass cost at ~27 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:   112.2 ms  x1.00   [warm misses 0 | first run   182.2 ms, 193 misses]
  verify  k=2:    94.4 ms  x0.84   [warm misses 0 | first run   271.9 ms, 232 misses]
  verify  k=3:   144.7 ms  x1.29   [warm misses 0 | first run   248.8 ms, 262 misses]
  draft step:       3.0 ms  x0.03   (one head step + lm_head, resident)
multi-row attention modes at 8183 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:   112.2 ms  x1.00
  split  k=1:   111.5 ms  x0.99   diff 0.00e+00  flips 0
  stock  k=2:    94.4 ms  x0.84
  split  k=2:   114.5 ms  x1.02   diff 0.00e+00  flips 0
  stock  k=3:   144.7 ms  x1.29
  split  k=3:   130.5 ms  x1.16   diff 1.62e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 9.43e-03  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 9685 calls; fused hyper-connection read 0 calls
== rung 8192 done 00:33:08, total = 8192.00M  used = 6759.31M  free = 1432.69M  (encrypted)
== rung 12288 tokens, 00:33:08, reclaimable 27.6 GB, target 13 GB, total = 8192.00M  used = 6759.31M  free = 1432.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (28.8 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~27 of 512 experts per layer  (1317 global slots = 3.6 GB pool)
  expect: ~12.0 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 16384 tokens per request (prompt + reply); a full-length prompt takes ~2.2 min before its first token here, follow-up turns read only what is new
  reuse:  up to 16384 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.1s: expert cache ~27/512 per layer (1317 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
prompt: 12279 tokens; context window 16384; modes: stock,split
fetch-free pass cost at ~27 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    60.6 ms  x1.00   [warm misses 0 | first run   154.7 ms, 207 misses]
  verify  k=2:    76.5 ms  x1.26   [warm misses 0 | first run   180.5 ms, 236 misses]
  verify  k=3:    97.1 ms  x1.60   [warm misses 0 | first run   198.8 ms, 269 misses]
  draft step:       2.7 ms  x0.04   (one head step + lm_head, resident)
multi-row attention modes at 12279 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    60.6 ms  x1.00
  split  k=1:    58.8 ms  x0.97   diff 0.00e+00  flips 0
  stock  k=2:    76.5 ms  x1.26
  split  k=2:    78.5 ms  x1.29   diff 0.00e+00  flips 0
  stock  k=3:    97.1 ms  x1.60
  split  k=3:    89.3 ms  x1.47   diff 1.48e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 1.39e-02  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 9685 calls; fused hyper-connection read 0 calls
== rung 12288 done 00:35:58, total = 8192.00M  used = 6743.31M  free = 1448.69M  (encrypted)
== rung 16384 tokens, 00:35:58, reclaimable 32.0 GB, target 13 GB, total = 8192.00M  used = 6743.31M  free = 1448.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=unset
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.3 GB reclaimable now), 40.2 GB Metal working set
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
prompt: 16356 tokens; context window 32768; modes: stock,split
fetch-free pass cost at ~27 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    58.5 ms  x1.00   [warm misses 0 | first run   145.2 ms, 230 misses]
  verify  k=2:    71.0 ms  x1.21   [warm misses 0 | first run   158.2 ms, 217 misses]
  verify  k=3:    98.0 ms  x1.68   [warm misses 0 | first run   192.0 ms, 251 misses]
  draft step:       2.6 ms  x0.04   (one head step + lm_head, resident)
multi-row attention modes at 16356 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    58.5 ms  x1.00
  split  k=1:    55.1 ms  x0.94   diff 0.00e+00  flips 0
  stock  k=2:    71.0 ms  x1.21
  split  k=2:    72.6 ms  x1.24   diff 0.00e+00  flips 0
  stock  k=3:    98.0 ms  x1.68
  split  k=3:    86.8 ms  x1.48   diff 2.04e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 1.30e-02  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 9685 calls; fused hyper-connection read 0 calls
== rung 16384 done 00:39:19, total = 8192.00M  used = 6743.31M  free = 1448.69M  (encrypted)
#### phase C 00:39:19
== rung 4096 tokens, 00:39:19, reclaimable 32.7 GB, target 13 GB, total = 8192.00M  used = 6743.31M  free = 1448.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=1
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.8 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~29 of 512 experts per layer  (1399 global slots = 3.9 GB pool)
  expect: ~12.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 8192 tokens per request (prompt + reply); a full-length prompt takes ~1.1 min before its first token here, follow-up turns read only what is new
  reuse:  up to 8192 tokens across 4 conversations (~0.6 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~29/512 per layer (1399 global slots = 3.9 GB), mtp draft head on, eos [248044, 248046]
prompt: 4068 tokens; context window 8192; modes: stock,split
fetch-free pass cost at ~29 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    52.8 ms  x1.00   [warm misses 1 | first run   139.7 ms, 263 misses]
  verify  k=2:    70.0 ms  x1.33   [warm misses 0 | first run   154.0 ms, 254 misses]
  verify  k=3:    84.0 ms  x1.59   [warm misses 0 | first run   186.1 ms, 268 misses]
  draft step:       2.4 ms  x0.05   (one head step + lm_head, resident)
multi-row attention modes at 4068 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    52.8 ms  x1.00
  split  k=1:    52.4 ms  x0.99   diff 0.00e+00  flips 0
  stock  k=2:    70.0 ms  x1.33
  split  k=2:    72.9 ms  x1.38   diff 0.00e+00  flips 0
  stock  k=3:    84.0 ms  x1.59
  split  k=3:    84.9 ms  x1.61   diff 2.51e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 2.81e-02  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 9685 calls; fused hyper-connection read 7323 calls
== rung 4096 done 00:40:20, total = 8192.00M  used = 6743.31M  free = 1448.69M  (encrypted)
== rung 16384 tokens, 00:40:20, reclaimable 32.9 GB, target 13 GB, total = 8192.00M  used = 6743.31M  free = 1448.69M  (encrypted), env ROW_INVARIANT=1 COMPILED_HC=1
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.6 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~27 of 512 experts per layer  (1296 global slots = 3.6 GB pool)
  expect: ~12.0 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 18446 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.0s: expert cache ~27/512 per layer (1296 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; modes: stock,split
fetch-free pass cost at ~27 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:    91.0 ms  x1.00   [warm misses 0 | first run   143.6 ms, 230 misses]
  verify  k=2:   101.8 ms  x1.12   [warm misses 0 | first run   264.0 ms, 217 misses]
  verify  k=3:   130.0 ms  x1.43   [warm misses 0 | first run   230.9 ms, 251 misses]
  draft step:       2.8 ms  x0.03   (one head step + lm_head, resident)
multi-row attention modes at 16356 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock  k=1:    91.0 ms  x1.00
  split  k=1:    67.4 ms  x0.74   diff 0.00e+00  flips 0
  stock  k=2:   101.8 ms  x1.12
  split  k=2:   100.5 ms  x1.10   diff 0.00e+00  flips 0
  stock  k=3:   130.0 ms  x1.43
  split  k=3:   121.0 ms  x1.33   diff 2.04e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock  k=2 row0: diff 0.00e+00  flips 0
  split  k=2 row0: diff 0.00e+00  flips 0
  stock  k=3 row0: diff 1.30e-02  flips 0
  split  k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 9685 calls; fused hyper-connection read 12658 calls
== rung 16384 done 00:43:58, total = 8192.00M  used = 6727.31M  free = 1464.69M  (encrypted)
#### all phases done 00:43:58
```

## Log, the 09:45 rung

```text
#### quiet (load 1.76) after 1380s at 09:45:00
== rung 8192 row-invariant 09:45:00 reclaimable 29.7 GB target 13 GB load { 1.64 3.38 4.08 } total = 7168.00M  used = 6262.81M  free = 905.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (33.4 GB reclaimable now), 40.2 GB Metal working set
  target: 13.0 GB total for this process
  cache:  ~27 of 512 experts per layer  (1317 global slots = 3.6 GB pool)
  expect: ~12.0 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 16384 tokens per request (prompt + reply); a full-length prompt takes ~2.2 min before its first token here, follow-up turns read only what is new
  reuse:  up to 16384 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.0s: expert cache ~27/512 per layer (1317 global slots = 3.6 GB), mtp draft head on, eos [248044, 248046]
#### interference during rung 8192 row-invariant at 09:45:10: 10451 /bin/zsh -c source /Users/carlos/.claude/shell-snapshots/snapshot-zsh-1789
#### interference during rung 8192 row-invariant at 09:46:25: 10771 /bin/zsh -c source /Users/carlos/.claude/shell-snapshots/snapshot-zsh-1789
#### interference during rung 8192 row-invariant at 09:46:31: 10771 /bin/zsh -c source /Users/carlos/.claude/shell-snapshots/snapshot-zsh-1789
#### interference during rung 8192 row-invariant at 09:46:36: 10771 /bin/zsh -c source /Users/carlos/.claude/shell-snapshots/snapshot-zsh-1789
#### interference during rung 8192 row-invariant at 09:46:41: 10771 /bin/zsh -c source /Users/carlos/.claude/shell-snapshots/snapshot-zsh-1789
prompt: 8183 tokens; context window 16384; modes: stock,split
fetch-free pass cost at ~27 experts/layer, median of 4 positions (ms; ratio to the 1-token pass):
  verify  k=1:   118.9 ms  x1.00   [warm misses 0 | first run   154.6 ms, 193 misses]
  verify  k=2:   106.7 ms  x0.90   [warm misses 0 | first run   273.0 ms, 232 misses]
  verify  k=3:   143.6 ms  x1.21   [warm misses 0 | first run   284.7 ms, 262 misses]
  draft step:       3.2 ms  x0.03   (one head step + lm_head, resident)
multi-row attention modes at 8183 prompt tokens (warm ms, median of 4 positions; diff = max |logit delta| / stock logit spread, median; flips = top-1 changes over all rows and positions):
  stock    k=1:   118.9 ms  x1.00
  split    k=1:   102.3 ms  x0.86   diff 0.00e+00  flips 0
  stock    k=2:   106.7 ms  x0.90
  split    k=2:   141.6 ms  x1.19   diff 0.00e+00  flips 0
  stock    k=3:   143.6 ms  x1.21
  split    k=3:   119.9 ms  x1.01   diff 1.62e-02  flips 0
  stock pass, cold run against warm run at the same k (max |delta| / spread, median; top-1 flips over all rows):
  stock  k=1 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=2 cold-vs-warm: diff 0.00e+00  flips 0
  stock  k=3 cold-vs-warm: diff 0.00e+00  flips 0
  row 0 against the same position's 1-row stock pass (max |delta| / spread, median; top-1 flips):
  stock    k=2 row0: diff 0.00e+00  flips 0
  split    k=2 row0: diff 0.00e+00  flips 0
  stock    k=3 row0: diff 9.43e-03  flips 0
  split    k=3 row0: diff 0.00e+00  flips 0
  engaged: split 60 layer passes; row-invariant matmul on, 26847 calls; fused hyper-connection read 0 calls
== rung 8192 row-invariant exit 0 09:46:45 load { 4.94 4.03 4.25 }
#### discarded: the 8192 rung at 09:45 overlapped another session's Mac app build (load 4.9 to 5.1); one-row pass 118.9 ms
```
