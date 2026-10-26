---
type: decision
id: 01m5n0gft2t7mwd01ktdaa27k5
created: 2026-10-23T18:31:27.810751+00:00
updated: 2026-10-26T18:09:26.157552+00:00
summary: Keep measured bounded Q2 input read-ahead, reject its Fast default and buffer reuse, and require actual app recipe and branch evidence
decided_on: 2026-10-23
evidence: '[[records/measurements/native-fast-q2-scheduling]]'
reversible_if: Complete-request, hardware or resource evidence shows a regression or a simpler schedule performs better
title: Native input read-ahead
status: reversed
---
**Archived October 26, 2026.** [[records/decisions/one-maintained-model]] supersedes the active model choices and continuation instructions below. Preserve this dated decision and its evidence as experiment history.

# Native input read-ahead

Use bounded next-input expert read-ahead in the explicit Q2 candidate's native
engine and app startup recipe. Keep Fast's production recipe without it. The
clean equal-capacity experiments in
[[records/measurements/native-fast-q2-scheduling]] support the Q2 change and
reject enabling the same scheduling in Fast. The extra persistent-buffer pool
is also rejected and removed. Keep its source and results as evidence.

This is not permission to promote Q2 to Smart. Fast remains the new-install
default, Smart retains the original target/MTP policy, and existing choices
remain explicit. There is no new user-facing tuning control, task router,
Splash subprocess, GPU spin or power-state mechanism.

The Q2 recipe owns its complete staging charge, actual cache capacity,
readers and request lifecycle. Predictions only arrange reads; actual target
routing decides every expert and demand chooses every cache victim. Wrong
predictions cannot evict useful experts. The memory and startup identities
change with the recipe, and app tests verify the actual loaded identity.

Native Swift/MLX is an implementation choice, not independent evidence of
better speed. Compare complete requests under matched actual resources and
retain adverse outcomes. Test model-specific forward branches with counters
that prove the intended path ran. A faster model can have less time to hide
read-ahead work, so a benefit on one target is not a generic default for all
targets. Retain simple reductions in real work only when their full-request
tradeoffs justify them.

Reverse or revise the recipe if complete jobs regress, different physical
hardware disproves the benefit, its memory or SSD cost exceeds useful overlap,
or a simpler measured schedule does better. The available Mac and simulated
planning do not establish physical qualification across the whole target
range. Final comparisons affected by paging or heat do not establish parity
with Splash, and a small unchanged quality suite does not establish negligible
quantization loss.
