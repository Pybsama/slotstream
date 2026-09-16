---
type: run
id: 01m2n6p9n0qhn261p1hjpmtxm1
created: 2026-09-16T13:32:24.096963+00:00
updated: 2026-09-16T13:38:52.113148+00:00
summary: 'Taps B1 at 20 GB: aggregate 1.058 (bootstrap 1.031 to 1.088), families 1.019 to 1.105, 36 of 36 outputs identical; r0033 kept one counted pair, so the pairs condition fails'
binary: 661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099 (taps build)
captured_at: 2026-09-15
command: run-b1-taps.sh (waits for 25.5 GB reclaimable; Tools/expert_lookahead.py prepare --memory-gb 20; Tools/decode_cohort.py --plan plan-b1-taps.json, three rounds at 512 outputs with 128 warmup tokens, contention sampler)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 3: B1 confirmation of the attention tap at 20 GB'
tool: Tools/decode_cohort.py over slotstream expert-lookahead-bench; analyze_taps_b1.py
---
Forecast taps, step 3 ([[records/plan/decode-forecast-taps-2026-09-14]]): does the attention tap, which passed the 18 GB mechanism screen, raise decode throughput against the qualified configuration on the held-out B1 prompts at 20 GB under the registered gate? Artifacts are under `.build/expert-lookahead/xla3-taps-b1-20gb/`, which git ignores. Nothing was installed, published or committed, and no default changed.

## Registration

`taps-preregistration.md` (the copy in the run directory, sha256 `02654d9f6015c5c3b584423b42a5e49b79476c5c6a32feb67984939ded8b4063`) fixes the B1 set, the profile and the gate. Its correction written at 23:33:56, 36 seconds after the screen launched and before its first cell finished, replaces the B0 gate with the tap's own: outputs identical in every pair; aggregate paired ratio (median of rounds per prompt, geometric mean of prompts per family, equal family weight) at least 1.02; lower bootstrap bound above 1.00; no family below 0.97; no family duration regression above 2%; at least two clean pairs per prompt. The B1 hygiene section (00:03:04, before the screen was analyzed) adds that a pair counts only when the cohort tool counts it under process-pageins-v1 and neither arm's window shows a compiler, linker or second slotstream engine, reports the Sevra app sensitivity as for the screen, states that a prompt left with fewer than two counted pairs fails the pairs condition, and keeps offline CPU work off the machine while B1 runs. The plan (`plan-b1-taps.json`, sha256 `ae7c61295d2204ba4262a441f5d2ed5982774a0cdfb3a63500569b9507983255`) holds the two arms, identical except the tap, and the B1 prompts (sha256 `cf519d2aee0a7470...`). `analyze_taps_b1.py` (sha256 `d7b9d7ccb43256f046d8d60ba74de1fc373a8ec6ce1a0bd8a89cc032e8b9f14c`) was written before B1 ran and reproduced a regenerated schema v2 cohort report exactly.

## Run

`run-b1-taps.sh` (sha256 `4cd0445d8827ff2c1919b11165b441901c9a84184cca583d6d9473827a5e1927`) waits for no other bench, capture or offline analysis process and at least 25.5 GB reclaimable. Earlier waits, at 21.8 to 24.9 GB, were stopped before they launched anything, and the co-routing, learned-correction and native diagnostic work ran in between. It launched at 02:35:37 with 26.22 GB reclaimable and froze protocol `xla3-taps-b1-20gb` (sha256 `fdfbf6a9a6677eaffd622c3ec140077f33518b36a570b60813d5d8b1674f695e`) from the screen protocol, changing only the run id, the 20 GB target, the creation time, the artifact root, the reclaimable reading, the preflight flag and the host conditions. The binary is the taps build (sha256 `661632d4545af0c8...`). The cohort ran 36 pairs, three rounds of twelve prompts at 512 outputs with a 128-token warmup, alternating arm order, and finished at 04:25:53 with no model process left.

The contention sampler wrote 1,309 lines. No arm window held a compiler, linker or second slotstream engine, and the Sevra app peaked at 5.9% CPU, so the sensitivity reading equals the rule as written. The cohort tool excluded six pairs for host swap-outs during an arm, four of them in round 0:

| pair | arm with swap-outs (pages) |
| --- | --- |
| r0033, round 0 | both (qualified 10,320; attention 24,144) |
| r0173, round 0 | attention (39,076) |
| r0256, round 0 | attention (22,368) |
| r0257, round 0 | attention (92) |
| r0125, round 2 | qualified (3,756) |
| r0033, round 2 | attention (5,548) |

## Results

Outputs were identical in all 36 pairs. Over the 30 counted pairs, and identically under the Sevra sensitivity:

