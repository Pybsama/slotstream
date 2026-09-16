---
type: run
id: 01m2k3bscce92mqcvk24yt8bcb
created: 2026-09-15T17:55:45.164924+00:00
updated: 2026-09-15T17:56:14.331780+00:00
summary: Contextual Latest navigation with native viewport regression tests, light/dark UI checks and verified development bundle
binary: 8179d654843e9d9e5bd945c735d22a943d9b469064dae02383f1a361a9c7151d
captured_at: 2026-09-15
command: check_sevra_scroll.sh; composer/presentation checks; pinned Sevra build; native UI walkthrough
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra contextual Latest navigation
tool: Swift, AppKit, native UI, codesign
---
# Contextual conversation navigation

Follow-up to the native controls audit: the permanent toolbar down-arrow was
functional but occupied space even when there was nothing below. It is now a
round, contextual control above the composer, with native help and keyboard
access. No model was loaded during this UI pass.

## Implemented behavior

- Latest appears while newer content is below or an earlier history page is
  loaded; it disappears at the bottom. Empty/source-mode outlines are hidden.
- Clicking Latest or using Control-Command-Down returns to the exact latest
  page after asynchronous rendering, clears selection and focuses the document.
- Automatic following stays enabled while at the bottom with no selection.
  Scrolling away or selecting text preserves the reader's position during new
  output. Returning to a thread restores its saved position or following state.
- Sending an accepted message requests the latest page without stealing
  composer focus. The View menu and Keyboard settings expose the shortcut.
- Native clip/document frame observers publish viewport changes and detach
  with their view. Notification delivery verifies the document and render
  generation so stale geometry cannot update another conversation's control.
- A resize regression was reproduced by the production native component probe:
  reducing window size left the newest text below the viewport. The native
  scroll view now follows through resizing only when already following and
  no text is selected. The failing output is preserved below.

The proximity tolerance is a UI follow threshold, not a retention or performance
limit. The control uses the existing native palette, a circular boundary and
increased-contrast stroke, and performs no animated scroll. Live OS contrast,
reduced-motion transitions and full accessibility qualification remain open.

## Native UI observations

A separate synthetic Home and application identity were used for testing.

- A newly opened long conversation started at the newest message, with no
  Latest button or empty outline. Scrolling upward made the floating arrow
  appear above the composer; native AX help included its name and shortcut.
- Clicking the arrow returned the scrollbar to its end, removed the control,
  and placed focus in the conversation. The earlier-page action opened the
  first page; Control-Command-Down returned to the newest page and its end.
- The circular arrow was visually inspected in light and dark appearance.
  Keyboard settings listed the matching shortcut. System appearance was
  restored before the isolated app was closed.
- The updated normal development bundle reopened the existing Home with the
  empty outline and unnecessary Latest hidden. Conversation options and the
  remaining controls retained native help. Privately hashed Home file bytes
  remained identical across quit, bundle replacement and reopening; no private
  contents or paths are filed in this public record.

A clicked control can disappear before the automation system reads it, producing
a transient AX error; subsequent state verified the result. Native AppKit
help properties and AX help are checked. The tool has no sustained hover API,
so this does not claim a captured hover bubble or a complete VoiceOver pass.

## Verification and build identity

Tools/check_sevra_scroll.sh compiles the actual App/NativeText.swift with an
offscreen SwiftUI/AppKit fixture. Mutable synthetic text exercises the real
asynchronous render and viewport lifecycle, including selection, resize,
text-size changes, paging and thread switching. It does not simulate an entire
inference run. The script is included in Tools/check_sevra_mac.sh after the
presentation checks. Composer and Markdown regressions also passed again.

The app was built from the established isolated engine snapshot with pinned
resolution. Every Mac App source matched the root checkout, and the build-input
manifests matched before and after compilation. Concurrent root engine changes
are not qualified by this UI pass. The final bundle retained its normal
identity, logo and resources, passed ad-hoc codesign verification, and has a
rollback copy. Only the ordinary Home app remains running. No release or push.

Final bundle identity:

```json
{
  "executable_sha256": "8179d654843e9d9e5bd945c735d22a943d9b469064dae02383f1a361a9c7151d",
  "manifest_sha256": "97baf6d1412b7de933db1d514f22e9a7adc04eb6348dbfe0f41b19fa699c9e62"
}
```

## Preserved resize failure

```text
FAIL: window resizing preserves following at latest
PASS: first opening of a long conversation starts at latest without an extra control
PASS: new text follows while already at the end
PASS: streaming preserves the reader's position and offers Latest
PASS: explicit Latest clears selection and resumes following
PASS: later text keeps following after Latest
PASS: selecting text prevents streaming from moving the document
```

## Final native scroll check

```text
PASS: first opening of a long conversation starts at latest without an extra control
PASS: new text follows while already at the end
PASS: streaming preserves the reader's position and offers Latest
PASS: explicit Latest clears selection and resumes following
PASS: later text keeps following after Latest
PASS: selecting text prevents streaming from moving the document
PASS: window resizing preserves following at latest
PASS: text-size reflow keeps a reader at latest
PASS: an earlier page opens at its beginning
PASS: earlier-page Latest is consumed only after destination layout
PASS: short conversations need no jump control
PASS: returning to a thread restores its reading position
PASS: production native transcript scroll lifecycle
```

## Final build

```text
warning: '--skip-update' option is deprecated and will be removed in a future release
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (12.75s)
```

## Composer regressions

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

## Markdown regressions

```text
PRESENTATION_RENDER_MS 13.458,0.263,0.236,0.243,0.239,0.240,0.254,0.240,0.335,0.247,0.232,0.242,0.229,0.226,0.222,0.226,0.222,0.219,0.223,0.223
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
```

The prior control audit remains immutable:
[[sources/runs/2026/09/2026-09-15-sevra-mac-controls-and-help]]. Broader native,
model and release requirements remain open in
[[records/design/sevra-spec/implementation-status]]. Timing printed by the
existing harnesses is functional diagnostics on a live desktop, not a clean
performance benchmark.
