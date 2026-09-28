---
type: reference
id: 01m3mx4pd1jjp06hrsp5hfw1j8
created: 2026-09-28T21:01:11.969791+00:00
updated: 2026-09-28T21:01:20.635022+00:00
summary: The publisher's size and quality table for the VQ builds of Qwen3.8-Flash-Next, pinned at the revision issue 7 inspected.
captured_at: 2026-09-28T20:57:23Z
title: 'Qwen3.8-Flash-Next VQ model card: size and quality table'
url: https://huggingface.co/TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw
---
# Qwen3.8-Flash-Next VQ 2.1-bit model card: size and quality table

Retrieved 2026-09-28T20:57Z from
<https://huggingface.co/TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw> at revision
`8684640a3956b01c47f5d47f9b999e2ab8b985f1` (last modified 2026-09-20), the
revision [#7](https://github.com/carloslfu/slotstream/issues/7) inspected.
README SHA-256: `d3bf42d868042f0a178cd87db6c705d6d7542868090e9e19f27c3ac87c2a8890`.
License: Qwen Community License 1.0, as for the base model.

These are the publisher's measurements, not slotstream's. Their instrument is
a 2,048-token prose referee scored by KL divergence against the bf16 teacher's
cached top-64 logits, re-measured on 2026-09-15 with a corrected scorer. Their
affine rows are their own conversions made with the same tooling, not
slotstream's pinned 4-bit checkpoint. Sizes include the 0.84 GiB bf16 vision
tower; the draft (MTP) sidecar is a separate 2.14 GiB.

| Build | Size | KL to bf16 (mnats/token) | Top-1 agreement | Perplexity |
| --- | ---: | ---: | ---: | ---: |
| affine q3 | 75 GiB | 1050.98 | 61.91% | 12.3541 |
| VQ 2.1 bpw | 45.8 GiB | 339.89 | 80.22% | 5.6736 |
| affine q4 | 96 GiB | 307.42 | 79.98% | 6.6327 |
| VQ 3.2 bpw | 71.7 GiB | 122.15 | 86.23% | 5.1684 |
| affine q5 | 116 GiB | 93.68 | 88.04% | 5.3068 |
| VQ 4.4 bpw | 96.3 GiB | 50.58 | 92.58% | 5.2379 |
| affine q6 | 137 GiB | 46.48 | 92.09% | 4.9833 |
| VQ 5.5 bpw | 114.5 GiB | 33.38 | 93.65% | 5.2429 |
| affine q8 | 178 GiB | 22.82 | 94.68% | 5.2311 |

The card ranks builds by KL, because perplexity does not follow the bit
budget in this table.

Layout facts stated on the card: expert `gate`/`up` projections mostly at
d=8/K=16384 codebooks, d=4/K=256 for every `down_proj` and for nine promoted
layers, n-gram PLE tables at d=8/K=256, and layers 0 and 1 at d=2/K=256. The
reference runtime ships inside the checkpoint as `model.py`, and the base
architecture needs the unmerged mlx-lm PR #1788.
