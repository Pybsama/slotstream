---
type: run
id: 01m5rbbysbs87fw55tncvkbn4t
created: 2026-10-25T01:38:56.939361+00:00
updated: 2026-10-25T01:38:57.551946+00:00
summary: Preserve complete excluded candidate replay after final baseline paging
binary: Frozen v68, diagnostic, direct-read candidate and Splash hashes in archive manifests
captured_at: 2026-10-25
command: python3 .build/q2-typical-20261025/run_copy_replay.py
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Excluded Q2 direct-read component replay
tool: Swift/MLX/Metal and isolated Splash instrumentation
---
The [raw archive](q2-typical-verification-2026-10-25.tar.gz) contains 278 files, 47337530 bytes, SHA-256 `db93f4d22280a7d590e7f459773b8498d746af7eba5dd0e83da14fa7deda52bf`. Every archived member passed readback verification. Four unique full-logit byte streams and a hash map preserve repeated outputs without duplicate storage.

The four-row, 393-miss candidate replay uses A = baseline and B = direct forecast reads in ABBA order at 15 GB. The last baseline arm records global paging. The entire aggregate is excluded from qualified timing claims, even though the other arms are clean and functional checks pass. No favorable subset or retry replaces this protocol.

All fixed-work native logits remain byte-identical to baseline. The component diagnostic results show no benefit, but the candidate verdict rests on the separately clean six-arm complete-request comparison, not this excluded aggregate. All run logs and `copy-plan.json`, `copy-ledger.json` and `copy-summary.json` remain in the archive. The patch is preserved and reverted.
