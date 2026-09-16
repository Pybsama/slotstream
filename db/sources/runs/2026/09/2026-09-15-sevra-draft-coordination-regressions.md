---
type: run
id: 01m2h82zzqnkwa2zfxzmzm4k83
created: 2026-09-15T00:39:51.031291+00:00
updated: 2026-09-15T00:40:08.754614+00:00
summary: Native draft race correction, adversarial composer scenarios, real persistence and scoped UI checks; broader release gates remain open
binary: 5700f9f180a2ff4b6f987c451951c8b053556e9cf769d5345c204131a131a399
captured_at: 2026-09-15
command: bash Tools/check_sevra_mac.sh; bash Tools/build_sevra_mac.sh; native UI walkthrough
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra draft coordination regression checks
tool: Native UI and Mac regression executables
---
# Draft coordination regression evidence

Scoped correction of the native Mac draft autosave race reported by the user. This does not complete the broader Mac release plan.

## Changes

The production ComposerSession owns its acknowledged revision, debounces edits through one writer, coalesces overlapping callers, drains edits during writes, and coordinates navigation, Send and close. Display snapshots no longer choose the revision used to save. Send accepts the prompt and replaces the draft in one durable runtime transaction. Exact revisions still prevent stale writes from restoring an accepted prompt. Duplicate acceptance uses a durable nonce. Incognito removal waits for pending writes before removing the owner. Shutdown disables editing until quiescence or restores editing if it fails; startup errors do not trap the user in an unquittable app.

Benign revision-only changes reconcile with bounded retries. A genuinely different persisted draft requires an explicit choice and can be inspected. Save and Send failures retain text, explain that persistence or acceptance could not be confirmed, and offer relevant recovery/copy controls. Successful recovery clears its own warning. Send is disabled when the draft needs save/conflict resolution. Generic errors no longer offer an irrelevant Settings button. Native programmatic draft replacements clear stale Undo ranges; normal editing and unchanged draft restoration retain Undo. Focus requests remain pending until the new NSTextView is attached to a window.

## Automated coverage

The raw output below records 22 named composer scenarios, including a 200-operation deterministic mixed edit/send/navigation sequence. The checks use the actual production ComposerSession with delayed/failing storage, not a reimplementation of its scheduling. They cover stale-snapshot reproduction, acknowledgement revisions, overlapping saves, coalescing, Undo while saving, debounce cancellation, Send before/during autosave, newer and identical retyped drafts, double Send, lost acknowledgements, nonce reuse, post-acceptance competing edits, bounded retries, both explicit conflict choices and a further competing edit, navigation and failed reads, close refusal/draining, shutdown failure, and Incognito removal.

A separate real-runtime check uses scripted inference with the real dbmd store, including draft/message size limits, atomic acceptance/clear, stale-write rejection, no-op refusal after an external edit, exact disk reopen and Incognito exclusion. Existing Markdown and runtime suites also passed, including process-crash recovery, tools, IPC, memory scopes, duplicate submission, symlink boundaries and external-edit protection. Renderer times are developer diagnostics only, not sustained native-frame or release-performance qualification.

## Native observations

The native walkthrough used the pre-final bundle identified below. A separate QA thread preserved exact multiline Unicode through typing, Undo/Redo, switching Home and back, and quit/relaunch with a fresh draft. An oversized draft produced a contextual save failure, retained text, disabled Send, and refused Quit; replacing the text recovered without a stale warning. Under the bounded in-process local inference configuration, the synthetic prompt `Autosave regression QA: respond with only OK.` received `OK`. Text entered immediately during acceptance remained in the edited composer buffer, including the original prompt to which it had been appended before clearing, and survived navigation. No spontaneous restore or conflict banner appeared. The unsent QA draft was cleared after verification and its completed test thread archived.

An Incognito test draft was closed through the native thread menu and did not appear in the persisted Home (a unique canary was checked). The model process was quit after this real inference check. User conversations were preserved.

The final native pass exposed an early focus request made before a new composer had a window. After the attachment-aware correction, three successive new Incognito composers focused their Message fields and accepted paste. The final bundle displayed the final error wording and disabled Send for the oversized draft, retained the draft through Settings, and showed readable recovery controls in Dark mode. Correcting the draft removed the warning. System appearance and default size were preserved/restored; quitting discarded the temporary Incognito threads. Only focus/error-copy changes followed the real-model walkthrough; no later inference qualification is claimed.

## Binary identities

Final bundle and checks (SHA-256):

```json
{
  ".build/Sevra.app/Contents/MacOS/Sevra": "5700f9f180a2ff4b6f987c451951c8b053556e9cf769d5345c204131a131a399",
  ".build/Sevra.app/Contents/Resources/build-inputs.json": "f9c9b24215ba3ea92871ab63262baad41d6e6a0c333223958b64f7adb225e6a2",
  "apps/macos/.build/release/sevra-composer-checks": "1cb9980f6ca0be54e1026c213f01f71e7d7d6737927e8fc8c5d3765eff8c1278",
  "apps/macos/.build/release/sevra-presentation-checks": "4709656bcc9e74926092b63495617c1210573d0401c04b9f94c8a4ae869b3a93",
  "apps/macos/.build/release/sevra-mac-checks": "6649c779a54ef0974c652f126cf97a5c92d4956a0e1c28176c0d182b84ecf2ed"
}
```

Pre-final native walkthrough (SHA-256):

```json
{
  "MacOS/Sevra": "d0704c8b6ce23365bec0b8263c225c19d924c47e4a18e0ddb873a4f4db7cd914",
  "Resources/build-inputs.json": "7001496b78c28c77fa9d2dd59011c6acb65f44ea20de2f24d368b53b80498788"
}
```

## Final automated output

Command: `bash Tools/check_sevra_mac.sh`

```text
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraPresentation ComposerSession.swift
[4/6] Compiling SevraMac AppModel.swift
[4/6] Write Objects.LinkFileList
[5/6] Linking Sevra
Build of product 'Sevra' complete! (14.28s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-local' complete! (0.25s)
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraComposerChecks ComposerChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (5.73s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraPresentationChecks MarkdownDocumentTests.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-presentation-checks
Build of product 'sevra-presentation-checks' complete! (1.21s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-mac-checks' complete! (0.25s)
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
PASS: 22 composer scenarios plus real-runtime persistence checks
PRESENTATION_RENDER_MS 14.769,0.405,0.274,0.350,0.300,0.360,0.306,0.273,0.256,0.252,0.250,0.253,0.252,0.254,0.253,0.253,0.252,0.247,0.250,0.249
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget

```

## Final bundle output

Command: `bash Tools/build_sevra_mac.sh`

```text
swift-driver version: 1.148.6 Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (12.02s)
swift-driver version: 1.148.6 /Users/carlos/Projects/slotstream/.build/sevra-bundle-dxlZWR/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
/Users/carlos/Projects/slotstream/.build/sevra-bundle-dxlZWR/Sevra.app: replacing existing signature
/Users/carlos/Projects/slotstream/.build/Sevra.app

```

The bundle script verified stable build inputs and its ad-hoc signature. Info.plist and the Xcode project parse. Full Xcode builds, signing/notarization, clean-machine installation, full VoiceOver/IME matrices, sustained-load budgets and the wider release gates remain open. No commit, publication, deployment, remote inference or paid call was performed for this correction.
