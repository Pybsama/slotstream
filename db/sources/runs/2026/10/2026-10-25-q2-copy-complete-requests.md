---
type: run
id: 01m5sycary6yv2bbq3m9ecfna2
created: 2026-10-25T16:30:26.590699+00:00
updated: 2026-10-25T16:30:53.651018+00:00
summary: Q2 copy candidates fail clean complete-request retention
binary: v68 plus diagnostic candidate and Splash identities in the archive
captured_at: 2026-10-25
command: Frozen protocols and exact commands in the q2-frozen-sequence archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 copy candidates fail clean complete-request retention
tool: Swift/MLX/Metal and bounded Splash diagnostics
---
The [raw archive](q2-frozen-sequence-2026-10-25.tar.gz) contains 797 files,
52891637 bytes, SHA-256 `b74f4fbdeca0cf68cea1bbdfa55e1070091a1a2015524e88e201c9507319f2a9`. Every member passed hash readback.
Scripts, inputs, rejected patches, diagnostic source, commands, binary identities,
guards and failures are preserved. Model weights and executables are identified,
not embedded. Original Splash source excerpts and its license are included.

Two separate six-arm ABCCBA protocols compare frozen v68, one native candidate
and original published Splash 1.4.0. Each process runs two warmups followed by
384-token code and prose requests, with identical prompt IDs, ordinary adaptive
verification, read-ahead and no reused prefix. A has 4,067 cache slots; charged
candidate B and Splash C match at 4,062. All have 15 GB total process ceilings,
8,192-token context, BF16 activation/KV and FP32 state. All twelve arms pass the
no-paging, nominal-thermal, no-competing-build, headroom and physical-memory gates.

The combined aligned demand/forecast candidate improves prose by 5.0% but
regresses code by 5.7%. The demand-only candidate improves code by 0.87% and
prose by 0.63%, below the predeclared 2% retention gate. Its request medians
remain 7.4% behind Splash for code and 3.8% for prose. Full values, every arm,
work counters and analyses are in padded-complete-15* and demand-complete-15*.
The original retention wording was clarified before any timed request result:
retaining a meaningful intermediate win is separate from achieving the 5%
Splash target. Neither candidate passes retention or both-task parity.

Four frozen ordinary-decoding tasks separately compare v68 with the demand-only
candidate through the production tokenizer, sampler, stream and tool parser.
Exact prompt IDs, output tokens/text, streamed text and parsed tool calls match.
All have successful stop terminals inside 15 GB. See demand-quality-summary.json
and demand-quality-manual-review.json for actual per-task outcomes and limits.
This is a narrow regression control, not application execution, broad quality
qualification or negligible Q2-versus-four-bit degradation evidence. Truncated
throughput answers remain unsuitable as task-quality passes.
