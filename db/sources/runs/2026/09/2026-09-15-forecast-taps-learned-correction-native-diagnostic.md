---
type: run
id: 01m2n6p9n354bmx2087x2k8hya
created: 2026-09-16T13:32:24.099011+00:00
updated: 2026-09-16T13:38:51.966464+00:00
summary: 'Native learned correction: corrected top-10 set equals the offline set in 99.90% of 141,450 rows, agreement 0.79799 against 0.7980 offline, plain tap 0.72918; passes'
binary: 3e6652f30aec593dd5240213f173429cf369abf8c3917741235b01ff1dfe755e (correction build)
captured_at: 2026-09-15
command: run-learned-native-diagnostic.sh (Tools/expert_lookahead.py prepare --memory-gb 10; capture of the 13 validation requests with the attention and attention-corrected taps side by side)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Forecast taps, step 7: native learned correction, correctness diagnostic'
tool: slotstream expert-lookahead-capture with --forecast-correction; analyze_learned_native.py
---
Forecast taps, step 7 ([[records/plan/decode-forecast-taps-2026-09-14]]): does the engine's native learned tap correction reproduce the offline rank-128 forecasts closely enough to time it? Artifacts are under `.build/expert-lookahead/xla3-learned-native-20260915/`, which git ignores. Nothing was installed, published or committed.

## Registration

`learned-native-preregistration.md` (sha256 `237b2916fd6cc19e5301ae0273a29b926d14be7bbe8ea6c4aa6d0b0c2b8ea037`, written 2026-09-15 02:08:16 -05, after the offline gate passed and before any engine code for the correction existed) fixes three steps: this correctness diagnostic with no timing, a screen on the four exploration prompts that only decides whether a confirmation runs, and a held-out confirmation on ten prompts from training-split families that no capture, fit, screen or cohort has used. Step 1 passes when, over targets 2 to 47, the native corrected top-10 set equals the offline rank-128 top-10 set in at least 99% of rows, native corrected top-10 agreement with the true routes is within 0.005 of 0.7980, and the plain tap still gives 0.7292 within 0.002. A failure stops every timing run until the difference is explained and a corrected build passes.

## Implementation

`RouterTapCorrection` loads a `slotstream-tap-correction-v1` safetensors file (FP16 factors a and b, FP32 mu and delta, I32 targets), checks its schema, tap, dtypes, shapes, target window and finite values, and identifies it by the file's SHA-256. A new forecast tap, `attention-corrected` (code 3), shares the attention tap's mixed input and router product and adds ((mixed - mu[T-1]) a[T-1]) b[T-1] + delta[T-1], with the wide product in FP16 and the narrow one in FP32. `SLOTSTREAM_EXPERT_PREFETCH_CORRECTION` names the file; the corrected tap without a file, or a file without the corrected tap, is refused. The default lookahead reserve grows by the file's size in whole MiB (128 to 164 MiB for this file). The scheduler loads the factors at engine start and stops if they fail to load or if its staging cap plus their 37,539,840 resident bytes exceeds the reserve; with 32 records of 2,764,800 bytes the two need 120.2 MiB. The capture tool gained `--forecast-correction` and records the file's path, hash and resident bytes. The forecast tap check grew to 40 assertions: parsing, refusals, the reserve, the formula against a hand reference within 1e-2, loaded against in-memory factors, and the session skipping the corrected tap until factors are set.

The changes are uncommitted in the working tree: `Sources/Slotstream/RouterTapCorrection.swift` (new), `ExpertLookaheadTrace.swift`, `Model.swift`, `ExpertPrefetch.swift`, `Sources/slotstream-cli/ExpertLookaheadCommands.swift`, `Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift` and `Tools/expert_lookahead.py`. The release build (binary sha256 `3e6652f30aec593dd5240213f173429cf369abf8c3917741235b01ff1dfe755e`) completed, and the diagnostics suite passed 55 of 55 checks (30,368 assertions).

## Capture

The launcher waited for no other model or analysis process and at least 15.5 GB reclaimable, copied the binary and metallib to `bin-learned-3e6652f30aec593d/`, and launched at 02:22:19 with 21.22 GB reclaimable. `Tools/expert_lookahead.py prepare` froze protocol `xla3-learned-native-20260915` at 02:22:21 as a successor of `xla-pilot-20260911`, at a 10 GB target. The capture ran the pilot's 13 validation-split requests (request file sha256 `ce8dffd7fef1e97296441c3719896bada6202e256f84747dda6fcf525a513643`) with the decode lookahead off, start features and x2 off, and the attention and attention-corrected taps recorded side by side as observer forecasts with 24 candidates per row.

