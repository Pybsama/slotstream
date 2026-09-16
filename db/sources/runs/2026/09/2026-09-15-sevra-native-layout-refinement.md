---
type: run
id: 01m2hc9spzxf5qsaxxrpj4xwyz
created: 2026-09-15T01:53:28.287790+00:00
updated: 2026-09-15T01:53:54.568853+00:00
summary: Native layout refinement with aligned toolbar, shared content gutters, consistent sidebar rows and scoped native verification
binary: 0252548337177e2f9f545e1637db2b8df5ad842cb37eb725679099bc9518ec8d
captured_at: 2026-09-15
command: bash Tools/build_sevra_mac.sh; native layout walkthrough; sevra-presentation-checks
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra native layout refinement verification
tool: Native AppKit UI and SwiftPM bundle build
---
# Native layout refinement verification

Scoped follow-up to the unified toolbar: inspect alignment, spacing and the whole native window, then correct observed inconsistencies.

## Changes

The native toolbar heading follows the detail-pane gutter as the sidebar resizes. AppKit measurements account for native navigation grouping after layout. Compact, hidden-sidebar and document-split layouts remove the alignment spacer entirely. The real system traffic lights and controls retain their own positioning.

The conversation, composer, run status, document actions and ordinary panels share a 720-point readable column and 24-point compact gutters. NSTextView line-fragment padding is removed so its readable text starts on the same grid as SwiftUI content. Artifact title, text, notices, sources and footer share the same inset. The native Settings form retains its grouped layout.

Sidebar icons use one fixed column. Rows have consistent heights, selected/pressed/hover states and active/inactive emphasis. The New Thread control loses its redundant capsule. Document actions have consistent hit areas and accessible labels without duplicate menu chevrons. Search results lose doubled horizontal padding. Journal uses a New entry heading instead of repeating the window title. Speaker labels and the gap between conversation sections use compact paragraph metrics while copy/export retain the original source.

## Native observations

Reviewed System resolving to Light and explicit Dark, the normal wide window, compact navigation, hidden and resized sidebar, grouped Settings, Search, Journal, Knowledge and Needs you. Reading size was increased to 21 points for a compact conversation and Settings check, then restored to 16. The sidebar was resized from 232 to 280 points and restored. Headings followed the detail-pane gutter. A native-toolbar grouping shift discovered during the review was fixed and rechecked after compilation. A retained spacer in compact mode was corrected by removing its toolbar item when the sidebar is absent.

The labeled, pre-existing rich-document fixture was reviewed for headings, nested lists, a native table and code spacing. Its saved document opened in the split viewer with aligned title, text, sources and footer controls. The final build was checked in Dark split mode, compact-to-wide navigation, full-screen document view and return, System appearance, Home and sidebar hiding/restoration. The three-dot menu still exposed New Thread, New Incognito Thread, Reveal Home and Settings. The fixture's pre-existing unsent draft survived the navigation and relaunches. No message was submitted and no inference was started for this review.

Final app state: Home, System appearance, normal reading size, visible default-width sidebar and a wide window. Independent runtime/performance work already in the shared checkout was preserved.

These are scoped visual and interaction observations. They do not certify the full VoiceOver/IME, live OS accessibility, sustained load/performance or installed-release matrix. The full-screen check covers the document layout and return, not every auto-hidden titlebar state.

## Build and targeted checks

The final canonical bundle script succeeded, compared build inputs before and after compilation, and verified the ad-hoc signature. The existing presentation checks passed after the paragraph/inset work; later edits touched toolbar alignment and an artifact-notice gutter only. The timing samples emitted by that test are preserved as diagnostics, not a clean performance claim.

Commands:

```text
bash Tools/build_sevra_mac.sh
swift build --package-path apps/macos -c release --product sevra-presentation-checks -j 2
apps/macos/.build/release/sevra-presentation-checks
```

Build identities:

```json
{
  ".build/Sevra.app/Contents/MacOS/Sevra": "0252548337177e2f9f545e1637db2b8df5ad842cb37eb725679099bc9518ec8d",
  ".build/Sevra.app/Contents/Resources/build-inputs.json": "c2f27a5ace9c9ee7ffe4a190e3c2474123ff6fc0548c57c5cf5655d45bdc2a6f",
  "apps/macos/App/SevraMain.swift": "20c95a008cd066186d70fc15f1b577ed562b86e57c970d8039c59f32083513b0",
  "apps/macos/App/ContentView.swift": "576c614c0dcb94258a7067eae5b1fcf556931da0f8c2a8f60bf5ca0da7c0e481",
  "apps/macos/App/NativeText.swift": "28d8267715c603997cdce8753dd4c524ad9183c6b503d3c05b54e600f9d4c48f",
  "apps/macos/Presentation/MarkdownDocument.swift": "26a2501a3e1b10a60ef72e2d98748f0d6778cef7c5df28c648f7db99fcb58f9d"
}
```

Final build output (checkout path replaced by a local-path label):

```text
swift-driver version: 1.148.6 Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (10.86s)
swift-driver version: 1.148.6 <checkout>/.build/sevra-bundle-INmfqQ/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
<checkout>/.build/sevra-bundle-INmfqQ/Sevra.app: replacing existing signature
<checkout>/.build/Sevra.app

```

Presentation check output:

```text
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write Objects.LinkFileList
[2/3] Linking sevra-presentation-checks
Build of product 'sevra-presentation-checks' complete! (2.59s)
PRESENTATION_RENDER_MS 14.424,0.275,0.253,0.250,0.243,0.246,0.246,0.241,0.244,0.259,0.242,0.242,0.244,0.240,0.240,0.240,0.246,0.242,0.248,0.239
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits

```
