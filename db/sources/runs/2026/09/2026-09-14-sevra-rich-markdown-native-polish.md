---
type: run
id: 01m2gkxmr82c8jtjfzcpbv4b04
created: 2026-09-14T18:47:24.168442+00:00
updated: 2026-09-14T18:48:14.099606+00:00
summary: Native rich Markdown, document affordances, responsive layout and bounded regression evidence; full UI and release qualification remains open
binary: 7d38bdc2b1ca4267cacf318941a7b1ab17046b61f94e872e5c97d9b63ba5ef35
captured_at: 2026-09-14
command: Tools/build_sevra_mac.sh; sevra-presentation-checks; sevra-mac-checks; native UI walkthrough
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra rich Markdown and native UI polish audit
tool: Native UI, sevra-presentation-checks and sevra-mac-checks
---
# Rich Markdown and native UI polish audit

Scoped development implementation and native interaction evidence. This follows the earlier brand audit and preserves that receipt. No new model inference, remote page opening, analytics, release, sync or deployment was performed in this pass.

## Implemented

Swift Markdown parses CommonMark and GFM tables off the main thread, with per-message caching and late-reference reconciliation. The app uses native attributed text and NSTextTable through AppKit's compatible TextKit document engine deliberately. It does not claim an all-TextKit-2 path. Headings, emphasis, quotes, ordered/nested/task lists, native tables, code highlighting and exact code-copy links are implemented. HTML stays literal, remote images do not fetch, schemes are bounded, and only owner-bound citations resolve to evidence. Original Markdown remains available through source mode, full copy and export. The new dependencies' license notices are bundled by both build routes.

History windows cap loaded message count and aggregate source bytes; an individual oversized message is retained in source form. Clipboard overflow is explicit and offers full export, never truncation. Completed-message cache reuse, structural limits, late links, punctuation, UTF-8 coordinates, Unicode code and forward/backward history coverage have executable checks. Renderer timings below are developer diagnostics, not presented-frame, latency, sustained-load or release-performance qualification.

The resizable rail, scrollable compact navigation overlay, growing native composer, responsive artifact split, thread actions, search/empty/error/activity/review states and appearance/reading controls were refined. Navigation disables and hides underlying controls from accessibility and focuses its close action. Composer views retain Undo/caret state across panels with a bounded recent-view cache. Focus commands use the persistent view's revision; completion returns to the composer. Native writing tools and unneeded context-menu actions are disabled. Heading/table/code accessibility rotors are implemented, but not certified through a complete VoiceOver session.

## Native observations and corrections

- Reviewed rich headings, nested lists, blockquotes, table geometry, colored code and mixed Chinese/Hebrew/emoji in the running app. Light/Dark and System resolution work. Large reading/writing text was inspected at the smallest tested window, then System and default size were restored.
- Search initially failed to focus its field. After correction, Cmd+K focused it and searching document content returned the expected thread. Escape restored conversation focus; Cmd+L returned from Search to the composer. Settings now focuses the selected native appearance segment.
- Used the outline to jump to code. Its visible Copy code action pasted exact indentation, Unicode and trailing newline into the unsent fixture draft. Undo restored the draft. The context menu now contains only relevant copy/select/find actions.
- The compact navigation initially collapsed its thread list. After correction it exposed both test threads, scrolled its remaining destinations, focused Close navigation and hid the underlying UI from accessibility. Escape dismissed it. Native split dragging changed the conversation pane from 520 to 430 points while preserving both panes. The native splitter itself reports disabled through AX, so keyboard/VoiceOver resizing is not certified.
- The clearly labeled UI fixture read the public Markdown file through SourceFolder and retained a real byte/hash excerpt. Native Sources displayed the full excerpt, bytes 0..<1644 and the fixture hash. Native Save created native-ui-review.md; reopening showed the rich, read-only saved file. A byte comparison confirmed the saved file equals the reviewed source plus its declared citation paragraph.
- Native Find searched the open artifact pane and highlighted the expected occurrence. A prior selected range originally prevented link activation; the final delegate relies on native click handling and that guard was removed. The final native link click opened a sheet showing the full Apple destination and Cancel/Open in browser. Cancel returned to the document without opening a website.
- Export Markdown opened a native Save panel and saved the entire conversation to a temporary file. Independent comparison proved all message sources, separators and Unicode were preserved. File attachment selected the single public fixture, displayed Read-only, and returned focus to the composer. The attachment was removed after testing. The completed UI test thread was archived without deleting its document or evidence.
- The existing Cedar thread remains the real-model job evidence. The new formatting/review gallery explicitly identifies itself as a UI test with no model run. Do not conflate the two. The final bundle was launched after the last focus/link fixes and its input manifest still matched the checkout.

