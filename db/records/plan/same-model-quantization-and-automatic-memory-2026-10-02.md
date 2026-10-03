---
type: plan
meta-type: operational
id: 01m3yz0p8fprhjdshs3m6f82gy
created: 2026-10-02T18:46:22.223253+00:00
updated: 2026-10-03T05:35:05.684055+00:00
summary: Same Flash Next checkpoint, qualified quantizations, automatic selection with overrides, independent live memory management and measured hardware gates.
date: 2026-10-02
doc: plan
kind: milestone
level: '2'
order: '6'
title: Flash Next quantization and automatic memory implementation
---
Keep Qwen3.8 Flash Next as the same underlying model across the 16 to 64 GB Mac target range. Qualify a small set of weight representations, select one automatically for the Mac and its usable memory, and let the user override that selection and the memory ceiling independently. A separate runtime governor adapts allocations as system conditions change.

The engineering target is at least 20 committed generation tokens per second in each supported automatic profile. This is a target, not an achieved result or a guarantee for arbitrary manual settings, prompts, context lengths, SSDs, temperatures or competing applications. If a profile fails, keep that failure visible and continue the optimization work. Do not quietly lower quality, substitute another model or declare the hardware qualified.

Status on October 2, 2026: implementation in progress. The owner requested the full program after the three document review passes below. The initial bounded screen and existing-path memory fixes are implemented; bounded native complete-stack, 512-token prefill and greedy-sequence parity now pass; candidate serving and qualification are not complete. Candidate winners, performance, quality margins and new operating thresholds remain experimental. The original document review loaded no model; subsequent implementation measurements are recorded separately in [[records/measurements/quantization-screen-2026-10-02]].

### Implementation checkpoint, October 2

| Work | Implemented and checked | Still required |
| --- | --- | --- |
| Baseline and inventory | Frozen bounded screen, installed-pack pilot, complete pinned shard-header/config inventories for VQ 2.1, 3.2 and 4.4 | Representative workload/power pilot and held-out protocol; both 3.2 and 4.4 payloads and corrected reference traversal proofs are now verified |
| Candidate screening | Checked affine/VQ geometry, native Metal selected-row decoder, scalar row oracles, fused binding and complete-record composition parity, cost pilots, both projection shapes and affine width timings | Production generation/caching and complete-task quality; both native packs pass short, 512-token prefill, 16-step greedy and sparse-selection reference checks |
| Existing adapter | Explicit affine descriptors and rejection of malformed or inconsistent per-module overrides; pinned arithmetic unchanged | Full candidate family descriptors; the foundation binary passed the complete existing-engine battery |
| Current Mac memory controls | Preserve out-of-range saved ceilings; distinguish saved/applied/current memory; hold queued work after failed configuration; reject delayed UI revisions; revalidate queued Incognito requests | Candidate-specific cost ranges and configuration identity spanning pack, template, features and prepared resources |
| Quality instrument | Separate bounded full-vocabulary KL/top-1 scorer with hash/context validation and deterministic tests | Frozen noninferiority/latency rules, held-out tasks and confidence analysis; corrected matched outputs now favor continued VQ 3.2 engineering, without qualification |
| Product integration and promotion | Existing pack stays the supported path; no alternate pack is offered | Steps 4 through 10 below, including mixed-size residency, native PLE/draft integration, qualified Auto selection, transactional distribution and real-hardware rollout |

The materialize-then-multiply VQ prototype is a decoding and cost instrument. The recorded one-token kernel screen is much slower than the affine controls; it must not become the production decode path. This does not reject fused VQ. The follow-up fused binding passed selected-row bit equality against Python MLX and reached costs near the affine controls after removing redundant route synchronization. This is a component result. A bounded full-reference runner with quantized PLE row streaming now completes VQ 3.2 forwards. The corrected matched pilot now supports continuing VQ 3.2 engineering. Complete real expert composition and private array-context ownership now pass for both research packs. The first native dense block now passes the pinned candidate arithmetic and continuation checks. Direct native candidate checkpoint loading and a fixed short complete-stack/continuation comparison now pass for both packs. Complete 512-token prefill and its continuation now pass. A frozen 16-step greedy sequence also passes for both packs. Sparse selection through 2054 consumed tokens also passes. The next work is mixed-record storage before production generation and qualification. Its unknown quality/performance cannot justify moving product defaults early.

Reduced targets on the development Mac remain budget tests of that Mac. No other target hardware has been supplied to this implementation session. The hardware qualification rows and the 20-token target remain open; do not label this implementation checkpoint as completion of the whole plan.

### Reference and tokenizer checkpoint

The bounded VQ 3.2 reference, corrected traversal proof, native baseline logit exporter and native CPU PLE row checks are recorded in [[sources/runs/2026/10/2026-10-02-bounded-vq-reference-and-ple]]. Full-reference feasibility does not finish step 4: ordinary native prefill/generation, mixed allocation ownership and independent draft metadata remain open. The VQ 4.4 artifact has also been fully staged and verified through the pinned research downloader, without product activation.

The bundle tokenizer is an explicit configuration choice, not an incidental file. [[sources/references/2026/10/2026-10-02-vq-tokenizer-compatibility]] proves that the inspected VQ files tokenize a Hindi example differently from the original, despite matching vocabulary IDs and normalized merge order. The owned six-case logit pilot uses the original tokenizer and identical frozen tokens for all arms. Any supported pack must bind those chosen preprocessing bytes and qualify them; do not silently install the upstream bundle's different behavior. Source lineage, full-payload identity, numerical parity and task quality remain separate evidence.

The first complete matched pilot exposed a normalization convention mismatch in both VQ reference arms. [[sources/runs/2026/10/2026-10-02-vq-pilot-normalization-diagnosis]] preserves the invalid scores and the independent all-norm tensor audit. The raw VQ norms require one explicit BF16 +1 fold for the pinned architecture; the baseline already stores the folded values. Old VQ feasibility/proof results are not semantic model-correctness evidence. Fresh proofs and pilot runs bind the corrected normalization adapter, and the scorer refuses the old producer receipts. This is an instrument repair, not a relaxed quality or parity threshold. The corrected matched pilot is now complete in [[sources/runs/2026/10/2026-10-02-corrected-vq-distribution-pilot]]: VQ 3.2 has lower full-vocabulary KL in all six contexts and higher average top-1 agreement, with a multilingual top-1 regression. This is favorable screening evidence only. It does not complete the held-out/task or product-integration gate.

### Scope and relationship to existing work

