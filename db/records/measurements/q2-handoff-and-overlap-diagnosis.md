---
type: measurement
id: 01m5smsb6dryjjxjc8gqa0p2g4
created: 2026-10-25T13:42:47.245918+00:00
updated: 2026-10-25T13:44:46.664243+00:00
summary: Q2 remains slower; readiness, read-work and bounded scheduling controls reject unearned complexity
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1892'
runs: '[[sources/runs/2026/10/2026-10-25-q2-handoff-diagnostics]] [[sources/runs/2026/10/2026-10-25-q2-handoff-excluded]] [[sources/runs/2026/10/2026-10-25-q2-handoff-complete-requests]]'
title: Q2 handoff and overlap diagnosis
status: measured
---
Q2 still misses the requested complete-request speed target. This study retains
no production change and leaves Fast unchanged. It narrows several hypotheses
without establishing the remaining cause: extra command buffers, event wake-up,
thread priority, residency requests and forecast copies do not yet justify a
new production path. Native language and MLX are not evidence of superiority.

The raw scripts, captured fixtures, source and binary identities, guards,
timestamps, failures, rejected patches and restoration proof are preserved in
[[sources/runs/2026/10/2026-10-25-q2-handoff-diagnostics]]. Excluded protocols are
registered separately in [[sources/runs/2026/10/2026-10-25-q2-handoff-excluded]].
The new clean complete-request comparison is
[[sources/runs/2026/10/2026-10-25-q2-handoff-complete-requests]]. This follows
[[records/measurements/q2-typical-verification]].

## Work, controls and instrumentation

The main component fixture is the captured four-row code verification at
position 317, with 393 common logical missing experts across 48 layers. Both
engines use a 15 GB budget, 4,067 actual slots, 8,192-token context, BF16
activation/KV and FP32 recurrent state. Each condition has two warmups and
three timed passes. Native full FP32 logits preserve SHA-256
`c6cc487735173af3198566071fbc3a2016f3e970a1f576523f046386cea94d22` in the completed
fixed-work candidate protocols. Cross-engine prefix arithmetic and some routes
remain slightly different, as recorded in the preceding study.

The first observer records readiness publication, event waits, encoder creation
and command timestamps. A second interposes the same pread boundary in both
engines, using bounded preallocated records. The stage observer attaches
public Metal timestamp counters to existing compute encoders, preserving their
dispatch type. It does not add GPU work, commits or waits. These are diagnostic
instruments, not production builds or uninstrumented speed claims.

This M5 Pro exposes stage-boundary timestamp sampling but no public per-dispatch
or utilization counters. The first oversized sample-buffer probe fails; the
corrected implementation uses bounded 32 KB buffers and passes original-byte
expert checks with Metal validation. Recorded stage intervals fit their parent
command intervals; measured passes have complete samples. GPU intervals can
still include scheduling or memory stalls. They are not ALU utilization, and
CPU waiting alone does not prove an idle GPU.

A global model reservation now spans each whole protocol, including cooldowns;
children use a private lock beneath that reservation. Later guards also record
competing compiler processes. Other builds contaminated several earlier arms.
Those complete protocols remain excluded. No other task's processes were
stopped. Clean timing remains separate from arithmetic and physical-memory
acceptance; global paging does not turn a correct functional check into a
product failure.

## Clean readiness and read-work observations

The readiness NSSN shows native and Splash resuming GPU work only after the
CPU publishes readiness. Per-pass resume spans are about 3.70 and 4.04 ms;
route-result pickup totals about 1.99 and 1.88 ms. These scopes overlap work
elsewhere and cannot be added to the request wall time. They do not support
an event-wake rewrite as the main fix.

A separate clean, symmetric pread observation gives the following average of
process medians, in milliseconds. Read/GPU overlap is counted once in wall time.

| Condition | Native wall | Splash wall | Native GPU intervals | Splash GPU intervals | Native read union | Splash read union |
|---|---:|---:|---:|---:|---:|---:|
| Cached, read-ahead off | 39.191 | 38.838 | 29.157 | 27.979 | 0 | 0 |
| Partial misses, off | 93.222 | 94.425 | 36.292 | 38.031 | 43.785 | 44.424 |
| Cached, on | 40.093 | 38.453 | 30.450 | 29.461 | 28.179 | 29.103 |
| Partial misses, on | 81.993 | 74.720 | 45.179 | 38.712 | 72.383 | 69.058 |

For partial misses with read-ahead, read/GPU overlap totals about 40.00 ms
native and 35.52 ms Splash. Neither observed interval covers about 4.70 and
2.51 ms respectively. Those uncovered intervals are not automatically wasted
CPU time. Read latency medians are similar, about 187 and 191 microseconds,
and observed bytes are about 797 and 794 MB. Native demand concurrency peaks
below Splash, but native is already slightly faster with read-ahead disabled.
That does not establish that more readers or a unified reader pool fixes the
gap. Both implementations use four background forecast readers.

Additional stage observations locate the extra native duration inside several
compute encoders while read-ahead runs, rather than solely at readiness waits
or a single repack stage. Their whole timing protocols have exclusions, so
these are localization evidence, not a qualified cross-engine speed ratio.
Native host preparation measurements are small relative to the whole pass;
the sparse host profiler does not identify a large preparation term to remove.

