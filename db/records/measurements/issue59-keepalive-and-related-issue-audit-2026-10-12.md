---
type: measurement
id: 01m4skfa94ehs1j4de2drvdz6d
created: 2026-10-13T03:04:08.228567+00:00
updated: 2026-10-13T03:41:31.518594+00:00
summary: M1 Max keepalive report and complete issue audit; preserve confounds and keep issue 54 separate
date: 2026-10-12
doc: measurements
level: '2'
machines: '[[records/machines/mac-studio-m1-max-32gb-issue59]]'
note: v0.2.29 is accepted; issues 55 and 59 received release follow-ups and were closed. Issue 54 remains open. See the published release measurement for receipts.
order: '1760'
runs: '[[sources/runs/2026/10/2026-10-12-release-0-2-29-published-and-installed]]'
title: M1 Max keepalive report and related-issue audit
status: analysis
---
The issue audit found a second current report of severe stalls with the GPU keepalive default: [#59](https://github.com/carloslfu/slotstream/issues/59), from `@dittsn` on a Mac Studio M1 Max with 32 GB, Slotstream 0.2.28 and weights on its internal SSD. The raw report is [[sources/community/2026/10/2026-10-12-issue59-keepalive]]. It supports removing the feature across machines, as already decided in [[records/decisions/remove-gpu-keepalive]].

The reporter gives 0.94 tok/s by default and 6.23 tok/s with keepalive disabled, with the same printed text. Disabling MTP, then MTP plus lookahead, did not recover throughput while keepalive remained enabled. Three warm server requests with keepalive off reportedly reached 6.00, 6.10 and 6.09 tok/s.

These are not controlled same-plan A/B timings: automatic planning changed between the default and off runs (32,768 versus 65,536 configured context, resident versus streamed draft experts, different target/cache sizes and reclaimable memory). No off-run powermetrics trace was supplied. The trace's stated end time and final printed sample also differ. Preserve those limits instead of treating the observed ratio as an isolated causal effect, power comparison or proven GPU scheduling explanation. No new machine qualification or hardware-table speed claim is made.

The report belongs with #55 for release handling: remove the submitted artificial GPU work, communicate the existing off workaround, then follow up and close after the accepted removal release. The reporter's supplied output already identifies a working path. No further profiling is required to justify removing an unreliable feature.

The audit covered all 20 issues returned by GitHub, open and closed, including their comments. Only #55 and #59 explicitly report the keepalive-on/off failure pattern. #54 remains a separate active-context-boundary report with no keepalive-off comparison; [[records/measurements/issue54-context-boundary-triage-2026-10-12]] preserves its analysis. Historical #21 describes long-prefill, streaming and process-exit problems addressed by earlier releases, without evidence connecting them to keepalive; its regression suite remains in release acceptance. The hardware measurement threads and open smaller-format request #7 do not establish additional duplicates. Do not reopen or close unrelated issues based on symptom words alone.
