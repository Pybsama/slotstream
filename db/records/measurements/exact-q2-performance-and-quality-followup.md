---
type: measurement
id: 01m5gv89arv32djhc0d8cvm5ae
created: 2026-10-22T03:42:38.424799+00:00
updated: 2026-10-22T03:42:38.424799+00:00
summary: Exact upstream Q2 is substantially faster in bounded coding controls; preserve capability failures and prioritize native qualification over the earlier DFlash-only conclusion
date: 2026-10-21
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1870'
runs: '[[sources/runs/2026/10/2026-10-21-exact-q2-tradeoff]], [[sources/runs/2026/10/2026-10-21-exact-q2-timing-exclusions]]'
title: Exact Q2 performance, production defaults and capability tradeoff
status: measured
---
This follow-up changes the engineering priority: the exact GSQ-RCO Q2_0
checkpoint deserves native implementation and qualification. The previous
8.48% timing result compared MTP and DFlash on the same four-bit target, with
two short outputs. It was not a Q2 speed test. The earlier Q2 smoke also counted
a JSON fence as one of two additional failures; consistently separating format
from task correctness gives 11/12 versus 10/12, rather than two extra wrong
answers. Preserve the historical frozen scores and their original evidence.

The app's Smart deployment is unchanged. This is a comparison of native
Slotstream with an isolated upstream Splash process, not a shipped native Q2
port, a new release or an exact reproduction of the advertised 64 GB benchmark.

## Identities and method

The owned machine is the 48 GB M5 Pro with 20 GPU cores. The native binary is
`29024b72d6877becb94c59a1f3bda8f8d165b3f28af58202ea412c55aaad01b7`, built from
`ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe`; its manifest matches the current engine
sources. Splash is release 1.4.0, source
`1482f6bbc2abf12375332725302019594150b6cb`, executable
`20b36bcc051145b425403dee7489d06cdbb5060460dfdb2e0cfc8d49cebfc29f`.
The target is `ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF:Q2_0` at
`ed59f92082b1e93c0e96d60a8b11aab089b52f09`; the draft is Inco's DFlash2 at
`a22a1744e85c17364dcc54a6a420af7135d4c7f6`. Both target shards retain their
previously verified whole-file hashes. No model weights are included in the
evidence archive.

All requests use greedy, non-thinking generation. Upstream receives the exact
prepared native prompt IDs, with an 8K request window and no disk prefix cache.
Its normal auto verification and INT8 KV are compared with BF16 KV and full
verification. The GPU host-step spin library is absent; bounded CPU polling
remains. ANE is disabled, and this MoE target has no applicable dense-FFN ANE
path. The upstream Flash-Next loader does not accept safetensors, so it cannot
provide an otherwise matched control using our exact current MLX checkpoint.

The diagnostic `smart-dflash-check` forces its draft mode, disables ordinary
decode read-ahead, reserves 32K context and limits prefill to 256 tokens. It is
not the default-product baseline. Separate normal `slotstream run` controls
use automatic MTP/read-ahead, 8K context, vision off and identical prompt IDs.
At ten GB the normal planner selects MTP off and read-ahead on.

One model runs at a time under the shared model lock. Native admission requires
budget plus three real reclaimable GB; upstream requires four. Splash's flag
bounds Metal allocation, while Slotstream's target prices a whole-process
workload envelope. The harness separately samples upstream engine plus frontend
and enforces budget plus one GB as its physical ceiling. Report observed memory
alongside requested budgets; these are not equal physical allocations. All
processes are drained after their test. No user application or other chat's
process is stopped.

## Performance and capacity

Single coding-request controls, not a repeated causal estimate of quantization alone. The selected rows have nominal thermal boundaries and unchanged swap counters. All repetitions and exclusions remain in the archive.

| Configuration | Budget GB | Decode tok/s | Request seconds | Observed peak GB |
| --- | ---: | ---: | ---: | ---: |
| Slotstream normal CLI | 10 | 4.71 | 224.90 | 6.18 |
| Splash Q2 auto / INT8 | 10 | 22.53 | 47.29 | 9.64 |
| Splash Q2 auto / INT8 | 16 | 43.41 | 25.03 | 15.47 |

Fresh eligible ten-GB Q2 coding runs are about 22.5 to 22.7 tok/s; the initial combined run is 22.8. Two eligible sixteen-GB coding runs are 43.4 and 44.0 tok/s. Do not pool them with the thermally affected third repetition.

