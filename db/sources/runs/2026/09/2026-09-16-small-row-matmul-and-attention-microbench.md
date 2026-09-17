---
type: run
id: 01m2r4z7tn1y8cysk8qx4389z3
created: 2026-09-17T17:00:03.285203+00:00
updated: 2026-09-17T17:00:41.451912+00:00
summary: Small-row quantized matmul and multi-row attention microbenchmarks under Python MLX
binary: Python mlx 0.31.1 wheel; no slotstream binary
captured_at: 2026-09-16
command: .venv31/bin/python qmv_rows_bench.py; .venv31/bin/python verify_pass_bench.py
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Small-row quantized matmul and multi-row attention microbenchmarks under Python MLX
tool: Python mlx 0.31.1 (.venv31) scripts qmv_rows_bench.py and verify_pass_bench.py, synthetic weights
---
Two synthetic microbenchmarks under Python `mlx 0.31.1` (`.venv31`) on this M5 Pro, random weights, no model loaded. They sized the questions the real-engine run then answered. Scripts: `qmv_rows_bench.py` (sha256 prefix `29de044a26dbfa61`), one call per eval, and `verify_pass_bench.py` (`95b87ba12f8674df`), eight calls per eval so the per-call submit and sync floor does not dominate small kernels. A Sevra test process used about one CPU core during the first script; ratios within a shape were monotone.

## qmv_rows_bench.py (one call per eval)

