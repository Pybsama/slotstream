---
type: measurement
id: 01m5jg2vf02zjt7ejz23530m55
created: 2026-10-22T19:05:54.912043+00:00
updated: 2026-10-24T22:31:23.774768+00:00
summary: Native Q2 grouped kernels, precision and speculative-state fixes improve execution; matched evidence still shows a Splash gap, equal small-suite Q2 scores and six passing app jobs
date: 2026-10-22
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1876'
runs: '[[sources/runs/2026/10/2026-10-22-native-q2-execution]], [[sources/runs/2026/10/2026-10-22-native-q2-execution-exclusions]], [[sources/runs/2026/10/2026-10-22-native-q2-execution-validation]], [[sources/runs/2026/10/2026-10-22-native-q2-execution-followup]]'
title: Native Q2 and Splash execution comparison
status: measured
---
Slotstream's native Q2 candidate is substantially improved, but has not reached
Splash's speed. The clean adjacent pair from the matched-cache v15 experiment
is 29.38 native versus 50.21 Splash decode tokens/s. This is one eligible pair,
not a multi-round median or a guarantee for other prompts. Later final-binary
runs and their exclusions remain in the evidence. Q2 stays an explicit
engineering candidate; Fast and Smart defaults are unchanged. No release is
published by this work.

## Recipe and comparison controls

The physical machine is the owned M5 Pro, 20 GPU cores, 48 GiB unified memory,
macOS 26.6.2. There is one model process at a time, target-plus-headroom
preflight, a combined process-footprint ceiling and a remaining-headroom
watchdog. Other applications are not terminated. Paging disqualifies clean
speed evidence, separately from successful functional and memory checks.
Speed eligibility also requires nominal thermal state. No spin library,
undocumented synchronization switch, power-state manipulation or ANE path is
introduced.

Splash is release 1.4.0, source commit
`1482f6bbc2abf12375332725302019594150b6cb`; its engine SHA-256 is
`20b36bcc051145b425403dee7489d06cdbb5060460dfdb2e0cfc8d49cebfc29f`.
Both engines read the same original pinned GGUF files, verified as hardlinks
to the same physical shards. Both use the pinned DFlash2 draft, automatic
verification, greedy sampling and BF16 KV. The target preparation includes
Splash's Q8_0 conversion of floating-point hyper-connection mixing weights.
That conversion is quantization. The packed expert/resident plane transforms
are lossless; the entire prepared checkpoint must not be called lossless.

The main speed comparison uses an 8,192-token context, identical actual prompt
IDs, a 512-token completion cap and 4,968 expert slots on each engine, with a
16 GB combined-process guard. Splash's expert-memory option includes staging
and metadata; it is not its actual slot arena. The verified arena is
6,867,763,200 bytes. The PLE allowance is 51,200,000 bytes. The initial baseline
used unequal caches and paging, so its roughly 8–10 tokens/s cannot support a
causal speedup ratio. It is preserved as a starting diagnostic.

ABBA sequences use fresh processes and preserve all attempts. Splash warms
kernels during startup. An earlier v8 persistent-server control runs around
22–23 tokens/s with a different cache. A final v17 warm control matches both
expert caches at 4,968 slots and repeats around 23–26 native tokens/s. Its
Splash sequence varies around 25–42 tokens/s under paging and reuses part of
the prompt after the first request. These are separate diagnostics, not
eligible paired ratios. Native repetition does not close the observed gap;
this does not precisely isolate compilation from other request costs. Load
time remains separate from request time. A capped coding completion is a
throughput fixture, not proof that the code finishes a real job. The independent
app code-edit job checks completed work.

The final CLI is frozen as v17, SHA-256
`f6c979e088384622291bd9b3c277b2d9f4ba014bbebf1caa85e12bfb984808e3`.
Each build's source archive, binary and Metal library identities remain in the
raw archive. v17 fixes the key normalization path used by optional terminal
prefill. Its ordinary generation arithmetic is v16's. The app has its own
source archive and executable identities; a CLI identity is not app evidence.

## Final timing limits

The final v17 sixteen-GB coding sequence observes 25.40/28.49 native and
48.28/48.51 Splash tokens/s. The native arms have global paging and the last
also loses nominal thermal state. The final prose sequence similarly has no
eligible adjacent clean pair. These results demonstrate bounded completion,
not a clean final-binary throughput ratio. The earlier v15 pair above remains
a separately identified historical result, not a substituted v17 measurement.

A final twelve-GB ABBA verifies exactly 2,074 slots per engine. It observes
18.69/6.60 native and 32.22/32.43 Splash tokens/s; paging excludes every adjacent
pair. The unusually slow last native arm spends 29.36 seconds in demand I/O.
A previous twelve-GB arm completed cleanly at 22.48 tokens/s, but its Splash
control had one fewer slot and paging. Keep these controls separate. No
eligible median is manufactured from their best individual arms. The source
and every exclusion are retained in `comparison-summary.json`.