The coding prompt reaches its 1,024-token cap in each compared configuration.
It is a throughput task, not evidence of a completed correct cache class. The
independent bounded coding tasks below supply correctness evidence. Explanation
outputs vary in length, so their total latency also reflects different answers.
Timing excludes installation, model loading and the app UI. Prefixes are cold
in fresh performance processes; OS file-cache state is uncontrolled.

The initial combined quality/performance run and three later interleaved
MTP/Q2 pairs are retained separately. Only one complete later coding pair
passes the clean timing conditions in both halves. Do not call that a
three-pair clean median or a universal multiplier. The normal ten-GB coding
control has nominal boundary temperatures and unchanged swap counters; its
explanation control has global paging and is excluded from clean timing.

Unrelated Swift builds subsequently overlap the DFlash diagnostic and keep
restarting. The thermal-wait campaign is stopped before launching its next
model. Remaining small-memory tests explicitly continue as functional checks,
with unchanged memory guards and serious/critical thermal admission refused.
Their times are diagnostic only. Boundary thermal snapshots are not a
continuous temperature trace. Global paging does not identify its owning
process or invalidate completed work within a process budget. All interrupted,
refused and ineligible attempts are retained and separately registered.

The later native sixteen-GB control is refused before model allocation when
another compiler restarts and reclaimable memory falls to 17.95 GB, below the
required nineteen. The twenty-GB Q2 extension is not admitted by the recorded
22.86 GB snapshot either, since it needs twenty-four. Larger native controls
remain unmeasured; the earlier completed sixteen-GB Q2 runs are preserved. No
simulated availability or pressure override is used.

## What limits speed

Routed expert payload falls from 67,947,724,800 to 33,973,862,400 bytes; each
record falls from 2,764,800 to 1,382,400 bytes. Smaller weights both halve the
bytes per miss and permit more experts to remain cached. In the initial coding
controls, forced native MTP requests about 1.090 TB of expert data, Q2 at ten GB
about 432 GB and Q2 at sixteen GB about 193 GB. Q2's observed cache hit fraction
rises from about 29% to 75% as its expert arena grows from 1.82 to 7.82 GB.
These are engine IO counters, not independent physical-SSD traces.

Normal native read-ahead must be counted separately: its coding run records
334.762 GB of demand reads plus 576.170 GB of issued prefetch, including 484.255
GB adopted and 91.902 GB wasted. Demand bytes alone understate its traffic.
There are 1,023 decode forward passes. Forecast evaluation records 70.238
seconds and demand IO 57.813 seconds, but these are not an exclusive wall-time
decomposition. Conservative native reservations also leave unused capacity for
this short request; that is a separate planning hypothesis, not permission to
weaken the full-workload memory envelope.

The native MTP proposal network uses 4.20 seconds of a 167.46-second coding
decode. The loaded DFlash diagnostic spends 1.75 seconds proposing and falls
through depths 7, 3 and 1 before ordinary decoding supplies 780 of 1,024 output
tokens. Its interference prevents a clean performance verdict. The trace still
shows why draft acceptance alone cannot decide usefulness: target verification
and ordinary passes dominate, and the draft also consumes cache capacity.

