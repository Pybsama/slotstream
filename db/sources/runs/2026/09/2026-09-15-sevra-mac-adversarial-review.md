---
type: run
id: 01m2hpsa242path8xwmxh4rh2b
created: 2026-09-15T04:56:42.307941+00:00
updated: 2026-09-15T04:57:41.814970+00:00
summary: Adversarial Mac app review, corrected durability and tool boundaries, passing regressions, real-model failures and remaining qualification
binary: 389d744ea017c5441261a67600eb1bb5794930e9e0e31ce2987ac31c3a471c61
captured_at: 2026-09-15
command: bash Tools/check_sevra_mac.sh in frozen source snapshot; sevra-mac-checks --real; isolated native QA walkthrough; Tools/static_gates.sh with frozen root CLI
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra native Mac adversarial review
tool: Native UI, production runtime checks, real local inference and static gates
---
# Adversarial review of the native Mac development app

Verdict: substantial functional development code, with reproduced defects corrected, but not bug-free, fully qualified, public-alpha-ready or completion of the Mac plan. This review covers the implemented Mac application, runtime, persistence, source tools, inference adapter, local CLI and packaging, with explicit rows for unimplemented features. It does not qualify Windows or Linux. Cloud remains deferred.

The latest corrected composer, presentation and runtime suite passes. The latest real-model Cedar workflow did not pass. That distinction controls this receipt even though an earlier independently recorded Cedar run succeeded. No production installer, user Home migration or release publication was performed.

## Defects and corrections

| Priority | Finding and consequence | Correction and evidence |
| --- | --- | --- |
| P1 | Subsequent messages replaced the only retained run. Earlier saved documents and their citations became inaccessible. The baseline reproduced `This thread has no saved document.` | Retain prior runs in each thread; resolve Documents and citations by their original run, including promoted Home messages. Compact index and current-run IPC omit historical payloads. New regression and native historical-document/citation walkthrough pass. This does not reconstruct history already discarded by an older build. |
| P1 | Journal used a separate transient editor without the conversation coordinator's durable acceptance behavior. Overlapping saves could clear newer text or duplicate an entry, and unsaved text did not survive restart. | Use the production ComposerSession and a journal-specific revision/nonce adapter. Persist entry and remaining draft in one acceptance, preserve conflict/error recovery, flush on navigation/sleep/quit. Real dbmd delayed acceptance, duplicate/lost-acknowledgement and restart tests pass. Native double Save produced one entry; exact multiline Unicode draft survived quit and a new process. |
| P1 | Malformed model call sets could reach inconsistent handling; multiple proposals were ambiguous. The live Cedar replay exposed an unavailable tool spelling after successful reads. | Validate the complete set before any call; reject invalid terminal state, duplicate IDs, oversized/empty artifacts and combined proposals. Allow one bounded host schema correction for extra keys or a declared tool with `=` replacing `.`. Misspelled calls never execute as aliases. Unrelated tools, invalid effects and exhausted corrections still fail. Tests cover no partial execution, review, rejection and stale approval. Real-model replay of the spelling correction remains pending. |
| P1 | Invalid artifact/state input could write recovery intent before validation, leaving a Home that repeatedly refused recovery. | Validate publication and state identities before writing intent. Invalid filename/duplicate identity tests leave no poisoned recovery intent and reopen successfully. |
| P1 | Reconstructing an existing Home URL in a fresh process folded `/private/tmp` differently from the URL used to create it. Native launch refused the same Home although reuse of the original URL had passed a headless test. | Canonicalize again after directory creation and share that canonical path with runtime and IPC. Fresh-URL restart and both system aliases pass, while user-created symlinks remain refused. Native launch/relaunch then passed. |
| P2 | Memory admission duplicated an already admitted message; eligible memory text was silently cut after its first portion in model context. | Idempotent admission, full bounded saved text, refusal of empty/oversized/partial-response candidates. Context tests preserve a canary beyond the previous truncation. Native save/correct/Forget passes. Retrieval still selects recent eligible records, not a qualified semantic memory system. |
| P2 | Public mutations could run after shutdown began. | Guard mutators against a closed owner while retaining internal cancellation persistence. Closed-owner mutation tests pass. Interactive recovery after shutdown/storage refusal remains incomplete. |
| P2 | A throwing source-folder initializer explicitly closed a descriptor that its deinitializer also owned. Reuse could close an unrelated descriptor. | Remove duplicate ownership of the close. Repeated unsafe inventory and descriptor/UTF-8 boundary checks pass; this is an ownership correction, not a claim of a reproduced production descriptor-reuse incident. |
| P2 | Stop during full model-file hashing had no cancellation boundary. | Add backward-compatible cancellable WeightStore overloads; check between bounded reads and during status verification. Hash parity and cancellation tests pass without loading a model. Native Check reached verified-ready and Stop reached paused. The final refinement removes the redundant global error banner; that visual recheck remains pending. |
| P2 | Home displayed Queue when another thread was only awaiting review. A new thread created from Archived could be hidden. Closing Find could return focus to the conversation behind a document. | Exclude review-only state from Queue, reset the archive filter on destination selection, and restore the document responder after Find closes. The states were reproduced through native UI; final fixes compile, but their final native recheck was blocked by the locked screen. |

## Feature-by-feature coverage

A passing row means the stated checks passed, not that all possible states or hardware were exhausted. Scripted inference validates the runtime contract, not model intelligence. Earlier native receipts are referenced explicitly where this pass did not repeat an interaction.

| Feature | Evidence in this pass | Remaining qualification or missing behavior |
| --- | --- | --- |
| First launch and Home ownership | New disposable Homes, fresh-process canonical-path restart, writer exclusion, helper validation and bundle launch | Clean-machine first use; full Xcode-built target; supported-OS matrix |
| Composer and drafts | Production coordinator races, delayed/failing/lost saves and submissions, typing during acceptance, navigation, quit, restart, Unicode, draft conflict preservation | Full physical keyboard/IME, accessibility and long-session qualification |
| Home stream, paging and Search | Native Earlier/Newer across synthetic history; Search keyboard selection/Return; bounded-page and exact-copy tests | Long-Home loading, search and event-ledger cost; cross-page selection; automatic conversation windowing |
| Continue in thread | Full promotion/context/draft/permission/idempotence/restart regression; prior native real continuation receipt remains evidence | Arbitrary older-exchange selection and broader historical link UI are not complete |
| Thread lifecycle | Native rename with Unicode, pin, archive and reopen; queue/cancel/runtime admission tests | Final archived-filter and Queue visual rechecks pending |
| Inference and source-tool job | Real local model read both public Cedar files in each attempt; complete call validation and correction tests | Latest real job failed before review; spelling-feedback replay pending. Broader task reliability and same-hardware model comparison not qualified |
| Attachments and scoped reads | File/folder, sibling/symlink substitution, source identity/change, UTF-8 offsets and context budget tests; prior native file/folder picker receipts | Rich PDF/office extraction containment, complete attachment closure, fresh drag/drop matrix |
| Proposal review and Save | Native full proposal, retained citation inspector, double-click Save, exact file bytes; duplicate/reject/stale digest and create-only tests | User-edited/versioned artifacts and all portability lifecycle cases |
| Historical documents | Native Documents menu opens earlier file after a subsequent ordinary response; both earlier conversation and saved-document citations open retained excerpt | Recovery of already discarded old histories; large retained-history scaling |
| Markdown presentation | Native headings/lists/table/code in Light/Dark; exact-code, inert HTML/images, Unicode, references, bounds/cache tests | Sustained streaming/large-document performance, full table accessibility and selection/IME matrix |
| Copy/export/link review | Presentation exact-source and destination-boundary tests; prior native complete Markdown/code copy/export and reviewed-link cancellation receipt | This pass did not repeat every picker/copy/export route. Conversation export is not a complete Home backup |
| Personal memory | Native admit/correct/Forget, original evidence retained; duplicate/size/scope/full-context tests | Latest 12 eligible items, not measured semantic retrieval; longitudinal memory relevance/reconciliation |
| Journal | Native double Save, durable exact multiline Unicode, fresh-process restart; real runtime lost-acknowledgement and concurrent-edit tests | Large journal navigation, complete search/export and accessibility |
| Shared/thread-only/Incognito | Exact context fixtures, Forget suppression, native Incognito close and absence on disk, unbound IPC refusal | Full forensic erasure is not claimed; exported/copied data is explicitly outside Incognito retention guarantees |
| Automatic/custom memory and readiness | Full policy matrix, invalid settings, deferred/coalesced handoff, idle/release and draft-preservation tests; native controls/unloaded state | Earlier real memory-cycle receipt remains scoped evidence. Physical sleep/wake, thermal/OS pressure, supported hardware and latency matrix remain open |
| Model files | Native explicit Check completed against the existing pinned model; cancellation reached paused; hash/cancellation tests | Independent fresh full download, repair, cancelled acquisition and packaging qualification remain open |
| Light/Dark/System and brand | Native Light/Dark plus System setting, Observer/wordmark, settings and document inspection | Live OS appearance transitions, full contrast/assistive-technology certification, Finder/Dock and modern icon qualification |
| Commands, windows and focus | Native Search, Find/Escape, Settings, thread menu, quit/relaunch, journal draft persistence | Final Find responder fix recheck; complete VoiceOver/IME/window lifecycle matrix. Toolbar initial sizing warnings remain diagnostic follow-up |
| Persistence and recovery | Real dbmd, immutable events, four actual process-kill seams, invalid-save preflight, conflict/no-overwrite, fresh path restart | Interactive external-edit reconciliation, complete Home export/inert restore, storage power loss and scale remain open |
| Internal CLI and IPC | Authenticated Unix socket, peer/capability/refusal, long paths, current-run bounds, duplicate acceptance, detached completion, Incognito exclusion | Full public CLI grammar, historical event replay and optional authenticated network adapter |
| Skills, mini-apps and extensions | Compared implementation inventory with plan | Not implemented: installation/version/data migration/sandbox/permissions/lifecycle requirements remain plan work |
| Release and updates | All Mac products build; isolated QA bundle includes dbmd, Metal, fonts/licenses/icon and passes deep strict ad-hoc signature verification; separate static engine gates pass | Developer ID/notarization, installed updater/rollback, clean-machine support, voluntary feedback and external-user qualification remain incomplete |
| Cloud, accounts and analytics | No cloud/account/analytics behavior added by this audit | Cloud remains demand-led and outside the active implementation |

## Real-model failures and correction scope

The frozen prompt, public Cedar fixtures and acceptance rubric were not weakened. Each run used the bounded 10 GB local check after actual headroom and model-process checks. All three attempts read decision.md and launch-notes.md and failed before proposal review; none wrote cedar-briefing.md. The first error was generic, the second narrowed it to an unavailable tool, and the diagnostic build exposed `artifact=propose`. Earlier logs do not independently expose that exact spelling, so the diagnostic inference must not be presented as a verbatim observation from all three runs.

This audit also made artifact.propose's single-proposal response requirement explicit in its tool description before these real attempts. That prompt change may affect model output. The added schema correction does not establish that model behavior is fixed: scripted fixtures show one host feedback round can accept a subsequent valid response and still require review; only a fresh real replay can qualify the actual model. The latest real replay was not started because another task's decode sweep remained active, including between its individual model processes. No competing model was launched and no other task was interrupted.

The app still refuses conversation text beyond its current bounded context rather than silently discarding history. That is honest failure behavior, but it is not sufficient for the intended continuous Home experience. Full saved memory text improves recall fidelity but does not solve relevance, retrieval or context capacity.

## Native walkthrough and its boundaries

The synthetic Home contained a past saved document, a later response, a separate pending review, paged history and a journal draft. Native interactions exercised the rows above. Durable inspection independently confirms the reviewed artifact matches the full fixture, only one Save acknowledgement and journal entry exist, the exact Unicode journal draft remains, the renamed/pinned thread is reopened, past run metadata remains, both superseded and corrected memories are excluded, and no Incognito thread was persisted.

The first native launch failed due to the system-path alias defect. After correction, launch and a genuinely new process succeeded. CUA typeText initially omitted accented/emoji input; repeating with paste showed the correct text in the editor and exact disk bytes. That first input attempt was an automation limitation, not classified as application data loss.

The Mac locked again before the final Queue/archive-filter/Find-focus/quiet-cancel refinements could be rechecked. A fresh second synthetic Home remains available for those checks. The final source passed the complete scripted suite and was packaged into the separate QA bundle, then the idle audit process was stopped. The user's ordinary Sevra process and Home were left intact. The ordinary running app has not been replaced with every final audit correction.

The prior native pass is associated with the retained path-corrected source manifest below, not with the final corrected executable's UI qualification. Old executable hashes were not retained for each intermediate build. This limits exact-binary attribution of intermediate native and failed real runs; do not attribute those runs to the final executable merely because source snapshots are available.

## Build identity and concurrency

Repeated root builds were invalidated by concurrent engine edits, including a changed tuple shape and sources modified during compilation. A narrow tuple-consumer fix retained the other task's new tap field. Subsequent app work used a frozen local source snapshot with the original dependency pins. Initial resolution attempted a transitive upgrade; it was stopped and the original pins restored. Final builds used force-resolved versions. The snapshot Package.resolved originHash differs because its path identity differs, but its pins were verified equal to the real checkout.

The final snapshot app/runtime/presentation sources matched the real checkout at capture. Independent engine differences remain listed in final-identities.json. They were not overwritten. The separate static suite used a frozen root CLI, so its success is not a same-binary inference or model-quality qualification for the isolated app.

The QA bundle has identity com.sevra.mac.adversarial-audit and display name Sevra Audit, keeping test defaults separate. Its Info.plist differs from the normal product identity recorded in the source manifest only for that test identity/name. Ad-hoc signing changes the packaged executable hash; both unbundled product and bundle hashes are retained below. No timing samples below are promoted to clean performance claims.

## Required next verification

1. With the other model task finished and sufficient real headroom, run the unchanged Cedar real check on a fresh disposable Home using the final snapshot. Require the frozen rubric, real citations, review before file creation, exact commit and reopen. Preserve any failure.
2. Unlock the Mac and recheck final Home Send/Queue, new thread from Archived, Find focus, model-check Stop without duplicate error and native rejection on the second synthetic Home.
3. Qualify long-context/Home behavior and recovery/portability before inviting sustained personal use. Implement full Home export/inert restore and interactive external-edit reconciliation.
4. Finish the native accessibility/IME/load and hardware/lifecycle matrix, fresh model acquisition, and the signed installed-release gates. Implement the explicitly missing stable-plan features separately; this audit does not mark them complete.

## Retained raw evidence

The following blocks are copied from the recorded files. Negative-test diagnostics in the static suite are expected inputs to its final passing verdict. Failed real runs and invalidated builds remain preserved. Absolute paths refer only to this public development checkout or synthetic temporary fixtures; no user Home contents, credentials or model weights are included.

### sevra-audit-baseline.log

SHA256: `58df398ad7a60ca3dfee0cee97866693b981664900fadbf88a779e172782964f`

````text
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/4] Write sources
[1/4] Write swift-version--1AB21518FC5DEDBE.txt
[3/5] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (8.37s)
This thread has no saved document.

````

### sevra-adversarial-release-candidate.log

SHA256: `c7b78044e934229d5498a99a9cf0225cbd24f196b81134050dda8c68de327b61`

