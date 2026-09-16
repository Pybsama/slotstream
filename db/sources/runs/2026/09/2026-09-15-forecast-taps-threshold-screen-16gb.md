---
type: run
id: 01m2n6p9n4khjzjwg28hrqeygj
created: 2026-09-16T13:32:24.100742+00:00
updated: 2026-09-16T13:32:24.100742+00:00
summary: 'Threshold screen at 16 GB: t031 1.015 on the first twelve counted pairs (below the 1.02 confirmation bar), t000 0.994; 47 of 48 cells counted, outputs identical; the 0.062 threshold stays'
binary: '3e6652f30aec593dd5240213f173429cf369abf8c3917741235b01ff1dfe755e (correction build)'
captured_at: 2026-09-15
command: 'chain-threshold.sh, run-threshold-screen.sh and chain-threshold-resume.sh (Tools/expert_lookahead.py prepare --memory-gb 16; Tools/decode_sweep.py --rounds 3 then 4 --max-tokens 256 --warmup-tokens 128, contention sampler)'
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 10: issue threshold screen for the corrected tap at 16 GB'
tool: 'Tools/decode_sweep.py over slotstream expert-lookahead-bench; analyze_learned_screen.py'
---
Forecast taps, step 10 ([[records/plan/decode-forecast-taps-2026-09-14]]): with the learned correction on, does a lower issue threshold raise decode throughput over the confirmed 0.062? Artifacts are under `.build/expert-lookahead/xla3-threshold-screen-16gb/`, which git ignores. Nothing was installed, published or committed, and no default changed. The registered rule adds rounds until 12 counted pairs per candidate or six rounds; four rounds ran.

## Registration

