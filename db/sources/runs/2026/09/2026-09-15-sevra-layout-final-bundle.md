---
type: run
id: 01m2hcfcp4rxhy4zkz0r35xfsz
created: 2026-09-15T01:56:31.556393+00:00
updated: 2026-09-15T01:56:32.082228+00:00
summary: Final layout bundle with corrected source-to-binary mapping after concurrent app edits
binary: 3d631b5a1a2e311d8b9cc0b92c359d0ae5af3334e96899930bdb665c79da8c46
captured_at: 2026-09-15
command: bash Tools/build_sevra_mac.sh; build-input manifest comparison; native Home/Search review
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra layout final bundle and source correction
tool: Native AppKit UI and SwiftPM bundle build
---
# Layout refinement final bundle and source correction

Follow-up to [[sources/runs/2026/09/2026-09-15-sevra-native-layout-refinement]]. Its visual observations and tested binary remain evidence. Its source hash list was captured from the checkout after concurrent edits, so it must not be treated as an exact source-to-binary mapping. Specifically, that tested bundle's manifest records ContentView.swift as `07c31e996fee6b9bfcb41ff4b493de72a72938047f952194026e1a9cc9af75db`, while the receipt listed the newer working-copy hash. The original receipt remains unchanged.

A subsequent canonical bundle build incorporated the current shared checkout. Inputs matched before and after compilation; a fresh manifest generated after the build also matched the bundled manifest byte-for-byte. The signature verified. The identities below are derived from that bundle and its own manifest, not from a later working-copy sample.

The final app was reopened and visually checked on Home and Search. The toolbar heading aligns with the detail-pane gutter in both, the back button groups correctly, and conversation/status/composer margins remain aligned. The app is left on Home with System appearance, normal text size and the default visible sidebar. The independent Continue in thread/Open thread behavior changed concurrently and is outside this visual refinement's functional claims. Earlier Dark/compact/split/full-screen observations are scoped to the preceding bundle. Toolbar, native-text and Markdown-renderer sources are unchanged between those bundles. No broad release gate is accepted.

```json
{
  "binary": "3d631b5a1a2e311d8b9cc0b92c359d0ae5af3334e96899930bdb665c79da8c46",
  "manifest": "c80e95eb25b975129aa7b1ef59a8422571c38cecb06511e3fa82d3850efd2b92",
  "ui_sources": {
    "apps/macos/App/ContentView.swift": "e21cf2223eccf21357886a4fd65b5cb6336dd504930a26d24635a8889df1872b",
    "apps/macos/App/NativeText.swift": "28d8267715c603997cdce8753dd4c524ad9183c6b503d3c05b54e600f9d4c48f",
    "apps/macos/App/SevraMain.swift": "20c95a008cd066186d70fc15f1b577ed562b86e57c970d8039c59f32083513b0",
    "apps/macos/Presentation/MarkdownDocument.swift": "26a2501a3e1b10a60ef72e2d98748f0d6778cef7c5df28c648f7db99fcb58f9d"
  }
}
```

Final build command: `bash Tools/build_sevra_mac.sh`.
Output below substitutes the local checkout path only.

```text
swift-driver version: 1.148.6 Another instance of SwiftPM (PID: 51147) is already running using '<checkout>/apps/macos/.build', waiting until that process has finished execution...[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'Sevra' complete! (2.73s)
swift-driver version: 1.148.6 <checkout>/.build/sevra-bundle-UmsQHV/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
<checkout>/.build/sevra-bundle-UmsQHV/Sevra.app: replacing existing signature
<checkout>/.build/Sevra.app

```