```text
mx.metal.device_info is deprecated and will be removed in a future version. Use mx.device_info instead.
device applegpu_g17s  mlx 0.31.1
shape | M | ms/call | weight bytes | GB/s if read once | GB/s if read M times
qsa q (2560->6144)               |   1 |    0.240 |      8.8 MB |    36.8 |    36.8   (x1.00 vs M=1)
qsa q (2560->6144)               |   2 |    0.246 |      8.8 MB |    36.0 |    72.0   (x1.02 vs M=1)
qsa q (2560->6144)               |   3 |    0.248 |      8.8 MB |    35.6 |   106.9   (x1.03 vs M=1)
qsa q (2560->6144)               |   4 |    0.282 |      8.8 MB |    31.4 |   125.4   (x1.17 vs M=1)
qsa q (2560->6144)               |   6 |    0.359 |      8.8 MB |    24.6 |   147.7   (x1.49 vs M=1)
qsa q (2560->6144)               |   8 |    0.406 |      8.8 MB |    21.8 |   174.2   (x1.69 vs M=1)
qsa q (2560->6144)               |  11 |    0.405 |      8.8 MB |    21.8 |   240.1   (x1.69 vs M=1)
qsa q (2560->6144)               |  12 |    0.458 |      8.8 MB |    19.3 |   231.8   (x1.91 vs M=1)
qsa q (2560->6144)               |  16 |    0.459 |      8.8 MB |    19.3 |   308.7   (x1.91 vs M=1)
qsa q (2560->6144)               |  32 |    0.392 |      8.8 MB |    22.6 |   722.0   (x1.63 vs M=1)

qsa kv (2560->512)               |   1 |    0.158 |      0.7 MB |     4.7 |     4.7   (x1.00 vs M=1)
qsa kv (2560->512)               |   2 |    0.185 |      0.7 MB |     4.0 |     7.9   (x1.17 vs M=1)
qsa kv (2560->512)               |   3 |    0.163 |      0.7 MB |     4.5 |    13.6   (x1.03 vs M=1)
qsa kv (2560->512)               |   4 |    0.185 |      0.7 MB |     4.0 |    15.9   (x1.17 vs M=1)
qsa kv (2560->512)               |   6 |    0.158 |      0.7 MB |     4.7 |    28.1   (x1.00 vs M=1)
qsa kv (2560->512)               |   8 |    0.158 |      0.7 MB |     4.7 |    37.4   (x1.00 vs M=1)
qsa kv (2560->512)               |  11 |    0.239 |      0.7 MB |     3.1 |    34.0   (x1.51 vs M=1)
qsa kv (2560->512)               |  12 |    0.295 |      0.7 MB |     2.5 |    30.0   (x1.87 vs M=1)
qsa kv (2560->512)               |  16 |    0.293 |      0.7 MB |     2.5 |    40.3   (x1.85 vs M=1)
qsa kv (2560->512)               |  32 |    0.293 |      0.7 MB |     2.5 |    80.5   (x1.85 vs M=1)

gdn in_proj-like (2560->16384)   |   1 |    0.314 |     23.6 MB |    75.3 |    75.3   (x1.00 vs M=1)
gdn in_proj-like (2560->16384)   |   2 |    0.306 |     23.6 MB |    77.2 |   154.4   (x0.97 vs M=1)
gdn in_proj-like (2560->16384)   |   3 |    0.295 |     23.6 MB |    79.9 |   239.8   (x0.94 vs M=1)
gdn in_proj-like (2560->16384)   |   4 |    0.363 |     23.6 MB |    65.0 |   259.8   (x1.16 vs M=1)
gdn in_proj-like (2560->16384)   |   6 |    0.392 |     23.6 MB |    60.2 |   361.1   (x1.25 vs M=1)
gdn in_proj-like (2560->16384)   |   8 |    0.451 |     23.6 MB |    52.3 |   418.4   (x1.44 vs M=1)
gdn in_proj-like (2560->16384)   |  11 |    0.466 |     23.6 MB |    50.7 |   557.4   (x1.49 vs M=1)
gdn in_proj-like (2560->16384)   |  12 |    0.508 |     23.6 MB |    46.5 |   557.8   (x1.62 vs M=1)
gdn in_proj-like (2560->16384)   |  16 |    0.465 |     23.6 MB |    50.7 |   811.0   (x1.48 vs M=1)
gdn in_proj-like (2560->16384)   |  32 |    0.440 |     23.6 MB |    53.7 |  1717.6   (x1.40 vs M=1)

hyper/mixer (2560->2560)         |   1 |    0.166 |      3.7 MB |    22.2 |    22.2   (x1.00 vs M=1)
hyper/mixer (2560->2560)         |   2 |    0.162 |      3.7 MB |    22.7 |    45.5   (x0.98 vs M=1)
hyper/mixer (2560->2560)         |   3 |    0.171 |      3.7 MB |    21.6 |    64.7   (x1.03 vs M=1)
hyper/mixer (2560->2560)         |   4 |    0.166 |      3.7 MB |    22.2 |    88.9   (x1.00 vs M=1)
hyper/mixer (2560->2560)         |   6 |    0.193 |      3.7 MB |    19.1 |   114.8   (x1.16 vs M=1)
hyper/mixer (2560->2560)         |   8 |    0.205 |      3.7 MB |    18.0 |   143.6   (x1.24 vs M=1)
hyper/mixer (2560->2560)         |  11 |    0.198 |      3.7 MB |    18.6 |   204.6   (x1.19 vs M=1)
hyper/mixer (2560->2560)         |  12 |    0.216 |      3.7 MB |    17.1 |   205.2   (x1.30 vs M=1)
hyper/mixer (2560->2560)         |  16 |    0.237 |      3.7 MB |    15.6 |   249.3   (x1.42 vs M=1)
hyper/mixer (2560->2560)         |  32 |    0.214 |      3.7 MB |    17.2 |   551.6   (x1.29 vs M=1)

lm_head (2560->248320)           |   1 |    1.957 |    357.6 MB |   182.7 |   182.7   (x1.00 vs M=1)
lm_head (2560->248320)           |   2 |    2.104 |    357.6 MB |   170.0 |   339.9   (x1.07 vs M=1)
lm_head (2560->248320)           |   3 |    2.357 |    357.6 MB |   151.7 |   455.2   (x1.20 vs M=1)
lm_head (2560->248320)           |   4 |    2.847 |    357.6 MB |   125.6 |   502.3   (x1.45 vs M=1)
lm_head (2560->248320)           |   6 |    3.542 |    357.6 MB |   101.0 |   605.7   (x1.81 vs M=1)
lm_head (2560->248320)           |   8 |    5.050 |    357.6 MB |    70.8 |   566.5   (x2.58 vs M=1)
lm_head (2560->248320)           |  11 |    4.677 |    357.6 MB |    76.5 |   841.1   (x2.39 vs M=1)
lm_head (2560->248320)           |  12 |    4.999 |    357.6 MB |    71.5 |   858.4   (x2.55 vs M=1)
lm_head (2560->248320)           |  16 |    5.308 |    357.6 MB |    67.4 |  1077.9   (x2.71 vs M=1)
lm_head (2560->248320)           |  32 |    4.919 |    357.6 MB |    72.7 |  2326.4   (x2.51 vs M=1)

Reading: if ms/call grows ~linearly with M up to 11 and drops at 12,
the verify pass's dense projections re-read their weights per row, and
either padding verify rows to the qmm threshold or a weight-reusing
small-M kernel (MTPLX's verify_qmv idea) is the fix. Compare the M=3
row against the M=12 row: that ratio is the available win per projection.
```

