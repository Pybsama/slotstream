---
type: measurement
id: 01m5tzhccq7ej6965g57htd0n3
created: 2026-10-26T02:09:55.095858+00:00
updated: 2026-10-26T02:11:09.522933+00:00
summary: Q2 full-cycle execution and submission control
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1908'
runs: '[[sources/runs/2026/10/2026-10-25-q2-full-cycle-execution-control]]'
title: Q2 full-cycle execution and submission control
status: measured
---
The remaining Q2 difference is now **5.44% in a clean, fixed full-cycle code
control**. Native takes 11.182 seconds versus source-built Splash's 10.606.
This is diagnostic progress, not established ordinary-request parity or a new
runtime optimization. Fast and production v68 remain unchanged. This follows
[[records/measurements/q2-forecast-launch-control]]; evidence is in
[[sources/runs/2026/10/2026-10-25-q2-full-cycle-execution-control]].

## Match useful work before comparing execution

Both engines execute the same 84 prompt IDs and 111 sequential target passes:
472 target rows, widths one through eight, and 384 retained input tokens.
Every cycle computes a real seven-token draft proposal, runs the target on the
recorded inputs, computes greedy decisions and commits target/draft state using
the recorded accepted prefix. Only the choices of target inputs, width and
retention are frozen. Proposal computation is retained; it is not dummy work.

Each engine's 111 full-logit hashes and greedy IDs match its own prior target
reference. The two engines are not bit-identical to each other. All timing and
attribution passes also retain the validated real proposal IDs and selected
IDs. That establishes the diagnostic's target behavior, not semantic quality
of an ordinary generated answer or a quantization-loss bound.

Native uses v68 engine code with only the diagnostic CLI changed. Splash is
built from commit `1482f6bbc2abf12375332725302019594150b6cb`, preserving its
original CPU polling and using the published Metal library. Its actual draft,
target, sampling and state commits stay in one submitted graph. Four tiny
existing GPU copy operations save the actual proposals and impose fixed inputs,
width and retention without a new host wait. This diagnostic overhead and its
manual metadata finalization prevent equating it with the published executable.
No power manipulation, GPU spin or fake computation is introduced.

Both use the original Q2 weights, BF16 activations/KV, FP32 recurrent state,
4,067 actual expert slots, natural cache evolution and a 15 GB physical ceiling.
Fresh prompt/state initialization precedes each round. Native plans for 8,192
context tokens; Splash allocates enough KV pages for the bounded fixture.
Both committed target states reach 468 tokens, but reserved context capacity is
not matched. There is no tokenizer, server, streaming or adaptive-controller
choice in this control. It cannot replace the ordinary complete-request gate.

## Clean timing result

One frozen NSSN protocol runs one warmup and two measured sequences per process.
Every arm passes: no paging, nominal thermal state, no competing build,
maximum sampled footprint 12.650 GB and minimum sampled headroom 14.531 GB.
No arm is selected away or retried. All timing occurs without injected
read/GPU observers or full-logit readback. Passive frequency sampling is 200 ms.

| Arm | Measured round 1 s | Measured round 2 s |
| --- | ---: | ---: |
| Native first | 11.151 | 11.189 |
| Splash first | 10.509 | 10.660 |
| Splash second | 10.551 | 10.724 |
| Native second | 11.176 | 11.400 |

Median native/Splash ratio is 1.054369. Native's measured-round GPU frequencies
are about 1,156 to 1,223 MHz, versus Splash's 1,081 to 1,157 MHz. The earlier
large low-frequency target-only gap does not recur with this full useful
workload. This observation does not isolate drafting as the sole cause: the
control also omits inter-pass full-logit validation and preserves a different
execution rhythm. It does rule out low native frequency as the explanation
for this comparison's remaining gap.

Median demand reads are 25,893.5 native versus 24,390.5 Splash; adopted forecasts
are 19,198.5 versus 20,655.5. Inputs and widths match, but routed keys, cache
placement and forecast readiness can still differ. Native spends about 10.043
seconds verifying, 0.909 drafting, 0.082 sampling and 0.125 committing per
measured sequence. These sequential native scopes cannot be compared directly
with Splash's overlapping GPU and host timing totals.

## Submission is a stronger lead than extra reader waiting

A separate native/Splash attribution pair repeats the same 111 full cycles with
bounded read/copy and named GPU-encoder observations. Both pass environmental
and selected-ID/proposal checks. Traced times are 11.195/10.930 seconds, compared
with untraced warmup ranges of 11.434 to 11.463 and 10.725 to 10.801. The tracing
changes the relative gap, so these are localization data, not a replacement
speed estimate. All native encoder samples are valid; 66 Splash encoder
boundaries are missing and remain counted.

| Observed full-cycle interval | Native s | Splash s |
| --- | ---: | ---: |
| Measured GPU encoder intervals | 5.735 | 6.417 |
| Queued dependency not yet published | 3.687 | 3.799 |
| After publication, before next encoder | 0.614 | 0.608 |
| GPU gap before next command submission | 0.912 | 0.069 |

Rows are different classifications and must not be added as independent
costs. Encoder intervals include stalls and scheduling, not pure instruction
execution. Missing samples can overstate gaps. The before-submission interval
identifies next work not yet submitted; it is not proof the CPU was running
throughout or that every millisecond can be removed.

About 0.677 seconds of native's pre-submission gaps fall in target verification,
0.142 in drafting, 0.028 in sampling and 0.064 in commit. Classifying the next
encoder locates 0.467 seconds before expert schedules. Only 0.034 seconds precede
encoders containing the final combine. Moving that combine earlier therefore
has a small observed scope and does not justify reviving the rejected
forecast-launch candidate. Cache claims, routing readback and preparation
before submission remain the stronger region to isolate.

Native's 78,891 attributed demand copies exactly match three copies per fetched
expert. Copies overlap reads/GPU work; their union outside both is 0.072 seconds.
The larger parallel copy service sum is not removable request delay. Likewise,
more demand records do not establish a larger exposed read wait: native's
matched queued-readiness interval is slightly shorter here. Neither this trace
nor CPU wait sums justify a shared-reader rewrite.

## Next action and retained state

Use this full-cycle control to align bounded route readback, cache-claim,
expert-preparation and MLX-submission scopes with the 0.467-second region.
The earlier ordinary host measurements in
[[records/measurements/q2-ordinary-host-attribution]] already limit preparation
alone; do not relabel the whole gap as preparation or repeat a broad port.
Choose one measured sub-scope, test the smallest change, then require repeatable
ordinary complete requests against v68 and the published Splash binary.
The prior unchanged ordinary medians already reached within five percent in
one protocol, but the history of varying work and earlier clean gaps remains.

No runtime candidate is retained or proposed solely from this attribution.
All 509 runtime inputs and five default artifacts match v68. Known Fast recall
failures and Q2 strict-format failures remain separate. There is no Smart
promotion, app-readiness claim or release.