## Useful changes retained

- Route tokens by expert and reuse compressed weight tiles across their rows.
  CPU plane repacking writes directly into joined, pinned slots. GPU repacking
  every demand miss was slower. All other expert-loading paths use the same
  layout, including speculative tickets and sweep batches.
- Keep resident weights compressed with staged matrix tiles; partition the
  measured long, narrow projection reduction across four groups. Preserve
  FP32 vocabulary logits, residuals and the required single-round BF16
  boundaries. Native floating-point projections, hyper-connections, routing,
  mixtures, PLE, attention preparation and GDN operations reduce temporary
  arrays and dispatches.
- Let the Q2 confidence/cost controller choose verification depth. The old
  outer controller could permanently truncate or disable the inner policy's
  exploration after cold compilation. Anchor-only passes remain priced
  choices, and all emitted tokens still require target verification.
- Start resident shared-expert work before waiting for demand reads. Keep a
  bounded four-layer pin interval with the existing small-pool safety fallback.
- Record compact GDN inputs and evaluate only the accepted recovery state.
  Do not compact each layer's final convolution window while recording still
  retains its parent. Commit accepted windows together in one evaluation.
  Check every rollback position and continuation, not only full acceptance.

These are native Swift/MLX/Metal changes. Splash and Python are comparison
instruments, not product dependencies. Apache notices accompany adapted code.
The raw fallback remains for older OS versions. This work physically qualifies
only the available Mac, not all 16–64 GB hardware or every older GPU family.

## What explains the remaining gap

The fixed-token replay separates compute from I/O. The v14 untraced cached
width-eight target pass takes about 75.85 ms, with zero demand I/O in the warm
replay. The earlier v1 diagnostic was about 159.5 ms. Boundary-forcing profiles
are separate and deliberately serialize work; their timings are not request
latency measurements.

A temporary MLX completion-handler diagnostic finds substantial submission
gaps even with cached experts. Its width-eight pass is roughly 87 ms, with
51–54 ms covered by GPU command intervals and about 35 ms between them,
across approximately 270 command buffers. GPU intervals may themselves
include waits and are not pure arithmetic time. The diagnostic emitted all
samples and then aborted at shutdown. It is exploratory evidence, not a
passing functional build. The dependency patch was removed and its original
hash verified before every subsequent production qualification.

Splash assembles a Metal execution sequence ahead of time, groups routes and
uses bounded host-event handoffs and staging for expert reads. Its read-ahead
can overlap useful work. The current native path builds a dynamic MLX graph
and synchronizes host route decisions repeatedly. The matched v12 clean
native run spends about 6.19 seconds in demand I/O and 16.88 seconds in target
verification. The remaining time cannot simply be labeled disk latency.
Upstream counters include startup; subtract status-before values when using
them to analyze a request.

In that one eligible v15 pair, native completes 126 verification cycles and
accepts 385 draft tokens; Splash completes 131 cycles and accepts 380. The
mean total decode cost per cycle is 138.33 ms native versus 77.68 ms Splash,
computed from each request's decode duration and cycle count. Native uses
slightly fewer cycles yet takes longer. In this fixture the main gap is the
cost of executing a cycle, rather than fewer useful draft tokens. Those costs
include draft, target, recovery and emission work; they are not pure GPU time
or equal-width kernel timings. Different outputs and adaptive widths remain
part of each engine's measured request.

The next substantial port is the bounded native Metal execution sequence and
its CPU/GPU handoffs, integrated with existing cache ownership, cancellation,
rollback and process-memory accounting. Missing pieces also include upstream's
complete resident projection fusion, register-tile selection and its target
sparse-attention schedule. Their individual full-request contributions remain
unproven. This evidence does not identify a single magic flag or prove that
one scheduler rewrite will remove the entire gap. A final isolated Q8
register-MMA adaptation has better unrounded numerical accuracy but is slower
than the current staged kernel in the tested narrow projection. Its first
attempt had a packed-slot indexing error; the corrected probe and CPU oracle
are preserved. This rejects that adaptation, not Splash's complete register
path, and no additional production code is adopted.

Several plausible changes lost: demand-miss GPU repacking, extra cross-layer
read-ahead, staging with repeated GPU scatters, a wider barrier interval,
higher I/O queue depth, alternate expert gate/up parallelism and forced/padded
attention paths. Larger MLX command-buffer limits brought only a small
single-run change. None is adopted. In particular, a prefetcher that lowers
measured disk wait can still make the whole request slower and read tens of
GB that the request never uses. Keep the failed runs and implementation
snapshots instead of tuning only the reported winner.

A later v18 experiment delays construction of all alternative recurrent
recovery graphs until the accepted position is known. Independent state and
continuation checks pass, but its first cached width-eight replay pair changes
68.522 to 67.347 ms, and the next arm is refused by the independent headroom
preflight before allocation. The ABBA is incomplete and no substantial
full-request benefit is established. That extra representation is removed;
all compiled engine and app inputs are restored exactly to v17. The complete
warm control, refused attempt and rejected source snapshot remain in
[[sources/runs/2026/10/2026-10-22-native-q2-execution-followup]].

