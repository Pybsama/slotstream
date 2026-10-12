---
type: run
id: 01m4ra0s2wgwhe53qt60gvtvx4
created: 2026-10-12T14:59:40.252505+00:00
updated: 2026-10-12T15:00:55.596342+00:00
summary: 'Initial real-model comparison: preserve refusals and paging-contaminated pairs; no clean timing claim'
binary: Installed slotstream 0.2.27 sha256 fad3a30a1bcabec74d64690ddc538c8553026168d71094a97d31346bedf2eae4
captured_at: 2026-10-12
command: python3 model_compare.py model; python3 model_compare.py model-2; python3 model_compare.py model-3
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Issue 55: initial model comparisons excluded from clean timing'
tool: slotstream 0.2.27 and captured model_compare.py
---
Raw files are in [capture.tar.gz](../../../artifacts/issue55-keepalive-2026-10-12/capture.tar.gz), SHA-256 `6fe22ba3da79a33f0d3c311d0440722a118f7ad129e052eb065a1d98bc7c2891`.

`model/` refused the external preflight, and `model-2/` expired its bounded
headroom wait. Neither loaded a model. `model-3/` attempted twelve launches:
seven completed and five were refused by the engine's memory admission. Four
individual completed runs had no paging, but none of the three completed pairs
was free of paging in both arms. Those three pairs kept identical output IDs
and effective configurations. Do not use them for a clean timing claim.

Every cell's command, environment policy, preflight, host observations, sampled
thermal state, raw stdout/stderr, metrics and exclusion are retained. The
per-cell `result.json` is authoritative; driver exit success does not mean all
cells passed. No safety check was bypassed. `model-3/model_compare.py` matches
its manifest's source hash.
