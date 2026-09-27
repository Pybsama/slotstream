---
type: run
id: 01m3hkk3q38qtyjmb6wdz65pac
created: 2026-09-27T14:16:35.298748+00:00
updated: 2026-09-27T14:16:41.563128+00:00
summary: v0.2.26 published, publicly installed and accepted
binary: 37243fe333423b238e087448823b93a19712d9473937353fce9e145dfe10e645
captured_at: 2026-09-27
command: python3 qualify.py; python3 Tools/prefix_turn_writes_e2e.py; python3 Tools/persistent_prefix_e2e.py; gh release download; gh attestation verify; sh install.sh; Tools/e2e_release.sh
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.26 published, publicly installed and accepted
tool: GitHub Actions, native acceptance, prefix cache live gates, public installer and installed serving
---
[v0.2.26](https://github.com/carloslfu/slotstream/releases/tag/v0.2.26) was published at 2026-09-27T14:12:39Z from commit `a8a5294a8a826ee9356c900df76614646e756bba`. Main engine CI 36321843873, context proxies 36321843905 and docs 36321843869 passed before the tag. Mac app CI 36321843875 built the app in Xcode, and its scripted checks failed only `Tools/check_sevra_scroll.sh` ("returning to a thread restores its reading position"), the same intermittent failure seen on main at `a855c49`, `4ee751a` and `ef38ad7`; the release does not depend on that workflow. Release workflow 36325034332 published the exact tested CI archive without rebuilding it.

Original bytes are preserved in [capture.tar.gz](../../../artifacts/release-0.2.26-2026-09-27/capture.tar.gz), with a [per-file manifest](../../../artifacts/release-0.2.26-2026-09-27/manifest.json) and [verification receipt](../../../artifacts/release-0.2.26-2026-09-27/receipt.json). Capture SHA-256: `d3df9a4d948f50cb67d6a78f4fcfef50ae201ad5b112f2f1a0d3451b68e0883b`. All 145 included files were read back from the archive and checked against their recorded SHA-256. Tensor caches, release archives, the candidate binary and the Metal library are excluded with their paths and sizes and are identified by the retained hashes.

The archive SHA-256 is `eb4f52d7655b7d1978c2ef28a19597c687d9e513d8ca0625eaefbc3a72547b3b`. The installed executable SHA-256 is `37243fe333423b238e087448823b93a19712d9473937353fce9e145dfe10e645`. The MLX 0.32.2 metallib SHA-256 is `dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed`, unchanged from 0.2.25. All 209 source inputs match the release checkout. CI and public archive/checksum bytes match, GitHub attestation verification passed, and the public installer was checked against source before it upgraded the standard installation from 0.2.25.

Before the candidate existed, a local build of the release commit passed the weight-free catalogue: 85 groups, 32,636 assertions, no failures or skips. The exact downloaded candidate then ran the full native battery in 1,873 s with 33 gates passed. Its vision parity gate was skipped, which the battery counts as a failure, because the scratch checkout had no `.venv31`. With the reference `.venv31` (MLX 0.31.1), the same candidate passed both vision parity gates: the Swift tower against MLX float32 at cosine 0.99846 and against the bf16 reference at 0.99866, inside the dtype band. That is 35 top-level gates, the same set that accepted 0.2.25; apart from the version string, the gate lines differ only in the key order of one printed JSON object.

`Tools/prefix_turn_writes_e2e.py` passed 4/4 on the candidate. The second turn wrote 122.8 MB, one state, where 0.2.25 wrote 238.4 MB ([[records/measurements/prefix-turn-writes-2026-09-26]]), and no later turn kept a shared prefix.

`Tools/persistent_prefix_e2e.py` at the release commit failed the same five of its twelve checks on a local build of 0.2.26 and on the released 0.2.25, with byte-identical writes: turn 1 saved its 3,584-token system prompt as a shared prefix (214.8 MB) and then its 3,840-token state (122.8 MB written, 99.1 MB of the prefix's rows reused). The gate still expected turn 1 to reuse nothing and every snapshot to hold only the conversation's two states. Its restart, regeneration and output-id checks passed on both. Commit `6dcba83` counts the shared prefix separately and lets turn 1 reuse only its rows; the corrected gate passed 12/12 on the candidate, including identical prompt and output ids after a restart and after regenerating.

The publicly installed executable passed all 31 end-to-end checks with a 10 GB target, context 32768, MTP on and vision off. The installed server exited and was reaped. Qualification began with 32.2 GB reclaimable. These are functional acceptance results, not speed claims.
