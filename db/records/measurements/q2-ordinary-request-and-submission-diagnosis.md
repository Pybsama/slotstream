---
type: measurement
id: 01m5tkstddx0abt5jcc5ar6cze
created: 2026-10-25T22:44:48.685697+00:00
updated: 2026-10-25T22:44:48.685697+00:00
summary: Q2 ordinary requests and submission boundaries
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1903'
runs: '[[sources/runs/2026/10/2026-10-25-q2-ordinary-request-and-submission-diagnosis]]'
title: Q2 ordinary requests and submission boundaries
status: measured
---
Q2 parity remains unachieved. No production change is retained and Fast remains
unchanged. This follows [[records/measurements/q2-order-executor-and-validation]];
raw observations, instrumentation checks and exclusions are preserved in
[[sources/runs/2026/10/2026-10-25-q2-ordinary-request-and-submission-diagnosis]].

## Fixed-pass behavior does not establish ordinary-request behavior

A timestamp-only ACCA compares normal complete requests under the same 15 GB
ceiling, actual cache capacity, context and precision. Native timed-request
frequencies range from about 1,144 to 1,184 MHz, while Splash ranges from about
1,101 to 1,189 MHz. The much lower native clock seen in the earlier fixed-pass
control does not carry directly into these ordinary requests. Frequency is a
whole-device observation, not arithmetic utilization or a proven cause.

The whole ACCA timing aggregate is excluded by paging in C1 and A3. Its raw
request times cannot qualify parity. Both engines also produce different texts
across their own repeated adaptive requests. Pass counts therefore measure
actual work but do not isolate an efficiency defect by themselves.

Splash's public speculation `cycles` counter excludes anchor-only passes;
native's verification counter includes them. Use the change in Splash's target
scheduler batch counter, checked against 48 expert-layer loads per batch.
Comparing the two public cycle counters directly would miscount the work.
No product counter or controller is changed.

## Ordinary-request overlap observation

A separate native/Splash pair uses bounded read and named Metal encoder
observations. Both pass the environmental guards. It remains an instrumented
diagnostic with different adaptive work, not an eligible speed comparison.

| Timed request | Native encoder union s | Splash encoder union s | Native outside both reads and encoders s | Splash outside both s |
| --- | ---: | ---: | ---: | ---: |
| Code | 6.404 | 6.465–6.484 | 1.167 | 0.443–0.462 |
| Prose | 7.010 | 6.916–6.934 | 1.199 | 0.484–0.502 |

Splash ranges bound missing encoder timestamps by their completed enclosing
command spans. The bounds are conservative. Encoder intervals include hardware
scheduling and stalls; neither their sum nor their complement is pure compute
or recoverable CPU delay. Reads overlap encoder execution and each other.
Native's read time outside encoder intervals is about 5.10 and 5.40 seconds,
versus Splash's upper bounds of about 4.59 and 5.02 seconds. These are observed
interval unions, not additive syscall service times.

The largest native gap group precedes expert repack/gather/execution. Its
portion outside observed reads totals about 0.42–0.44 seconds per request.
Smaller gaps precede draft graph execution and per-token sampling. This locates
further investigation at host preparation and handoff, but does not establish
that all of those gaps are removable. Unequal work and higher native observer
call counts limit differential attribution.

## Submission origin and a bounded control

Native's two traced timed requests contain 2,506 and 2,978 successful command
submissions with zero-length public GPU spans and no observed compute-encoder
creation or host-readiness wait. That is not proof that they are useless: the
observer does not capture every event signal or blit.

A clean native-only sampled-stack follow-up identifies 763 sampled zero-span
submissions. Of those, 718 originate in `NativeExpertSchedule.submit`, through
MLX asynchronous evaluation's finalizer. MLX can split the real work at its
automatic thresholds and then submit a separate completion signal. Removing
that signal without preserving completion, error and resource ownership is
unsafe.

Reanalysis of the earlier fixed-work control confirms that raising both split
thresholds reduces command count from 22,393 to 16,427 and zero-span submissions
from 2,764 to zero. Its verification time remains approximately 11.91 versus
11.85 seconds. This is a structural observation, not a paired speed win. It
does not justify a global cap change.

One new untraced ABCCBA tests whether that reduction helps ordinary requests.
A uses production thresholds, B uses high thresholds only in its isolated Q2
process, and C is published Splash. All use the same native runtime where
applicable. The protocol has a paging exclusion and is retained in full:

| Arm | Code request s | Prose request s | Environmental guard |
| --- | ---: | ---: | --- |
| 0-A | 12.064 | 13.912 | pass |
| 1-B | 12.207 | 13.562 | excluded |
| 2-C | 11.618 | 12.500 | excluded |
| 3-C | 11.238 | 12.509 | pass |
| 4-B | 12.437 | 13.650 | pass |
| 5-A | 12.753 | 14.105 | excluded |

Median B/A ratios are 0.9930 for code and
0.9713 for prose. These excluded raw values cannot
qualify a speed claim, and the paired directions must be assessed together.
No threshold setting or production change is adopted. Do not repeat the
protocol merely to find a favorable aggregate.

## Remaining work

The ordinary-request observations narrow the next question to useful host
work around expert handoff and draft preparation. Measure CPU copying and
preparation against the already observed read/GPU intervals in ordinary
requests, without treating overlapped service time as delay. Establish the
avoidable part before another reader architecture or prepared-block port.
Do not transfer the fixed-pass clock gap to the product, count unequal cycle
metrics as equal work, or remove completion signals because their GPU span is
zero. Native language choice still does not promise parity.

All 509 runtime inputs and five default build artifacts match v68. Capped
streams, memory and instrumentation checks pass within their declared scope;
no new semantic quality or complete app qualification follows. Existing Fast
recall failures and the Q2 strict-format failure remain separate gates in
[[records/measurements/native-prepared-execution]] and
[[records/measurements/q2-continuation-and-copy-diagnosis]].
