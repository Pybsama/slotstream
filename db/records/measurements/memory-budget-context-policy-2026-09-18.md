---
type: measurement
id: 01m2tmg5t1yqhsmbq9s63cetr8
created: 2026-09-18T16:09:55.777897+00:00
updated: 2026-09-18T17:09:36.034135+00:00
summary: 'Memory budget: preserve expert cache when context cost is unmeasured'
date: 2026-09-18
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1580'
runs: '[[sources/runs/2026/09/2026-09-18-memory-budget-regression]], [[sources/runs/2026/09/2026-09-18-memory-budget-software-verification]], [[sources/runs/2026/09/2026-09-18-memory-budget-native-verification]], [[sources/runs/2026/09/2026-09-18-memory-budget-final-reporting]]'
title: 'Memory budget: preserve expert cache when context cost is unmeasured'
status: measured
---
The automatic context selector used a speed estimate that is deliberately flat above the last measured cache anchor. Comparing two such plans treated removing useful expert slots as having no cost. A fixed process budget could therefore become reservations for a much longer context while a short request used far less memory.

Automatic selection now declines any candidate that removes slots from a baseline cache above the measured decode range. It applies the same rule and request-time tolerance to live startup, including busy machines. A rejected candidate explains the cache tradeoff and omits a numeric relative request cost when that cost is unmeasured. Explicit context choices remain available.

The memory flag remains a total process planning budget. The expert pool is allocated; runtime, conversation state and workspace allowances are not all materialized at startup. The banner and JSON distinguish those meanings. A lower measured footprint alone is not an error and is not a reason to fill RAM.

This correction preserves the existing pool, conversation retention, allocation guards and allocator-cache limit. A reclaimable overflow cache is a separate optimization: copying evicted GPU slots would introduce synchronization on the miss path, while retaining incoming records duplicates the main cache. Neither is enabled without evidence that it improves end-to-end work within the same memory allowance. The correction does not claim that a static plan borrows unused context reservations.

Evidence: [[sources/runs/2026/09/2026-09-18-memory-budget-regression]]. The new checks fail against the original policy and pass against the corrected production source. The CLI tests include an explicit memory budget with automatic context, which the older override matrix did not cover.

## Compiled software verification
The first frozen allocation-fix CLI passes 319 memory-override cases, 90 planner checks and 130 context CLI assertions. The catalogue passes 63 groups, including 74 assertions for the new memory-budget regression. All completed static components pass after correcting the stale busy-start assertion. The production-source context policy passes; full evidence and the earlier fixture corrections are preserved in [[sources/runs/2026/09/2026-09-18-memory-budget-software-verification]]. The representative simulated 64 GB machine with a 48 GB budget and MTP enabled keeps approximately 33.1 GB of expert cache, compared with approximately 15.7 GB under the old automatic 262,144-token selection. It now chooses 32,768 tokens automatically; larger explicit windows remain available. This is allocation evidence, not a measured throughput improvement or native qualification of the full 48 GB target.
## Native verification
The full native battery on the frozen allocation-fix build completed with 26 top-level gates passed and one failed. Passing gates cover pinned weight hashes, reference parity, identical outputs across memory targets, pool resizing, live governor shrink/regrowth, prefix reuse and exactness, the prefill sweep, speculative decoding and image memory, short- and long-request process memory, long-context recall, API behavior and image numerical parity.

The image-serving suite passed 24 checks and failed one assertion about reusing image state on a follow-up. The same 24 passes and the same failure reproduce on the frozen pre-change checkout. Both snapshots include the separate conversation-resume work that was already present before this task. This correction does not change that code or relax the assertion. The failure remains open; the complete battery is not all green.

The 10 GB short request peaked at 6.216 GB. The 7,972-token long request peaked at 8.094 GB and answered SEVENTEEN correctly. The separately authorized 12 GB image/MTP check peaked at 10.507 GB. These are process-memory and functional results on the development 48 GB Mac. Global paging is retained as a diagnostic, and these runs make no throughput claim. They do not qualify a native 48 GB allocation or a 64 GB Mac.

Exact output and both frozen identities are in [[sources/runs/2026/09/2026-09-18-memory-budget-native-verification]]. This native run precedes the final headroom-report and help wording corrections. Those changes only expose the existing budget residual and clarify text; they do not alter allocation or generation. The final reporting checks are recorded separately below.

## Final reporting verification
The final report shows planned expert cache at load, non-cache allowances and remaining budget separately. Near the minimum cache size, the planner can consume part of its nominal margin, so the report now calculates headroom from the existing ledger instead of displaying the full nominal margin. An unbudgeted raw pool does not invent total-process headroom.

The reporting build passes 319 memory-override cases, 90 planner checks, 130 context CLI assertions and 964,237 production-source policy assertions. Its 48 T0 groups pass 28,623 assertions, including 85 in the memory-budget regression. The delivered build has the identical allocation and reporting sources; only two CLI help wording corrections differ. Exact archived-source comparison, a repeated T0 catalogue and context CLI suite, and direct human/JSON UX checks pass on that delivered binary.

Evidence: [[sources/runs/2026/09/2026-09-18-memory-budget-final-reporting]]. These results supplement the earlier full native run; they do not reclassify its known image-reuse failure as a pass. The final source and binary remain local and are not a published release.
