---
type: measurement
id: 01m5r0a94ksxdkhq6njd3v3d77
created: 2026-10-24T22:25:47.667458+00:00
updated: 2026-10-24T22:48:48.964959+00:00
summary: 'Native prepared execution on the 48 GiB Mac: qualified Fast speed, cache-dependent Q2 results, ownership checks and preserved workflow failures'
date: 2026-10-24
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1880'
runs: '[[sources/runs/2026/10/2026-10-24-native-prepared-execution]], [[sources/runs/2026/10/2026-10-24-native-prepared-execution-validation]], [[sources/runs/2026/10/2026-10-24-native-prepared-execution-context-repair]]'
title: Native prepared GPU execution
status: measured
---
The [verified raw evidence](https://github.com/carloslfu/slotstream/blob/main/db/sources/runs/2026/10/2026-10-24-native-prepared-execution.md) binds every protocol, source snapshot and retained failure below.

The native engine now reuses prepared GPU execution descriptions on the
existing MLX stream. This follow-up measures complete Fast and exact-Q2
requests against Splash and preserves unsuccessful candidates, excluded timing
protocols and known model-quality limitations. The source is not an identical
copy of the entire Splash runtime: Swift owns the model, cache, file reads and
request lifecycle, with small native Metal execution adapters.

Fast remains the default for new app installations. The current Smart alias
retains the original four-bit target and MTP policy. Q2 remains an explicit
engineering candidate; this study does not promote it or publish a release.

## Reference and protocol

The upstream reference is Splash 1.4.0, source commit
`1482f6bbc2abf12375332725302019594150b6cb`. Measurements use the owned 48 GiB
M5 Pro with 20 GPU cores. Target and draft checkpoints, exact prompt token IDs,
greedy sampling, thinking disabled, BF16 KV, requested context and actual
expert-slot capacity are matched. Upstream alignment, staging and metadata are
included when matching the cache; equal advertised budgets alone are inadequate.

The selected short-request protocol uses an 8,192-token context, two warmups
and two timed requests per fresh process, code and prose, each with 384 output
tokens. ABBA ordering and the reverse BAAB control preserve every arm. Native
and upstream decode counters use their respective emitted-token conventions;
full request time is a separate gate. Parity requires at least 95% of upstream
decode rate and no more than 105% of upstream request time on both tasks.

Every arm, including warmups, must pass the frozen paging, thermal, output
length, prefix-reuse and memory checks. A clean subset cannot rescue an
excluded aggregate. Functional checks may pass during global paging, with no
clean timing claim. Earlier 512-token studies remain distinct protocols.

One model process runs at a time, with target-plus-three-GB launch preflights,
continuous process-footprint and headroom checks, and cleanup of owned children.
Other applications remain open. Splash ANE, disk cache and GPU spin are off.
No manufactured GPU work or power-state manipulation enters the native engine.

## Mechanisms retained

Prepared projection and expert programs are MLX primitives, using its allocator,
stream, dependency tracking and command-buffer completion ownership. Immutable
plans retain pipelines and geometry; request arrays and model weights are
invocation inputs. Both plan and pipeline caches have finite bounds, tested
for actual full-model execution without capacity or compilation fallback.

Host-ready event leases are reusable only after both host and GPU owners release
them, with increasing event values. Raw Q2 demand bytes and forecast tickets
share bounded, charged staging. Failed reads publish failure and drain before
reuse. Forecasts can prepare bytes but cannot select cache victims. The
upstream replacement policy is adapted to physical slots and pins; an
independent logical-order trace caught and corrected an integration error that
policy-only equality had missed.

Useful routed work is submitted before the next resident block is constructed.
Eligible reader retirement happens at the next actual router readback, retaining
final draining and observer paths. Pending recurrent state is folded into the
next narrow pass, with its small tape staged once per head. Checkpoints,
persistence, forks, public full-state access and wider fallbacks keep their
materialized-state contracts.

Q2 residual combination is a single prepared grid with fresh output ownership.
It preserves separate FP32 multiply/add rounding, so retained checkpoints cannot
be mutated. Shared/routed expert work, draft convolution, packed draft weights,
lossless resident row order and bounded projection splits preserve independently
checked original-format arithmetic and required intermediate precision.

Batch dimensions and reduction extents are now copied into at most eight inline
32-bit dispatch parameters. They do not specialize shader source. Plans still
own exact buffer shapes; distinct arithmetic tiles retain distinct pipelines.
Boundary tests reject missing, negative and oversized parameter counts, and
prove two plans sharing a pipeline retain independent copied parameters after
the original host arrays and plan handles are released.

Splash reuses immutable plans but encodes fresh commands each cycle. Earlier
references to pre-encoded command-buffer replay were incorrect. The pinned MLX
event implementation already uses the public Metal shared-event wait; a supposed
listener-versus-wait difference was not a demonstrated bottleneck.

## Matched speed results

The final frozen v68 binary is
`db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b`.
Its source archive is bound by `v68/sha256.json`. It retains v61 computation,
adds explicit Swift-owner lifetimes at native boundaries and a fresh-input
regression, and corrects a qualification comment. Source scope is independently
checked against the frozen v61 archive.

The final Fast 15 GB ABBA is clean and passes: code native/Splash rates are
61.3349/54.7889 tok/s; prose rates are 49.9878/45.6404. Full-request ratios are
0.90368 and 0.92416. Initial elevated thermal samples belong to cooldown;
every passive sample after the first-arm preflight is nominal.

The final Q2 12 GB confirmation is excluded by first-arm warmup paging and
second-arm process paging. Its diagnostic code/prose native rates are
22.5464/19.9928 versus Splash 22.2103/20.9328; these are not a clean speed
claim. The final Q2 15 GB confirmation is excluded because its first Splash
arm ends above nominal thermal status. Its diagnostic rates are
32.5577/29.2540 versus 35.3611/30.3344. No clean subset repairs either full
protocol. All measured requests complete inside their physical ceilings.
Neither final Q2 repeat qualifies parity, and the larger-cache gap remains
open despite the following earlier qualified smaller-cache result.

The prior clean v61 Fast 15 GB comparison passes: native/Splash code rates are
59.4415/53.0388 tok/s and prose rates 50.5817/48.7568. Complete-request ratios
are 0.89903 and 0.96685. Every arm passes; all 225 passive thermal samples are
nominal. This establishes the declared two-task comparison on this Mac, not a
universal speed advantage.

Q2 performance depends on the declared memory budget. A clean 12 GB three-way
ABCCBA comparison retains all six arms: v61, the v66b full-GDN candidate and
Splash. Native v61/Splash code rates are 23.4402/22.9903 tok/s and prose rates
21.7714/22.3501. Complete-request ratios are 0.97663 and 1.02741, meeting both
parity gates. All 692 passive thermal samples are nominal and no arm pages.
The candidate's native/native geometric request ratio is 0.98736 and code
regresses slightly. It misses the preregistered 0.98 gain threshold and is
removed. The simpler retained schedule already matches Splash at this budget.

That result does not repair the valid Q2 15 GB failures. Ordinary ABBA returns
native/Splash code 28.4405/36.2694 and prose 27.2538/32.7492 tok/s. A quiet
ABBA, excluding builds, source reads, edits and large UI output during timing,
also fails at 28.2978/35.0549 and 26.3360/32.4890. All arms are eligible and its
374 passive thermal samples are nominal. Extra assistant output alone is
therefore not a sufficient explanation.

A clean reverse BAAB control with passive clock observations also fails:
code 31.4111/37.4272, prose 27.9580/32.4392 tok/s; complete-request ratios
1.17670 and 1.15879. Splash remains faster in the last arm at higher observed
temperatures. Whole-device GPU clocks are higher during Splash generation;
that association does not prove causation. Approximate request windows include
prefill and are not per-process clock attribution. No clock or power settings
were changed. An initial monitoring attempt failed a 384-token harness
assertion before loading a model; preserve it separately from the corrected run.

Earlier v58b Q2 15 GB results were favorable, but v59 and repeated v61
confirmations failed. They are retained rather than selecting the fastest
historical candidate result as proof of reliable parity. The v60 experiment
omitting cost observations during pipeline creation was excluded by heat and
removed. Production prices all cycles. Earlier small-cache controller studies
excluded by paging or heat remain excluded; no subset repairs them.

## Root-cause evidence and rejected work

Earlier fixed-input instrumentation found substantial native host/submission
gaps even with cached target work. Its native target-only workload and upstream
draft-plus-target workload differ, so the trace is diagnostic, not a serving
speed comparison. GPU timestamp-interval unions include waits and are not ALU
utilization. CPU samples identify waits, not GPU idle time; worker samples
cannot be summed into request-wall-time percentages.

Native graph construction and launch boundaries, recurrent-state materialization
and verification-batch selection were concrete sources of extra work. Once the
target schedule changed, prior calibration conclusions needed remeasurement:
the older small-cache controller bundle had regressed, while the current 15 GB
ablation improves complete requests. Draft acceptance alone never establishes
quality or acceleration.

Rejected production experiments include deferred host-routing workers, extra
SSD readers, a separate buffer pool, raw Metal buffer bindings, wider command
batching, an isolated compiled GDN graph, and a sharded draft top-16 kernel.
The top-16 component improved in isolation but slowed complete requests. A
staggered projection traversal failed the strict BF16 arithmetic gate. Combined
GDN input scheduling was exact but had no eligible full-request benefit across
two excluded protocols, so its extra production path was removed. Its shared
threadgroup-scratch correction remains and passes strict shader validation.

A diagnostic Metal observer directly records library and pipeline creation,
without changing command execution. Its independent component check preserves
computed values. On the same 96-token prompt, v59 prepares 162 native projection
libraries and v61 prepares 35. Recorded native library calls total 2.46449 s
and 0.002354 s respectively; these sequential instrumented runs retain OS
compiler caches and do not qualify a serving speed ratio. They demonstrate
unnecessary preparation and its observed cost, but cannot retrospectively prove
that compilation caused every millisecond of the earlier v59 stall. Across all
34 v61 Q2 functional requests, the prepared pipeline count stays at 35 and
only the first decode cycle prepares new native projection pipelines.

All failed builds, crashes, excluded aggregates, source snapshots and never-run
candidate status remain in the evidence. Tests were not weakened to accept them.
A static-gate fixture initially omitted the new header-test dependency; the
corrected isolated fixture passes while the initial failure is preserved.

## Correctness, quality and scope

Independent compressed-byte references, cache-adapter traces, event/read-failure
checks, cancellation, exact original greedy goldens and retained-state probes
are separate from speed acceptance. Real trained-state probes compare complete
FP32 logits and recurrent-state hashes across optimized/unoptimized and
traced/untraced continuations, including partial speculative acceptance.

The final v68 engine passes all 108 catalogue checks, with 41,435 assertions,
no failures and no skips. Independent format, expert-pool, shared-kernel,
Metal-validation and fresh-input ownership checks pass. Plain outputs equal
the original goldens; partial-acceptance continuations preserve every full
FP32 logit and recurrent-state hash. Both 34-request functional suites pass
inside the explicit nine-GB ceiling. Fast peaks at 5.91201 GB and
Q2 at 7.32162 GB. Global paging is observed for both models; these are functional checks, not speed claims.
The rebuilt app's scripted UI/runtime suite, bundle inputs, helper hashes and
strict code-signature checks pass. Its separate frozen source archive binds the
actual app build. All 92 captured UI images were created by this execution; the
reviewed file-change screen shows the expected diff and review controls.
At a ten-GB combined-process ceiling, Fast peaks at 7.44798 GB
and Q2 at 7.74492 GB. Q2 passes all six real jobs: writing, PDF,
receipt OCR, CSV computation, reviewed code editing and history recall. Fast
passes the first five but returns unrelated conversation text in history recall.
It also fails the answer check after Fast → Q2 → Fast. The loaded-model,
startup recipe, memory and native-path assertions pass for both switches.
Q2 retrieves the correct stored code in the same Home; the two failed Fast
turns do not call history.search. This is not observed deletion of history,
and its cause is not isolated by this study. The complete real-workflow gate
is failed, not relabeled as a pass. No scoring or prompt workaround was added.
The final v68 scores retain both v61 and upstream per-case grades: Fast 20/24 semantic passes and Q2 19/24; both have 12 strict
passes. All 34 request-behavior cases pass for each model. These small frozen
suites do not prove negligible Q2-versus-four-bit capability loss or qualify
all user tasks. No result from this single 48 GiB Mac establishes behavior on
physical 16, 32 or 64 GB Macs.

## Later candidates and ownership correction

The v62c upstream-style AF4G64 draft packing passes arithmetic and quality, but
its clean 15 GB native/native geometric request ratio is 1.01135, so it is
removed. v63 borrowed buffer descriptors and sealed output metadata also pass
correctness; their clean ratio of 0.98034 narrowly misses the frozen 0.98 gain
gate. v64 lazy convolution windows preserve independently checked values and
trained state, but their whole timing aggregate is excluded by paging. None
becomes a production knob.

v65 combines the entire Q2 recurrent block into one prepared primitive. Real
trained-state continuations after retaining three of eight speculative rows
produce identical full FP32 logits and recurrent hashes. A new fresh-input
boundary test exposes a Swift/C++ wrapper-lifetime crash. Holding the Swift
owners through the C call fixes it. The production projection and expert
wrappers retain this correction independently of the rejected larger block.
C++ copies MLX arrays for asynchronous use; raw context pointers alone do not
retain their Swift owners. The regression frees program handles and temporary
inputs before output evaluation and verifies independent outputs.

v65b exhausts the bounded plan cache by specializing on previous tape length.
v65c makes that input extent bounded and dynamic, keeping exact tail geometry
and the existing cache cap. The clean 12 GB comparison misses the gain gate
and regresses prose. Both 15 GB attempts are excluded by paging. v66b also
folds convolution-window and output-permutation copies into the block, with
independent all-width checks, strict Metal validation and exact trained-state
continuations. Its clean three-way comparison still misses the gain gate.
All whole-GDN candidate code, expanded program limits and associated flags
are removed. Larger prepared blocks are not inherently faster.

Full-prefix shader instrumentation exceeds threadgroup memory in an existing
prefill kernel. A separately declared short-prefix validation exercises the
new whole-GDN block and passes. This preserves the instrumentation limit; it
is not evidence that the longer instrumented run passed. Initial type-check
failures, rejected candidates and source snapshots remain in the raw archive.

## Remaining gap and next experiment

Both runtimes use the same physical GGUF files: device/inode checks prove the
two path sets are hardlinks on the internal SSD. Different storage placement
and a hidden prepacked upstream expert file are ruled out. Prepared upstream
metadata still names those original raw files, and both runtimes GPU-repack
expert bytes.

Actual verification dominates native request time in the inspected Q2 traces.
The draft and host reconciliation are much smaller. Approximate physical
read-counter windows show similar total request traffic, with somewhat more
native code-request reads; the different timing scopes cannot isolate an I/O
cause. Issued forecast bytes are reservations, not completed SSD traffic.

The full runtimes still differ. Splash's shared reader pool halts speculative
batches and completes needed partial pieces in its demand scheduler. The
native implementation promotes required tickets and uses joined demand reads
with private aligned scratch. Splash can read aligned staging directly;
removing the native scratch copy would require separately charged padded
staging and proven ownership. The earlier worker-only ablation does not test
this complete scheduling difference. These are concrete remaining experiments,
not established causes or shipped optimizations.

Native sections still participate in MLX graph evaluation and dependencies;
Splash reuses a wider immutable execution graph. The failed full-GDN controls
show that simply merging another block is insufficient. Public GPU counters
on this Mac support stage timestamps, not dispatch sampling. GPU command
intervals include event waits; neither them nor CPU samples prove individual
kernel utilization. No keepalive, artificial work, power-state manipulation
or benchmark-only timing filter is justified.

Fast remains the new-install default. Smart retains the original four-bit
model and MTP policy. Q2 remains an explicit engineering candidate outside
normal setup and automatic incumbent retention. Clearing prefix state clears
learned calibration at privacy/ownership transitions, and unload releases it.
No public release or Smart promotion is made by this study. Broad Q2 parity
remains unresolved until repeated matched complete-request gates pass at the
larger cache as well as smaller budgets, with quality and real app jobs kept
as independent acceptance criteria.


## Final local validation

The complete static suite passes against the frozen v68 binary. The current
source and default local build match its archived identity. Brain validation
reports zero errors and warnings, generated documents and all claim needles
pass, and added local file links and Git whitespace checks pass. The original
link-check failure and repair are preserved in
[[sources/runs/2026/10/2026-10-24-native-prepared-execution-validation]].
Hosted CI is pending at this capture; these checks do not turn the remaining
Q2 timing exclusions or Fast workflow failures into passes.


## Direct-read constraint from earlier evidence

The earlier [[records/measurements/expert-lookahead-2-slot-adoption-screen-2026-09-12]]
records kernel-level file-read stalls after an experiment reading directly into
GPU-shared pool storage. It did not isolate the cause. Removing the current
private scratch copy is therefore not an established safe speedup. A future
read-scheduler experiment must preserve bounded buffer ownership, completion
and failure draining, and separately qualify any changed file-read destination.
The remaining shared-reader scheduling hypothesis can be tested without first
reintroducing that destination change.

The final upstream logs explicitly report that the host-step spin library is
absent and GPU keepawake is disabled. The comparison harness asserts the
library is absent before each arm. The observed Q2 gap is not evidence that
this study accidentally compared against an enabled upstream GPU keepalive.


## Context proxy repair

The first hosted context check fails because the isolated planner compilation
omits the native schedule policy that the new Q2 memory profile references.
The proxy now extracts the production declaration verbatim and injects the
platform capability. It runs both states in fresh processes and independently
checks the complete expert staging geometry, profile identity and reserve.
The complete local proxy suite passes; no inference source or benchmark binary
changes. The original failed CI artifact, exact repair and passing local
receipts are preserved in
[[sources/runs/2026/10/2026-10-24-native-prepared-execution-context-repair]].
The hosted repair result is pending at this capture.
