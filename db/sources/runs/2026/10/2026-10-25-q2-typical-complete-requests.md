---
type: run
id: 01m5rbby4bvkky0j707kaa7thv
created: 2026-10-25T01:38:56.267827+00:00
updated: 2026-10-25T01:39:50.106433+00:00
summary: Clean 15 GB baseline, direct-read candidate and Splash complete-request comparison
binary: Frozen v68, diagnostic, direct-read candidate and Splash hashes in archive manifests
captured_at: 2026-10-25
command: python3 .build/q2-typical-20261025/complete_requests.py --label complete-q2-15 --native .build/q2-typical-20261025/candidate-build/candidate/slotstream --baseline .build/native-replay-20261023/v68/slotstream --order ABCCBA --budget 15 --cases .build/native-replay-20261023/short-warm-384-cases.json --context 8192 --ahead on --model smart-q2 --schedule 1
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Clean Q2 complete requests reject direct forecast reads
tool: Swift/MLX/Metal and isolated Splash instrumentation
---
The [raw archive](q2-typical-verification-2026-10-25.tar.gz) contains 278 files, 47337530 bytes, SHA-256 `db93f4d22280a7d590e7f459773b8498d746af7eba5dd0e83da14fa7deda52bf`. Every archived member passed readback verification. Four unique full-logit byte streams and a hash map preserve repeated outputs without duplicate storage.

The production ABCCBA uses A = frozen native v68, B = the 11-line exact forecast direct-read candidate and C = Splash 1.4.0 without host spin. All six arms pass the 15 GB physical ceiling, headroom, no-paging and nominal-thermal gates. Each process runs two warmups and timed code/prose requests of 384 output tokens, matching prompt IDs, 8,192-token context, precision and 4,067 actual expert slots. Normal adaptive verification and read-ahead remain enabled. Exact commands, source/binary identities, outputs and guards are preserved in the archive's complete-request files and `external-guards/`.

The candidate makes geometric mean complete-request time about 3.27% slower than baseline, with both tasks slower. It fails the frozen minimum 2% improvement and no-task-regression requirement and is reverted. The baseline takes about 10.8% longer than Splash for code and 5.8% longer for prose in this clean matched protocol. No repeat or favorable subset replaces the protocol. This establishes the comparison at 15 GB on this Mac only.

Adaptive outputs vary even between unchanged baseline arms. The length-limited throughput outputs are not full task-quality passes: code truncates and the prose examples do not establish correct write-skew reasoning. Relevant original-byte and full-state correctness checks pass separately, but neither those nor throughput completion establishes negligible Q2 quality loss or full app readiness. Fast remains unchanged.
