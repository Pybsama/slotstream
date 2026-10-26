---
type: run
id: 01m5jg2vd0qxq33yhrz43b1d6z
created: 2026-10-22T19:05:54.848575+00:00
updated: 2026-10-22T19:06:12.608863+00:00
summary: Frozen native Q2 ports, matched-cache comparisons, independent quality/state checks and six real app jobs, with performance parity still open
binary: Native v17 f6c979e088384622291bd9b3c277b2d9f4ba014bbebf1caa85e12bfb984808e3; per-build and app identities in archive
captured_at: 2026-10-22
command: Exact commands, protocol, fixtures, identities and outputs inside the frozen archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native Q2 execution comparison and app receipts
tool: Native Swift/MLX/Metal CLI and Mac app; pinned Splash 1.4.0 comparison
---
# Native Q2 execution comparison receipts

The immutable [archive](native-q2-execution-2026-10-22.tar.gz) contains 593 payloads and a per-file size/SHA-256 manifest. Archive SHA-256: `62bcb46565d8ea10e583d1e9e0637168402173d3dda42018190037d820523c9e`. Every payload was read back and verified. It includes frozen native build source archives, a separate app source archive and identity, and the pinned public upstream runtime source with its license. Model weights, executable binaries, metallibs, private Homes and persistent-prefix payloads are excluded.

`protocol.md` records the retrospective method. `comparison-summary.json` reads observed expert slot counts and prompt IDs, and separately filters paging, thermal state and completion. It does not trust a matching flag as proof. The main speed sequences use 8K context, BF16 KV, the same pinned target/draft and 4,968 expert slots. Corrected twelve-GB controls assert 2,074 slots on both engines. The near-matched quality control differs by one expert slot.

`final-quality-audit.json`, the original quality receipts and grader preserve 32 continuous native requests, 24 quality outcomes and every failure. The upstream aggregate explicitly retains its failed continuous-session memory gate and separate completion of the remaining independent cases. `final-prefix-audit.json` checks fresh-process restore. Component fixtures bind independent CPU and upstream C++ arithmetic. Smart/Fast state recovery logs qualify the generic compaction change.

`final-app-identity.json` and `final-app-source.tar.gz` bind the rebuilt development app separately. `final-app-workflow-results.json`, `app-real-q2-final-observer.json` and `final-app-code-execution.json` preserve six completed real-model jobs, model/budget assertions and bounded execution of the approved minimal code edit. `app-fixtures/` contains their original synthetic inputs. The scripted UI/runtime log and a separate successful current-input check remain in `final-app-audit.json`; its original shell exit status was not recovered after context compaction, so the audit states that limitation. Every suite logged success and the failure summary is absent.

The engine catalogue passes 89 T0 and 18 T1 checks in separate final invocations. The source snapshot is the normal release build, with its MLX checkout restored to upstream-clean identity; the temporary completion-handler instrumentation is archived separately. Full static gates and hosted verification are recorded by a later validation receipt. No release or Smart promotion is implied.

Failed experiments, unsupported fixtures and speed exclusions remain registered in [[sources/runs/2026/10/2026-10-22-native-q2-execution-exclusions]].
