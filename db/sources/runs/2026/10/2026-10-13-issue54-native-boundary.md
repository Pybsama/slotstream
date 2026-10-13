---
type: run
id: 01m4v2e83q80zqxzph2m59s9a6
created: 2026-10-13T16:44:56.311935+00:00
updated: 2026-10-13T16:44:57.453435+00:00
summary: Native trained-weight boundary probes pass on both local deployment and portable rotation paths; full model still cannot launch safely
binary: Final build-portable candidate identity and source archive in capture; public v0.2.29 for full-model planning
captured_at: 2026-10-13
command: See exact commands, source identities and drivers in the linked capture
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Issue 54 native boundary probes and bounded full-model refusal
tool: Native Swift diagnostics, Python driver, release doctor and T0 catalogue
---
Local continuation of issue #54 after Carlos asked us to do more investigation ourselves. [capture.tar.gz](../../../artifacts/issue54-native-boundary-2026-10-13/capture.tar.gz) contains exact native source snapshots and build identities, compiler failure/correction, all probe output and per-token measurements, selected trained-weight hashes, released-source equality checks, full-model planner/refusal evidence, T0 output and the process-lock check. Archive SHA-256: `5e31bc8e023cf55c62d10788784598c44a4f8f0f1bf8fecb311c8b3afb30ee24`. All 42 captured files, including the inventory, were packed; each inventoried member was hash-checked against the archive.

Builds used `Tools/optimization_build.py`'s existing `build` function with a 7 GB real reclaimable preflight, two compiler jobs and the model lock held throughout. The initial compile failed on an unqualified helper name. The correction and final environment-aware version built successfully; failed evidence is retained.

Final native commands: `slotstream optimization-state-check --variant context-boundary-component --json` against the original local model, once with a sanitized environment selecting deployment defaults, then in a fresh process with only `SLOTSTREAM_OPT_FUSED_ROPE=0` added. `run_profiles.py` preserves exact commands, identities, overrides and operating conditions. Each subprocess exited and was reaped before the next began. The native probe independently acquires the model lock and requires 4 GB reclaimable before loading its bounded weights.

The probe reads 34 trained attention tensors from the original checkpoint's first and last full-attention layers. It constructs deterministic synthetic hidden inputs, seeds actual KV/indexer storage through the existing projection/normalization/rotary/cache implementation to 32,704 tokens, then advances one token at a time to 32,832. Four rounds per layer include an initial shape/JIT-cold sweep, two repeats and one separately labeled synchronized-stage probe. The optional dense forecast readout is timed separately and must not advance state. Every later ordinary/instrumented output is compared byte-for-byte with that arm's first sweep; offsets and finite values are checked throughout. This does not compare output bytes between the two rotation arms or establish whole-model generation parity.

Both final arms pass 3,080 assertions. The preliminary native run also passes and is preserved. Global swap counters remain unchanged during each final native arm. `discarded: true` excludes these live-desktop component timings from clean performance qualification; functional checks remain valid. There is no M4 hardware run, complete language-model generation, routed-expert I/O, retained-conversation pressure test or energy measurement here.

The successor full-model protocol pins 640 expert slots, disables prefix retention, keeps 256-token prefill, MTP/vision off and a 33,792-token window. Doctor prices its full-workload envelope at 8,336,553,216 bytes, permitting a prospective 11.34 GB preflight while retaining more than 3 GB real headroom. It does not relax the original frozen 9 GB-target protocol. The attempt was refused before launch at 10.03 GB reclaimable, and the later recheck remained below the unchanged requirement at 10.91 GB. No full-model response exists.

The final binary also passes all 84 T0 checks, 38,821 assertions, zero failures/skips. Holding the real model lock causes the new probe to refuse before allocation. There is no product inference-default change, installed CLI replacement, release, issue closure or new GitHub comment.