## Quality, state and memory

The frozen 24-task rubric gives v17 native Q2 19 semantic and 12 strict-format
passes. Splash Q2 has the same totals and the same five semantic failures:
order total, stock, tax, Spanish and first-missing-positive code. Earlier
four-bit Smart scored 21 semantic and 16 strict passes. This small screen does
not establish negligible quality loss or broad equivalence. Preserve the
actual prompts, outputs and bounded code grader.

Native v17 completes all 32 quality/runtime requests continuously at a 16 GB
target, peaking at 13.13 GB observed combined physical footprint. The eight
runtime cases cover streaming equality, conversation recall, cancellation,
post-cancellation recovery, stop buffering, decoded tool arguments, long
retrieval and prefix reuse. The repeated long prompt reuses 2,460 tokens. A
v16 continuous run also completes within a 10 GB target with a 7.67 GB peak. A separate v17 restart restores 2,304 persisted tokens
and retrieves the correct audit code within its sixteen-GB ceiling.
Paging is retained as a diagnostic; neither is a clean latency claim.

The 32K-context quality comparison has 4,546 native versus 4,545 Splash expert
slots. A missing metadata/alignment allowance in the harness caused the
one-slot difference. This is near-matched quality evidence, not exact cache
parity. Splash crosses the strict combined 16 GB process guard after sixteen
quality tasks, at 16.025 GB. The remaining eight independent coding tasks run
in a fresh server. Their aggregate score is not a passing continuous-session
memory result. Splash's documented allocation budget and this experiment's
combined process limit are distinct contracts.

Independent component checks pass the thirteen format oracles, CPU/GPU
repack byte equality, partial/full resident tiles, FP64 float projections,
exact Q8 preparation, deterministic routing ties, PLE and attention arithmetic,
and every recorded GDN recovery boundary. The cost controller matches 160
upstream C++ reference cycles, including anchor-only verification. The generic
Smart and Fast state-recovery regressions pass. The legacy diagnostic invoked
on Q2 refuses before allocation because it expects safetensors; preserve that
unsupported fixture result rather than calling it a model failure or pass.

## Final integration and next gate

The rebuilt app passes its complete scripted runtime and rendered UI suite.
All six real-model jobs pass at the explicit 10 GB ceiling: writing, cited
PDF reading, receipt OCR, deterministic CSV calculation, reviewed code edits
and history recall outside the initial context. Actual loaded pack and budget
are asserted for each job. The observed combined physical peak is 6.47 GB.
The approved minimal code edit also passes six bounded execution cases.
These are development-app functional checks, not signed-release certification
or a broad capability benchmark.
Performance parity remains open. Keep Smart unchanged until repeated clean
comparisons and complete useful jobs establish a worthwhile speed/capability
tradeoff, including the Q2 candidate's missing general vision support. Do not
spend memory reserves merely because one short prompt did not use them.

Evidence: [[sources/runs/2026/10/2026-10-22-native-q2-execution]],
[[sources/runs/2026/10/2026-10-22-native-q2-execution-exclusions]]. Previous
qualification: [[records/measurements/native-exact-q2-qualification]].

The full static suite passes against frozen v17, as do all 89 T0 and 18 T1
catalogue checks. The static-entry fixture initially failed because its
expected commands omitted the new mix-quantization fixture and expert check;
the corrected expectations and new failure-path assertion pass. Both runs
remain in [[sources/runs/2026/10/2026-10-22-native-q2-execution-validation]].
The source restoration after the rejected v18 experiment is hash-checked
against both the CLI and app build identities.

The code checkpoint is pushed as 3b6a307. The exact qualified v17 CLI is also restored as the default local build output. Local rebuild and catalogue receipts, the derived cycle-cost audit, and a hosted-status snapshot are in [[sources/runs/2026/10/2026-10-22-native-q2-execution-closeout]]. At that capture, documentation, context contracts and the external-library job pass; full engine and Mac app CI remain pending. They are not counted as passes.

## Prepared execution follow-up, October 24, 2026

The [prepared execution study](https://github.com/carloslfu/slotstream/blob/main/db/records/measurements/native-prepared-execution.md) adds reusable
native execution descriptions, pipeline sharing across batch widths, checked
state folding and cache integration. It preserves the earlier timing failures
and distinguishes cold preparation, steady work, controller behavior and actual
app outcomes. Its complete-request results have their own matched cache,
warmup and exclusion rules; they do not retroactively qualify this study's
excluded observations.

The original 160-cycle controller oracle covered its truncated observation
interface. It did not independently prove the complete runtime's anchor-only,
bonus-observation and cross-request calibration wiring. The new study includes
those separate fixture and executed-path checks.
