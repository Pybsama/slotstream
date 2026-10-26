---
type: run
id: 01m5wr3f2xndyp4hzs14zrqkdg
created: 2026-10-26T18:38:27.933155+00:00
updated: 2026-10-26T18:38:53.813021+00:00
summary: Single-model archive, app migration and native workflow verification
binary: 793bd0534e2a0afab8c16ae5aa41a3ba33c5bc88 engine; 3bfc81efb7aea84638dd1a282e328140feb7441f app; SHA-256 identities in build-identity.json
captured_at: 2026-10-26
command: Exact commands and final source/binary identities are preserved in the linked raw archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Single-model maintenance verification
tool: Native engine and app checks, offscreen production views, disposable real-model workflows and repository gates
---
[Raw verification archive](single-model-maintenance-2026-10-26.tar.xz): 40 members, 544212 bytes, SHA-256 `2e40910e20160613075156b24dfebb9bc9fc7955bb2cc9982664b5f9db6db604`. Every member is read back and compared. Home and checkout path prefixes are replaced; synthetic fixture contents are preserved. Credential-pattern matches are zero. Model weights, executables and user Homes are excluded.

Commands include `make build`, `slotstream-checks --tier t0 --tier t1`, CLI model selection, `bash Tools/check_slotstream_mac.sh`, `bash Tools/build_slotstream_mac.sh`, signature and embedded-source verification, `slotstream-mac-checks --real-capabilities --memory-gb 10 --case csv,code_edit,history_recall`, and `bash Tools/static_gates.sh`. The archive contains exact arguments, source and binary hashes, admission/cleanup observations, complete local stdout and synthetic workflow outputs.

The implementation is `793bd0534e2a0afab8c16ae5aa41a3ba33c5bc88`; final app copy and UI checks are `3bfc81efb7aea84638dd1a282e328140feb7441f`. One older app run fails its final freshness check after a concurrent settings-copy edit. Its functional checks passed; the complete stable-source rerun and explicit freshness check passed. Both logs remain. Offscreen UI screenshots use simulated telemetry and no user Home.

Real jobs use one model process, a fresh disposable Home and an explicit 10 GB ceiling on the owned M5 Pro. These are functional checks, not clean speed measurements. Read the full answers: the code explanation exceeds the requested sentence count and the recall answer emits an S1 marker without a captured source-excerpt entry. Those quality limits are not removed by passing the frozen mechanical assertions.

`ci-results.json` is a point-in-time remote snapshot: documentation and context-proxy checks have passed; engine and app workflows are still running at that capture. Their later outcome must be checked separately. `release-state.json` confirms v0.2.30 remains published. No release was created.
