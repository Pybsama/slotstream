---
type: measurement
id: 01m5g6zxhaae830aswm9h9rffy
created: 2026-10-21T21:48:32.682233+00:00
updated: 2026-10-22T03:43:30.723757+00:00
summary: Historical native Smart DFlash reference and small-task review; Q2 performance and the adoption priority are corrected by the exact-recipe follow-up.
date: 2026-10-21
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: 'The follow-up corrects the interpretation of the Q2 smoke score and supersedes the DFlash-first engineering priority: [[records/measurements/exact-q2-performance-and-quality-followup]]. Original measurements and frozen verdicts remain preserved.'
order: '1860'
runs: '[[sources/runs/2026/10/2026-10-21-smart-dflash-review]], [[sources/runs/2026/10/2026-10-21-smart-dflash-final-code-ci]]'
title: Smart DFlash native comparison and Q2 checkpoint review
status: measured
---
This is a native draft candidate and an investigation of a different target
checkpoint. The app's Smart selection remains the original four-bit model with
MTP. The comparison uses the owned 48 GB M5 Pro. Planning checks for 16, 24, 32,
48 and 64 GB are simulations, not physical tests on those machines.

## Native implementation

The explicit `smart-dflash-check` command loads the existing Smart target and
Inco's pinned Smart draft at `a22a1744e85c17364dcc54a6a420af7135d4c7f6`.
It compares plain, MTP and DFlash through the production Engine, tokenizer,
sampler, tools, vision and caches. Only the draft projections are quantized to
affine four-bit groups of 64. Codebooks, norms and dynamic-convolution kernels
retain BF16. Each draft artifact is verified against its pinned hash.

Smart captures the BF16 mean of its post-layer hyper-connection streams at
layers 5, 15, 25, 35 and 45. The prefill feature window now retains up to 2,047
positions across passes; verification capture remains per-pass so rejected
state can roll back. Float32 rotary arithmetic and fused SwiGLU match the
reference's operation grouping. Terminal prefill pruning remains available
when the final layer is not a draft feature tap. Every emitted token is still
chosen by the target sampler, with checked state rollback and adaptive fallback.

The comparison reserves an additional 1.6 GB for the draft, loading overlap and
bounded state, admits no simultaneous MTP component, and inherits no Smart
throughput estimate. The full model tests use a 10 GB process budget and the
image comparisons explicitly price 12 GB. The MLX allocator cache remains
bounded. No GPU spin, Python runtime, Splash server or GGUF adapter was added to
the product.

## Quality and arithmetic evidence

A frozen set of twelve prompts covers extraction, filtering, aggregation,
Spanish, Hindi, conflicting quoted instructions, sorting, JSON tool arguments,
three executable Python tasks and longer retrieval. Expected results were saved
before generation. Code grading permits one Python fence semantically and
counts it separately as a formatting deviation. Literal JSON is otherwise
required. The captured scripts and original failing outputs are retained.

| Mode | Task checks under frozen rules | Strict format and content | Original successes retained |
| --- | ---: | ---: | --- |
| Plain Smart | 11/12 | 8/12 | baseline |
| Existing Smart MTP | 11/12 | 8/12 | all |
| Native Smart DFlash | 11/12 | 8/12 | all |

All modes return 12 for the Hindi arithmetic problem whose answer is 14. All
three coding answers add fences despite the plain-code instruction. Eleven
answers have identical token IDs to plain decoding; the interval function is a
different valid implementation. These small tests found no added semantic loss;
they do not establish statistical noninferiority or broad coding capability.
The final DFlash run accepted 243 of 294 proposed tokens and peaked at
7.751161064 GB. Draft acceptance is neither a quality score nor a speed result.

The pinned Z Lab MLX reference, using the same actual captured target features,
embeddings, draft weights and projection chunk shapes, produces exactly the
same 17,920 draft hidden values. An independent candidate-selector calculation
with Splash's float32 edge arithmetic chooses the same seven tokens. Replaying
earlier captured inputs through `smart-dflash-replay` also matches the reference
exactly. This qualifies those fixtures, not every tensor on every prompt. The
first diagnostic mismatches were traced to BF16 intermediate rotary arithmetic
and unfused SwiGLU; the old results and the corrected checks are both preserved.

