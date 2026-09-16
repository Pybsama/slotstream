---
type: run
id: 01m2n6p9n6d5nfzgz29dfbjf2e
created: 2026-09-16T13:32:24.102351+00:00
updated: 2026-09-16T13:38:51.189994+00:00
summary: 'Readout timing screen at 20 GB: no readout arm has a pair above 1 against the corrected tap (readback 0.952, after-demand 0.737); 113 cells with identical outputs'
binary: 49d4502aed892c2aa0126f85c8b3e6647e4ea7eb2759488c2fba171b1998e9ba (readout build 3)
captured_at: 2026-09-15
command: chain-readout.sh and run-readout-screen.sh (smoke at 10 GB; Tools/expert_lookahead.py prepare --memory-gb 20; Tools/decode_sweep.py --rounds 3 then 4 --max-tokens 256 --warmup-tokens 128 over five arms, observation cells r0178 and r0222, contention sampler)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 13: readout timing screen at 20 GB'
tool: Tools/decode_sweep.py over slotstream expert-lookahead-bench; analyze_readout_screen.py
---
Readout tap timing, section 1 of `readout-timing-preregistration.md` ([[records/plan/decode-forecast-taps-2026-09-14]], step 13): does computing the target layer's attention early, in either placement, with or without its correction, raise decode throughput over the confirmed corrected attention tap? Artifacts are under `.build/expert-lookahead/xla3-readout-screen-20gb/`, which git ignores. Nothing was installed, published or committed, and no default changed.

## Registration and run

The registration (sha256 `5358e3ea65c2e6603bbbd8f9ac61fe612b4e281e227f2b18eafa17a55e3ad396` with its profile amendment) was written at 17:15:37 -05, after the readout correction's offline gate failed and before any configuration existed; the amendment at 17:20 allowed 18 or 16 GB fallbacks that were not needed. It states the prior the placement smoke gave (7.71 against 6.18 tok/s on one cell) and the twin's projections (1.290 and 1.307 against 1.249) so neither can be read as post hoc. A smoke of the two after-demand arms (one 32-output request at 10 GB) passed at 17:21: both exited 0 with identical outputs and the corrected arm's identity named `correction=8d815db674138677`. `prepare` froze protocol `xla3-readout-screen-20gb` (sha256 `3305a339ae306d5bb0816cee48953782b94155a6c078db94b9ea83bd74c37507`) at 17:23:33 with 29.9 GB reclaimable, the 20 GB profile, process-pageins-v1, on the readout build (binary sha256 `49d4502aed892c2a...`, mlx.metallib `198488eb61359e95...`). Five arms (`configs-readout.json`, sha256 `942b7f3eed2aabdfdee350af30fd2b3022730d9067b3617c573857495d894253`), identical to the learned confirmation's corrected arm except the tap, the placement, the correction file and the reserve: `corrected` (the reference, correction `37b00d3a32d1e188...`, reserve 164 MiB), `readout-readback` and `readout-after` (tap attention-readout, reserve 128 MiB), `readout-corrected-readback` and `readout-corrected-after` (tap attention-readout-corrected, correction `8d815db674138677...`, reserve 164 MiB). The sweep rotated arm order every cell. r0005, r0206, r0096 and r0074 at 256 outputs: rounds 0 to 2 ran 17:23:33 to 18:48:42 and round 3, added by the rule when two arms had 11 counted pairs, 20:25:19 to 20:53:10. The observation cells r0178 (5,231 prompt tokens) and r0222 (about 7,000) ran in `observe/` after each screen sweep, to 21:25:55. The contention sampler wrote 2,879 lines; no arm window held a compiler, linker or second slotstream engine, and no Sevra app sample appeared, so the sensitivity reading equals the rule as written. No model process remained.

## Results

Outputs were identical in all 80 screen cells and all 33 observation cells. Three screen cells were unclean for host swap-outs, all on r0096 (round 0 readout-corrected-readback, round 2 readout-readback, round 3 readout-corrected-after); 77 counted. Paired ratios over `corrected` on the same prompt and round (`sweep/readout-screen-analysis.json`, sha256 `7a263872f328d99b4c92ddd846f14be48ad53e2937f64a8e74d7342f5febfbe8`):

| arm | counted pairs | first 12 | above 1 | all pairs | by round | median tok/s |
| --- | ---: | ---: | ---: | ---: | --- | ---: |
| corrected (reference) | | | | | | 14.56 |
| readout-readback | 15 | 0.949 | 0 | 0.952 | 0.957, 0.949, 0.942, 0.959 | 13.67 |
| readout-corrected-readback | 15 | 0.952 | 0 | 0.952 | 0.965, 0.956, 0.952, 0.940 | 13.48 |
| readout-after | 16 | 0.738 | 0 | 0.737 | | 10.71 |
| readout-corrected-after | 15 | 0.745 | 0 | 0.742 | | 10.36 |

