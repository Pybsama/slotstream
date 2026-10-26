---
type: run
id: 01m5wtcs6p0ztsgfg5x8h66b9a
created: 2026-10-26T19:18:30.358293+00:00
updated: 2026-10-26T19:18:31.055587+00:00
summary: Mac app source archive, unchanged engine release comparison and scoped verification
binary: 'No new inference binary: engine source unchanged from ca4bd6869f394a5d03ddb459e8202ad897d1d03a; successful matching engine CI recorded'
captured_at: 2026-10-26
command: git diff v0.2.30 HEAD; archive inventory byte comparison; swift package dump-package; vq_kernel_sources_test.py; static_gates_binary_test.py; brain gates and local link check
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Mac app retirement and engine release comparison
tool: Git source audit, Swift package inspection, focused checks and repository gates
---
[Raw scope and verification capture](mac-app-retirement-2026-10-26.tar.xz): 12 members, SHA-256 `74e47d4e8bddb6c773a1cb4bd43086f6d8d61867cdfef4eab553bbc7cbfd6b72`. Every member is read back and compared. Home/checkout prefixes are replaced, credential-pattern matches are zero, and user Homes, model weights and ignored binaries are excluded.

The complete app was archived at `ca4bd6869f394a5d03ddb459e8202ad897d1d03a`, tag `archive-mac-app-2026-10-26`, before deleting 128 tracked app files, scripts and the app workflow. `archive-inventory.json` records each removed path and hash and was checked against that fixed commit. The tag is pushed; it is not a release.

`engine-vs-v0.2.30.diff` shows the sole engine-source change, the display title from Original 4-bit to Qwen3.8-Flash-Next 4-bit. `engine-unchanged.json` confirms app retirement itself changes no engine Sources, root package inputs, Makefile, installer or engine licenses. `swift package dump-package` resolves the existing engine/library/CLI products with no app target. The engine CI for the identical source inputs passed; its live result and the archived app's CI status are captured separately.

The edited VQ kernel-source test passes its four tests; its reviewed engine kernel and license hashes remain checked, and only the removed app's duplicate-license comparison is dropped. The static-gate harness passes all 39 tests; its final tool output is preserved. Current CI YAML parses. Full brain validation has zero errors/warnings, generated projections are current and all 354 claim checks pass. The link pass checks 300 local documentation targets without findings; all pre-existing README anchors remain.

Active docs, README, repository description and agent instructions now describe the engine scope. Historical app guides keep their original paths with an archive notice and are omitted from the combined current documentation. App plans and implementation ledgers are marked archived; unfinished gates are not claimed complete. No app is uninstalled and no local Home or downloaded model is deleted. No release is created.