This work implements [[records/decisions/same-model-automatic-quantization-with-overrides]] within [[records/design/sevra-maintained-model-integration]]. It narrows this optimization program to one checkpoint family; it does not reverse the wider product's ability to maintain different qualified models in the future. Compatibility support below 16 GB and optimization above 64 GB remain separate work.

Reuse the approved VQ direction in [[records/decisions/vq-weights-behind-qualification-gates]], including its September 30 correction. Preserve the completed work in [[records/plan/whole-engine-optimization-2026-09-04]], the prefill plan [[records/plan/n6-prefill-bound-the-pass-then-read-each-expert-once]] and the separate lookahead experiment [[records/plan/expert-lookahead-local-experiment-2026-09-10]]. Do not implement the same mechanism twice or reopen failed experiments without a new falsifiable hypothesis.

The simplest initial release is the existing 4-bit pack plus one demonstrably useful alternative, using the existing verified download pipeline. More packs are justified only when they win for a measured hardware or quality preference. There is no requirement to ship one pack per RAM tier, a generic model catalog, a GGUF backend or a new external runner.

### Current implementation and changes required

The code inspection baseline is repository commit `3fb9c3b`. Paths below are relative to the Slotstream repository; unprefixed engine filenames are under `Sources/Slotstream/`. Recheck these interfaces at implementation time because the plan is not a frozen fork of the code.

| Area | Existing behavior | Required change |
| --- | --- | --- |
| `Sources/Slotstream/Checkpoint.swift` | Global affine quantization fields and validation for the supported checkpoint, with n-gram grouping handled specially | Explicit, validated descriptors for each weight family and supported packing layout |
| `ExpertStore.swift`, `Plan.swift`, `SlotWritePlan.swift` | A fixed affine expert record, slot accounting, reservations and a shared CLOCK pool | Format-aware byte geometry, VQ-compatible allocation classes and exact reserve/pin/reclaim accounting |
| `Weights.swift`, `EmbeddingRows.swift`, `Layers.swift`, `NgramStore.swift` | Several independent assumptions about packed affine rows, scales and grouping | Audit every consumer; implement only qualified layouts, including bounded n-gram row decoding |
| `MTP.swift`, `MTPExpertStream.swift` | Draft loading and execution coupled to current model configuration | Independent draft metadata, compatibility identity and complete cost accounting |
| `PlannerCostModel.swift` | Costs and an empirical envelope for the existing pack and reference hardware | Per-pack costs, hardware-qualified evidence and explicit unknown estimates |
| `Governor.swift` | Live shrink/grow behavior, deadbands, pressure cancellation and safe mutation boundaries already exist | Retain these mechanisms; use the new byte ledger and test every supported allocation layout |
| `PinnedModel.swift`, `WeightStore.swift`, `SlotpackDownload.swift` | One pinned model and a verified, resumable download pipeline | A small allowlisted registry of immutable qualified packs and transactional activation |
| `apps/macos/Runtime/Performance.swift` and runtime integration | Automatic/custom memory controls already exist | Separate quant selection from saved ceiling, show actual applied configuration and schedule changes at safe boundaries |
| `Tools/serve_bench.py`, diagnostics and real app checks | Paired benchmark equality assumes the same artifact | Keep that gate and add a separate explicit cross-artifact quality/performance protocol |

CLI compatibility matters: `--memory-limit-gb` is the adaptive ceiling; `--memory-gb` selects the existing fixed-cache behavior. Do not silently reinterpret the latter or confuse these with the internal governor drill's `--max-memory-gb`. Keep existing library entry points, engine defaults and pinned clients working. Product Auto selection must be an explicit integration above the legacy pinned engine behavior.

### Candidate register and research limits

The first decision is which representations merit implementation, not which advertised bit count looks smallest. Compare full deployed packs, including the n-gram table, dense weights, metadata, codebooks, vision and optional draft weights. Download size, resident bytes and bytes read per generated token are different quantities.

| Candidate | Role in this program | Main uncertainty |
| --- | --- | --- |
| Current pinned affine 4-bit | Production baseline, compatibility path and rollback | Current costs and throughput need a fresh baseline for the tested binary and workload |
| Controlled affine 3-bit and 2-bit conversions of the same checkpoint | Cheap geometry and kernel screening; preserve sensitive families initially to isolate effects | Kernel support, group size, rounding and calibration may erase the byte advantage or damage quality |
| Flash Next VQ 2.1 and 3.2 builds | First-class candidates under the already approved VQ plan | Additional decode work, exact native support, mixed record sizes and whole-task quality |
| VQ 4.4 | Local quality reference required by the existing decision; a shipping candidate only if it independently earns a place | It is a quantized proxy for BF16, not BF16 ground truth |
| GSQ/RCO conversions of full Flash Next | Research comparator and potential later native export | Published GGUF layouts and conversion reproducibility do not imply native MLX compatibility |
| Swift variants | Separate fine-tuned checkpoint experiment, outside this same-checkpoint comparison | Changed training, behavior, licensing and deployment identity |
| Bonsai and pruned variants | Outside the primary path | Different model or capacity, so success would not establish this same-model promise |

The pinned VQ model card is preserved in [[sources/references/2026/09/2026-09-28-qwen-flash-next-vq-model-card]]. Its publisher reports VQ 2.1 close to their affine 4-bit conversion on a short prose evaluation, and VQ 3.2 closer to BF16. Those results are a reason to test, not proof of parity with Slotstream's deployed checkpoint or of reliable tool use. The advertised sizes include vision but exclude a separately distributed draft sidecar. Preserve those distinctions when comparing storage.

The verified VQ 2.1 headers in [[sources/references/2026/09/2026-09-30-qwen-flash-next-vq-expert-record-sizes]] establish three expert record sizes: 1,280,000 bytes in 37 layers, 1,382,400 bytes in nine layers and 2,611,200 bytes in the first two layers. Shared codebooks are additional allocations counted once per owner. Do not reuse these sizes for VQ 3.2 or 4.4 without inspecting their own pinned headers.

