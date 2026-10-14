---
type: run
id: 01m4xfqjs5vzcq7fphg3fyr6p0
created: 2026-10-14T15:15:42.501429+00:00
updated: 2026-10-14T15:15:55.778685+00:00
summary: Six full-model requests complete without the reported 32k cliff on M5 across deployment, portable and automatic lookahead configurations; one interrupted prefill preserved
binary: Public v0.2.29 SHA256 4d7d4ed4d2a19b5991d47f4731198932cd616e5c2722fcf8b6e37612c232f051
captured_at: 2026-10-14
command: Exact commands, environments and protocols are preserved in capture.tar.gz
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Issue 54 full-model boundary reproduction evidence
tool: Exact public CLI, templated HTTP generation, guarded Python driver and source audit
---
Raw full-model follow-up for [issue #54](https://github.com/carloslfu/slotstream/issues/54). The capture contains the exact public-release drivers and protocol hashes, request/response JSON, all output and prompt IDs, inter-token intervals, server logs, operating conditions and memory observations, original and portable-path settings, automatic lookahead planning and execution evidence, the interrupted attempt and guarded retry, release source excerpts, backend pin comparison, model header/metadata and correction-file identities, token-count validation, and the issue discussion before/after the follow-up reply.

The public v0.2.29 executable is SHA-256 `4d7d4ed4d2a19b5991d47f4731198932cd616e5c2722fcf8b6e37612c232f051`, from release source `5728fc2d64d7d918f1c16c3f45538d6fd2b9e900`. Both compared release tags pin mlx-swift `ab924c82ead3b970caaa1c0ac11171de23f0305a`. No new inference binary was built or installed.

All workloads use the original local Flash-Next checkpoint and the reporter's repeated German prompt through templated `/api/generate`, temperature zero, think true, stream false, 500 requested tokens, MTP/vision off and 256-token prefill. Two prompts contain exactly 32,320 and 32,770 rendered tokens. Separate processes cover local deployment at 640 slots, portable M4-default rotation/prefill branches at 640 slots, and those portable branches with the real automatic corrected lookahead at 960 slots. The first two use a 9 GB target and a 36,864-token maximum; the lookahead process pins 2.654208 GB of expert storage, disables prefix retention and uses a 33,792-token maximum. Its expected full-workload envelope is 9,650,156,800 bytes, with a 12.66 GB launch preflight. The other launch preflight is 12 GB.

The initial lookahead process was manually stopped on an observed OS warning while still reading the prompt. It never reached decode, and is not a reproduced cliff. A later retry uses a two-second OS-pressure/physical-footprint monitor, as does the intervening smaller portable run. Every attempt and stop remains in the capture. Prepared unexecuted scripts are also preserved and are not counted as runs.

`discarded: true` excludes this live-desktop timing cohort from clean performance qualification. Global paging and fair thermal states are recorded. Completion, count, memory and selected-path assertions remain functional evidence. This is M5 hardware with bounded caches, not the reporter's M4/large-pool profile, an independent model-quality oracle, or proof of a release fix. Metadata/header identity is distinguished from the earlier complete checkpoint payload verification, which was not rerun here.

[capture.tar.gz](../../../artifacts/issue54-full-model-2026-10-14/capture.tar.gz) is 350143 bytes, SHA-256 `d9d713bfc648e2d70224ad198f3bcba2189db28e8bb5f8ad46b38f313744dbd0`. All 96 inventoried members match their byte counts and hashes; the archive contains 97 members including the inventory.

Verification passes for six completed requests, 3,000 generated tokens, exact rendered prompt counts, 499 ordinary forward passes per request, expected runtime settings, finite positive token intervals, process-memory bounds, automatic lookahead activity in its selected arm, unchanged helper/binary identities and cleanup. The two portable configurations return identical output IDs for each matched prompt. Default fused-prefill and portable outputs differ, so no cross-arithmetic equivalence claim is made.

The posted [issue follow-up](https://github.com/carloslfu/slotstream/issues/54#issuecomment-6171643768) was checked against the submitted body. Issue state remains open.
