---
type: run
id: 01m2r4z7wm9mm7631g4metw9a7
created: 2026-09-17T17:00:03.348243+00:00
updated: 2026-09-17T17:00:43.264538+00:00
summary: Row-equality gate mtp-rowcheck, four versions at 10 GB
binary: 60820d93c83f871f, 1bf06185fb7d721b and f9e23f6cf3e31b29a1c83a9aec5bc64a8b0cf1543e1eb0ca9cdf3ce86536d9a8 for versions 1 to 3; 7a581747832566258100703d14d9d90c8275269efefc1e93a36ca6e6cd02121e for version 4
captured_at: 2026-09-17
command: slotstream mtp-rowcheck --memory-gb 10
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Row-equality gate mtp-rowcheck, four versions at 10 GB
tool: slotstream mtp-rowcheck
---
Raw output of the four versions of `mtp-rowcheck`, the row-equality gate for the verify pass, each run at the battery's 10 GB target (`slotstream mtp-rowcheck --memory-gb 10`, defaults otherwise), no other model process, on 2026-09-17.

1. 00:09, binary sha256 prefix `60820d93c83f871f` (the 00:06 development build; working-tree diff sha256 prefix `3a6271349faa55c4` over `Sources` and `Tools/verify.sh`). One 2,965-token prompt above the 2,048-token indexer budget; compares row 0 of a two-row and a three-row pass against the stock one-row pass. Row-invariant matmuls covered passes of two to eight rows only.
2. 08:56, binary `1bf06185fb7d721b` (08:50 build). Same prompt; compares every row and, through the next token's logits, the state a three-row pass leaves. Same row-invariant form as version 1.
3. 10:15, binary `f9e23f6cf3e31b29` (build identity and source archive preserved in the artifact [speculative-verify-pass-2026-09-17](../../../artifacts/speculative-verify-pass-2026-09-17/manifest.json)). Two prompts, 973 tokens (below the indexer budget, where the split builds its own causal mask and a one-row pass uses none) and 2,826 tokens (above it). The row-invariant matmuls cover one to eight rows, so one-row passes in the exact mode run the same kernel as the rows of a multi-row pass; each mode is compared with its own one-row passes.

4. 11:22, binary `7a58174783256625` (build identity and source archive in the verify-pass artifact). The exact mode runs one attention call per row over that row's own keys from two rows up and selects each row's index blocks at a one-row pass's shapes. The 973-token prompt is extended to 1,019 tokens and its positions advance one token at a time, so the recorded passes start at positions 1,020 to 1,023 and their rows' key counts run from 1,021 to 1,026, across 1,024 and 1,025 keys, where this GPU switches attention kernel and block layout; the 2,826-token leg is unchanged.

Pass criterion in every version: zero deviation and zero top-1 flips for the exact mode; the stock deviation is printed beside it. All four passed. Versions 1 and 2 used a row-invariant form that later proved inexact on narrow-output shapes against the stock one-row kernel (see the Python kernel run); their passes held on these activations and are superseded by version 3. Version 3's split gave the rows of a pass the whole pass's key count, which rounds differently from a one-row pass where the two counts straddle a kernel switch (the catalogue check counts it); its prompts did not reach such a count, and version 4 replaces it.

## Version 1 (00:09)

```text
== gate run 00:09:42
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (25.9 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total for this process
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  expect: ~9.6 GB peak, ~3 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 7595 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.2s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 2965 tokens; context window 32768; indexer budget 2048
PASS  split verify attention engaged (60 layer passes)
PASS  row-invariant projections engaged (2760 matmuls)
PASS  k=2 row 0 equals the one-row pass bit for bit over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0229, 0 flips)
PASS  k=3 row 0 equals the one-row pass bit for bit over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0211, 0 flips)
MTP ROWCHECK PASS
exit 0 00:10:57
```

## Version 2 (08:56)

```text
== gate mtp-rowcheck 10 GB 08:56:05 reclaimable 20.2 GB target 10 GB load { 2.09 2.43 2.14 } total = 7168.00M  used = 6310.81M  free = 857.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (25.4 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total for this process
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  expect: ~9.6 GB peak, ~3 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 7595 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.3s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 2965 tokens; context window 32768; indexer budget 2048
PASS  split verify attention engaged (120 layer passes)
PASS  row-invariant projections engaged (4140 matmuls)
PASS  k=2: every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0229, 0 flips)
PASS  k=3: every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0241, 0 flips)
PASS  state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0266, 0 flips)
MTP ROWCHECK PASS
== gate mtp-rowcheck 10 GB exit 0 08:57:27 load { 2.73 2.62 2.24 }
```

## Version 3 (10:15)

```text
== gate mtp-rowcheck two legs 10 GB (attempt 1) 10:15:26 reclaimable 30.9 GB target 10 GB load { 1.69 2.88 3.53 } total = 7168.00M  used = 6262.81M  free = 905.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (33.0 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total for this process
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  expect: ~9.6 GB peak, ~3 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 7595 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 973-token prompt, below the indexer budget (2048); context window 32768
PASS  973-token prompt, below the indexer budget: split verify attention engaged (120 layer passes)
PASS  973-token prompt, below the indexer budget: row-invariant projections engaged (11040 matmuls)
PASS  973-token prompt, below the indexer budget: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0286, 0 flips)
PASS  973-token prompt, below the indexer budget: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0218, 0 flips)
PASS  973-token prompt, below the indexer budget: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.023, 0 flips)
prompt: 2826-token prompt, above the indexer budget (2048); context window 32768
PASS  2826-token prompt, above the indexer budget: split verify attention engaged (120 layer passes)
PASS  2826-token prompt, above the indexer budget: row-invariant projections engaged (11040 matmuls)
PASS  2826-token prompt, above the indexer budget: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0268, 0 flips)
PASS  2826-token prompt, above the indexer budget: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0194, 0 flips)
PASS  2826-token prompt, above the indexer budget: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0283, 0 flips)
MTP ROWCHECK PASS
== gate mtp-rowcheck two legs 10 GB exit 0 10:17:31 load { 2.55 2.93 3.47 }
```

## Version 4 (11:22)

```text
== rowcheck gate at 10 GB (attempt 1) 11:22:49 reclaimable 27.8 GB target 10 GB load { 2.69 3.58 4.43 } total = 7168.00M  used = 6086.81M  free = 1081.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (32.3 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total for this process
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  expect: ~9.6 GB peak, ~3 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 7595 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 973-token prompt, below the indexer budget, rows across 1024 keys (2048); positions from 1019 every 1 tokens; context window 32768
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: exact verify attention engaged (180 layer passes)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: row-invariant projections engaged (11040 matmuls)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0148, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0152, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0131, 0 flips)
prompt: 2826-token prompt, above the indexer budget (2048); positions from 2826 every 4 tokens; context window 32768
PASS  2826-token prompt, above the indexer budget: exact verify attention engaged (180 layer passes)
PASS  2826-token prompt, above the indexer budget: row-invariant projections engaged (11040 matmuls)
PASS  2826-token prompt, above the indexer budget: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0268, 0 flips)
PASS  2826-token prompt, above the indexer budget: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0194, 0 flips)
PASS  2826-token prompt, above the indexer budget: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0283, 0 flips)
MTP ROWCHECK PASS
== rowcheck gate at 10 GB exit 0 11:25:04 load { 4.06 3.93 4.46 }
```