`threshold-preregistration.md` (the copy in the run directory, sha256 `84e43874096a7f5ebae1569c0ebb6c2229a5f24bc4aa47852ec0dcd5b4844851`, written 2026-09-15 12:59:38 -05 with a profile amendment at 13:00, before any cell ran) fixes the arms (the confirmation's attention-corrected configuration at threshold 0.062 as t062, and the same at 0.031 and 0.0 as t031 and t000; a row's candidates whose margin over its tenth lies below the threshold are not issued), the screen (r0005, r0206, r0096, r0074 at 256 outputs, the contention rule and the Sevra sensitivity, rounds until 12 counted pairs per candidate or six), the reading (identical outputs; paired ratio at least 1.01 with at least 8 of the first 12 counted pairs above 1; a candidate goes to confirmation only at 1.02 or more) and the held-out confirmation (eight prompts from the 26 unused training-split families, three rounds at 512 outputs at 20 GB, the correction's gate). The motivation: with the correction, issued reads are adopted at a median 0.83 against the attention tap's 0.70, and the twin's threshold curve for the corrected forecast gives coverage 0.543 at 0.062, 0.582 at 0.031 and 0.670 at 0.0 with no traffic bound, while decode serialization round 2 found natively that extra speculative reads did not reduce demand reads for the boundary forecast.

## Run

The launcher (`run-threshold-screen.sh`, sha256 `7683ff9516c4f96040e1e8088669827fd0008594313d09c38cec104301745a92`) sized the profile at launch: another session's virtual machine held 9 GB, leaving 22.35 GB reclaimable, so the screen ran at 16 GB as a mechanism screen (protocol `xla3-threshold-screen-16gb`, sha256 `46d0bd870483b0d4309c981f96afd833d52474a75aec1657a59c3a1fc3e0952c`, frozen 13:02:21 on the correction build sha256 `3e6652f30aec593d...`), with an expert cache of 2,746 slots against 4,206 at 20 GB, so hit rates were about 0.57 against 0.70 in the correction's screen. Configurations: `configs-threshold.json` (sha256 `c8b24c7f1506ce791738e0589c848f0e52dbfc68a541066b134a469eeb99065e`), identical except the threshold. Three rounds of twelve cells ran from 13:02:21. At 13:50 the Sevra app (the Mac app under development in another session) took the per-user model lock, and the sweep stopped at its 35th cell with the lock refusal (`sweep-rounds3.log`, sha256 `416f7d8264c3c4aafa426d5b88f9ebf99ca807a20677e2e87227576866557a0b`), leaving r0074's round-2 t062 and t031 cells unrun. The sweep resumed in the same directory at 14:28:15 once the lock was free, completed those two cells and ran round 4 (`sweep-rounds4.log`, sha256 `5943ecc55e7f8501a00dc86558f7c1f3a143b32b52e7705a6c3bb412f79451bd`), ending at 14:47:47 with 30.7 GB reclaimable throughout. The contention sampler wrote 613 lines in the first three rounds and covered round 4 as well; no arm window held a compiler, linker or second slotstream engine, and the Sevra app peaked at 11.0% CPU, below the 25% sensitivity cutoff, so the sensitivity reading equals the rule as written.

## Results

48 cells, 47 counted; the one exclusion is r0074 round 2 t000, for host swap-outs. Outputs were identical in every cell. Paired ratios, candidate over t062 on the same prompt and round (`sweep/cells.jsonl`, sha256 `fda5d8b07541122c6af902d57b7d96fcb641992ed4b1a452f69a501beb1db2b8`; `sweep/learned-screen-analysis.json`, sha256 `f0e6d2456e9ccfb845e429f6626117757b9abc9950b21c5473624e13906835fd`):

| candidate | counted pairs | first-12 ratio | above 1 of 12 | all-pairs ratio | above 1 | min | max | reading |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| t031 (0.031) | 16 | 1.015 | 10 | 1.013 | 13 | 0.987 | 1.055 | passes the screen reading, below the 1.02 confirmation bar |
| t000 (0.0) | 15 | 0.994 | 6 | 0.992 | 6 | 0.947 | 1.067 | fails |

Identical under the Sevra sensitivity (the app peaked at 11.0% CPU, in an excluded cell). By round, t031's pairs ran 1.019, 1.033, 0.996, 1.055; 1.006, 1.002, 1.050, 1.003; 1.001, 0.998, 1.019, 1.000; 1.022, 0.987, 1.011, 1.001. Median tok/s over counted cells: t062 12.49, t031 12.54, t000 12.28. Median counters per counted cell, t062 then t031 then t000: records read in decode 17,780, 15,960, 10,670; reads issued 32,270, 36,510, 44,080; adopted 26,800, 28,870, 31,330; expired unused 3,832, 5,356, 9,033; wasted bytes 10.6 GB, 14.9 GB, 25.1 GB; reads still in flight when demanded 4,610, 5,978, 10,702; join seconds 0.074, 0.107, 0.365.

## Outcome

Issuing every top-10 candidate (t000) cuts demand reads by 40% and still slows decode by 0.6% on 15 pairs: the extra reads arrive late (twice the in-flight reads at demand time, five times the join time) and waste 2.4 times the bytes, which matches decode serialization round 2's native finding rather than the twin's unbounded curve. The middle threshold (t031) cuts demand reads 10% for 13% more issued reads and runs 1.3% faster over 16 pairs, 13 of them above 1, with the effect shrinking over the rounds (1.026 in round 0, 1.005 in round 3). It passes the screen reading but not the registered 1.02 bar for a confirmation, so no confirmation runs and the threshold stays at 0.062. Read as a mechanism screen at 16 GB, where the expert cache is smaller and demand reads more frequent than at 20 GB: a lower threshold buys a small, consistent gain that is under the gate here and would likely be smaller at 20 GB. The lever closes at this result; a later re-tune would belong with any change that moves the forecast's precision again, such as the readout tap.

## Rounds 0 to 2 (stopped by the model lock)

```text
screen chain ended (13:54:06)
== screen, 3 rounds (13:02:19)
{"run_id": "xla3-threshold-screen-16gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-threshold-screen-16gb/protocol.json", "memory_gb": 16.0}
configs: [('t062', '0.062'), ('t031', '0.031'), ('t000', '0.0')]
screen .build/expert-lookahead/xla3-threshold-screen-16gb to 3 rounds with 22.35 GB reclaimable (13:02:21)
sweep exit 1 (13:53:59)
no model process
34 cells, 33 counted as written, 33 under the Sevra sensitivity, 613 sampler lines

exact outputs in every cell with output: yes

counted:
  config                       cells  med tps | pairs  ratio  >1    min    max | first 12: ratio  >1  pass
  t062                            11    12.29 |     0      -   0      -      - |      -   0 False
  t000                            11    12.11 |    11  0.993   5  0.947  1.067 |  0.993   5 False
  t031                            11    12.53 |    11  1.017  10  0.996  1.055 |  1.017  10 False

counted_sensitivity:
  config                       cells  med tps | pairs  ratio  >1    min    max | first 12: ratio  >1  pass
  t062                            11    12.29 |     0      -   0      -      - |      -   0 False
  t000                            11    12.11 |    11  0.993   5  0.947  1.067 |  0.993   5 False
  t031                            11    12.53 |    11  1.017  10  0.996  1.055 |  1.017  10 False

median prefetch counters per counted cell (rule as written):
  decodeRecords          t062=1.694e+04  t000=1.066e+04  t031=1.524e+04
  verifyPasses           t062=96  t000=96  t031=96
  issued                 t062=2.968e+04  t000=4.408e+04  t031=3.359e+04
  adopted                t062=2.515e+04  t000=3.133e+04  t031=2.711e+04
  promoted               t062=4818  t000=1.07e+04  t031=6764
  expired                t062=3174  t000=9033  t031=4317
  cancelled              t062=10  t000=76  t031=18
  demandMisses           t062=1.692e+04  t000=1.066e+04  t031=1.523e+04
  wastedBytes            t062=8.775e+09  t000=2.508e+10  t031=1.195e+10
  arrivalIssues          t062=4406  t000=4483  t031=4437
  slotEvictedKeys        t062=2.515e+04  t000=3.133e+04  t031=2.712e+04
  joinSeconds            t062=0.07832  t000=0.3652  t031=0.1145
  adoptSeconds           t062=0.109  t000=0.4768  t031=0.1591
  forecastBuildSeconds   t062=0.09455  t000=0.1039  t031=0.08787
  forecastEvalSeconds    t062=4.771  t000=5.189  t031=4.649
  forecastSelectSeconds  t062=0.1879  t000=0.2205  t031=0.1748
  scheduleSeconds        t062=0.1144  t000=0.1469  t031=0.1153

counted pairs per candidate: {'t000': 11, 't031': 11} (rounds are added until 12 or six rounds)
screen reading for t031: as written False, Sevra sensitivity False, confirmation runs False
wrote .build/expert-lookahead/xla3-threshold-screen-16gb/sweep/learned-screen-analysis.json
after 3 rounds: error, fewest counted pairs 34 cells
CHAIN STOPPED: the analysis does not cover 3 rounds

[exited with code 0]
```

## Resume and round 3

```text
threshold resume ended (14:47:52)
  joinSeconds            t062=0.07433  t000=0.3652  t031=0.1071
  adoptSeconds           t062=0.1058  t000=0.4768  t031=0.1429
  forecastBuildSeconds   t062=0.08841  t000=0.1025  t031=0.08649
  forecastEvalSeconds    t062=4.634  t000=5.115  t031=4.719
  forecastSelectSeconds  t062=0.1699  t000=0.2186  t031=0.1743
  scheduleSeconds        t062=0.1065  t000=0.1391  t031=0.1149

counted pairs per candidate: {'t000': 15, 't031': 16} (rounds are added until 12 or six rounds)
screen reading for t031: as written True, Sevra sensitivity True, confirmation runs True
wrote .build/expert-lookahead/xla3-threshold-screen-16gb/sweep/learned-screen-analysis.json
before round 5: ok, fewest counted pairs 15, last round seen 3 (14:47:47)
enough pairs
  t031                            16    12.54 |    16  1.013  13  0.987  1.055 |  1.015  10 True

counted_sensitivity:
  config                       cells  med tps | pairs  ratio  >1    min    max | first 12: ratio  >1  pass
  t062                            16    12.49 |     0      -   0      -      - |      -   0 False
  t000                            15    12.28 |    15  0.992   6  0.947  1.067 |  0.994   6 False
  t031                            16    12.54 |    16  1.013  13  0.987  1.055 |  1.015  10 True

median prefetch counters per counted cell (rule as written):
  decodeRecords          t062=1.778e+04  t000=1.067e+04  t031=1.596e+04
  verifyPasses           t062=91.5  t000=96  t031=91.5
  issued                 t062=3.227e+04  t000=4.408e+04  t031=3.651e+04
  adopted                t062=2.68e+04  t000=3.133e+04  t031=2.887e+04
  promoted               t062=4610  t000=1.07e+04  t031=5978
  expired                t062=3832  t000=9033  t031=5356
  cancelled              t062=11.5  t000=78  t031=18.5
  demandMisses           t062=1.776e+04  t000=1.067e+04  t031=1.596e+04
  wastedBytes            t062=1.063e+10  t000=2.508e+10  t031=1.489e+10
  arrivalIssues          t062=4232  t000=4483  t031=4251
  slotEvictedKeys        t062=2.68e+04  t000=3.133e+04  t031=2.887e+04
  joinSeconds            t062=0.07433  t000=0.3652  t031=0.1071
  adoptSeconds           t062=0.1058  t000=0.4768  t031=0.1429
  forecastBuildSeconds   t062=0.08841  t000=0.1025  t031=0.08649
  forecastEvalSeconds    t062=4.634  t000=5.115  t031=4.719
  forecastSelectSeconds  t062=0.1699  t000=0.2186  t031=0.1743
  scheduleSeconds        t062=0.1065  t000=0.1391  t031=0.1149

counted pairs per candidate: {'t000': 15, 't031': 16} (rounds are added until 12 or six rounds)
screen reading for t031: as written True, Sevra sensitivity True, confirmation runs True
wrote .build/expert-lookahead/xla3-threshold-screen-16gb/sweep/learned-screen-analysis.json
screen reading for t000: as written False, Sevra sensitivity False, confirmation runs False
wrote .build/expert-lookahead/xla3-threshold-screen-16gb/sweep/learned-screen-analysis.json
THRESHOLD SCREEN RESUME DONE (14:47:47)

[exited with code 0]
```
