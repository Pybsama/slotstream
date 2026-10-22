---
type: run
id: 01m5gv899tvggnn4k32nfjnw3b
created: 2026-10-22T03:42:38.394204+00:00
updated: 2026-10-22T03:43:12.591614+00:00
summary: Retained timing exclusions, thermal interruption and real-headroom refusals
binary: Native 29024b72d6877becb94c59a1f3bda8f8d165b3f28af58202ea412c55aaad01b7; Splash 20b36bcc051145b425403dee7489d06cdbb5060460dfdb2e0cfc8d49cebfc29f
captured_at: 2026-10-21
command: Preserved harnesses, commands and protocol amendments in the immutable archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Exact Q2 timing exclusions and refused controls
tool: Native Slotstream CLI and isolated Splash 1.4.0
---
# Exact Q2 timing exclusions

Timing-only exclusions in the [immutable archive](exact-q2-tradeoff-2026-10-21.tar.gz)
are listed in `timing-exclusions.json` and `timing-summary-v2.json`. They include
non-nominal thermal boundaries, global paging, unrelated compilation during the
native DFlash diagnostic and the later explicitly functional controls. These
observations cannot support a clean benchmark median. Their completed answers
and bounded process footprints remain valid functional evidence.

The first paired campaign is interrupted after thermal state is noticed; its
partial log and explanation remain. The first production follow-up is refused
for real headroom. The second campaign is interrupted during its thermal wait,
with no model running, before continuing under the separate functional protocol.
The late native sixteen-GB control is refused before launch because another
build has restarted and available memory is below its required headroom. The
planned twenty-GB Q2 extension is not admitted by the recorded resource snapshot.
No blocked or interrupted check is reported as a passed performance result.

The archive digest and exact identities are registered in
[[sources/runs/2026/10/2026-10-21-exact-q2-tradeoff]]. The earlier raw sources and
frozen verdicts are preserved. This record's discarded flag applies to timing
claims from these intervals, not to all functional results in the shared archive.