## Candidates and rejected explanations

- Delaying expert submission preserves logits but slows clean partial/on
  replay from about 82.47 to 86.72 ms. It is rejected.
- Coalescing expert execution removes command boundaries but the completed
  candidate arm is much slower. The later interrupted protocol is incomplete;
  it is preserved without a qualified aggregate or production adoption.
- Page-padding forecast storage alone is clean and essentially flat:
  partial/on is about 80.65 versus 80.86 ms. The existing charged reserve and
  actual cache capacity remain unchanged.
- Page-aligned direct forecast reads carry payload offsets into the GPU repack
  and avoid the scratch copy. Passive destination observations prove that the
  branch executes, and fixed logits match. Earlier protocols have competing
  builds. After those builds finish, one new BAAB is attempted; its final arm
  has 16 global swap-in pages. The whole protocol is excluded, and even its
  diagnostic aggregate falls short of the preregistered improvement threshold
  while other conditions regress. The seven-file candidate is not retained.
- Forcing serial encoders instead of MLX's concurrent encoders preserves
  tested arithmetic but gives no repeatable material gain; the whole timing
  protocol has an external-build exclusion. It is not retained.
- Requesting MLX residency alone or alongside direct reads gives no repeatable
  benefit in the recorded controls. Their protocols have external-build
  exclusions. A diagnostic cleanup crash was repaired and the bounded check
  passes, but this does not qualify a production residency policy.
- Native command creation predominantly runs at user-initiated QoS, while
  Splash uses user-interactive QoS. Earlier self-priority setters on managed
  Swift threads did not actually change it. An explicit serial-queue diagnostic
  proves that the requested priority applies. Its ABCCBA has paging in the
  first baseline arm and does not support a production priority boost.
- A final clean ABBA disables only optional early attention submission.
  Commands fall from 197 to 149 and compute encoders from 147 to 100, with
  exact logits. Partial/on changes from about 81.97 to 81.77 ms, only about
  0.25%; other controls are effectively flat. Fewer submissions alone do not
  earn this change. The default remains unchanged.

All incomplete, excluded and failed attempts, including cancelled forecast,
arena controls and the stopped invalid priority intervention, remain in the
archive. A favorable individual arm never replaces its whole protocol.

## Distinguish CPU polling from the removed GPU spin

The published Splash host polls for up to 5 ms before blocking. An already
completed clean same-Splash ABBA, recovered from the earlier prepared-execution
archive, shows disabling that CPU polling increases request time by only about
1.35% for code and 0.70% for prose. It does not explain the larger Q2 gap.
The component reference used here already disables CPU polling. A proposed
duplicate build stops at its source assertion before compilation or another
model run; its draft and failure are preserved.

The production comparison retains Splash's published CPU waiting behavior.
Its separate GPU host-step spin library is absent. Earlier references to
"host spin absent" mean that GPU library, not removal of all CPU polling.
Do not compare native against a deliberately slowed upstream control and call
that production parity. No CPU busy waiting or blanket priority boost is ported.

## Fresh complete requests after competing builds stop

A fresh ACCA uses unchanged native v68 and production Splash 1.4.0. Both run
the same two warmups, code/prose prompts and 384-token output limits, with
matched prompt IDs, precision, actual cache capacity and context. Ordinary
adaptive verification and native Q2 read-ahead remain enabled. All four arms
pass the physical ceiling, headroom, no-paging, nominal-thermal and continuous
external-build checks.

| Task | Native request seconds | Splash request seconds | Native tokens/s | Splash tokens/s |
|---|---:|---:|---:|---:|
| Code | 12.201 | 10.690 | 34.36 | 39.39 |
| Prose | 13.992 | 11.999 | 30.32 | 34.82 |

These paired-process medians leave native about 14.1% and 16.6% slower by
request time. The first pair alone looks within 5%, but the reverse pair does
not. That first pair is not a parity result. The earlier clean comparison's
smaller gap remains valid for its recorded protocol; the new data shows that
neither a favorable pair nor nominal thermal status guarantees stable timing.

The second native process uses 109 versus 101 code verification passes and
131 versus 122 prose passes. Its demand bytes increase and time per pass also
changes. Adaptive width, generated tokens and cache state are coupled, so
this is extra observed work, not proof of a defective controller or a complete
causal decomposition. The limited throughput outputs remain archived; they
are not full task-quality or app-readiness passes.

## Checkpoint and next discriminating experiment

All 509 runtime input hashes and the five default artifacts match frozen v68.
The executable remains
`db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b`.
Fast's qualified performance path is unchanged; its recall failures remain
tracked in [[records/measurements/native-prepared-execution]]. There is no
release, Smart promotion, new performance default or full app-readiness claim.

The remaining work is unresolved. Reconstruct a slow complete request's actual
verification-width and routing/cache sequence, then replay equal work before
changing another scheduler. Separate extra verification work from per-pass
execution under concurrent I/O. A single fixed four-row state cannot explain
all request variance. Keep the published Splash baseline intact, retain only
repeatable complete-request improvements and qualify power, memory and user
responsiveness before adopting any priority or polling policy.

Restoration, repository gates and the Metal capability query are captured in
[[sources/runs/2026/10/2026-10-25-q2-handoff-checkpoint]].
