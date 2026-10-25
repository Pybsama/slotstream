---
type: run
id: 01m5r766m8rwsjgpmnem1e2kbw
created: 2026-10-25T00:25:54.056625+00:00
updated: 2026-10-25T00:25:54.681440+00:00
summary: Discarded whole 15 GB Q2 baseline/candidate/Splash comparison with both candidate arms paging
binary: Exact v68, candidate and Splash hashes in archived receipts
captured_at: 2026-10-24
command: python3 .build/q2-bottleneck-20261024/run_candidate_protocol_v2.py
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Excluded Q2 focused complete-request protocol
tool: Native Swift/MLX and Splash complete requests
---
The [complete raw protocol](q2-focused-bottleneck-2026-10-24.tar.gz) preserves `complete-q2-15-ledger.json`, all six request receipts, guard logs, frozen cases, source hashes and the summary. It compares unchanged v68, the experimental per-expert repack grid, and Splash in ABCCBA order at 15 GB, with matched context, prompt IDs and actual cache slots.

This aggregate is discarded for speed claims because both candidate arms recorded global swap-ins, 8 and 4 pages, including one candidate warmup. No clean subset replaces it. All requests completed within the physical-memory ceiling and thermal conditions were nominal. Even the unqualified diagnostic result fails the frozen benefit gate: geometric request-time ratio 0.99887, code slower and prose faster. The patch is reverted, with no repeat seeking a passing aggregate. This does not establish that repacking caused paging, or that the change is faster or slower in general.

The surrounding controlled diagnostic evidence and exact restoration are described in [[sources/runs/2026/10/2026-10-24-q2-focused-bottleneck]].
