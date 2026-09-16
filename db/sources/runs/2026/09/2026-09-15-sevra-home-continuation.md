---
type: run
id: 01m2hctjapq9rcrdmwkyr8163e
created: 2026-09-15T02:02:37.782523+00:00
updated: 2026-09-15T02:02:59.843811+00:00
summary: Home continuation correction, exact context, repeat-click and draft safety, persistence and native real-model verification
binary: dfb63b492161a454c39456d599d083803dac28ead7cb5c81e516b8a0457b8b7e
captured_at: 2026-09-15
command: bash Tools/check_sevra_mac.sh; bash Tools/build_sevra_mac.sh; native disposable-Home walkthrough
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra Home continuation verification
tool: Mac native UI and regression executables
---
# Continue in thread: correction and verification

Scoped Mac development verification on the registered Mac. The earlier button created an event-linked thread but the native conversation only rendered that thread's own messages. A real click reproduced the apparently empty destination. The earlier model-context path did include the referenced exchange, so creation and inference context were partially implemented while the visible continuation was incomplete.

## Correction

The same reference resolver now supplies visible conversation history and inference input. Quoted turns retain exact event identity, text, roles and Home chronology. The view labels them From Home; original Home events stay put. Search, Markdown copy/export and paging use the resolved visible conversation. A deterministic title comes from the selected user message. Repeated promotion reopens the existing continuation, including after restart. Home offers Open thread and the continuation offers View in Home. Composer transition saves Home before creation, protects typing during asynchronous preparation, restores any destination draft, and publishes the destination snapshot before activation. No attachments, pending approvals or memory admission are transferred.

## Automated evidence

The new promotion checks use real disposable HomeStore/dbmd persistence and an explicit inference probe. They cover empty/missing selections, canonical order and duplicate IDs, repeated actions, preserved Home records and drafts, exact model input roles/text/order, no unrelated earlier/later Home context, inherited memory mode, no inherited source capability or run authority, no implicit memory/journal changes, restart, archived continuations, Forget suppression with inspectable history, active-response refusal and external-edit refusal without overwriting user bytes. Production composer tests cover repeated clicks during suspended preparation, edits during preparation, retained destination drafts and save failure before any destination creation.

The initial test run encountered a source symlink left deliberately by an earlier safety test. The promotion fixture was corrected to use its own source. A second test compared subsecond in-memory dates with whole-second persisted ISO-8601 dates; comparison now checks exact identity/text/roles/run links with only that documented timestamp precision tolerance. Neither failure was treated as a product regression. Original run logs are preserved below.

### Complete passing regression output

```text
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'Sevra' complete! (2.06s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-local' complete! (0.24s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-composer-checks' complete! (0.24s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.22s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (6.13s)
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
PASS: 24 composer scenarios plus real-runtime persistence checks
PRESENTATION_RENDER_MS 14.098,0.273,0.250,0.250,0.374,0.288,0.267,0.252,0.248,0.252,0.246,0.242,0.247,0.243,0.248,0.245,0.248,0.247,0.250,0.242
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
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
```

## Native and real-model check

A separate disposable Home was seeded through HomeStore/dbmd with an explicitly labeled synthetic exchange: user text "Promotion test: the codename is Juniper." and assistant text "The test codename is Juniper. This is a seeded UI fixture, not a model response." Its Home composer contained "This unsent Home draft must stay in Home."

The actual native Continue in thread button created a titled work thread with both quoted messages visible. Settings temporarily selected the existing 9 GB custom limit. One real in-process local-model follow-up asked "What is the test codename from the Home exchange? Reply with only the codename." The completed response was "Juniper". While work ran, a separate continuation draft was entered. View in Home restored the original Home draft; Open thread returned to the same continuation and its distinct draft. Only one work thread existed in the disposable Home.

After restoring the original Automatic memory and readiness preferences, the model was unloaded and the test app quit. The final UI-only refinement publishes the destination snapshot before switching composers, avoiding a transient empty-state frame. After rebuilding and relaunching the same disposable Home, quoted history, the real reply, the continuation draft, the Home draft and Open thread all remained correct. Searching for "seeded UI fixture", present only in the linked Home history, returned both Home and its continuation. No additional inference was needed for the final snapshot-publication refinement.

