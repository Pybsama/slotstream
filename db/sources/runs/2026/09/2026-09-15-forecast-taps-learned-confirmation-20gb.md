---
type: run
id: 01m2n6p9n41nq2tgr1j3ajztkj
created: 2026-09-16T13:32:24.100092+00:00
updated: 2026-09-16T13:32:24.100092+00:00
summary: 'Learned confirmation at 20 GB: aggregate 1.031 (bootstrap 1.013 to 1.041), kinds 1.025 to 1.055, 30 of 30 pairs counted with identical outputs; passes every registered condition'
binary: '3e6652f30aec593dd5240213f173429cf369abf8c3917741235b01ff1dfe755e (correction build)'
captured_at: 2026-09-15
command: 'run-learned-confirm.sh (make_learned_confirm_plan.py draw of ten held-out prompts; Tools/expert_lookahead.py prepare --memory-gb 20; Tools/decode_cohort.py --plan plan-learned-confirm.json, three rounds at 512 outputs with 128 warmup tokens, contention sampler)'
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 9: held-out confirmation of the corrected tap against the attention tap at 20 GB'
tool: 'Tools/decode_cohort.py over slotstream expert-lookahead-bench; analyze_learned_confirm.py'
---
Forecast taps, step 9 ([[records/plan/decode-forecast-taps-2026-09-14]]): on held-out prompts from corpus families that no earlier run has used, does the native learned correction raise decode throughput over the plain attention tap under the registered gate? Artifacts are under `.build/expert-lookahead/xla3-learned-confirm-20gb/`, which git ignores. Nothing was installed, published or committed, and no default changed.

## Registration

Step 3 of `learned-native-preregistration.md` (sha256 `237b2916fd6cc19e5301ae0273a29b926d14be7bbe8ea6c4aa6d0b0c2b8ea037`, 02:08:16 -05) fixes the set and the gate. The B0 and B1 sets had both informed decisions and the correction was trained on the pilot's training requests, so the prompts come from the 36 training-split families that no capture, fit, screen or cohort had used (code 16, reasoning 8, prose 6, dialogue 3, structured 3; no multilingual family remains): for each kind, its sorted family names shuffled with `random.Random(20260915)`, the first two families, and from each the request with the smallest id. Ten prompts, three rounds at 512 outputs, 30 pairs, at the 20 GB profile once 25.5 GB is reclaimable, process-pageins-v1 with the contention rule. Gate: outputs identical in every pair; aggregate paired ratio (median of rounds per prompt, geometric mean per kind, equal kind weight) at least 1.02; bootstrap 2.5th percentile above 1.00; no kind below 0.97; no kind duration ratio above 1.02; at least two counted pairs for every prompt; under the rule as written and the Sevra sensitivity. The screen passed first.

## Prompts

`make_learned_confirm_plan.py` (sha256 `1ae1d664dc900c78e17ffe49da43a2bddf7673fcc8bb9b6604042aa76ab2410c`) reproduces the registration's audit (the pilot requests, B0, B1, the exploration prompts, and the pilot protocol's correctness and screen prompts) and refuses unless it finds the registered counts; it found 36 families holding 115 requests. It reads the shuffle as a fresh generator for each kind, so the draw does not depend on kind order. The draw was first computed at about 02:33, after the diagnostic passed and before any timing run of the correction, and the plan written at 05:18:22 reproduced it. A scan of 16,983 run files under `.build/` found requests from these families only in a copy of the corpus file itself.

| kind | family | prompt | outputs |
| --- | --- | --- | ---: |
| code | code:Tools/ngram_lookahead_bench.py | r0026 | 111, stop |
| code | code:Tools/gdn_profile.py | r0050 | 512, length |
| dialogue | dialogue:fitness | r0304 | 512, length |
| dialogue | dialogue:finance | r0292 | 178, stop |
| prose | prose:docs/ENGINEERING.md | r0186 | 170, stop |
| prose | prose:docs/HARDWARE.md | r0195 | 163, stop |
| reasoning | reasoning:scheduling | r0156 | 512, length |
| reasoning | reasoning:logic | r0128 | 268, stop |
| structured | structured:employees | r0268 | 168, stop |
| structured | structured:config | r0271 | 92, stop |

## Run

