---
type: run
id: 01m2k1vkmvmvgj30k45ew3wam3
created: 2026-09-15T17:29:26.427069+00:00
updated: 2026-09-15T17:29:57.244116+00:00
summary: Native control help, paging and split Find corrections with exact copy/export checks and verified development bundle
binary: d1fc0fafaf14a33ea3f0f88dfbe23b73960ef53793716ae1f53104734022b966
captured_at: 2026-09-15
command: swift build --product Sevra; composer and presentation checks; seed-audit-ui and native walkthrough
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra Mac control behavior and help audit
tool: Swift build, native UI, composer and Markdown checks, codesign
---
# Native control help and behavior audit

Development-app correction after a report of unexplained conversation icons.
The changes are limited to Mac UI actions, help, responder targeting and menu
admission. No model was loaded or inference benchmark repeated.

## Findings and fixes

- Conversation icons mean Outline, Jump to latest message, and Conversation
  options (Markdown source, full copy/export, and Find).
- Existing SwiftUI help did not consistently reach the actual menu/attachment
  control in accessibility inspection. Native icon buttons and pull-downs now
  own both NSView.toolTip and accessibility help. Help is only reassigned when
  it changes, preserving native hover tracking through frequent UI refreshes.
- Empty outlines explain the absence of sections. Source mode explains that
  the rendered view must be restored before using the outline.
- Jump to latest from an earlier page previously restored the saved old scroll
  position. A request now follows the exact destination through asynchronous
  render/layout, and only that document consumes it.
- Find in conversation previously used the global responder fallback and
  could select the artifact pane. Each document menu now targets its own text
  view. The preview also has Find. Global Find is disabled without a document.
- Source toggles are separate for conversation and preview. Outline actions
  resolve current ranges within the same message before jumping, so a menu
  left open during a render change cannot apply an obsolete range blindly.
- New thread, detach, attachment, navigation close, error dismissal, send,
  stop, toolbar overflow, navigation, paging, appearance, backups, model setup
  and memory controls have explanatory help. Disabled Send/Attach/Release
  states explain the relevant prerequisite. Trivial labeled Cancel/Done
  actions and standard system controls keep their native conventions.
- The empty-state attachment action and File/Send menu respect admission
  guards. The model also refuses Send while the Home is paused for review.
- The Xcode project registers the new native controls source, as does SwiftPM.

## Native observations

A new synthetic Home was seeded through the existing --seed-audit-ui harness,
using apps/macos/Fixtures/markdown/native-document.md. The normal Home was
kept separate from this test data.

- Earlier changed the loaded range from 11–90 to 1–10 of 90. Jump to latest
  returned to 11–90 with scrollbar value 1 and message 90 visibly at the end.
- Outline listed headings, the native table and Swift code. Selecting Code
  moved the scrollbar to 0.6133447390932421 and showed the exact code block.
- With a saved document open beside the conversation and preview focused,
  Find in conversation opened under the conversation text view. Find in
  document opened under the artifact text view. Escape closed Find before the
  preview and retained the unsent draft.
- Keyboard menu activation toggled preview source only; the conversation kept
  its rendered heading/table/code view.
- Copy Markdown, followed by native Paste into a disposable composer, exactly
  matched the full saved artifact, including Unicode and final citation.
  Undo returned the original synthetic draft.
- Export through NSSavePanel produced a file byte-identical to the artifact.
- New Thread opened an empty composer with disabled Send and its explanation.
  Attach opened NSOpenPanel and attached the selected disposable test log;
  Detach removed it while the original file remained present and empty.
- Native General/Model settings exposed help on category and appearance
  segments, sliders, backup/restore, local-model actions and release control.
- The final installed app reopened the existing Home. The conversation and
  toolbar icon controls expose their help. Its source toggle updates the
  outline explanation and was restored to rendered mode. Saved Home files
  matched a private before/after manifest; no private contents are filed here.

Some CUA AX actions reported a transient failure as a clicked control was
removed; subsequent state and screenshots confirmed the actual destination.
Native tooltips are installed on the AppKit hit targets and their help is
verified through AX. The available computer-use API did not provide a sustained
hover operation; no captured hover-bubble, full VoiceOver, all-IME, every
appearance/OS or streaming-load certification is claimed by this receipt.

## Build and regression evidence

Built with pinned resolution from the existing isolated engine snapshot, with
Mac App sources and Xcode registration matching the root checkout exactly.
Independent root engine edits remain unqualified by this UI pass. Before and
after build-input manifests matched. The previous normal app was retained for
rollback. The final development bundle passed codesign --verify --deep --strict.
The isolated audit process was closed; only the normal Home app remains open.

Final identity:

```json
{
  "executable_sha256": "d1fc0fafaf14a33ea3f0f88dfbe23b73960ef53793716ae1f53104734022b966",
  "manifest_sha256": "32d8d9acc80f7ab6d2d55c19cd7659813e3e0884f4170c8a954ad4434f2ab210"
}
```

Final build output:

```text
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (10.44s)
```

Production composer regressions (runtime/persistence unchanged by this pass):

```text
PASS: External adoption refreshes clean drafts and preserves competing unsaved text
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
PASS: 25 composer scenarios plus real-runtime persistence checks
```

Production Markdown regressions (timing printed by the existing harness is
functional diagnostics on a live desktop, not a clean benchmark claim):

```text
PRESENTATION_RENDER_MS 14.509,0.271,0.257,0.264,0.269,0.247,0.249,0.247,0.246,0.247,0.247,0.244,0.249,0.279,0.259,0.254,0.245,0.245,0.252,0.251
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
```

The full runtime and real-model acceptance from
[[sources/runs/2026/09/2026-09-15-sevra-mac-adversarial-fixes]] is prior evidence,
not a new run in this tooltip task. Broader product and release gates remain
open in [[records/design/sevra-spec/implementation-status]].
