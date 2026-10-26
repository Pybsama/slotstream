---
type: run
id: 01m5t1k77av08n8wpw4gaqkk4m
created: 2026-10-25T17:26:38.058528+00:00
updated: 2026-10-25T17:26:38.709343+00:00
summary: Q2 recorded adaptive choices preserve complete work; timing excluded
binary: v68 and pinned diagnostic identities in archive
captured_at: 2026-10-25
command: Exact commands and process ledgers in the linked archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 recorded adaptive choices preserve complete work; timing excluded
tool: Native Swift/MLX/Metal Q2 diagnostics
---
Evidence archive: [q2-layout-and-choice-controls-2026-10-25.tar.gz](q2-layout-and-choice-controls-2026-10-25.tar.gz), 85 files, 474227 bytes, SHA-256 `d33696c876ed731e7e8829ee2dc2ae4212b53cfc5cce8d3909f3eb385a4f6fe3`. Every member passed hash readback and the credential-pattern scan. Scripts, source/patches, inputs, commands, binary identities, guards and results are preserved. Model weights and executables are identified, not embedded.

The first padded-copy arm of the layout control supplies four exact prompt-ID
and chosen-depth vectors before any replay result. A temporary diagnostic build
replays those choices, ranging from zero through seven proposals, while keeping
real proposal generation, verification, sampling, rollback, streaming,
read-ahead and calibration observation. A/B share the same executable, padded
layout and 4,062 slots, differing only in original copies versus aligned direct
reads. The protocol is ABBA with two warmups and 384-token code/prose requests,
15 GB budgets and 8,192-token context. There is no per-pass logit readback.

Every one of the 16 requests matches the captured ordinary request's prompt
IDs, output tokens/text/stream, tool parse and core verification work. All
memory, headroom, nominal thermal and no-competing-build checks pass. Final A
records eight global swap-in pages during timed prose, with no swap-outs.
The whole timing protocol is excluded, including favorable clean earlier arms.
The consistent raw direct-read gains remain diagnostic, not an adoption gate.
Secondary streaming-gap analysis checks one observed long gap per verify pass;
those gaps include drafting, verification, preceding reconciliation and host
scheduling. They are not isolated GPU time.

The prepared normal-adaptive same-binary copy control was conditional on a
qualified replay gain. Its prerequisite fails, so it is not run. The bounded
adaptive-cost diagnostic is a future investigation, not implemented or tested
here. Restoration proof verifies all 509 runtime inputs and five default build
artifacts equal v68. Fast is unchanged; no production change is retained.
