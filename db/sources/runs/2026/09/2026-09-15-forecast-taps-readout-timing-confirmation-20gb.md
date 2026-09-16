---
type: run
id: 01m2n6p9n6ft9zztgx9whdyhzg
created: 2026-09-16T13:32:24.102773+00:00
updated: 2026-09-16T13:38:51.338327+00:00
summary: 'Readout timing confirmation at 20 GB: corrected over qualified 1.111 (bootstrap 1.102 to 1.123), all 23 pairs above 1, 60 of 60 outputs identical, 13.10 to 14.83 tok/s'
binary: 49d4502aed892c2aa0126f85c8b3e6647e4ea7eb2759488c2fba171b1998e9ba (readout build 3)
captured_at: 2026-09-15
command: chain-readout-confirm.sh and run-readout-confirm.sh (Tools/expert_lookahead.py prepare --memory-gb 20; Tools/decode_sweep.py --rounds 3 --max-tokens 512 --warmup-tokens 128 over the qualified and corrected arms, observation cells r0178 and r0222, contention sampler)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 13: held-out confirmation of the corrected tap against the qualified configuration at 20 GB'
tool: Tools/decode_sweep.py over slotstream expert-lookahead-bench; analyze_readout_confirm.py
---
Readout tap timing, section 2 of `readout-timing-preregistration.md` ([[records/plan/decode-forecast-taps-2026-09-14]], step 13): with no readout arm qualifying at the screen, the confirmation ran its default-evidence contrast, the corrected attention tap against the qualified configuration that ships, on eight held-out prompts. Artifacts are under `.build/expert-lookahead/xla3-readout-confirm-20gb/`, which git ignores. Nothing was installed, published or committed, and no default changed.

## Registration

The registration (sha256 `5358e3ea65c2e6603bbbd8f9ac61fe612b4e281e227f2b18eafa17a55e3ad396`, 17:15:37 -05 with a profile amendment at 17:20, before any configuration existed) fixes the prompts, the arms and the reading. Prompts by the threshold registration's rule over the 26 training-split families no capture, fit, screen or cohort had used (code 14, reasoning 6, prose 4, dialogue 1, structured 1): for each kind, its sorted family names shuffled with `random.Random(20260915)`, the first two families or all when fewer, and from each the request with the smallest id: r0058 and r0067 (code), r0289 (dialogue), r0189 and r0211 (prose), r0092 and r0132 (reasoning), r0265 (structured), listed in the registration before any run. The candidate's gate (candidate over corrected) did not apply because the screen produced no candidate; the same conditions apply to corrected over qualified as a reading: outputs identical in every cell; aggregate paired ratio (median of rounds per prompt, geometric mean of prompts per kind, equal kind weight) at least 1.02; the bootstrap's 2.5th percentile (10,000 draws, seed 1729) above 1.00; no kind below 0.97; no kind duration ratio above 1.02; at least two counted pairs per prompt; under the contention rule as written and the Sevra sensitivity. Dialogue and structured hold one prompt each, a stated limit.

## Run

The first launch at 21:26:04 froze a protocol and stopped before any configuration when the launcher passed the screen's "no candidate" as the word none, which the arm maker refused; that directory was set aside unused as `xla3-readout-confirm-20gb-aborted-2126`. The corrected launcher froze protocol `xla3-readout-confirm-20gb` (sha256 `07dbf18ac21b3736866e4ef5c7b38b6d0f36b62ba47a27ada2ee837c8d3bf116`) at 21:26:53 with 26.4 GB reclaimable, the 20 GB profile (an expert cache of about 87 experts per layer, 4,193 slots), process-pageins-v1, on the readout build (binary sha256 `49d4502aed892c2a...`). Two arms (`configs-confirm.json`, sha256 `05bdaa155efe426233dee3f25a0a04f3c93180d7da1404d389bb7908091e5e13`): `qualified`, the B1 plan's combined arm (the shipped boundary forecast at stride 2), and `corrected`, the learned confirmation's corrected arm (tap attention-corrected, correction sha256 `37b00d3a32d1e188...`, reserve 164 MiB); nothing else differs. The sweep rotated arm order every cell: 48 cells at 512 outputs with 128 warmup tokens from 21:26:54 to 22:36:37, then the observation cells r0178 (5,231 prompt tokens) and r0222 (about 7,000), 12 cells, to 23:13:59. The contention sampler wrote 1,273 lines; no arm window held a compiler, linker or second slotstream engine, and no Sevra app sample appeared, so the sensitivity reading equals the rule as written. No model process remained.

