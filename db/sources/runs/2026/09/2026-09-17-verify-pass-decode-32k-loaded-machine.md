---
type: run
id: 01m2r4z7yjtacaq77r9m730tg8
created: 2026-09-17T17:00:03.410300+00:00
updated: 2026-09-17T17:00:34.512588+00:00
summary: Decode comparison at 32k on a loaded machine, discarded for timing
binary: f9e23f6cf3e31b29a1c83a9aec5bc64a8b0cf1543e1eb0ca9cdf3ce86536d9a8
captured_at: 2026-09-17
command: slotstream mtp-bench --memory-gb 22 --max-context 33024 --prompt-file prompt_32768.txt --max-tokens 128 --pairs 2 --arms spec,split
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Decode comparison at 32k on a loaded machine, discarded for timing
tool: slotstream mtp-bench --arms
---
Raw output of the 32k decode comparison on binary f9e23f6cf3e31b29 (split threshold 8,192 keys, split off by default in that build), 2026-09-17 10:45 to 11:11 local. **Discarded for timing**: the 1- and 5-minute load averages read 5.9 and 6.7 when the step ended, against 2.7 and 3.7 after the 16k comparison of the same shape, and both arms ran about 15% slower in the second round than in the first (spec 8.63 then 7.28 tok/s, split 11.44 then 9.99). The runner found no build, app check or model-lock holder before the start and none started during the run, so the cause is unrecorded; the benchmark's own reader threads account for part of the load. Within each round the split arm was 1.33 and 1.37 times the dense arm on the same text length; that ratio is kept as a screen only. The comparison was repeated on the final binary.

Command: `slotstream mtp-bench --memory-gb 22 --max-context 33024 --prompt-file prompt_32768.txt --max-tokens 128 --pairs 2 --arms spec,split`, greedy; `spec` is the dense verify pass (the build's default), `split` the split verify attention.

```text
#### seq9 start 10:45:44; binary f9e23f6cf3e31b29
#### quiet (load 2.13) after 90s at 10:47:15
== decode A/B 32k at 22 GB (attempt 1) 10:47:15 reclaimable 31.6 GB target 22 GB load { 1.81 2.54 3.20 } total = 7168.00M  used = 6238.81M  free = 929.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.2 GB reclaimable now), 40.2 GB Metal working set
  target: 22.0 GB total for this process
  cache:  ~76 of 512 experts per layer  (3671 global slots = 10.1 GB pool)
  expect: ~21.0 GB peak, ~9 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 33024 tokens per request (prompt + reply, +0.9 GB state and transient reserve charged above); a full-length prompt takes ~3.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 33024 tokens across 4 conversations (~1.3 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 1.2s: expert cache ~76/512 per layer (3671 global slots = 10.1 GB), mtp draft head on, eos [248044, 248046]
prompt: 32740 tokens; context window 33024; ~76 experts/layer; arms: spec,split
round 1: spec 8.63 tok/s (accept 62.3%, 57 passes); split 11.44 tok/s (accept 61.4%, 57 passes);
round 2: split 9.99 tok/s (accept 61.4%, 57 passes); spec 7.28 tok/s (accept 62.3%, 57 passes);
medians (tok/s) over 2 rounds, greedy=true:
  spec           8.63
  split         11.44   x1.326 against spec
  every arm repeats its own output across rounds: true
  split verify attention engaged in: split
== decode A/B 32k at 22 GB exit 0 11:11:09 load { 5.94 6.67 5.65 }
#### seq9 done 11:11:09
```
