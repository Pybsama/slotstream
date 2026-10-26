---
type: run
id: 01m5g6zxgn6q01tnnz77ks2wqk
created: 2026-10-21T21:48:32.661078+00:00
updated: 2026-10-21T21:49:26.794816+00:00
summary: Smart DFlash native and upstream comparison receipts
binary: Native 29024b72d6877becb94c59a1f3bda8f8d165b3f28af58202ea412c55aaad01b7; Splash 20b36bcc051145b425403dee7489d06cdbb5060460dfdb2e0cfc8d49cebfc29f
captured_at: 2026-10-21
command: See protocol.txt, preserved harnesses and per-run commands in the immutable archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Smart DFlash native and upstream comparison receipts
tool: Slotstream native comparison and isolated Splash reference
---
# Smart DFlash native and upstream comparison receipts

The immutable [artifact archive](smart-dflash-review-2026-10-21.tar.gz) contains
174 captured files, including original prompts and expected results, model
outputs, statistics, frozen graders, reference fixtures, source archives,
binary identities, commands, upstream model cards and download verification.
Its SHA-256 is `c7770e009a5675f538e1254740c31a3632fc865face88201c34135a429fe613c`.
`archive-manifest.json` binds each payload's size and digest. `protocol.txt`
explains reproduction, controls and the scope of every test group.

Primary native results are `quality-plain.json`, `quality-mtp.json`,
`quality-dflash-final.json` and `grades-final.json`. The original failed smoke,
intermediate arithmetic differences, stop-fixture error and OS-pressure
interruption remain present. `extended-grade.json`, `vision-grade.json`,
`cancellation-retry-grade.json`, the Fast receipts and final T0/T1 logs carry
separate functional outcomes. Successful inference does not turn a wrong answer
or a formatting deviation into a pass.

`native-draft-final-reference-parity-chunked.json` compares the actual draft
network and selector to the independent pinned reference. The replay and held
model-lock checks are separate. `native-replay-identity.json` binds the full
native generation comparison; `native-guard-identity.json` binds the CLI-only
replay-lock follow-up and paired timings. Their source maps differ only in
`Sources/slotstream-cli/SmartDFlashCommand.swift`.

The two complete GSQ shards are excluded from the archive. Their original
sizes, revisions and whole-file hashes are in `ranges-receipt.json`.
`tokenizer-identity.json` verifies matching IDs for every actual native token.
`quality-upstream-q2.json` and its repeated-failure receipt preserve the direct
Splash result, exact server invocation, fixed prompt IDs, physical engine
observation and successful shutdown. They compare complete implementations,
not quantization alone. The copied host-step library was disabled; no user
installation was edited. The first startup includes cold GPU compilation.

`paired-timing-v2-receipt.json`, `timing-summary.json` and `timing-grades.json`
carry the complete interleaved native comparison with operating observations
and matching output IDs. Ordinary live user applications remained open; no
owned build, download or second model overlapped it. These are short Engine
requests, not whole-app or default-memory performance. The incomplete first
attempt is separately discarded in
[[sources/runs/2026/10/2026-10-21-smart-dflash-timing-discarded]].
