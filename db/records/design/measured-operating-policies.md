---
type: design
meta-type: conclusion
id: 01m246aw461nyrejaspmzhxkms
created: 2026-09-09T22:59:04.454986+00:00
updated: 2026-09-14T13:38:59.335425+00:00
summary: Measured operating policies and revision criteria
date: 2026-09-09
doc: plan
level: '2'
order: '145'
title: Measured operating policies and revision criteria
---
Maintaining good operating choices is part of the product: model selection, inference, context, memory, responsiveness and resource use must work together. A useful default saves users from repeating the engineering investigation. It may deliberately leave capacity unused when further allocation has no demonstrated benefit. Best means the best-supported tradeoff for the stated objective and evidence, not proof of a universal optimum.

## Classify the number before changing it

| Kind | Meaning and revision rule |
|---|---|
| Model or format fact | An exact dimension, byte count or format requirement. Verify against the pinned artifact; do not tune it independently. |
| Safety or correctness bound | Protects physical feasibility, numerical validity or ownership. A performance preference never overrides it. |
| Qualification limit | Marks the configuration actually validated. Expanding it requires the corresponding acceptance gates, not merely spare capacity. |
| Operating default | Chooses a practical resource/performance tradeoff. Retain a justified default until evidence or an explicit change of objective warrants revision. Document any supported override and its consequences. |
| Estimator bound | Limits what a prediction may claim. Holding an estimate flat outside its verified range does not establish a flat physical response. |

A value can serve several roles; state each one and separate their controls. A manual operating override does not waive a safety or qualification limit. Some legacy explicit paths warn rather than refuse, so describe their actual behavior instead of inventing protection.

## Record the reasoning where it is used

For each important new or materially revised tuning value, keep a named code constant and a nearby explanation linked to a canonical record. Record:

- Purpose and units, including whether a budget covers the whole process or one component.
- Kind of limit and evidence basis: measured observation, derived arithmetic, bounded estimate or provisional engineering choice.
- Tested model/revision, engine/backend, hardware and workload scope, with links to evidence and failed or excluded runs.
- The objective and tradeoff, including costs displaced elsewhere in the stack.
- Automatic behavior, allowed override and consequences for resizing, safety checks and user control.
- The condition that would justify revision and the gate that checks implementation behavior.

Keep this proportional to the decision; this does not require a separate record for every loop literal. Existing records can own a coherent family of constants. Examples include expert-cache targets, prefill candidates, draft activation thresholds, I/O concurrency, context qualification and allocator allowances. Preserve their distinct evidence rather than treating every number as one type of cap.

## Make the best supported choice with incomplete evidence

Use first principles to identify the bottleneck and feasible alternatives, then the available measurements to choose a conservative default. More RAM, larger batches or greater concurrency can displace useful resources or hit another bottleneck. Unavailable target hardware does not itself invalidate the existing choice or require automatic benchmarking on every user's machine.

When a revision is justified, compare configurations with matched work, controlled warm/cold state and relevant context/draft settings. Measure user-visible time and the full resource cost; fewer cache misses or a faster estimate alone is insufficient. Freeze meaningful comparison criteria before scored runs and retain failures. Change the default only within its proven safety and correctness envelope. A simpler measured profile may suffice; a live tuner needs evidence that its benefit repays its complexity and transition cost.

## Memory ceiling example and maintenance

The base automatic total-process ceiling remains 33 GB. The clean development-Mac cache ladder showed diminishing returns near 120 to 150 experts/layer, and the target accommodates the chosen prefill workspace. An enabled draft head adds its separately charged cost. RAM share, Metal limits and live availability may lower the target. Explicit memory sizing bypasses the operating ceiling and pins the cache.

The original larger-target sweep evaluated an already-bounded prediction curve. It cannot prove that all larger allocations have no benefit. The existing ceiling is still a defensible default; no allocation change is justified merely by that limitation in the evidence. See [[records/measurements/automatic-memory-default-evidence-scope-2026-09-09]], [[records/decisions/auto-target-is-the-33-gb-knee-not-70-percent-of-ram]] and [[records/claims/auto-memory-target-ceiling-33-gb]].

Keep code comments, CLI help/diagnostics, policy checks, canonical decisions/claims and relevant README/guides aligned. Regenerate PLAN.md, MEASUREMENTS.md and llms-full.txt from their declared sources. Preserve historical source bytes and annotate interpretations through records. This policy documents ongoing engineering responsibility; it does not claim a completed audit of every existing constant or authorize new benchmarks, spending, telemetry or background tuning.

## Functional memory acceptance and benchmark eligibility

Global macOS paging is diagnostic for ordinary correctness, context-capacity and process-budget acceptance. It cannot attribute system activity to Slotstream. Keep process ceilings, real headroom, OS pressure handling, allocation safeguards and complete numerical/work checks; report paging separately. Performance comparisons retain declared clean-interval rules, and historical frozen results stay unchanged. The controlling decision is [[records/decisions/global-paging-is-diagnostic]].

## Public claim review