`run-learned-confirm.sh` (sha256 `0b832916506a208758bf3b6b4c38431a22b7bf9ecb00a317ba6e9059352841e8`) refuses unless the screen's reading passed and the binary and correction file hashes match, and waits for no other bench, sweep, cohort, capture or build process and 25.5 GB reclaimable. It launched at 05:18:20 with 30.63 GB reclaimable, `prepare` froze protocol `xla3-learned-confirm-20gb` (sha256 `694323c1ad80debd72829fc27c77af36c27ff2785037cb2a92fe938bb384089f`) at 20 GB on the correction build (sha256 `3e6652f30aec593d...`), and the cohort ran the plan (sha256 `dd8e2975448de35abfc147e9207b4e0fe1cccc8260c5cbcee42ee935b01a33a3`) with the screen's two configurations, the attention tap first: 30 pairs at 512 outputs with a 128-token warmup and alternating arm order, from 05:18:22 to 06:41:26, with no model process left. No arm had a host swap-out, and all 30 pairs were eligible. The contention sampler wrote 985 lines; no arm window held a compiler, linker or second slotstream engine, and the Sevra app peaked at 6.1% CPU, so the sensitivity reading equals the rule as written.

## Results

Outputs were identical in all 30 pairs. `analyze_learned_confirm.py` (sha256 `c58b29b87c84f6912b49a55c3ea7772af1a12a2cba4165cbe91d5faac156f81f`) reproduced the cohort tool's aggregate and bootstrap exactly.

| kind | tok/s ratio | duration ratio | prompt medians (counted pairs) |
| --- | ---: | ---: | --- |
| code | 1.027 | 0.988 | r0026 1.047 (3), r0050 1.008 (3) |
| dialogue | 1.026 | 1.012 | r0304 1.023 (3), r0292 1.028 (3) |
| prose | 1.025 | 0.991 | r0186 1.020 (3), r0195 1.029 (3) |
| reasoning | 1.025 | 0.977 | r0156 1.017 (3), r0128 1.034 (3) |
| structured | 1.055 | 0.971 | r0268 1.042 (3), r0271 1.068 (3) |

| condition | required | result |
| --- | --- | --- |
| identical outputs | every pair | 30 of 30 |
| aggregate ratio, equal kind weight | at least 1.02 | 1.0314 |
| bootstrap 2.5th percentile | above 1.00 | 1.0132 (median 1.0312, 97.5th 1.0409) |
| kind floor | at least 0.97 | 1.0245 (prose) |
| kind duration ratio | at most 1.02 | 1.012 (dialogue) |
| counted pairs per prompt | at least 2 | 3 for every prompt |

Every condition passes under the rule as written and under the Sevra sensitivity. The tool's own B0 verdict, set for prefetch against no prefetch at a 1.10 aggregate, is recorded as not successful with sufficient evidence; it is not this gate. 29 of the 30 pairs were above 1; the exception was r0304 in round 2 at 0.910 (16.62 against 15.13 tok/s). Median decode throughput over the pairs was 14.64 tok/s with the attention tap and 15.14 with the correction. Paired medians, corrected over attention: records read in decode 0.907, decode read bytes 0.907, decode seconds 0.972, request seconds 0.977, expert hit rate 0.999, reads issued 0.922, adopted 1.084, promoted 1.078, expired unused 0.525, wasted bytes 0.523, demand misses 0.903, arrival issues 0.982, forecast evaluation seconds 0.996 and forecast selection seconds 0.978.

## Outcome

The held-out confirmation passes every registered condition. Against the attention tap, the learned correction raises decode throughput by 3.1% in aggregate (bootstrap 1.3% to 4.1%) on ten prompts from families no earlier run used, by reading 9% fewer records in decode and wasting about half as many speculative read bytes, with forecast time unchanged. The comparison is against the attention tap, not the shipped configuration, whose own B1 confirmation did not pass its pairs condition. As registered, a default change, docs and any public number are separate decisions, and so is where the 37,540,708-byte factor file lives and how it is reproduced. Limits: one machine, one model checkpoint, the 20 GB profile, no multilingual prompt, and a correction trained on the pilot's training requests.

Artifacts (sha256): protocol.json `694323c1ad80debd72829fc27c77af36c27ff2785037cb2a92fe938bb384089f`, plan-learned-confirm.json `dd8e2975448de35abfc147e9207b4e0fe1cccc8260c5cbcee42ee935b01a33a3`, learned-native-preregistration.md `237b2916fd6cc19e5301ae0273a29b926d14be7bbe8ea6c4aa6d0b0c2b8ea037`, contention-samples.txt `c3a3772e0e6a85db00f64c98425a2aa7d5637b7cd49b2187e4e4a7d20ae4bbf5`, cohort.log `6df52dbf5bc7054d9404d9995f14a6f8b12905a4787ecde401d53935189608eb`, cohort/pairs.jsonl `244a5b1face421d6be5b9714b13df2e31addf5dde96ab48526bbeccf495be494`, cohort/report.json `36d74bb673b82fb2dd1e1b9d6e639aa79bacab912ece9533bf9c07fe0457d3d2`, learned-confirm-analysis.json `f1495fc0e3b102278c4d439bb8f45be9b6c3af8d503236f988f2c91b5242bb44`.

