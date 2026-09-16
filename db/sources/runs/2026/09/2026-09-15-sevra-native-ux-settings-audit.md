---
type: run
id: 01m2hm783c3qy1yrfx5bqg3z3p
created: 2026-09-15T04:11:53.324125+00:00
updated: 2026-09-15T04:12:06.943189+00:00
summary: Native Settings and UX audit with keyboard, accessibility, privacy wording, scoped visual checks and exact delivered bundle
binary: ca443f33157ca98eca65f7c820311115c0f0b9c2dc29136cdf84217265c35876
captured_at: 2026-09-15
command: bash Tools/check_sevra_mac.sh; bash Tools/build_sevra_mac.sh; native Settings, Search, Find and memory-menu review
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra native UX and Settings audit
tool: Native AppKit UI, SwiftPM build and scripted runtime checks
---
# Native UX and Settings audit

This pass follows [[sources/runs/2026/09/2026-09-15-sevra-native-layout-refinement]] and [[sources/runs/2026/09/2026-09-15-sevra-layout-final-bundle]]. Its design principles are clear hierarchy, predictable native input, visible consequences for privacy choices, preserved drafts, and ordinary settings that stay readable without exposing every diagnostic at once. The existing warm palettes, Observer identity, system control typography and shared reading grid remain the foundation.

## Implemented behavior

- Settings has native General, Model and Keyboard categories. General groups appearance, reading size, sidebar width and Home location. Model groups automatic/custom memory budget, readiness and file setup. Optional usage diagnostics open under Memory details. Keyboard derives its rows from the same command map as the app menus, with separate accessible labels and values.
- Model-file setup distinguishes an unchecked installation from missing files. It no longer duplicates loaded-model status or presents a misleading remaining-file count before checking. A read-only native check reached Local model ready; no download or inference was started by this audit.
- Search selects a visible result with Up/Down and opens it with Return. Query changes select the first matching result; selection remains visible. Marked-text input keeps ownership of arrows. Search privacy exclusions are unchanged.
- Escape follows the native responder chain. Native Find closes first; another Escape can leave a document or panel and restore the conversation. No global event monitor or key interception was added.
- Saved conversations show a checked memory scope with plain explanations. Incognito states its actual restriction and omits unavailable saved-scope changes. Knowledge uses save/forget language, excludes already active saved candidates, and explains oversized items/corrections that cannot be saved.

## Native observations

The walkthrough reproduced Search Return doing nothing and Escape failing from a freshly opened document before the fixes. Afterward, selecting/filtering/opening a saved fixture through Search worked; the document returned to its intact draft with focus. An empty Incognito thread exposed only applicable actions and was closed without sending a message. Existing conversation contents and drafts were preserved.

Settings was reviewed in warm Light and Dark, at 1120 by 760 and a compact 620-point width, including 24-point reading text. Category selection uses native focus and Space activation. The custom-memory field rejected nonnumeric input with a visible valid-range explanation. The original custom value was restored, then Automatic budget and Automatic readiness. Native document Find matched and scrolled through the large-text table fixture; Escape closed Find before leaving the document. The prior Find query was restored.

The native walkthrough spans the development builds in this pass. The observed-bundle identity below was captured after the main layout, Search, Escape, Incognito and compact/large-text checks. The model-file readiness check occurred on an earlier development build and is not claimed as a final-bundle check. Later delivery builds add separately labelled Keyboard, recommended-budget and model-status rows; final-bundle checks are recorded below. System appearance, 16-point reading text, 232-point sidebar and the Home screen are the delivery defaults restored after QA.

## Regression scope and limits

`bash Tools/check_sevra_mac.sh` passed the complete scripted composer, native Markdown presentation and runtime suites using disposable Homes. Coverage includes the 24 composer cases and real dbmd persistence, source fidelity and inert HTML/images, document reopening, Home continuation, memory policies, deferred handoff, cancellation/queue/restart, external-edit refusal and memory/Incognito boundaries. It performs no model inference. Its raw output is preserved below. Timing lines are diagnostic output, not a clean performance benchmark.

