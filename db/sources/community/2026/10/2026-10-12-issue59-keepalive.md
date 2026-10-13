---
type: community-report
id: 01m4ske6s38hst9fs13zhprjq7
created: 2026-10-13T03:03:31.875317+00:00
updated: 2026-10-13T03:04:08.117079+00:00
summary: Issue 59 reports severe keepalive-associated stalls on M1 Max
captured_at: 2026-10-12
machines: '[[records/machines/mac-studio-m1-max-32gb-issue59]]'
reporter: dittsn
title: Default --gpu-keepalive makes decode about 6x slower on M1 Max (0.94 vs 6.23 tok/s)
url: https://github.com/carloslfu/slotstream/issues/59
---
Public issue body captured verbatim before the first maintainer reply on October 12, 2026 (local date). No comments existed at capture. Community measurements have not been independently repeated on this Mac.

Full disclosure: I'm a clueless vibe coder. My own Claude set up slotstream on my Mac Studio, ran these measurements and suggested I send this, because CONTRIBUTING.md asks for bug reports with raw output. The numbers and outputs below are copied unedited from my machine. I can't judge the cause myself.

- **Mac:** Mac Studio (Mac13,1), Apple M1 Max, 32 GB, always on AC power
- **SSD:** model on the internal SSD (macOS boots from an external SSD)
- **macOS:** 27.0.1
- **slotstream:** 0.2.28, qwen38-flash-next-mlx-4bit

## What happens

With default settings, decode runs at 0.94 tok/s. With `--gpu-keepalive off` it runs at 6.23 tok/s and produces the same text. Turning off the draft head and the decode lookahead did not help.

Four runs one after another, no other model process, `SLOTSTREAM_GPU_KEEPALIVE` unset. Base command:

```
slotstream run --greedy --max-tokens 48 --prompt "Explain how a hash map works, in about 200 words."
```

| Extra options | Decode |
|---|---|
| none (default) | `-- decode 48 tok in 51.14s (0.94 tok/s)` |
| `--mtp off` | `-- decode 48 tok in 75.86s (0.63 tok/s)` |
| `--mtp off`, `SLOTSTREAM_OPT_EXPERT_PREFETCH=0` | `-- decode 48 tok in 93.67s (0.51 tok/s)` |
| `--gpu-keepalive off` | `-- decode 48 tok in 7.70s (6.23 tok/s)` |

The server with `--gpu-keepalive off`, three warm requests of 128 tokens to `/api/generate`: 6.00, 6.10 and 6.09 tok/s.

## GPU during the default run

`sudo powermetrics --samplers gpu_power -i 2000 -n 25`, started right before the default run. The default run ended at 07:49:59; sampling ended at 07:49:23. I have no powermetrics samples for the run with `--gpu-keepalive off`.

<details><summary>powermetrics lines</summary>