## Chain output, confirmation part

```text
== confirmation (05:18:20)
confirmation launches with 30.63 GB reclaimable (05:18:20)
[05:18:22] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-learned-confirm-20gb/protocol.json: memory 20.0 GB (reclaimable 30.6 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-learned-confirm-20gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-learned-confirm-20gb/protocol.json", "memory_gb": 20.0}
{"plan": ".build/expert-lookahead/xla3-learned-confirm-20gb/plan-learned-confirm.json", "prompts": {"code": ["r0026", "r0050"], "dialogue": ["r0304", "r0292"], "prose": ["r0186", "r0195"], "reasoning": ["r0156", "r0128"], "structured": ["r0268", "r0271"]}}
  "aggregate_ratio": 1.1,
  "duration_regression": 0.05,
  "family_floor": 0.95,
  "lower_bound": 1.0,
  "min_clean_pairs_per_prompt": 2
 }
}
  code: tps x1.027 duration x0.988 r0026=1.047(3) r0050=1.008(3)
  dialogue: tps x1.026 duration x1.012 r0304=1.023(3) r0292=1.028(3)
  prose: tps x1.025 duration x0.991 r0186=1.020(3) r0195=1.029(3)
  reasoning: tps x1.025 duration x0.977 r0156=1.017(3) r0128=1.034(3)
  structured: tps x1.055 duration x0.971 r0268=1.042(3) r0271=1.068(3)
== model processes after ==
none
30 pairs, 30 eligible for the cohort tool, 30 counted as written, 30 under the Sevra sensitivity, 985 sampler lines

outputs identical in every pair: True; tool arithmetic reproduced: True
tool's own B0 verdict (recorded, not this gate): success=False

as_written: 30 pairs
  code         tps x1.027 duration x0.988 r0026=1.047(3) r0050=1.008(3)
  dialogue     tps x1.026 duration x1.012 r0304=1.023(3) r0292=1.028(3)
  prose        tps x1.025 duration x0.991 r0186=1.020(3) r0195=1.029(3)
  reasoning    tps x1.025 duration x0.977 r0156=1.017(3) r0128=1.034(3)
  structured   tps x1.055 duration x0.971 r0268=1.042(3) r0271=1.068(3)
  aggregate x1.0314, bootstrap [1.0132, 1.0409], missing pairs [], checks {'aggregate': True, 'lower_bound': True, 'kind_floor': True, 'duration': True, 'pairs_per_prompt': True}, passes True

sevra_sensitivity: 30 pairs
  code         tps x1.027 duration x0.988 r0026=1.047(3) r0050=1.008(3)
  dialogue     tps x1.026 duration x1.012 r0304=1.023(3) r0292=1.028(3)
  prose        tps x1.025 duration x0.991 r0186=1.020(3) r0195=1.029(3)
  reasoning    tps x1.025 duration x0.977 r0156=1.017(3) r0128=1.034(3)
  structured   tps x1.055 duration x0.971 r0268=1.042(3) r0271=1.068(3)
  aggregate x1.0314, bootstrap [1.0132, 1.0409], missing pairs [], checks {'aggregate': True, 'lower_bound': True, 'kind_floor': True, 'duration': True, 'pairs_per_prompt': True}, passes True

median tok/s over counted pairs: {'attention': 14.639507602312278, 'attention-corrected': 15.140719724250363}
median paired counters (counted pairs): decode_records 0.907, decode_read_bytes 0.907, decode_seconds 0.972, request_seconds 0.977, hit_rate 0.999, prefetch.issued 0.922, prefetch.adopted 1.084, prefetch.expired 0.525, prefetch.wastedBytes 0.523, prefetch.demandMisses 0.903, prefetch.promoted 1.078, prefetch.forecastEvalSeconds 0.996, prefetch.forecastSelectSeconds 0.978, prefetch.arrivalIssues 0.982

confirmation verdict: {'identical_outputs': True, 'reproduces_tool': True, 'as_written': True, 'sevra_sensitivity': True, 'passes': True}
wrote .build/expert-lookahead/xla3-learned-confirm-20gb/learned-confirm-analysis.json
CONFIRMATION DONE (06:41:26)

[exited with code 0]
```