## verify_pass_bench.py (eight calls per eval)

```text
device applegpu_g17s  mlx 0.31.1

A. dense projections, ms/call (8 calls per eval)
  gdn in_proj-like 2560->16384   M=1: 0.066 (x1.00)  M=2: 0.097 (x1.47)  M=3: 0.127 (x1.93)  M=4: 0.156 (x2.36)  M=6: 0.222 (x3.35)  M=12: 0.249 (x3.76)
  lm_head 2560->248320           M=1: 0.888 (x1.00)  M=2: 1.184 (x1.33)  M=3: 1.614 (x1.82)  M=4: 2.085 (x2.35)  M=6: 3.034 (x3.42)  M=12: 3.397 (x3.82)
  qsa q 2560->6144               M=1: 0.040 (x1.00)  M=2: 0.047 (x1.18)  M=3: 0.061 (x1.52)  M=4: 0.071 (x1.78)  M=6: 0.100 (x2.51)  M=12: 0.111 (x2.79)

B. expert chain gate/up/silu*mul/down, ms per layer-call (8 calls per eval)
  1-row pass, 10 pairs M=1        : 0.101 ms
  3-row pass, 30 pairs M=1 (now)  : 0.262 ms  (x2.60 vs 1-row)
  3-row pass, 22 unique x M=3     : 0.433 ms  (x4.30 vs 1-row, x1.65 vs pairs)
  max|pairs - unique| over the 30 routed outputs: 0.000e+00  (0 means bit-identical rows)

C. 12-layer-equivalent? no: per-layer ms, one attention call (8 calls per eval); 2052 selected keys per row
  T=  4096 | S=1: masked 0.118 / gather 0.189 ms (diff 7.3e-04) | S=2: masked 0.112 / gather 0.234 ms (diff 9.8e-04) | S=3: masked 0.315 / gather 0.339 ms (diff 1.2e-04)
  T= 16384 | S=1: masked 0.123 / gather 0.132 ms (diff 1.2e-03) | S=2: masked 0.227 / gather 0.233 ms (diff 9.8e-04) | S=3: masked 1.159 / gather 0.336 ms (diff 1.5e-05)
  T= 32768 | S=1: masked 0.181 / gather 0.131 ms (diff 9.8e-04) | S=2: masked 0.332 / gather 0.231 ms (diff 9.8e-04) | S=3: masked 2.305 / gather 0.336 ms (diff 4.9e-04)
  T= 65536 | S=1: masked 0.296 / gather 0.126 ms (diff 1.2e-03) | S=2: masked 0.574 / gather 0.228 ms (diff 7.3e-04) | S=3: masked 5.285 / gather 0.338 ms (diff 4.9e-04)
  T=131072 | S=1: masked 0.565 / gather 0.130 ms (diff 9.8e-04) | S=2: masked 1.121 / gather 0.241 ms (diff 9.8e-04) | S=3: masked 15.783 / gather 0.340 ms (diff 9.5e-07)

Reading: S=1,2 use the vector kernel (skips masked keys); S=3 is the dense fallback. If the S=3 masked
column grows with T and the gather column does not, the 3-row verify pays an O(context) attention read that
either a 2+1 row split or a rows-gather removes. The diff column shows the numerical class of the gather.
```
