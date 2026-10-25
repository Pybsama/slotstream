---
type: run
id: 01m5td3za1y0fcn15tvbb9r7bb
created: 2026-10-25T20:48:01.344918+00:00
updated: 2026-10-25T20:48:02.510212+00:00
summary: Q2 copy control, file checks and paired-code decoder trials
binary: v68, v4 diagnostic CLI, padded copy-control binary, paired-code candidate and pinned Splash1482f6b; identities in archive
captured_at: 2026-10-25
command: Exact commands, sources, frozen plans, identities, guards and analyses in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 copy control, file checks and paired-code decoder trials
tool: Bounded copy/stat/read/Metal observers, native and Splash kernel probe, guarded complete requests and fixed-work controls
---
Evidence: [q2-decoder-and-metadata-diagnosis-2026-10-25.tar.xz](q2-decoder-and-metadata-diagnosis-2026-10-25.tar.xz), 205 files,
98435324 bytes, SHA-256 `bfe0e4aedf7a428ddaf0d1a32e071b7dce58f62db989c54306e1a22029a0e432`. Sequential archive readback verifies
every member hash; credential-pattern screening finds no matches. No model
weights or executable binaries are embedded. The large derived per-stage JSON
is omitted; its raw observations, analysis script and compact group summary
are preserved so it can be regenerated.

Discarded is true for the combined source because the copy/stage ABSSBA has
124 global swap-in pages in its first A arm and the decoder is not retained.
This does not mark every constituent protocol ineligible: the actual stat
observation, cached kernel probe, full decoder ABCCBA and subsequent fixed-work
ABBA all pass their own guards. Keep these verdicts separate.

The first copy control uses 15 GB, 4,062 actual slots, two rounds of the frozen
111-pass continuation and symmetric copy/read/named-stage observers. A/B use
one padded executable; only B enables aligned direct reads. Splash matches
capacity. Native full logits match v68. All named pipeline assignments resolve.
Prior complete-request rejection of direct reads remains authoritative.

The stat observer is checked before model use: 82 successful calls across five
threads preserve file-size changes; a failing descriptor preserves EBADF. Its
bounded numeric array records original syscall intervals and writes at exit.
The actual model trace uses original v68 runtime plus v4 CLI, 15 GB, 4,067 slots
and two rounds. All full native logits match the reference. The separate
metadata-only probe makes no weight reads and is not inference timing.

The cached expert probe compares extracted production native kernels, a
Q2-only adjacent-pair decoder and pinned Splash kernels. Same original generated
compressed values, BF16 inputs, dimensions and live rows are independently
packed for each layout. It covers gate/up and down, 10/30/60 expert tiles and
1/2/3/8 active rows, with alternating ABC/CBA order, two warmup rounds and eight
measured rounds. All active outputs match exactly, including Splash.

The candidate native q2-experts-check passes, including independent raw-byte
oracles, Fast affine arithmetic and ownership boundaries. A real frozen
continuation then reproduces 222 full v68 logit hashes exactly. The production
candidate changes only Q2 decoding; the diagnostic CLI is frozen separately.

Trace-disabled complete requests use ABCCBA, 15 GB, 4,067 slots and 8,192 context.
Every process gets two warmups and the frozen 384-token code/prose requests.
Automatic drafting remains enabled. All six arms complete and pass paging,
thermal, competing-build, actual footprint, token-count and prefix-reuse gates.
The keep and parity gates fail. The candidate is reverted.

A subsequent attribution-only ABBA fixes all 111 verification inputs, widths,
precision and logical cache work. It has no injected observers. All four arms
are clean; all 888 full logits match v68 and each measured round has 45,109
logical misses. It cannot cancel the prior complete-request failure.

Final restoration verifies all 509 runtime inputs and five default artifacts
against v68. Fast and app selection remain unchanged. Fixed-length throughput
requests are not complete semantic quality jobs; existing Fast recall and
Q2 Python-only formatting failures remain open.
