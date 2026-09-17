---
type: run
id: 01m2rc5nq0s750d5y2xtrvrvf1
created: 2026-09-17T19:05:54.144586+00:00
updated: 2026-09-17T19:05:54.808462+00:00
summary: 'Dense matmul row invariance under Python MLX: stock, gathered and one-row kernels'
binary: Python mlx 0.31.1 wheel; no slotstream binary
captured_at: 2026-09-17
command: .venv31/bin/python matmul_rows_shapes2.py; .venv31/bin/python matmul_rows_shapes3.py; .venv31/bin/python matmul_rows_shapes4.py
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Dense matmul row invariance under Python MLX: stock, gathered and one-row kernels'
tool: Python mlx 0.31.1 (.venv31) scripts matmul_rows_shapes2.py, matmul_rows_shapes3.py and matmul_rows_shapes4.py
---
Raw output of three Python scripts under `mlx 0.31.1` (`.venv31`, the Python build of the backend Slotstream pins), run on this M5 Pro with no model loaded, 2026-09-17 12:52 local, while another session's server held about 12 GB (the scripts use well under 1 GB and time nothing). They test the arithmetic of the model's five dense matmul shapes on seeded normal and heavy-tailed values (a normal times `exp(1.5 x normal)`), weights scaled by 0.05, rows 2, 3, 4 or 5 and 8.

- `matmul_rows_shapes2.py`: the stock multi-row product `x @ w.T` and the gathered product (`gather_mm` with one row per index) against one-row products of slices of the same input. Twenty seeds and four row counts per shape and kind, 80 trials.
- `matmul_rows_shapes3.py`: the same against one-row products of separately built contiguous rows, as the engine's one-row decode sees them, plus the gathered product against sliced one-row products and sliced against contiguous one-row products; fresh draws.
- `matmul_rows_shapes4.py`: the gathered product of k rows against the gathered product of each row alone, 25 seeds and rows 2, 3, 5 and 8, 100 trials per shape and kind.

Reading: the stock multi-row product differs from one-row products in every router trial, in 71 to 82 of 160 indexer trials and in a few GDN gate and inject trials. The gathered product of k rows equals the gathered product of one row in 1,000 of 1,000 trials, but differs from the stock one-row product in 4 and 8 of 160 GDN gate trials (two draws) and 1 of 160 inject trials, the shapes whose input is at least 16 times wider than the output. Slicing does not matter (0 differences between sliced and contiguous one-row products). This is why the exact mode routes one-row passes through the gathered kernel too.

```text
== python kernel scripts 12:52:49 load { 4.25 3.96 3.37 }
-- matmul_rows_shapes2
router fp32 2560x512           normal trials 80: stock differs 80 (max 3.81e-06); row path differs 0 (max 0)
router fp32 2560x512           heavy  trials 80: stock differs 80 (max 0.00781); row path differs 0 (max 0)
gdn in_proj_a/b bf16 2560x48   normal trials 80: stock differs 6 (max 0.00391); row path differs 5 (max 0.00195)
gdn in_proj_a/b bf16 2560x48   heavy  trials 80: stock differs 2 (max 0.25); row path differs 3 (max 0.25)
shared gate bf16 2560x1        normal trials 80: stock differs 0 (max 0); row path differs 0 (max 0)
shared gate bf16 2560x1        heavy  trials 80: stock differs 0 (max 0); row path differs 0 (max 0)
indexer qk bf16 2560x640       normal trials 80: stock differs 31 (max 0.00391); row path differs 0 (max 0)
indexer qk bf16 2560x640       heavy  trials 80: stock differs 40 (max 2); row path differs 0 (max 0)
inject bf16 10240x4            normal trials 80: stock differs 0 (max 0); row path differs 0 (max 0)
inject bf16 10240x4            heavy  trials 80: stock differs 1 (max 0.25); row path differs 1 (max 0.25)
-- matmul_rows_shapes3
gdn in_proj bf16 2560x48   normal 80 trials, rows differing from contiguous one-row passes: stock 2, gather 3, gather_vs_sliced 3, sliced_vs_contig 0
gdn in_proj bf16 2560x48   heavy  80 trials, rows differing from contiguous one-row passes: stock 0, gather 1, gather_vs_sliced 1, sliced_vs_contig 0
inject bf16 10240x4        normal 80 trials, rows differing from contiguous one-row passes: stock 0, gather 1, gather_vs_sliced 1, sliced_vs_contig 0
inject bf16 10240x4        heavy  80 trials, rows differing from contiguous one-row passes: stock 0, gather 0, gather_vs_sliced 0, sliced_vs_contig 0
indexer qk bf16 2560x640   normal 80 trials, rows differing from contiguous one-row passes: stock 34, gather 0, gather_vs_sliced 0, sliced_vs_contig 0
indexer qk bf16 2560x640   heavy  80 trials, rows differing from contiguous one-row passes: stock 48, gather 0, gather_vs_sliced 0, sliced_vs_contig 0
router fp32 2560x512       normal 80 trials, rows differing from contiguous one-row passes: stock 80, gather 0, gather_vs_sliced 0, sliced_vs_contig 0
router fp32 2560x512       heavy  80 trials, rows differing from contiguous one-row passes: stock 80, gather 0, gather_vs_sliced 0, sliced_vs_contig 0
-- matmul_rows_shapes4
router fp32 2560x512       normal 100 trials: gathered k rows differ from gathered one row in 0
router fp32 2560x512       heavy  100 trials: gathered k rows differ from gathered one row in 0
gdn in_proj bf16 2560x48   normal 100 trials: gathered k rows differ from gathered one row in 0
gdn in_proj bf16 2560x48   heavy  100 trials: gathered k rows differ from gathered one row in 0
shared gate bf16 2560x1    normal 100 trials: gathered k rows differ from gathered one row in 0
shared gate bf16 2560x1    heavy  100 trials: gathered k rows differ from gathered one row in 0
indexer qk bf16 2560x640   normal 100 trials: gathered k rows differ from gathered one row in 0
indexer qk bf16 2560x640   heavy  100 trials: gathered k rows differ from gathered one row in 0
inject bf16 10240x4        normal 100 trials: gathered k rows differ from gathered one row in 0
inject bf16 10240x4        heavy  100 trials: gathered k rows differ from gathered one row in 0
== done 12:52:52
```
