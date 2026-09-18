---
type: run
id: 01m2v15nsttzndyftjs8sqfjh9
created: 2026-09-18T19:51:23.194127+00:00
updated: 2026-09-18T19:51:48.063893+00:00
summary: v0.2.22 candidate passes the full model battery, memory and source gates, public library smoke test, and Mac app checks.
binary: abb433340669e727c1f807a44fb2ddf1a1062b937e5190285df80494aa34754f
captured_at: 2026-09-18
command: make build; Tools/static_gates.sh; make checks-all; Tools/consumer_smoke.sh; bash Tools/check_sevra_mac.sh; Tools/verify.sh
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.22 release candidate qualification
tool: Tools/verify.sh, repository gates and Sevra Mac checks
---
The local v0.2.22 release candidate was built from the final engine and test sources. Its binary SHA-256 is `abb433340669e727c1f807a44fb2ddf1a1062b937e5190285df80494aa34754f`; the reconstructible source archive is `b198de075033266559613a2bd85e61ef2f2c2677a69844f284301df833cae70a` and contains 190 source files. The pinned MLX Metal library is `198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597`.

## Engine and repository gates

- Release and debug builds passed. The public Swift package consumer smoke test passed with 22 diagnostic assertions.
- The check catalogue passed 69 groups, 0 failed and 0 skipped, with 31,261 assertions.
- The planner passed 90 cases, the sampler and governor passed 17, and the memory override matrix passed 319 cases without loading the model.
- Static gates passed, including the coverage ratchet, claims gate with 299 needles, installer gates, HTTP/download gates, sustained-memory gate, projections and brain validation. The store retains its two declared historical warnings.

## Full native model battery

`Tools/verify.sh` completed against the same candidate with 27 top-level gates passed and 0 failed. Every required file in the 105.3 GB pinned model matched its digest. Layer 0 and layer 1 were bit-exact against the Python reference. Output stayed identical across 8.1 GB and 10 GB cache plans and across pool grow, shrink and regrow. The live governor shrank, honored its cooldown, regrew, and kept every generation byte-identical.

A continued conversation matched a cold read exactly: all prompt logit deltas were 0.000000%, both follow-up turns resumed their own prefill boundaries, repeated prompts used the complete checkpoint, edited history rebuilt, and another conversation reused its shared prefix. The measured three-turn follow-up prefill was 7.87 seconds against 28.20 seconds cold in this shared-machine run.

The 10 GB process target stayed within its bound on short and long prompts. The long-context answer remained correct. Speculative decode passed Python parity, determinism, state integrity, acceptance sanity, and bit-for-bit multi-row verification. The behavioral probe passed 15 of 15 and serving robustness passed 74 of 74. `/api/version` reported 0.2.22.

Vision parity passed inside the bf16 reference band. Vision serving passed 25 of 25. The earlier image follow-up failure was a test setup error: its short first prompt offered no stable 3,072-token prefill boundary containing the complete image, so the exact-resume policy correctly refused it. The corrected fixture crosses a real boundary without reshaping a pass. Its first request encoded the image and stored a checkpoint; the follow-up reused the prefix, skipped the tower and completed in 3.4 seconds. Changed image bytes still miss and re-encode.

## Sevra Mac development app

Every Mac product built in release mode. The composer suite passed 25 scripted scenarios plus real dbmd persistence. Native transcript, thinking controls, mini-app isolation, review flows and dark-mode snapshots passed. The runtime suite passed its document, journal, memory, queue, cancellation, IPC, backup/restore, extension, skill, mini-app and sandbox checks. This qualifies the source in the release tag; the Mac app remains a development app and is not part of the CLI release download.

## Scope

These are functional and memory-safety results on the shared M5 Pro 48 GB development Mac. They are not a clean throughput run, a native 48 GB allocation measurement, or 64 GB hardware qualification. Publication, CI-artifact identity, installation and installed-binary acceptance are separate release steps.