## Results

Outputs were identical in all 60 cells. One confirmation cell was unclean for host swap-outs (r0289 round 2, corrected), leaving 47 counted cells and 23 pairs; every prompt kept at least two. Paired ratios, corrected over qualified (`readout-confirm-analysis.json`, sha256 `0106c52a171f0cf7493ddb28c248d9b6b60e0dde418d3b8e7d3c12a64721305b`):

| kind | tok/s ratio | duration ratio | prompt medians (counted pairs) |
| --- | ---: | ---: | --- |
| code | 1.112 | 0.928 | r0058 1.115 (3), r0067 1.110 (3) |
| dialogue | 1.079 | 0.937 | r0289 1.079 (2) |
| prose | 1.096 | 0.956 | r0189 1.089 (3), r0211 1.104 (3) |
| reasoning | 1.134 | 0.889 | r0092 1.137 (3), r0132 1.130 (3) |
| structured | 1.136 | 0.903 | r0265 1.136 (3) |

| condition | required | result |
| --- | --- | --- |
| identical outputs | every cell | 60 of 60 |
| aggregate ratio, equal kind weight | at least 1.02 | 1.1114 |
| bootstrap 2.5th percentile | above 1.00 | 1.1017 (median 1.1127, 97.5th 1.1232) |
| kind floor | at least 0.97 | 1.079 (dialogue) |
| kind duration ratio | at most 1.02 | 0.956 (prose) |
| counted pairs per prompt | at least 2 | 2 for r0289, 3 for the rest |

All 23 pairs were above 1, from 1.048 to 1.169, identically under the Sevra sensitivity. Median decode throughput over counted cells was 13.10 tok/s for the qualified configuration and 14.83 with the corrected tap. Paired medians, corrected over qualified: records read in decode 0.794, decode read bytes 0.794, decode seconds 0.897, request seconds 0.918, prefill seconds 0.998, expert hit rate 0.999, reads issued 0.796, adopted 1.283, promoted 1.206, expired unused 0.275, wasted bytes 0.274, demand misses 0.838, forecast evaluation seconds 0.523, forecast build seconds 1.384, forecast selection seconds 1.809, join seconds 0.898.

Observation cells, outside the reading: on r0178 the corrected tap ran 1.067, 0.994 and 1.088 against qualified over the three rounds (12.65, 11.64 and 12.65 against 11.85, 11.70 and 11.63 tok/s), and on r0222 1.073 and 1.068 in rounds 0 and 1 (10.19 and 10.21 against 9.50 and 9.56 tok/s). The round-2 corrected cell on r0222 did not complete: the engine's memory-pressure guard stopped its prefill commit ("memory pressure interrupted prefill commit; retry after memory becomes available") while the host swapped pages in (12 swap-ins in that arm, 16 in the qualified arm of the same round, which completed). That is the guard doing its job under a host event, not a property of the tap; the cell is recorded and excluded.

## Outcome

The corrected attention tap decodes 11.1% faster than the configuration that ships (bootstrap 10.2% to 12.3%) on eight held-out prompts from families no earlier run had used, with identical outputs, every kind at 1.079 or above and every kind's request duration shorter. It does so by reading 21% fewer records in decode and wasting 73% fewer speculative bytes, with forecast evaluation time halved. This is the direct measurement the default decision needs and the one number the work supports publicly, pending its claim record; it is consistent with, and replaces, the product of the two earlier links (1.058 for the tap on B1 and 1.031 for the correction over the tap). As registered, the recommendation is the corrected attention tap as the default; the default change, docs, the file's home and any public number remain Carlos's decision. Limits: one machine, one checkpoint, the 20 GB profile, no multilingual prompt, one dialogue and one structured family, the observation prompts at most about 7,000 tokens, and a correction trained on the pilot's training requests.