Splash combines packed Q2 kernels, an ARC expert cache, read-ahead and a
[confidence/cost verification budget](https://github.com/incoai/splash/pull/487).
Unverified speculative rows route no experts; checking every row can read
experts for guesses later rejected. Native adaptation uses measured plain and
draft costs instead of the same selector. Wall-clock adaptive batching can
change greedy outputs between runs through floating-point execution shape.
These runtime differences prevent attributing the entire speedup to two-bit
quantization alone.

The ineligible BF16 diagnostics provide mechanism evidence: full verification
checks 1,415 coding proposals and accepts 820, while auto checks 871 and accepts
755. Rejected verified rows fall from 595 to 116; expert-read bytes fall from
650.317 to 438.379 GB for the same 1,024 output-token cap. Observed decode is
15.93 versus 22.61 tok/s, but thermal/paging and desktop interference prohibit
using that difference as a clean speedup estimate. The auto/BF16 rate is also
near the earlier auto/INT8 rate: short-context speed does not require INT8 KV.
This does not measure long-context KV tradeoffs.

All four follow-up paths return the correct audit code for the same synthetic,
repetitive 2,460-token retrieval input. Diagnostic prefill times are 18.07 seconds
native MTP, 26.14 native DFlash and 3.12 for both Q2 settings. These are not clean
or default-product long-document comparisons: the native diagnostic uses a
256-token prefill cap, upstream has different scheduling, and the input is not
a representative document workload. They identify a prefill path worth studying,
not a general RAG throughput claim.

Upstream ten-GB coding host-step counters record 18.386 seconds of loading
work, 2.379 of GPU resume and 0.479 of pickup. Removing the measured resume
delay alone cannot explain a jump from about 23 to 95 tokens/s. GPU-clock
effects of spin are not isolated; keep that mechanism excluded. Upstream
GPU-command durations include event waits and are not pure arithmetic time.

## Why the published 95 tokens/s differs

The [publisher's benchmark description](https://github.com/incoai/splash/pull/521)
uses an idle 64 GB M5 Pro with the same 20 GPU cores, all experts resident,
selected SPEED-Bench coding prompts and 1,024-token outputs. Its short-prompt
decode is 1,000 divided by median output-token latency of 10.57 ms. That is
different from its 32K prefill throughput, cached first-token latency and
four-request aggregate throughput.

The 66.4 GB download is not a requirement to retain every byte in RAM. Its
first shard is 37.6 GB and the 28.8 GB PLE lookup table is sparsely read from SSD.
This 48 GB machine reports a 40,200,896,512-byte recommended Metal working set;
upstream subtracts a safety margin. Full residency is constrained under the
reviewed planner, but no all-resident run was attempted here. The measured
ten/sixteen-GB cache scaling, not an extrapolation, supports residency as a major
cause of the remaining gap. Hardware, workload, available memory and disabled
GPU spin still differ from the headline setup.

## Capability and adoption

| Configuration | Semantic tasks | Strict format and content |
| --- | ---: | ---: |
| Native four-bit Smart, forced MTP | 21/24 | 16/24 |
| Q2, auto verification / INT8 KV | 19/24 | 12/24 |
| Q2, full verification / BF16 KV | 19/24 | 12/24 |

Both implementations fail the order total, stock arithmetic and Spanish
arithmetic. Q2 additionally returns 100 instead of 110 for tax and mutates an
input list despite an explicit no-mutation contract. The latter produces the
correct return values but violates caller ownership. Both extra failures persist
with BF16 KV and full verification, so they are not explained solely by INT8 KV
or the adaptive row selector. Stock answers vary between Q2 settings but remain
wrong. These tests use non-thinking mode and are not a thinking-mode evaluation.

The 24-case expected-output rubric is frozen before generation and separates
literal format from task correctness. Both configurations may have one Markdown
fence stripped for semantic JSON/Python grading. A worker limitation rejecting
valid `counts[key] += 1` was repaired identically for both using a restricted
AST transformation; the original grader and score remain. The gold fixture
passes all 24 checks. Code executes only in the existing bounded pure-function
worker, never as a general tool action.

This is not a broad error-rate estimate. The
[publisher's results](https://huggingface.co/ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF#results)
give Q2 LiveCodeBench v6 81.14 versus BF16 87.43, a 6.29-point gap; its three-task
mean is 89.07 versus 93.12. Those are BF16 comparisons, not measured losses
against our four-bit deployment. The local comparison also changes runtime
numerics. Neither zero-shot recovery percentages nor this small sample establish
negligible loss. A sufficiently large practical gain can justify some loss;
zero new failures is not an automatic adoption requirement.

Prioritize an exact native Q2 candidate. Preserve all mixed-format weights,
FP16 block scales, output head, embeddings and sparse PLE table. The previous
GSQ224 overlay retained original four-bit down/dense/PLE tensors and rounded
scales to BF16, so it was a different model. Q2_0 represents `d*(q-1)` with a
FP16 scale and 64 two-bit coefficients in eighteen bytes. A lossless layout
conversion is possible if coefficient precision is preserved; adding explicit
affine bias would raise it to twenty bytes. Packed native kernels can avoid
that added traffic. Both prefill and decode need independent reference checks.

The reviewed upstream source is Apache-2.0 with third-party notices, distinct
from the earlier MIT DFlash reference. Preserve applicable notices for borrowed
code. Keep native tool, stream, cancellation, prefix-cache and memory contracts.
Qualify actual complete app jobs and the delivered bundle before promoting the
candidate. Broad coding, images, long contexts and physical 16/64 GB hardware
remain unqualified. Do not turn this into a format catalog or an embedded
Python/Splash runtime. The updated priority is recorded in
[[records/decisions/smart-dflash-and-target-quantization]].

Evidence: [[sources/runs/2026/10/2026-10-21-exact-q2-tradeoff]].
Timing exclusions: [[sources/runs/2026/10/2026-10-21-exact-q2-timing-exclusions]].