The [GSQ/RCO model card](https://huggingface.co/ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF) supplies narrow published quality results, not native Slotstream measurements. Affine-compatible values still need a proof of exact conversion into supported packing; IQ/codebook layouts cannot simply be relabeled as affine. [GSQ tooling](https://github.com/IST-DASLab/GSQ) must have a reproducible path for this exact checkpoint before becoming a shipping dependency.

[Swift 1.5](https://huggingface.co/ukisai/Swift1.5-Qwen3.8-Flash-Next) and [Ternary Bonsai 2](https://huggingface.co/prism-ml/Ternary-Bonsai-2-27B-mlx-2bit) do not resolve the same-checkpoint quantization question. Keep them in a separate comparison if later requested. Similarly, a TensorFold or OptiQ bit label is insufficient: inspect every tensor family's effective bits, group size, retained high-precision layers, n-gram treatment and draft support before admitting any artifact. A third-party conversion of the same checkpoint can enter the register after that inspection; a fine-tuned, pruned or different-model artifact cannot enter this same-checkpoint path merely because its name includes Flash Next.

Pin original checkpoint, conversion code, calibration data provenance, tokenizer, template, architecture reference and every file digest. A controlled affine candidate that keeps the current n-gram/trunk is a new artifact with its own evaluation. A VQ-experts-only hybrid is likewise a new artifact: it cannot inherit the full VQ pack's published quality or reference parity. Reproducing the full VQ pack includes its n-gram representation.

The VQ 2.1 evidence pins upstream revision `8684640a3956b01c47f5d47f9b999e2ab8b985f1`. Pin and review the applicable architecture code as data before implementing it; do not execute newly downloaded remote model code in the app. Resolve redistribution and product-use permissions for each exact checkpoint, sidecar and conversion dependency before publishing packs. Retain required notices and license hashes in the manifest. A model card label alone is not that review.

### Success contracts

Four independent contracts apply. Passing one cannot compensate for failing another.

1. **Numerical correctness:** the current affine path retains its existing exact gates. Each new representation matches its own pinned reference under a specified arithmetic contract, with deterministic goldens and bounded kernel checks. Cross-quantization token identity is not required and must not be mistaken for the reference-parity gate.
2. **Task quality:** candidates pass the strengthened VQ quality gate where applicable, real app basics and a held-out task suite against current 4-bit. Similar quality must include structured tool calls, long conversations and completed tasks, not prose perplexity alone.
3. **Memory correctness:** observed process footprint, transient peaks, reservations and pressure handling stay within the tested safety contract. Accounting includes GPU allocations and allocations during load, resize, prefill, vision and draft operation.
4. **Performance:** each automatic profile meets its declared context/workload and sustained speed gate, with TTFT and complete-task latency reported as well as committed generation throughput. Unsupported or unmeasured profiles cannot inherit another Mac's result.

Define committed generation throughput as accepted target-model output tokens, including generated reasoning tokens, divided by the corresponding generation interval. Exclude rejected speculative tokens from the numerator; include draft and verification work in elapsed time. Report visible-answer throughput and end-to-end request latency separately. Counting only visible tokens, only accepted fast intervals or raw draft proposals would change the promise.

Before collecting qualification data, freeze the tested prompt/context classes, generation length rules, cache state, reasoning/sampling settings, repetitions, thermal/power conditions, metric aggregation and uncertainty method. Use two complementary protocols: fixed-work diagnostic decoding for comparisons, and natural complete tasks for real latency and quality. Artificially forcing long outputs is diagnostic evidence, not a better task result.

Proposed speed gate: every required scenario in a declared profile must have a conservative lower confidence bound on its predeclared typical committed decode rate of at least 20 tokens/s. Also publish tail stalls and short-answer latency. Select the estimator and sample count from pilot variance before the held-out run. Treat repeated runs and task instances as the sampling units, not correlated tokens as independent observations; account for the required scenario comparisons. Freeze exact timer boundaries, including treatment of the first token produced during prefill, so numerator and elapsed interval describe the same work. This gate supports the stated tested envelope; it does not establish an instantaneous minimum for every token or every possible workload. If the intended public promise is literally every configuration and every instant, the present evidence cannot support it.

### Two independent automatic controls

**Selection control** chooses a qualified pack and initial resource plan at setup or an idle load boundary. Inputs include chip generation and class, RAM capacity, a current headroom snapshot, storage capability, requested context/features, installed eligible packs, saved user choices and qualified profile evidence. Physical RAM alone never determines the answer.

**Runtime control** adjusts allocations within the active pack and saved ceiling as memory conditions change. It preserves checkpoint identity, request settings and user choices. A pressure event must not trigger a download, model switch, hidden context truncation or a permanent reduction of the saved ceiling.

| Weight choice | Memory ceiling choice | Selection behavior | Live behavior |
| --- | --- | --- | --- |
| Auto | Auto | Choose the highest-quality qualified configuration meeting the declared speed and memory envelope; derive a conservative ceiling | Shrink and regrow within that ceiling and current safety bounds |
| Pinned supported pack | Auto | Keep the chosen pack; derive a feasible ceiling | Same governor, no pack substitution |
| Auto | Custom | Select among packs that fit the user's ceiling and requested features | Adapt below the saved ceiling; do not overwrite it |
| Pinned supported pack | Custom | Honor both if feasible; explain conflicts before allocation | Adapt within the ceiling; reject or stop safely if no safe plan remains |

Manual overrides expose the maintained supported packs, not arbitrary remote checkpoints. An override can waive a performance recommendation, not tensor validation or allocation safety. Label a valid but unqualified performance combination honestly. A new installation defaults to Auto. Migrate existing installs by preserving their installed pack and behavior until the user accepts the offered selection change; the older promise of no silent replacement remains intact.

Keep the existing distinction between an automatic ceiling derived from the supported hardware/pack policy and the smaller initial target permitted by current headroom. Busy startup must not permanently lower the automatic ceiling. A custom ceiling persists across restarts and temporary shortages. Quant selection, ceiling preference and live adaptivity need separate state fields; the current planner source enum alone cannot encode all three. Tuned automatic caps and hard allocation limits must be separately named, so an empirical default is not presented as a physical limit. Change current supported override ranges only with their own memory validation. Preserve [[records/decisions/adaptive-memory-limits]]: a custom ceiling can exceed the automatic default within the supported hardware bounds; fixed-cache knobs and `--no-elastic` retain their independent semantics. Do not add a live speed tuner that keeps consuming more RAM merely because it is free.

Keep four separately observable values: physical capacity, saved memory ceiling, current planned target and observed process footprint. Also show the active pack, requested/applied context, effective features and the reason for an automatic choice. A user-facing target is a planning budget. Charge controlled transient allocations inside its total envelope, including resize overlap. Separately account for bounded OS/runtime uncertainty through the existing safety margin and the measured footprint gate; do not create an unpriced permission to exceed a custom ceiling.

Derive the displayed minimum and maximum from the same pack/context/feature ledger used by admission. Keep the hardware maximum stable as other apps open; report current availability separately. If a pack or context change makes a saved custom value invalid, retain it visibly and require a valid selection before loading, rather than silently clamp the preference. Test boundaries immediately below/at/above the minimum, feature activation thresholds, the automatic ceiling and supported hardware maximum. Reuse the current first-use and saved-value migration behavior.

Do not select a smaller pack because of one noisy sample or select a larger pack after every memory recovery. Use a conservative load-time snapshot and retained profile selection; existing governor hysteresis handles transient pressure. Reconsider Auto at the next explicit load, relevant setting change or accepted qualified update. If the incumbent no longer fits at load time, propose or choose an already installed eligible pack under the user's Auto policy and show the applied choice. An additional large download requires the existing explicit offer/accept flow.

### Byte accounting and pool design

Replace arithmetic derived from a single `recordBytes` with an immutable validated layout descriptor. It names tensor shapes and dtypes, bit layout and padding, group sizes and axes, scales/biases, codebook ownership, row/record lengths, required alignment, tensor and expert file ranges and kernel compatibility. Preserve exact validated range coverage through Slotpack decompression, tensor indexing and asynchronous expert reads; reject path escapes and conflicting ranges using the existing bounded decoder rules. Checked arithmetic must reject overflow, overlaps, out-of-file ranges and unsupported mixtures before allocation or GPU dispatch. Test short files and corrupt metadata.

Build one ledger with these ownership categories: resident trunk and embeddings; n-gram cache and read staging; expert banks; shared VQ codebooks; KV and recurrent state; prefix cache; draft weights/cache; vision buffers; prefill workspace; read queues; allocator cache and bounded transient resize/load workspace. Count aliased unified-memory storage once. Measure physical-footprint consequences instead of adding RSS and Metal memory as though they were disjoint. A live replanning snapshot may credit this process with memory it would release, exactly once, while protecting non-reclaimable active state. Keep this credit distinct from the admission check for new incremental allocation, and never credit another process or file cache twice.

Admission uses the minimum of the user's ceiling, the validated resource policy and real current headroom, with explicit reserves. Metal's recommended working set is a bound or signal, not a measurement of free RAM. All internal byte math uses integer bytes; convert explicitly at GB/GiB display boundaries. An estimate above measured hardware or context evidence must be marked unknown or bounded, not emitted as a fabricated throughput curve.

For VQ, use compatible allocation classes or pages from the first useful prototype. Allocating every record at the largest early-layer size gives back most of the cache advantage. The approved starting geometry uses a 1,382,400-byte unit, with early layers in a larger class or requiring two units. Choose the final representation after a bounded prototype establishes actual MLX/Metal view and gather constraints. Two abstract units do not by themselves create a valid contiguous logical expert tensor.

Keep CLOCK as the initial eviction policy under [[records/decisions/clock-stays-the-eviction-policy]]; variable allocation geometry alone does not justify an unmeasured replacement policy. Separate class-capacity and fragmentation effects from policy effects in native replay.

An expert's complete record is the atomic cache item. Maintain logical expert-to-bank/offset mappings; reserve every required segment atomically; do not expose partly filled records. Pins cover the entire record until all GPU uses complete. Eviction, cancellation and shrink release all associated units exactly once. Shared codebooks outlive every dependent command. Neither speculative reservations nor optional prefetch may starve the minimum working set required by demanded experts.

Prove the minimum feasible pool from the maximum simultaneously pinned expert set of each admitted operation, including overlapping read/GPU work and draft execution. Reserve prefill sweep workspace separately. Reserve KV/recurrent growth through the admitted context limit, or use an explicitly bounded incremental reservation protocol before each growth operation. Pressure may reduce optional cache capacity, not the promised context of an admitted request. Record capacity stranded in size classes and fragmentation; a nominal total byte budget is insufficient if one required class is exhausted. Regrouping experts for kernels must restore routing/output order and the reference's numerical contract. Do not treat cache hits as permission to change arithmetic.

Preserve safe resize boundaries, generation fences and cancellation already present. Tag asynchronous reads, governor actions and pool mappings with the active configuration/pool generation. Ignore stale completions after resize or unload, drain GPU uses before reuse and verify cancellation cannot publish a record into a new pool. Shrink first reclaims optional caches, speculative reads and unused experts within the existing policy. If the committed working set cannot fit, cancel or defer new work safely and explain it. Never free pinned buffers to obey an impossible target. Growth waits for sustained headroom and fits peak old/new allocation overlap; otherwise grow incrementally or stay smaller. Preserve current thresholds until new measurements justify changes under [[records/design/measured-operating-policies]].

### Weight formats and execution

Start with exact-layout fixtures and representative layer microbenchmarks, then an end-to-end native path. Lower bit width is not automatically faster: padding, unpacking, scale loads, gather patterns, GPU occupancy, read amplification and changed cache hit rates all matter. The existing decode profile's read and GPU sample proportions are not a serial timing decomposition from which to promise an Amdahl speedup.

For affine trials, derive real payload sizes from the exact shapes and group sizes, including scales and biases. Check the pinned MLX runtime's support for each operation, not just whether a conversion utility accepts a bit count. Keep sensitive families unchanged for the first controlled trial, then evaluate any further family changes independently. Do not assume a 3-bit group-32 pack is cheaper than every 4-bit alternative after overheads.

For VQ, implement bounded expert decode/gather and n-gram lookup, retaining shared codebooks. Compare fused lookup/matmul with bounded unpack-then-matmul where both satisfy the reference contract; never materialize the full model or n-gram table. Match all supported packed integer encodings and padded dimensions explicitly. A header parser that accepts the pack is not an inference implementation.

MTP has its own pack identity, layout and measured memory cost. Do not decode draft weights with the target model's global bit setting. Test MTP off/on against the same target artifact, then compare each candidate's best qualified complete configuration to the deployed baseline including its existing MTP. Rejected drafts, extra verification reads and lost expert residency can make a smaller candidate slower overall. Preserve exact-mode contracts and distinguish them from sampled-distribution or batched-rounding tests.

Treat lookahead, prefix reuse, prefill sweep, n-gram cache sizing and allocator policy as interacting optimizations. Measure net task latency after their combined memory cost. Keep existing successful optimizations; do not credit their speed twice. Test a newer MLX runtime as a separate controlled variable before combining it with quantization, following [[records/decisions/kernel-upgrade-fidelity-and-cache-equivalence]]. The current runtime already includes optimized dispatch, so a version bump alone is not a speed argument. KV quantization and lower-precision activations are later, independent candidates because they alter cached state or arithmetic; neither inherits the weight pack's quality result. Reject unmeasured expert dropping, speculative token acceptance shortcuts and hidden context reduction as ways to reach the target.

### Evaluation design

Use sequential gates to avoid building a large product path for a losing candidate.

**Feasibility screening:** inspect pinned headers, compute actual storage/resident/record geometry, test pack decoding and representative kernels, and sample read amplification and cache behavior at safe budgets. Reject formats that cannot fit the minimum operating floor or cannot plausibly improve the measured bottleneck. Screen the approved VQ 2.1/3.2 layouts and an affine 3-bit control first; retain affine 2-bit as a lower-memory hypothesis only if its early quality evidence warrants more work. Do not commit to the engineering cost of every format before this screen. A kernel win or smaller file is not qualification.

Before full conversion or reference generation, write a local resource budget covering total download/staging/rollback disk, conversion RAM, reference-logit storage, compute time and expected run count. Prove that the VQ 4.4 reference can produce the required outputs within available memory using a pinned bounded execution path, sequentially with the candidate. If it cannot, obtain an exact reproducible reference artifact or measured hardware access; do not silently replace the mandatory reference with publisher summary scores. No paid compute is authorized by this plan.

**Reference parity:** keep existing affine goldens unchanged. For each candidate, freeze exact reference code, runtime, preprocessing and arithmetic mode. Verify representative tensors, every packing edge, layer outputs, model logits, greedy generation and relevant continuation/cache paths. Any permissible tolerance must be specified with rationale before observing candidate errors; do not relax the existing VQ exact-parity decision silently. If exact parity needs a policy revision, record that decision before qualification proceeds.

**Quality comparison:** measure current 4-bit and each candidate against the VQ 4.4 reference on identical frozen token contexts, including realistic tool and continuation states. Preserve the decision's KL/top-1 gate. VQ 4.4 remains a proxy; results against it are not a proof of BF16 equivalence. Full-vocabulary KL and a top-k approximation are different metrics. If reference storage is bounded with top-k logits, define residual mass handling and call the result an approximation; do not compare it numerically with an incompatible publisher scorer.

Add held-out complete-task evaluation: instruction following, tool schema validity and successful execution, coding fixes with tests, factual tasks, multilingual use, long-context retrieval/continuation and the product's ordinary workflows. Freeze prompts, environment, seeds/settings, graders and task-family weights. Keep calibration, pilot and final evaluation examples disjoint. Grade final outcomes and tool traces, not just the assistant's claims of success. Run `sevra-mac-checks --real-basics`; qualify vision separately before a profile can advertise images.

Proposed noninferiority margins for discussion are no more than two percentage points loss overall and five within a task family, with a predeclared one-sided paired confidence method. They are engineering proposals, not accepted evidence or universal definitions of similar quality. Choose margins that reflect product harm, estimate sample requirements from the pilot, then freeze the protocol before the held-out run. Structural safety and deterministic schema checks remain hard gates regardless of average score. Cap evaluation cost and handle multiple candidates/categories explicitly; inconclusive results do not qualify a pack. Do not keep sampling until a preferred candidate passes.

Use a first workload matrix of short first turns, multi-turn tool use, and total admitted contexts around 2K, 8K and the current Mac app's 32K default, with output space reserved inside the context limit. Test higher context limits only for profiles that expose them. Exact tokenized fixtures and generation lengths are frozen in step 1. Freeze maximum acceptable TTFT and complete-task regressions before candidate results, alongside the absolute decode target; a speed win cannot excuse an unbounded startup or prefill regression.

**Performance comparison:** interleave paired runs on the same actual Mac, binary, requested context, memory ceiling and workload. Preserve raw outputs and failures. Separate cold-load/first-use, warm operation, fresh prompts, prefix hits/misses, short/long prefill and sustained generation. Report TTFT, committed decode, task completion time, tail stalls, bytes read, cache hit/miss and read amplification, peak process footprint, pressure events, draft acceptance and power/thermal state. Report both equal-budget comparisons and Auto's actual recommended configuration so the result cannot be won by quietly granting extra memory or shrinking context.

`Tools/serve_bench.py` must keep its same-artifact output-equality check. Add a separate cross-artifact mode or harness whose result schema records both artifact identities and quality outcomes. It must not silently disable equality for ordinary regression runs. A changed completion length or routing trace is part of a quantization result, not a reason to discard a slow candidate. Fixed-work diagnostic results can isolate implementation cost but cannot replace natural completion results.

Clean timing eligibility and functional acceptance remain separate under [[records/decisions/global-paging-is-diagnostic]]. Record system paging, competing load and discarded timing reasons; do not fail a correct memory/governor run solely because global swap counters increased. Use one model process at a time, real reclaimable-memory preflight and the existing small explicit budgets for routine gates. Do not use memory-hog stress tests or simulated availability above actual headroom. Exceptional existing drills retain their exact documented preflights and sizes.

### Hardware qualification and honest simulation

The [[records/machines/macbook-pro-m5-pro-48gb|development Mac]] is an M5 Pro with 48 GB of unified memory. It is the first qualification machine, not a proxy for all supported Macs. Lower memory ceilings here test planner choices, allocations, cache residency, resize behavior and performance on this same chip and SSD at smaller budgets. They do not reproduce the bandwidth, GPU resources, storage, thermals or OS pressure of a real 16 or 24 GB Mac.

For 48 to 64 GB planning, retain conservative defaults and use bounded geometry estimates. A 64 GB machine can have different bandwidth and may spend extra RAM on context instead of expert residency. Do not simulate free memory above this Mac's real available memory or call an extrapolation a measured speed. Unknown hardware can retain the current validated safe policy; it cannot acquire a 20 tokens/s qualification badge from an estimate.

Build the minimum useful matrix around actual chip classes, not every retail SKU: a low-bandwidth base-class Mac near the low memory end, an intermediate Pro-class machine, the development M5 Pro, and a 64 GB target with its actual chip/SSD identified. Add classes whenever their hardware or tested behavior differs materially. Include 16/18/24/32/36/48/64 GB configurations only where those combinations exist and there is a reason to distinguish them; do not invent a uniform RAM ladder.

Each qualification row names exact chip, RAM, internal/external storage, OS/runtime/binary, pack and sidecar hashes, context/features, ceiling, cache policy and evidence. Record power mode and thermal conditions. A hardware-family rollout may extend only across a justified measured envelope; otherwise mark it provisional. Qualification is versioned with the deployed engine, kernels, pack and policy. A material change invalidates affected rows until their required checks pass again. Real hardware access is a dependency for universal coverage, not a reason to block useful engine work or to claim untested profiles pass.

Record format support, quality qualification, memory qualification and speed qualification separately. The existing baseline may remain a supported fallback without satisfying the new speed target. Unknown or failed evidence is never converted into a positive qualification flag.

The selection algorithm chooses among feasible qualified configurations by the user's required features, then the speed/latency gate, then quality, with deterministic tie-breaking by measured resource cost. Missing evidence is a separate state. If no candidate meets 20, retain a safe supported configuration and explicitly record the unmet target. Do not change model identity, lower the quality gate or hide the hardware row to manufacture success.

### Downloads and configuration transactions

Extend the pinned manifest registry and existing Slotpack verification rather than introduce a service that requantizes models per user. Publish reproducible prebuilt packs through the existing mirror, at immutable revisions with digest and decoder bounds. The app accepts only supported manifest versions and its trusted allowlist; a mutable upstream model card cannot redefine an installed artifact.

Registry entries contain model/checkpoint identity, quantization and layout version, component hashes, tokenizer/template identity, engine/runtime compatibility, optional features, on-disk sizes, load/transient resource requirements and qualification references. Draft and vision components are separate capabilities. An absent or corrupt optional component must not be reported as installed or silently change a pinned feature setting.

Use resumable range downloads, hash validation, atomic completion and an activation pointer. Preflight space for the installed pack, compressed/download staging, decoded output, temporary duplication and chosen rollback retention. Reflinks, hardlinks or cross-pack deduplication are optional later optimizations and may share only byte-identical immutable content. Do not make a content-addressed rewrite a first-release dependency. Never delete a pack still used by a request or another process.

A switch transaction is: resolve settings and candidate; validate compatibility/headroom/disk; obtain any required download acceptance; stage and verify; wait for an idle boundary; stop admission; release old runtime resources; load the new pack; perform a bounded health check; atomically commit the active identity/settings; resume admission. Keep only one model process/runtime allocation at a time. Recheck real headroom immediately before each large allocation, including after the old runtime is released and memory readings settle. If loading fails, release partial resources and restore the last known good applied configuration if it fits; otherwise remain unloaded with a clear recovery action. Mark the requested change failed without overwriting the saved preference. Work submitted for that failed requested configuration stays deferred or returns a clear error; it must not silently run against the rollback pack. Do not retain both models in RAM for rollback.

Persist enough transaction state to recover after interruption at every stage. Incomplete downloads cannot appear installed; a staged pack cannot appear active; an active pointer cannot assert a successful health check that did not finish. Rolling back weights invalidates incompatible derived caches but preserves conversations, files, memory, permissions and user preferences. User-selected old packs remain usable while supported; disk cleanup is explicit and never deletes user data.

Bind each admitted request to a configuration generation containing pack identity, tokenizer/template, arithmetic/runtime mode, context, features and resource reservations. Settings can be saved while busy, but applied settings change only at the boundary and the UI distinguishes them. Each in-flight request retains its previous ceiling until completion or explicit cancellation; the OS-pressure path can still force safe cancellation. Serial ownership covers request admission, settings activation and model lifetime so a newer preference cannot race an older load into becoming active. Revalidate queued work before admission; release or rebuild already prepared token/image resources if its configuration changed. Do not silently reinterpret a prepared request with another template.

Prefix/cache keys include all state that affects compatible computation. Preserve aligned continuation requirements and current same-artifact hit/miss goldens; different chunking is not assumed byte-identical. On cancellation due to pressure, tools already executed remain recorded. The runtime must not automatically replay an application turn or tool action as a side effect of reloading or shrinking memory.

### Implementation sequence and exit gates

| Step | Deliverable and dependency | Exit gate or failure action |
| --- | --- | --- |
| 1 | Freeze baseline, artifact inventory and experiment protocol | Reproducible existing-pack results and a resource ledger; no UI expansion yet |
| 2 | Cheap affine/VQ geometry, kernel and quality pilot | Rank plausible candidates using measured cost and quality; stop unsupported/losing formats early |
| 3 | Quant descriptors and compatibility API with existing 4-bit adapter | Existing acceptance battery and fixed clients unchanged; corrupt layouts refused before allocation |
| 4 | Native candidate pack path, mixed VQ allocation classes where needed, bounded n-gram support and separate draft metadata | Reference parity, record ownership/pin invariants, exact pack conversion checks and minimum-memory proof |
| 5 | Held-out quality plus paired complete-configuration performance, starting on the development Mac | A candidate wins on at least one intended real hardware class without failing quality, memory or latency gates; a loss on this Mac alone does not disqualify a low-memory specialist |
| 6 | Per-pack cost model and governor integration | Shrink/regrow, floor refusal, cancellation, prefix and feature interactions pass with unchanged saved choices |
| 7 | Deterministic Auto policy and independent overrides in engine integration, CLI diagnostics and Mac settings | Selection truth table, persistence, request-generation binding and legacy behavior pass |
| 8 | Transactional distribution, migration and recovery | Fault injection across download/verify/load/activate/rollback preserves one runtime and all user data |
| 9 | Real hardware qualification of the integrated release, profile registry and staged opt-in upgrade | Rerun affected gates after steps 6 to 8; every released profile has its own support evidence and explicitly records whether it reaches 20 |
| 10 | Default promotion, docs and release | Claims match qualified scope, old pack remains recoverable, monitoring is local and voluntary reports are user-reviewed |

Steps 3 and 4 may use a minimal experimental harness before product integration. The VQ reference and quality harness can be prepared during screening; neither requires shipping the pack. Steps 6 through 8 depend on a candidate earning product integration, although general existing-path memory defects found earlier should be fixed independently. External hardware collection can begin once the baseline protocol is frozen, without waiting for all UI work.

For each step, record code commit, exact artifacts, commands, machine, raw run paths, verdict, limitations and rollback. Capture raw measurement output under `db/sources/runs/` before interpreting it. Update canonical measurement/claim records and generated projections with behavior changes. There are no day estimates until pilot data reveals the kernel, conversion and hardware-access costs.

### Required failure scenarios

The following are release criteria, not optional exploratory tests:

- A custom ceiling below the pack's minimum yields a clear refusal before large allocation; a pinned pack is not silently replaced.
- Auto selects only installed/accepted qualified content and remains deterministic when telemetry is missing; an offline install stays usable.
- Memory falls during prefill, decode, vision preparation or draft verification; pins, resources and terminal request status remain correct.
- Memory recovers after shrink; the governor regrows only within the original saved ceiling, without a quantization change.
- One VQ size class is exhausted despite spare bytes elsewhere; required experts cannot deadlock behind optional prefetch.
- A resize would temporarily need both old and new banks; admission accounts for the overlap and retains a safe fallback.
- An old read or governor callback completes after resize/unload; it cannot mutate a new pool or resurrect released resources.
- The user changes pack, ceiling or context during a request; the active request keeps its bound settings and queued work is revalidated.
- A pack download is interrupted, disk fills, a range/hash is wrong or a component is missing; the current installation remains valid.
- The app quits between verification, unload, load, health check and activation; recovery never exposes a half-installed pack.
- A requested pack fails its health check; rollback is visible and work requiring the failed configuration does not run on the old pack.
- A new pack or runtime invalidates a prefix cache; durable conversation state survives and incompatible cache state cannot be reused.
- A pressure cancellation follows a completed tool action; recovery does not execute that action again automatically.
- A candidate passes prose quality but fails agent tasks, or reaches 20 only by disabling a required feature; it does not qualify that profile.

Use deterministic metadata/unit fixtures and bounded fault injection for lifecycle failures. Extend the existing `Tools/context_proxy.swift`, `Tools/memory_override_gate.py`, native performance checks and `Tools/check_sevra_memory_ui.sh` instead of building parallel memory-control suites. Check Mac Light, Dark and System appearances and clear pending/error states; preserve readiness preferences independently of pack and ceiling choices. Run the existing engine acceptance battery and real application checks for behavior that depends on the native runtime. Do not substitute tests that merely restate the implementation for end-to-end ownership and recovery checks.

### Review record and unresolved evidence

Pass 1, implementation and source contracts: checked the draft against checkpoint validation, embedding and n-gram consumers, draft configuration, geometry, governor growth checks, Mac performance preferences, planner costs, benchmark equality and the existing VQ decision. Added the independent automatic ceiling/current target state, retained custom-ceiling persistence, incremental allocation versus reclaim credit, bounded reference-generation feasibility and explicit resource budgets. The candidate register includes the previously omitted approved VQ path, mixed-size storage and n-gram requirements.

Pass 2, failure and state transitions: walked through all four preference combinations, pressure during active work, mixed-class exhaustion, late read callbacks, setting changes during load, failed activation, restart and rollback. Added generation-tagged read/governor actions, bounded context growth, a fresh headroom check at allocation, serial settings/admission ownership and explicit treatment of work queued for a failed pack. Rollback cannot silently defeat a manual override or replay a tool action.

Pass 3, whole-program and evaluation review: checked phase dependencies, the rollout path, cost, source limits and the meaning of the performance promise. Prioritized VQ screening alongside an affine control, separated runnable/quality/memory/speed evidence, removed a development-Mac-only win as the condition for a low-memory candidate, required final requalification after integration, and added a concrete context matrix plus frozen latency/statistical protocols. Kept one useful alternative as the initial shipping scope and preserved unresolved hardware/quality results as explicit gates. Document review establishes plan consistency, not model quality or performance.

Remaining experimental questions are explicit: which affine/VQ configuration wins; whether native VQ kernel overhead is acceptable; how n-gram and draft choices affect quality and memory; which same-model profiles can reach 20 on slower chips; and what quality sample size is affordable and decisive. Each has a gate above. If no same-model configuration meets the low-end target, report that conflict to the owner with the measured alternatives. Choosing a different model or changing the promise is a separate decision, not a hidden fallback.


### Native record checkpoint

[[sources/runs/2026/10/2026-10-02-native-vq-complete-records]] records exact complete expert composition for both packs and caller-context replacement regression checks. Experimental VQRecordBatch owns complete bounded records, and VQRecordLayout distinguishes geometry even when byte counts match. This is still immutable staging. Mutable banks, pins, required-read priority, cancellation/generation fences and resize overlap accounting remain open. Native dense-block arithmetic must explicitly match the pinned reference before full-model parity can be claimed; the deployed adapter's arithmetic remains the compatibility baseline.


### Native arithmetic checkpoint

[[sources/runs/2026/10/2026-10-02-native-vq-trunk-profile]] records exact first-block output/state parity for the byte-identical fixtures from both verified packs, and unchanged full-model baseline logits on one frozen pilot case. Candidate grouped normalization, query/key normalization, quantized injection and recurrence are explicit internal arithmetic choices. The deployed profile remains the default. This is an experimental block harness, not full candidate loading; QSA, PLE, draft/rollback, mixed pool ownership, held-out tasks and performance remain required before product integration.


### Direct-read foundation

[[sources/runs/2026/10/2026-10-02-native-vq-owned-file-reader]] establishes the native owned-descriptor primitive on bounded synthetic files. Complete payload verification, extent checks and cancellation precede publication of bytes. Authentication against the pinned pack inventory and wiring real routed expert/PLE reads are the next dependencies; the primitive alone does not complete native checkpoint loading or pool-generation fences.

### Authenticated short-stack checkpoint

[[sources/runs/2026/10/2026-10-02-native-vq-authenticated-checkpoint]] binds the owned file reader to both exact research artifacts and compares actual expert/PLE payloads with their fixtures. [[sources/runs/2026/10/2026-10-02-native-vq-complete-stack-smoke]] records exact hidden/state/logit equality through every layer for fixed passes of three tokens followed by one continuation. Both packs pass all 320 observed boundaries, including the complete vocabulary head. This is a bounded text arithmetic check, not ordinary prefill, generated output, sparse indexer activation, mutable caching or a throughput measurement.

[[sources/runs/2026/10/2026-10-02-vq-bf16-sigmoid-arithmetic]] preserves the first QSA-layer failures and their localization to BF16 sigmoid rounding. A candidate-only precise exponential with explicit BF16 intermediates matches the pinned Python finite-domain reference. The deployed arithmetic remains unchanged. Failed diagnostic attempts are preserved with the eventual FP64 test-input diagnosis. No public pack admission or selection changes follow from these component results.

[[sources/runs/2026/10/2026-10-02-native-vq-complete-stack-validation]] records the repaired exhaustive sigmoid gate, all 95 native T0/T1 checks passing with no skips, unchanged deployed full-model logit bits on the fixed memory-prose case, fresh baseline payload verification and six metadata rejection cases. The v7 inference sources are identical to the independently passing v4 complete-stack sources; only the diagnostic input/readback file differs. These checks do not replace the complete heavyweight app, governor and hardware qualification gates.

The frozen v7 complete static suite also passes in [[sources/runs/2026/10/2026-10-02-native-vq-complete-stack-static]], including planner, memory-override, transport and installer gates. The first attempt stopped on a source-wrapper token list interpreted as a wiki-link; the authored wrapper was corrected without changing its raw transcripts. This result applies to the authenticated short-stack checkpoint, before subsequent batched-route changes.

### Partitioned fused-route checkpoint

[[sources/runs/2026/10/2026-10-02-native-vq-partitioned-route-parity]] records bounded complete-record partitions with explicit original-batch arithmetic dispatch. Small local partitions cannot accidentally change the D8 reduction method. The component gates compare exact projection bits across the dispatch boundary, then exact complete SwiGLU at capacities of one, two, three and thirty-two experts, including duplicate routes and restored pair order.

Both pinned packs retain exact original short-stack outputs and pass a new eight-token pass plus three-token continuation through all 320 observed hidden/state/logit boundaries. Each larger run exercises two staging partitions and at most 32 live expert records per batch. All 95 native catalogue checks pass without skips. The source, artifact and reference identities are frozen. Compilation and these numerical/ownership checks cover this increment; the preceding full static suite is not claimed as freshly rerun.

This is synchronous immutable staging. It does not supply persistent residency, mutable cache pins, asynchronous generation fences, resize accounting or a production memory governor. The larger-batch upstream prefill path beyond 4,096 routed pairs remains a separate implementation/parity gate. Eleven functional tokens do not establish task quality, latency or committed generation speed.

### Segmented prefill component checkpoint

[[sources/runs/2026/10/2026-10-02-native-vq-segmented-prefill]] records the pinned large-prefill dispatch audit and exact native expert composition for both packs at 410 and 512 prompt rows. The actual default is fused segmented GEMM, with recorded kernel flags and executed variant names. The reference's fixed decoded-expert chunk of 32 affects only its fallback; it is not evidence that the admitted large-prefill path materializes decoded matrices. No prior measured outputs are retracted by this dispatch clarification.

The native wrapper uses the exact reviewed segmented kernel and its preprocessor specialization, preserves complete expert token segments across storage partitions, and restores routing order. Sixty-four real experts with skewed routes exercise two staging batches, partial tiles and both codebook placements. Complete SwiGLU outputs match exactly in both inspected layer families and both packs. All 95 native catalogue checks and the reference/source unit checks pass. These are component results with bounded process-memory supervision, not full-model prefill or timing qualification. Full-model attention, PLE and recurrent state at these batch sizes are the next parity gate; mutable residency, native generation, quality and speed remain open.

### Complete prefill checkpoint

[[sources/runs/2026/10/2026-10-02-native-vq-complete-prefill]] records exact complete-model prefill and one-token continuation for both research packs. All 320 full logical tensor boundaries match the pinned reference, including hidden output, recurrent/convolution state, PLE, QSA caches, indexer keys, final mixer and every vocabulary logit. The original 512-row head shape is retained. All 48 layers use bounded segmented expert staging, with at most 32 expert records live per batch. This remains a synchronous diagnostic with one dense block live at a time; its low process peak does not establish the production resident-memory floor.

[[sources/runs/2026/10/2026-10-02-vq-prefill-rotary-arithmetic]] preserves the initial QSA mismatch and the full investigation. Projection/normalization bits agree; differences start after rotation. Native inverse frequencies match fast Metal power, while explicit precise power matches the pinned Python frequencies. The candidate-only constructor now uses precise power; the public constructor retains deployed arithmetic. Dedicated native checks compare every inverse-frequency value and the first 512 FP32 angle rows. The earlier short tests remain valid for their original limited positions.

All 95 native catalogue checks pass without skips. Generated sequences, sparse indexer activation, persistent mixed-record ownership, draft, vision, quality and complete-configuration performance still gate subsequent integration. No candidate is admitted to production or Auto by this checkpoint.

[[sources/runs/2026/10/2026-10-03-native-vq-prefill-validation]] records the complete static suite passing on this frozen corrected prefill binary, including 420 memory-override cases, planner, transport and installer checks. Eight malformed full-prefill manifests are rejected before execution. Fresh original-pack verification succeeds, and its frozen complete-vocabulary memory-prose logit bits remain unchanged. This is scoped regression evidence, not candidate app/governor, quality or speed qualification.

### Greedy numerical checkpoint, October 3

[[sources/runs/2026/10/2026-10-03-native-vq-greedy-parity]] records both packs passing the frozen 16-step greedy feedback profile. Each implementation samples its own next token, then feeds that actual token into the next forward. Every sampled token and all 2,560 complete state/output boundaries per pack agree with its pinned reference. The 44-token literal prompt uses the original tokenizer. The final sampled token remains unconsumed, leaving 59 consumed tokens. Both runs reach the length cap; a real sampled EOS stop is outside this fixture.

Twelve broken fixture/profile/stop/CLI cases are refused before execution, and all 95 native checks pass without skips. Engine sources match the preceding fully validated prefill binary; this increment adds only the experimental diagnostic and CLI dispatch. The earlier full static result is not described as newly rerun. This establishes bounded autoregressive arithmetic, not a product generation service, persistent residency, draft, sparse long-context selection, completed-task quality or speed.


### Sparse-selection checkpoint, October 3

[[sources/runs/2026/10/2026-10-03-native-vq-sparse-selection]] records both packs passing the fixed 2053-token prefill plus one-token continuation. All 984 complete output/state boundaries agree with the independent reference, including the 24 actual Boolean sparse masks. Four large passes exercise segmented expert staging, and the final short pass and decode cross the selection threshold and partial block. This does not qualify the entire supported context range.

The native peaks are 3,136,752,112 bytes for VQ 3.2 and 3,130,771,904 bytes for VQ 4.4, within the 4 GB diagnostic process bound. All eight malformed-fixture cases and 95 native checks pass, alongside the five reference unit tests. Global swap counters are retained as diagnostics, with no clean timing claim. These bounds describe the one-layer-at-a-time probe, not a production resident-memory floor. Mutable caching, production generation, draft, vision, held-out task quality and complete-configuration speed remain required.