Artifacts (sha256): protocol.json `07dbf18ac21b3736866e4ef5c7b38b6d0f36b62ba47a27ada2ee837c8d3bf116`, configs-confirm.json `05bdaa155efe426233dee3f25a0a04f3c93180d7da1404d389bb7908091e5e13`, readout-timing-preregistration.md `5358e3ea65c2e6603bbbd8f9ac61fe612b4e281e227f2b18eafa17a55e3ad396`, screen-verdict.json `59084ce16dd78aaea773b76d0b2535b093a1f53029a2274a3ad6eb79965a8078`, contention-samples.txt `a476813148d482ba1d322fb1045308083aeba169780d2e75697c8d33a244f667`, sweep-rounds3.log `b71aef540ed40bf5079be24b8c6163fff4041422ca0034f6fce982a96474b970`, observe-rounds3.log `6a9440be35d0d9a8f31fbf131ea06b65c6e83c53b8c99d6771cce6c755cc0068`, sweep/cells.jsonl `c6ad4a790f099dc4c9837f3116a9c31e22a5a494332ffac458866ef59df94d6c`, sweep/report.json `9ab4daa20a9899a819205c05b1f1d119ad699c9225e1575036cb318c75eefe85`, observe/cells.jsonl `5721c078213ac2686da693ebf6abc2912c4ef4d5a1a83744e8ae22eee501a7a9`, observe/report.json `ccf166a9ed758bbbff565d6be5d267fc0507c62a8a16a8659e569e4889361095`, readout-confirm-analysis.json `0106c52a171f0cf7493ddb28c248d9b6b60e0dde418d3b8e7d3c12a64721305b`.

## Chain output, confirmation part

```text
CHAIN STOPPED: the confirmation launcher failed (21:26:04)
== confirmation, 3 rounds, relaunched (21:26:51)
[21:26:53] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-confirm-20gb/protocol.json: memory 20.0 GB (reclaimable 26.4 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-readout-confirm-20gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-confirm-20gb/protocol.json", "memory_gb": 20.0}
{"configs": ".build/expert-lookahead/xla3-readout-confirm-20gb/configs-confirm.json", "arms": ["qualified", "corrected"]}
confirmation .build/expert-lookahead/xla3-readout-confirm-20gb to 3 rounds, 2 arms (candidate none), with 26.39 GB reclaimable (21:26:54)
sweep sweep exit 0 (22:36:37)
sweep observe exit 0 (23:13:59)
48 cells over 3 rounds, 47 counted as written, 47 under the Sevra sensitivity, 1271 sampler lines; 12 observation cells

outputs identical in every cell: True

corrected/qualified [counted]: 23 pairs
  code         tps x1.112 duration x0.928 r0058=1.115(3) r0067=1.110(3)
  dialogue     tps x1.079 duration x0.937 r0289=1.079(2)
  prose        tps x1.096 duration x0.956 r0189=1.089(3) r0211=1.104(3)
  reasoning    tps x1.134 duration x0.889 r0092=1.137(3) r0132=1.130(3)
  structured   tps x1.136 duration x0.903 r0265=1.136(3)
  aggregate x1.1114, bootstrap [1.1017, 1.1232], missing pairs [], checks {'aggregate': True, 'lower_bound': True, 'kind_floor': True, 'duration': True, 'pairs_per_prompt': True}, passes True

corrected/qualified [counted_sensitivity]: 23 pairs
  code         tps x1.112 duration x0.928 r0058=1.115(3) r0067=1.110(3)
  dialogue     tps x1.079 duration x0.937 r0289=1.079(2)
  prose        tps x1.096 duration x0.956 r0189=1.089(3) r0211=1.104(3)
  reasoning    tps x1.134 duration x0.889 r0092=1.137(3) r0132=1.130(3)
  structured   tps x1.136 duration x0.903 r0265=1.136(3)
  aggregate x1.1114, bootstrap [1.1017, 1.1232], missing pairs [], checks {'aggregate': True, 'lower_bound': True, 'kind_floor': True, 'duration': True, 'pairs_per_prompt': True}, passes True

observation (candidate over corrected): {}; guard None
median tok/s over counted cells: {'corrected': 14.83, 'qualified': 13.1}
paired medians corrected/qualified: decode_records 0.794, decode_read_bytes 0.794, decode_seconds 0.897, request_seconds 0.918, hit_rate 0.999, prefill_seconds 0.998, prefetch.issued 0.796, prefetch.adopted 1.283, prefetch.expired 0.275, prefetch.wastedBytes 0.274, prefetch.demandMisses 0.838, prefetch.promoted 1.206, prefetch.forecastBuildSeconds 1.384, prefetch.forecastEvalSeconds 0.523, prefetch.forecastSelectSeconds 1.809, prefetch.joinSeconds 0.898

state enough; gate passes False; corrected over qualified passes True; recommendation corrected
wrote .build/expert-lookahead/xla3-readout-confirm-20gb/readout-confirm-analysis.json
confirmation after 3 rounds: enough (23:14:06)
gate passes False guard None corrected over qualified passes True recommendation corrected
READOUT CHAIN DONE (23:14:06)
```