Observation cells, paired ratio to `corrected` (median over rounds; `observe/readout-screen-analysis.json`, sha256 `cff429707a0224a3289a69c072ad8d2261101c33ce429adc2a4ab46029190ddb`): readout-readback 0.888 on r0178 and 0.849 on r0222; readout-corrected-readback 0.886 and 0.846; readout-after 0.712 and 0.699; readout-corrected-after 0.702 and 0.706. The reference decoded them at 11.19 tok/s.

Median counters per counted cell, reference first: records read in decode 13,220, then 12,180 (readback), 11,440 (corrected readback), 12,870 (after), 11,470 (corrected after); reads expiring unused 2,948, 1,391, 855, 1,771, 857; wasted bytes 8.16 GB, 3.85, 2.36, 4.90, 2.37; demand misses 13,140, 12,080, 11,350, 11,030, 9,660; forecast build 0.079 s, 0.264, 0.294, 0.265, 0.286; forecast evaluation 4.09 s, 4.65, 4.79, 0 (asynchronous), 0; forecast selection 0.142 s, 0.139, 0.142, 7.63, 7.55; scheduling 0.084 s, 0.079, 0.081, 7.58, 7.49; joins on in-flight reads 0.071 s, 0.046, 0.035, 0.234, 0.215.

## Why

The readout does what the offline audit said: 8% fewer records read in decode, half the speculative reads expiring unused, half the wasted bytes, and with its correction 13% fewer records. It loses anyway because its GPU work is not free. In the readback placement the forecast evaluation grows by 0.56 to 0.70 s per 256-output cell and the build by 0.19 to 0.22 s, about 0.8 s on a 17.6 s decode, and the routing readback it rides returns later, so the source layer's own demand reads start later. Demand reads take about 30% of decode time at this profile, so an 8% cut in records is worth about 2.4% of decode, less than the readout costs. At long context the readout attends densely on the twelve full-attention layers, past the 2,048-token indexer budget where the forward attends sparsely, and the loss grows to 11% to 15%.

The after-demand placement is worse for a structural reason. It submits the readout with `asyncEval` at the readback and consumes it after the source layer's MoE; consumption materializes the logits, which waits for every queued GPU operation, so each layer ends with a full GPU synchronization that the deferred four-layer barrier exists to avoid. That wait lands in the selection and scheduling timers (7.6 s each per cell against 0.14 s and 0.08 s), the forecast reaches the scheduler one MoE later than the readback placement's, and joins on in-flight reads triple. A placement that hid the readout's GPU work would have to consume it without synchronizing, at the next barrier, which is too late to be useful.

## Reading

No arm has a pair above 1, so none passes the reading (paired ratio at least 1.01 with at least 8 of the first 12 counted pairs above 1) and none qualifies for the confirmation. As registered, the readout lever closes at the screen and the confirmation runs with the qualified and corrected arms only, for the default evidence. The engine keeps the readout tap and its placements as observer and opt-in tools; nothing recommends them. The chain's hand-off to the confirmation failed once on a defect of the launcher (the screen's "no candidate" was passed as the word none, which the arm maker refused); the confirmation's protocol frozen at 21:26:04 was set aside unused as `xla3-readout-confirm-20gb-aborted-2126`, the maker was corrected and the confirmation relaunched at 21:26:51.

Artifacts (sha256): protocol.json `3305a339ae306d5bb0816cee48953782b94155a6c078db94b9ea83bd74c37507`, configs-readout.json `942b7f3eed2aabdfdee350af30fd2b3022730d9067b3617c573857495d894253`, readout-timing-preregistration.md `5358e3ea65c2e6603bbbd8f9ac61fe612b4e281e227f2b18eafa17a55e3ad396`, contention-samples.txt `5270919603b709fc1616c4c65eb48034b4ca7cd114847fca8decf6ce24c3552b`, sweep-rounds3.log `2911df402f6a984d3273135b2879991f6d96531c664b5142440dbb29a39a5923`, sweep-rounds4.log `ead1518c561ff541101cdf6c5e89ffe8a2e59facd5900c2e68b956473b5a5434`, observe-rounds3.log `e7a0ec52748b85ada544a39db9de489f2732c2bb8cc9fa27186683b156776e90`, observe-rounds4.log `b716e34e91403dc3a0587e1b61162ab44ff780a855023db1f7944001abf6b271`, sweep/cells.jsonl `8a2cf7fb6e6d3128cbcf64399938eb52b76c802cd1d79032a25b6bc758c853a6`, sweep/report.json `f7db4c38c6b185ae8e032c4e182e57bc7297ee779f8b4b6f6bd79c037fbb5873`, sweep/readout-screen-analysis.json `7a263872f328d99b4c92ddd846f14be48ad53e2937f64a8e74d7342f5febfbe8`, observe/cells.jsonl `aa70808db67f91d4995c651f5ea3697061d29a8da22692fae40ed766cab38fff`, observe/readout-screen-analysis.json `cff429707a0224a3289a69c072ad8d2261101c33ce429adc2a4ab46029190ddb`, readout-screen-verdict.json `59084ce16dd78aaea773b76d0b2535b093a1f53029a2274a3ad6eb79965a8078`.

