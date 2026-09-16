---
type: run
id: 01m2gg996j1txaebjwcgbcdkxm
created: 2026-09-14T17:43:51.250778+00:00
updated: 2026-09-14T17:44:23.232584+00:00
summary: Native Observer branding, appearance, Save/reopen, document viewing and bounded runtime checks; full UI qualification remains open
binary: 8dec3e112649cd99329688c7d8e197818347b3a65201aec2e9ff3b3fab1a8d31
captured_at: 2026-09-14
command: bash Tools/build_sevra_mac.sh; swift build --package-path apps/macos -c release --product sevra-mac-checks -j 2; apps/macos/.build/release/sevra-mac-checks
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra native branding and interaction audit
tool: cua native UI and sevra-mac-checks
---
# Native brand and interaction audit

This is a scoped development-build review, not public-alpha acceptance. The earlier locked-screen receipt is preserved unchanged; this later session resumed when macOS was accessible.

## Direct native UI observations

- The sidebar displayed the approved Observer mark and lowercase Poppins wordmark in Light and Dark. The same mark appeared in the native About panel after adding the multiresolution bundle icon. Info.plist now declares that icon, and both bundle build routes include it. A separate Finder-shell walkthrough was interrupted by user activity, so Finder/Dock-shell appearance is not claimed as visually verified.
- Settings selected Dark and Light immediately. Dark persisted across application quit/relaunch. System resolved to the host's current Light appearance; System and the default content size were restored after QA. Live changes to the operating system's preference, increased contrast and VoiceOver were not tested.
- Native Save committed the existing real-model Cedar proposal. The completed thread and its artifact survived a clean quit and relaunch. This completes the previously untested native Save path on the synthetic QA Home.
- Initial Open document delegated to the system association but produced no visible document. The fix reads the current saved file through the native owner and displays it inside Sevra. The final app visibly showed cedar-briefing.md, its complete content in the accessibility document, a read-only label, Back to conversation and Reveal in Finder. The Finder action is not separately certified here.
- Reviewed the standard window and narrow navigation layout, including the largest content text setting. Composer and transcript now use the same text-size preference. A draft survived entering Settings, Dark/System switching and returning to the thread; it was cleared afterward. Native Find returned four occurrences of briefing. Quit completed cleanly. No inference or model download was started during this audit.
- Reduced excessive transcript spacing, kept Settings on the warm canvas, applied the selected readable secondary-text and input-boundary colors, gave document review a more compact composer, removed the composer from unrelated panels, and gave the sidebar toggle a purposeful accessible name.

## Requirements review and remaining gaps

Compared against the approved Observer geometry and brand decision, natural-writing/simple-design guide, and the Mac plan's S-UI1 through S-UI6, S2c and S2h. Native system controls, direct Swift ownership, native text editing, local-only inference, explicit source and artifact authority, appearance choice and purposeful branding are present. Full plan conformance is not established.

Still incomplete: rich Markdown/code/table/citation semantics; bounded large-history rendering and measured latency/frame/memory budgets; full keyboard focus/selection/IME continuity across panel replacement; VoiceOver and OS accessibility settings; resizable rail/overlay and content-growing composer behavior; artifact split layout; first-use and model-download error/recovery qualification; installed-release and unfamiliar-user review. Small-window screenshots do not certify all geometry or accessibility targets.

The bundled ICNS is a development icon with the approved geometry, not a completed modern layered-icon qualification. Apple's current Icon Composer workflow remains relevant to release work: https://developer.apple.com/documentation/Xcode/creating-your-app-icon-using-icon-composer . No full Xcode or Icon Composer qualification was performed.

The native saved-document reader accepts only a named completed thread artifact, opens the Home/artifacts directory and file with no-follow handles, rejects non-regular files and caps UTF-8 reading at the existing one-megabyte source-read budget. It displays current bytes read at open time, not a claim that externally edited bytes equal the earlier approved proposal. Tests cover exact current bytes, symlink substitution and the read cap.

## Exact local evidence

```json
{
  ".build/Sevra.app/Contents/MacOS/Sevra": "8dec3e112649cd99329688c7d8e197818347b3a65201aec2e9ff3b3fab1a8d31",
  ".build/Sevra.app/Contents/Resources/build-inputs.json": "74a037e6986bbea359df6265e5e4985ab6d42a9db04653c133438c2e3ac67915",
  "apps/macos/Resources/Sevra.icns": "b28f2df8e40cafc2e89fb3ae5a0e361b5470851d833495df9b3dd4ca0395471d",
  "apps/macos/.build/release/sevra-mac-checks": "fc1b520c26e80b19ee44cb299718bc7563bc9488d47c4d15ffa88d7aa230d72c",
  "native_QA_artifact_sha256": "e69014aa604cb3b84a1914f1b0260df5645a692e95be54092d52040a6793ca49"
}
```

## sevra-brand-final-build.log

```text
swift-driver version: 1.148.6 [0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/4] Write sources
[4/5] Compiling SevraRuntime HomeStore.swift
[5/6] Compiling SevraMac AppModel.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking Sevra
Build of product 'Sevra' complete! (13.32s)
swift-driver version: 1.148.6 /Users/carlos/Projects/slotstream/.build/sevra-bundle-G0ewKe/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
/Users/carlos/Projects/slotstream/.build/sevra-bundle-G0ewKe/Sevra.app: replacing existing signature
/Users/carlos/Projects/slotstream/.build/Sevra.app

```

## sevra-brand-check-build.log

```text
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (6.83s)

```

## sevra-brand-checks.log

```text
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, source symlink substitution
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget

```

