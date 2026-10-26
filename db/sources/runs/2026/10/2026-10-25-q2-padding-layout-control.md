---
type: run
id: 01m5t1k6gadrbs1vddpxayxnzg
created: 2026-10-25T17:26:37.322884+00:00
updated: 2026-10-25T17:26:37.989439+00:00
summary: Clean Q2 padding-only normal-request comparison
binary: v68 and pinned diagnostic identities in archive
captured_at: 2026-10-25
command: Exact commands and process ledgers in the linked archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Clean Q2 padding-only normal-request comparison
tool: Native Swift/MLX/Metal Q2 diagnostics
---
Evidence archive: [q2-layout-and-choice-controls-2026-10-25.tar.gz](q2-layout-and-choice-controls-2026-10-25.tar.gz), 85 files, 474227 bytes, SHA-256 `d33696c876ed731e7e8829ee2dc2ae4212b53cfc5cce8d3909f3eb385a4f6fe3`. Every member passed hash readback and the credential-pattern scan. Scripts, source/patches, inputs, commands, binary identities, guards and results are preserved. Model weights and executables are identified, not embedded.

Fresh ordinary-adaptive ABBA compares frozen v68 (4,067 slots) with the padded
candidate using original scratch/copy reads (4,062 slots). Both have 15 GB
budgets, 8,192-token context, read-ahead, two warmups and 384-token code/prose
requests. Aligned-direct reads and diagnostic depth overrides are disabled.
All four arms pass the no-paging, nominal-thermal, no-competing-build, actual
physical-memory and headroom gates. Prompt IDs match and prefix reuse is zero.

The full charged layout changes median request time by about -1.2% for code
and -0.1% for prose. Both tasks have opposite signs between paired orders.
This does not establish a consistent layout penalty or stable layout speedup.
The actual requests and work differences remain in padding-only-complete-15*.
The next recorded-choice control is separately registered as timing-excluded.