The first disposable launch under /private/tmp was refused by the existing no-symlink Home check after folder creation; no model ran there. The successful native fixture used a direct directory under the user's Sevra folder. Private user Home text and screenshots are not included in this public record.

### Model/build identities

Real-model app executable SHA-256: `3d631b5a1a2e311d8b9cc0b92c359d0ae5af3334e96899930bdb665c79da8c46`.
Real-model input manifest SHA-256: `c80e95eb25b975129aa7b1ef59a8422571c38cecb06511e3fa82d3850efd2b92`.
Regression runner SHA-256: `6397f6aee732a562bcce16519e9e824540e63eefd69c98e47e02eec26b134f76`.
Final UI-refinement executable SHA-256: `dfb63b492161a454c39456d599d083803dac28ead7cb5c81e516b8a0457b8b7e`.
Final input manifest SHA-256: `e7715441d5062d399f7115a2961ccb3d0e61553510e3679061057afe700962a3`.
Final manifest matched checkout build inputs. Build script signature verification passed. Global swap-in/out counters were 48/64 before and after the bounded real-model check; these are diagnostics, not a timing claim. No concurrent model process was launched. This is functional evidence for this button and context path, not full app-plan completion, general model quality, benchmark evidence or public-release qualification. Earlier arbitrary turn selection and complete inline historical link-card coverage remain broader plan work; this button operates on the latest completed Home exchange.

### Native process output

```text
2026-09-14 20:58:19.085 Sevra[53274:1662194] WARNING <NSToolbarItem: 0x99f14b8e0> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize
2026-09-14 20:58:19.085 Sevra[53274:1662194] WARNING <NSToolbarItem: 0x99f14b8e0> -> view was automatically measured but had an ambiguous height or width and the view's frame size had a zero height or width. Did you forget to add constraints on your view or its subview(s)? Try adding constraints or give the view an intrinsicContentSize
engine ready in 1.3s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
```

### Final bundle build

```text
swift-driver version: 1.148.6 Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (13.15s)
swift-driver version: 1.148.6 /Users/carlos/Projects/slotstream/.build/sevra-bundle-IGiw1U/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
/Users/carlos/Projects/slotstream/.build/sevra-bundle-IGiw1U/Sevra.app: replacing existing signature
/Users/carlos/Projects/slotstream/.build/Sevra.app
```

### Preserved first test attempt

```text
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/4] Write sources
[4/5] Compiling SevraRuntime HomeStore.swift
[5/6] Compiling SevraMac AppModel.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking Sevra
Build of product 'Sevra' complete! (19.35s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraLocal main.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-local
Build of product 'sevra-local' complete! (3.87s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/4] Write sources
[3/5] Compiling SevraComposerChecks ComposerChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (5.72s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.23s)
Building for production...
[0/4] Write sources
[1/4] Write swift-version--1AB21518FC5DEDBE.txt
[3/5] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (6.04s)
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
PASS: 24 composer scenarios plus real-runtime persistence checks
PRESENTATION_RENDER_MS 14.431,0.283,0.263,0.253,0.245,0.249,0.249,0.243,0.326,0.333,0.271,0.258,0.262,0.251,0.249,0.262,0.262,0.264,0.382,0.246
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
Cannot safely read notes.md. Symbolic links are not supported.
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
```

### Preserved timestamp-comparison attempt

```text
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (12.54s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-local' complete! (0.24s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-composer-checks' complete! (0.24s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.22s)
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (5.95s)
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
PASS: 24 composer scenarios plus real-runtime persistence checks
PRESENTATION_RENDER_MS 14.421,0.277,0.250,0.256,0.248,0.248,0.251,0.240,0.241,0.243,0.238,0.234,0.241,0.236,0.251,0.238,0.243,0.243,0.242,0.236
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
CHECK FAILED: restart resolves origin and continuation messages
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
```