```text
Machine model: Mac13,1
OS version: 26A434
*** Sampled system activity (Mon Oct 12 07:48:37 2026 +0200) (2004.76ms elapsed) ***
GPU HW active frequency: 637 MHz
GPU HW active residency:   0.90% (389 MHz: .04% 486 MHz:   0% 648 MHz: .86% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  99.10%
GPU Power: 5 mW
*** Sampled system activity (Mon Oct 12 07:48:39 2026 +0200) (2004.13ms elapsed) ***
GPU HW active frequency: 636 MHz
GPU HW active residency:   1.55% (389 MHz: .07% 486 MHz:   0% 648 MHz: 1.5% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.45%
GPU Power: 9 mW
*** Sampled system activity (Mon Oct 12 07:48:41 2026 +0200) (2004.19ms elapsed) ***
GPU HW active frequency: 639 MHz
GPU HW active residency:   5.29% (389 MHz: .17% 486 MHz:   0% 648 MHz: 5.1% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  94.71%
GPU Power: 53 mW
*** Sampled system activity (Mon Oct 12 07:48:43 2026 +0200) (2004.43ms elapsed) ***
GPU HW active frequency: 640 MHz
GPU HW active residency:   1.90% (389 MHz: .06% 486 MHz:   0% 648 MHz: 1.8% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.10%
GPU Power: 16 mW
*** Sampled system activity (Mon Oct 12 07:48:45 2026 +0200) (2004.25ms elapsed) ***
GPU HW active frequency: 635 MHz
GPU HW active residency:   1.10% (389 MHz: .06% 486 MHz:   0% 648 MHz: 1.0% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.90%
GPU Power: 7 mW
*** Sampled system activity (Mon Oct 12 07:48:47 2026 +0200) (2003.98ms elapsed) ***
GPU HW active frequency: 763 MHz
GPU HW active residency:   1.46% (389 MHz: .05% 486 MHz:   0% 648 MHz: .84% 778 MHz: .02% 972 MHz: .54% 1296 MHz: .01%)
GPU idle residency:  98.54%
GPU Power: 6 mW
*** Sampled system activity (Mon Oct 12 07:48:49 2026 +0200) (2005.18ms elapsed) ***
GPU HW active frequency: 639 MHz
GPU HW active residency:   1.57% (389 MHz: .05% 486 MHz:   0% 648 MHz: 1.5% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.43%
GPU Power: 5 mW
*** Sampled system activity (Mon Oct 12 07:48:51 2026 +0200) (2004.29ms elapsed) ***
GPU HW active frequency: 639 MHz
GPU HW active residency:   1.14% (389 MHz: .04% 486 MHz:   0% 648 MHz: 1.1% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.86%
GPU Power: 6 mW
*** Sampled system activity (Mon Oct 12 07:48:53 2026 +0200) (2004.01ms elapsed) ***
GPU HW active frequency: 638 MHz
GPU HW active residency:   1.44% (389 MHz: .05% 486 MHz:   0% 648 MHz: 1.4% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.56%
GPU Power: 4 mW
*** Sampled system activity (Mon Oct 12 07:48:55 2026 +0200) (2004.53ms elapsed) ***
GPU HW active frequency: 641 MHz
GPU HW active residency:   2.14% (389 MHz: .06% 486 MHz:   0% 648 MHz: 2.1% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  97.86%
GPU Power: 23 mW
*** Sampled system activity (Mon Oct 12 07:48:57 2026 +0200) (2004.07ms elapsed) ***
GPU HW active frequency: 638 MHz
GPU HW active residency:   1.07% (389 MHz: .04% 486 MHz:   0% 648 MHz: 1.0% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.93%
GPU Power: 5 mW
*** Sampled system activity (Mon Oct 12 07:48:59 2026 +0200) (2004.37ms elapsed) ***
GPU HW active frequency: 637 MHz
GPU HW active residency:   1.44% (389 MHz: .06% 486 MHz:   0% 648 MHz: 1.4% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  98.56%
GPU Power: 7 mW
*** Sampled system activity (Mon Oct 12 07:49:01 2026 +0200) (2003.95ms elapsed) ***
GPU HW active frequency: 646 MHz
GPU HW active residency:   9.00% (389 MHz: .09% 486 MHz:   0% 648 MHz: 8.9% 778 MHz:   0% 972 MHz:   0% 1296 MHz:   0%)
GPU idle residency:  91.00%
GPU Power: 98 mW
*** Sampled system activity (Mon Oct 12 07:49:03 2026 +0200) (2004.01ms elapsed) ***
GPU HW active frequency: 1293 MHz
GPU HW active residency:  92.59% (389 MHz: .01% 486 MHz:   0% 648 MHz: .09% 778 MHz:   0% 972 MHz: .79% 1296 MHz:  92%)
GPU idle residency:   7.41%
GPU Power: 1165 mW
*** Sampled system activity (Mon Oct 12 07:49:05 2026 +0200) (2004.02ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency: 100.00% (389 MHz:   0% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz: 100%)
GPU idle residency:   0.00%
GPU Power: 2523 mW
*** Sampled system activity (Mon Oct 12 07:49:07 2026 +0200) (2004.18ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency: 100.00% (389 MHz:   0% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz: 100%)
GPU idle residency:   0.00%
GPU Power: 2355 mW
*** Sampled system activity (Mon Oct 12 07:49:09 2026 +0200) (2004.21ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency: 100.00% (389 MHz:   0% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz: 100%)
GPU idle residency:   0.00%
GPU Power: 1507 mW
*** Sampled system activity (Mon Oct 12 07:49:11 2026 +0200) (2008.59ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency: 100.00% (389 MHz:   0% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz: 100%)
GPU idle residency:   0.00%
GPU Power: 1435 mW
*** Sampled system activity (Mon Oct 12 07:49:13 2026 +0200) (2008.34ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency:  99.30% (389 MHz: .03% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz:  99%)
GPU idle residency:   0.70%
GPU Power: 1487 mW
*** Sampled system activity (Mon Oct 12 07:49:15 2026 +0200) (2013.42ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency:  99.15% (389 MHz: .03% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz:  99%)
GPU idle residency:   0.85%
GPU Power: 1474 mW
*** Sampled system activity (Mon Oct 12 07:49:17 2026 +0200) (2007.42ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency:  99.32% (389 MHz: .04% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz:  99%)
GPU idle residency:   0.68%
GPU Power: 1480 mW
*** Sampled system activity (Mon Oct 12 07:49:19 2026 +0200) (2009.80ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency: 100.00% (389 MHz:   0% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz: 100%)
GPU idle residency:   0.00%
GPU Power: 1471 mW
*** Sampled system activity (Mon Oct 12 07:49:21 2026 +0200) (2012.91ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency:  99.27% (389 MHz: .05% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz:  99%)
GPU idle residency:   0.73%
GPU Power: 1516 mW
*** Sampled system activity (Mon Oct 12 07:49:23 2026 +0200) (2008.49ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency:  99.05% (389 MHz: .04% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz:  99%)
GPU idle residency:   0.95%
GPU Power: 1345 mW
*** Sampled system activity (Mon Oct 12 07:49:25 2026 +0200) (2009.18ms elapsed) ***
GPU HW active frequency: 1296 MHz
GPU HW active residency:  99.99% (389 MHz: .01% 486 MHz:   0% 648 MHz:   0% 778 MHz:   0% 972 MHz:   0% 1296 MHz: 100%)
GPU idle residency:   0.01%
GPU Power: 1486 mW
```

