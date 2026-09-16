---
type: run
id: 01m2n6p9n3z7f371eyzbjrh90p
created: 2026-09-16T13:32:24.099669+00:00
updated: 2026-09-16T13:32:24.099669+00:00
summary: 'Learned screen at 20 GB: 32 cells with identical outputs; corrected over attention 1.036 on the first twelve counted pairs (9 above 1); the confirmation runs'
binary: '3e6652f30aec593dd5240213f173429cf369abf8c3917741235b01ff1dfe755e (correction build)'
captured_at: 2026-09-15
command: 'chain-learned.sh and run-learned-screen.sh (smoke at 10 GB; Tools/expert_lookahead.py prepare --memory-gb 20; Tools/decode_sweep.py --rounds 3 then 4 --max-tokens 256 --warmup-tokens 128, contention sampler)'
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 8: screen of the corrected tap against the attention tap at 20 GB'
tool: 'Tools/decode_sweep.py over slotstream expert-lookahead-bench; analyze_learned_screen.py'
---
Forecast taps, step 8 ([[records/plan/decode-forecast-taps-2026-09-14]]): does the native learned correction raise decode throughput over the plain attention tap on the exploration prompts enough to run its held-out confirmation? Artifacts are under `.build/expert-lookahead/xla3-learned-screen-20gb/` and, for the smoke, `.build/expert-lookahead/xla3-learned-native-20260915/smoke-sweep/`, which git ignores. Nothing was installed, published or committed.

## Registration

Step 2 of `learned-native-preregistration.md` (sha256 `237b2916fd6cc19e5301ae0273a29b926d14be7bbe8ea6c4aa6d0b0c2b8ea037`, 02:08:16 -05) fixes the design: r0005, r0206, r0096 and r0074 at 256 outputs, the attention tap against the corrected tap in interleaved rounds, at 20 GB when 25 GB is reclaimable at launch and otherwise at 18 GB, with the taps screen's contention rule and Sevra app sensitivity, adding rounds until 12 counted pairs or six rounds. Reading: identical outputs in every cell, and a paired ratio of at least 1.01 with at least 8 of the first 12 counted pairs above 1. It decides only whether the confirmation runs. Step 1, the correctness diagnostic, passed before any of this ran.

## Preparation

Written after the registration and before any timing run: `make_learned_screen.py` (sha256 `2bb642eb442d5e03b209e83203974b56de1e71acb2ac0ae13d6086c48463b98d`) takes the taps screen's combined-attention arm as `attention` and adds `attention-corrected`, which differs only in the tap, the correction file and the lookahead reserve (128 to 164 MiB); `configs-learned.json` (sha256 `97cebea5ef2ed5a0b7dfaacef3a0f332e81d5f994a24ac75663d812a2a741460`) is identical in the smoke and the screen. `analyze_learned_screen.py` (sha256 `d4680ca4032e47a94e0dd53be2512e1ffb1c6b093fd116c0f73610d7d1f0a49e`) applies the taps screen analysis with the attention tap as the reference. `chain-learned.sh` (sha256 `a37f2d6b92366c33daa6afc2a9b49dc8ee53f233ec3c1ce3c7529fdc3ebdd7ba`) ran the screen after the taps B1 confirmation finished, added rounds by the rule and started the confirmation only on a passing reading; `run-learned-screen.sh` (sha256 `17918747fa175e58e747cf77589ff6be829b2696b2a1dad2449b16f282af2308`) refuses unless the diagnostic passed and the binary and correction file hashes match.

The launcher first runs a smoke, which the registration does not mention: one 32-output request (r0005) per arm on the diagnostic's 10 GB protocol, required to exit cleanly with identical outputs and with the corrected arm naming the correction file. It measures nothing and gates nothing registered. It ran at 04:26:01 with 26.92 GB reclaimable: both arms exited 0 with the same 32 outputs, and the corrected arm's predictor identity was `router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188`.

## Run

`Tools/expert_lookahead.py prepare` froze protocol `xla3-learned-screen-20gb` (sha256 `a1420cc7a15ea7226d91911fb3aea4d364c8a024bfc9eef0506c2798f8a6e671`) at 04:34:56 with 30.40 GB reclaimable, so the 20 GB profile applied, on the correction build (sha256 `3e6652f30aec593d...`) under process-pageins-v1. Rounds 0 to 2 ran from 04:34:56 to 05:07:14. Host swap-outs during the arm made three cells unclean, all r0074: round 0 attention (1,224 pages), round 1 corrected (4,424) and round 2 attention (12,212). That left 9 counted pairs, so the rule added round 3, which ran from 05:07:21 to 05:18:14 and brought 13. The contention sampler wrote 514 lines; no arm window held a compiler, linker or second slotstream engine, and the Sevra app peaked at 5.3% CPU, so the sensitivity reading equals the rule as written. No model process remained.

