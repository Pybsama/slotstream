---
type: run
id: 01m2n6p9myym8phtqwbqyzkr5f
created: 2026-09-16T13:32:24.094076+00:00
updated: 2026-09-16T13:38:51.657891+00:00
summary: 'Taps offline stage: the attention tap reads 0.7292 top-10 agreement against 0.6171 for the shipped forecast, twin coverage 0.539 against 0.439; the gate passes'
binary: 661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099 (taps build)
captured_at: 2026-09-14
command: run-taps-capture.sh (Tools/expert_lookahead.py prepare and capture at 10 GB, observer taps); Tools/expert_lookahead_taps.py audit; Tools/expert_lookahead_taps.py twin --run xla-pilot-20260911/pilot --forecast-run xla3-taps-20260915/capture
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, offline stage: native capture of the attention taps, audit and twin'
tool: slotstream expert-lookahead-capture; Tools/expert_lookahead_taps.py audit and twin
---
Forecast taps, offline stage ([[records/plan/decode-forecast-taps-2026-09-14]]): where the router-reuse forecast reads the streams, captured natively on the pilot validation requests, audited against the true routes and replayed in the prefetch twin on the pilot's 20 GB residency. Artifacts live under `.build/expert-lookahead/xla3-taps-20260915/` (ignored by git). Nothing was installed, published or committed.

## Build and checks

Working tree at `ad89ecc` plus the forecast-tap diagnostic, default off: `RouterForecastTap` (boundary, attention, attention-shared), observer-only taps and candidates per row in the capture command, shard format 3 carrying the tap in the forecast record's source field, `SLOTSTREAM_EXPERT_PREFETCH_TAP` for the router policy with issue on arrival, and the `expert-lookahead-forecast-tap` check. The tree also held another session's uncommitted Sevra app hunks in `Engine.swift`, `Governor.swift` and `WeightStore.swift`, none on the decode path. `make build` took 127.9 s; `slotstream-checks --tier t0 --tier t1` passed 55 checks with 30,359 assertions, including `expert-lookahead-forecast-tap` (31) and `decode-lookahead-defaults` (32). The binary was copied to `.build/expert-lookahead/bin-xla3-taps-20260915/` so a later rebuild could not replace it during a run.

## Capture

`run-taps-capture.sh` on protocol `xla3-taps-20260915`, a successor of `xla-pilot-20260911` whose shards were re-verified at freeze. 10 GB target, draft depth 2, greedy (seed 42), thinking off, prefix cache off, prefill chunk 256, `SLOTSTREAM_OPT_EXPERT_PREFETCH=0`; observer forecasts at boundary strides 2 and 1 and at both attention taps, 24 candidates per row; features and x2 off. Preflight saw 24.5 GB reclaimable. The plan kept 838 slots (about 17 experts per layer) with the draft head. The 13 pilot validation requests completed in 716 s at a 10.01 GB peak: 1,025 complete verify passes, 3,075 verify tokens, 191,675 forecast records, 13 shards of 123,609,268 bytes. `validate-data` passed. Routing never depends on the cache size, which is what lets these forecasts join the pilot's residency.

## Audit

`Tools/expert_lookahead_taps.py audit`, targets 2 to 47, 141,450 rows per variant:

| forecast | top-10 agreement | exact top-10 | recall at 16 | recall at 24 |
| --- | ---: | ---: | ---: | ---: |
| boundary, stride 2 (shipped) | 0.6171 | 0.0223 | 0.7389 | 0.8125 |
| attention tap | 0.7292 | 0.0530 | 0.8565 | 0.9162 |
| attention tap with the shared expert | 0.7398 | 0.0603 | 0.8655 | 0.9217 |
| boundary, stride 1 | 0.7619 | 0.0885 | 0.8819 | 0.9319 |

By eight-layer group the attention tap gains 0.08 to 0.16 over stride 2, most in layers 0 to 7 (0.535 to 0.696). At margin threshold 0.062 the three stride-2-timed variants keep about the same candidates per row (7.45, 7.58, 7.57), and the share the router chose rises from 0.710 to 0.824 and 0.836, covering 0.529, 0.625 and 0.633 of the chosen experts. Stride 2 reproduces the earlier native audit (0.628 on the same requests plus the correctness set).

## Twin

