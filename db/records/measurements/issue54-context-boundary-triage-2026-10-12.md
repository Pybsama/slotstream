---
type: measurement
id: 01m4rf8cd80hzfsn004qpz0ke7
created: 2026-10-12T16:31:12.296100+00:00
updated: 2026-10-12T16:31:12.296100+00:00
summary: The 32k report remains unconfirmed as a keepalive bug; a bounded attention probe finds only a small boundary step on the M5 Pro
date: 2026-10-12
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1740'
runs: '[[sources/runs/2026/10/2026-10-12-issue54-attention-triage]]'
title: Issue 54 context-boundary triage during keepalive removal
status: measured
---
**Scope.** [Issue #54](https://github.com/carloslfu/slotstream/issues/54) reports a sharp decode slowdown above 32,768 active tokens on an M4 Pro 48 GB, version 0.2.27, with MTP off. Changing the configured window, expert-cache size and adaptive memory did not remove the reported boundary. It has no keepalive-off comparison. Carlos had already suggested a possible relationship to #55; that possibility is not confirmation.

**Source inspection.** The pinned MLX 0.32.2 `scaled_dot_product_attention.cpp` increases the two-pass vector attention partition count from 256 to 512 beyond 32,768 keys in its `s` architecture branch when `n_simds > 4`. The model's ordinary one-row decode has GQA factor 12. This is a plausible boundary to isolate, not a diagnosis. Do not infer applicability from the backend comment labeling `s` as Max: the existing [[records/machines/macbook-pro-m4-pro-24gb]] report identifies an M4 Pro as `applegpu_g16s`, and the current probe identifies the M5 Pro as `applegpu_g17s`. Verify actual runtime architecture and dispatch on the affected machine.

Slotstream's experimental `SelectedAttention` also has a 32,768-key guard, but requires more than eight query rows. It is not the ordinary one-query decode path in this report. Configured context-memory reservations and prefill chunk limits likewise do not establish a per-token decode cliff. Finding the same number in code is not enough; follow the executed path and verify the mechanism.

**Bounded probe.** [[sources/runs/2026/10/2026-10-12-issue54-attention-triage]] preserves a synthetic single-query attention test on the M5 Pro with the production head dimensions. The default median changes from approximately 0.319 to 0.337 ms across 32,768/32,769 keys. Holding the partition count at 256 or 512 removes that small step on this Mac. All outputs were finite and the recorded peak allocation was below 0.3 GB. These live-desktop component timings have no clean-performance qualification, use a synthetic mask, and neither reproduce the reported threefold full-model slowdown nor qualify an override. No product setting changes follow from them.

**Disposition.** Keep #54 open. GPU keepalive removal directly addresses #55's controlled on/off failure, but has not been shown to fix #54. Ask for the same boundary comparison after the removal release, preserving the reporter's MTP-off setting and measuring actual prompt plus output tokens. If it persists, isolate attention dispatch and GPU scheduling on that M4 Pro, retaining complete-request and resource evidence. Do not tell the reporter to adopt an unqualified MLX override or claim the exact root cause is known. Keeping active prompt plus reply within the faster reported range is a temporary workload constraint, not a fix.