## Results

Outputs were identical in all 32 cells. Paired ratios, corrected over attention:

| round | r0005 | r0074 | r0096 | r0206 |
| --- | ---: | ---: | ---: | ---: |
| 0 | 1.047 | excluded | 1.043 | 1.017 |
| 1 | 0.996 | excluded | 1.042 | 1.024 |
| 2 | 0.963 | excluded | 1.086 | 1.290 |
| 3 | 0.928 | 1.040 | 1.001 | 1.033 |

The first 12 counted pairs in round order give 1.036 with 9 above 1 (bars 1.01 and 8). All 13 give 1.036 with 10 above 1, from 0.928 to 1.290. Median tok/s over counted cells was 14.17 for the attention tap (14 cells) and 14.30 with the correction (15 cells). Median counters per counted cell, attention then corrected: records read in decode 13,760 and 12,370, reads issued 23,870 and 21,020, adopted 15,950 and 17,530, expired unused 5,650 and 2,420, wasted bytes 15.64 GB and 6.69 GB, demand misses 13,720 and 12,280, forecast build 0.050 s and 0.080 s, forecast evaluation 3.98 s and 4.05 s, and 96 verify passes in both.

## Outcome

The reading passes under the rule as written and the Sevra sensitivity, so the held-out confirmation ran as registered. The screen only decides whether the confirmation runs; its ratios are not claims.

Artifacts (sha256): smoke configs-learned.json `97cebea5ef2ed5a0b7dfaacef3a0f332e81d5f994a24ac75663d812a2a741460`, smoke cells.jsonl `0e5d1935fd66da54b8de28c9f5ba578576bfa59f1d7d4e41ff0ddf9b1f01f470`, smoke.log `3927f487db24352c15fc5d1ddd652881914f35f1b7d4f8745ad3a27371256511`, protocol.json `a1420cc7a15ea7226d91911fb3aea4d364c8a024bfc9eef0506c2798f8a6e671`, configs-learned.json `97cebea5ef2ed5a0b7dfaacef3a0f332e81d5f994a24ac75663d812a2a741460`, learned-native-preregistration.md `237b2916fd6cc19e5301ae0273a29b926d14be7bbe8ea6c4aa6d0b0c2b8ea037`, contention-samples.txt `20051aa08a98dc7ffb57d44ab2422b5fefbbd9d5882fe5f4f7978891a200e117`, sweep-rounds3.log `0359deb48d90f66c2fe7910af1ca0ea65a83e387d352f05c0e1dce81dd6fffdd`, sweep-rounds4.log `17b6fd4f04774ea374fdfeb4d507515396d226df54f5b6b79254d1f1b5699607`, sweep/cells.jsonl `1c91204dd81e672f01709ae73e03edb5e6d540ac9c8215e76b71cdc6874d1804`, sweep/report.json `5dfef49d393f20b933b0d110ff6ebe7d65a3836ec4b546dc4001a1357a2b67e6`, sweep/learned-screen-analysis.json `b63bbf97bd703a64d63219cccae121fb00d6d209eaef9931aa405909d254d6e1`.

## Chain output, screen part

