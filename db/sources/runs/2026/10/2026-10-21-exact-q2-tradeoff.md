---
type: run
id: 01m5gv89857kb3zcvd3jmtdt15
created: 2026-10-22T03:42:38.341092+00:00
updated: 2026-10-22T03:43:11.713113+00:00
summary: Exact Q2 recipe, production controls, cache scaling and bounded quality receipts
binary: Native 29024b72d6877becb94c59a1f3bda8f8d165b3f28af58202ea412c55aaad01b7; Splash 20b36bcc051145b425403dee7489d06cdbb5060460dfdb2e0cfc8d49cebfc29f
captured_at: 2026-10-21
command: Preserved harnesses, commands and protocol amendments in the immutable archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Exact Q2 performance and quality follow-up receipts
tool: Native Slotstream CLI and isolated Splash 1.4.0
---
# Exact Q2 performance and quality follow-up

The immutable [artifact archive](exact-q2-tradeoff-2026-10-21.tar.gz) contains
139 payload files plus a per-file size/SHA-256 manifest. Its archive SHA-256 is
`46e402acd9ea644e0aaa64cc02d7aa037a53716358bf975724c7e6ede59aa016`. Every payload was independently read back and checked after packing.

The archive preserves frozen prompts and expected results, original and repaired
bounded graders, all raw outputs and stream events, process memory observations,
thermal/paging diagnostics, startup/configuration status, interrupted campaigns,
real-headroom refusals, source identities and pinned upstream references. No
weights, credentials or user conversation content are included. The synthetic
cases and performance prompts were saved before their model generations.

`final-audit.json` verifies sixteen complete run receipts containing 106 requests,
all process-memory guards and four correct long-retrieval results. It binds the
unchanged native executable. `quality-summary-final.json` keeps semantic and
strict results separate. `prior-semantic-correction.json` references the hashes
of the earlier outputs and consistently distinguishes JSON fencing from wrong
values; the historical frozen scores remain unchanged.

`protocol.md` and `protocol-clarifications.md` define the original experiment and
its clarified limits. `followup-protocol.md` adds normal production CLI controls.
`functional-followup-protocol.md` explicitly excludes remaining controls from
clean timing after unrelated builds restart; no memory requirement is weakened.
`native16-functional-protocol.md` and its refusal log preserve the final larger
control attempt, which never allocates a model.

`timing-summary-v2.json` separates eligible intervals from exclusions; do not use
the older preliminary summary to override those exclusions. Only one complete
later native-MTP/Q2 coding pair is eligible in both halves. The normal ten-GB CLI
coding control is a separate single request with automatic settings. Native
process targets and Splash Metal limits are different contracts; physical peaks
are retained. Memory budgets do not represent physical hardware tests: every request runs
on the owned 48 GB Mac.

`production-control-interpretation.md` explains why demand-read bytes do not
include issued read-ahead traffic. `harness-dependencies.json` identifies the
copied bounded-worker and memory-guard source dependencies. The original source
archive, initial Q2 download verification and native DFlash reference proof remain
in [[sources/runs/2026/10/2026-10-21-smart-dflash-review]]. The current study does
not alter that archive, import the upstream runtime into the product or publish
a release.

Ineligible timing and refused/incomplete attempts are separately registered in
[[sources/runs/2026/10/2026-10-21-exact-q2-timing-exclusions]].
