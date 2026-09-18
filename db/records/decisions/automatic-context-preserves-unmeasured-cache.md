---
type: decision
id: 01m2tmkynhfx4ggypkka4065za
created: 2026-09-18T16:11:59.537476+00:00
updated: 2026-09-18T16:11:59.537476+00:00
summary: Automatic context preserves cache whose loss is unmeasured
decided_on: 2026-09-18
evidence: '[[records/measurements/memory-budget-context-policy-2026-09-18]]'
reversible_if: Paired measurements extend the decode cost model to the affected cache sizes, or a separately qualified adaptive cache preserves useful residency while reclaiming capacity safely.
title: Automatic context preserves cache whose loss is unmeasured
status: standing
---
Automatic context selection must not use a clamped speed estimate as evidence that extra expert cache has no value. If a larger window removes any slots from a baseline cache above the measured decode range, auto keeps the baseline window unless another larger candidate preserves those slots. An explicit context window remains authoritative.

This applies to both hardware-tier selection and live startup. Busy startup must also keep the existing request-time tolerance, MTP and lookahead rules. The CLI preserves the selected plan and explains any smaller live window.

The memory allowance is not a RAM utilization target. Report the allocated expert cache separately from the empirical runtime, context, workspace and safety allowances. Retain existing JSON fields for compatibility and add explicit semantics rather than changing a planned envelope into a claimed measurement.

This revises [[records/decisions/automatic-context-window-per-machine]] using [[records/measurements/memory-budget-context-policy-2026-09-18]]. The original default speed curve and automatic base budget remain unchanged. Reclaimable overflow or segmented caches require separate end-to-end timing and pressure tests before becoming a default; unused capacity alone does not establish a benefit.