</details>

<details><summary>Full output: default run</summary>

```text
slotstream memory plan (auto)
  device: 34 GB RAM (22.4 GB reclaimable now), 26.8 GB Metal working set
  target: 20.7 GB total process budget, not a RAM usage goal   (adaptive limit: --memory-limit-gb N; fixed cache: --memory-gb N)
  cache:  ~74 of 512 experts per layer  (3534 global slots = 9.8 GB pool)
  plan:   ~19.7 GB full-workload envelope, ~9 tok/s warm decode (est. from M5 Pro anchors)
  memory: 9.8 GB expert cache at load; 9.9 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.3 min before its first token here, follow-up turns read only what is new
  reuse:  up to 32768 tokens across 4 conversations (~1.2 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  note:   only 22.4 GB of 34 GB RAM is reclaimable right now (other apps hold the rest) — sized down from the usual 24.1 GB; close apps and restart for full speed, or force a size with --memory-gb
  note:   automatic context window lowered from 65536 to 32768 tokens for this run (22.4 GB reclaimable now): streams the draft head's experts, a cost the estimate does not price; restart after other apps release memory to reconsider the window
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
[expert-lookahead] attention-corrected forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 2.1s: expert cache ~74/512 per layer (3534 global slots = 9.8 GB), mtp draft head on, eos [248044, 248046]
prompt tokens: 28 (~0 s to the first token at this plan)
  prefill: reading 28 prompt tokens, ~0 s to the first token at this plan (follow-up turns read only what is new)
  prefill: done, 28 tokens in 6 s (5 tok/s)
A hash map, also known as a hash table, is a data structure that stores key-value pairs, allowing for highly efficient data retrieval. Its core mechanism relies on a hash function, which converts a given key into a specific numerical index within
-- prefill 28 tok in 5.83s (4.8 tok/s)
-- prefill split: io 2.93s + scatter 0.00s | 4765 records (13.2 GB, 4.5 GB/s)
-- decode 48 tok in 51.14s (0.94 tok/s)
-- decode split: io 2.56s + scatter 0.00s | 2025 records | mtp 26/42 drafts accepted (62%), 21 verify passes
-- expert cache ~74/512 experts per layer, hit rate 0.725 | ngram rows 24h/984m | lifetime footprint peak 15.070 GB, current footprint 15.070 GB | total 57.7s

```

</details>

<details><summary>Full output: --gpu-keepalive off</summary>

```text
slotstream memory plan (auto)
  device: 34 GB RAM (23.5 GB reclaimable now), 26.8 GB Metal working set
  target: 21.7 GB total process budget, not a RAM usage goal   (adaptive limit: --memory-limit-gb N; fixed cache: --memory-gb N)
  cache:  ~69 of 512 experts per layer  (3320 global slots = 9.2 GB pool)
  plan:   ~20.7 GB full-workload envelope, ~8 tok/s warm decode (est. from M5 Pro anchors)
  memory: 9.2 GB expert cache at load; 11.6 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 1024 tokens per pass (~165 tok/s here; costs ~1.3 GB of the target)
  mtp:    draft head on — speculative decode; its experts stream through a 64-expert cache (0.4 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~7.8 min before its first token here, follow-up turns read only what is new
  reuse:  up to 65536 tokens across 4 conversations (~2.2 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  note:   only 23.5 GB of 34 GB RAM is reclaimable right now (other apps hold the rest) — sized down from the usual 24.1 GB; close apps and restart for full speed, or force a size with --memory-gb
  window: automatic for this Mac, 65536 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
[expert-lookahead] attention-corrected forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 1.7s: expert cache ~69/512 per layer (3320 global slots = 9.2 GB), mtp draft head on, eos [248044, 248046]
prompt tokens: 28 (~0 s to the first token at this plan)
A hash map, also known as a hash table, is a data structure that stores key-value pairs, allowing for highly efficient data retrieval. Its core mechanism relies on a hash function, which converts a given key into a specific numerical index within
-- prefill 28 tok in 3.78s (7.4 tok/s)
-- prefill split: io 2.84s + scatter 0.00s | 4765 records (13.2 GB, 4.6 GB/s)
-- decode 48 tok in 7.70s (6.23 tok/s)
-- decode split: io 1.80s + scatter 0.00s | 2145 records | mtp 26/42 drafts accepted (62%), 21 verify passes
-- expert cache ~69/512 experts per layer, hit rate 0.708 | ngram rows 24h/984m | lifetime footprint peak 13.278 GB, current footprint 13.278 GB | total 11.5s

```

</details>