```text
chain checks ok (02:41:21)
== screen, 3 rounds (02:41:21)
{"configs": ".build/expert-lookahead/xla3-learned-native-20260915/smoke-sweep/configs-learned.json", "corrected_reserve_mib": 164}
smoke with 26.92 GB reclaimable (04:26:01)
smoke: both arms ran True, outputs identical True, corrected identity 'router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188'
[04:34:56] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-learned-screen-20gb/protocol.json: memory 20.0 GB (reclaimable 30.4 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-learned-screen-20gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-learned-screen-20gb/protocol.json", "memory_gb": 20.0}
{"configs": ".build/expert-lookahead/xla3-learned-screen-20gb/configs-learned.json", "corrected_reserve_mib": 164}
screen .build/expert-lookahead/xla3-learned-screen-20gb to 3 rounds with 30.40 GB reclaimable (04:34:56)
sweep exit 0 (05:07:14)
no model process
24 cells, 21 counted as written, 21 under the Sevra sensitivity, 384 sampler lines

exact outputs in every cell with output: yes

counted:
  config                       cells  med tps | pairs  ratio  >1    min    max | first 12: ratio  >1  pass
  attention                       10    14.13 |     0      -   0      -      - |      -   0 False
  attention-corrected             11    14.30 |     9  1.053   7  0.963  1.290 |  1.053   7 False

counted_sensitivity:
  config                       cells  med tps | pairs  ratio  >1    min    max | first 12: ratio  >1  pass
  attention                       10    14.13 |     0      -   0      -      - |      -   0 False
  attention-corrected             11    14.30 |     9  1.053   7  0.963  1.290 |  1.053   7 False

median prefetch counters per counted cell (rule as written):
  decodeRecords          attention=1.376e+04  attention-corrected=1.236e+04
  verifyPasses           attention=96  attention-corrected=96
  issued                 attention=2.387e+04  attention-corrected=2.102e+04
  adopted                attention=1.595e+04  attention-corrected=1.753e+04
  promoted               attention=4826  attention-corrected=4851
  expired                attention=5649  attention-corrected=2420
  cancelled              attention=24.5  attention-corrected=8
  demandMisses           attention=1.372e+04  attention-corrected=1.227e+04
  wastedBytes            attention=1.564e+10  attention-corrected=6.694e+09
  arrivalIssues          attention=4305  attention-corrected=4210
  slotEvictedKeys        attention=1.595e+04  attention-corrected=1.754e+04
  joinSeconds            attention=0.1158  attention-corrected=0.09205
  adoptSeconds           attention=0.1308  attention-corrected=0.1139
  forecastBuildSeconds   attention=0.0502  attention-corrected=0.08049
  forecastEvalSeconds    attention=3.919  attention-corrected=3.827
  forecastSelectSeconds  attention=0.1428  attention-corrected=0.1386
  scheduleSeconds        attention=0.08503  attention-corrected=0.07817

counted pairs per candidate: {'attention-corrected': 9} (rounds are added until 12 or six rounds)
screen reading for attention-corrected: as written False, Sevra sensitivity False, confirmation runs False
wrote .build/expert-lookahead/xla3-learned-screen-20gb/sweep/learned-screen-analysis.json
after 3 rounds: more, 9 counted pairs, confirmation runs False
== screen, round 4 (05:07:20)
screen .build/expert-lookahead/xla3-learned-screen-20gb to 4 rounds with 30.89 GB reclaimable (05:07:21)
sweep exit 0 (05:18:14)
no model process
32 cells, 29 counted as written, 29 under the Sevra sensitivity, 514 sampler lines

exact outputs in every cell with output: yes

counted:
  config                       cells  med tps | pairs  ratio  >1    min    max | first 12: ratio  >1  pass
  attention                       14    14.17 |     0      -   0      -      - |      -   0 False
  attention-corrected             15    14.30 |    13  1.036  10  0.928  1.290 |  1.036   9 True

counted_sensitivity:
  config                       cells  med tps | pairs  ratio  >1    min    max | first 12: ratio  >1  pass
  attention                       14    14.17 |     0      -   0      -      - |      -   0 False
  attention-corrected             15    14.30 |    13  1.036  10  0.928  1.290 |  1.036   9 True

median prefetch counters per counted cell (rule as written):
  decodeRecords          attention=1.376e+04  attention-corrected=1.237e+04
  verifyPasses           attention=96  attention-corrected=96
  issued                 attention=2.387e+04  attention-corrected=2.102e+04
  adopted                attention=1.595e+04  attention-corrected=1.753e+04
  promoted               attention=4486  attention-corrected=3932
  expired                attention=5650  attention-corrected=2420
  cancelled              attention=20.5  attention-corrected=10
  demandMisses           attention=1.372e+04  attention-corrected=1.228e+04
  wastedBytes            attention=1.564e+10  attention-corrected=6.694e+09
  arrivalIssues          attention=4304  attention-corrected=4210
  slotEvictedKeys        attention=1.595e+04  attention-corrected=1.754e+04
  joinSeconds            attention=0.07217  attention-corrected=0.08345
  adoptSeconds           attention=0.09097  attention-corrected=0.1064
  forecastBuildSeconds   attention=0.0502  attention-corrected=0.08049
  forecastEvalSeconds    attention=3.978  attention-corrected=4.051
  forecastSelectSeconds  attention=0.144  attention-corrected=0.143
  scheduleSeconds        attention=0.08653  attention-corrected=0.08626

counted pairs per candidate: {'attention-corrected': 13} (rounds are added until 12 or six rounds)
screen reading for attention-corrected: as written True, Sevra sensitivity True, confirmation runs True
wrote .build/expert-lookahead/xla3-learned-screen-20gb/sweep/learned-screen-analysis.json
after 4 rounds: enough, 13 counted pairs, confirmation runs True
```