````text
warning: '--skip-update' option is deprecated and will be removed in a future release
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraRuntime HomeStore.swift
[4/5] Compiling SevraMac AppModel.swift
[4/6] Write Objects.LinkFileList
[5/6] Linking Sevra
Build of product 'Sevra' complete! (23.09s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/3] Compiling SevraLocal main.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-local
Build of product 'sevra-local' complete! (3.98s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/3] Compiling SevraComposerChecks ComposerChecks.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (4.90s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.28s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (8.43s)
PASS: Continue in thread saves Home before creation and rejects overlapping clicks
PASS: Continue in thread cannot create a destination when saving Home fails
PASS: old stale-snapshot sequence reproduces a rejected draft
PASS: back-to-back saves use acknowledged revisions without any display refresh
PASS: overlapping save callers coalesce edits and never write concurrently
PASS: undo to the previous saved text during an in-flight write persists the undo
PASS: debounce saves only the newest edit and cancels pending work after Send
PASS: Send before autosave atomically accepts the prompt and clears the older draft
PASS: Send waits for an in-flight save and preserves typing before acceptance
PASS: typing during acceptance survives the cleared draft receipt
PASS: edit-away-and-back while sending counts as a new draft
PASS: failed save keeps text, blocks navigation/close and clears only after recovery
PASS: lost save acknowledgement reconciles exact persisted text
PASS: failed Send and lost acceptance receipt reuse nonce without duplicating messages
PASS: an idempotent Send retry never erases a subsequently changed saved draft
PASS: revision-only conflicts recover silently and retry storms are bounded
PASS: real competing edits preserve both versions and require an explicit choice
PASS: another change during conflict resolution is not overwritten
PASS: navigation saves typing during destination loading and keeps drafts in their own threads
PASS: failed destination read leaves the current composer intact
PASS: close drains the in-flight writer before reporting safe to close
PASS: quit freezes edits during shutdown and restores editing when shutdown fails
PASS: mixed typing, clearing, Unicode, thread changes and sending retain exact drafts
PASS: discarding Incognito drains pending saves before changing owner
PASS: real dbmd persistence, atomic Send, stale-save refusal, external-edit/no-op refusal, exact reopen and Incognito exclusion
PASS: production journal coordinator, double Save, lost acceptance retry and exact entry/draft restart
PASS: 24 composer scenarios plus real-runtime persistence checks
PRESENTATION_RENDER_MS 24.452,0.340,0.256,0.457,0.287,0.508,0.298,0.262,0.263,0.263,0.250,0.250,0.258,0.278,0.254,0.255,0.248,0.447,0.264,0.246
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
PASS: fresh-URL Home restart, macOS system-alias IPC binding and user-symlink refusal
PASS: historical documents and citations, journal atomic acceptance and restart, duplicate/revision refusal and closed-owner guards
PASS: idempotent memory admission and complete eligible memory text in AI context
PASS: malformed termination, undeclared mixed calls and multiple proposals fail before execution
PASS: one bounded tool-schema correction, no partial execution, preserved review, exhausted-retry and unavailable-tool refusal
PASS: observed artifact=propose spelling correction without alias execution; rejection and stale approval refusal
PASS: invalid artifact and duplicate identities do not poison durable recovery
PASS: source Unicode boundaries and repeated unsafe-inventory cleanup
PASS: model verification hash parity and mid-read cancellation without model allocation
PASS: Home promotion selection, visible quotations, exact model context, idempotence, drafts, permissions, scope, restart, Forget, active-run refusal and external edits
PASS: memory plans 28 accepted / 59 safely refused; custom ceilings, unavailable readings, persistence, stable ranges and idle/pressure policy
PASS: deferred budget coalescing, queued submission during handoff, active release refusal, idle release and draft preservation
PASS: sleep cancellation, queued interruption, unload, admission guard, wake without replay and explicit recovery
PASS: context overflow preserves messages and refuses instead of silently trimming history
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget

````

### sevra-adversarial-static.log

SHA256: `d42a225862a0c69f8e9a707d2420e1f7754d5c19f313c7b03264eae8005079cb`

````text
........................
----------------------------------------------------------------------
Ran 24 tests in 21.420s

OK
..........
----------------------------------------------------------------------
Ran 10 tests in 7.668s

OK
................
----------------------------------------------------------------------
Ran 16 tests in 6.280s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 9.172s

OK
.......
----------------------------------------------------------------------
Ran 7 tests in 4.310s

OK
.........
----------------------------------------------------------------------
Ran 9 tests in 7.883s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.897s

OK
............................
----------------------------------------------------------------------
Ran 28 tests in 47.818s

OK
coverage ratchet checks pass
..{"phase": "starting", "prompt_tokens": 16, "reclaimable_gb": 20.0}
{"prompt_tokens": 16, "passed": false, "error": "ValueError: capacity rung was incomplete, aborted or over its plan"}
.......
----------------------------------------------------------------------
Ran 9 tests in 0.040s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 3.101s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.655s

OK
.....{"phase": "waiting for build reservation", "seconds": 0.0}
.
----------------------------------------------------------------------
Ran 6 tests in 0.008s

OK
..............
----------------------------------------------------------------------
Ran 14 tests in 1.480s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.000s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 0.002s

OK
..................................................
----------------------------------------------------------------------
Ran 50 tests in 0.022s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.030s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.006s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.000s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.003s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.017s

OK
..............................
----------------------------------------------------------------------
Ran 30 tests in 3.608s

OK
...........
----------------------------------------------------------------------
Ran 11 tests in 0.104s

OK
{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
.{"starting": "native/combined-plain"}
..{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
{"starting": "paired/sampled-short"}
{"starting": "paired/mtp-resource"}
{"starting": "paired/distinct-tail"}
{"starting": "paired/complete-repeat"}
{"starting": "paired/unique-with-retention"}
{"starting": "paired/actual-default-one-token"}
{"starting": "soak/off"}
{"starting": "soak/on"}
....{"starting": "native/combined-plain"}
.{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
.{"starting": "native/combined-plain"}
..{"starting": "native/combined-plain"}
..
----------------------------------------------------------------------
Ran 13 tests in 1.669s

OK
..........{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
.
----------------------------------------------------------------------
Ran 11 tests in 0.129s

OK
llms-full.txt is current
warning LOG_UNKNOWN_KIND log.md:124 — log entry kind `change` is not recognized
    hint: use one of: ingest, create, update, delete, rename, link, validate, index-rebuild, contradiction
warning LOG_OUT_OF_ORDER log.md:883 — log entry is older than the entry above it (possible rewrite)
    hint: append corrective entries; never reorder past ones
2 issue(s): 0 error(s), 2 warning(s), 0 info
MEASUREMENTS.md is current
PLAN.md is current
claims gate: 216 needle checks, 0 failures
BRAIN GATES PASS
dequant_row.txt: OK
layer_0.bin: OK
layer_1.bin: OK
layer_2.bin: OK
layer_3.bin: OK
ngram_ids.txt: OK
tokens.txt: OK
PASS  request VM counters are monotonic
PASS  request VM reclaimable bytes are available
PASS  process physical footprint is readable
PASS  process compatibility high-water is readable
PASS  lifetime RSS is separately readable
PASS  kernel lifetime footprint includes current allocation
PASS  statistics publish current and lifetime observations
PASS  statistics predating the lifetime footprint field still decode
PASS  monotonic duration is nonnegative
PASS  footprint sampler includes endpoints
PASS  automatic platform-qualified optimization defaults
PASS  qualified platform keeps the complete joint candidate
PASS  unqualified platform 0 keeps portable work and original rotation
PASS  unqualified platform 1 keeps portable work and original rotation
PASS  unqualified platform 2 keeps portable work and original rotation
PASS  unqualified platform 3 keeps portable work and original rotation
PASS  unqualified platform 4 keeps portable work and original rotation
PASS  unqualified platform 5 keeps portable work and original rotation
PASS  unqualified platform 6 keeps portable work and original rotation
PASS  unqualified platform 7 keeps portable work and original rotation
PASS  unqualified platform 8 keeps portable work and original rotation
PASS  unqualified platform 9 keeps portable work and original rotation
PASS  unqualified platform 10 keeps portable work and original rotation
PASS  unqualified platform 11 keeps portable work and original rotation
PASS  unqualified platform 12 keeps portable work and original rotation
PASS  platform selection is deterministic
PASS  explicit kernel qualification remains available
PASS  explicit kernel fallback remains available
PASS  reference control encoding omits unset automatic policy
PASS  old control JSON remains decodable
PASS  automatic policy survives saved control round trip
PASS  absent overrides preserve an inherited automatic policy
PASS  explicit automatic zero restores the chronological policy
PASS  explicit automatic one enables only that policy
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_READ_SCOPE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_INDEXER_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_PLE_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_TILE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_SCOPE_FRONTIER
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_PIECES
PASS  malformed automatic policy refuses/true
PASS  malformed automatic policy refuses/-1
PASS  malformed automatic policy refuses/2
PASS  malformed automatic policy refuses/
PASS  absent vision overrides retain inherited tiling
PASS  explicit zero padding leaves inherited tiling enabled
PASS  explicit zero query tile selects original vision attention
PASS  explicit padding overrides inherited tiling/80
PASS  explicit tiling overrides inherited padding/80
PASS  explicit query zero retains inherited padding/80
PASS  explicit padding with query zero remains valid/80
PASS  explicit query tile with padding zero remains valid/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  explicit padding overrides inherited tiling/128
PASS  explicit tiling overrides inherited padding/128
PASS  explicit query zero retains inherited padding/128
PASS  explicit padding with query zero remains valid/128
PASS  explicit query tile with padding zero remains valid/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/256
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/128
PASS  combined candidate preserves the original MTP verification shape
PASS  absent overrides retain the selected default family
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit zero disables only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit one restores only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit zero disables only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit one restores only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit zero disables only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit one restores only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit zero disables only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit one restores only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit one restores only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit zero disables only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit zero disables only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit zeros restore the complete reference inference family
PASS  explicit numeric zero disables inherited prefix retention
PASS  non-optimization environment leaves the family intact
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_COMPLETE_PROMPT": "false"]
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_TYPO": "0"]
PASS  valid inherited read scope retains its prerequisites
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_STATE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_MTP
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_INDEXER_TILES
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_PLE_TILES
PASS  scope can be disabled while retaining its other independent work
PASS  public environment function value keeps its signature and automatic default
PASS  typed override enables compaction
PASS  malformed override refused
PASS  unknown optimization refused
PASS  invalid read scope -1 refused
PASS  invalid read scope 1 refused
PASS  invalid read scope 16384 refused
PASS  invalid read scope bad refused
PASS  unbounded read scope refused
PASS  explicit workspace tile is recorded
PASS  unbounded workspace tile refused
PASS  terminal output needs no speculative draft
PASS  draft count fits remaining output
PASS  public depth cannot exceed recording cap
PASS  negative remaining output cannot underflow
PASS  prefix cache reaches its four-entry bound
PASS  an identical history replaces instead of duplicating an entry
PASS  a miss evicts before allocating a fifth state
PASS  a smaller live token ceiling evicts immediately
PASS  held GB includes fixed recurrent state
PASS  growing hit still reuses its state
PASS  growing hit reserves future state before allocation
PASS  huge reservation safely misses
PASS  huge reservation releases held state
PASS  capacity reservation still hits
PASS  capacity growth reserves bytes before reuse
PASS  saturated byte reservation evicts safely
PASS  identical bytes hash alike
PASS  different bytes do not
PASS  the same image at the same offset matches
PASS  a swapped image does not
PASS  an entry ending inside a run still matches that run
PASS  a text-only entry rejects a prompt with an image inside its range
PASS  an image beyond the entry's range is irrelevant to the match
PASS  a vision conversation is held, not discarded
PASS  the same ids with a different picture miss
PASS  the text-only splice never sees a vision entry
PASS  prefix splice chooses the longest retained extension
PASS  prefix splice is strict, not an identical-history match
PASS  prefix splice lookup does not consume the retained state
PASS  a disabled prefix cache offers no splice
PASS  shard listing works through a symlinked model dir
PASS  8.1 GB plan stays inside its target
PASS  10.0 GB plan stays inside its target
PASS  16.0 GB plan stays inside its target
PASS  30.0 GB plan stays inside its target
RUNTIME CHECK PASS
{
  "device": "Apple M5 Pro",
  "exit_code": 0,
  "failures": [],
  "maximum_live_gpu_buffer_bytes": 201326592,
  "model_loaded": false,
  "observations": [
    {
      "lifetime_rss_peak_bytes": 13090816,
      "phase": "baseline",
      "physical_footprint_bytes": 4342360,
      "reported_peak_bytes": 13074432,
      "sampled_peak_bytes": 4342360
    },
    {
      "lifetime_rss_peak_bytes": 15106048,
      "phase": "transient_128_mib",
      "physical_footprint_bytes": 198967968,
      "reported_peak_bytes": 198967968,
      "sampled_peak_bytes": 198967968
    },
    {
      "lifetime_rss_peak_bytes": 15106048,
      "phase": "transient_freed",
      "physical_footprint_bytes": 64750240,
      "reported_peak_bytes": 198967968,
      "sampled_peak_bytes": 198967968
    },
    {
      "lifetime_rss_peak_bytes": 15122432,
      "phase": "persistent_64_mib",
      "physical_footprint_bytes": 131875488,
      "reported_peak_bytes": 198967968,
      "sampled_peak_bytes": 198967968
    },
    {
      "lifetime_rss_peak_bytes": 15122432,
      "phase": "persistent_plus_transient",
      "physical_footprint_bytes": 266093216,
      "reported_peak_bytes": 266093216,
      "sampled_peak_bytes": 266093216
    },
    {
      "lifetime_rss_peak_bytes": 15122432,
      "phase": "persistent_after_transient_freed",
      "physical_footprint_bytes": 131875488,
      "reported_peak_bytes": 266093216,
      "sampled_peak_bytes": 266093216
    },
    {
      "lifetime_rss_peak_bytes": 15122432,
      "phase": "all_gpu_buffers_freed",
      "physical_footprint_bytes": 64766624,
      "reported_peak_bytes": 266093216,
      "sampled_peak_bytes": 266093216
    },
    {
      "lifetime_rss_peak_bytes": 23527424,
      "phase": "cpu_allocation_after_gpu_peak",
      "physical_footprint_bytes": 73171616,
      "reported_peak_bytes": 266093216,
      "sampled_peak_bytes": 266093216
    },
    {
      "lifetime_rss_peak_bytes": 23527424,
      "phase": "after_concurrent_reads",
      "physical_footprint_bytes": 64996000,
      "reported_peak_bytes": 266093216,
      "sampled_peak_bytes": 266093216
    }
  ],
  "passed": true,
  "source_sha256": {
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Tools/process_memory_check.swift": "17c4ee5dfdff19b1bc467ad896047f6cc8c35d27850d1a62b88f39ea59ff704b",
    "Tools/process_memory_gate.py": "4eb64b24a9fe7d25ac6c970da91688751303a5cc7dd6d2fc340486220b3fdb58"
  }
}
PASS  matching file is accepted
PASS  same-size corruption is rejected
PASS  exact Content-Range is accepted
PASS  wrong range start is rejected
PASS  wrong range total is rejected
PASS  unknown range total is rejected
PASS  every pinned file has a digest
PASS  the draft head is pinned as the one optional file
PASS  an absent optional file is not a repair; an absent required one is
PASS  an empty directory reads as missing
PASS  missing needs the required model
PASS  status carries free disk
PASS  bytesToFetch agrees with required files
PASS  a missing copy is not ready
PULL CHECK PASS
.......
----------------------------------------------------------------------
Ran 7 tests in 0.013s

OK
{"bf16_predictions":16711680,"centers":1000000,"roundtrips":60,"malformed_inputs":39583,"pass":true}
MANIFEST CHECKS PASS
{"name": "normal", "pass_": true, "seconds": 0.308, "returncode": 0}
{"name": "cache-miss-reporting", "pass_": true, "seconds": 0.043, "returncode": 0}
{"name": "redirect", "pass_": true, "seconds": 0.039, "returncode": 0}
{"name": "bad-object-fallback", "pass_": true, "seconds": 0.047, "returncode": 0}
{"name": "missing-object-raw-fallback", "pass_": true, "seconds": 0.054, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.021, "returncode": 1}
{"name": "raw-ignored-range-fails", "pass_": true, "seconds": 0.024, "returncode": 1}
{"name": "optional-absent", "pass_": true, "seconds": 0.043, "returncode": 0}
{"name": "optional-corrupt-and-unavailable", "pass_": true, "seconds": 0.042, "returncode": 0}
{"name": "bad-object-fails", "pass_": true, "seconds": 0.024, "returncode": 1}
{"name": "retry-after", "pass_": true, "seconds": 0.044, "returncode": 0}
{"name": "hugging-face-rate-limit", "pass_": true, "seconds": 5.208, "returncode": 0}
{"name": "cancel-during-hugging-face-rate-limit", "pass_": true, "seconds": 0.426, "returncode": 1}
{"name": "transient-retry", "pass_": true, "seconds": 5.215, "returncode": 0}
{"name": "wrong-length-fallback", "pass_": true, "seconds": 11.215, "returncode": 0}
{"name": "short-body-fallback", "pass_": true, "seconds": 35.443, "returncode": 0}
{"name": "content-encoding-fallback", "pass_": true, "seconds": 35.959, "returncode": 0}
{"name": "cancel-preserves-progress", "pass_": true, "seconds": 1.417, "returncode": 1}
{"name": "damaged-resumed-chunk-rejected", "pass_": true, "seconds": 0.052, "returncode": 1}
{"name": "damaged-resumed-chunk-repair", "pass_": true, "seconds": 0.066, "returncode": 0}
{"name": "resume", "pass_": true, "seconds": 0.071, "returncode": 0}
{"name": "already-installed", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "valid-symlinks-reused", "pass_": true, "seconds": 0.032, "returncode": 0}
{"name": "corruption-seed", "pass_": true, "seconds": 0.097, "returncode": 0}
{"name": "same-size-final-repair", "pass_": true, "seconds": 0.061, "returncode": 0}
{"name": "invalid-resume-map", "pass_": true, "seconds": 0.078, "returncode": 0}
{"name": "forged-complete-map-without-parts", "pass_": true, "seconds": 0.08, "returncode": 0}
{"name": "oversized-map-is-discarded", "pass_": true, "seconds": 0.085, "returncode": 0}
{"name": "part-symlink-rejected", "pass_": true, "seconds": 0.012, "returncode": 1}
{"name": "part-hardlink-rejected", "pass_": true, "seconds": 0.014, "returncode": 1}
{"name": "part-fifo-rejected", "pass_": true, "seconds": 0.013, "returncode": 1}
{"name": "concurrent-writer-rejected", "pass_": true, "seconds": 0.016, "returncode": 1}
ALL HTTP CHECKS PASS
{"name": "raw-multichunk", "pass_": true, "seconds": 0.954, "returncode": 0}
{"name": "raw-installed-no-http", "pass_": true, "seconds": 0.491, "returncode": 0}
{"name": "raw-source-fallback-missing", "pass_": true, "seconds": 0.709, "returncode": 0}
{"name": "raw-source-fallback-wrong-range", "pass_": true, "seconds": 0.818, "returncode": 0}
{"name": "raw-source-fallback-encoding", "pass_": true, "seconds": 41.036, "returncode": 0}
{"name": "raw-source-fallback-ignore-range", "pass_": true, "seconds": 0.568, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.052, "returncode": 1}
{"name": "raw-corrupt-final-rejected", "pass_": true, "seconds": 0.275, "returncode": 1}
{"name": "raw-optional-inflight-writers", "pass_": true, "seconds": 0.324, "returncode": 0}
{"name": "raw-cancel", "pass_": true, "seconds": 3.315, "returncode": 1}
{"name": "raw-resume", "pass_": true, "seconds": 0.541, "returncode": 0}
{"name": "raw-same-size-repair", "pass_": true, "seconds": 0.771, "returncode": 0}
ALL RAW HTTP CHECKS PASS
SUSTAINED MEMORY PASS 344440832 bytes peak RSS
SLOTPACK GATES PASS
PASS  48GB pristine: 33.0 GB target and starts quiet
PASS  48GB busy: clamped to 15.4 GB, sized-down note
PASS  16GB pristine: 9.8 GB target, no notes
PASS  16GB busy: refuses an unphysical minimum allocation
PASS  8GB Mac: refuses an unphysical minimum allocation
PASS  128GB auto stops at the knee, not at 70% of RAM
PASS  128GB explains the measured basis for its default
PASS  128GB: --memory-gb still reaches full residency
PASS  --sim-ram alone plans instead of erroring
PASS  --max-ram-percent lowers the auto target
PASS  --max-ram-percent cannot exceed the knee
PASS  --max-ram-percent 0 refused
PASS  --max-ram-percent 150 refused
PASS  --max-ram-percent noted when outranked
PASS  more memory never plans slower (7-90 GB sweep)
PASS  explicit total target cannot authorize unavailable memory
PASS  --experts-per-layer 0 refused
PASS  --pool-gb 0 refused
PASS  --memory-gb below minimum refused
PASS  --memory-gb inf is a clean error
PASS  --pool-gb inf is a clean error
PASS  --pool-gb 1e300 saturates safely instead of trapping
PASS  --memory-gb 1e300 refuses physical overcommit without trapping
PASS  huge finite memory plan remains valid JSON
PASS  --sim-ram inf is a clean error
PASS  --sim-working-set inf is a clean error
PASS  --sim-available inf is a clean error
PASS  tiny pool raised to the floor, consistently
PASS  knob precedence noted, never silent
PASS  --model with no safetensors: clean error
PASS  --model with no safetensors: names the fix
PASS  MTP auto on a big quiet machine: knee + head = 34.6
PASS  MTP auto stays off on a 16GB machine
PASS  MTP auto on at --memory-gb 30 (137/layer after the charge)
PASS  MTP auto on at --memory-gb 22 (above the 76/layer floor after the charge)
PASS  decode lookahead rides the head at --memory-gb 22
PASS  32 GB Mac: auto runs the head and the lookahead
PASS  24 GB Mac: auto runs neither
PASS  32 GB Mac at 65,536 tokens runs without the head
PASS  36 GB Mac at 65,536 tokens keeps the head and the lookahead
PASS  MTP auto off at --memory-gb 16 (below the 76/layer floor)
PASS  SLOTSTREAM_OPT_EXPERT_PREFETCH=0 keeps the head without the lookahead
PASS  decode lookahead charge visible in json
PASS  --mtp on forces the head onto a small machine
PASS  a head forced below the floor runs without the lookahead
PASS  --mtp off suppresses it everywhere
PASS  --mtp on without mtp.safetensors is a clean error
PASS  --mtp on cannot squeeze under the minimum target
PASS  --mtp gibberish refused
PASS  MTP charge visible in json peak
PASS  --model with unparseable config: clean error
PASS  invalid config arithmetic is rejected before it traps
PASS  --model with a corrupt safetensors header
PASS  safetensors dtype/shape byte mismatch rejected
PASS  safetensors header over 100MB rejected before allocation
PASS  --model with a different model's tensors
PASS  serve --max-context 0 refused before load
PASS  plan announces the context cap and the wait
PASS  doctor --json carries max_context_tokens + wait
PASS  serve --max-context above the ceiling names the ceiling, not a knob
PASS  doctor --max-context above the ceiling is the same clean error
PASS  a lower --max-context caps the reuse ceiling too
PASS  16 GB Mac: automatic window is 32,768
PASS  24 GB Mac: automatic window is 32,768
PASS  32 GB Mac: automatic window is 32,768 (65,536 drops the head)
PASS  36 GB Mac: automatic window is 65,536
PASS  48 GB Mac: automatic window is 65,536
PASS  64 GB Mac: automatic window is 131,072
PASS  96 GB Mac: automatic window is 262,144
PASS  128 GB Mac: automatic window is 262,144
PASS  --max-context auto is the default
PASS  a fixed cache size keeps the default window
PASS  an explicit window is reported as explicit
PASS  128 GB: the window rides above the knee and doctor marks the choice
PASS  a busy big Mac lowers the automatic window and keeps the head
PASS  an explicit window too large to retain says how much follow-ups reuse
PASS  automatic window JSON lists every candidate and retains the chosen window
PASS  serve --max-context auto is accepted by the parser
PASS  an unparseable --max-context is refused
PASS  prefill-schedule: full model window obeys the product without exemptions
PASS  prefill-schedule agrees with the doctor wait for the same pass
PASS  prefill-schedule: a prefix hit reads only what is new
PASS  prefill-schedule --chunk 0 refused
PASS  context-check --tokens 4 refused before load
PASS  parity rejects an invalid layer count before model load
PASS  parity rejects malformed token ids without trapping
PASS  n-gram golden rejects malformed token ids without trapping
PASS  dequant golden rejects a negative row before model load
PASS  sampler golden rejects an empty vocabulary without trapping
PASS  sampler golden rejects a negative draw count without trapping
planner: passed 90, failed 0
{
  "passed": true,
  "model_loaded": false,
  "hardware_qualified": false,
  "binary_sha256": "661632d4545af0c823b0af10ab08e48dd19675f17ba9b8c5f8abff64646e7099",
  "cases": 304,
  "failures": []
}
######################################################################## 100.0%
######################################################################## 100.0%
######################################################################## 100.0%
INSTALLER GATES PASS
STATIC GATES PASS

````

### sevra-adversarial-real.log

SHA256: `5250870950f816300e264cc88d795c6fa40ddf0a79b33759fa2fc6093358069a`

````text
Verifying the local model
Loading the local model
engine ready in 1.6s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
Reading context: 0 of 780 tokens
Reading context: 256 of 780 tokens
Reading context: 512 of 780 tokens
Reading context: 768 of 780 tokens
Responding
Reading the conversation
Reading context: 808 of 873 tokens
Responding
Reading context: 936 of 1317 tokens
Reading context: 1192 of 1317 tokens
Responding
Unrecognized tool or argument.
Real workflow did not reach review: Unrecognized tool or argument.

````

### sevra-adversarial-real-corrected.log

SHA256: `138b1298a1c804a5382ae2d008d13bfba1636547689dc1e9e8972baa18055bca`

````text
Verifying the local model
Loading the local model
engine ready in 0.9s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
Reading context: 0 of 780 tokens
Reading context: 256 of 780 tokens
Reading context: 512 of 780 tokens
Reading context: 768 of 780 tokens
Responding
Reading context: 808 of 873 tokens
Responding
Reading context: 936 of 1317 tokens
Reading context: 1192 of 1317 tokens
Responding
The model requested an unavailable tool. No calls from that response were executed.
Real workflow did not reach review: The model requested an unavailable tool. No calls from that response were executed.

````

### sevra-adversarial-real-diagnostic.log

SHA256: `9c51c477ab28672ae34164e16adb5bbd935a547ff23d6867715d135c4424f666`

````text
Verifying the local model
Loading the local model
engine ready in 0.8s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
Reading context: 0 of 780 tokens
Reading context: 256 of 780 tokens
Reading context: 512 of 780 tokens
Reading context: 768 of 780 tokens
Responding
Reading context: 808 of 873 tokens
Responding
Reading context: 936 of 1317 tokens
Reading context: 1192 of 1317 tokens
Responding
The model requested unavailable tool "artifact=propose". No calls from that response were executed.
Real workflow did not reach review: The model requested unavailable tool "artifact=propose". No calls from that response were executed.

````

### sevra-adversarial-full.log

SHA256: `6c537a00db3ec3fe4517a4018b990f9d23a0f49ce5d1d7db26e69374d75567fa`

````text
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/4] Write sources
[4/5] Compiling Slotstream AdaptiveSpeculation.swift
/Users/carlos/Projects/slotstream/Sources/Slotstream/EmbeddingRows.swift:107:36: warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
105 |             data.withUnsafeMutableBytes { output in
106 |                 for (i, id) in ids.enumerated() {
107 |                     available[id]!.withUnsafeBytes { row in
    |                                    `- warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
108 |                         memcpy(output.baseAddress! + i * stride, row.baseAddress! + offsets[p], stride)
109 |                     }

/Users/carlos/Projects/slotstream/Sources/Slotstream/RouterTrace.swift:36:13: warning: variable 'header' was never mutated; consider changing to 'let' constant
34 |         lock.lock()
35 |         defer { lock.unlock() }
36 |         var header = [Int32(layer), Int32(tokens), Int32(topK)]
   |             `- warning: variable 'header' was never mutated; consider changing to 'let' constant
37 |         header.withUnsafeBytes { buffer.append(contentsOf: $0) }
38 |         var small = [Int16](repeating: 0, count: ids.count)
error: input file '/Users/carlos/Projects/slotstream/Sources/Slotstream/ExpertPrefetch.swift' was modified during the build
error: input file '/Users/carlos/Projects/slotstream/Sources/Slotstream/ExpertPrefetch.swift' was modified during the build

````

### sevra-adversarial-snapshot.log

SHA256: `d0322c4b40b7ac9e4203ab88cd299b24d0cbbf04794691304fb5dab93a7f6ba1`

````text
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'Sevra' complete! (2.05s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraLocal main.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-local
Build of product 'sevra-local' complete! (4.02s)
Another instance of SwiftPM (PID: 74390) is already running using '/Users/carlos/Projects/slotstream/apps/macos/.build', waiting until that process has finished execution...[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/4] Write sources
[3/5] Compiling SevraComposerChecks ComposerChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (7.91s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.31s)
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Write sources
[4/5] Compiling Slotstream AdaptiveSpeculation.swift
/Users/carlos/Projects/slotstream/Sources/Slotstream/EmbeddingRows.swift:107:36: warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
105 |             data.withUnsafeMutableBytes { output in
106 |                 for (i, id) in ids.enumerated() {
107 |                     available[id]!.withUnsafeBytes { row in
    |                                    `- warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
108 |                         memcpy(output.baseAddress! + i * stride, row.baseAddress! + offsets[p], stride)
109 |                     }

/Users/carlos/Projects/slotstream/Sources/Slotstream/RouterTrace.swift:36:13: warning: variable 'header' was never mutated; consider changing to 'let' constant
34 |         lock.lock()
35 |         defer { lock.unlock() }
36 |         var header = [Int32(layer), Int32(tokens), Int32(topK)]
   |             `- warning: variable 'header' was never mutated; consider changing to 'let' constant
37 |         header.withUnsafeBytes { buffer.append(contentsOf: $0) }
38 |         var small = [Int16](repeating: 0, count: ids.count)
error: input file '/Users/carlos/Projects/slotstream/Sources/Slotstream/ExpertPrefetch.swift' was modified during the build
error: input file '/Users/carlos/Projects/slotstream/Sources/Slotstream/ExpertPrefetch.swift' was modified during the build

````

### sevra-adversarial-isolated.log

SHA256: `d498d5d6997511b86b49db8f0de46d3bf496f0091fe359a1e8e855847e1ed2fe`

````text
warning: '--skip-update' option is deprecated and will be removed in a future release
Working copy of https://github.com/huggingface/swift-jinja.git resolved at 2.4.2
Working copy of https://github.com/huggingface/swift-huggingface.git resolved at 0.9.0
Working copy of https://github.com/huggingface/swift-transformers.git resolved at 1.3.3
Working copy of https://github.com/apple/swift-asn1.git resolved at 1.7.1
Working copy of https://github.com/apple/swift-crypto.git resolved at 4.5.1
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/244] Compiling conv.cpp
[1/244] Compiling stream.cpp
[2/244] Write swift-version--1AB21518FC5DEDBE.txt
[3/244] Copying t5_tokenizer_config.json
[4/244] Copying gpt2_tokenizer_config.json
[5/244] Copying PrivacyInfo.xcprivacy
[6/244] Compiling cmark-gfm-extensions tasklist.c
[7/244] Compiling cmark-gfm-extensions tagfilter.c
[8/244] Compiling cmark-gfm-extensions table.c
[9/244] Compiling cmark-gfm-extensions strikethrough.c
[10/244] Compiling cmark-gfm-extensions ext_scanners.c
[11/244] Compiling cmark-gfm-extensions core-extensions.c
[12/244] Compiling cmark-gfm-extensions autolink.c
[13/244] Compiling cmark-gfm xml.c
[14/244] Compiling cmark-gfm utf8.c
[15/244] Compiling cmark-gfm syntax_extension.c
[16/244] Compiling cmark-gfm scanners.c
[17/244] Compiling cmark-gfm render.c
[18/244] Compiling cmark-gfm registry.c
[19/244] Compiling cmark-gfm references.c
[20/244] Compiling cmark-gfm plugin.c
[21/244] Compiling cmark-gfm plaintext.c
[22/244] Compiling cmark-gfm node.c
[23/244] Compiling cmark-gfm map.c
[24/244] Compiling cmark-gfm man.c
[25/244] Compiling cmark-gfm linked_list.c
[26/244] Compiling yyjson.c
[27/244] Compiling cmark-gfm latex.c
[28/244] Compiling cmark-gfm iterator.c
[29/244] Compiling cmark-gfm html.c
[30/244] Compiling cmark-gfm houdini_html_u.c
[31/244] Compiling cmark-gfm houdini_html_e.c
[32/244] Compiling cmark-gfm houdini_href_e.c
[33/244] Compiling cmark-gfm footnotes.c
[34/244] Compiling cmark-gfm inlines.c
[35/244] Compiling cmark-gfm cmark_ctype.c
[36/244] Compiling cmark-gfm commonmark.c
[37/244] Compiling cmark-gfm cmark.c
[38/244] Compiling cmark-gfm buffer.c
[39/244] Compiling cmark-gfm arena.c
[40/244] Compiling _NumericsShims _NumericsShims.c
[41/244] Write sources
[48/245] Compiling cmark-gfm blocks.c
[49/245] Write sources
[59/246] Compiling RealModule AlgebraicField.swift
[59/246] Write sources
[64/247] Compiling InternalCollectionsUtilities Debugging.swift
[65/248] Compiling EventSource AsyncEventsSequence.swift
[66/249] Compiling Crypto AES-GCM.swift
[66/249] Write sources
[67/249] Compiling version.cpp
[69/250] Compiling OrderedCollections _HashTable+Bucket.swift
[70/251] Compiling ComplexModule Complex+AdditiveArithmetic.swift
[71/252] Compiling Jinja AST.swift
[72/253] Compiling Numerics Numerics.swift
[72/253] Compiling utils.cpp
[73/253] Compiling transforms.cpp
[74/253] Compiling scheduler.cpp
[75/253] Compiling random.cpp
[77/253] Compiling HuggingFace AccessRequest.swift
[77/253] Compiling primitives.cpp
[78/254] Compiling ops.cpp
[79/254] Compiling linalg.cpp
[80/254] Compiling safetensors.cpp
[81/254] Compiling no_gguf.cpp
[83/254] Compiling Hub BinaryDistinct.swift
[83/254] Compiling load.cpp
[84/255] Compiling graph_utils.cpp
[85/255] Compiling fft.cpp
[86/255] Compiling fast.cpp
[88/255] Compiling Tokenizers BPETokenizer.swift
[88/255] Compiling einsum.cpp
[90/256] Compiling Generation Decoders.swift
[90/256] Compiling dtype_utils.cpp
[92/257] Compiling Models LanguageModel.swift
[92/257] Compiling export.cpp
[93/257] Compiling dtype.cpp
[94/257] Compiling utils.cpp
[95/257] Compiling no_ring.cpp
[96/257] Compiling primitives.cpp
[97/257] Compiling ops.cpp
[98/257] Compiling no_nccl.cpp
[99/257] Compiling no_mpi.cpp
[100/257] Compiling no_jaccl.cpp
[101/257] Compiling device.cpp
[102/257] Compiling distributed.cpp
[103/257] Compiling utils.cpp
[104/257] Compiling unary.cpp
[105/257] Compiling compile.cpp
[106/257] Compiling ternary.cpp
[107/257] Compiling sort.cpp
[108/257] Compiling softmax.cpp
[109/257] Compiling slicing.cpp
[110/257] Compiling scan.cpp
[111/257] Compiling scaled_dot_product_attention.cpp
[112/257] Compiling rope.cpp
[113/257] Compiling resident.cpp
[114/257] Compiling reduce.cpp
[115/257] Compiling quantized.cpp
[116/257] Compiling primitives.cpp
[117/257] Compiling metal.cpp
[118/257] Compiling normalization.cpp
[119/257] Compiling logsumexp.cpp
[120/257] Compiling matmul.cpp
[121/257] Compiling jit_kernels.cpp
[122/257] Compiling indexing.cpp
[123/257] Compiling hadamard.cpp
[124/257] Compiling fence.cpp
[125/257] Compiling event.cpp
[126/257] Compiling eval.cpp
[127/257] Compiling fft.cpp
[128/257] Compiling distributed.cpp
[129/257] Compiling device_info.cpp
[130/257] Compiling device.cpp
[131/257] Compiling custom_kernel.cpp
[132/257] Compiling copy.cpp
[133/257] Compiling compiled.cpp
[134/257] Compiling conv.cpp
[135/257] Compiling allocator.cpp
[136/257] Compiling binary.cpp
[137/257] Compiling slicing.cpp
[138/257] Compiling primitives.cpp
[139/257] Compiling no_cuda.cpp
[140/257] Compiling copy.cpp
[141/257] Compiling threefry.cpp
[142/257] Compiling svd.cpp
[143/257] Compiling unary.cpp
[144/257] Compiling softmax.cpp
[145/257] Compiling select.cpp
[146/257] Compiling sort.cpp
[147/257] Compiling scan.cpp
[148/257] Compiling reduce.cpp
[149/257] Compiling qrf.cpp
[150/257] Compiling primitives.cpp
[151/257] Compiling quantized.cpp
[152/257] Compiling matmul.cpp
[153/257] Compiling masked_mm.cpp
[154/257] Compiling luf.cpp
[155/257] Compiling logsumexp.cpp
[156/257] Compiling jit_compiler.cpp
[157/257] Compiling inverse.cpp
[158/257] Compiling hadamard.cpp
[159/257] Compiling cblas.cpp
[160/257] Compiling bnns.cpp
[161/257] Compiling fft.cpp
[162/257] Compiling eval.cpp
[163/257] Compiling encoder.cpp
[164/257] Compiling eigh.cpp
[165/257] Compiling eig.cpp
[166/257] Compiling distributed.cpp
[167/257] Compiling device_info.cpp
[168/257] Compiling indexing.cpp
[169/257] Compiling copy.cpp
[170/257] Compiling conv.cpp
[171/257] Compiling cholesky.cpp
[172/257] Compiling arg_reduce.cpp
[173/257] Compiling utils.cpp
[174/257] Compiling slicing.cpp
[175/257] Compiling reduce.cpp
[176/257] Compiling load.cpp
[177/257] Compiling compiled.cpp
[178/257] Compiling common.cpp
[179/257] Compiling broadcasting.cpp
[180/257] Compiling array.cpp
[181/257] Compiling utils.cpp
[182/257] Compiling unary_ops.cpp
[183/257] Compiling unary.cpp
[184/257] Compiling ternary_ops.cpp
[185/257] Compiling ternary.cpp
[186/257] Compiling steel_gemm_splitk_nax.cpp
[187/257] Compiling steel_gemm_splitk.cpp
[188/257] Compiling steel_gemm_segmented.cpp
[189/257] Compiling steel_gemm_masked.cpp
[190/257] Compiling steel_gemm_gather_nax.cpp
[191/257] Compiling steel_gemm_gather.cpp
[192/257] Compiling steel_gemm_fused_nax.cpp
[193/257] Compiling steel_gemm_fused.cpp
[194/257] Compiling steel_conv_general.cpp
[195/257] Compiling steel_conv_3d.cpp
[196/257] Compiling steel_conv.cpp
[197/257] Compiling steel_attention_nax.cpp
[198/257] Compiling steel_attention.cpp
[199/257] Compiling sort.cpp
[200/257] Compiling softmax.cpp
[201/257] Compiling scatter_axis.cpp
[202/257] Compiling scatter.cpp
[203/257] Compiling scan.cpp
[204/257] Compiling reduce_utils.cpp
[205/257] Compiling reduce.cpp
[206/257] Compiling quantized_utils.cpp
[207/257] Compiling quantized_nax.cpp
[208/257] Compiling quantized.cpp
[209/257] Compiling masked_scatter.cpp
[210/257] Compiling logsumexp.cpp
[211/257] Compiling hadamard.cpp
[212/257] Compiling gemv_masked.cpp
[213/257] Compiling gemm_nax.cpp
[214/257] Compiling gemm.cpp
[215/257] Compiling gather_front.cpp
[216/257] Compiling gather_axis.cpp
[217/257] Compiling gather.cpp
[218/257] Compiling fp_quantized_nax.cpp
[219/257] Compiling fp_quantized.cpp
[220/257] Compiling fft.cpp
[221/257] Compiling copy.cpp
[222/257] Compiling compiled_preamble.cpp
[223/257] Compiling binary_two.cpp
[224/257] Compiling binary_ops.cpp
[225/257] Compiling binary.cpp
[226/257] Compiling arange.cpp
[227/257] Compiling compiled_conditional.cpp
[228/257] Compiling version.cpp
[229/257] Compiling vector.cpp
[230/257] Compiling transforms_impl.cpp
[231/257] Compiling transforms.cpp
[232/257] Compiling string.cpp
[233/257] Compiling random.cpp
[234/257] Compiling ops.cpp
[235/257] Compiling metal.cpp
[236/257] Compiling memory.cpp
[237/257] Compiling map.cpp
[238/257] Compiling linalg.cpp
[239/257] Compiling io_types.cpp
[240/257] Compiling io.cpp
[241/257] Compiling fft.cpp
[242/257] Compiling fast.cpp
[243/257] Compiling export.cpp
[244/257] Compiling error.cpp
[245/257] Compiling device.cpp
[246/257] Compiling cuda.cpp
[247/257] Compiling compile.cpp
[248/257] Compiling closure.cpp
[249/257] Compiling array.cpp
[250/257] Compiling Cmlx.m
[251/257] Compiling binary.cpp
[252/257] Compiling CSlotpack slotpack.c
[253/257] Compiling CAtomic CAtomic.c
[254/258] Compiling format.cc
[256/259] Compiling Markdown ChildIndexPath.swift
[257/260] Compiling MLX ArrayAt.swift
[258/261] Compiling SevraPresentation ComposerSession.swift
[259/262] Compiling MLXFast MLXFast.swift
[260/262] Compiling MLXNN Activations.swift
[261/263] Compiling Slotstream AdaptiveSpeculation.swift
/Users/carlos/Projects/slotstream/.build/adversarial-snapshot/slotstream/Sources/Slotstream/EmbeddingRows.swift:107:36: warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
105 |             data.withUnsafeMutableBytes { output in
106 |                 for (i, id) in ids.enumerated() {
107 |                     available[id]!.withUnsafeBytes { row in
    |                                    `- warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
108 |                         memcpy(output.baseAddress! + i * stride, row.baseAddress! + offsets[p], stride)
109 |                     }

/Users/carlos/Projects/slotstream/.build/adversarial-snapshot/slotstream/Sources/Slotstream/RouterTrace.swift:36:13: warning: variable 'header' was never mutated; consider changing to 'let' constant
34 |         lock.lock()
35 |         defer { lock.unlock() }
36 |         var header = [Int32(layer), Int32(tokens), Int32(topK)]
   |             `- warning: variable 'header' was never mutated; consider changing to 'let' constant
37 |         header.withUnsafeBytes { buffer.append(contentsOf: $0) }
38 |         var small = [Int16](repeating: 0, count: ids.count)
[262/264] Compiling SevraRuntime HomeStore.swift
[263/265] Compiling SevraMac AppModel.swift
[263/265] Write Objects.LinkFileList
[264/265] Linking Sevra
Build of product 'Sevra' complete! (195.81s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/5] Write sources
[1/4] Write swift-version--1AB21518FC5DEDBE.txt
[3/5] Compiling SevraLocal main.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-local
Build of product 'sevra-local' complete! (4.22s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/5] Write sources
[1/4] Write swift-version--1AB21518FC5DEDBE.txt
[3/5] Compiling SevraComposerChecks ComposerChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (6.19s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/5] Write sources
[1/4] Write swift-version--1AB21518FC5DEDBE.txt
[3/5] Compiling SevraPresentationChecks MarkdownDocumentTests.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-presentation-checks
Build of product 'sevra-presentation-checks' complete! (1.42s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/5] Write sources
[1/4] Write swift-version--1AB21518FC5DEDBE.txt
[3/5] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (7.27s)
PASS: Continue in thread saves Home before creation and rejects overlapping clicks
PASS: Continue in thread cannot create a destination when saving Home fails
PASS: old stale-snapshot sequence reproduces a rejected draft
PASS: back-to-back saves use acknowledged revisions without any display refresh
PASS: overlapping save callers coalesce edits and never write concurrently
PASS: undo to the previous saved text during an in-flight write persists the undo
PASS: debounce saves only the newest edit and cancels pending work after Send
PASS: Send before autosave atomically accepts the prompt and clears the older draft
PASS: Send waits for an in-flight save and preserves typing before acceptance
PASS: typing during acceptance survives the cleared draft receipt
PASS: edit-away-and-back while sending counts as a new draft
PASS: failed save keeps text, blocks navigation/close and clears only after recovery
PASS: lost save acknowledgement reconciles exact persisted text
PASS: failed Send and lost acceptance receipt reuse nonce without duplicating messages
PASS: an idempotent Send retry never erases a subsequently changed saved draft
PASS: revision-only conflicts recover silently and retry storms are bounded
PASS: real competing edits preserve both versions and require an explicit choice
PASS: another change during conflict resolution is not overwritten
PASS: navigation saves typing during destination loading and keeps drafts in their own threads
PASS: failed destination read leaves the current composer intact
PASS: close drains the in-flight writer before reporting safe to close
PASS: quit freezes edits during shutdown and restores editing when shutdown fails
PASS: mixed typing, clearing, Unicode, thread changes and sending retain exact drafts
PASS: discarding Incognito drains pending saves before changing owner
PASS: real dbmd persistence, atomic Send, stale-save refusal, external-edit/no-op refusal, exact reopen and Incognito exclusion
PASS: production journal coordinator, double Save, lost acceptance retry and exact entry/draft restart
PASS: 24 composer scenarios plus real-runtime persistence checks
PRESENTATION_RENDER_MS 14.455,0.289,0.267,0.280,0.266,0.259,0.261,0.266,0.251,0.255,0.250,0.252,0.250,0.259,0.277,0.269,0.258,0.254,0.266,0.271
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
PASS: historical documents and citations, journal atomic acceptance and restart, duplicate/revision refusal and closed-owner guards
PASS: idempotent memory admission and complete eligible memory text in AI context
PASS: malformed termination, undeclared mixed calls and multiple proposals fail before execution
PASS: invalid artifact and duplicate identities do not poison durable recovery
PASS: source Unicode boundaries and repeated unsafe-inventory cleanup
PASS: model verification hash parity and mid-read cancellation without model allocation
PASS: Home promotion selection, visible quotations, exact model context, idempotence, drafts, permissions, scope, restart, Forget, active-run refusal and external edits
PASS: memory plans 28 accepted / 59 safely refused; custom ceilings, unavailable readings, persistence, stable ranges and idle/pressure policy
PASS: deferred budget coalescing, queued submission during handoff, active release refusal, idle release and draft preservation
PASS: sleep cancellation, queued interruption, unload, admission guard, wake without replay and explicit recovery
PASS: context overflow preserves messages and refuses instead of silently trimming history
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget

````

### sevra-adversarial-native.log

SHA256: `7dad3476a2bce5d5c603cf1dd4405d1c4aaa2c8b18353352be151ffe7233b291`

````text
2026-09-14 23:13:44.593 Sevra[84335:1838449] WARNING <NSToolbarItem: 0x90c251880> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize
2026-09-14 23:13:44.593 Sevra[84335:1838449] WARNING <NSToolbarItem: 0x90c251880> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize

````

### sevra-adversarial-native-fixed.log

SHA256: `577643ba6bc38c96df6e17bb93458dd9d91568863e74a897a729d2e3beb8f48f`

````text
2026-09-14 23:28:09.303 Sevra[98644:1898266] WARNING <NSToolbarItem: 0xada74da40> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize
2026-09-14 23:28:09.303 Sevra[98644:1898266] WARNING <NSToolbarItem: 0xada74da40> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize
2026-09-14 23:30:27.384 Sevra[98644:1898266] WARNING <NSToolbarItem: 0xadaf13640> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize
2026-09-14 23:30:27.384 Sevra[98644:1898266] WARNING <NSToolbarItem: 0xadaf13640> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize

````

### sevra-adversarial-native-reopen.log

SHA256: `bca02004d356355ec9bc4942125334d850b65a08e75343971e3e541109baef5d`

````text
2026-09-14 23:31:49.050 Sevra[99730:1905800] WARNING <NSToolbarItem: 0xc442fda40> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize
2026-09-14 23:31:49.050 Sevra[99730:1905800] WARNING <NSToolbarItem: 0xc442fda40> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize

````

### sevra-adversarial-ui-final-build.log

SHA256: `2980f07d488604a8225bb7cc483fb1132743b5c5e29c15fcfa62a936691c9ccb`

````text
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (24.12s)

````

### sevra-adversarial-durable-facts.json

SHA256: `228158e4ac0434ebd0f2a8656ea812e76c28be6eb028bc10247e6e5a96cf3150`

````json
{
  "synthetic_ui_home": "/private/tmp/sevra-adversarial-native-20260915",
  "journal_entry_count": 1,
  "journal_draft_exact_unicode": true,
  "journal_draft_utf8_sha256": "e223e6bb26c756a80cb721374af1e5916cd5ce650e73e135b925cc1dece6f990",
  "reviewed_artifact_exact": true,
  "artifact_sha256": "2d77e3a753f9331f34934d0d2754d7b741bfb2e7ec5bba81a85f21b8cdbd07bb",
  "saved_ack_count": 1,
  "renamed_title": "Reviewed document café",
  "reopened_lifecycle": "open",
  "pinned": true,
  "historical_saved_run_retained": true,
  "corrected_memories": [
    {
      "admitted": false,
      "date": "2026-09-15T04:32:10Z",
      "forgotten": true,
      "id": "051a11aa-f855-4de2-b063-5c34145b271b",
      "messageID": "a66592cb-d7eb-466a-8678-4441f9ec7f7c",
      "scope": "shared",
      "text": "Propose this synthetic document for review.",
      "threadID": "e2f20c50-b255-4be1-899c-4eb9bf075980"
    },
    {
      "admitted": false,
      "date": "2026-09-15T04:32:23Z",
      "forgotten": true,
      "id": "68906562-6417-4177-9a8f-f8418735bdba",
      "messageID": "a66592cb-d7eb-466a-8678-4441f9ec7f7c",
      "scope": "shared",
      "supersedes": "051a11aa-f855-4de2-b063-5c34145b271b",
      "text": "Synthetic preference: brief answers, café and 中文.",
      "threadID": "e2f20c50-b255-4be1-899c-4eb9bf075980"
    }
  ],
  "incognito_thread_count": 0,
  "real": {
    "state": "failed",
    "status": "Unrecognized tool or argument.",
    "trace": [
      "source.list: returned bounded source data",
      "source.read: returned bounded source data",
      "source.read: returned bounded source data"
    ],
    "source_paths": [
      "decision.md",
      "launch-notes.md"
    ],
    "artifact_exists": false
  },
  "real-corrected": {
    "state": "failed",
    "status": "The model requested an unavailable tool. No calls from that response were executed.",
    "trace": [
      "source.list: returned bounded source data",
      "source.read: returned bounded source data",
      "source.read: returned bounded source data"
    ],
    "source_paths": [
      "decision.md",
      "launch-notes.md"
    ],
    "artifact_exists": false
  },
  "real-diagnostic": {
    "state": "failed",
    "status": "The model requested unavailable tool \"artifact=propose\". No calls from that response were executed.",
    "trace": [
      "source.list: returned bounded source data",
      "source.read: returned bounded source data",
      "source.read: returned bounded source data"
    ],
    "source_paths": [
      "decision.md",
      "launch-notes.md"
    ],
    "artifact_exists": false
  }
}

````

### sevra-adversarial-final-identities.json

SHA256: `8a187272f4fbcb2c1a98c24acd2c3af4c566e1614044fac208017927fc1d78fe`

````json
{
  "build_files": {
    ".build/adversarial-snapshot/slotstream/apps/macos/.build/release/Sevra": "56a65790b5335777bac4795b3d29fbf94cf810c9955193b24810b0faa10429b0",
    ".build/adversarial-snapshot/slotstream/apps/macos/.build/release/sevra-local": "af4c5ce48cdb6ead712a38c543a80b60dfb0837f8e899993f8514c4a7ecf7f45",
    ".build/adversarial-snapshot/slotstream/apps/macos/.build/release/sevra-composer-checks": "5d887681dbe507b3068b0dd3038242fbc235c6386749500c128ec74d95473112",
    ".build/adversarial-snapshot/slotstream/apps/macos/.build/release/sevra-presentation-checks": "d907df2d56d12c0fa9bf0b3cdffc560d3c0ed889372fd01ef7f155671c6c5b3f",
    ".build/adversarial-snapshot/slotstream/apps/macos/.build/release/sevra-mac-checks": "300a0c37d9267839a7ef43bc91dec4e08a9c0a855b8012819d7e8a1fe1e6c787",
    ".build/SevraAudit.app/Contents/Helpers/dbmd": "cbf9ee106ab0162fc0ac1865cf09fb38269d5ab13dedb57e3e811ff509cee920",
    ".build/SevraAudit.app/Contents/Info.plist": "6b0a9e406faff0d4846eae83d892e11a2650a4d0110796e791574c754381cf2c",
    ".build/SevraAudit.app/Contents/MacOS/Sevra": "389d744ea017c5441261a67600eb1bb5794930e9e0e31ce2987ac31c3a471c61",
    ".build/SevraAudit.app/Contents/MacOS/mlx.metallib": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597",
    ".build/SevraAudit.app/Contents/Resources/Fonts/Inter-OFL.txt": "5b9321a4298cfeb6b34354164a1c3afc3db114569984c502b9b35d988fd58c57",
    ".build/SevraAudit.app/Contents/Resources/Fonts/Inter.ttf": "29160a80ff49ddcab2c97711247e08b1fab27a484a329ce8b813d820dc559031",
    ".build/SevraAudit.app/Contents/Resources/Fonts/Poppins-Medium.ttf": "90373e7d838d32468438fc3e152dca0bdb12edcab99ea639f158790b1ba1fd05",
    ".build/SevraAudit.app/Contents/Resources/Fonts/Poppins-OFL.txt": "6be04893d770899a015649c7aa3b582f871b272f8747a92b78b17c3e5c8b2573",
    ".build/SevraAudit.app/Contents/Resources/Fonts/manifest.json": "1e79dfd278dbe9bfd8afbf7e5cbaee64dff1574fc1cc3aca8fdd903f4056677e",
    ".build/SevraAudit.app/Contents/Resources/Licenses/swift-cmark-COPYING": "c22e885f33b821bddb24cf007145e5540655b6c0f403e49e6c76a93c28e6d9a9",
    ".build/SevraAudit.app/Contents/Resources/Licenses/swift-markdown-LICENSE.txt": "167beb36f181bd163c93c6feb45c68e5f9462fe1af55b278f7bfd1df20e673a3",
    ".build/SevraAudit.app/Contents/Resources/Licenses/swift-markdown-NOTICE.txt": "ee7da43afcac4a52196a2141024573ec2ceb84b14e74dfed38522d94586fbc52",
    ".build/SevraAudit.app/Contents/Resources/Sevra.icns": "b28f2df8e40cafc2e89fb3ae5a0e361b5470851d833495df9b3dd4ca0395471d",
    ".build/SevraAudit.app/Contents/Resources/build-inputs.json": "0023f60abb5fe904b85f9aeed3d0efab3bac1cf7f2233caef893cfb07e1e8c86",
    ".build/SevraAudit.app/Contents/_CodeSignature/CodeResources": "40629fc8ec7a9195df02214ec1b81ae864746a49c61fb46b01e544cf3b686779"
  },
  "checks_sources": {
    "apps/macos/Checks/AdverseChecks.swift": "88421d2a0925b6dde9a8a9dde1d4b18677cf4a310b013d0a308b5c875b71bd15",
    "apps/macos/Checks/AuditChecks.swift": "decec6d419d1b5f89e4f4444954d988b12c595e7f9d7a1360f89940bb131280f",
    "apps/macos/Checks/PerformanceChecks.swift": "6649e5f982b8d7fec79805ac349a6ed109c887ecf437dbd92744878417283441",
    "apps/macos/Checks/PromotionChecks.swift": "0deb594c4e6a258d49c49df222ea6f32336c21e9dad9711b88ec28cf9c11b2c8",
    "apps/macos/Checks/RealChecks.swift": "c9020d34375a4eb8d788c767419ac381b75a3b1f1f10f2fd13a96b4fd0c95d42",
    "apps/macos/Checks/UIFixture.swift": "ce486b15b53ddbf32be9c327104c80768d9def7bd4f0098f56854d774d984681",
    "apps/macos/Checks/main.swift": "368f1bbfc84f6787c1151b9aa02a86933204163a52729aa9ef54fa7258016c53",
    "apps/macos/ComposerChecks/ComposerChecks.swift": "28c5775316928cc14714ad51b1be08eccf7e46d27c9c4a9c2164cff0f1381db2",
    "apps/macos/CLI/main.swift": "c2d85885bfe9eb872f43fb7245ec39d69269c6493949b0a95a9f484e33bf98a2",
    "Tools/check_sevra_mac.sh": "eb4b31f777d036b8703850d64143e9c1bc4452ab94bf604a8f4a36c16b29bed2",
    "apps/macos/PresentationTests/MarkdownDocumentTests.swift": "c1527abd1c51c9b93afb71bc02c8e2a35de575ba82db551fb49b18466689af86"
  },
  "root_differences": [
    "Sources/Slotstream/ExpertPrefetch.swift",
    "Sources/Slotstream/Model.swift",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift",
    "apps/macos/Package.resolved"
  ],
  "dependency_pins_match": true,
  "qa_bundle_id": "com.sevra.mac.adversarial-audit",
  "normal_user_app_updated": false
}

````

### sevra-adversarial-final-inputs.json

SHA256: `4afe39ce612644f40ddc1f9c1696a51a63cc87c229fc5acc197296a5987b5d83`

````json
{
  "dbmd_sha256": "ce799f5d8105969bf57c80d451fd8e5a10d325eee01dac659f15694b5355e8ef",
  "files": {
    "Package.resolved": "6fc23da3ddc636949e84042cb70da34bc93c4355feef14857880caa6c3c7fceb",
    "Package.swift": "8e2faec45c5aa764014d61b5cc04dee63640660322ad3e943084d5cb6dee4f87",
    "Sources/CSlotpack/include/slotpack.h": "07301354bebebac253975abbd5981006be411fed444abab0b6bbc857e28bdd1b",
    "Sources/CSlotpack/slotpack.c": "be45d2daf3e7e95d66cb9178f40dab292b85b1998086d71c53e41f59596d57a2",
    "Sources/Slotstream/AdaptiveSpeculation.swift": "da8062ff16c1d72ccd28852ba18e43cd434a8165483d045759cd29a499f5fff6",
    "Sources/Slotstream/BlockSelection.swift": "16e5fb4a4ea82728e3caaf3d6f4cdbf7d91614b757b0624913ae14c052d6f27d",
    "Sources/Slotstream/BoundedOutput.swift": "70c21c3583edecdd856af06c2fae567bccaf0ea2005ddb932a7dd99642e7780f",
    "Sources/Slotstream/CPUSlotWrite.swift": "da137aec8944dab6590cbea17afff28f094aef876688d20782b5791028d83349",
    "Sources/Slotstream/CacheBookkeeping.swift": "0c3726c431b41a2c84fa2ea21ce49eb209f2c36955925754508a51cb54ae0779",
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/CompiledArithmetic.swift": "98611b31035459d237d901be7fff175072c30b32b992c7534d770b1bc6d117f2",
    "Sources/Slotstream/Context.swift": "2ec4523a59da75efba101b56e9d0e943feb477084e593e68827f84e1ee8b7f44",
    "Sources/Slotstream/ContextFeasibility.swift": "582f40326eea4d969834eefa13425dec345b5630206235640b4b9536ddb044d2",
    "Sources/Slotstream/ContextMemory.swift": "848df7f507cd1cc0d978ea29866f4c5c9635f5091ff236e551cde652cc668d9b",
    "Sources/Slotstream/ContextWindowPolicy.swift": "6da4b93a1a01b1d1b9be13b14d7c4d3b3751f1c38575672d4489f3545a913ab6",
    "Sources/Slotstream/DecodeLookahead+Configuration.swift": "0731bd8d9d7674b3b143bef039ca84d56f11bbb1f255ba7eb31292b17a91c33c",
    "Sources/Slotstream/DecodeLookahead.swift": "13ff2deb101b25f302828a25f090af7c2abf52c2f4baf8e927f6c050545e4668",
    "Sources/Slotstream/DownloadConcurrency.swift": "cf872e6e99b9e1df121a9feba4c0c8420719fe62a5f5a50e58b26bf11cb8126e",
    "Sources/Slotstream/DownloadHTTP.swift": "341a7a7157c575658ee7d7bc6c77ed593bf30f79d8c262906d7672e2e40c6cbc",
    "Sources/Slotstream/EmbeddingRows.swift": "10c722abb55b03bd6ae0f8188ec156f97e2a7603a516bd91919e060d8fc5a645",
    "Sources/Slotstream/Engine.swift": "3428ab0552cc27364fbfeb0c731ef8d73be412e12ed13bb6bfe04813afb02459",
    "Sources/Slotstream/Errors.swift": "0f65317656d38709f071fb58cb4c11f11f68f0949be02a781c675f37f76f5b57",
    "Sources/Slotstream/ExactRead.swift": "bd90fbeb1d400cb7dda746d434a5c4f1fbb4d767506013e4398de9ba1253a47e",
    "Sources/Slotstream/ExpertLookaheadTrace.swift": "16e69d2c91c54d9c45f3df7c7d6e8121fd0fcd8abc627801ee4a4e131556061a",
    "Sources/Slotstream/ExpertPredictor.swift": "2f25044ff7258ac53973c3e5de7138ad078b0b90a1ab13cc332cab8bcfa0740e",
    "Sources/Slotstream/ExpertPrefetch.swift": "7c3ceca11a8587942bb2c60d4c04afbd762b4643e4170a27281bab6366f4369e",
    "Sources/Slotstream/ExpertStore.swift": "f69c680e9c130a178a84db8b6df6e63aabe64a5da2b9963c7e724114e8715ce6",
    "Sources/Slotstream/ExpertTransferProfile.swift": "17fe476f01b03d3a151506d324d9ad0d83d8dcf152489c9e88805ddea2b302ad",
    "Sources/Slotstream/GDNPhaseProfile.swift": "f74d843773b549530cebe9e5df79a02b0104068e05c39ff6adfcbae3effaef66",
    "Sources/Slotstream/GatewayDialect.swift": "93561b74b171c78d107dca5985a1c0601f7ca0ce4388f0a3aa03e9bd0c6bd0c8",
    "Sources/Slotstream/Generate.swift": "2668a164ad5d82bd20ff58c682c11a754efa1c53a5572da619dfe01181e60d2a",
    "Sources/Slotstream/Governor.swift": "ddac4e5d20f3a771cd81767d7734f7b2206b93ea1b2981388b78d6ac5abe1406",
    "Sources/Slotstream/LayerLocalVictim.swift": "9615385e6c2ac18573f4d2089a75a70d356d803c0c4a603b4db3397fafa6275c",
    "Sources/Slotstream/Layers.swift": "a724e905905b256a5a463cc8585a227a0062976c879cf57d2b3f2d3ca4278b52",
    "Sources/Slotstream/MTP.swift": "10b63deee430c1e1d5792221f128bea0a6158161911676679665a168116cf743",
    "Sources/Slotstream/Machine.swift": "ffed1d45e029e21e42e1eb956d1b3f2647aae2bca689f532b5dc2dba897c89ee",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "26aa0f5c18d24e3692363570e92f59dfcd34c080aa213b846b39156a9047b4b5",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/OpenAIDialect.swift": "714263f4382c83835c4e617ffcb72e231c270a0f0d8be497881cdfc663d52f58",
    "Sources/Slotstream/OpenAIOutput.swift": "d13c9a29f3dbcf9fb9933e5a378f3ba8160d7eb4f96d3c7a61f3faed5a563b76",
    "Sources/Slotstream/OptimizationPlatform.swift": "e4c17aeb1ab294ac9d9e9c60095cc5360382c0809a4f579672b4d0b66a0ed3cf",
    "Sources/Slotstream/Optimizations.swift": "4f3b35ad41cef026e7bcccfeb03580a1d4c4ade57a21eacb5b195f0dff38bee8",
    "Sources/Slotstream/PackedExpertLayout.swift": "c74e9867e2c37ba92d84bf7ce90253eea6db6f8531a6d6b8792874d4810cc6ee",
    "Sources/Slotstream/PackedProjectionPair.swift": "84fa87130270092c16a538f7d50cfee55e71b52ecd8250a1bce7e0547c8b1d96",
    "Sources/Slotstream/PartialRotation.swift": "57177495e6ba630c66744b2b9e2bde23acf9349fca52b97a4ea406c5839c7f8f",
    "Sources/Slotstream/PersistentPrefixCache.swift": "2761c700990f8295e069108828ebd9c91aaf7cc12bc3649ce06690fc7ed25665",
    "Sources/Slotstream/PersistentPrefixFormat.swift": "eec16cb611bf9a5c617ea73f465f05db1f4fdae503b1b3655b59d6cbe7290702",
    "Sources/Slotstream/PersistentPrefixGenerator.swift": "36a24796df4c6d9c5bc56170888be142749d787d39dab79bbe9c9e4b278db47e",
    "Sources/Slotstream/PersistentPrefixPolicy.swift": "40cfc47a5e4a5f3cb91e1264e1bac3121bb871335313205a3529a89e9cb24aca",
    "Sources/Slotstream/PersistentPrefixRestore.swift": "ee3bc4123ac885375ac2be349454f92dcfecd28478eb905427d5f33e6925e8c4",
    "Sources/Slotstream/PersistentPrefixSave.swift": "3605a27cacf1c7b94bb228785d7be1b1e4bbb4a64f455c4b93ea6b2f292d811f",
    "Sources/Slotstream/PinnedModel.swift": "0c7c16539bcb54924ff7306b03b470e2915b5bb41c4ecff9e60dc7912e7afdd2",
    "Sources/Slotstream/PinnedTransport.swift": "f30c4c4bfeaf49c5e2dfcbfa728d6eab44d02a1f77d40217e84723fd03761d87",
    "Sources/Slotstream/PinnedTransportManifest.swift": "6b0de220938fc91dd4dc24cd0fc9dffa086f09f04cd83823dc3de3a13de8ac11",
    "Sources/Slotstream/Plan.swift": "a93709d5b77069ca9558846efc988f9c81ee2f88303e4dd407f8e417f961536b",
    "Sources/Slotstream/PlannerCostModel.swift": "a95e2781a7448418ec78480be356bac9eb80bb36cc64c63f6cb3e378043d29c0",
    "Sources/Slotstream/PlannerDevice.swift": "528cdf93cf0fe600b8c53a3eb828b9b1922ee4817fa100393a11d4e2714784f8",
    "Sources/Slotstream/PrefixCache.swift": "96f5c3aa54471582d5e8a6b4a2a6b37e8ea284c5e9ce29e5b133a306cf5a42d2",
    "Sources/Slotstream/PressureBoundary.swift": "ed22537fccc321589eb3d33b3538984630daae951d00e4ac829412897b181a3d",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Sources/Slotstream/RequestControl.swift": "a8bea5078dbd26458331af41fba986f9de05d386637b69768e2035c95345bdea",
    "Sources/Slotstream/ResidentExpertOverlap.swift": "4ddb3a027d92697dcc1e7373e66fc139abdc12063448d864ef635e5202f57dde",
    "Sources/Slotstream/RouterProjection.swift": "98ea668ac6f47549ec9cdee41b81109e66f11935946d2d1587ebf97ad106230d",
    "Sources/Slotstream/RouterSelection.swift": "35b122748ab05c00122bfb5b4c78416ee28b55abaa4d4e1379fd163aaf47b4a6",
    "Sources/Slotstream/RouterTrace.swift": "b34c1974f60015c913649a285023e57b15d92f37c2f7aa282b821eb2043652c1",
    "Sources/Slotstream/RoutingReadbackQueue.swift": "477ad597e6e741cb939c9ade983934814e2a7c6b8e7c59fc659a1dc02eb4b4ab",
    "Sources/Slotstream/SelectedAttention.swift": "70e61a089444f74cc74494d7f05005b0ff4dfe67043782befbbef80d96b911db",
    "Sources/Slotstream/Server.swift": "c20776840aa9551958d8fed92389c8fc32318c97639bd14d93609233dc449334",
    "Sources/Slotstream/SlotWritePlan.swift": "9abde1de815522ff835d3c685a2e342293f3c9c7019cfc742265193ea2e286c1",
    "Sources/Slotstream/SlotpackDownload.swift": "fb6f47ce70f30713cf1679ebda619c980e9d783dd6ae4cd1cc4e0a68b14705b7",
    "Sources/Slotstream/SlotpackManifest.swift": "8664440e22653e64b85c0100345169dd93b3836d1bbd125ac2add4f621b9876d",
    "Sources/Slotstream/StatePrefixFork.swift": "35ed6954bc927e37c117d53eb25e007b83b3385099bc9b18e01607f30abb7df7",
    "Sources/Slotstream/StateRecovery.swift": "078521e0e08233c06706408bb6dbc53f902285fc4c891af2e164386bd41bf98b",
    "Sources/Slotstream/ToolCallSplitter.swift": "2c2e1d722188d633508c871d73f011fa4053b666d10b7585b304c151c53925a8",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
    "Sources/Slotstream/Version.swift": "4a34c363a6357ae06fb07c9d58f959de072ae0d4dad889e8f9c0e88063a5613c",
    "Sources/Slotstream/Vision.swift": "38565f564bf8ba73d2dc87e2f1874fa6fda2652e094a324048bfa8cb1278a79e",
    "Sources/Slotstream/VisionAttention.swift": "83b1012cb0b3a2c22098f71515e3e853cf1ca3affb01cb667a8248e3c34c63a5",
    "Sources/Slotstream/VisionPrompt.swift": "61b90891a5ec9944406287fa73b4c0e5bdd29b4e3903dff345cbeb80638c6435",
    "Sources/Slotstream/WeightDownload.swift": "2758b2eea2631635cd3da5c18a87e724c57aab5c78ad816b7e18d7ff48c8c98d",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "4c6112412f38192de1955bedb6b7f3cddcb2d0b338b570b6b688df4638a55e5f",
    "Sources/Slotstream/WordSlotWrite.swift": "1c19def2346669acc1afa811a7244233c6f593de91c02bfc4ff145465b95187e",
    "Sources/SlotstreamDiagnostics/CheckReport.swift": "9bbe2106b5b55331cc3fbc093edd803eff6f9f00ebd5f30ce587754fe0bc7e47",
    "Sources/SlotstreamDiagnostics/Diagnostics+AdaptiveSpeculation.swift": "e53d32c4f5a3fc7039a258db5c5b3c530416d07828c5d424a8f35e67d80dc256",
    "Sources/SlotstreamDiagnostics/Diagnostics+AllHitReplay.swift": "187a98c70c2e66008622db3727f0bf58126928862bc102782574fa0ba5f57513",
    "Sources/SlotstreamDiagnostics/Diagnostics+BlockSelection.swift": "08d3f1fc29b6353443b795198295bacb85f57d0a2bdbac67450cf66d505f852c",
    "Sources/SlotstreamDiagnostics/Diagnostics+CacheBookkeeping.swift": "6db1e4743b6adce39f32c2c5c0ff9c38bb86d7e9548c41e6c0e7d64299dd9cae",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompactIndexer.swift": "3dd65c8fac32f2804cce942845946debe74ca83b9cf6485a441ed15331711a5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompiledNorm.swift": "9f1beb774172bc33a27020261532e06723f0794adba9ab5dbca7807d01a0748f",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompletePrompt.swift": "75cdd2137b2856407d2fb297504039b174b3ae116b40608d5f42fabf0237a66d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ComputeIslands.swift": "ac7f3b5ed140a566348e9be06274cf757144d2db099fe5af097c4a3807dc6801",
    "Sources/SlotstreamDiagnostics/Diagnostics+Context.swift": "76ea9c95cd2d20614533458ffe32c8e8fd6d29dee3b1bece7476e27d3f589ce0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift": "51e505bd3279983263ad731133b2f1e20606387cf03ba360ffcb2fba34dd33a3",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift": "90b83306d1966da794daf28cc84f426a42cd853075f5e236cf1bacae10787d8f",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeLookahead.swift": "a27f1040ec4bea2a5e02f25f2a4d51a6a15ff78bd0609b1c23bd97e1adc3822c",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRows.swift": "a0f0532a43c1329b3a69f8a3bd8607df9f27793c0994ad23203936896b44e81f",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRuntime.swift": "c5c37fafb45b2ac2434a36cd7c8b8804fac0e271e9e3f0fb10ef97481db77e24",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExactRead.swift": "77a357f55c3f5aced5ba0d74012e35f73e678e0840024f24a5ab86909d335c59",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift": "6a88a4b8bb8b35d6ca80d63cc1264f4da44218ca0229320960a8328ad2e95935",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProfile.swift": "6d982a575d6c6282941a9f9f3ac063b75d31996fcde387a63ca3ce44fea93242",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProjection.swift": "983a071e562451dbc22cfe09b005d9c68af687c10e7d94802d7d3cb28af1c7cd",
    "Sources/SlotstreamDiagnostics/Diagnostics+Governor.swift": "8ec85ff3609cd5657eae1a8434189e9474460aad0c850f6b88240457c8f0f1fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+HTTP.swift": "9526e51122c9e463ea9a3201da6e4628f3794f329bd4ca05f1496daf3c66c1e5",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageFailure.swift": "766742295107f924177f7f724a7be61f8ccb29b3e044a7de345523598c31cead",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageReuse.swift": "5d0e619769c0f7d4ea8c73439ac44bc499db6184c4954b417f4cb7804aec20e8",
    "Sources/SlotstreamDiagnostics/Diagnostics+Integrated.swift": "5eb2132959b1db779caa520a3eefe5d6c5ffdd9ed317750c8cee48f02bd05941",
    "Sources/SlotstreamDiagnostics/Diagnostics+LayerLocalVictim.swift": "d512d93741a6675412cc9e6c739b940132ca3f20ebecd709884b00b1ebbc49b7",
    "Sources/SlotstreamDiagnostics/Diagnostics+MTPIndexer.swift": "7784a18a1eddafa25ecaee9eeacfbcddf8bcabac8d53919f80367a4f4e5be476",
    "Sources/SlotstreamDiagnostics/Diagnostics+Machine.swift": "20f6edb816fc3a794143042e59847adbfc1fe06514fc990e8a3d81eb87abe50c",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramCache.swift": "9bee4eb6c6cf09df5673e177d4b7f006681794bf680366b4549e4fa3d38b7368",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramLookahead.swift": "3b0bc7ea21a57d2ce65e58773879f5f86ba7f0f37c47d8f1d08d51e61c486370",
    "Sources/SlotstreamDiagnostics/Diagnostics+Optimization.swift": "35d99deb614da4ffdfef075eabdc5a1c8b3518bf9accf265796e09f2c7c281ee",
    "Sources/SlotstreamDiagnostics/Diagnostics+Output.swift": "e39951dc83e8410abdc840d0a739e1e1b2fbbdf1e2d06b3cb2d28c39ee9329cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+OutputServing.swift": "50bb807143f1e5134f52a6f3d48b8da297f4186dd91895e016d191ca13ccf66a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PackedLayout.swift": "14c31f94ebdd8bbbbb1479c77d0649b4c0632d978e4d8a60a8048214a1e08e65",
    "Sources/SlotstreamDiagnostics/Diagnostics+PartialRotation.swift": "de75d07feedc163834fe8e716683af8b2d373c51b0588ccc2cac922f775367ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefix.swift": "46a5bc33ee3fd389694f22c9e7ff5cdd995539663b3141688414351f50ac3189",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixModel.swift": "3e06c67777ce3572d9bd7cce5d220be5f41af90e31b6f5da349ba6f3ec667798",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixPolicy.swift": "82dcadab2ac079d3662da6dd012d8a031c4bdea9ee8c022ac34d5faf66277f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+PoolRequests.swift": "e383c494263afa029a9ef107c90d6ba59f44cda5da7ca1035eae68cbda3562d2",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillQualification.swift": "f40d8e711121f12cbcd95f8880d483ac36995faeab06af714d201fa1671348f1",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixCapacity.swift": "b76e9185930a90d2509f9d7dfc247afee3ff2a083a1bc6bb3da6d090653d290f",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixFork.swift": "e7a7094b3930cef8e380d711f20e8f82e2821c070579549692a6120e9ba3afc4",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixRetention.swift": "5de9452266e8e59da03b078990689554fc7a419a5cd8e5879cc68e2e277ea8cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixVision.swift": "5e4737dbe5344492fc2f9c6881f8d56e997668f674c91b28b9349c9420465f72",
    "Sources/SlotstreamDiagnostics/Diagnostics+PressureBoundary.swift": "f84979a3da94bc5ac0cfeb5cc84b61af43716c5664cc71853085ffa1b116d325",
    "Sources/SlotstreamDiagnostics/Diagnostics+Pull.swift": "224e4bf5210afbddd992894860343add73d1f52b12b2d9a00abf78fdc492ada0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift": "1532f45714ceb98a5adcfa31abd31f065493164f49d2ee3aac868d5d4080b04c",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift": "9e98b6e0fd6c30f36d1d3ec8d556216f351a2f09ee5d15dbb4f5580858fad4b4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadRecovery.swift": "5d51636a62b376e74dfefab207fdd42da61436210973f714819c7cc11488a04d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ResidentOverlap.swift": "c1e7b847cffa51939b0ae20027b289efcae5585a94ae5c1c751a66f110a25522",
    "Sources/SlotstreamDiagnostics/Diagnostics+RopePerformance.swift": "19d040f21391a1ea87831b73a8adf055a78aeafe9d902bd11ce22fd6a492d892",
    "Sources/SlotstreamDiagnostics/Diagnostics+RouterProjection.swift": "3981e415003e6258d41690216a7ab668652a0ce436bf644d99d88dbc2799db9e",
    "Sources/SlotstreamDiagnostics/Diagnostics+RoutingReadback.swift": "f29aad2cde3bbb526f83dcec4565f3c382d071734acc47a0e31d7223312713cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+Runtime.swift": "b6debc0a68e2df94574964c13afa41a76a5aab783e75d1428da25110d241cffc",
    "Sources/SlotstreamDiagnostics/Diagnostics+RuntimeBudget.swift": "b5ce492456b9e27b19765a0bd4f23cbd81ccff034be5af3142737cdae7944d6e",
    "Sources/SlotstreamDiagnostics/Diagnostics+SamplerPerformance.swift": "4e6dd7e85d7ac0f2b2af291343ab4cdc52fa94fe6edb588c1d517008a0c35cb3",
    "Sources/SlotstreamDiagnostics/Diagnostics+SelectedAttention.swift": "8dd385da9b79c3625d1cc9ccc6c8821978f88437fcded918f049328b7a969e7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Selection.swift": "b737794c5a57cd224f36a93b960fa9834cabb51ef810945bab64fd71e59c91d0",
    "Sources/SlotstreamDiagnostics/Diagnostics+SlotSlices.swift": "32c10a839423b13a4dceff67a5b2a617f90d145376a70b19bd27f2e62452e288",
    "Sources/SlotstreamDiagnostics/Diagnostics+StateRecovery.swift": "a53db99ff0f97a26e87586e35bf05daa26b9281fe7d686a1670c14984da2dd77",
    "Sources/SlotstreamDiagnostics/Diagnostics+TerminalPrefill.swift": "7ef27bec8489f52ccdd3ea51c125d21eb94512924b163e854b7aaf25ef39f57a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "be63108d11318a9469d26587ade08c79bf34274c61b847d752663d8ce007f9af",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "da4b4a89d9b11d26a64cd244aae2887acfbca16a6d3aceefa8f40f90c8e39634",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "fe3aaf4ad816c02fc0b28771d6c3c7f9cf7b2a9f102ea4fce660c1dd8541a650",
    "Sources/SlotstreamTestKit/T0Checks.swift": "c3078392faebeddc26b250361a400ac66a756def9ee38edb972c21f3a80266e0",
    "Sources/SlotstreamTestKit/ToolCallChecks.swift": "f1b263239f4e82707c77a5887367fb5302e96d369f2f278e0e45a87d3006dad8",
    "Sources/slotstream-checks/main.swift": "02ebabaf058afa95622ccd29fb65d80b7eac41c9e6232f0167ef288c2126e0d9",
    "Sources/slotstream-cli/CheckRendering.swift": "0905dcbae17a5b3d66e13a760c4054fb29d930331d32942a528510ecfe9769a1",
    "Sources/slotstream-cli/ContextCommands.swift": "3ba24ae3e24dd10214e3288f007952d9e2b06241c081e29313b42ac7aa7a31bb",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift": "b921d4791feb0caab0ef50f74e92e0bba202e9ccf84ed1b9f4571e3a184ab696",
    "Sources/slotstream-cli/MTPCommands.swift": "190b88f5e069d11361597b0fa869ffbe21b003fecc635cc8907a9a55d3239576",
    "Sources/slotstream-cli/OptimizationCommands.swift": "9a0013222a0accfb268bb860f94e8939b2b99f8fb31bd949be9d5e9ace83e8d5",
    "Sources/slotstream-cli/PackedExpertCommands.swift": "ea7f4485d60a985a0a1f759f077d28dc42f36512dc1dd07a7644a22e31346b12",
    "Sources/slotstream-cli/PrefixCacheCommand.swift": "266b9571726fe280c11d5dededa565375af1749b76c7e70def4fe9530729914f",
    "Sources/slotstream-cli/Pull.swift": "4fa56def1edb0ae575bd898e3b53b669f0a16b04d734ef86e0f6c4a6ad185d14",
    "Sources/slotstream-cli/SweepCommands.swift": "37455d724a63b1689208dce9d55cd3d249bcab6d45bdf40d5c5e4f6992aa0d20",
    "Sources/slotstream-cli/VisionCommands.swift": "df80e089ea9cdbc6fc51ec7dc895b0dbf0eec5d4db80eb73b0ca9720a3ce8cc0",
    "Sources/slotstream-cli/main.swift": "9eff0455736b4d5ecf6825463d1a3fac5863ce549540f82c7b11734366a5f919",
    "Tools/build_sevra_mac.sh": "c54606315dafd8755b12b48aed50a95b90a527d9c7fc34ee8daf20c961b815d7",
    "Tools/generate_sevra_icon.sh": "8228ccb8e4d707c2a73336f283ed599f72cbc2213589ca36191d675e737141b6",
    "Tools/lib/mlx-0.31.1.metallib": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597",
    "Tools/mac_build_inputs.py": "8ea8316c74a1056182128c4f81a9651bb3ff9dd328569811d795301c4cb7b335",
    "Tools/render_sevra_icon.swift": "cbcf593dec275773cc86118bc4d6aff423534d9df7e62ef0fb014733c9aa3095",
    "apps/macos/App/AppModel.swift": "7f1f6d0c81bd7f10e8dd2954c4c2f4004c240871d14f1c1a5bb015ba758c622b",
    "apps/macos/App/ContentView.swift": "342a0436254740a51aeddf1fe930765a4eeff294a2b7e5f3c11e64fe76b94968",
    "apps/macos/App/MacCommands.swift": "059ebbbaf81cb83f3c57bdc1f635b1d30e0f8913fe776ce4c9c2615c979fa481",
    "apps/macos/App/NativeText.swift": "626011238af01cb0b4179e582f00ca40c83afa5591492bc9797a4b57e191635b",
    "apps/macos/App/ObserverMark.swift": "93f172ecc0b360338bb09913071a6ba6644077576abf9b323bfa95ebd4c5b764",
    "apps/macos/App/SevraMain.swift": "a001519c25160a01a38596c6bcb214d117ce3074ea22340fff2d005168b4b21b",
    "apps/macos/Info.plist": "73cc83e91b2729b1ef576226fd95104e0bb763f874fe937d81d92d9785e8bdb6",
    "apps/macos/Package.resolved": "766f45a6da66031f58629e0446f18060a3c92699b1346c8e028181bc9aaeffd5",
    "apps/macos/Package.swift": "20288a7efe64b916a71e1dadd9a9e249fb1f5b6d10048b22e69c62e37a9f91a5",
    "apps/macos/Presentation/ComposerSession.swift": "ea87ddd71658f9876dec8565c0210ef839085f7eeb74c6b95294f348fad51d46",
    "apps/macos/Presentation/HistoryPage.swift": "a97110301fe774fa0236f1b5dfced7a437620953f30e23656affb716b35f2032",
    "apps/macos/Presentation/MarkdownDocument.swift": "26a2501a3e1b10a60ef72e2d98748f0d6778cef7c5df28c648f7db99fcb58f9d",
    "apps/macos/Presentation/Module.swift": "dda9b75f64b106eb544de201f599122d75abc483c5b156bba6c05c0f956dbc3c",
    "apps/macos/Resources/Fonts/Inter-OFL.txt": "5b9321a4298cfeb6b34354164a1c3afc3db114569984c502b9b35d988fd58c57",
    "apps/macos/Resources/Fonts/Inter.ttf": "29160a80ff49ddcab2c97711247e08b1fab27a484a329ce8b813d820dc559031",
    "apps/macos/Resources/Fonts/Poppins-Medium.ttf": "90373e7d838d32468438fc3e152dca0bdb12edcab99ea639f158790b1ba1fd05",
    "apps/macos/Resources/Fonts/Poppins-OFL.txt": "6be04893d770899a015649c7aa3b582f871b272f8747a92b78b17c3e5c8b2573",
    "apps/macos/Resources/Fonts/manifest.json": "1e79dfd278dbe9bfd8afbf7e5cbaee64dff1574fc1cc3aca8fdd903f4056677e",
    "apps/macos/Resources/Licenses/swift-cmark-COPYING": "c22e885f33b821bddb24cf007145e5540655b6c0f403e49e6c76a93c28e6d9a9",
    "apps/macos/Resources/Licenses/swift-markdown-LICENSE.txt": "167beb36f181bd163c93c6feb45c68e5f9462fe1af55b278f7bfd1df20e673a3",
    "apps/macos/Resources/Licenses/swift-markdown-NOTICE.txt": "ee7da43afcac4a52196a2141024573ec2ceb84b14e74dfed38522d94586fbc52",
    "apps/macos/Resources/Sevra.icns": "b28f2df8e40cafc2e89fb3ae5a0e361b5470851d833495df9b3dd4ca0395471d",
    "apps/macos/Runtime/HomeStore.swift": "81b17acacdc2557bd04dc86f033553bd7c6ca00b38dd7be184ae53a6abf5789e",
    "apps/macos/Runtime/HomeTemplate.swift": "61cbd2fafefcbcfb21c90d043be66234e4da37b1220c0355d973ffa42ed1cf07",
    "apps/macos/Runtime/Inference.swift": "896df732fe4cb8e760cf6e5d89e2fada828635c053f0828329d76b66c49f202e",
    "apps/macos/Runtime/LocalIPC.swift": "896fdb1e597888c54c7d0ee79ba61e186b4bfd8c1d745d67196ce7b611242984",
    "apps/macos/Runtime/ModelSetup.swift": "0710c291b65007ed39cde6b77b10bc4c2636cdfc44bbb7975f9aec1b30d3c501",
    "apps/macos/Runtime/Models.swift": "aa1fe954f65ae8f5d73bc04e5cbbb6ab9c57f424f4941d6e1fc13bdf1ba6b8bd",
    "apps/macos/Runtime/Performance.swift": "b771d35aa8af3dcb6de0d88fe4585ac9b405b01e15d7a0fd1695f7ccad94dc00",
    "apps/macos/Runtime/Runtime.swift": "cf8700cc150efe2bb28761082d4010f4c7b4fd824452af1f00db2fedf1e06410",
    "apps/macos/Runtime/SourceTools.swift": "71c30fa54ac76b6de953b4bd4c9b2fe9af76144315fa21535d22a303fc3fea63",
    "apps/macos/Sevra.xcodeproj/project.pbxproj": "9cc99dbdd7fb8e54224e2f48993e99bdc8084a5432fbcb7f2483c1d812cf7a5a"
  },
  "scope": "Local development build inputs. Ad-hoc signing is not release qualification.",
  "sdk": "26.5",
  "swift": "Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101)\nTarget: arm64-apple-macosx26.0"
}

````

### sevra-adversarial-ui-final-inputs.json

SHA256: `abed07d70fc12c349262c9bde86b7150f53db82b70d65055b2b9771ee5588b17`

````json
{
  "dbmd_sha256": "ce799f5d8105969bf57c80d451fd8e5a10d325eee01dac659f15694b5355e8ef",
  "files": {
    "Package.resolved": "6fc23da3ddc636949e84042cb70da34bc93c4355feef14857880caa6c3c7fceb",
    "Package.swift": "8e2faec45c5aa764014d61b5cc04dee63640660322ad3e943084d5cb6dee4f87",
    "Sources/CSlotpack/include/slotpack.h": "07301354bebebac253975abbd5981006be411fed444abab0b6bbc857e28bdd1b",
    "Sources/CSlotpack/slotpack.c": "be45d2daf3e7e95d66cb9178f40dab292b85b1998086d71c53e41f59596d57a2",
    "Sources/Slotstream/AdaptiveSpeculation.swift": "da8062ff16c1d72ccd28852ba18e43cd434a8165483d045759cd29a499f5fff6",
    "Sources/Slotstream/BlockSelection.swift": "16e5fb4a4ea82728e3caaf3d6f4cdbf7d91614b757b0624913ae14c052d6f27d",
    "Sources/Slotstream/BoundedOutput.swift": "70c21c3583edecdd856af06c2fae567bccaf0ea2005ddb932a7dd99642e7780f",
    "Sources/Slotstream/CPUSlotWrite.swift": "da137aec8944dab6590cbea17afff28f094aef876688d20782b5791028d83349",
    "Sources/Slotstream/CacheBookkeeping.swift": "0c3726c431b41a2c84fa2ea21ce49eb209f2c36955925754508a51cb54ae0779",
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/CompiledArithmetic.swift": "98611b31035459d237d901be7fff175072c30b32b992c7534d770b1bc6d117f2",
    "Sources/Slotstream/Context.swift": "2ec4523a59da75efba101b56e9d0e943feb477084e593e68827f84e1ee8b7f44",
    "Sources/Slotstream/ContextFeasibility.swift": "582f40326eea4d969834eefa13425dec345b5630206235640b4b9536ddb044d2",
    "Sources/Slotstream/ContextMemory.swift": "848df7f507cd1cc0d978ea29866f4c5c9635f5091ff236e551cde652cc668d9b",
    "Sources/Slotstream/ContextWindowPolicy.swift": "6da4b93a1a01b1d1b9be13b14d7c4d3b3751f1c38575672d4489f3545a913ab6",
    "Sources/Slotstream/DecodeLookahead+Configuration.swift": "0731bd8d9d7674b3b143bef039ca84d56f11bbb1f255ba7eb31292b17a91c33c",
    "Sources/Slotstream/DecodeLookahead.swift": "13ff2deb101b25f302828a25f090af7c2abf52c2f4baf8e927f6c050545e4668",
    "Sources/Slotstream/DownloadConcurrency.swift": "cf872e6e99b9e1df121a9feba4c0c8420719fe62a5f5a50e58b26bf11cb8126e",
    "Sources/Slotstream/DownloadHTTP.swift": "341a7a7157c575658ee7d7bc6c77ed593bf30f79d8c262906d7672e2e40c6cbc",
    "Sources/Slotstream/EmbeddingRows.swift": "10c722abb55b03bd6ae0f8188ec156f97e2a7603a516bd91919e060d8fc5a645",
    "Sources/Slotstream/Engine.swift": "3428ab0552cc27364fbfeb0c731ef8d73be412e12ed13bb6bfe04813afb02459",
    "Sources/Slotstream/Errors.swift": "0f65317656d38709f071fb58cb4c11f11f68f0949be02a781c675f37f76f5b57",
    "Sources/Slotstream/ExactRead.swift": "bd90fbeb1d400cb7dda746d434a5c4f1fbb4d767506013e4398de9ba1253a47e",
    "Sources/Slotstream/ExpertLookaheadTrace.swift": "16e69d2c91c54d9c45f3df7c7d6e8121fd0fcd8abc627801ee4a4e131556061a",
    "Sources/Slotstream/ExpertPredictor.swift": "2f25044ff7258ac53973c3e5de7138ad078b0b90a1ab13cc332cab8bcfa0740e",
    "Sources/Slotstream/ExpertPrefetch.swift": "7c3ceca11a8587942bb2c60d4c04afbd762b4643e4170a27281bab6366f4369e",
    "Sources/Slotstream/ExpertStore.swift": "f69c680e9c130a178a84db8b6df6e63aabe64a5da2b9963c7e724114e8715ce6",
    "Sources/Slotstream/ExpertTransferProfile.swift": "17fe476f01b03d3a151506d324d9ad0d83d8dcf152489c9e88805ddea2b302ad",
    "Sources/Slotstream/GDNPhaseProfile.swift": "f74d843773b549530cebe9e5df79a02b0104068e05c39ff6adfcbae3effaef66",
    "Sources/Slotstream/GatewayDialect.swift": "93561b74b171c78d107dca5985a1c0601f7ca0ce4388f0a3aa03e9bd0c6bd0c8",
    "Sources/Slotstream/Generate.swift": "2668a164ad5d82bd20ff58c682c11a754efa1c53a5572da619dfe01181e60d2a",
    "Sources/Slotstream/Governor.swift": "ddac4e5d20f3a771cd81767d7734f7b2206b93ea1b2981388b78d6ac5abe1406",
    "Sources/Slotstream/LayerLocalVictim.swift": "9615385e6c2ac18573f4d2089a75a70d356d803c0c4a603b4db3397fafa6275c",
    "Sources/Slotstream/Layers.swift": "a724e905905b256a5a463cc8585a227a0062976c879cf57d2b3f2d3ca4278b52",
    "Sources/Slotstream/MTP.swift": "10b63deee430c1e1d5792221f128bea0a6158161911676679665a168116cf743",
    "Sources/Slotstream/Machine.swift": "ffed1d45e029e21e42e1eb956d1b3f2647aae2bca689f532b5dc2dba897c89ee",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "26aa0f5c18d24e3692363570e92f59dfcd34c080aa213b846b39156a9047b4b5",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/OpenAIDialect.swift": "714263f4382c83835c4e617ffcb72e231c270a0f0d8be497881cdfc663d52f58",
    "Sources/Slotstream/OpenAIOutput.swift": "d13c9a29f3dbcf9fb9933e5a378f3ba8160d7eb4f96d3c7a61f3faed5a563b76",
    "Sources/Slotstream/OptimizationPlatform.swift": "e4c17aeb1ab294ac9d9e9c60095cc5360382c0809a4f579672b4d0b66a0ed3cf",
    "Sources/Slotstream/Optimizations.swift": "4f3b35ad41cef026e7bcccfeb03580a1d4c4ade57a21eacb5b195f0dff38bee8",
    "Sources/Slotstream/PackedExpertLayout.swift": "c74e9867e2c37ba92d84bf7ce90253eea6db6f8531a6d6b8792874d4810cc6ee",
    "Sources/Slotstream/PackedProjectionPair.swift": "84fa87130270092c16a538f7d50cfee55e71b52ecd8250a1bce7e0547c8b1d96",
    "Sources/Slotstream/PartialRotation.swift": "57177495e6ba630c66744b2b9e2bde23acf9349fca52b97a4ea406c5839c7f8f",
    "Sources/Slotstream/PersistentPrefixCache.swift": "2761c700990f8295e069108828ebd9c91aaf7cc12bc3649ce06690fc7ed25665",
    "Sources/Slotstream/PersistentPrefixFormat.swift": "eec16cb611bf9a5c617ea73f465f05db1f4fdae503b1b3655b59d6cbe7290702",
    "Sources/Slotstream/PersistentPrefixGenerator.swift": "36a24796df4c6d9c5bc56170888be142749d787d39dab79bbe9c9e4b278db47e",
    "Sources/Slotstream/PersistentPrefixPolicy.swift": "40cfc47a5e4a5f3cb91e1264e1bac3121bb871335313205a3529a89e9cb24aca",
    "Sources/Slotstream/PersistentPrefixRestore.swift": "ee3bc4123ac885375ac2be349454f92dcfecd28478eb905427d5f33e6925e8c4",
    "Sources/Slotstream/PersistentPrefixSave.swift": "3605a27cacf1c7b94bb228785d7be1b1e4bbb4a64f455c4b93ea6b2f292d811f",
    "Sources/Slotstream/PinnedModel.swift": "0c7c16539bcb54924ff7306b03b470e2915b5bb41c4ecff9e60dc7912e7afdd2",
    "Sources/Slotstream/PinnedTransport.swift": "f30c4c4bfeaf49c5e2dfcbfa728d6eab44d02a1f77d40217e84723fd03761d87",
    "Sources/Slotstream/PinnedTransportManifest.swift": "6b0de220938fc91dd4dc24cd0fc9dffa086f09f04cd83823dc3de3a13de8ac11",
    "Sources/Slotstream/Plan.swift": "a93709d5b77069ca9558846efc988f9c81ee2f88303e4dd407f8e417f961536b",
    "Sources/Slotstream/PlannerCostModel.swift": "a95e2781a7448418ec78480be356bac9eb80bb36cc64c63f6cb3e378043d29c0",
    "Sources/Slotstream/PlannerDevice.swift": "528cdf93cf0fe600b8c53a3eb828b9b1922ee4817fa100393a11d4e2714784f8",
    "Sources/Slotstream/PrefixCache.swift": "96f5c3aa54471582d5e8a6b4a2a6b37e8ea284c5e9ce29e5b133a306cf5a42d2",
    "Sources/Slotstream/PressureBoundary.swift": "ed22537fccc321589eb3d33b3538984630daae951d00e4ac829412897b181a3d",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Sources/Slotstream/RequestControl.swift": "a8bea5078dbd26458331af41fba986f9de05d386637b69768e2035c95345bdea",
    "Sources/Slotstream/ResidentExpertOverlap.swift": "4ddb3a027d92697dcc1e7373e66fc139abdc12063448d864ef635e5202f57dde",
    "Sources/Slotstream/RouterProjection.swift": "98ea668ac6f47549ec9cdee41b81109e66f11935946d2d1587ebf97ad106230d",
    "Sources/Slotstream/RouterSelection.swift": "35b122748ab05c00122bfb5b4c78416ee28b55abaa4d4e1379fd163aaf47b4a6",
    "Sources/Slotstream/RouterTrace.swift": "b34c1974f60015c913649a285023e57b15d92f37c2f7aa282b821eb2043652c1",
    "Sources/Slotstream/RoutingReadbackQueue.swift": "477ad597e6e741cb939c9ade983934814e2a7c6b8e7c59fc659a1dc02eb4b4ab",
    "Sources/Slotstream/SelectedAttention.swift": "70e61a089444f74cc74494d7f05005b0ff4dfe67043782befbbef80d96b911db",
    "Sources/Slotstream/Server.swift": "c20776840aa9551958d8fed92389c8fc32318c97639bd14d93609233dc449334",
    "Sources/Slotstream/SlotWritePlan.swift": "9abde1de815522ff835d3c685a2e342293f3c9c7019cfc742265193ea2e286c1",
    "Sources/Slotstream/SlotpackDownload.swift": "fb6f47ce70f30713cf1679ebda619c980e9d783dd6ae4cd1cc4e0a68b14705b7",
    "Sources/Slotstream/SlotpackManifest.swift": "8664440e22653e64b85c0100345169dd93b3836d1bbd125ac2add4f621b9876d",
    "Sources/Slotstream/StatePrefixFork.swift": "35ed6954bc927e37c117d53eb25e007b83b3385099bc9b18e01607f30abb7df7",
    "Sources/Slotstream/StateRecovery.swift": "078521e0e08233c06706408bb6dbc53f902285fc4c891af2e164386bd41bf98b",
    "Sources/Slotstream/ToolCallSplitter.swift": "2c2e1d722188d633508c871d73f011fa4053b666d10b7585b304c151c53925a8",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
    "Sources/Slotstream/Version.swift": "4a34c363a6357ae06fb07c9d58f959de072ae0d4dad889e8f9c0e88063a5613c",
    "Sources/Slotstream/Vision.swift": "38565f564bf8ba73d2dc87e2f1874fa6fda2652e094a324048bfa8cb1278a79e",
    "Sources/Slotstream/VisionAttention.swift": "83b1012cb0b3a2c22098f71515e3e853cf1ca3affb01cb667a8248e3c34c63a5",
    "Sources/Slotstream/VisionPrompt.swift": "61b90891a5ec9944406287fa73b4c0e5bdd29b4e3903dff345cbeb80638c6435",
    "Sources/Slotstream/WeightDownload.swift": "2758b2eea2631635cd3da5c18a87e724c57aab5c78ad816b7e18d7ff48c8c98d",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "4c6112412f38192de1955bedb6b7f3cddcb2d0b338b570b6b688df4638a55e5f",
    "Sources/Slotstream/WordSlotWrite.swift": "1c19def2346669acc1afa811a7244233c6f593de91c02bfc4ff145465b95187e",
    "Sources/SlotstreamDiagnostics/CheckReport.swift": "9bbe2106b5b55331cc3fbc093edd803eff6f9f00ebd5f30ce587754fe0bc7e47",
    "Sources/SlotstreamDiagnostics/Diagnostics+AdaptiveSpeculation.swift": "e53d32c4f5a3fc7039a258db5c5b3c530416d07828c5d424a8f35e67d80dc256",
    "Sources/SlotstreamDiagnostics/Diagnostics+AllHitReplay.swift": "187a98c70c2e66008622db3727f0bf58126928862bc102782574fa0ba5f57513",
    "Sources/SlotstreamDiagnostics/Diagnostics+BlockSelection.swift": "08d3f1fc29b6353443b795198295bacb85f57d0a2bdbac67450cf66d505f852c",
    "Sources/SlotstreamDiagnostics/Diagnostics+CacheBookkeeping.swift": "6db1e4743b6adce39f32c2c5c0ff9c38bb86d7e9548c41e6c0e7d64299dd9cae",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompactIndexer.swift": "3dd65c8fac32f2804cce942845946debe74ca83b9cf6485a441ed15331711a5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompiledNorm.swift": "9f1beb774172bc33a27020261532e06723f0794adba9ab5dbca7807d01a0748f",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompletePrompt.swift": "75cdd2137b2856407d2fb297504039b174b3ae116b40608d5f42fabf0237a66d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ComputeIslands.swift": "ac7f3b5ed140a566348e9be06274cf757144d2db099fe5af097c4a3807dc6801",
    "Sources/SlotstreamDiagnostics/Diagnostics+Context.swift": "76ea9c95cd2d20614533458ffe32c8e8fd6d29dee3b1bece7476e27d3f589ce0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift": "51e505bd3279983263ad731133b2f1e20606387cf03ba360ffcb2fba34dd33a3",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift": "90b83306d1966da794daf28cc84f426a42cd853075f5e236cf1bacae10787d8f",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeLookahead.swift": "a27f1040ec4bea2a5e02f25f2a4d51a6a15ff78bd0609b1c23bd97e1adc3822c",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRows.swift": "a0f0532a43c1329b3a69f8a3bd8607df9f27793c0994ad23203936896b44e81f",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRuntime.swift": "c5c37fafb45b2ac2434a36cd7c8b8804fac0e271e9e3f0fb10ef97481db77e24",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExactRead.swift": "77a357f55c3f5aced5ba0d74012e35f73e678e0840024f24a5ab86909d335c59",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift": "6a88a4b8bb8b35d6ca80d63cc1264f4da44218ca0229320960a8328ad2e95935",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProfile.swift": "6d982a575d6c6282941a9f9f3ac063b75d31996fcde387a63ca3ce44fea93242",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProjection.swift": "983a071e562451dbc22cfe09b005d9c68af687c10e7d94802d7d3cb28af1c7cd",
    "Sources/SlotstreamDiagnostics/Diagnostics+Governor.swift": "8ec85ff3609cd5657eae1a8434189e9474460aad0c850f6b88240457c8f0f1fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+HTTP.swift": "9526e51122c9e463ea9a3201da6e4628f3794f329bd4ca05f1496daf3c66c1e5",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageFailure.swift": "766742295107f924177f7f724a7be61f8ccb29b3e044a7de345523598c31cead",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageReuse.swift": "5d0e619769c0f7d4ea8c73439ac44bc499db6184c4954b417f4cb7804aec20e8",
    "Sources/SlotstreamDiagnostics/Diagnostics+Integrated.swift": "5eb2132959b1db779caa520a3eefe5d6c5ffdd9ed317750c8cee48f02bd05941",
    "Sources/SlotstreamDiagnostics/Diagnostics+LayerLocalVictim.swift": "d512d93741a6675412cc9e6c739b940132ca3f20ebecd709884b00b1ebbc49b7",
    "Sources/SlotstreamDiagnostics/Diagnostics+MTPIndexer.swift": "7784a18a1eddafa25ecaee9eeacfbcddf8bcabac8d53919f80367a4f4e5be476",
    "Sources/SlotstreamDiagnostics/Diagnostics+Machine.swift": "20f6edb816fc3a794143042e59847adbfc1fe06514fc990e8a3d81eb87abe50c",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramCache.swift": "9bee4eb6c6cf09df5673e177d4b7f006681794bf680366b4549e4fa3d38b7368",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramLookahead.swift": "3b0bc7ea21a57d2ce65e58773879f5f86ba7f0f37c47d8f1d08d51e61c486370",
    "Sources/SlotstreamDiagnostics/Diagnostics+Optimization.swift": "35d99deb614da4ffdfef075eabdc5a1c8b3518bf9accf265796e09f2c7c281ee",
    "Sources/SlotstreamDiagnostics/Diagnostics+Output.swift": "e39951dc83e8410abdc840d0a739e1e1b2fbbdf1e2d06b3cb2d28c39ee9329cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+OutputServing.swift": "50bb807143f1e5134f52a6f3d48b8da297f4186dd91895e016d191ca13ccf66a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PackedLayout.swift": "14c31f94ebdd8bbbbb1479c77d0649b4c0632d978e4d8a60a8048214a1e08e65",
    "Sources/SlotstreamDiagnostics/Diagnostics+PartialRotation.swift": "de75d07feedc163834fe8e716683af8b2d373c51b0588ccc2cac922f775367ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefix.swift": "46a5bc33ee3fd389694f22c9e7ff5cdd995539663b3141688414351f50ac3189",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixModel.swift": "3e06c67777ce3572d9bd7cce5d220be5f41af90e31b6f5da349ba6f3ec667798",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixPolicy.swift": "82dcadab2ac079d3662da6dd012d8a031c4bdea9ee8c022ac34d5faf66277f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+PoolRequests.swift": "e383c494263afa029a9ef107c90d6ba59f44cda5da7ca1035eae68cbda3562d2",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillQualification.swift": "f40d8e711121f12cbcd95f8880d483ac36995faeab06af714d201fa1671348f1",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixCapacity.swift": "b76e9185930a90d2509f9d7dfc247afee3ff2a083a1bc6bb3da6d090653d290f",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixFork.swift": "e7a7094b3930cef8e380d711f20e8f82e2821c070579549692a6120e9ba3afc4",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixRetention.swift": "5de9452266e8e59da03b078990689554fc7a419a5cd8e5879cc68e2e277ea8cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixVision.swift": "5e4737dbe5344492fc2f9c6881f8d56e997668f674c91b28b9349c9420465f72",
    "Sources/SlotstreamDiagnostics/Diagnostics+PressureBoundary.swift": "f84979a3da94bc5ac0cfeb5cc84b61af43716c5664cc71853085ffa1b116d325",
    "Sources/SlotstreamDiagnostics/Diagnostics+Pull.swift": "224e4bf5210afbddd992894860343add73d1f52b12b2d9a00abf78fdc492ada0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift": "1532f45714ceb98a5adcfa31abd31f065493164f49d2ee3aac868d5d4080b04c",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift": "9e98b6e0fd6c30f36d1d3ec8d556216f351a2f09ee5d15dbb4f5580858fad4b4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadRecovery.swift": "5d51636a62b376e74dfefab207fdd42da61436210973f714819c7cc11488a04d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ResidentOverlap.swift": "c1e7b847cffa51939b0ae20027b289efcae5585a94ae5c1c751a66f110a25522",
    "Sources/SlotstreamDiagnostics/Diagnostics+RopePerformance.swift": "19d040f21391a1ea87831b73a8adf055a78aeafe9d902bd11ce22fd6a492d892",
    "Sources/SlotstreamDiagnostics/Diagnostics+RouterProjection.swift": "3981e415003e6258d41690216a7ab668652a0ce436bf644d99d88dbc2799db9e",
    "Sources/SlotstreamDiagnostics/Diagnostics+RoutingReadback.swift": "f29aad2cde3bbb526f83dcec4565f3c382d071734acc47a0e31d7223312713cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+Runtime.swift": "b6debc0a68e2df94574964c13afa41a76a5aab783e75d1428da25110d241cffc",
    "Sources/SlotstreamDiagnostics/Diagnostics+RuntimeBudget.swift": "b5ce492456b9e27b19765a0bd4f23cbd81ccff034be5af3142737cdae7944d6e",
    "Sources/SlotstreamDiagnostics/Diagnostics+SamplerPerformance.swift": "4e6dd7e85d7ac0f2b2af291343ab4cdc52fa94fe6edb588c1d517008a0c35cb3",
    "Sources/SlotstreamDiagnostics/Diagnostics+SelectedAttention.swift": "8dd385da9b79c3625d1cc9ccc6c8821978f88437fcded918f049328b7a969e7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Selection.swift": "b737794c5a57cd224f36a93b960fa9834cabb51ef810945bab64fd71e59c91d0",
    "Sources/SlotstreamDiagnostics/Diagnostics+SlotSlices.swift": "32c10a839423b13a4dceff67a5b2a617f90d145376a70b19bd27f2e62452e288",
    "Sources/SlotstreamDiagnostics/Diagnostics+StateRecovery.swift": "a53db99ff0f97a26e87586e35bf05daa26b9281fe7d686a1670c14984da2dd77",
    "Sources/SlotstreamDiagnostics/Diagnostics+TerminalPrefill.swift": "7ef27bec8489f52ccdd3ea51c125d21eb94512924b163e854b7aaf25ef39f57a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "be63108d11318a9469d26587ade08c79bf34274c61b847d752663d8ce007f9af",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "da4b4a89d9b11d26a64cd244aae2887acfbca16a6d3aceefa8f40f90c8e39634",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "fe3aaf4ad816c02fc0b28771d6c3c7f9cf7b2a9f102ea4fce660c1dd8541a650",
    "Sources/SlotstreamTestKit/T0Checks.swift": "c3078392faebeddc26b250361a400ac66a756def9ee38edb972c21f3a80266e0",
    "Sources/SlotstreamTestKit/ToolCallChecks.swift": "f1b263239f4e82707c77a5887367fb5302e96d369f2f278e0e45a87d3006dad8",
    "Sources/slotstream-checks/main.swift": "02ebabaf058afa95622ccd29fb65d80b7eac41c9e6232f0167ef288c2126e0d9",
    "Sources/slotstream-cli/CheckRendering.swift": "0905dcbae17a5b3d66e13a760c4054fb29d930331d32942a528510ecfe9769a1",
    "Sources/slotstream-cli/ContextCommands.swift": "3ba24ae3e24dd10214e3288f007952d9e2b06241c081e29313b42ac7aa7a31bb",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift": "b921d4791feb0caab0ef50f74e92e0bba202e9ccf84ed1b9f4571e3a184ab696",
    "Sources/slotstream-cli/MTPCommands.swift": "190b88f5e069d11361597b0fa869ffbe21b003fecc635cc8907a9a55d3239576",
    "Sources/slotstream-cli/OptimizationCommands.swift": "9a0013222a0accfb268bb860f94e8939b2b99f8fb31bd949be9d5e9ace83e8d5",
    "Sources/slotstream-cli/PackedExpertCommands.swift": "ea7f4485d60a985a0a1f759f077d28dc42f36512dc1dd07a7644a22e31346b12",
    "Sources/slotstream-cli/PrefixCacheCommand.swift": "266b9571726fe280c11d5dededa565375af1749b76c7e70def4fe9530729914f",
    "Sources/slotstream-cli/Pull.swift": "4fa56def1edb0ae575bd898e3b53b669f0a16b04d734ef86e0f6c4a6ad185d14",
    "Sources/slotstream-cli/SweepCommands.swift": "37455d724a63b1689208dce9d55cd3d249bcab6d45bdf40d5c5e4f6992aa0d20",
    "Sources/slotstream-cli/VisionCommands.swift": "df80e089ea9cdbc6fc51ec7dc895b0dbf0eec5d4db80eb73b0ca9720a3ce8cc0",
    "Sources/slotstream-cli/main.swift": "9eff0455736b4d5ecf6825463d1a3fac5863ce549540f82c7b11734366a5f919",
    "Tools/build_sevra_mac.sh": "c54606315dafd8755b12b48aed50a95b90a527d9c7fc34ee8daf20c961b815d7",
    "Tools/generate_sevra_icon.sh": "8228ccb8e4d707c2a73336f283ed599f72cbc2213589ca36191d675e737141b6",
    "Tools/lib/mlx-0.31.1.metallib": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597",
    "Tools/mac_build_inputs.py": "8ea8316c74a1056182128c4f81a9651bb3ff9dd328569811d795301c4cb7b335",
    "Tools/render_sevra_icon.swift": "cbcf593dec275773cc86118bc4d6aff423534d9df7e62ef0fb014733c9aa3095",
    "apps/macos/App/AppModel.swift": "59ec35ae4b9c3b0b37f94fef523f1e074206784569c9aee772af908a55b5a409",
    "apps/macos/App/ContentView.swift": "26244881858eaafc6fe95fc9b6a979f541a8d53f259e5c2371a7df6803132c1d",
    "apps/macos/App/MacCommands.swift": "059ebbbaf81cb83f3c57bdc1f635b1d30e0f8913fe776ce4c9c2615c979fa481",
    "apps/macos/App/NativeText.swift": "ffda81e14f2d8a59b54923e0a66a726b7ffd618a0e77d41dfd8e76c9d4f20dab",
    "apps/macos/App/ObserverMark.swift": "93f172ecc0b360338bb09913071a6ba6644077576abf9b323bfa95ebd4c5b764",
    "apps/macos/App/SevraMain.swift": "a001519c25160a01a38596c6bcb214d117ce3074ea22340fff2d005168b4b21b",
    "apps/macos/Info.plist": "73cc83e91b2729b1ef576226fd95104e0bb763f874fe937d81d92d9785e8bdb6",
    "apps/macos/Package.resolved": "766f45a6da66031f58629e0446f18060a3c92699b1346c8e028181bc9aaeffd5",
    "apps/macos/Package.swift": "20288a7efe64b916a71e1dadd9a9e249fb1f5b6d10048b22e69c62e37a9f91a5",
    "apps/macos/Presentation/ComposerSession.swift": "ea87ddd71658f9876dec8565c0210ef839085f7eeb74c6b95294f348fad51d46",
    "apps/macos/Presentation/HistoryPage.swift": "a97110301fe774fa0236f1b5dfced7a437620953f30e23656affb716b35f2032",
    "apps/macos/Presentation/MarkdownDocument.swift": "26a2501a3e1b10a60ef72e2d98748f0d6778cef7c5df28c648f7db99fcb58f9d",
    "apps/macos/Presentation/Module.swift": "dda9b75f64b106eb544de201f599122d75abc483c5b156bba6c05c0f956dbc3c",
    "apps/macos/Resources/Fonts/Inter-OFL.txt": "5b9321a4298cfeb6b34354164a1c3afc3db114569984c502b9b35d988fd58c57",
    "apps/macos/Resources/Fonts/Inter.ttf": "29160a80ff49ddcab2c97711247e08b1fab27a484a329ce8b813d820dc559031",
    "apps/macos/Resources/Fonts/Poppins-Medium.ttf": "90373e7d838d32468438fc3e152dca0bdb12edcab99ea639f158790b1ba1fd05",
    "apps/macos/Resources/Fonts/Poppins-OFL.txt": "6be04893d770899a015649c7aa3b582f871b272f8747a92b78b17c3e5c8b2573",
    "apps/macos/Resources/Fonts/manifest.json": "1e79dfd278dbe9bfd8afbf7e5cbaee64dff1574fc1cc3aca8fdd903f4056677e",
    "apps/macos/Resources/Licenses/swift-cmark-COPYING": "c22e885f33b821bddb24cf007145e5540655b6c0f403e49e6c76a93c28e6d9a9",
    "apps/macos/Resources/Licenses/swift-markdown-LICENSE.txt": "167beb36f181bd163c93c6feb45c68e5f9462fe1af55b278f7bfd1df20e673a3",
    "apps/macos/Resources/Licenses/swift-markdown-NOTICE.txt": "ee7da43afcac4a52196a2141024573ec2ceb84b14e74dfed38522d94586fbc52",
    "apps/macos/Resources/Sevra.icns": "b28f2df8e40cafc2e89fb3ae5a0e361b5470851d833495df9b3dd4ca0395471d",
    "apps/macos/Runtime/HomeStore.swift": "81b17acacdc2557bd04dc86f033553bd7c6ca00b38dd7be184ae53a6abf5789e",
    "apps/macos/Runtime/HomeTemplate.swift": "61cbd2fafefcbcfb21c90d043be66234e4da37b1220c0355d973ffa42ed1cf07",
    "apps/macos/Runtime/Inference.swift": "896df732fe4cb8e760cf6e5d89e2fada828635c053f0828329d76b66c49f202e",
    "apps/macos/Runtime/LocalIPC.swift": "896fdb1e597888c54c7d0ee79ba61e186b4bfd8c1d745d67196ce7b611242984",
    "apps/macos/Runtime/ModelSetup.swift": "0710c291b65007ed39cde6b77b10bc4c2636cdfc44bbb7975f9aec1b30d3c501",
    "apps/macos/Runtime/Models.swift": "aa1fe954f65ae8f5d73bc04e5cbbb6ab9c57f424f4941d6e1fc13bdf1ba6b8bd",
    "apps/macos/Runtime/Performance.swift": "b771d35aa8af3dcb6de0d88fe4585ac9b405b01e15d7a0fd1695f7ccad94dc00",
    "apps/macos/Runtime/Runtime.swift": "cf8700cc150efe2bb28761082d4010f4c7b4fd824452af1f00db2fedf1e06410",
    "apps/macos/Runtime/SourceTools.swift": "2089501130ebd232c0c6789efff0ec28705d9a321c557ef61c4b1433e82e0f07",
    "apps/macos/Sevra.xcodeproj/project.pbxproj": "9cc99dbdd7fb8e54224e2f48993e99bdc8084a5432fbcb7f2483c1d812cf7a5a"
  },
  "scope": "Local development build inputs. Ad-hoc signing is not release qualification.",
  "sdk": "26.5",
  "swift": "Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101)\nTarget: arm64-apple-macosx26.0"
}

````

### sevra-adversarial-release-inputs.json

SHA256: `0023f60abb5fe904b85f9aeed3d0efab3bac1cf7f2233caef893cfb07e1e8c86`

````json
{
  "dbmd_sha256": "ce799f5d8105969bf57c80d451fd8e5a10d325eee01dac659f15694b5355e8ef",
  "files": {
    "Package.resolved": "6fc23da3ddc636949e84042cb70da34bc93c4355feef14857880caa6c3c7fceb",
    "Package.swift": "8e2faec45c5aa764014d61b5cc04dee63640660322ad3e943084d5cb6dee4f87",
    "Sources/CSlotpack/include/slotpack.h": "07301354bebebac253975abbd5981006be411fed444abab0b6bbc857e28bdd1b",
    "Sources/CSlotpack/slotpack.c": "be45d2daf3e7e95d66cb9178f40dab292b85b1998086d71c53e41f59596d57a2",
    "Sources/Slotstream/AdaptiveSpeculation.swift": "da8062ff16c1d72ccd28852ba18e43cd434a8165483d045759cd29a499f5fff6",
    "Sources/Slotstream/BlockSelection.swift": "16e5fb4a4ea82728e3caaf3d6f4cdbf7d91614b757b0624913ae14c052d6f27d",
    "Sources/Slotstream/BoundedOutput.swift": "70c21c3583edecdd856af06c2fae567bccaf0ea2005ddb932a7dd99642e7780f",
    "Sources/Slotstream/CPUSlotWrite.swift": "da137aec8944dab6590cbea17afff28f094aef876688d20782b5791028d83349",
    "Sources/Slotstream/CacheBookkeeping.swift": "0c3726c431b41a2c84fa2ea21ce49eb209f2c36955925754508a51cb54ae0779",
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/CompiledArithmetic.swift": "98611b31035459d237d901be7fff175072c30b32b992c7534d770b1bc6d117f2",
    "Sources/Slotstream/Context.swift": "2ec4523a59da75efba101b56e9d0e943feb477084e593e68827f84e1ee8b7f44",
    "Sources/Slotstream/ContextFeasibility.swift": "582f40326eea4d969834eefa13425dec345b5630206235640b4b9536ddb044d2",
    "Sources/Slotstream/ContextMemory.swift": "848df7f507cd1cc0d978ea29866f4c5c9635f5091ff236e551cde652cc668d9b",
    "Sources/Slotstream/ContextWindowPolicy.swift": "6da4b93a1a01b1d1b9be13b14d7c4d3b3751f1c38575672d4489f3545a913ab6",
    "Sources/Slotstream/DecodeLookahead+Configuration.swift": "0731bd8d9d7674b3b143bef039ca84d56f11bbb1f255ba7eb31292b17a91c33c",
    "Sources/Slotstream/DecodeLookahead.swift": "13ff2deb101b25f302828a25f090af7c2abf52c2f4baf8e927f6c050545e4668",
    "Sources/Slotstream/DownloadConcurrency.swift": "cf872e6e99b9e1df121a9feba4c0c8420719fe62a5f5a50e58b26bf11cb8126e",
    "Sources/Slotstream/DownloadHTTP.swift": "341a7a7157c575658ee7d7bc6c77ed593bf30f79d8c262906d7672e2e40c6cbc",
    "Sources/Slotstream/EmbeddingRows.swift": "10c722abb55b03bd6ae0f8188ec156f97e2a7603a516bd91919e060d8fc5a645",
    "Sources/Slotstream/Engine.swift": "3428ab0552cc27364fbfeb0c731ef8d73be412e12ed13bb6bfe04813afb02459",
    "Sources/Slotstream/Errors.swift": "0f65317656d38709f071fb58cb4c11f11f68f0949be02a781c675f37f76f5b57",
    "Sources/Slotstream/ExactRead.swift": "bd90fbeb1d400cb7dda746d434a5c4f1fbb4d767506013e4398de9ba1253a47e",
    "Sources/Slotstream/ExpertLookaheadTrace.swift": "16e69d2c91c54d9c45f3df7c7d6e8121fd0fcd8abc627801ee4a4e131556061a",
    "Sources/Slotstream/ExpertPredictor.swift": "2f25044ff7258ac53973c3e5de7138ad078b0b90a1ab13cc332cab8bcfa0740e",
    "Sources/Slotstream/ExpertPrefetch.swift": "7c3ceca11a8587942bb2c60d4c04afbd762b4643e4170a27281bab6366f4369e",
    "Sources/Slotstream/ExpertStore.swift": "f69c680e9c130a178a84db8b6df6e63aabe64a5da2b9963c7e724114e8715ce6",
    "Sources/Slotstream/ExpertTransferProfile.swift": "17fe476f01b03d3a151506d324d9ad0d83d8dcf152489c9e88805ddea2b302ad",
    "Sources/Slotstream/GDNPhaseProfile.swift": "f74d843773b549530cebe9e5df79a02b0104068e05c39ff6adfcbae3effaef66",
    "Sources/Slotstream/GatewayDialect.swift": "93561b74b171c78d107dca5985a1c0601f7ca0ce4388f0a3aa03e9bd0c6bd0c8",
    "Sources/Slotstream/Generate.swift": "2668a164ad5d82bd20ff58c682c11a754efa1c53a5572da619dfe01181e60d2a",
    "Sources/Slotstream/Governor.swift": "ddac4e5d20f3a771cd81767d7734f7b2206b93ea1b2981388b78d6ac5abe1406",
    "Sources/Slotstream/LayerLocalVictim.swift": "9615385e6c2ac18573f4d2089a75a70d356d803c0c4a603b4db3397fafa6275c",
    "Sources/Slotstream/Layers.swift": "a724e905905b256a5a463cc8585a227a0062976c879cf57d2b3f2d3ca4278b52",
    "Sources/Slotstream/MTP.swift": "10b63deee430c1e1d5792221f128bea0a6158161911676679665a168116cf743",
    "Sources/Slotstream/Machine.swift": "ffed1d45e029e21e42e1eb956d1b3f2647aae2bca689f532b5dc2dba897c89ee",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "26aa0f5c18d24e3692363570e92f59dfcd34c080aa213b846b39156a9047b4b5",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/OpenAIDialect.swift": "714263f4382c83835c4e617ffcb72e231c270a0f0d8be497881cdfc663d52f58",
    "Sources/Slotstream/OpenAIOutput.swift": "d13c9a29f3dbcf9fb9933e5a378f3ba8160d7eb4f96d3c7a61f3faed5a563b76",
    "Sources/Slotstream/OptimizationPlatform.swift": "e4c17aeb1ab294ac9d9e9c60095cc5360382c0809a4f579672b4d0b66a0ed3cf",
    "Sources/Slotstream/Optimizations.swift": "4f3b35ad41cef026e7bcccfeb03580a1d4c4ade57a21eacb5b195f0dff38bee8",
    "Sources/Slotstream/PackedExpertLayout.swift": "c74e9867e2c37ba92d84bf7ce90253eea6db6f8531a6d6b8792874d4810cc6ee",
    "Sources/Slotstream/PackedProjectionPair.swift": "84fa87130270092c16a538f7d50cfee55e71b52ecd8250a1bce7e0547c8b1d96",
    "Sources/Slotstream/PartialRotation.swift": "57177495e6ba630c66744b2b9e2bde23acf9349fca52b97a4ea406c5839c7f8f",
    "Sources/Slotstream/PersistentPrefixCache.swift": "2761c700990f8295e069108828ebd9c91aaf7cc12bc3649ce06690fc7ed25665",
    "Sources/Slotstream/PersistentPrefixFormat.swift": "eec16cb611bf9a5c617ea73f465f05db1f4fdae503b1b3655b59d6cbe7290702",
    "Sources/Slotstream/PersistentPrefixGenerator.swift": "36a24796df4c6d9c5bc56170888be142749d787d39dab79bbe9c9e4b278db47e",
    "Sources/Slotstream/PersistentPrefixPolicy.swift": "40cfc47a5e4a5f3cb91e1264e1bac3121bb871335313205a3529a89e9cb24aca",
    "Sources/Slotstream/PersistentPrefixRestore.swift": "ee3bc4123ac885375ac2be349454f92dcfecd28478eb905427d5f33e6925e8c4",
    "Sources/Slotstream/PersistentPrefixSave.swift": "3605a27cacf1c7b94bb228785d7be1b1e4bbb4a64f455c4b93ea6b2f292d811f",
    "Sources/Slotstream/PinnedModel.swift": "0c7c16539bcb54924ff7306b03b470e2915b5bb41c4ecff9e60dc7912e7afdd2",
    "Sources/Slotstream/PinnedTransport.swift": "f30c4c4bfeaf49c5e2dfcbfa728d6eab44d02a1f77d40217e84723fd03761d87",
    "Sources/Slotstream/PinnedTransportManifest.swift": "6b0de220938fc91dd4dc24cd0fc9dffa086f09f04cd83823dc3de3a13de8ac11",
    "Sources/Slotstream/Plan.swift": "a93709d5b77069ca9558846efc988f9c81ee2f88303e4dd407f8e417f961536b",
    "Sources/Slotstream/PlannerCostModel.swift": "a95e2781a7448418ec78480be356bac9eb80bb36cc64c63f6cb3e378043d29c0",
    "Sources/Slotstream/PlannerDevice.swift": "528cdf93cf0fe600b8c53a3eb828b9b1922ee4817fa100393a11d4e2714784f8",
    "Sources/Slotstream/PrefixCache.swift": "96f5c3aa54471582d5e8a6b4a2a6b37e8ea284c5e9ce29e5b133a306cf5a42d2",
    "Sources/Slotstream/PressureBoundary.swift": "ed22537fccc321589eb3d33b3538984630daae951d00e4ac829412897b181a3d",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Sources/Slotstream/RequestControl.swift": "a8bea5078dbd26458331af41fba986f9de05d386637b69768e2035c95345bdea",
    "Sources/Slotstream/ResidentExpertOverlap.swift": "4ddb3a027d92697dcc1e7373e66fc139abdc12063448d864ef635e5202f57dde",
    "Sources/Slotstream/RouterProjection.swift": "98ea668ac6f47549ec9cdee41b81109e66f11935946d2d1587ebf97ad106230d",
    "Sources/Slotstream/RouterSelection.swift": "35b122748ab05c00122bfb5b4c78416ee28b55abaa4d4e1379fd163aaf47b4a6",
    "Sources/Slotstream/RouterTrace.swift": "b34c1974f60015c913649a285023e57b15d92f37c2f7aa282b821eb2043652c1",
    "Sources/Slotstream/RoutingReadbackQueue.swift": "477ad597e6e741cb939c9ade983934814e2a7c6b8e7c59fc659a1dc02eb4b4ab",
    "Sources/Slotstream/SelectedAttention.swift": "70e61a089444f74cc74494d7f05005b0ff4dfe67043782befbbef80d96b911db",
    "Sources/Slotstream/Server.swift": "c20776840aa9551958d8fed92389c8fc32318c97639bd14d93609233dc449334",
    "Sources/Slotstream/SlotWritePlan.swift": "9abde1de815522ff835d3c685a2e342293f3c9c7019cfc742265193ea2e286c1",
    "Sources/Slotstream/SlotpackDownload.swift": "fb6f47ce70f30713cf1679ebda619c980e9d783dd6ae4cd1cc4e0a68b14705b7",
    "Sources/Slotstream/SlotpackManifest.swift": "8664440e22653e64b85c0100345169dd93b3836d1bbd125ac2add4f621b9876d",
    "Sources/Slotstream/StatePrefixFork.swift": "35ed6954bc927e37c117d53eb25e007b83b3385099bc9b18e01607f30abb7df7",
    "Sources/Slotstream/StateRecovery.swift": "078521e0e08233c06706408bb6dbc53f902285fc4c891af2e164386bd41bf98b",
    "Sources/Slotstream/ToolCallSplitter.swift": "2c2e1d722188d633508c871d73f011fa4053b666d10b7585b304c151c53925a8",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
    "Sources/Slotstream/Version.swift": "4a34c363a6357ae06fb07c9d58f959de072ae0d4dad889e8f9c0e88063a5613c",
    "Sources/Slotstream/Vision.swift": "38565f564bf8ba73d2dc87e2f1874fa6fda2652e094a324048bfa8cb1278a79e",
    "Sources/Slotstream/VisionAttention.swift": "83b1012cb0b3a2c22098f71515e3e853cf1ca3affb01cb667a8248e3c34c63a5",
    "Sources/Slotstream/VisionPrompt.swift": "61b90891a5ec9944406287fa73b4c0e5bdd29b4e3903dff345cbeb80638c6435",
    "Sources/Slotstream/WeightDownload.swift": "2758b2eea2631635cd3da5c18a87e724c57aab5c78ad816b7e18d7ff48c8c98d",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "4c6112412f38192de1955bedb6b7f3cddcb2d0b338b570b6b688df4638a55e5f",
    "Sources/Slotstream/WordSlotWrite.swift": "1c19def2346669acc1afa811a7244233c6f593de91c02bfc4ff145465b95187e",
    "Sources/SlotstreamDiagnostics/CheckReport.swift": "9bbe2106b5b55331cc3fbc093edd803eff6f9f00ebd5f30ce587754fe0bc7e47",
    "Sources/SlotstreamDiagnostics/Diagnostics+AdaptiveSpeculation.swift": "e53d32c4f5a3fc7039a258db5c5b3c530416d07828c5d424a8f35e67d80dc256",
    "Sources/SlotstreamDiagnostics/Diagnostics+AllHitReplay.swift": "187a98c70c2e66008622db3727f0bf58126928862bc102782574fa0ba5f57513",
    "Sources/SlotstreamDiagnostics/Diagnostics+BlockSelection.swift": "08d3f1fc29b6353443b795198295bacb85f57d0a2bdbac67450cf66d505f852c",
    "Sources/SlotstreamDiagnostics/Diagnostics+CacheBookkeeping.swift": "6db1e4743b6adce39f32c2c5c0ff9c38bb86d7e9548c41e6c0e7d64299dd9cae",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompactIndexer.swift": "3dd65c8fac32f2804cce942845946debe74ca83b9cf6485a441ed15331711a5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompiledNorm.swift": "9f1beb774172bc33a27020261532e06723f0794adba9ab5dbca7807d01a0748f",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompletePrompt.swift": "75cdd2137b2856407d2fb297504039b174b3ae116b40608d5f42fabf0237a66d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ComputeIslands.swift": "ac7f3b5ed140a566348e9be06274cf757144d2db099fe5af097c4a3807dc6801",
    "Sources/SlotstreamDiagnostics/Diagnostics+Context.swift": "76ea9c95cd2d20614533458ffe32c8e8fd6d29dee3b1bece7476e27d3f589ce0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift": "51e505bd3279983263ad731133b2f1e20606387cf03ba360ffcb2fba34dd33a3",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift": "90b83306d1966da794daf28cc84f426a42cd853075f5e236cf1bacae10787d8f",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeLookahead.swift": "a27f1040ec4bea2a5e02f25f2a4d51a6a15ff78bd0609b1c23bd97e1adc3822c",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRows.swift": "a0f0532a43c1329b3a69f8a3bd8607df9f27793c0994ad23203936896b44e81f",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRuntime.swift": "c5c37fafb45b2ac2434a36cd7c8b8804fac0e271e9e3f0fb10ef97481db77e24",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExactRead.swift": "77a357f55c3f5aced5ba0d74012e35f73e678e0840024f24a5ab86909d335c59",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift": "6a88a4b8bb8b35d6ca80d63cc1264f4da44218ca0229320960a8328ad2e95935",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProfile.swift": "6d982a575d6c6282941a9f9f3ac063b75d31996fcde387a63ca3ce44fea93242",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProjection.swift": "983a071e562451dbc22cfe09b005d9c68af687c10e7d94802d7d3cb28af1c7cd",
    "Sources/SlotstreamDiagnostics/Diagnostics+Governor.swift": "8ec85ff3609cd5657eae1a8434189e9474460aad0c850f6b88240457c8f0f1fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+HTTP.swift": "9526e51122c9e463ea9a3201da6e4628f3794f329bd4ca05f1496daf3c66c1e5",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageFailure.swift": "766742295107f924177f7f724a7be61f8ccb29b3e044a7de345523598c31cead",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageReuse.swift": "5d0e619769c0f7d4ea8c73439ac44bc499db6184c4954b417f4cb7804aec20e8",
    "Sources/SlotstreamDiagnostics/Diagnostics+Integrated.swift": "5eb2132959b1db779caa520a3eefe5d6c5ffdd9ed317750c8cee48f02bd05941",
    "Sources/SlotstreamDiagnostics/Diagnostics+LayerLocalVictim.swift": "d512d93741a6675412cc9e6c739b940132ca3f20ebecd709884b00b1ebbc49b7",
    "Sources/SlotstreamDiagnostics/Diagnostics+MTPIndexer.swift": "7784a18a1eddafa25ecaee9eeacfbcddf8bcabac8d53919f80367a4f4e5be476",
    "Sources/SlotstreamDiagnostics/Diagnostics+Machine.swift": "20f6edb816fc3a794143042e59847adbfc1fe06514fc990e8a3d81eb87abe50c",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramCache.swift": "9bee4eb6c6cf09df5673e177d4b7f006681794bf680366b4549e4fa3d38b7368",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramLookahead.swift": "3b0bc7ea21a57d2ce65e58773879f5f86ba7f0f37c47d8f1d08d51e61c486370",
    "Sources/SlotstreamDiagnostics/Diagnostics+Optimization.swift": "35d99deb614da4ffdfef075eabdc5a1c8b3518bf9accf265796e09f2c7c281ee",
    "Sources/SlotstreamDiagnostics/Diagnostics+Output.swift": "e39951dc83e8410abdc840d0a739e1e1b2fbbdf1e2d06b3cb2d28c39ee9329cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+OutputServing.swift": "50bb807143f1e5134f52a6f3d48b8da297f4186dd91895e016d191ca13ccf66a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PackedLayout.swift": "14c31f94ebdd8bbbbb1479c77d0649b4c0632d978e4d8a60a8048214a1e08e65",
    "Sources/SlotstreamDiagnostics/Diagnostics+PartialRotation.swift": "de75d07feedc163834fe8e716683af8b2d373c51b0588ccc2cac922f775367ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefix.swift": "46a5bc33ee3fd389694f22c9e7ff5cdd995539663b3141688414351f50ac3189",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixModel.swift": "3e06c67777ce3572d9bd7cce5d220be5f41af90e31b6f5da349ba6f3ec667798",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixPolicy.swift": "82dcadab2ac079d3662da6dd012d8a031c4bdea9ee8c022ac34d5faf66277f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+PoolRequests.swift": "e383c494263afa029a9ef107c90d6ba59f44cda5da7ca1035eae68cbda3562d2",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillQualification.swift": "f40d8e711121f12cbcd95f8880d483ac36995faeab06af714d201fa1671348f1",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixCapacity.swift": "b76e9185930a90d2509f9d7dfc247afee3ff2a083a1bc6bb3da6d090653d290f",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixFork.swift": "e7a7094b3930cef8e380d711f20e8f82e2821c070579549692a6120e9ba3afc4",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixRetention.swift": "5de9452266e8e59da03b078990689554fc7a419a5cd8e5879cc68e2e277ea8cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixVision.swift": "5e4737dbe5344492fc2f9c6881f8d56e997668f674c91b28b9349c9420465f72",
    "Sources/SlotstreamDiagnostics/Diagnostics+PressureBoundary.swift": "f84979a3da94bc5ac0cfeb5cc84b61af43716c5664cc71853085ffa1b116d325",
    "Sources/SlotstreamDiagnostics/Diagnostics+Pull.swift": "224e4bf5210afbddd992894860343add73d1f52b12b2d9a00abf78fdc492ada0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift": "1532f45714ceb98a5adcfa31abd31f065493164f49d2ee3aac868d5d4080b04c",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift": "9e98b6e0fd6c30f36d1d3ec8d556216f351a2f09ee5d15dbb4f5580858fad4b4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadRecovery.swift": "5d51636a62b376e74dfefab207fdd42da61436210973f714819c7cc11488a04d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ResidentOverlap.swift": "c1e7b847cffa51939b0ae20027b289efcae5585a94ae5c1c751a66f110a25522",
    "Sources/SlotstreamDiagnostics/Diagnostics+RopePerformance.swift": "19d040f21391a1ea87831b73a8adf055a78aeafe9d902bd11ce22fd6a492d892",
    "Sources/SlotstreamDiagnostics/Diagnostics+RouterProjection.swift": "3981e415003e6258d41690216a7ab668652a0ce436bf644d99d88dbc2799db9e",
    "Sources/SlotstreamDiagnostics/Diagnostics+RoutingReadback.swift": "f29aad2cde3bbb526f83dcec4565f3c382d071734acc47a0e31d7223312713cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+Runtime.swift": "b6debc0a68e2df94574964c13afa41a76a5aab783e75d1428da25110d241cffc",
    "Sources/SlotstreamDiagnostics/Diagnostics+RuntimeBudget.swift": "b5ce492456b9e27b19765a0bd4f23cbd81ccff034be5af3142737cdae7944d6e",
    "Sources/SlotstreamDiagnostics/Diagnostics+SamplerPerformance.swift": "4e6dd7e85d7ac0f2b2af291343ab4cdc52fa94fe6edb588c1d517008a0c35cb3",
    "Sources/SlotstreamDiagnostics/Diagnostics+SelectedAttention.swift": "8dd385da9b79c3625d1cc9ccc6c8821978f88437fcded918f049328b7a969e7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Selection.swift": "b737794c5a57cd224f36a93b960fa9834cabb51ef810945bab64fd71e59c91d0",
    "Sources/SlotstreamDiagnostics/Diagnostics+SlotSlices.swift": "32c10a839423b13a4dceff67a5b2a617f90d145376a70b19bd27f2e62452e288",
    "Sources/SlotstreamDiagnostics/Diagnostics+StateRecovery.swift": "a53db99ff0f97a26e87586e35bf05daa26b9281fe7d686a1670c14984da2dd77",
    "Sources/SlotstreamDiagnostics/Diagnostics+TerminalPrefill.swift": "7ef27bec8489f52ccdd3ea51c125d21eb94512924b163e854b7aaf25ef39f57a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "be63108d11318a9469d26587ade08c79bf34274c61b847d752663d8ce007f9af",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "da4b4a89d9b11d26a64cd244aae2887acfbca16a6d3aceefa8f40f90c8e39634",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "fe3aaf4ad816c02fc0b28771d6c3c7f9cf7b2a9f102ea4fce660c1dd8541a650",
    "Sources/SlotstreamTestKit/T0Checks.swift": "c3078392faebeddc26b250361a400ac66a756def9ee38edb972c21f3a80266e0",
    "Sources/SlotstreamTestKit/ToolCallChecks.swift": "f1b263239f4e82707c77a5887367fb5302e96d369f2f278e0e45a87d3006dad8",
    "Sources/slotstream-checks/main.swift": "02ebabaf058afa95622ccd29fb65d80b7eac41c9e6232f0167ef288c2126e0d9",
    "Sources/slotstream-cli/CheckRendering.swift": "0905dcbae17a5b3d66e13a760c4054fb29d930331d32942a528510ecfe9769a1",
    "Sources/slotstream-cli/ContextCommands.swift": "3ba24ae3e24dd10214e3288f007952d9e2b06241c081e29313b42ac7aa7a31bb",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift": "b921d4791feb0caab0ef50f74e92e0bba202e9ccf84ed1b9f4571e3a184ab696",
    "Sources/slotstream-cli/MTPCommands.swift": "190b88f5e069d11361597b0fa869ffbe21b003fecc635cc8907a9a55d3239576",
    "Sources/slotstream-cli/OptimizationCommands.swift": "9a0013222a0accfb268bb860f94e8939b2b99f8fb31bd949be9d5e9ace83e8d5",
    "Sources/slotstream-cli/PackedExpertCommands.swift": "ea7f4485d60a985a0a1f759f077d28dc42f36512dc1dd07a7644a22e31346b12",
    "Sources/slotstream-cli/PrefixCacheCommand.swift": "266b9571726fe280c11d5dededa565375af1749b76c7e70def4fe9530729914f",
    "Sources/slotstream-cli/Pull.swift": "4fa56def1edb0ae575bd898e3b53b669f0a16b04d734ef86e0f6c4a6ad185d14",
    "Sources/slotstream-cli/SweepCommands.swift": "37455d724a63b1689208dce9d55cd3d249bcab6d45bdf40d5c5e4f6992aa0d20",
    "Sources/slotstream-cli/VisionCommands.swift": "df80e089ea9cdbc6fc51ec7dc895b0dbf0eec5d4db80eb73b0ca9720a3ce8cc0",
    "Sources/slotstream-cli/main.swift": "9eff0455736b4d5ecf6825463d1a3fac5863ce549540f82c7b11734366a5f919",
    "Tools/build_sevra_mac.sh": "c54606315dafd8755b12b48aed50a95b90a527d9c7fc34ee8daf20c961b815d7",
    "Tools/generate_sevra_icon.sh": "8228ccb8e4d707c2a73336f283ed599f72cbc2213589ca36191d675e737141b6",
    "Tools/lib/mlx-0.31.1.metallib": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597",
    "Tools/mac_build_inputs.py": "8ea8316c74a1056182128c4f81a9651bb3ff9dd328569811d795301c4cb7b335",
    "Tools/render_sevra_icon.swift": "cbcf593dec275773cc86118bc4d6aff423534d9df7e62ef0fb014733c9aa3095",
    "apps/macos/App/AppModel.swift": "59ec35ae4b9c3b0b37f94fef523f1e074206784569c9aee772af908a55b5a409",
    "apps/macos/App/ContentView.swift": "26244881858eaafc6fe95fc9b6a979f541a8d53f259e5c2371a7df6803132c1d",
    "apps/macos/App/MacCommands.swift": "059ebbbaf81cb83f3c57bdc1f635b1d30e0f8913fe776ce4c9c2615c979fa481",
    "apps/macos/App/NativeText.swift": "ffda81e14f2d8a59b54923e0a66a726b7ffd618a0e77d41dfd8e76c9d4f20dab",
    "apps/macos/App/ObserverMark.swift": "93f172ecc0b360338bb09913071a6ba6644077576abf9b323bfa95ebd4c5b764",
    "apps/macos/App/SevraMain.swift": "a001519c25160a01a38596c6bcb214d117ce3074ea22340fff2d005168b4b21b",
    "apps/macos/Info.plist": "73cc83e91b2729b1ef576226fd95104e0bb763f874fe937d81d92d9785e8bdb6",
    "apps/macos/Package.resolved": "766f45a6da66031f58629e0446f18060a3c92699b1346c8e028181bc9aaeffd5",
    "apps/macos/Package.swift": "20288a7efe64b916a71e1dadd9a9e249fb1f5b6d10048b22e69c62e37a9f91a5",
    "apps/macos/Presentation/ComposerSession.swift": "ea87ddd71658f9876dec8565c0210ef839085f7eeb74c6b95294f348fad51d46",
    "apps/macos/Presentation/HistoryPage.swift": "a97110301fe774fa0236f1b5dfced7a437620953f30e23656affb716b35f2032",
    "apps/macos/Presentation/MarkdownDocument.swift": "26a2501a3e1b10a60ef72e2d98748f0d6778cef7c5df28c648f7db99fcb58f9d",
    "apps/macos/Presentation/Module.swift": "dda9b75f64b106eb544de201f599122d75abc483c5b156bba6c05c0f956dbc3c",
    "apps/macos/Resources/Fonts/Inter-OFL.txt": "5b9321a4298cfeb6b34354164a1c3afc3db114569984c502b9b35d988fd58c57",
    "apps/macos/Resources/Fonts/Inter.ttf": "29160a80ff49ddcab2c97711247e08b1fab27a484a329ce8b813d820dc559031",
    "apps/macos/Resources/Fonts/Poppins-Medium.ttf": "90373e7d838d32468438fc3e152dca0bdb12edcab99ea639f158790b1ba1fd05",
    "apps/macos/Resources/Fonts/Poppins-OFL.txt": "6be04893d770899a015649c7aa3b582f871b272f8747a92b78b17c3e5c8b2573",
    "apps/macos/Resources/Fonts/manifest.json": "1e79dfd278dbe9bfd8afbf7e5cbaee64dff1574fc1cc3aca8fdd903f4056677e",
    "apps/macos/Resources/Licenses/swift-cmark-COPYING": "c22e885f33b821bddb24cf007145e5540655b6c0f403e49e6c76a93c28e6d9a9",
    "apps/macos/Resources/Licenses/swift-markdown-LICENSE.txt": "167beb36f181bd163c93c6feb45c68e5f9462fe1af55b278f7bfd1df20e673a3",
    "apps/macos/Resources/Licenses/swift-markdown-NOTICE.txt": "ee7da43afcac4a52196a2141024573ec2ceb84b14e74dfed38522d94586fbc52",
    "apps/macos/Resources/Sevra.icns": "b28f2df8e40cafc2e89fb3ae5a0e361b5470851d833495df9b3dd4ca0395471d",
    "apps/macos/Runtime/HomeStore.swift": "81b17acacdc2557bd04dc86f033553bd7c6ca00b38dd7be184ae53a6abf5789e",
    "apps/macos/Runtime/HomeTemplate.swift": "61cbd2fafefcbcfb21c90d043be66234e4da37b1220c0355d973ffa42ed1cf07",
    "apps/macos/Runtime/Inference.swift": "e1a8dbf38a10b4b36e8be5aaf3cbdb8448dfd13f30985c326c07fcbc263e9268",
    "apps/macos/Runtime/LocalIPC.swift": "896fdb1e597888c54c7d0ee79ba61e186b4bfd8c1d745d67196ce7b611242984",
    "apps/macos/Runtime/ModelSetup.swift": "0710c291b65007ed39cde6b77b10bc4c2636cdfc44bbb7975f9aec1b30d3c501",
    "apps/macos/Runtime/Models.swift": "aa1fe954f65ae8f5d73bc04e5cbbb6ab9c57f424f4941d6e1fc13bdf1ba6b8bd",
    "apps/macos/Runtime/Performance.swift": "b771d35aa8af3dcb6de0d88fe4585ac9b405b01e15d7a0fd1695f7ccad94dc00",
    "apps/macos/Runtime/Runtime.swift": "4ac300966808e63b8a4fedf031f5bd410a97b6536b67061a7f5956d3af147b42",
    "apps/macos/Runtime/SourceTools.swift": "2aaedf54990a266980c608d29ff2316dfba6c9d696cf20d8e273d8b9481c4c15",
    "apps/macos/Sevra.xcodeproj/project.pbxproj": "9cc99dbdd7fb8e54224e2f48993e99bdc8084a5432fbcb7f2483c1d812cf7a5a"
  },
  "scope": "Local development build inputs. Ad-hoc signing is not release qualification.",
  "sdk": "26.5",
  "swift": "Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101)\nTarget: arm64-apple-macosx26.0"
}

````