It exited 0 after 697 s at 02:33:58: all 13 requests valid, 1,072 passes (1,025 verify passes with 3,075 verify tokens, 2,616 kept, and 47 prefill passes), 51,456 route records, and 96,350 forecast records, which is both taps at each of 47 targets on every verify pass, in 79,112,241 bytes of shards. `validate-data` passed and no model process remained.

## Analysis

`analyze_learned_native.py` (sha256 `e84be895fef456f07e556c8f4f043522f537532d30c7ce002c044e54c72b0978`) joins each request's native verify passes with the learned capture's, checking that each pair decodes the same tokens, and scores the rows the offline fit scored, targets 2 to 47.

| request | rows | top-10 set match | native corrected | offline rank-128 | plain tap |
| --- | ---: | ---: | ---: | ---: | ---: |
| r0013 | 11,592 | 0.9978 | 0.7370 | 0.7370 | 0.6633 |
| r0065 | 12,006 | 0.9988 | 0.7329 | 0.7329 | 0.6319 |
| r0066 | 14,490 | 0.9990 | 0.8398 | 0.8398 | 0.7807 |
| r0151 | 12,558 | 0.9993 | 0.7656 | 0.7656 | 0.6784 |
| r0163 | 13,524 | 0.9990 | 0.8152 | 0.8152 | 0.7570 |
| r0177 | 8,694 | 0.9995 | 0.8290 | 0.8290 | 0.7678 |
| r0178 | 7,866 | 0.9992 | 0.8452 | 0.8452 | 0.7699 |
| r0241 | 10,212 | 0.9986 | 0.8097 | 0.8098 | 0.7446 |
| r0243 | 9,246 | 0.9991 | 0.7944 | 0.7944 | 0.7593 |
| r0250 | 8,142 | 0.9989 | 0.7327 | 0.7326 | 0.6219 |
| r0251 | 11,178 | 0.9987 | 0.7934 | 0.7934 | 0.7056 |
| r0298 | 14,214 | 0.9996 | 0.8347 | 0.8347 | 0.7951 |
| r0300 | 7,728 | 0.9999 | 0.8484 | 0.8484 | 0.8010 |
| pooled | 141,450 | 0.99902 | 0.79799 | 0.79799 | 0.72918 |

Every row of the offline validation set was matched (141,450 of 141,450).

## Outcome

Step 1 passes all three conditions: top-10 set match 0.9990 (bar 0.99), native corrected agreement 0.79799 (0.7980 within 0.005) and plain tap 0.72918 (0.7292 within 0.002). Over the same rows the native corrected agreement differs from the offline form's by 0.0000014; the 0.1% of rows whose top-10 sets differ do not move pooled agreement at the fourth decimal. As registered, the screen follows. The taps B1 confirmation, which had waited for memory since the taps screen passed, launched first at 02:35:37 with 26.22 GB reclaimable, and the screen waits for it to finish.

Artifacts (sha256): protocol.json `da554e6bcc6f4e5ac3529bcf7656fcf34c026b58ff8c145706d0fd5bd99970d7`, requests-validation13.json `ce8dffd7fef1e97296441c3719896bada6202e256f84747dda6fcf525a513643`, learned-native-preregistration.md `237b2916fd6cc19e5301ae0273a29b926d14be7bbe8ea6c4aa6d0b0c2b8ea037`, capture/run.json `e2944a7926ad832159524a1c99e1935843d2a081e0df36feaa787085f364fdc0`, capture/requests.jsonl `3d10128df2051516c664c8f4c0fd7a0e64dbae8f918ee420dbd2c4d088b53d76`, capture/validate-data.json `364ad5846c61f6a1964674c059eef1abcd0a4e35ea4983eb9e176c8dfaf26007`, native-diagnostic.json `6ee59571943c538bc7782ee0afaa9d1fb34a4dbf2c42c4c960823ffd39199ce9`, and the launcher run-learned-native-diagnostic.sh `caa6f4167caad245a1465bd540478a257fc676a7e65ef969aa277f42317168c4`.

## native-diagnostic.json (pooled fields)

```text
{
 "checks": {
  "corrected_within_0_005": true,
  "plain_within_0_002": true,
  "set_match": true
 },
 "corrected_agreement": 0.7979886885825072,
 "expected_rows": 141450,
 "offline_rank_agreement_same_rows": 0.7979872746553244,
 "passes": true,
 "plain_agreement": 0.7291841640155416,
 "rows": 141450,
 "set_match": 0.9990173206079886
}
```
