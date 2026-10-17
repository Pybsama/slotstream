---
type: community-report
id: 01m4r9ec21zczj7rfn4gjc023f
created: 2026-10-12T14:49:37.089869+00:00
updated: 2026-10-12T14:50:02.167123+00:00
summary: 'Issue 55: reported keepalive regression on base M5, workaround and follow-up controls'
captured_at: 2026-10-12
machines: '[[records/machines/macbook-air-m5-32gb-issue55]]'
reporter: Arsenitim
title: Decode ~20× slower with GPU keepalive on a base M5 MacBook Air (0.4 vs 8 tok/s)
url: https://github.com/carloslfu/slotstream/issues/55
---
Public issue body captured verbatim on October 12, 2026. Created and last updated October 5, 2026; no comments at capture. Reporter measurements have not been independently repeated on this Mac.

Hi, and thank you for slotstream! Running a 125B model on a MacBook Air at all is impressive.

On my MacBook Air M5, decode runs at about **0.4 tok/s with the default `--gpu-keepalive auto`** while on AC power. With **`--gpu-keepalive off`** it runs at **about 8 tok/s**. That's in line with (or a bit above) the 6.22 tok/s measured on the same Mac in #12, which was on v0.2.11.

### Setup

- MacBook Air, Apple M5 (base chip), 32 GB, 1 TB internal SSD (weights on the internal drive)
- macOS 26.6.2
- slotstream 0.2.27, model `qwen3.8-flash-next:4bit`
- On AC power, Low Power Mode off, so `auto` turns the keepalive on

### Results

Each row is a fresh `slotstream run` (128 tokens), run back to back:

| command | decode |
|---|---|
| `slotstream run --prompt "Why is the sky blue?"` | **0.42 tok/s** (128 tok in 302.5 s) |
| `slotstream run --prompt "Why is the sky blue?" --gpu-keepalive off` | **7.82 tok/s** (128 tok in 16.4 s) |
| `slotstream run --greedy --max-tokens 128 --prompt "Explain how a hash map works, in about 200 words."` | 0.44 tok/s (128 tok in 293.9 s) |
| same, with `--gpu-keepalive off` | 8.38 tok/s (128 tok in 15.3 s) |

The slow and fast runs read about the same amount from disk. Only the wall time differs:

```text
# default (keepalive on)
-- decode 128 tok in 293.85s (0.44 tok/s)
-- decode split: io 8.18s + scatter 0.00s | 5573 records | mtp 73/108 drafts accepted (68%), 54 verify passes
-- expert cache ~80/512 experts per layer, hit rate 0.720 | ngram rows 112h/2480m | lifetime footprint peak 15.907 GB, current footprint 15.907 GB | total 303.1s

# --gpu-keepalive off
-- decode 128 tok in 15.27s (8.38 tok/s)
-- decode split: io 3.85s + scatter 0.00s | 5541 records | mtp 73/108 drafts accepted (68%), 54 verify passes
```

In `--stats-json` for the slow run, each verify pass takes almost exactly 5 s. All 54 entries in `interTokenSeconds` above 1 s fall between 4.79 and 5.97 s, and `verifySeconds` is 267.8 of the 293.9 s.

### Other things I tried (all still slow with keepalive on)

- `SLOTSTREAM_OPT_EXPERT_PREFETCH=0`: 0.39 tok/s (48 tokens)
- `--mtp off`: 0.25 tok/s (48 tokens)

### Guess

I noticed in `GPUKeepAlive.swift` that the keepalive was tuned on an M5 Pro. My guess is that on the smaller base-M5 GPU, the polling kernel holds up the model's own command buffers rather than just keeping the clock up. I haven't confirmed that, so please take it as a guess.

Workaround for anyone else on a base M5: `export SLOTSTREAM_GPU_KEEPALIVE=off`. On battery `auto` already turns it off, which is probably why it shows up only when the Mac is plugged in.

I'm happy to run any diagnostics or test a build if that helps. Thanks again!
