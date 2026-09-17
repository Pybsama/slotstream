---
type: run
id: 01m2rg92qfd7taxt28dm0498vm
created: 2026-09-17T20:17:40.079339+00:00
updated: 2026-09-17T20:17:40.713750+00:00
summary: 'Decode comparisons at 16k and 32k on the final build: dense, split and exact'
binary: 7a581747832566258100703d14d9d90c8275269efefc1e93a36ca6e6cd02121e (16k); 8d86f10f5b6696d444769308c07d678447b80a531476b48fb70a50988102dbc6 (32k)
captured_at: 2026-09-17
command: SLOTSTREAM_OPT_VERIFY_SPLIT=0 slotstream mtp-bench --memory-gb 22 [--mtp auto] --max-context 32768|33024 --prompt-file prompt_16384.txt|prompt_32768.txt --max-tokens 128 --pairs 2 --arms plain,spec,split,exact,plain-exact|spec,split
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Decode comparisons at 16k and 32k on the final build: dense, split and exact'
tool: slotstream mtp-bench --arms under a quiet-machine runner
---
Raw output of the decode comparisons on the final build, binary 7a58174783256625 (build identity and source archive in the verify-pass artifact), 2026-09-17 from 11:27 local, each on one warm engine at the 22 GB target. `SLOTSTREAM_OPT_VERIFY_SPLIT=0` makes the build's configured verify pass the dense one, so `spec` is the previous behavior; `split` is the split verify attention at its default threshold (6,144 keys); `exact` is the exact mode at every context (row-invariant projections, one attention call per row, per-row index selection); `plain-exact` is plain decode under the exact controls. Each arm runs once untimed, then once per round with the order rotating; the reported median of two rounds is the larger value. Greedy, 128 tokens. The quiet runner started each step after 90 s without a build, app check or model-lock holder and with a 1-minute load under 3.0; `pmset -g therm` recorded no thermal or performance warning before and after each step.

## 16k (16,356-token prompt, 32,768-token window)

The machine was busier than during the first build's comparison of the same shape at 10:19 (load 4.9 at the end against 2.7), and every arm ran about 10% slower than there, in both rounds. The texts, acceptance rates and pass counts are identical to that run's. Mean of the two rounds per verification round (128 tokens over the passes): dense 251 ms, split 220, exact 222; per plain token: plain 117.6 ms, plain-exact 122.3. Paired within rounds, split over dense is 1.107 and 1.049 (1.075 and 1.081 in the first build's run); exact over split 1.035 and 1.061 in throughput with a higher acceptance; plain-exact over plain 0.950 and 0.974.

```text
== decode A/B 16k at 22 GB, dense spec (attempt 1) 11:27:35 reclaimable 31.0 GB target 22 GB load { 2.65 3.30 4.10 } total = 7168.00M  used = 6046.81M  free = 1121.19M  (encrypted)
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (34.0 GB reclaimable now), 40.2 GB Metal working set
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
engine ready in 1.2s: expert cache ~74/512 per layer (3531 global slots = 9.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; ~73 experts/layer; arms: plain,spec,split,exact,plain-exact
round 1: plain 8.58 tok/s; spec 9.62 tok/s (accept 69.8%, 53 passes); split 10.65 tok/s (accept 63.4%, 56 passes); exact 11.02 tok/s (accept 70.8%, 53 passes); plain-exact 8.15 tok/s;
round 2: spec 9.64 tok/s (accept 69.8%, 53 passes); split 10.11 tok/s (accept 63.4%, 56 passes); exact 10.73 tok/s (accept 70.8%, 53 passes); plain-exact 8.20 tok/s; plain 8.42 tok/s;
medians (tok/s) over 2 rounds, greedy=true:
  plain          8.58   x0.890 against spec
  spec           9.64
  split         10.65   x1.105 against spec
  exact         11.02   x1.143 against spec
  plain-exact    8.20   x0.851 against spec
  every arm repeats its own output across rounds: true
  spec against plain: differs from token 76 of 128
  split against plain: differs from token 24 of 128
  exact against plain: differs from token 76 of 128
  plain-exact against plain: differs from token 76 of 128
  exact against plain-exact: identical (128 tokens)
  split verify attention engaged in: split,exact
== decode A/B 16k at 22 GB, dense spec exit 0 11:50:28 load { 4.92 4.97 4.74 }
```

## 32k (32,740-token prompt, 33,024-token window, 14:51)

Run on the frozen copy of the same build. The split arm is 1.406 and 1.368 times the dense arm inside its two rounds; the rounds themselves differ by 7 to 10% in absolute rate, on a machine still settling after a battery run was stopped at 14:46 (5-minute load 4.55 at the start), so the ratio is the reading and the rates are not. The first attempts at 11:53, 12:04 and 12:15 stepped aside for another session's builds, and one at 12:18 lost the model slot to another session between the quiet check and the launch.

```text
== decode A/B 32k at 22 GB, dense spec (attempt 1) 14:51:06 reclaimable 30.2 GB target 22 GB load { 2.60 4.55 4.69 } total = 7168.00M  used = 5875.94M  free = 1292.06M  (encrypted)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 1.2s: expert cache ~76/512 per layer (3671 global slots = 10.1 GB), mtp draft head on, eos [248044, 248046]
prompt: 32740 tokens; context window 33024; ~76 experts/layer; arms: spec,split
round 1: spec 7.75 tok/s (accept 62.3%, 57 passes); split 10.90 tok/s (accept 61.4%, 57 passes);
round 2: split 11.66 tok/s (accept 61.4%, 57 passes); spec 8.52 tok/s (accept 62.3%, 57 passes);
medians (tok/s) over 2 rounds, greedy=true:
  spec           8.52
  split         11.66   x1.368 against spec
  every arm repeats its own output across rounds: true
  split verify attention engaged in: split
== decode A/B 32k at 22 GB, dense spec exit 0 15:16:13 load { 3.04 4.34 5.06 }
```
