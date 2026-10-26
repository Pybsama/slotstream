---
type: measurement
id: 01m5jpdfs9mpjpwq9s40cq93b1
created: 2026-10-22T20:56:34.857226+00:00
updated: 2026-10-22T21:12:04.677798+00:00
summary: Fast native scheduling ports preserve measured quality; matched-cache observations still show a larger-cache Splash gap and exclude clean aggregate speed claims
date: 2026-10-22
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1877'
runs: '[[sources/runs/2026/10/2026-10-22-fast-splash-execution]], [[sources/runs/2026/10/2026-10-22-fast-splash-exclusions]], [[sources/runs/2026/10/2026-10-22-fast-splash-app-validation]]'
title: Fast and Splash execution comparison
status: measured
---
Fast is implemented natively and now avoids several unnecessary dispatches
and waits, but this work does not establish Splash speed parity. At the larger
matched cache Splash still completes the measured requests faster. At the
smaller cache the engines are closer, and the ordering varies with workload.
No release is published and no Smart model selection changes.

## Matched deployment and timing limits

The physical machine is the owned M5 Pro with 20 GPU cores, 48 GiB memory and
macOS 26.6.2. Both engines use the original pinned
`mlx-community/Qwen3.6-35B-A3B-4bit` target at
`38740b847e4cb78f352aba30aa41c76e08e6eb46` and Inco DFlash2 at
`51ef7b6923ad6c14cb1bb41c37a9041446496ab6`. Splash is release 1.4.0,
source commit `1482f6bbc2abf12375332725302019594150b6cb`. Its local preparation
references the original target and draft files. Target quantization is unchanged.

The warm protocols use exact native prompt IDs, greedy sampling, thinking off,
BF16 KV, an 8,192-token context, 512 generated tokens per request and identical
actual expert slots. There is one engine at a time, a target-plus-headroom
preflight, a combined physical-process guard, and a minimum remaining-headroom
guard. No GPU spin, host-step keepalive, undocumented power setting or ANE
acceleration is enabled. Existing user applications remain running.

Each arm starts a fresh process and runs two warmup requests. The twelve-GB
ABBA then times six distinct prompts per arm; the sixteen-GB short ABBA times
one coding and one prose prompt per arm. Early differing task identifiers
prevent prompt reuse, and every timed request reports zero reused prompt
positions. Load time and warmups are excluded from the warmed observations.

| Process budget / actual expert slots | Native code | Splash code | Native prose | Splash prose |
|---|---:|---:|---:|---:|
| 12 GB / 2,525 | 36.6 | 35.4 | 26.6 | 29.8 |
| 16 GB / 4,785 | 56.2 | 67.8 | 40.3 | 54.5 |

These are **observed medians in decode tokens/s, not eligible clean benchmark
aggregates**. Both native/splash timers use the generated-token count minus the
initial token. Every complete ABBA violates its predeclared zero-paging gate;
the last twelve-GB native arm also ends with elevated thermal state. Individual
clean requests and two clean sixteen-GB Splash arms do not rescue an excluded
aggregate. No precise universal speedup or parity claim follows. At sixteen GB,
the two timed native coding requests take 9.52 and 10.03 seconds end to end;
the source retains every request latency, prefill cost and paging observation.

Equal budget flags initially produced unequal expert caches. Splash's automatic
cache exceeded the sixteen-GB combined process ceiling and was stopped before
any request result. Matching actual slot counts, rather than its broader expert
memory setting, fixed that comparison defect. The first baseline and v1 runs
also lack symmetric warmup and/or have paging; they cannot establish a clean
before/after speedup. The memory and thermal preflight refusals, unsuccessful
selector builds and all timing exclusions are preserved.

## Native changes

- Fast's separate model branch now applies the existing bounded four-layer
  evaluation interval, safe pin generations, resident shared-expert overlap and
  fused recurrent verification recording. Previously it bypassed this wiring
  and synchronized after every layer. The interval shrinks when row count and
  pool capacity require it; slot ownership remains bounded.
- One confidence/cost verification controller replaces competing adaptation.
  It chooses a useful verified prefix, including an anchor-only target pass,
  and periodically explores again. Cold compilation no longer permanently
  shuts down its ability to recover. An anchor-only pass still pays for draft
  confidence; this is not a zero-overhead ordinary-decoding claim.
- A native Metal kernel performs the dependent draft candidate edge reductions,
  selection and confidence calculation with one host readback. Its independent
  CPU oracle checks every depth, ties and confidence. Target verification still
  owns every emitted token. Apache attribution accompanies the adapted work.
- Independent draft-context projections materialize together; the six-layer
  draft graph no longer evaluates at every layer. Bounded windows remain.
- Short prefill passes with 64–255 rows use the existing grouped expert sweep,
  while verification retains its cache path. Fast also receives the platform-
  qualified fused dense-attention setting and its diagnostic counter. Existing
  fallbacks remain on unqualified platforms.