| family | tok/s ratio | duration ratio | prompt medians (counted pairs) |
| --- | ---: | ---: | --- |
| code | 1.059 | 0.931 | r0062 1.049 (3), r0033 1.070 (1) |
| dialogue | 1.028 | 0.976 | r0296 1.028 (3), r0295 1.028 (3) |
| multilingual | 1.019 | 0.959 | r0244 1.066 (3), r0245 0.974 (3) |
| prose | 1.105 | 1.005 | r0171 1.040 (3), r0173 1.173 (2) |
| reasoning | 1.070 | 0.941 | r0124 1.088 (3), r0125 1.052 (2) |
| structured | 1.068 | 0.955 | r0256 1.065 (2), r0257 1.072 (2) |

| condition | required | result |
| --- | --- | --- |
| identical outputs | every pair | 36 of 36 |
| aggregate ratio | at least 1.02 | 1.0578 |
| bootstrap lower bound | above 1.00 | 1.0311 (upper 1.0880) |
| family floor | at least 0.97 | 1.019 (multilingual) |
| family duration | at most 1.02 | 1.005 (prose) |
| counted pairs per prompt | at least 2 | r0033 has 1 |

Recomputing the tool's own eligible set reproduced its aggregate and bootstrap exactly. The tool's B0 verdict, recorded and not this gate, is not successful, with insufficient evidence for the same prompt. Median decode throughput over counted pairs was 12.17 tok/s for the qualified configuration and 12.98 with the attention tap. Paired medians, attention over qualified: decode records 0.878, decode read bytes 0.878, decode seconds 0.943, request seconds 0.965, issued reads 0.880, adopted 1.123, promoted 1.085, expired 0.569, wasted bytes 0.568, demand misses 0.939, forecast evaluation seconds 0.545 and forecast selection seconds 1.817.

## Outcome

B1 does not pass as registered. Every effect condition passes, but host swap-outs left r0033 with one counted pair, and the registration makes that a failed pairs condition. The mechanism matches the screen: fewer records read in decode and fewer reads expiring unused. The default is unchanged, and this run supports no public number. Any further confirmation of the tap needs its own registration before it runs, and it would reuse the B1 prompts for a third time.

Artifacts (sha256): protocol.json `fdfbf6a9a6677eaffd622c3ec140077f33518b36a570b60813d5d8b1674f695e`, plan-b1-taps.json `ae7c61295d2204ba4262a441f5d2ed5982774a0cdfb3a63500569b9507983255`, taps-preregistration.md `02654d9f6015c5c3b584423b42a5e49b79476c5c6a32feb67984939ded8b4063`, cohort/pairs.jsonl `07ee2619ddbde4609b9c757f7f578182a52dd64d272d265e0ce105b4ddae59bd`, cohort/report.json `4e5bff7769bec5d06676a6d7814b00445dcc53fce10b2e7e203c9f2500015cde`, taps-b1-analysis.json `0af05c2852ceaf608892795a9e65c2d401b59bc4e54fef5edc0152e9d5780ecc`, contention-samples.txt `c0679895c377a92d3c5a7f7557487d53d114b38abfdb78fddbc8c4aa19550684`, cohort.log `a74b5c4a8ba9599359db4a7c332eb4f9846f0bd6d4a895993345766a53807f96`.

## Cohort tool verdict and families

```text
B1 launches with 26.22 GB reclaimable (02:35:37)
frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-taps-b1-20gb/protocol.json at 20 GB with 26.21 GB reclaimable
  "seed": 1729,
  "p2_5": 1.0310746998260665,
  "p97_5": 1.0879823936466273,
  "median": 1.058394194791753
 },
 "verdict": {
  "aggregate_ratio": 1.057805466974013,
  "lower_bound": 1.0310746998260665,
  "upper_bound": 1.0879823936466273,
  "family_floor_ok": true,
  "duration_ok": true,
  "evidence_sufficient": false,
  "success": false
 },
 "absolute": {
  "attention": {
   "pairs": 30,
   "median_tps": 12.981126992558028,
   "mean_tps": 12.91690157317393
  },
  "combined": {
   "pairs": 30,
   "median_tps": 12.170748131391782,
   "mean_tps": 12.248961414366114
  }
 },
 "gates": {
  "aggregate_ratio": 1.1,
  "duration_regression": 0.05,
  "family_floor": 0.95,
  "lower_bound": 1.0,
  "min_clean_pairs_per_prompt": 2
 }
}
  code: tps x1.059 duration x0.931 r0062=1.049(3) r0033=1.070(1)
  dialogue: tps x1.028 duration x0.976 r0296=1.028(3) r0295=1.028(3)
  multilingual: tps x1.019 duration x0.959 r0244=1.066(3) r0245=0.974(3)
  prose: tps x1.105 duration x1.005 r0171=1.040(3) r0173=1.173(2)
  reasoning: tps x1.070 duration x0.941 r0124=1.088(3) r0125=1.052(2)
  structured: tps x1.068 duration x0.955 r0256=1.065(2) r0257=1.072(2)
== model processes after ==
none
B1 DONE (04:25:53)

[exited with code 0]
```
