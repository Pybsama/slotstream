---
type: measurement
id: 01m37frm11f9k0ac9dq217tkrx
created: 2026-09-23T15:57:17.217770+00:00
updated: 2026-09-23T15:58:31.021610+00:00
summary: 'Sevra desktop defaults: MTP, useful checkpoints and verified reloads'
date: 2026-09-23
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Delivered development-app defaults and real-model correctness; paired timings are diagnostic, not new clean public throughput anchors.
order: '1661'
runs: '[[sources/runs/2026/09/2026-09-23-sevra-app-optimizations]]'
title: 'Sevra desktop defaults: MTP, useful checkpoints and verified reloads'
status: measured
---
The development app now uses the engine's qualified automatic MTP policy, a short-chat checkpoint schedule, foreground-aware readiness and session-scoped model verification. This addresses the integration gaps in [[records/measurements/sevra-app-speed-2026-09-23]]. Code and failed trials are preserved in [[sources/runs/2026/09/2026-09-23-sevra-app-optimizations]]. The policy and revision criteria are in [[records/decisions/sevra-app-speed-defaults-2026-09-23]].

## Final matched-input comparison

Three alternating pairs on the M5 Pro/48 GiB Mac using the pinned Qwen3.8-Flash-Next 4-bit model, MLX 0.32.2, and the 0.2.24 engine plus this development patch: 26 GB total budgets, 32,768 context, fixed 96-token replies and identical input histories:

| Turn | Plain writing tok/s | New policy writing tok/s | Plain reading | New policy reading | New policy reused tokens |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1 | 11.51 | 16.03 | 3.88 s | 3.91 s | 0 |
| 2 | 11.90 | 14.59 | 4.32 s | 5.94 s | 0 |
| 3 | 11.67 | 19.03 | 4.67 s | 3.40 s | 512 |

The median sum of prompt-reading and generation time across the three turns fell from **37.80 to 30.76 seconds**, an observed **18.6% reduction**. This includes the second turn's checkpoint-creation cost. It excludes model construction, UI overhead and the extra cold parity replay. Each within-policy cached result reproduced the cold output IDs exactly. MTP/plain text can differ, so this is matched token work and inputs, not a claim of identical answers across decoding methods.

These are live-machine diagnostic timings: global swap-ins occurred and thermal state varied between nominal and fair. No new README throughput anchor or hardware estimate is justified. The earlier three-arm screen found automatic MTP already supplied most of the generation gain. Fixed smaller batches were slower for longer inputs; the hybrid keeps larger passes there. The 9,295-token inventory took roughly 31 seconds to read across the screening arms, with correct answers. That screening omitted a small optional correction charge from planning; the final comparison includes it.

## What changed and what it costs

- MTP activates automatically only when its optional head is present and the fully charged plan qualifies. Both the head and configured lookahead correction fit inside the app's displayed total ceiling. The automatic Desktop ceiling stays 33 GB; custom ceilings remain adaptive. Smaller budgets retain ordinary decoding.
- Below 1,536 prompt tokens, compute passes are at most 512 tokens or the smaller live plan. This makes an eligible checkpoint available earlier. Longer prompts keep the planned schedule. The larger workspace reservation remains available; it is not silently spent on more experts. Creating a checkpoint can slow an earlier turn, and crossing schedules requires a fresh read when arithmetic is incompatible. Selection happens under the generation lock after a governor resize and is stable across a thinking continuation.
- Automatic readiness retains an already-loaded model while the app is foreground and has a visible non-minimized window. Background inactivity starts a fresh interval. Pressure, power saving and sleep retain their release behavior. This does not preload the model merely because the app opened.
- The first load still hashes the pinned files. Within one inference owner's lifetime, an unchanged APFS file-identity/size/mtime/ctime signature can reuse that successful proof. Changed or replaced files, optional-file changes, a new process and other filesystems require fresh hashing. No proof or private inference state is persisted by this mechanism.
- Immediate reloads wait only the remaining 1.05 seconds after model release before reading real availability. XNU's one-second shared statistics cache otherwise undercounted newly freed memory and disabled MTP in two reproduced reload checks. No synthetic availability credit or safety bypass is used. [Apple kernel source](https://github.com/apple-oss-distributions/xnu/blob/main/osfmk/kern/host.c) documents the caching window.

## Correctness and integration

All six real-model profiles passed: precise phase metrics with actual MTP drafts, MTP disk restore/private isolation/cancellation/tools/crossover, thinking with Answer now, complete cited Cedar document creation after exact synthetic-fixture review, 10-to-9 GB lifecycle behavior, and ordinary 10 GB disk reuse. The MTP reload restored 2,048 prompt tokens at the full 26 GB budget; its immediate load was 2.085 seconds. The small-budget warm disk hit read only 168 tokens. Session-proof tests reject same-size corruption even after restoring mtime, optional arrival/removal, file replacement, symlink retargeting and mutation during verification, and honor cancellation.

Native UI/runtime regressions, the final policy check, release builds, source-manifest verification, static gates and 73 engine catalogue checks (31,907 assertions) passed. The broader pure-policy sweep accepted 85 plans and safely refused 215. Functional acceptance is independent of global paging. The source changes preserve the independent CLI defaults and do not add another public release tag.

## Rebuilt app observation

The new development app was rebuilt and its bundled input manifest exactly matches the current source inputs. The final visible-app replay could not start because the Mac was locked; native UI control explicitly required manual unlock. These new rates come from the real engine and app-runtime checks, not a completed new UI replay. The earlier actual-app baseline remains unchanged.

## Remaining costs

First launch still pays pinned weight verification. Uncached or schedule-incompatible context still requires real prompt computation and expert reads. MTP adds head memory and speculative work, so smaller plans must keep the existing activation guard. Short-batch checkpoint creation has an up-front cost. No universal maximum, cross-hardware speedup, or free continuation after every short message has been established. Revisit these operating choices with repeated complete-workflow measurements and the same numerical, privacy, process-budget and lifecycle gates.
