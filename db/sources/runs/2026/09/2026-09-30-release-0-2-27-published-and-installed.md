---
type: run
id: 01m3swb1zdm1d9wcy72a6bgdrm
created: 2026-09-30T19:23:24.013232+00:00
updated: 2026-09-30T19:23:29.390398+00:00
summary: v0.2.27 published, publicly installed and accepted
binary: fad3a30a1bcabec74d64690ddc538c8553026168d71094a97d31346bedf2eae4
captured_at: 2026-09-30
command: python3 qualify.py; python3 Tools/prefix_turn_writes_e2e.py; python3 Tools/persistent_prefix_e2e.py; gh release download; gh attestation verify; sh install.sh; Tools/e2e_release.sh
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.27 published, publicly installed and accepted
tool: GitHub Actions, native acceptance, prefix cache live gates, public installer and installed serving
---
[v0.2.27](https://github.com/carloslfu/slotstream/releases/tag/v0.2.27) was published at 2026-09-30T19:16:02Z from commit `22ac07e7fe04bd45d844b39ebd8a86c1d3c6d4cf`. Main engine CI 36755478234, context proxies 36755478269, docs 36755478227 and Mac app CI 36755478242 passed before the tag. The Mac app's scripted checks passed in full, including "returning to a thread restores its reading position", the intermittent check fixed in [#50](https://github.com/carloslfu/slotstream/pull/50). Release workflow 36764262813 published the exact tested CI archive without rebuilding it.

Original bytes are preserved in [capture.tar.gz](../../../artifacts/release-0.2.27-2026-09-30/capture.tar.gz), with a [per-file manifest](../../../artifacts/release-0.2.27-2026-09-30/manifest.json) and [verification receipt](../../../artifacts/release-0.2.27-2026-09-30/receipt.json). Capture SHA-256: `0555319da5c7fe13f320621e6396cebe11d2777dbea7077c6438a155b095be64`. All 205 included files were read back from the archive and checked against their recorded SHA-256. Tensor caches, release archives, the candidate binary and the Metal library are excluded with their paths and sizes and are identified by the retained hashes. Generated tensor dumps from the current-layer, MTP and vision parity gates are excluded too, with their SHA-256 kept in the manifest; the gate logs record their comparisons.

The archive SHA-256 is `b5af97f06a7fcad105e6027aa00e6ec6d58e5c8d13234c5f95852c66f242494c`. The installed executable SHA-256 is `fad3a30a1bcabec74d64690ddc538c8553026168d71094a97d31346bedf2eae4`. The MLX 0.32.2 metallib SHA-256 is `dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed`, unchanged from 0.2.26. All 211 source inputs match the release checkout. CI and public archive/checksum bytes match, GitHub attestation verification passed, and the public installer matched the checkout's `install.sh` byte for byte before it upgraded the standard installation from 0.2.26.

Before the candidate existed, a local build of the release commit passed the weight-free catalogue (89 groups, 33,136 assertions, no failures or skips) and the full native battery (35 gates, no failures). The exact downloaded candidate then passed the full native battery in 1,956 s: 35 top-level gates, no failures or skips. The reference `.venv31` (MLX 0.31.1) was linked into the checkout for the battery and removed afterwards, so vision parity ran inside the battery: the Swift tower against MLX float32 at cosine 0.99846 and against the bf16 reference at 0.99866, inside the dtype band. Quality passed 15/15, API robustness 74/74 and vision serving 25/25. Apart from the version string, the battery's passing checks are the ones that accepted 0.2.26 plus the two vision parity gates, with one printed JSON object in a different key order.

`Tools/prefix_turn_writes_e2e.py` passed 4/4 on the candidate. The second turn wrote 122.8 MB, one state, as in 0.2.26. `Tools/persistent_prefix_e2e.py` passed 12/12, including identical prompt and output ids after a restart and after regenerating.

The publicly installed executable passed all 31 end-to-end checks with a 10 GB target, context 32768, MTP on and vision off. The installed server exited and was reaped. Qualification began with 33.8 GB reclaimable and the installed acceptance with 32.7 GB. These are functional acceptance results, not speed claims.