Independent engine/runtime edits continued in the shared checkout after that suite. The suite establishes its tested snapshot, not blanket qualification of later unrelated engine experiments. Several delivery attempts encountered those in-progress edits or the stable-input guard; no unrelated changes were reverted. The final bundle manifest owns its exact source mapping. Final native UI checks and signature/build verification are separate from the earlier scripted regression scope.

This is a scoped development UX improvement, not acceptance of UI-D, alpha, stable or an installed public release. Full VoiceOver and native table-cell behavior, live IME composition across supported input methods, OS accessibility/appearance transitions, sustained load and measured UI budgets remain open. The search marked-text guard is code-level protection, not a substitute for that live IME matrix. Prior platform and release gates remain in force.

Apple references used as design guidance: [Settings](https://developer.apple.com/design/human-interface-guidelines/settings), [Designing for macOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-macos/), and [Toolbars](https://developer.apple.com/design/human-interface-guidelines/toolbars). This is not Apple certification.

## Final-bundle verification

The delivered bundle reopened on Home. Native General settings confirmed System appearance, 16-point text and a 232-point sidebar. Model settings confirmed Automatic budget/readiness and independently labelled Recommended now, Model and expanded App memory values. Current budget is absent when no model is loaded, so its new label was not exercised in this final native check. Keyboard exposed all 14 command/shortcut rows separately. Escape returned from Settings to Home and focused the composer. Optional memory details were collapsed before leaving. The wide final Home and General/Model/Keyboard layouts remained aligned.

The final build completed with matching before/after input manifests and passed deep strict ad-hoc signature verification. Existing unrelated engine compiler warnings remain visible in the raw output. Identities are read from each bundle and its own manifest, never inferred from later checkout hashes.

### Main walkthrough bundle

```json
{
  "binary": "59ca50d5f55f39d156062197dbc7b59511ac7d79956494dbcd492de576f1dd8d",
  "manifest": "c95d9bd4ffeffba13734bd10572b09dae8ac321e9fd93e8f74855897f5f8ef99",
  "ui_sources": {
    "apps/macos/App/AppModel.swift": "7f1f6d0c81bd7f10e8dd2954c4c2f4004c240871d14f1c1a5bb015ba758c622b",
    "apps/macos/App/ContentView.swift": "2ff90cfe2f18de192e6240b79ad971a0eeb636e8b16f2bc31281a2681ddef16d",
    "apps/macos/App/MacCommands.swift": "059ebbbaf81cb83f3c57bdc1f635b1d30e0f8913fe776ce4c9c2615c979fa481",
    "apps/macos/App/NativeText.swift": "626011238af01cb0b4179e582f00ca40c83afa5591492bc9797a4b57e191635b",
    "apps/macos/App/ObserverMark.swift": "93f172ecc0b360338bb09913071a6ba6644077576abf9b323bfa95ebd4c5b764",
    "apps/macos/App/SevraMain.swift": "a001519c25160a01a38596c6bcb214d117ce3074ea22340fff2d005168b4b21b"
  }
}
```

### Intermediate Keyboard verification bundle

```json
{
  "binary": "a7af78669ec90944009b6ecaf64f4db9eb5bf28ed1d6c115cba6748bda081576",
  "manifest": "6e6e5ef349f283b532c7857dc604d42c39fd024f9db195e9de7af634e3d0b31c",
  "ui_sources": {
    "apps/macos/App/AppModel.swift": "7f1f6d0c81bd7f10e8dd2954c4c2f4004c240871d14f1c1a5bb015ba758c622b",
    "apps/macos/App/ContentView.swift": "15ad8f816be8d244fb035abde753ebe1f6f7af1cf4767a42e60b4ccdf6186e3c",
    "apps/macos/App/MacCommands.swift": "059ebbbaf81cb83f3c57bdc1f635b1d30e0f8913fe776ce4c9c2615c979fa481",
    "apps/macos/App/NativeText.swift": "626011238af01cb0b4179e582f00ca40c83afa5591492bc9797a4b57e191635b",
    "apps/macos/App/ObserverMark.swift": "93f172ecc0b360338bb09913071a6ba6644077576abf9b323bfa95ebd4c5b764",
    "apps/macos/App/SevraMain.swift": "a001519c25160a01a38596c6bcb214d117ce3074ea22340fff2d005168b4b21b"
  }
}
```

### Delivered bundle

```json
{
  "binary": "ca443f33157ca98eca65f7c820311115c0f0b9c2dc29136cdf84217265c35876",
  "manifest": "bfe9c1a61fdac31504c1ec7ef031d2326cad78b57f6630d04f03a14f91d84ef7",
  "ui_sources": {
    "apps/macos/App/AppModel.swift": "7f1f6d0c81bd7f10e8dd2954c4c2f4004c240871d14f1c1a5bb015ba758c622b",
    "apps/macos/App/ContentView.swift": "342a0436254740a51aeddf1fe930765a4eeff294a2b7e5f3c11e64fe76b94968",
    "apps/macos/App/MacCommands.swift": "059ebbbaf81cb83f3c57bdc1f635b1d30e0f8913fe776ce4c9c2615c979fa481",
    "apps/macos/App/NativeText.swift": "626011238af01cb0b4179e582f00ca40c83afa5591492bc9797a4b57e191635b",
    "apps/macos/App/ObserverMark.swift": "93f172ecc0b360338bb09913071a6ba6644077576abf9b323bfa95ebd4c5b764",
    "apps/macos/App/SevraMain.swift": "a001519c25160a01a38596c6bcb214d117ce3074ea22340fff2d005168b4b21b"
  }
}
```

## Scripted regression output

Only the local checkout path is normalized below.

```text
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'Sevra' complete! (0.25s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraLocal main.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-local
Build of product 'sevra-local' complete! (3.97s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraComposerChecks ComposerChecks.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (5.84s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.23s)
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/3] Compiling SevraMacChecks AdverseChecks.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (6.27s)
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
PRESENTATION_RENDER_MS 13.990,0.250,0.244,0.248,0.242,0.240,0.244,0.238,0.242,0.244,0.239,0.242,0.243,0.343,0.295,0.263,0.263,0.257,0.261,0.241
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
PASS: historical saved documents remain available after later responses and restart
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

## Final build output

Only the local checkout path is normalized below.

```text
swift-driver version: 1.148.6 Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling Slotstream AdaptiveSpeculation.swift
<checkout>/Sources/Slotstream/EmbeddingRows.swift:107:36: warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
105 |             data.withUnsafeMutableBytes { output in
106 |                 for (i, id) in ids.enumerated() {
107 |                     available[id]!.withUnsafeBytes { row in
    |                                    `- warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
108 |                         memcpy(output.baseAddress! + i * stride, row.baseAddress! + offsets[p], stride)
109 |                     }

<checkout>/Sources/Slotstream/RouterTrace.swift:36:13: warning: variable 'header' was never mutated; consider changing to 'let' constant
34 |         lock.lock()
35 |         defer { lock.unlock() }
36 |         var header = [Int32(layer), Int32(tokens), Int32(topK)]
   |             `- warning: variable 'header' was never mutated; consider changing to 'let' constant
37 |         header.withUnsafeBytes { buffer.append(contentsOf: $0) }
38 |         var small = [Int16](repeating: 0, count: ids.count)
[4/5] Compiling SevraRuntime HomeStore.swift
[5/6] Compiling SevraMac AppModel.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking Sevra
Build of product 'Sevra' complete! (58.40s)
swift-driver version: 1.148.6 <checkout>/.build/sevra-bundle-TOvxvQ/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
<checkout>/.build/sevra-bundle-TOvxvQ/Sevra.app: replacing existing signature
<checkout>/.build/Sevra.app

```