Both plain and DFlash read the receipt image's identifier, date, currency and
numeric total correctly. Both wrap the JSON in Markdown fences, which is a
strict-format failure. Plain peaks at 8.361155112 GB; DFlash at 8.609683336 GB,
within their explicit 12 GB budgets. This tests actual native image encoding,
not an external OCR transcription.

## Runtime and workflow checks

The real read-file and list-issues tool definitions produce correctly parsed
calls with exact typed arguments. No external tools are executed. Streamed
text reconstructs the final text. Cancellation after twelve callbacks and a
subsequent request are tested. The long request saves and restores 2,304 tokens
of persistent prefix state, including a separate-process restart; a short prompt
below the production persistence threshold is not counted as a disk-cache test.

The original stop fixture asked for numbers but expected words. The model
correctly returned digits, so its word stop sequence never occurred. That failed
fixture is retained; an explicit word-copy case reaches the stop branch and
returns exactly `one two three four`. This was a test correction, not a runtime
patch. Another repetition is retained as a failed run because macOS memory
pressure interrupted inference safely, despite a process peak below its budget.
No pressure override was used.

The shared DFlash changes also pass the existing Fast short and long extraction
checks. Functional measurements taken during the checkpoint download are not
clean throughput benchmarks. The final source archive and executable digest
bind the successful native runs to the implementation.

## What the upstream Q2 checkpoint changes

The reviewed Splash source is release 1.4.0 at
`1482f6bbc2abf12375332725302019594150b6cb`. Its Flash-Next benchmark uses
`ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF:Q2_0`, not Slotstream's current
four-bit target. The pinned target revision is
`ed59f92082b1e93c0e96d60a8b11aab089b52f09`.

