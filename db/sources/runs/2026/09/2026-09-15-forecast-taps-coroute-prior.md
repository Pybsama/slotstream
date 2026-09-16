---
type: run
id: 01m2n6p9n10cxzggjgn8g66hzh
created: 2026-09-16T13:32:24.097592+00:00
updated: 2026-09-16T13:32:24.097592+00:00
summary: 'Co-routing prior: leave-one-request-out top-10 agreement +0.0032 and matched-traffic twin coverage +0.0094 against bars of 0.03; negative, no native diagnostic'
binary: 'none (CPU analysis of recorded captures)'
captured_at: 2026-09-15
command: 'run-coroute.sh (Tools/expert_lookahead_coroute.py table --run xla-pilot-20260911/pilot; audit --forecast-run xla3-taps-20260915/capture; twin)'
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 5: co-routing prior, offline'
tool: 'Tools/expert_lookahead_coroute.py table, audit and twin'
---
Forecast taps, step 5 ([[records/plan/decode-forecast-taps-2026-09-14]]): does a co-routing prior, built from layer T-1's routed experts that the host already holds when the attention tap's forecast for T arrives, sharpen that forecast? Registered before any number existed in `.build/expert-lookahead/xla3-coroute-20260915/coroute-preregistration.md` (2026-09-14 23:57:17 -05, sha256 `2c49eee2f7212f359c5f652758a2e566b619d0b420e32c55132e6fd68ff1a1a5`), with `Tools/expert_lookahead_coroute.py` (sha256 `60073aef3d5f612531360f60478661e773825cd94c1a76bfd490a19e9c0333b3`) written in the same step. CPU only. It ran from 00:37:31 to 00:37:49 on 2026-09-15, after the taps screen's third round ended and before its fourth round started (00:38:12), so no timed cell overlapped it. Nothing was installed, published or committed.

## Table

The 56 training-split requests of `xla-pilot-20260911/pilot`: 4,180 complete verify passes, 12,540 rows per layer, counting for every layer T from 1 to 47 the pairs (i routed at T-1, j routed at T) in the same row. Smoothed pointwise mutual information with alpha 20 as registered.

## Audit

The 13 validation requests of `xla3-taps-20260915/capture`, attention tap, 1,025 passes, targets 2 to 47. Each of the tap's 24 recorded candidates is rescored as margin plus beta times the summed PMI over T-1's ten routed experts.

| beta | top-10 agreement | exact top-10 | recall at 16 |
| ---: | ---: | ---: | ---: |
| 0 (the tap) | 0.7292 | 0.0530 | 0.8565 |
| 0.02 | 0.7323 | 0.0465 | 0.8612 |
| 0.05 | 0.7019 | 0.0272 | 0.8421 |
| 0.1 | 0.6652 | 0.0139 | 0.8223 |
| 0.3 | 0.6149 | 0.0047 | 0.7962 |
| 1 | 0.5869 | 0.0023 | 0.7817 |

Leave-one-request-out chose beta 0.02 for all 13 requests: top-10 agreement 0.7323, 0.0032 above the tap. Sensitivities: alpha 5 gives 0.7251 (folds chose 0 or 0.02) and alpha 80 gives 0.7346. Checks held: beta 0 reproduces the taps audit's 0.7292 and recall at 24 stays 0.9162 at every beta.

## Twin

The same forecasts joined onto the pilot's 20 GB residency with the taps twin's settings, each request with its fold's beta, on the finer threshold grid. At the shipped setting's 284,812 issued reads (reproduced exactly):

| forecast | timely coverage | wasted reads | projected |
| --- | ---: | ---: | ---: |
| boundary, stride 2 (shipped) | 0.4389 | 136,416 | 1.161 |
| attention tap | 0.5397 | 102,326 | 1.206 |
| attention tap with the co-routing prior | 0.5490 | 99,161 | 1.211 |

## Outcome

The registered gate needed 0.03 more top-10 agreement and 0.03 more coverage at matched traffic. The prior gave 0.0032 and 0.0094 (with 3,165 fewer wasted reads), so both conditions fail. As registered, this is recorded as a negative result, no native diagnostic is built, and the next accuracy step is the learned correction. Agreement peaks at the smallest nonzero beta and falls below the tap from 0.05 on, while exact rows fall at every nonzero beta. That is consistent with T-1's routes carrying little about T's choices beyond what the tap already reads from the same streams, but this probe does not test that explanation. Projected ratios are the twin's, never claims.