## Qualification still open

This is not full UI-D2/D3, alpha or stable acceptance. Full VoiceOver/table-cell semantics, IME input-method combinations, live OS appearance/accessibility transitions, cross-page selection continuity, long-document scrolling/selection under sustained fake and real inference load, exact presentation/frame/memory budgets and unfamiliar-user reviews remain open. Recent native editor caches are bounded and older evicted editor views do not retain session Undo stacks. Reconstructing the complete source for export remains distinct from cross-page text selection. Full Xcode, Developer ID/notarization, installation/update/rollback, extraction containment, Home export/inert restore and later extensions remain separate plan work. Native Markdown export is not a complete Home backup.

## Exact executable and artifact hashes

```json
{
  ".build/Sevra.app/Contents/MacOS/Sevra": "7d38bdc2b1ca4267cacf318941a7b1ab17046b61f94e872e5c97d9b63ba5ef35",
  ".build/Sevra.app/Contents/Resources/build-inputs.json": "8914e14600998347d34b149f24db148150c934ad3d98c7b4e8a15797d91b968d",
  "apps/macos/.build/release/sevra-mac-checks": "90f29f4666014f9855ebe81a09d06e569514c9104065b75a2cbd2a5b8829a394",
  "apps/macos/.build/release/sevra-presentation-checks": "e7a2e62a1d886271468f67e765dd4e033ed4908b7454bff588e0d93e038a1d97",
  "apps/macos/Fixtures/markdown/native-document.md": "4fb31aaab72c152a9da38db8bc90d95e134404054ba707a09330006ef64a1969",
  "apps/macos/Resources/Sevra.icns": "b28f2df8e40cafc2e89fb3ae5a0e361b5470851d833495df9b3dd4ca0395471d"
}
```

## sevra-polish-save-check.json

```text
{
  "fixture_sha256": "4fb31aaab72c152a9da38db8bc90d95e134404054ba707a09330006ef64a1969",
  "saved_sha256": "2cfaacb47559df40e8c08fd8e78d2c7caace7f7e88088a242b60c0a9d01f5550",
  "saved_equals_reviewed_fixture": true
}
```

## sevra-polish-export-check.json

```text
{
  "export_sha256": "5f4a18edb7a02bfd53fd8f4c5093403b92fd1a4396bce5852c4ba3a095a2bf00",
  "export_equals_all_message_source": true
}
```

## sevra-presentation-delivery-checks.log

```text
PRESENTATION_RENDER_MS 15.068,0.271,0.254,0.252,0.252,0.247,0.249,0.261,0.245,0.296,0.264,0.264,0.252,0.252,0.377,0.282,0.263,0.256,0.257,0.258
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
```

## sevra-runtime-delivery-checks.log

```text
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget
```

## sevra-polish-final-verified-bundle.log

```text
swift-driver version: 1.148.6 [0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (14.58s)
swift-driver version: 1.148.6 /Users/carlos/Projects/slotstream/.build/sevra-bundle-MGzkFr/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
/Users/carlos/Projects/slotstream/.build/sevra-bundle-MGzkFr/Sevra.app: replacing existing signature
/Users/carlos/Projects/slotstream/.build/Sevra.app
```

Earlier unsuccessful builds were corrected before final verification: an overlapping source change was rejected by the input-manifest gate; the CLT-only XCTest route was replaced by the standalone presentation check executable; initial rotor imports were corrected to the SDK's nested Swift names. Their local diagnostic logs remain in /tmp; none is counted as a passed gate.

[[records/design/sevra-spec/implementation-status]]
