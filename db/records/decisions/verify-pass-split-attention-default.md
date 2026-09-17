---
type: decision
id: 01m2r64g02d82yq05t4wy739xk
created: 2026-09-17T17:20:24.066873+00:00
updated: 2026-09-17T20:17:53.047737+00:00
summary: The speculative verify pass splits its attention from 6,144 tokens by default; the exact mode stays opt-in
decided_on: 2026-09-17
evidence: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
reversible_if: a quiet paired rung shows the dense verify kernel faster than the split above 6,144 tokens, or a long-prompt comparison shows speculative decode slower with the split; the exact mode becomes a default only if the parity references adopt its kernels and its speed cost is acceptable
title: The speculative verify pass splits its attention from 6,144 tokens by default; the exact mode stays opt-in
status: standing
---
Carlos asked for every candidate from the verify-pass investigation to be evaluated and for the improvements to be implemented on best judgment. This records the choices made under that delegation.

**Decision.** The speculative verify pass splits its attention into two-row vector-kernel calls from 6,144 tokens of context, as part of the deployment family (`InferenceOptimizations.integrationCandidate`). A pass of three to eight rows otherwise falls to the dense attention kernel, whose cost grows with the context. Below 6,144 tokens the dense kernel stays, because it is faster there.

**Evidence.** Paired in one process at k=3, the split minus the dense kernel measured +6.1 to +6.8 ms at 4,068 tokens, -1.7 at 6,116, -3.9 at 8,183, -7.8 at 12,279 and -11.2 at 16,356; the fetch-free pass is 32% cheaper at 32,740 tokens and 45% at 65,508. On one warm engine at the 22 GB default profile with a 16,356-token prompt, a verification round took 12% less time with the split in two runs, and speculative decode ran at 11.80 against 10.93 tok/s (x1.079) in the quieter one; with a 32,740-token prompt the split was 1.41 and 1.37 times the dense pass inside the rounds of the kept run. The split changes speed, not the guarantee: like the dense pass, its rows can round differently from one-row decode, and acceptance samples from the pass's own logits either way. Record: [[records/measurements/speculative-verify-pass-split-attention-2026-09-17]].

**Not made default.** The exact mode (`SLOTSTREAM_OPT_ROW_INVARIANT=1` with `SLOTSTREAM_OPT_VERIFY_SPLIT_CONTEXT=0`) makes speculative output identical to plain output in that mode for draft depths up to 4. It changes plain decode's rounding, so the Python parity gates and every stored golden would move, and it costs speed: plain decode ran 4 to 6% slower per token and a verification round 1 to 2% slower than split at 16k. It stays opt-in, held by `mtp-rowcheck` in `Tools/verify.sh` and by the `verify-pass-rows` catalogue check. The gathered-key attention and the fused hyper-connection read were measured and removed.

**Overrides.** `SLOTSTREAM_OPT_VERIFY_SPLIT=0` restores the dense pass at every context; `SLOTSTREAM_OPT_VERIFY_SPLIT_CONTEXT=N` moves the threshold, and `0` splits everywhere.