These are Swift/MLX/Metal product changes. Splash and Python are reference/test
instruments, not product dependencies. The timing executable is frozen as v3.
The final executable adds diagnostic counting, command help and license notices
without changing generation arithmetic; both source archives and hashes remain.

## What still costs time

The fixed-token cached target replay takes about 33.0, 36.5, 40.4 and 52.6 ms
at widths one, two, four and eight respectively. Warmed rows have zero demand
I/O and zero paging. The traced/untraced output logits are identical within
that replay. Boundary-forcing traces deliberately serialize work and are not
normal request phase timings. These component observations do not inherit a
clean whole-request performance qualification.

At sixteen GB, a native timed coding request spends 7.86 seconds in target
verification, including 2.71 seconds of demand I/O, versus 0.74 seconds in the
draft. At twelve GB, its corresponding request reads about 64.6 GB of expert
records and spends 5.83 seconds in demand I/O. Increasing the cache changes
that tradeoff substantially. Native demand reads and Splash's read-ahead
counters have different scopes; keep them separate.

Source inspection explains further differences: Splash groups routes into
expert matrix tiles, uses compressed-weight execution layouts and prepares
more of its Metal command sequence ahead of time. Fast's current cached expert
path still uses MLX gathered quantized matrix-vector operations, and each layer
requires a host routing decision. The cached replay proves that SSD latency is
not the entire gap; it does not independently assign all remaining time to
one kernel or to CPU scheduling. A full pre-encoded target execution path and
Splash's grouped affine expert kernels have not been ported by this change.
Those are the next measured targets, not an established future speedup.

Do not spend every unused byte from a short-request peak on expert slots.
The process budget also covers longer contexts, retained conversations,
loading and transient work. The conservative Fast planner is unchanged here.

## Quality and engine qualification

The original native engine, final native engine and Splash use the same frozen
24 tasks, prompt IDs, greedy settings, 32,768-token requested context and 2,331
actual expert slots under a twelve-GB process guard. All three score 20/24
semantically and 12/24 under the strict formatting contract. Each gives the
same wrong answers on order total, available stock, discounted tax and Spanish
inventory. A native target-only control reproduces all four errors with the
draft disabled. This is no observed regression on a small suite, not general
quality equivalence or evidence about a different quantization.

The final native engine completes 32 continuous requests and passes exact
streaming, cancellation followed by a successful request, stop strings, native
tool arguments, conversation recall, long retrieval and prefix-reuse checks.
Its peak is 8.77 GB within the twelve-GB guard. Splash completes all quality
requests continuously within its guard as well. The source contains the exact
outputs, strict and semantic grading and failures.

The catalogue passes 89 T0 and 19 T1 checks. The recurrent recording kernel
passes 522 assertions over outputs and every retained state. Five bounded
Fast/Smart acceptance cases pass at 8.1–9 GB, including ordinary Fast decoding
and a longer prompt. Six Q2 regression requests pass under a ten-GB guard,
qualifying the shared draft changes independently of the Fast default.

Physical sixteen-GB and sixty-four-GB machines were not available. Small budgets
on this forty-eight-GB Mac are narrower evidence and do not qualify that entire
hardware range, every power state or long-context capacity.


## App and final validation

The rebuilt development app passes its full scripted UI/runtime suite. Its
embedded engine input manifest matches the current source, and its ad hoc
signature verifies. The [app validation receipts](https://github.com/carloslfu/slotstream/blob/main/db/sources/runs/2026/10/2026-10-22-fast-splash-app-validation.md)
contain the source archive, identities and exact outputs. This is not a public
release or a manual real-model GUI run.

The real app runtime completes six fixed synthetic jobs at a ten-GB budget.
Writing within the requested length, PDF facts with resolvable citations,
receipt extraction to exact JSON and CSV calculation through the table tool
pass. Two jobs fail: the model explains the correct code fix but does not stage
it for review, and it repeats irrelevant old conversation instead of looking
up the requested detail. Rerunning the same six jobs with the preserved original
app runtime reproduces both failures. Neither version changes the file without
review. The final process peaks at 6.61 GB; the original peaks at 6.22 GB.
These are four passing jobs out of six, not a complete workflow qualification
or proof that all code-edit/history tasks fail. Review/apply was not exercised
by these failed proposals. Keep these general tool-use limitations visible;
do not add fixture-specific prompts or silently treat a suggested patch as an
executed action.

The complete static suite passes with the final executable, including transport,
planner, memory override, installer, native miniature-kernel and brain gates.
Native runtime/API checks and the independently recorded real-model acceptance
remain distinct from the two app quality failures. No public release is made.

Next, profile and qualify a grouped affine expert path and prepared target
command dispatch on Fast at matched cache sizes. Repeat clean interleaved
completed-request comparisons before claiming parity or a speedup. Keep the
same frozen quality/workflow inputs and target verification, and measure
resident, SSD-bound and long-context cases independently. A proposed default
must earn its place in useful completed work, not merely fewer kernel calls.
