---
type: measurement
id: 01m5wr3f43amndvbsqce86h3q1
created: 2026-10-26T18:38:27.971419+00:00
updated: 2026-10-26T18:40:02.491065+00:00
summary: One maintained model, preserved experiments, passing local engine/app checks and bounded real workflows
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1930'
runs: '[[sources/runs/2026/10/2026-10-26-single-model-maintenance]]'
title: 'One maintained model: archive and verification'
status: measured
---
The app and engine now maintain Qwen3.8-Flash-Next 4-bit only. Fast, exact Q2,
Smart DFlash and their dedicated execution paths are archived at
`archive-fast-q2-2026-10-26`. The source, tests and licenses of every removed
path remain readable at that fixed revision. See
[[records/decisions/one-maintained-model]] and the
[archive index](../../../experiments/fast-q2/README.md).

## What was checked

The implementation is `793bd0534e2a0afab8c16ae5aa41a3ba33c5bc88`, followed by
settings copy and migration UI coverage at
`3bfc81efb7aea84638dd1a282e328140feb7441f`. Engine sources, package inputs and
license notices match v0.2.30 apart from the maintained model's display title.
Its original checkpoint, MTP, expert lookahead and released interfaces remain.

The release-mode engine build and all 106 T0/T1 checks pass, with 41,301
assertions. CLI selection resolves Automatic and the original explicit pack;
retired Fast and Q2 IDs are refused. All 228 deleted paths were read back from
the archive revision and hashed.

The complete local Mac app suite passes. This includes Home data integration,
MCP, literal JSON storage, context/privacy, activation recovery, memory
preferences and the production views in Light, Dark and System appearances.
Migration checks preserve saved memory settings, show the retirement notice
and keep historical activation identities unchanged. The rebuilt development
bundle passes ad hoc signature verification and its embedded input manifest
matches the final engine and app sources. This is not installer qualification.

Three real-model jobs run sequentially in a fresh disposable Home on the
48 GB M5 Pro, with a 10 GB memory ceiling. All verify the actual original pack,
startup recipe and applied ceiling:

- CSV: the table tool selects paid rows and computes the exact 67.34 total.
- Code edit: the proposed off-by-one fix preserves the function and docstring;
  the file stays unchanged before review and approval applies the exact edit.
- Recall: the answer recovers ORCHARD-9157 from permitted earlier conversation
  evidence beyond the recent-message window.

These are bounded functional checks. The code answer uses more than the
requested one sentence. The recall answer includes an S1 marker without a
source-excerpt entry in the captured job, so this run does not close the
previously recorded citation-quality limitation. Full answers, traces and
failures remain inspectable; no new quality or speed claim follows from these
three jobs. Other physical memory sizes and a public app installer were not
tested. The model process exits and releases its lock after the checks.

An earlier local app run completed its functional suites but failed the final
build-freshness check because settings copy changed during the run. That log
is preserved separately. The complete suite was then rerun against stable
sources and passed, followed by an explicit successful freshness check. No
assertion or acceptance threshold was relaxed.

README, model and app guides, CLI/test documentation, generated projections,
agent instructions and the live repository description reflect one maintained
model. The published release remains v0.2.30. This work creates no release.

The complete local static safety suite also passes, including download, planner,
memory-override and installer checks. Raw outputs and identities are in
[[sources/runs/2026/10/2026-10-26-single-model-maintenance]]. Hosted engine and
app CI were still running at capture; documentation and context-proxy CI had
passed. Their live runs remain separate from the local functional results.

The static suite completed with `STATIC GATES PASS`. Afterwards, the outer
zsh capture script failed because it assigned to the reserved `status`
variable. Its status receipt keeps that capture-script error separate from
the completed suite. No check was rerun or softened.