## Artifacts (sha256)

- coroute-table.npz `f2f000a3cee9c4e1689d9da39db51d4ec776df9bbf7cbd378795f2c8379bed64`, coroute-table.json `2a5af9808bb7dac8fca7f32acf56049817cbfcab5b7c53f623e879969e07f517`
- coroute-audit.json `2fdc6610137891c935f9edd1295a1fd25a8d28b90ca73c48be465481073b5bc7`
- coroute-twin.json `1905f33b30c9e7aaa02b859de2dd281b984a66de71f49c37d07ed05ca4655768`
- logs: table.log, audit.log, twin.log in the same directory

## Table, audit and twin

```text
== table (00:37:31) ==
56 requests, 4180 verify passes, 12540 rows per layer, table f2f000a3cee9c4e1
== audit (00:37:34) ==
1025 passes, tap attention, targets >= 2
alpha 20.0:   beta   top10   exact   rec16   rec24
            0.00  0.7292  0.0530  0.8565  0.9162
            0.02  0.7323  0.0465  0.8612  0.9162
            0.05  0.7019  0.0272  0.8421  0.9162
            0.10  0.6652  0.0139  0.8223  0.9162
            0.20  0.6308  0.0067  0.8046  0.9162
            0.30  0.6149  0.0047  0.7962  0.9162
            0.50  0.5998  0.0032  0.7885  0.9162
            0.75  0.5914  0.0027  0.7840  0.9162
            1.00  0.5869  0.0023  0.7817  0.9162
          leave-one-request-out 0.7323 (exact 0.0465, rec16 0.8612), betas [0.02]
alpha 5.0:   beta   top10   exact   rec16   rec24
            0.00  0.7292  0.0530  0.8565  0.9162
            0.02  0.7294  0.0442  0.8583  0.9162
            0.05  0.6955  0.0252  0.8369  0.9162
            0.10  0.6590  0.0129  0.8176  0.9162
            0.20  0.6269  0.0065  0.8014  0.9162
            0.30  0.6123  0.0046  0.7942  0.9162
            0.50  0.5984  0.0032  0.7875  0.9162
            0.75  0.5908  0.0027  0.7838  0.9162
            1.00  0.5868  0.0024  0.7818  0.9162
          leave-one-request-out 0.7251 (exact 0.0451, rec16 0.8541), betas [0.0, 0.02]
alpha 80.0:   beta   top10   exact   rec16   rec24
            0.00  0.7292  0.0530  0.8565  0.9162
            0.02  0.7346  0.0489  0.8635  0.9162
            0.05  0.7098  0.0303  0.8486  0.9162
            0.10  0.6742  0.0155  0.8292  0.9162
            0.20  0.6370  0.0073  0.8095  0.9162
            0.30  0.6192  0.0050  0.7997  0.9162
            0.50  0.6015  0.0033  0.7901  0.9162
            0.75  0.5917  0.0027  0.7845  0.9162
            1.00  0.5864  0.0023  0.7815  0.9162
          leave-one-request-out 0.7346 (exact 0.0489, rec16 0.8635), betas [0.02]
primary gain over the tap: +0.0032
== twin (00:37:38) ==
1025 passes, 338147 misses, decode 233.6 s, shipped issued 284812
matched to the shipped setting's issued reads:
  boundary-s2-k4             coverage 0.4389, wasted 136416, projected 1.161
  attention                  coverage 0.5397, wasted 102326, projected 1.206
  attention-coroute          coverage 0.5490, wasted 99161, projected 1.211
co-routing coverage gain +0.0094, wasted change -3165
f2f000a3cee9c4e1689d9da39db51d4ec776df9bbf7cbd378795f2c8379bed64  .build/expert-lookahead/xla3-coroute-20260915/coroute-table.npz
2a5af9808bb7dac8fca7f32acf56049817cbfcab5b7c53f623e879969e07f517  .build/expert-lookahead/xla3-coroute-20260915/coroute-table.json
2fdc6610137891c935f9edd1295a1fd25a8d28b90ca73c48be465481073b5bc7  .build/expert-lookahead/xla3-coroute-20260915/coroute-audit.json
1905f33b30c9e7aaa02b859de2dd281b984a66de71f49c37d07ed05ca4655768  .build/expert-lookahead/xla3-coroute-20260915/coroute-twin.json
COROUTE DONE (00:37:49)

[exited with code 0]
```