The [publisher's results](https://huggingface.co/ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF#results)
compare against BF16:

| Checkpoint | AIME25 | GPQA-Diamond | LiveCodeBench v6 | Three-task mean |
| --- | ---: | ---: | ---: | ---: |
| BF16 | 100.00 | 91.92 | 87.43 | 93.12 |
| Q2_0 | 96.67 | 89.39 | 81.14 | 89.07 |
| IQ3_XXS | 100.00 | 91.41 | 86.29 | 92.57 |
| IQ3_S | 100.00 | 92.93 | 86.86 | 93.26 |

The Q2 coding drop is 6.29 percentage points against BF16. That is not evidence
of minimal loss, and it is not a measurement against our four-bit checkpoint.
The publisher cautions that small apparent improvements are benchmark variance.
Its zero-shot recovery percentage does not establish preserved coding quality.

The two Q2 shards total 66,423,878,624 bytes. The transformer uses mixed precision,
not uniform two-bit weights. The first shard contains thirteen storage types;
all routed gate/up/down matrices use Q2_0, while embeddings, the output head and
dense layers use other formats. The second shard is the 28.8 GB IQ4_NL n-gram
lookup table. All actual native tokenizer entries have identical IDs in the
GGUF; its padded vocabulary is larger.

An exact native port needs pinned mixed-format loading and matching decode and
prefill arithmetic for those weights, including FP16 block scales and the
lookup table. The existing `gsq224` experiment preserves original down, dense
and lookup weights and therefore is not this checkpoint. Requantizing the GGUF
into our existing affine format would also change the model. The Q2 expert
record is half the original size, but that does not by itself prove a speedup.
Lower read volume, different residency, DFlash and runtime kernels must be
measured separately before attributing an upstream speed claim.

The [Splash release benchmark](https://github.com/incoai/splash/releases/tag/1.4.0)
is a different hardware, quantization and workload measurement. Its throughput
is not a Slotstream promise. The isolated upstream test copy disables host-step
spin and uses full verification plus BF16 KV to avoid adding those controls to
the quality comparison; it is not a reproduction of the advertised speed setup.

## Direct upstream answer comparison

Both Q2 shards passed whole-file SHA-256 verification. Splash received the exact
prompt token arrays used by the native baseline, avoiding chat-template and
pretokenization differences. The isolated server completed all twelve requests
with `--verify-rows all`, BF16 KV, no ANE and no host-step library. The observed
engine footprint peaked at 9.013137536 GB under its 10 GB engine limit; this
counter excludes the Python server's overhead. First-start kernel compilation
made readiness take 228.625 seconds. No upstream startup or throughput claim is
derived from this single run.

Under the unchanged checker, upstream Q2 scores 9/12, versus 11/12 for each
native Smart mode. Its strict-format-and-content score is 6/12, versus 8/12.
The extra misses are a total of 39 instead of 53, and Markdown fences around a
JSON array that was required to be literal JSON. Both repeat in a fresh server
run. The same Hindi arithmetic miss remains; all three code solutions pass
their executable checks but retain the baseline fence deviations.

This is an observed difference between the complete implementations. It does
not isolate quantization from the target runtime's numerical differences, and
the sample is too small for a general error-rate estimate. Together with the
publisher's coding result, it does not justify labeling Q2 a minimal-loss Smart
replacement. Prefer qualifying native DFlash on the existing Smart target first.

## Check coverage and limits

The final native core passes 89 T0 checks with 38,972 assertions and 18 T1 checks
with 2,360 assertions, with no failures or skips. The static gate battery also
passed. A follow-up adds the normal per-user model lock to standalone draft
replay; a held-lock negative test rejects before draft allocation, and a positive
replay still matches the reference exactly. The source archives distinguish the
generation-test binary from this CLI-only guard follow-up.

The Smart app has not been switched to DFlash, no Q2 loader has been shipped,
and no public release was created. Delivered-app qualification for a changed
Smart deployment, physical 16/64 GB testing, broad coding quality, longer-context
capacity and Q2 multimodal quality are still unproven. Keep the native candidate
separate from the maintained app choice until the remaining adoption gates pass.

## Paired native timing

Three rounds interleave plain/MTP/DFlash, DFlash/MTP/plain and MTP/plain/DFlash
at the same 10 GB process budget, with identical prepared prompts, prefill chunk
limits and output token IDs. Downloads, builds and other model processes were
stopped. Ordinary user apps remained open. All measured intervals retain
nominal thermal state, low-power mode off and unchanged global swap counters.
The request timer includes generation admission, prefill and decode, but excludes
installation, model loading, tokenization and UI. These are two short prompts,
not a general workload or a 48 GB automatically sized benchmark.

| Task | Plain median | MTP median | DFlash median |
| --- | ---: | ---: | ---: |
| JSON extraction | 6.979 s | 6.668 s | 5.972 s |
| Short Python function | 8.022 s | 7.154 s | 6.692 s |

The median summed time of the two requests is 14.980 s plain, 13.830 s MTP and
12.657 s DFlash: an 8.48% reduction from MTP and 15.51% from plain. First-text
latency stays around two seconds; the gain is mainly in generation after that.
The observed improvement is modest, not a reproduction of the upstream headline
throughput. Further app and low-memory qualification still matters.

An earlier attempted timing round is discarded because available memory fell
below the admission threshold before DFlash could start. The complete rerun
uses additional preflight headroom and a fixed short pause between processes;
it does not override the runtime guard. Both attempts remain in the archive.

Raw evidence: [[sources/runs/2026/10/2026-10-21-smart-dflash-review]].
Discarded timing attempt: [[sources/runs/2026/10/2026-10-21-smart-dflash-timing-discarded]].

## Hosted verification
The final code commit `ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe` passes
[engine CI](https://github.com/carloslfu/slotstream/actions/runs/39680693199),
[Mac app CI](https://github.com/carloslfu/slotstream/actions/runs/39680693003)
and [context proxies](https://github.com/carloslfu/slotstream/actions/runs/39680693062).
This includes the engine release build, external-library use, static/runtime
safety checks, goldens, full weights-free catalogue, instrumented tests and
coverage report, as well as the Xcode app build, scripted app checks and
light/dark view snapshots. The candidate's tested bytes remain unchanged.

These hosted checks complement the local model tests above. They do not promote
the candidate into the app, qualify physical 16/64 GB hardware or publish a
release. The raw exact-commit receipt is
[[sources/runs/2026/10/2026-10-21-smart-dflash-final-code-ci]].
