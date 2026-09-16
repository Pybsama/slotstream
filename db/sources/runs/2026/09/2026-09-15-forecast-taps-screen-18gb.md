---
type: run
id: 01m2n6p9n0qchdqsw8k1f4chgm
created: 2026-09-16T13:32:24.096037+00:00
updated: 2026-09-16T13:38:51.029420+00:00
summary: 'Taps screen at 18 GB: 48 cells with identical outputs; attention tap 1.054 over the qualified configuration on the first twelve pairs (11 above 1), attention-shared 1.078'
binary: 661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099 (taps build)
captured_at: 2026-09-15
command: run-taps-screen.sh and run-taps-screen-rounds.sh (Tools/expert_lookahead.py prepare --memory-gb 18; Tools/decode_sweep.py --rounds 3 then 4 --max-tokens 256 --warmup-tokens 128, contention sampler)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 2: native screen of both attention taps at 18 GB'
tool: Tools/decode_sweep.py over slotstream expert-lookahead-bench; analyze_taps_screen.py
---
Forecast taps, step 2 ([[records/plan/decode-forecast-taps-2026-09-14]]): the native screen of both attention taps against the qualified configuration, run as a mechanism screen at an 18 GB target because the 20 GB profile's 25 GB preflight was not reclaimable. Artifacts are under `.build/expert-lookahead/xla3-taps-screen-18gb/`, which git ignores. Nothing was installed, published or committed.

## Setup

Protocol `xla3-taps-screen-18gb`: the taps binary (sha256 `661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099`) from [[sources/runs/2026/09/2026-09-15-forecast-taps-offline-stage]], an 18 GB target, eligibility rule process-pageins-v1. Three configurations on the same forced profile: `combined`, the qualified decode lookahead set explicitly (router policy, stride 2, top 24, threshold 0.062, issue cap 32, 16 lanes, slot adoption with 64 records held, FP32 routers, barrier period 4, draft depth 2), and the same with `SLOTSTREAM_EXPERT_PREFETCH_TAP=attention` or `attention-shared`. The reference is `combined` rather than the default because a draft head forced on below its automatic floor runs without the lookahead. Exploration prompts r0005, r0206, r0096 and r0074, 128 warmup and 256 measured outputs, configurations interleaved within each round. At 23:30 only 23.65 GB was reclaimable, and the watcher launched at 18 GB at 23:33:20 with 24.82 GB.

## The stopped attempt

The first attempt (`sweep/`) ran three r0005 cells and stopped when the sweep could not rebuild prompt r0206: `docs/LIBRARY.md` had been edited since the corpus froze, so the prompt no longer matched its frozen hash. `Tools/expert_lookahead_corpus.py` now reads every code and prose source from the git blob recorded at freeze, and `verify` reports all 307 prompts. Its three cells are kept and never pooled: `combined` 10.93 tok/s clean, `combined-attention` 6.84 excluded for host swap-outs, `combined-attention-shared` 10.15 clean.

## Contention rule and resumed screen

Another session compiled and ran its app on the same Mac, which the swap-out rule cannot see. Before resuming, a contention rule was registered (23:41:24): a sampler records every 5 s each compiler, linker and slotstream process, a cell whose arm window holds a compiler, linker or second engine sample is excluded like an unclean cell, and rounds are added until each tap arm has 12 counted pairs with the reference or six rounds have run. A scope note (23:46:09) added a sensitivity reading that also excludes cells with the other session's Sevra app above 25% CPU. The screen resumed in `sweep2/` at 23:42:40 with 23.84 GB reclaimable.

Rounds 0 to 2 ran until 00:36:08. Four of 36 cells were excluded: `r0005` round 0 `combined-attention` overlapped a `swift-build` of `apps/macos` in another checkout, `r0005` round 0 `combined-attention-shared` had host swap-outs and a linker sample, and both `r0074` round 2 `combined-attention-shared` and `combined` had host swap-outs. Each tap arm had 10 counted pairs, so the rule added round 3, which ran from 00:38:12 (26.39 GB reclaimable) to 00:55:35 with all 12 cells counted. The Sevra sensitivity excluded no cell.

## Result

Every one of the 48 cells produced the same output tokens as its request's reference.

| configuration | counted cells | median tok/s | pairs | paired ratio | pairs above 1 | range | first 12 pairs |
| --- | ---: | ---: | ---: | ---: | ---: | --- | --- |
| `combined` | 15 | 11.26 | | | | | |
| `combined-attention` | 15 | 11.97 | 14 | 1.047 | 12 | 0.877 to 1.125 | 1.054, 11 above 1 |
| `combined-attention-shared` | 14 | 12.15 | 14 | 1.077 | 13 | 0.990 to 1.127 | 1.078, 11 above 1 |

Paired ratios are geometric means of arm over reference on the same request and round. The registered screen reading, for the tap chosen offline (attention), needed exact outputs and a paired ratio of at least 1.01 with at least 8 of 12 pairs above 1: the first 12 counted pairs in round order give 1.054 with 11 above 1, under the rule as written and under the Sevra sensitivity, so the B1 confirmation runs. Exploration differences inside about 2.5% are noise ([[records/measurements/decode-path-serialization-round-2-2026-09-12]]); this screen can justify B1 and cannot replace it. attention-shared measured higher here, but the offline gate chose attention before any native run, so B1 tests attention.

## Mechanism

Medians over the 14 counted pairs of each arm, arm over reference:

| counter | attention | attention-shared |
| --- | ---: | ---: |
| `decodeRecords` | 0.869 | 0.856 |
| `decodeIOSeconds` | 0.921 | 0.909 |
| `verifySeconds` | 0.934 | 0.920 |
| `decodeSeconds` | 0.937 | 0.922 |
| `prefetch.issued` | 0.898 | 0.899 |
| `prefetch.adopted` | 1.140 | 1.152 |
| `prefetch.expired` | 0.563 | 0.541 |
| `prefetch.wastedBytes` | 0.562 | 0.537 |
| `prefetch.demandMisses` | 0.934 | 0.923 |
| `prefetch.promoted` | 1.046 | 0.999 |
| `prefetch.forecastEvalSeconds` | 0.545 | 0.551 |
| `prefetch.forecastSelectSeconds` | 1.832 | 1.816 |

Verify passes, accepted drafts, decoded tokens and prefill tokens are identical in every pair. The taps issue about 10% fewer speculative reads, adopt 14 to 15% more of them into slots, roughly halve the reads that expire unused, and cut records read in decode by 13 to 14%, which matches the offline twin's direction (more timely coverage from fewer issued reads). Host forecast selection time rises by about 0.09 s per request, partly because arrival issues are counted inside it.

## Limits

A mechanism screen at a forced 18 GB profile on four exploration prompts that earlier decisions have seen, one machine, 256 outputs, the other session's app open and compiling at times. It decides only whether B1 runs; the default, docs and claims wait for B1 and a separate decision.

## Artifacts (sha256)

- protocol.json `d41062e137385b06d18c46811a9fe03da23391ba9eb9c2bcc036710a33a6951b`, configs-taps.json `8489b73256045b634638ddc5bbe12eb981ea710ce4595629c3a5fc654f12875a`
- sweep2/cells.jsonl `abd59849f61b94253a12be3b347501a18b36fc52efb042c2d6fa827dd69d58e1` (48 cells; per-arm logs and results in sweep2/arms/)
- sweep2/taps-analysis.json `4234b48b76a53fc07f05f62b84e15cc32eef84ec961998c4a8ddbf3ef9f47d73`, from analyze_taps_screen.py `dd98b5bb38a2ab6d31d8a54ba0bde7282e83a631cebb738d3c3b1343c33f9a92`
- sweep2/taps-paired-counters.json `8844c767f1910f559905498bee4de72db0f5653b28569e6cd043eec9b0a95a2f`
- contention-samples.txt `23c3f13ca32d046ea98c6fc3fdf878d78671f2b1c1884e9563ba9c3a8bec1919`
- sweep2.log `b9c280f0ea10fc4074f7d0d1c24228dbc97e10cf8759f422eb7a86df4164cd74`, sweep2-rounds4.log `fbdcc9fc218f679b68da5384819cac4d763c3080494a354ede09b172796bd15e`
- registration: taps-preregistration.md in `.build/expert-lookahead/xla3-taps-20260915/`, with the copies the screen directory received at each addition

## Stopped attempt (frozen-hash defect)

```text
watcher started 23:33
launch at 18 GB with 24.82 GB reclaimable (23:33)
screen exit 1 (23:38)
== prepare xla3-taps-screen-18gb (23:33) ==
[23:33:20] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-taps-screen-18gb/protocol.json: memory 18.0 GB (reclaimable 24.8 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-taps-screen-18gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-taps-screen-18gb/protocol.json", "memory_gb": 18.0}
== taps screen at 18 GB (23:33) ==
[23:36:36] r0005 r0 combined-attention: tps=6.84 clean=False host swap-outs during the arm
[23:38:11] r0005 r0 combined-attention-shared: tps=10.15 clean=True 
Traceback (most recent call last):
  File "/Users/carlos/Projects/slotstream/Tools/decode_sweep.py", line 211, in <module>
    main()
  File "/Users/carlos/Projects/slotstream/Tools/decode_sweep.py", line 104, in main
    payload = xla.request_payload(manifest, [rid])[0]
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Users/carlos/Projects/slotstream/Tools/expert_lookahead.py", line 141, in request_payload
    messages = [{"role": m["role"], "content": m["content"]} for m in corpus.materialize(r)]
                                                                      ^^^^^^^^^^^^^^^^^^^^^
  File "/Users/carlos/Projects/slotstream/Tools/expert_lookahead_corpus.py", line 558, in materialize
    raise ValueError(f"prompt {request['id']} does not match its frozen hash")
ValueError: prompt r0206 does not match its frozen hash
SCREEN FAILED: no report

[exited with code 1]
```

## Resumed screen, rounds 0 to 2

```text
screen resumes at 18 GB with 23.84 GB reclaimable (23:42:40)
sweep exit 0 (00:36:08)
[00:24:31] r0206 r2 combined: tps=11.26 clean=True 
[00:26:08] r0206 r2 combined-attention: tps=11.97 clean=True 
[00:27:46] r0206 r2 combined-attention-shared: tps=11.8 clean=True 
[00:29:01] r0096 r2 combined-attention: tps=13.11 clean=True 
[00:30:15] r0096 r2 combined-attention-shared: tps=13.19 clean=True 
[00:31:38] r0096 r2 combined: tps=11.91 clean=True 
[00:33:07] r0074 r2 combined-attention-shared: tps=12.98 clean=False host swap-outs during the arm
[00:34:38] r0074 r2 combined: tps=11.91 clean=False host swap-outs during the arm
[00:36:08] r0074 r2 combined-attention: tps=12.53 clean=True 

reference: combined

config                         tps   ratio  clean  accept tok/pass   records  exact
combined-attention-shared    12.02   1.080  10/12   0.765     2.53     17056    yes
combined-attention           11.74   1.047  12/12   0.764     2.53     17264    yes
combined                     11.22   1.000  11/12   0.747     2.50     18889    yes

[exited with code 0]
```
