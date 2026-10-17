---
type: decision
id: 01m4remmdjrd8qjvgrnpzyvnba
created: 2026-10-12T16:20:25.138274+00:00
updated: 2026-10-13T03:07:07.991055+00:00
summary: Remove artificial GPU keepalive and optimize useful work with evidence across the supported scope
decided_on: 2026-10-12
evidence: '[[records/measurements/issue55-keepalive-investigation-2026-10-12]]'
reversible_if: A new explicit owner decision supported by end-to-end evidence across the intended hardware and power envelope; a one-machine speedup or optional flag is insufficient
title: Remove GPU keepalive; prefer bounded optimizations of useful work
status: standing
---
Carlos chose complete removal on October 12, 2026 after reviewing [[records/measurements/issue55-keepalive-investigation-2026-10-12]]. This reverses [[records/decisions/gpu-keepalive-on-ac-power]]. The implementation, polling kernel, power detection, command queue, flags, environment reader, statistics field, startup setting and dedicated probes are removed. Direct demand reads remain independently tested. Historical evidence and source archives remain intact.

## What happened and what the evidence supports

Issue [#55](https://github.com/carloslfu/slotstream/issues/55) reports a base-M5 MacBook Air slowing from roughly eight tokens per second to less than one with the default enabled while plugged in. Disabling it restores usable generation. Similar read counts and unchanged draft acceptance narrow the problem away from extra model work. A separate polling queue can delay useful GPU work. Our scheduling probes demonstrate that mechanism under controlled dependencies, but do not prove the reporter's exact driver behavior or explain the approximately five-second stalls. We did not reproduce those stalls on the development M5 Pro.

The original paired development-Mac improvements remain valid for their recorded configurations. They did not qualify a default across the supported range. New small-budget pairs show no consistent benefit; neither these pairs nor the old larger-budget tests establish a universal speed claim. The combined keepalive/direct-read gains cannot be attributed to either feature alone. Energy cost also belongs in the evaluation. The old default's own reversal criterion was a contrary result on another Mac; the report satisfies the practical reason to reverse it without waiting for a complete driver diagnosis.

## Product and engineering lessons

- Optimize useful computation, data movement and dependencies: reduce reads, dispatches and synchronization; batch or overlap real work within bounded memory. Do not keep hardware artificially busy to influence its power state or undocumented scheduling. A faster isolated kernel is not sufficient product evidence.
- Prefer broadly applicable mechanisms with a clear resource bound and a safe ordinary path. Native kernels and justified shape-specific algorithms remain appropriate when their correctness, scope and resource costs are established. Generic does not mean abandoning the native stack or pretending hardware differences do not exist.
- Judge the full user experience: time to first response, sustained throughput, long pauses, cancellation, idle behavior, energy, heat and coexistence with other apps. A plugged-in laptop becoming unusably slow is a default failure even when the output is exact and a developer's benchmark improves.
- A user-facing switch is not a repair for an unreliable internal optimization. Users should not need to know the GPU scheduler, discover a hidden environment variable or tune their machine into a usable baseline. Hardware allowlists and optional retention would prolong this feature's maintenance and UX burden; remove it instead.
- Separate measured facts, plausible mechanisms and unresolved causes. Use paired/interleaved complete requests with exact output, resource accounting and preserved failures. Review adverse outcomes across chip sizes, power modes and sustained workloads before promoting a scheduling-sensitive default. Do not turn one-Mac evidence into a universal promise or hide a severe regression behind a favorable average.
- Investigate one reported failure at a time. Read the maintainer's previous replies before posting, acknowledge the practical problem, provide an immediate workaround, state the planned change and return with a verified release. Close only an issue the change actually resolves. A nearby slowdown is not automatically the same bug.

## Migration and release acceptance

Before the removal release, affected users can use `--gpu-keepalive off` or `export SLOTSTREAM_GPU_KEEPALIVE=off`. After upgrading, remove that CLI flag from scripts; the deleted environment variable has no effect and can be unset. No replacement tuning option is introduced. Ollama's `keep_alive` request field and network stream keepalives are unrelated and remain supported.

Startup recipe identities change because the actual execution policy changes. Preserve old identities as historical evidence; do not relabel old activation or performance receipts as acceptance of new settings. The development Mac app requires fresh activation when encountering an older recipe and retains saved preferences. Frozen research protocols naming the removed setting are historical inputs, not executable evidence for a new build; freeze new protocols before new comparisons.

Release completion requires complete CI for the source commit, the exact CI archive passing the native battery, successful publication with verified checksum/provenance, and the public installer plus installed serving acceptance. Functional acceptance permits diagnostic global paging but never waives real headroom or process-memory checks. Do not promise a speedup on untested hardware.

Issue [#54](https://github.com/carloslfu/slotstream/issues/54) reports a context-boundary slowdown and has no keepalive-off comparison. Inspect its actual attention path and boundary before attributing it. Keep it open unless independent evidence shows the reported failure is resolved.

## Release-test lesson from the removal

The broader local gates exposed an unrelated disk-space fixture failure. It built a synthetic model larger than the host's free space; with nearly a terabyte free, that fixture exceeded the manifest's object-count bound and failed validation before testing disk admission. The failure was in the test's host-dependent setup, not evidence of a broken user download. Use a small valid manifest and inject only the available-disk observation into the internal downloader, then assert that both zero capacity and a missing safety-margin byte refuse before any partial file appears. Production still reads real disk availability and enforces the same margin. Keep fixtures bounded and prove that they reach the behavior their names claim to cover.

## Additional affected hardware and issue audit

The subsequent [M1 Max report #59](https://github.com/carloslfu/slotstream/issues/59) describes the same practical keepalive-on/off failure pattern on another GPU generation. [[records/measurements/issue59-keepalive-and-related-issue-audit-2026-10-12]] preserves the original report and its automatic-planning confounds. It reinforces the removal decision without proving an exact causal speed ratio or the underlying driver mechanism. The issue audit identified #55 and #59 for the removal release; #54 remains unproven as related, and historical serving reports are not duplicates without evidence.