`Tools/expert_lookahead_taps.py twin --run xla-pilot-20260911/pilot --forecast-run xla3-taps-20260915/capture --cost-model xla-probes-20260911/router-reuse.json`: 10 candidates per row, issue cap 32, 64 records held, 16 lanes, barrier period 4 (boundary forecasts arrive at the completed layer when its barrier falls there and otherwise at the next routing readback; attention taps at their source layer's readback), speculative reads waiting for demand reads. 1,025 passes joined token by token and route by route, 338,147 misses, 233.6 s of decode.

| forecast at threshold 0.062 | issued | timely | wasted | timely coverage | precision | projected |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| boundary, stride 2 (shipped) | 284,812 | 148,396 | 136,416 | 0.439 | 0.521 | 1.161 |
| attention tap | 244,766 | 169,054 | 75,712 | 0.500 | 0.691 | 1.187 |
| attention tap with the shared expert | 243,667 | 171,566 | 72,101 | 0.507 | 0.704 | 1.191 |
| stride 2 plus the attention tap | 364,438 | 189,083 | 175,355 | 0.559 | 0.519 | 1.217 |

Interpolated at the shipped setting's 284,812 issued reads: attention tap coverage 0.5393 with 102,443 wasted, shared-expert tap 0.5492 with 99,104, stride 1 (arriving one attention block before its layer) 0.5785 with 89,203. Adding the tap to stride 2 is below the tap alone at matched traffic. Demand priority off, twice the read service time and a 32-record cap left every coverage unchanged: at these leads the twin is limited by forecast accuracy, not read timing, and it never counts a read still in flight, so it overstates what a native run can keep. Projected ratios are the twin's, never claims.

## Registration

`taps-preregistration.md` holds the question, data, metrics, offline gate and screen design, written between the capture protocol's freeze (23:15:19) and the capture launch (23:16:34); an addendum written after the gate and before any screen, between 23:30 and the screen directory's 23:33:20 copy of the file, which contains it (gate outcome, the attention tap chosen because the shared expert added 0.00988 coverage against a 0.01 margin, the smaller-profile rule and B1 as the confirmation set); and a correction written at about 23:33:56, 36 s after the watcher launched the 18 GB screen and before its first cell finished at 23:34:46, replacing the B0 gate for the B1 confirmation with a gate sized for one change inside the qualified configuration. The time labels first written into the file were estimates; they were corrected against file times, logs and the session transcript.

## Artifacts (sha256)

- binary `661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099`, metallib `198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597`
- protocol.json `b812a4dca78aa76f331a425189f3a785aae32f62610fcb9dfb727f7674392aec`
- requests-validation13.json `ce8dffd7fef1e97296441c3719896bada6202e256f84747dda6fcf525a513643`
- capture/run.json `7ca2ccd389b2913a74bcf96dd933187629502b54d2663fb6ce90d41ad9201f74`
- capture/requests.jsonl `0ae8036e159984c483b0f344f0ea68942fd7d3559027e2d2e5fd7451bb813842`
- tap-audit.json `869875e007ae136f6d0c81d26b92e7563d30a51082d838f6ff8d260902e7553b`
- tap-twin.json `b9ed887e75a20b3679af060f3bf5a53b62896de8ce0eaf6af07e34f833ddb8ac`, tap-twin.log `207091f6380b556f44cc3b3dc097bf41503e266f1a187c284ea81dd027fec933`
- run-taps-capture.sh `796eef94a1a341e95f3085506133f7987779148a378b05921e8912084d28ff51`
- Tools/expert_lookahead_taps.py `3257068ff802a8e5146d2bc5660017b54917542388d46b82ac69b7af36f81e57`
- cost model router-reuse.json `11cc7bfdfc27199a312759a1006ba8866df924bc071bb2558ef9492f3a78d0e4`

## Capture run.log

```text
Mon Sep 14 23:16:34 -05 2026
reclaimable at launch 24.6 GB
vm.swapusage: total = 1024.00M  used = 1.00M  free = 1023.00M  (encrypted)
79831 0.09GB /Users/carlos/Projects/slotstream/.build/Sevra.app/Contents/MacOS/Sevra
84335 0.05GB .build/SevraAudit.app/Contents/MacOS/Sevra
== capture ==
[23:16:34] preflight ok: 24.5 GB reclaimable for a 10.0 GB target
[23:28:30] capture exited 0 after 716 s
== validate-data ==
{
 "run": ".build/expert-lookahead/xla3-taps-20260915/capture",
 "requests": 13,
 "valid": 13,
 "incomplete": [],
 "totals": {
  "executables": [
   "661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099"
  ],
  "passes": 1072,
  "verify": 1025,
  "plain": 0,
  "prefill": 47,
  "features": 0,
  "layers": 51456,
  "routes": 51456,
  "demands": 49824,
  "x2_bytes": 0,
  "verify_tokens": 3075,
  "kept": 2616,
  "hits": 2003,
  "misses": 1221386,
  "adopted": 0,
  "residency": 13,
  "forecasts": 191675
 },
 "bytes": 123609268
}
VALIDATE-DATA PASS
== model processes after ==
none
TAPS CAPTURE DONE
script exit 0
```

## Twin log

```text
boundary-s2-k4                     none   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k4                    0.000   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k4                    0.031   323646   157295      0   166351  0.465  0.486  1.49  1.173
boundary-s2-k4                    0.062   284812   148396      0   136416  0.439  0.521  1.40  1.161
boundary-s2-k4                    0.100   244360   137808      0   106552  0.408  0.564  1.32  1.147
boundary-s2-k4                    0.150   202045   124672      0    77373  0.369  0.617  1.23  1.130
boundary-s2-k4                    0.214   161015   109247      0    51768  0.323  0.678  1.15  1.112
boundary-s2-k4                    0.300   121923    91164      0    30759  0.270  0.748  1.09  1.091
boundary-s2-k4                    0.500    70459    59916      0    10543  0.177  0.850  1.03  1.058
boundary-s2-k4                    0.750    38779    35120      0     3659  0.104  0.906  1.01  1.033
boundary-s2-k4                    1.000    21742    20064      0     1678  0.059  0.923  1.00  1.019
boundary-s2-k1                     none   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k1                    0.000   422054   177122      0   244932  0.524  0.420  1.72  1.201
boundary-s2-k1                    0.031   323646   157295      0   166351  0.465  0.486  1.49  1.173
boundary-s2-k1                    0.062   284812   148396      0   136416  0.439  0.521  1.40  1.161
boundary-s2-k1                    0.100   244360   137808      0   106552  0.408  0.564  1.32  1.147
boundary-s2-k1                    0.150   202045   124672      0    77373  0.369  0.617  1.23  1.130
boundary-s2-k1                    0.214   161015   109247      0    51768  0.323  0.678  1.15  1.112
boundary-s2-k1                    0.300   121923    91164      0    30759  0.270  0.748  1.09  1.091
boundary-s2-k1                    0.500    70459    59916      0    10543  0.177  0.850  1.03  1.058
boundary-s2-k1                    0.750    38779    35120      0     3659  0.104  0.906  1.01  1.033
boundary-s2-k1                    1.000    21742    20064      0     1678  0.059  0.923  1.00  1.019
boundary-s1-k1                     none   374430   223417      0   151013  0.661  0.597  1.45  1.275
boundary-s1-k1                    0.000   374430   223417      0   151013  0.661  0.597  1.45  1.275
boundary-s1-k1                    0.031   285818   195985      0    89833  0.580  0.686  1.27  1.227
boundary-s1-k1                    0.062   252719   183610      0    69109  0.543  0.727  1.20  1.208
boundary-s1-k1                    0.100   219142   169025      0    50117  0.500  0.771  1.15  1.187
boundary-s1-k1                    0.150   183852   150918      0    32934  0.446  0.821  1.10  1.163
boundary-s1-k1                    0.214   149900   130184      0    19716  0.385  0.868  1.06  1.136
boundary-s1-k1                    0.300   116666   106424      0    10242  0.315  0.912  1.03  1.108
boundary-s1-k1                    0.500    71643    68620      0     3023  0.203  0.958  1.01  1.067
boundary-s1-k1                    0.750    41448    40514      0      934  0.120  0.977  1.00  1.038
boundary-s1-k1                    1.000    23736    23408      0      328  0.069  0.986  1.00  1.022
attention                          none   360776   204990      0   155786  0.606  0.568  1.46  1.242
attention                         0.000   360776   204990      0   155786  0.606  0.568  1.46  1.242
attention                         0.031   276138   179786      0    96352  0.532  0.651  1.28  1.202
attention                         0.062   244766   169054      0    75712  0.500  0.691  1.22  1.187
attention                         0.100   212709   156117      0    56592  0.462  0.734  1.17  1.170
attention                         0.150   178580   139794      0    38786  0.413  0.783  1.11  1.148
attention                         0.214   145821   121317      0    24504  0.359  0.832  1.07  1.126
attention                         0.300   114242   100513      0    13729  0.297  0.880  1.04  1.101
attention                         0.500    70564    65856      0     4708  0.195  0.933  1.01  1.064
attention                         0.750    40990    39121      0     1869  0.116  0.954  1.01  1.037
attention                         1.000    23907    23013      0      894  0.068  0.963  1.00  1.021
attention-shared                   none   360589   208609      0   151980  0.617  0.579  1.45  1.249
attention-shared                  0.000   360589   208609      0   151980  0.617  0.579  1.45  1.249
attention-shared                  0.031   275390   182861      0    92529  0.541  0.664  1.27  1.207
attention-shared                  0.062   243667   171566      0    72101  0.507  0.704  1.21  1.191
attention-shared                  0.100   211240   158080      0    53160  0.467  0.748  1.16  1.172
attention-shared                  0.150   177105   141541      0    35564  0.419  0.799  1.11  1.151
attention-shared                  0.214   144216   122394      0    21822  0.362  0.849  1.06  1.127
attention-shared                  0.300   112698   101031      0    11667  0.299  0.896  1.03  1.102
attention-shared                  0.500    69028    65708      0     3320  0.194  0.952  1.01  1.064
attention-shared                  0.750    39684    38684      0     1000  0.114  0.975  1.00  1.036
attention-shared                  1.000    22822    22494      0      328  0.067  0.986  1.00  1.021
boundary-s2-k4+attention           none   541634   222303      0   319331  0.657  0.410  1.94  1.273
boundary-s2-k4+attention          0.000   541634   222303      0   319331  0.657  0.410  1.94  1.273
boundary-s2-k4+attention          0.031   414462   199528      0   214934  0.590  0.481  1.64  1.233
boundary-s2-k4+attention          0.062   364438   189083      0   175355  0.559  0.519  1.52  1.217
boundary-s2-k4+attention          0.100   312439   176128      0   136311  0.521  0.564  1.40  1.198
boundary-s2-k4+attention          0.150   257669   159516      0    98153  0.472  0.619  1.29  1.174
boundary-s2-k4+attention          0.214   205387   139975      0    65412  0.414  0.682  1.19  1.149
boundary-s2-k4+attention          0.300   155843   117043      0    38800  0.346  0.751  1.11  1.121
boundary-s2-k4+attention          0.500    91257    77661      0    13596  0.230  0.851  1.04  1.076
boundary-s2-k4+attention          0.750    51612    46658      0     4954  0.138  0.904  1.01  1.044
boundary-s2-k4+attention          1.000    30220    27888      0     2332  0.082  0.923  1.01  1.026
boundary-s2-k4+attention-shared    none   548483   226075      0   322408  0.669  0.412  1.95  1.281
boundary-s2-k4+attention-shared   0.000   548483   226075      0   322408  0.669  0.412  1.95  1.281
boundary-s2-k4+attention-shared   0.031   419449   203095      0   216354  0.601  0.484  1.64  1.239
boundary-s2-k4+attention-shared   0.062   368361   192200      0   176161  0.568  0.522  1.52  1.222
boundary-s2-k4+attention-shared   0.100   315458   178952      0   136506  0.529  0.567  1.40  1.202
boundary-s2-k4+attention-shared   0.150   260105   162234      0    97871  0.480  0.624  1.29  1.178
boundary-s2-k4+attention-shared   0.214   206754   142016      0    64738  0.420  0.687  1.19  1.151
boundary-s2-k4+attention-shared   0.300   156580   118539      0    38041  0.351  0.757  1.11  1.122
boundary-s2-k4+attention-shared   0.500    91019    78312      0    12707  0.232  0.860  1.04  1.077
boundary-s2-k4+attention-shared   0.750    51273    46899      0     4374  0.139  0.915  1.01  1.045
boundary-s2-k4+attention-shared   1.000    29707    27790      0     1917  0.082  0.935  1.01  1.026
matched to the shipped setting's issued reads:
  boundary-s2-k4                   coverage 0.439, wasted 136416, projected 1.161
  boundary-s2-k1                   coverage 0.439, wasted 136416, projected 1.161
  boundary-s1-k1                   coverage 0.578, wasted 89203, projected 1.226
  attention                        coverage 0.539, wasted 102443, projected 1.207
  attention-shared                 coverage 0.549, wasted 99104, projected 1.212
  boundary-s2-k4+attention         coverage 0.496, wasted 117063, projected 1.186
  boundary-s2-k4+attention-shared  coverage 0.502, wasted 115116, projected 1.189
sensitivities at threshold 0.062:
  {"cap": 32}                      boundary-s2-k4     issued  284508 cov 0.438 prec 0.521 ratio 1.160
  {"cap": 32}                      attention          issued  244766 cov 0.500 prec 0.691 ratio 1.187
  {"cap": 32}                      attention-shared   issued  243667 cov 0.507 prec 0.704 ratio 1.191
  {"demand_priority": false}       boundary-s2-k4     issued  284812 cov 0.439 prec 0.521 ratio 1.161
  {"demand_priority": false}       attention          issued  244766 cov 0.500 prec 0.691 ratio 1.187
  {"demand_priority": false}       attention-shared   issued  243667 cov 0.507 prec 0.704 ratio 1.191
  {"service_factor": 2.0}          boundary-s2-k4     issued  284812 cov 0.439 prec 0.521 ratio 1.161
  {"service_factor": 2.0}          attention          issued  244766 cov 0.500 prec 0.691 ratio 1.187
  {"service_factor": 2.0}          attention-shared   issued  243667 cov 0.507 prec 0.704 ratio 1.191

[exited with code 0]
```
