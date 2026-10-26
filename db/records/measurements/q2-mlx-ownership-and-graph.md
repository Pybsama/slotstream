---
type: measurement
id: 01m5v9tqfca92adbq8txfvca36
created: 2026-10-26T05:09:47.116061+00:00
updated: 2026-10-26T05:09:47.116061+00:00
summary: Q2 MLX ownership and graph diagnosis
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1912'
runs: '[[sources/runs/2026/10/2026-10-26-q2-metal-lifecycle]], [[sources/runs/2026/10/2026-10-26-q2-mlx-ownership]], [[sources/runs/2026/10/2026-10-26-q2-mlx-graph]]'
title: Q2 MLX ownership and graph diagnosis
status: measured
---
Buffer-lifetime bookkeeping does not justify a production rewrite. No runtime
change is retained; v68, Fast, Smart selection and app packaging remain unchanged.
The complete-request parity target remains unmet. This follows
[[records/measurements/q2-forecast-requests-and-mask-reuse]]. Raw evidence and
exclusions are [[sources/runs/2026/10/2026-10-26-q2-metal-lifecycle]], [[sources/runs/2026/10/2026-10-26-q2-mlx-ownership]] and [[sources/runs/2026/10/2026-10-26-q2-mlx-graph]].

## Scope and controls

Use the existing 111 real draft/target/commit cycles: 84 prompt IDs, widths one
through eight, 472 target rows and 384 retained tokens. Each native process has
4,067 cache slots, a 15 GB physical ceiling, 8,192-token context, BF16
activations/KV and FP32 recurrence. This fixes proposal/target inputs and retained
prefixes, not forecast completion timing or adaptive production behavior.
The original frozen native/Splash references are checked against their archived
member hashes before reuse. Source-built Splash keeps its existing bounded
fixture arena, so that first lifecycle comparison is diagnostic only.

The initial four-arm lifecycle protocol is excluded for accidental concurrent
analysis and an excessive native control shift. Preserve its unaffected native
localization without promoting it to a clean native/Splash result. The two
later native-only probes each use one warmup before the observed round, with
no simultaneous model, build or analysis. Their separate correctness runs
pass under Metal API validation; four/eight global swap-in pages exclude those
validation timings. Both timing pairs pass environment and memory guards.

## Direct buffer ownership and operation setup

The initial unaffected native trace records 639,836 caller completion-handler
registrations. Their original Metal service totals 35.316 ms, with 4.508 ms
outside observed reads and GPU encoders. All five measured command lifecycle
methods together total 175.113 ms, with 30.986 ms outside those intervals.
These calls exclude C++ capture construction and later callback destruction.
Counts alone are not grounds for a scheduler port.

The direct MLX probe then separates those missing ownership costs from primitive
encoding, registration and local cleanup. Its warmed off/on round times are
11.607052 and 11.719758 seconds, a 0.97%
shift within the declared sensitivity limit. All 594,394 rows are complete and
ordered; 6,080 operations take the split/commit branch. The whole-operation
row contains the other rows and must not be added to them.

| MLX GPU-operation scope | Total observed s | Outside observed reads and GPU encoders s |
| --- | ---: | ---: |
| Whole operation | 0.820499 | 0.114775 |
| Primitive encoding | 0.634946 | 0.083009 |
| Captured buffer-owner construction | 0.034023 | 0.004640 |
| Cleanup registration or split/commit | 0.117556 | 0.023263 |
| Front setup | 0.016343 | 0.001780 |
| Local cleanup and autorelease-pool tail | 0.012171 | 0.001476 |

The entire captured-owner construction is only 34 ms, so it cannot account
for the remaining roughly half-second fixed-cycle gap. Event registration,
autorelease-pool removal, a new buffer-owner container and fewer callback counts
do not have a measured case for adoption. The direct primitive interval also
includes allocation, binding and dispatch work; it is not pure CPU utilization.

The pipeline join finds no large single exposed encoding signature. The
repack/gather/gate-up/down signature has about 19.853 ms outside reads/GPU;
417,246 operations have no observed pipeline assignment and together contribute
about 10.797 ms of whole-operation time outside those intervals. No assignment
does not mean no necessary work. Debug buffer labeling is compiled behind
`MLX_METAL_DEBUG`, which the actual release recipe does not enable.

## Graph traversal and actual waiting

The follow-up records 162,066 graph/event scopes. Its warmed off/on passes take
11.890739 and 11.557855 seconds. The -2.80% shift exceeds
the two-percent sensitivity gate, so these are actual instrumented observations,
not representative costs or a speed improvement. Preserve that limitation.
Parent/child scopes in the following table overlap.

| Graph/event scope | Calls | Observed s | Outside observed reads and GPU encoders s |
| --- | ---: | ---: | ---: |
| setup and graph preparation | 17,034 | 0.122283 | 0.020308 |
| degree DFS | 17,034 | 0.044362 | 0.007489 |
| BFS tape build and local cache cleanup | 17,034 | 0.018081 | 0.002508 |
| event construction | 17,034 | 0.053214 | 0.009074 |
| event destruction | 9,184 | 0.029782 | 0.000456 |
| event signals and stream finalization | 17,034 | 0.080799 | 0.008288 |
| scheduler wait_for_one | 0 | 0.000000 | 0.000000 |
| actual Metal waitUntilSignaledValue | 6,378 | 5.501672 | 0.222586 |

There are no `scheduler::wait_for_one` calls in this pass: MLX's task-count or
active-memory throttle is not observed blocking it. Executor work outside the
GPU-operation scopes and scheduler/event waits totals 106.563 ms, only 8.299 ms
outside observed reads/GPU. Synchronous wrapper work outside graph evaluation
and the actual Metal wait totals about 0.813 ms.

Of 5.502 seconds inside Metal event waits, 5.042 seconds overlaps observed GPU
encoder intervals. About 0.223 seconds overlaps neither reads nor encoders.
The full wait is not wasted host work, and the uncovered part is not an isolated
wakeup delay. Existing CPU-polling controls and rejected prepared-block tests
remain authoritative; this does not justify busy waiting or another broad port.

Across this graph trace, observed MLX scopes cover about 0.379 of the 0.738 seconds
outside reads/GPU, leaving 0.359 seconds outside these scopes. All-positive-read
overlap includes speculative reads that may not serve the current dependency.
Consequently, uncovered intervals are neither pure idle time nor an upper bound
on potential gains: overlapping work can still delay the critical dependency or
compete for memory bandwidth. Do not add service sums or rule out such effects
solely because a forecast read was active.

## Next focused action and retained state

Do not implement an ownership-container, event-pool or generic graph scheduler
rewrite from these counts. The next comparison should bind each expert readiness
event to its actual demanded records, adopted forecasts and last required read
or copy, then compare that dependency path in native and Splash. Reuse existing
traces where they have the necessary identities; collect only missing identities
otherwise. Distinguish useful adoption from unrelated background reads before
changing reader scheduling. A new candidate still needs a justified mechanism,
exact checks and clean complete requests against v68 and published Splash.

Both probe builds restore the dependency's exact source bytes and modes and its
clean Git state; all 509 production inputs and five default v68 artifacts match.
There is no optional runtime knob, release or Smart promotion. The known Fast
recall and Q2 strict-format failures remain separate; frozen logits do not prove
semantic quality or complete app readiness.
