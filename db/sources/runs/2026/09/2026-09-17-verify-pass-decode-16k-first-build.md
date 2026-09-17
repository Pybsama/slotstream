---
type: run
id: 01m2r4z7xy08b1yfpaf1mr3ap1
created: 2026-09-17T17:00:03.390298+00:00
updated: 2026-09-17T17:00:43.739949+00:00
summary: 'Decode comparison at 16k on the first build: plain, dense, split and exact'
binary: f9e23f6cf3e31b29a1c83a9aec5bc64a8b0cf1543e1eb0ca9cdf3ce86536d9a8
captured_at: 2026-09-17
command: slotstream mtp-bench --memory-gb 22 --mtp auto --max-context 32768 --prompt-file prompt_16384.txt --max-tokens 128 --pairs 2 --arms plain,spec,split,exact,plain-exact
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Decode comparison at 16k on the first build: plain, dense, split and exact'
tool: slotstream mtp-bench --arms
---
Raw output of `mtp-bench --arms`, the decode comparison on one warm engine, at the 22 GB target with a 16,356-token prompt and a 32,768-token window: the automatic plan put the draft head and the decode lookahead on, with about 74 experts per layer. Binary sha256 prefix `f9e23f6cf3e31b29` (build identity and source archive preserved in the artifact [speculative-verify-pass-2026-09-17](../../../artifacts/speculative-verify-pass-2026-09-17/manifest.json)), 2026-09-17 10:19 to 10:40 local, no other model process and no build during the run (the runner stops a step when one starts; this one ran uninterrupted).

Command: `slotstream mtp-bench --memory-gb 22 --mtp auto --max-context 32768 --prompt-file prompt_16384.txt --max-tokens 128 --pairs 2 --arms plain,spec,split,exact,plain-exact`, greedy. Each arm runs once untimed, then once per round with the order rotating. Arms: `plain`, plain decode with the configured optimizations; `spec`, speculative decode as shipped; `split`, speculative decode with the split verify attention at this binary's threshold (8,192 keys; the prompt is above any threshold considered); `exact`, speculative decode with the split at every context plus the row-invariant matmuls; `plain-exact`, plain decode under the exact controls. The reported median of two rounds is the larger value; both rounds are printed. Outputs are compared token by token.

```text
#### decode A/B target 22 GB (--mtp auto), reclaimable 33.0 GB
#### quiet (load 1.52) after 90s at 10:19:01
== decode A/B 16k at 22 GB (attempt 1) 10:19:01 reclaimable 32.0 GB target 22 GB load { 1.38 2.44 3.22 } total = 7168.00M  used = 6254.81M  free = 913.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.7 GB reclaimable now), 40.2 GB Metal working set
  target: 22.0 GB total for this process
  cache:  ~74 of 512 experts per layer  (3531 global slots = 9.8 GB pool)
  expect: ~21.0 GB peak, ~9 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 2048 tokens per pass (~205 tok/s here; costs ~2.7 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.1 min before its first token here, follow-up turns read only what is new
  reuse:  up to 32768 tokens across 4 conversations (~1.2 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 1.3s: expert cache ~74/512 per layer (3531 global slots = 9.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; ~73 experts/layer; arms: plain,spec,split,exact,plain-exact
round 1: plain 9.19 tok/s; spec 10.93 tok/s (accept 69.8%, 53 passes); split 11.75 tok/s (accept 63.4%, 56 passes); exact 12.21 tok/s (accept 70.8%, 53 passes); plain-exact 8.68 tok/s;
round 2: spec 10.92 tok/s (accept 69.8%, 53 passes); split 11.80 tok/s (accept 63.4%, 56 passes); exact 12.21 tok/s (accept 70.8%, 53 passes); plain-exact 8.74 tok/s; plain 9.23 tok/s;
medians (tok/s) over 2 rounds, greedy=true:
  plain          9.23   x0.844 against spec
  spec          10.93
  split         11.80   x1.079 against spec
  exact         12.21   x1.117 against spec
  plain-exact    8.74   x0.799 against spec
  every arm repeats its own output across rounds: true
  spec against plain: differs from token 76 of 128
  split against plain: differs from token 24 of 128
  exact against plain: differs from token 76 of 128
  plain-exact against plain: differs from token 76 of 128
  exact against plain-exact: identical (128 tokens)
  split verify attention engaged in: split,exact
== decode A/B 16k at 22 GB exit 0 10:40:03 load { 2.68 3.69 3.86 }
```