## Chain output, screen part

```text
== screen, 3 rounds (17:21:32)
{"configs": ".build/expert-lookahead/xla3-readout-20260915/smoke-timing/configs-smoke.json", "arms": ["readout-after", "readout-corrected-after"]}
smoke with 21.14 GB reclaimable (17:21:33)
smoke: both arms ran True, outputs identical True, corrected identity 'router-reuse:tap=attention-readout-corrected:correction=8d815db674138677'
[17:23:33] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-screen-20gb/protocol.json: memory 20.0 GB (reclaimable 29.9 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-readout-screen-20gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-screen-20gb/protocol.json", "memory_gb": 20.0}
{"configs": ".build/expert-lookahead/xla3-readout-screen-20gb/configs-readout.json", "arms": ["corrected", "readout-readback", "readout-after", "readout-corrected-readback", "readout-corrected-after"]}
screen .build/expert-lookahead/xla3-readout-screen-20gb to 3 rounds with 29.96 GB reclaimable (17:23:33)
sweep sweep exit 0 (18:48:42)
sweep observe exit 0 (20:25:12)
screen after 3 rounds: state more, fewest counted pairs 11, mismatched []
  readout-readback             pairs 11 first-12 0.950 above 0 all 0.950 (0 above) med tps 13.666 passes False qualifies False
  readout-after                pairs 12 first-12 0.738 above 0 all 0.738 (0 above) med tps 10.670 passes False qualifies False
  readout-corrected-readback   pairs 11 first-12 0.957 above 0 all 0.957 (0 above) med tps 13.435 passes False qualifies False
  readout-corrected-after      pairs 12 first-12 0.745 above 0 all 0.745 (0 above) med tps 10.741 passes False qualifies False
  observe readout-readback     r0178 0.884(3) r0222 0.854(2)
  observe readout-after        r0178 0.707(2) r0222 0.699(2)
  observe readout-corrected-readback r0178 0.870(2) r0222 0.846(3)
  observe readout-corrected-after r0178 0.696(3) r0222 0.706(3)
candidate: None
screen after 3 rounds: more (20:25:19)
== screen, round 4 (20:25:19)
screen .build/expert-lookahead/xla3-readout-screen-20gb to 4 rounds with 31.28 GB reclaimable (20:25:19)
sweep sweep exit 0 (20:53:10)
sweep observe exit 0 (21:25:55)
screen after 4 rounds: state enough, fewest counted pairs 15, mismatched []
  readout-readback             pairs 15 first-12 0.949 above 0 all 0.952 (0 above) med tps 13.675 passes False qualifies False
  readout-after                pairs 16 first-12 0.738 above 0 all 0.737 (0 above) med tps 10.709 passes False qualifies False
  readout-corrected-readback   pairs 15 first-12 0.952 above 0 all 0.952 (0 above) med tps 13.476 passes False qualifies False
  readout-corrected-after      pairs 15 first-12 0.745 above 0 all 0.742 (0 above) med tps 10.363 passes False qualifies False
  observe readout-readback     r0178 0.888(4) r0222 0.849(3)
  observe readout-after        r0178 0.712(3) r0222 0.699(2)
  observe readout-corrected-readback r0178 0.886(3) r0222 0.846(3)
  observe readout-corrected-after r0178 0.702(4) r0222 0.706(3)
candidate: None
screen after 4 rounds: enough (21:26:01)
== confirmation, 3 rounds (21:26:01)
[21:26:04] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-confirm-20gb/protocol.json: memory 20.0 GB (reclaimable 27.7 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-readout-confirm-20gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-readout-confirm-20gb/protocol.json", "memory_gb": 20.0}
bad candidate none
```