Claim-text gates detect stale phrases, not unsupported implications. Review
supporting sources and supersession notes before changing a public claim's
scope. Keep hardware, release, workload, total-process target, measured
quantity and comparison baseline together. An estimate is labeled where it
appears, including a table cell; capped extrapolation does not establish a
physical plateau. Simulated capacity is not hardware qualification, a version
bump is not publication, and a cache-only equality test does not cover changed
prefill grouping or speculative decoding. Preserve legitimate historical
results with their dates and limits instead of discarding an entire record
when only one of its measurements was withdrawn.

The documented correction and its verification are in
[[records/measurements/public-documentation-evidence-audit-2026-09-13]].

Best-effort public estimates may combine incomplete evidence when useful to
users. Give their construction and assumptions, separate actual measurements,
and state when a configuration is transferred to unmeasured hardware. Do not
present an editorial range as a calibrated confidence interval or speed bound.
[[records/measurements/hardware-planning-ranges-2026-09-13]] records the memory
range example and its revision conditions.

## Persistent prefix cache defaults
`serve --prefix-cache-dir` is off unless a directory is named, so none of these values changes a default server. They are provisional engineering choices for an opt-in tier, not measured optima.

| Value | Kind | Purpose and tradeoff | Override and revision |
|---|---|---|---|
| 20 GB quota (`PersistentPrefixConfiguration.defaultMaxBytes`) | Operating default | Bounds every head and row segment in the directory, applied when the directory opens and before each write. When it is full, states nobody continued go first, then previous-turn states kept for regenerating, then continued conversations, then prefixes several conversations start from, least recently used first within each; files from other builds do not survive opening. A conversation costs one recurrent-state head per kept turn plus its rows once, so a larger quota keeps more long conversations at more disk. | `--prefix-cache-disk-gb`. Revise from measured restart hit rates and real conversation sizes. |
| 2,048-token minimum (`defaultMinimumTokens`) | Operating default | Every write stores the fixed recurrent state; a conversation's first write also stores every cached row, and later turns add only their new rows. Shorter conversations save less prefill for the same fixed write, and each write adds disk wear. | `--prefix-cache-min-tokens`. Revise from measured save cost against prefill time across hardware. |
| 30-day maximum age (`defaultMaxAgeDays`) | Operating default | Conversation contents should not stay on disk indefinitely just because the quota has room. A state neither written nor restored for this long is removed when the directory opens and before writes; a longer age keeps older conversations resumable. | `--prefix-cache-max-age-days`; `0` disables. Revise from how long real users return to conversations. |
| Previous turn kept, older turns removed | Operating default | The kept state restores a regenerated or edited last reply after a restart without re-reading the conversation, for one more recurrent-state head; earlier turns are rarely resumed. | None. Revise if measured use shows edits further back. |
| Shared prefixes kept once, never replaced (`PersistentPrefixEntry.shared`, `PersistentPrefixValue.shared`) | Operating default | A state written inside a prompt at a boundary other conversations start with, its system message or the head it shares with a kept state, is exempt from the ancestor removal a later save of an extending conversation performs, so it outlives every conversation that started from it, and goes after conversations when the quota needs room. A shared prefix nobody started from is one-off, and a reply two conversations continue counts as shared too: lineages decide, not the flag. | None. Revise if measured directories fill with prefixes nobody returns to; the maximum age already removes those. |
| 512-token minimum shared prefix (`Generator.sharedPrefixMinimumTokens`) | Operating default | A shared save costs a GPU synchronize, a fork into the memory tier and, with the disk tier, one head plus rows; below this length the prefill it saves a later conversation is small next to that cost. Memory keeps shared prefixes from 512 tokens; the disk tier applies its own minimum length. | Library: `Generator.sharedPrefixMinimumTokens`. Revise from measured save cost against prefill time. |
| Shared save point: the last existing pass end at or before the boundary (`PrefillSchedule.lastPassEnd`) | Correctness bound | A shared prefix is written where a prefill pass already ends, the 256-token grid by default, never by splitting or reshaping a pass, so every arithmetic shape and every output stays identical to a run without the save; the next conversation processes up to one pass of the system prompt again. | None. A save at the exact boundary would need the rechunking numerical contract re-qualified. |
| 32 segments per head (`PersistentPrefixCache.maximumSegments`) | Operating default | Bounds the files one restore reads and how long replaced rows stay referenced; past it a write stores every row again. | None. Revise from measured restore cost and disk use on long conversations. |
| 2 GB free-volume margin (`PersistentPrefixCache.minimumFreeBytes`) | Safety bound | A save is skipped rather than filling the volume. | None. Not a performance value. |
| Identity: executable image digest, config digest, first and last 4 MiB of every weight file, cache geometry, optimization settings | Correctness bound | A state is restored only by the computation that wrote it; sampled weight content survives a copied model but rejects a different checkpoint with the same file sizes. | None. A cheaper identity needs evidence that it still rejects every changed computation. |
| CRC-32 per payload and header, rename without fsync | Correctness bound | A torn or corrupted head or segment fails its checksum and is removed with every state that uses it; it is never restored. Durability after a crash is best effort. | None. |
| Rows reused only through lineage (`State.persistedLineage`) | Correctness bound | A write references earlier rows only when its state descends from that persisted head without a rewind below it. Equal token ids never qualify: a re-prefill of the same ids produces other bits. | None. |
