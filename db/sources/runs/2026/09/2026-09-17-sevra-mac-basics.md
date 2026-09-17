---
type: run
id: 01m2q4bjv3v412sshkta0q1q6k
created: 2026-09-17T07:30:04.771132+00:00
updated: 2026-09-17T14:55:23.040449+00:00
summary: 'Sevra Mac basics: full scripted suite, offscreen checks and two real-model runs pass for documents, reviewed changes, knowledge bases, skills and mini-apps'
binary: 21bb959a758f500ccf7ef93c44f34769690bf72c43b8d9971027cb4a57713f40
captured_at: 2026-09-17
command: bash Tools/check_sevra_mac.sh; sevra-mac-checks --basics; helper mode matrix; bash Tools/build_sevra_mac.sh; sevra-mac-checks --real-basics --home <new>; SEVRA_APP_UNDER_TEST=<app> bash Tools/check_sevra_apps_ui.sh; temporary sevra-mac-checks diagnostics --real-edit-trace, --edit-diagnostics, --edit-isolation, --edit-chains and --edit-canonical; slotstream doctor --memory-gb 10 --mtp off --vision off --max-context 8192 and 32768 --json
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra Mac reading, reviewed changes, knowledge bases, skills and mini-apps
tool: Swift build, scripted runtime checks with sevra-extract and dbmd, offscreen view checks, app bundle build, the local model at the 10 GB plan, slotstream doctor 0.2.20
---
# Sevra Mac basics: scripted, real-model, bundle and isolation verification

Development receipt for the Mac app work of September 17, 2026: attachments of files, folders and db.md stores; PDF, Word, RTF, OpenDocument, Excel and EPUB reading with page citations; text recognition for images and scanned pages; the sandboxed `sevra-extract` helper; reviewed file and record changes with undo; skills; offline mini-apps with Home data; and a 32,768-token planning window. Most of it is functional verification of one development build on one Mac, with scripted inference and the real bundled dbmd. The real-model sections record the basics check with the local model at the 10 GB plan. None of it is a latency claim, a VoiceOver pass, a person's review of the live app or a release qualification.

## Build under test

- Engine sources: `Sources/`, `Package.swift` and `Package.resolved` in the snapshot are identical, by git blob hash, to commit `6e25b00`. Uncommitted engine changes in the main checkout were not part of these runs.
- App sources: `apps/macos` and the Mac scripts below were copied into an isolated snapshot at `.build/sevra-basics/slotstream` and compared byte for byte with the source checkout before the final run. They were identical.
- App source manifest: 70 files, SHA-256 `629230d7a58bba3e6124f2ee5c7ef2b12672c3f0372cb3bda618da1371aba52f`. The manifest is `shasum -a 256` of each file from `find apps/macos -type f -not -path '*/.build/*' | LC_ALL=C sort`, in that order, and the hash covers the manifest text.
- `sevra-mac-checks` release binary SHA-256 `21bb959a758f500ccf7ef93c44f34769690bf72c43b8d9971027cb4a57713f40`.
- `sevra-extract` release binary SHA-256 `5cd8d69cabade916b5c19d1b02f64662a0198f021330bfea98672681df206796`.
- `dbmd 0.13.5-dev.4`, SHA-256 `ce799f5d8105969bf57c80d451fd8e5a10d325eee01dac659f15694b5355e8ef`.
- MacBook Pro, Apple M5 Pro, 48 GB, macOS 26.6.2 (25G83), Apple Swift 6.3.3 from the Command Line Tools.

| Script | SHA-256 |
| --- | --- |
| `Tools/check_sevra_mac.sh` | `e9c4f307879651646bfb91becf2885e3e1599fa6abc1c1c928d36369f8b49daf` |
| `Tools/check_sevra_apps_ui.sh` | `04a284945972d531d6fa46a64b143d9cde3b75d35743a1168f06ba9dd86ca985` |
| `Tools/check_sevra_thinking_ui.sh` | `a965c0157b3eec1c577e734060de4195af2ada069dc4429ef7b719581a4094da` |
| `Tools/build_sevra_mac.sh` | `21854dfe1d88d2f2589b15f7f665c27d054dfe8614f9b4d33835017d3009aab0` |
| `Tools/mac_build_inputs.py` | `4a2cdf7fcd74b2236e360f731c34069f6d19df33cf563c81581de4e9351a402c` |

## Complete scripted suite

`bash Tools/check_sevra_mac.sh` in the snapshot. Exit 0; 87.30s user 22.85s system 54% cpu 3:22.61 total. It builds the app, the local CLI, the check programs and `sevra-extract`, then runs the composer, presentation and runtime suites and the two offscreen view checks. 143 PASS lines, no failures:

```
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
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
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
PASS: Home composer shows the Think longer switch
PASS: Home hint stays plain while thinking is off
PASS: a new thread starts with Think longer off
PASS: Think longer is clickable
PASS: the thread remembers the switch
PASS: the hint explains the switch while it is on
PASS: Send is clickable
PASS: run status shows Thinking with a clock: Thinking… 0:01
PASS: Thinking status and Answer now are visible while the thought runs
PASS: Working notes can be opened while the thought runs
PASS: opened working notes show the streaming thought and its privacy line
PASS: Answer now is clickable
PASS: the run records an Answer now receipt: Thought for 3 s, then answered when you asked.
PASS: the answer arrived after Answer now
PASS: the receipt line is shown under the run
PASS: working notes stay readable and Answer now is gone
PASS: the composer hint now quotes a typical thinking time
PASS: Think longer is clickable again
PASS: clicking again turns thinking off and restores the plain hint (thinking=nil)
PASS: thinking controls render and respond in the production Mac views
PASS: the page made no network connection (attempts seen: [])
PASS: WebKit reports peer connections, link preconnects and DNS prefetching off (["LinkPreconnect": true, "LinkDNSPrefetchEnabled": true, "PeerConnectionEnabled": true])
PASS: fetch is blocked
PASS: fetchSelf is blocked
PASS: xhr is blocked
PASS: websocket is blocked
PASS: eventsource is blocked
PASS: peer connections are unavailable
PASS: no peer connection sent a datagram (0 seen; fresh frame: unavailable, srcdoc frame: undefined)
PASS: the page cannot open windows
PASS: an undeclared collection is refused
PASS: the page cannot replace the Sevra API
PASS: info reports only the declared collection
PASS: navigation away is refused (at sevra-app://app/index.html)
PASS: the page hears changes to its own collection only
PASS: the declared write reached the broker once
PASS: browser storage does not outlive the app view (<null>)
PASS: a second run and both teardowns made no network connection (attempts seen: [])
PASS: a second run sent no datagram either
PASS: the attached folder shows as a chip that can change
PASS: Send is clickable
PASS: the run offers Review changes
PASS: nothing is written while the review waits
PASS: Review changes is clickable
PASS: the review shows the removed and added lines
PASS: the review offers Write and Discard
PASS: Write 1 File is clickable
PASS: after writing, the panel offers Undo
PASS: Send is clickable for the app request
PASS: Review app is clickable
PASS: the preview runs the app against scratch data
PASS: the preview wrote nothing to Home
PASS: the review shows the data access and Turn On App
PASS: Turn On App is clickable
PASS: the approved app saved and shows a Home record
PASS: the app canvas names the app and its offline boundary
PASS: Apps & Skills lists the app and the built-in skills
PASS: Send is clickable for the second app request
PASS: Review app is clickable for the second app
PASS: a review names records other apps already saved in a collection
PASS: Send is clickable for the third app request
PASS: an app's own saves are not echoed back to it, so a save-on-change app stays at one record (1)
PASS: mini-app isolation and review flows work in the production Mac views
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
PASS: source Unicode boundaries, skipped symbolic links and repeated oversized-inventory cleanup
PASS: model verification hash parity and mid-read cancellation without model allocation
PASS: coherent Home backup, complete manifest, exact drafts, pending review, inert restore, explicit activation, monotonic Forget, unknown epochs, corruption/missing/symlink/path/collision/closure refusal and create-only publication
PASS: external draft inspection, exact review race refusal, preserved versions, revision adoption, restart review, no implicit inference, malformed record refusal and normal work after reconciliation
PASS: long Home recent windows, exact retained history, inspectable partial excerpts, matching-memory ranking, bounded full-memory text, suppression lineage and thread-only read/write scope
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
PASS: thinking off by default, sticky switch, live thought, receipt, answer now, off for tools, restart, no thought on disk
PASS: incognito thought stays in memory and leaves with its thread; local endpoint thinking intents
PASS: document helper sandbox denies file reads, folder listing, writes, loopback network, process launch, window server and home access; its memory limit counts the whole process group
PASS: multi-source attach, hidden and dependency folders skipped, PDF pages, word search fallback, image and scan recognition, RTF, Word, locked/damaged/oversized refusals, detach
PASS: tool groups follow access; cancelled document reading stops its helper
PASS: documented limits: eight attachments, 8 MB text files, 64 MB documents, 40 recognized pages per request, 2,000 files per folder
PASS: change tools follow access, read-before-edit, exact diff review, digest-bound approval, exact writes preserving mode and tags, undo with Trash recovery
PASS: external edits win, discard, hard-link refusal, symbolic-link swap refusal, review across restart with re-attached folder, Incognito read-only
PASS: process death while writing is reported after restart, never replayed, and undoable
PASS: knowledge base search and query, record-only tools, protected frontmatter/contract/paths, db.md writes, index and validation, undo with index rebuild, mid-write record edits kept
PASS: /skill proposal, reserved names, exact publication, /name use, no implied tools, tamper refusal, deactivation, restart
PASS: app review, exact publication, grants, host document, create/get/update/archive/restore, revision conflicts, scope and version refusals, malformed and nested data, db.md validation
PASS: app revision with shared data, version switching, tamper refusal, removal keeps data, Incognito, restart, write budget, inert restore, outside-edit pause
```

Snapshots from these runs were reviewed for layout: the dark change review, both app reviews and the dark Apps & Skills panel. The thinking snapshots come from that feature's own check. Snapshots do not show web view content, which WebKit draws in a separate process, so the apps check reads the drawn page text through the page itself.

| Snapshot | SHA-256 |
| --- | --- |
| `.build/sevra-thinking-ui/01-home-idle.png` | `bf6690512afac802b372175ac34084d7c5c2fc982099371b28d2b7e6dc8c5553` |
| `.build/sevra-thinking-ui/02-thread-thinking-off.png` | `9a28cdeb2ac1e7632004b033b8ecded50a122e1327c3f1638107384071e11eab` |
| `.build/sevra-thinking-ui/03-thread-thinking-on.png` | `7b499a54a094ce3038629a1a7b71255b020739ffb60b2ec627f45168b6e723e9` |
| `.build/sevra-thinking-ui/04-thinking-live.png` | `3ca2a132d09dee6d60614e339df009ec05b9eccd442b887ce1879620b798febe` |
| `.build/sevra-thinking-ui/05-answered-receipt.png` | `7cc828d8ad4626927bfb7caa9ae096b21a78f33bbf08cdeb29dbd5c4b8572f12` |
| `.build/sevra-thinking-ui/06-answered-receipt-dark.png` | `cc84797e0f0df811ad3e434a209b46d321036ce7e5a478f2cd4e91a2c9351e84` |
| `.build/sevra-apps-ui/01-folder-attached.png` | `013db67d624ddd1b00305a8640484af55785d2911b6036ff5a0d88d2af0defc5` |
| `.build/sevra-apps-ui/02-changes-waiting.png` | `6ddb46a16d11b4d0f0c5f82c8f3d876c3aee1b2d907b9832f6654350fde7b826` |
| `.build/sevra-apps-ui/03-changes-review.png` | `6cf7db12cf07a8f050f7eee76e029068a7a4a93b8669eff5a428d02050cbfda1` |
| `.build/sevra-apps-ui/03-changes-review-dark.png` | `51d1a750b14a706650b96857209573b3a2a515b63212131f5b5b50f88c6cdac3` |
| `.build/sevra-apps-ui/04-changes-written.png` | `b4a910afc179cb316cf9b4f039101793d2ae395636174f4553e74eb81b75aeec` |
| `.build/sevra-apps-ui/05-app-review.png` | `83106b71db03e722a7796dd24dd783c644dd07d6fb415b93dd544fa8f32afcde` |
| `.build/sevra-apps-ui/06-app-open.png` | `3847d95ce3521e4ac97bf10eba86d8d72d7a94c6d0d8b38c7548b0091a901a2e` |
| `.build/sevra-apps-ui/07-apps-and-skills.png` | `95cafb8a4bf8ca7c24b095036f7f88c348f560cfd32b5b84843c2d1adaa59112` |
| `.build/sevra-apps-ui/07-apps-and-skills-dark.png` | `fea7b509599ca6fc521a9d9b6c7d9560e024b3c0c0f85809d4433dde97e8267b` |
| `.build/sevra-apps-ui/08-shared-collection-review.png` | `212659c6750809e7191a01191c0bf96ad78d071f6d6614479cb3afa677ee40a7` |

## Checks run against code without their fix

Four new checks were each run once against a copy of the code of that moment with their fix removed. Each time the snapshot was then restored from the source and rebuilt. The last one ran after the suite, and the suite's own `sevra-mac-checks` binary was put back afterwards, so the hash above is the binary that ran the suite. The fifth check was written before its fix and run on the code as it stood.

- Without the record re-check before dbmd writes, the knowledge check failed: `CHECK FAILED: a record edited while earlier changes are written keeps the edit ([SevraRuntime.FileChange.Status.applied, SevraRuntime.FileChange.Status.applied])`. The person's edit was overwritten.
- Measuring only the helper process instead of its group, the sandbox check failed: `CHECK FAILED: the helper memory limit counts processes the helper starts (0 MB)`.
- With link preconnects left on, the host refused to create the app view and the apps check stopped: `Fatal error: Error raised at top level: Error Domain=AppsUIChecks Code=2 "the app view did not load"`.
- With every write request allowed, the app check failed: `CHECK FAILED: an app that saves too often is slowed down (0 of 140 refused)`.
- Before open apps stopped hearing their own saves, the apps check failed: `FAIL: an app's own saves are not echoed back to it, so a save-on-change app stays at one record (40)`. The same check reports one record now.

## Real model, first run

`sevra-mac-checks --real-basics --home <new>` with `LocalInference(memoryGB: 10)`, the release helper and `mlx.metallib` copied beside the binary, after confirming no other model process was running and about 21 GB was reclaimable. The first attempt stopped before loading because the metallib was missing and was discarded with its fixture folder. The second attempt ran to completion. Its binary was built from this session's sources before the own-write tracking, the write budget and the final PASS wording were added; its hash was not recorded. The engine reported `expert cache ~20/512 per layer (961 global slots = 2.7 GB)`. Exit 0 in 544 seconds. Status lines and results, without the prompt-reading progress lines:

```
  Verifying the local model
  Loading the local model
  Responding
  Responding
  Responding
  Responding
  Completed
PASS: the PDF question completes
PASS: the answer states the budget from the PDF
PASS: the answer names page 2
PASS: the run read the budget through the document reader
  Reading the conversation
  Responding
  Responding
  Responding
  Responding
  Responding
  Review 1 file change before anything is written
PASS: the edit waits for review as one change to plan.md
PASS: nothing is written before review
PASS: the approved edit changes exactly the status line
  Reading the conversation
  Responding
  Review the new app before turning it on
PASS: the app request ends in an app review
PASS: the app declares the counter collection for writing
PASS: the app uses the Sevra data API and has buttons
PASS: the app loads no web resources and uses no network API
PASS: the approved app is on with its data access
PASS: real local model answered from a PDF, proposed an exact reviewed edit and a working app proposal
```

Receipt printed by the check:

```json
{
  "app" : {
    "collections" : [
      "counter:write"
    ],
    "html_bytes" : 4521,
    "html_sha256" : "291391ecdb5a2a02d6180c321bc02645169d0aa3a3a88bbd7d44b194f06cb45d",
    "name" : "Counter",
    "notes" : [

    ],
    "prompt" : "\/app Build a small counter app with plus and minus buttons. Save the count in a collection named counter so it is kept.",
    "state" : "needsYou",
    "status" : "Review the new app before turning it on",
    "trace" : [
      "app.propose: inert draft awaiting review"
    ]
  },
  "edit" : {
    "changes" : [
      {
        "added" : 1,
        "operation" : "update",
        "path" : "plan.md",
        "removed" : 1
      }
    ],
    "prompt" : "In plan.md, change the status from draft to approved. Change nothing else.",
    "state" : "needsYou",
    "status" : "Review 1 file change before anything is written",
    "trace" : [
      "source.list: returned bounded source data",
      "source.read: returned bounded source data",
      "The model returned unsupported arguments for file.edit: old]\n<\/parameter. No calls from that response were executed. Requested one corrected response.",
      "file.edit: staged for review",
      "files: 1 staged for exact-content review"
    ]
  },
  "edit_written_sha256" : "646bb50f7a5184693ac355518a0ddaca2854e55e528f640b897bbf7b8d00db7d",
  "failures" : [

  ],
  "model_plan_gb" : 10,
  "pdf" : {
    "answer" : "I'll look through the attached files to find the report and the Cedar pilot budget.\n\nI found the report. Let me search it for the budget details.\n\nLet me read that section to confirm the details.\n\nThe approved Cedar pilot budget is **$7,300**, held by the operations team [S1].\n\nThis appears on **page 2** of `cedar-report.pdf` [S1].",
    "excerpts" : [
      {
        "id" : "S1",
        "method" : "pdfkit",
        "page" : 2,
        "path" : "cedar-report.pdf",
        "sha256" : "11d63e93fd0b44302ca352f17fe09dc927a1be510604898bc6b9cc5bf053f7ec"
      }
    ],
    "prompt" : "What is the approved Cedar pilot budget, and which page of the report says so? Read the report before answering.",
    "state" : "completed",
    "trace" : [
      "source.list: returned bounded source data",
      "source.search: returned bounded source data",
      "source.read: returned bounded source data"
    ]
  },
  "seconds" : 544
}```

Physical footprint samples from `vmmap --summary`, roughly every 16 seconds from the edit job on; swap stayed at 6,592 MB, as before the run:

```
02:43:52 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:44:08 Physical footprint: 7.1G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:44:24 Physical footprint: 6.8G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:44:40 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:44:56 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:45:13 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:45:30 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:45:46 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:46:03 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:46:20 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:46:36 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:46:52 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:47:08 Physical footprint: 6.2G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:47:24 Physical footprint: 6.3G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:47:40 Physical footprint: 6.3G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:47:56 Physical footprint: 6.3G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:48:12 Physical footprint: 6.3G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:48:28 Physical footprint: 6.3G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:48:45 Physical footprint: 6.3G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:49:01 Physical footprint: 6.3G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:49:18 Physical footprint: 6.4G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:49:34 Physical footprint: 6.4G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:49:50 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:50:06 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:50:22 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:50:38 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6592.31M
02:50:54 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6592.31M
```

Observations: the PDF answer carries the model's narration from earlier tool rounds before the answer itself. The model's first file.edit call used an argument name that contained a line break, `old]\n</parameter`. The host refused the whole response and the one bounded correction produced a valid call. Two later rounds of the edit job re-read the whole prompt instead of reusing the held prefix.

The counter app it built looks for a record with the id `count`, which it cannot choose, creates a record whenever that lookup fails, and reloads on every change event. The new app-under-test mode ran that exact file (SHA-256 `291391ecdb5a2a02d6180c321bc02645169d0aa3a3a88bbd7d44b194f06cb45d`) twice in the production host over one scratch store:

```
PASS: the app has a plus button that can be clicked three times
PASS: the app shows 3 after three clicks
FAIL: the reopened app still shows 3 (COUNTER | 0 | − | + | Reset to 0)
FAIL: the app kept one record instead of creating one per opening (2)
FAIL: 2 checks failed
```

With the host echoing an app's own saves, the same pattern loops. A deterministic check that reproduces it counted 40 records within about four seconds before the fix and counts one after it. The app guidance now says that Sevra assigns record ids, how to keep a single value, and that change events report only changes made elsewhere.

## Real model, second run

The same command with the suite's `sevra-mac-checks` and `sevra-extract` above, in a new folder. It started once the other session's agent gate had ended and the model slot had stayed free for 30 seconds. Exit 0 in 512 seconds. Status lines and results, without the prompt-reading progress lines:

```
  Verifying the local model
  Responding
  Responding
  Responding
  Responding
  Completed
PASS: the PDF question completes
PASS: the answer states the budget from the PDF
PASS: the answer names page 2
PASS: the run read the budget through the document reader
  Reading the conversation
  Responding
  Responding
  Reading the conversation
  Responding
  Responding
  Responding
  Review 1 file change before anything is written
PASS: the edit waits for review as one change to plan.md
PASS: nothing is written before review
PASS: the approved edit changes exactly the status line
  Reading the conversation
  Responding
  Review the new app before turning it on
PASS: the app request ends in an app review
PASS: the app declares the counter collection for writing
PASS: the app uses the Sevra data API and has buttons
PASS: the app loads no web resources and uses no network API
PASS: the approved app is on with its data access
PASS: real local model answered from a PDF, proposed an exact reviewed edit and an app that passed its review checks
```

Receipt printed by the check:

```json
{
  "app" : {
    "collections" : [
      "counter:write"
    ],
    "html_bytes" : 5203,
    "html_sha256" : "4cbc8fcaf1ff8d22188a3b354e1daa802770abe2e7868f27478412ddcd07b826",
    "name" : "Counter",
    "notes" : [

    ],
    "prompt" : "\/app Build a small counter app with plus and minus buttons. Save the count in a collection named counter so it is kept.",
    "state" : "needsYou",
    "status" : "Review the new app before turning it on",
    "trace" : [
      "app.propose: inert draft awaiting review"
    ]
  },
  "edit" : {
    "changes" : [
      {
        "added" : 1,
        "operation" : "update",
        "path" : "plan.md",
        "removed" : 1
      }
    ],
    "prompt" : "In plan.md, change the status from draft to approved. Change nothing else.",
    "state" : "needsYou",
    "status" : "Review 1 file change before anything is written",
    "trace" : [
      "source.list: returned bounded source data",
      "source.read: returned bounded source data",
      "The model returned unsupported arguments for file.edit: old]\n<\/parameter. No calls from that response were executed. Requested one corrected response.",
      "file.edit: staged for review",
      "files: 1 staged for exact-content review"
    ]
  },
  "edit_written_sha256" : "646bb50f7a5184693ac355518a0ddaca2854e55e528f640b897bbf7b8d00db7d",
  "failures" : [

  ],
  "model_plan_gb" : 10,
  "pdf" : {
    "answer" : "I'll look through the attached files to find the report and the Cedar pilot budget.\n\nI found the report. Let me search it for the budget details.\n\nLet me read that section to confirm the details.\n\nThe approved Cedar pilot budget is **$7,300**, held by the operations team [S1].\n\nThis appears on **page 2** of `cedar-report.pdf` [S1].",
    "excerpts" : [
      {
        "id" : "S1",
        "method" : "pdfkit",
        "page" : 2,
        "path" : "cedar-report.pdf",
        "sha256" : "485997908e31ed6768e3ae92f1b9255efac123f5655ccd7ff9c59c5ffcdd2a94"
      }
    ],
    "prompt" : "What is the approved Cedar pilot budget, and which page of the report says so? Read the report before answering.",
    "state" : "completed",
    "trace" : [
      "source.list: returned bounded source data",
      "source.search: returned bounded source data",
      "source.read: returned bounded source data"
    ]
  },
  "seconds" : 512
}```

Physical footprint samples from `vmmap --summary`, roughly every 16 seconds, with reclaimable memory in GiB and swap before and after:

```
before 03:23:02 reclaimable_gb=29 swap_used=6576.31M
03:23:02 Physical footprint: 80K Physical footprint (peak): 96K  swap_used=6576.31M
03:23:17 Physical footprint: 6.1G Physical footprint (peak): 6.1G  swap_used=6576.31M
03:23:36 Physical footprint: 6.6G Physical footprint (peak): 6.6G  swap_used=6576.31M
03:23:53 Physical footprint: 7.0G Physical footprint (peak): 7.0G  swap_used=6576.31M
03:24:09 Physical footprint: 7.4G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:24:25 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:24:40 Physical footprint: 6.8G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:24:56 Physical footprint: 7.0G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:25:12 Physical footprint: 6.7G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:25:28 Physical footprint: 6.8G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:25:44 Physical footprint: 6.8G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:26:00 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:26:16 Physical footprint: 6.8G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:26:32 Physical footprint: 6.8G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:26:48 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:27:04 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:27:19 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:27:35 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:27:51 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:28:07 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:28:23 Physical footprint: 6.9G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:28:39 Physical footprint: 7.0G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:28:54 Physical footprint: 7.0G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:29:10 Physical footprint: 7.0G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:29:26 Physical footprint: 6.0G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:29:42 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:29:58 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:30:14 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:30:30 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:30:45 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:31:01 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:31:17 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
03:31:33 Physical footprint: 6.1G Physical footprint (peak): 7.4G  swap_used=6576.31M
after 03:31:49 reclaimable_gb=30 swap_used=6576.31M
```

The app-under-test mode then ran the app from this run, SHA-256 `4cbc8fcaf1ff8d22188a3b354e1daa802770abe2e7868f27478412ddcd07b826` with data `counter:write`, twice in the production host over one scratch store:

```
PASS: the app has a plus button that can be clicked three times
PASS: the app shows 3 after three clicks
PASS: the reopened app still shows 3 (COUNTER | 3 | − | + | Reset to 0)
PASS: the app kept one record instead of creating one per opening (1)
PASS: the app under test keeps its count across reopening
exit 0
```

Observations: all twelve checks passed again, and swap stayed at 6,576 MB. The PDF answer and the edit job's trace are byte-identical to the first run's, narration and malformed first file.edit call included. Answers are decoded greedily, and both runs reached the edit prompt through the same cached turns, so they gave identical responses. The repeat is one behavior seen twice, not two independent samples. The app request ran under the corrected guidance, so its app differs from the first run's. This counter keeps its count in the first listed record and creates a record only when the list is empty. It sends the record's revision with each update and runs one save at a time. It reloads on change events, which now report only changes made elsewhere.

### Tracing the malformed edit call

A first replay wrapped the local model and printed each response as the runtime received it, before validation. It was built into the snapshot as a `sevra-mac-checks` with SHA-256 `d54589997b76e7dd580e965232414e185a665e261e21d29d9a004fb594646b76`, run once with `--real-edit-trace --home <new>` and removed. It reproduced the same edit trace, and its parsed arguments were:

```
--- response call file.edit: ["\"id\"=\"file-2\"", "\"old\"=\"Status: draft\"", "\"old]\\n</parameter\"=\"<parameter=new>\\nStatus: approved\""]
--- response call file.edit: ["\"id\"=\"file-2\"", "\"new\"=\"Status: approved\"", "\"old\"=\"Status: draft\""]
```

Further diagnostics loaded the engine directly with the app's 10 GB plan. They replayed the check's edit job with the exact prompts the runtime builds, captured with scripted turns. Their source was never part of the repository. As of the `--edit-chains` run it had SHA-256 `16f8c890dced1833bc56e7d357e3a8e29f418adadb719f46d89fd6d4ad292a8f`, and that build, SHA-256 `65ac6eb8985331654611c703a5403602379294d56ddf9ba44f976b9da12bad51`, ran `--edit-chains`. The `--edit-diagnostics` and `--edit-isolation` runs used earlier builds of the same file, before later sections were appended; their hashes were not recorded. The snapshot was restored and the suite binary put back afterwards.

The engine's raw text for the rejected call:

```
"<tool_call>\n<function=file.edit>\n<parameter=id>\nfile-2\n</parameter>\n<parameter=old]\n</parameter>\n<parameter=new>\nStatus: approved\n</parameter>\n<parameter=old>\nStatus: draft\n</parameter>\n</function>\n</tool_call>"
```

After the `id` parameter, the model opened an `old` parameter but wrote `]` where the tag's `>` belongs, and closed it at once. It then wrote `new` and a correct `old`. The parser read everything from the stray tag to the next closing tag as one argument, which swallowed `new`.

Scores for that stretch on a fresh state that reads the whole prompt in passes of 256 tokens, then feeds the engine's generated tokens one at a time. Token 25 is the flipped one:

```
SCORE 23 chosen="=" p=0.9999 argmax=same top: "=" 0.9999 | "=new" 0.0000 | "=path" 0.0000 | "=s" 0.0000 | " old" 0.0000
SCORE 24 chosen="old" p=1.0000 argmax=same top: "old" 1.0000 | "object" 0.0000 | "content" 0.0000 | "offset" 0.0000 | "Old" 0.0000
SCORE 25 chosen="]" p=0.0421 argmax=DIFFERENT top: ">" 0.9576 | "]" 0.0421 | "</" 0.0001 | "】" 0.0001 | "\">" 0.0000
SCORE 26 chosen="\n" p=0.9979 argmax=same top: "\n" 0.9979 | "\">" 0.0012 | "\":" 0.0005 | "\n\n" 0.0002 | "\n\n\n" 0.0001
SCORE 27 chosen="</" p=0.2885 argmax=same top: "</" 0.2885 | "old" 0.1203 | "d" 0.0880 | "new" 0.0416 | "Status" 0.0416
SCORE 28 chosen="parameter" p=0.9977 argmax=same top: "parameter" 0.9977 | "invoke" 0.0007 | "user" 0.0001 | "issue" 0.0001 | "old" 0.0001
SCORE 29 chosen=">" p=1.0000 argmax=same top: ">" 1.0000 | ">," 0.0000 | ">:" 0.0000 | "></" 0.0000 | ">=" 0.0000
```

Engine runs of the same edit prompt under different cache histories, and scores of token 25 on fresh states that read the same tokens in different groupings:

```
G1 app sequence: bad-keys token25="]" reused=0,1186,1299 prompts=1172,1272,1430 generated=14,27,63
G1 chain check: turn2 extends turn1+output true, turn3 extends turn2+output true
G2 repeat: correct token25=">" reused=0
G3 fresh prefill: correct token25=">" reused=0
G4 turn2 fresh then turn3: correct token25=">" reused=0,1299 same turn2 output true
G5 prefix by prefill then turn3: correct token25=">" reused=0,1299
G6 fresh prefill all: p(>)=0.9576 p(])=0.0421 logit gap(> minus ])=3.125
G6 app chain (prefill, decode, prefill, decode, prefill): p(>)=0.0373 p(])=0.9623 logit gap(> minus ])=-3.250
G6 prefill to split, then suffix: p(>)=0.9390 p(])=0.0600 logit gap(> minus ])=2.750
G6 prefill turn2 prompt, decode its output, then suffix: p(>)=0.9981 p(])=0.0018 logit gap(> minus ])=6.312
G6 decode every prompt token: p(>)=0.9792 p(])=0.0203 logit gap(> minus ])=3.875
```

Only the app's exact sequence gives the wrong token: the first prompt read in passes, the first reply decoded, the second round's new tokens read after reusing that state, the second reply decoded, and the third round's new tokens read the same way. The repeat found no reusable state, so it read the prompt fresh. Scoring the app's sequence without the engine cache reproduces the flip, so no cache fault is needed to explain it. The difference comes from grouping. The same tokens in other groupings keep `>` well ahead, although the margin itself varies by several units between groupings. These scoring passes use the model's plain arithmetic throughout; inside a request, the engine switches to a reference arithmetic for passes shorter than 256 tokens.

Expert routing and next-token distributions, fresh read against the app's sequence. A layer choice differs when any of its ten experts differs; drift is the relative L2 difference of the logits after each generated token:

```
ROUTES prompt before first split [0, 1172): 2670 of 56256 layer choices differ, at 148 of 1172 positions
ROUTES turn 1 output (decoded in app) [1172, 1186): 360 of 672 layer choices differ, at 14 of 14 positions
ROUTES turn 2 new tokens [1186, 1272): 1838 of 4128 layer choices differ, at 86 of 86 positions
ROUTES turn 2 output (decoded in app) [1272, 1299): 729 of 1296 layer choices differ, at 27 of 27 positions
ROUTES turn 3 new tokens [1299, 1430): 2407 of 6288 layer choices differ, at 131 of 131 positions
ROUTES generated tokens before the flip [1430, 1456): 686 of 1248 layer choices differ, at 26 of 26 positions
DRIFT step 0 rel 0.3546 top1 same p_fresh(chosen)=1.0000 p_app(chosen)=0.9999
DRIFT step 1 rel 0.0861 top1 same p_fresh(chosen)=1.0000 p_app(chosen)=1.0000
DRIFT step 23 rel 0.3214 top1 same p_fresh(chosen)=0.9999 p_app(chosen)=0.9999
DRIFT step 24 rel 0.2849 top1 same p_fresh(chosen)=1.0000 p_app(chosen)=1.0000
DRIFT step 25 rel 0.1863 top1 DIFFERENT p_fresh(chosen)=0.0421 p_app(chosen)=0.9623
DRIFT step 26 rel 0.2683 top1 same p_fresh(chosen)=0.9979 p_app(chosen)=0.9982
```

Positions that both schedules read in identical passes route identically. The 148 prompt positions that one schedule reads in a pass of 256 and the other in a pass of 148 already differ, as do all positions read or decoded differently later. The top choice agreed at every generated position except the flipped one.

Fresh reads of all twelve edit tasks in the diagnostic, with no reused state, all gave a correct first call:

```
E baseline status class=correct malformed=0 prompt=1430 reused=0
E baseline region class=correct malformed=0 prompt=1426 reused=0
E baseline owner class=correct malformed=0 prompt=1426 reused=0
E baseline calm class=correct malformed=0 prompt=1420 reused=0
E baseline retries class=correct malformed=0 prompt=1420 reused=0
E baseline todo class=correct malformed=0 prompt=1432 reused=0
E baseline clinics class=correct malformed=0 prompt=1432 reused=0
E baseline budget class=correct malformed=0 prompt=1444 reused=0
E baseline date class=correct malformed=0 prompt=1434 reused=0
E baseline weekday class=correct malformed=0 prompt=1432 reused=0
E baseline greet class=correct malformed=0 prompt=1427 reused=0
E baseline role class=correct malformed=0 prompt=1426 reused=0
```

The same tasks through the app's cached sequence, starting each from an empty cache. Four tasks were skipped because the model searched first, and the diagnostic serves only listing and reading results:

```
TASK status class=bad-keys reused=1186,1299
TASK region class=correct reused=1193,1306
TASK owner class=correct reused=1190,1303
TASK calm skipped: first call was source.search
TASK retries skipped: first call was source.search
TASK todo class=correct reused=1190,1316
TASK clinics skipped: first call was source.search
TASK budget class=correct reused=1195,1308
TASK date class=correct reused=1197,1322
TASK weekday class=correct reused=1193,1306
TASK greet class=correct reused=1191,1304
TASK role skipped: first call was source.search
CHAINS [(key: "bad-keys", value: 1), (key: "correct", value: 7), (key: "skipped", value: 4)]
```

A last section tested the proposed correction: resume a turn from a cached state that holds only the first multiple of 256 tokens, read fresh, and read the rest in the passes a fresh read uses. The source was then SHA-256 `0d1e1eb48574573cbcc9846b471551c87f5a025d6c85340a9e4b0589efb6d1a8`, and the build, SHA-256 `a741864ff3528aa9265f721a1a7bf1386460466e1ba1062fa449e26ca85a6489`, ran `--edit-canonical`. Each checkpoint was made by dropping the cache and reading the prefix fresh, which costs more than an engine implementation would. The chain line keeps only boundary checkpoints between turns:

```
FRESH turn3 correct prompt=1430 reused=0 generated=53
RESUME turn3 from 256 (boundary): reused=256 correct ids identical to fresh: true prompt identical: true
RESUME turn3 from 512 (boundary): reused=512 correct ids identical to fresh: true prompt identical: true
RESUME turn3 from 1024 (boundary): reused=1024 correct ids identical to fresh: true prompt identical: true
RESUME turn3 from 1280 (boundary): reused=1280 correct ids identical to fresh: true prompt identical: true
RESUME turn3 from 1299 (off boundary): reused=1299 correct ids identical to fresh: true prompt identical: true
BOUNDARY CHAIN reused=1024,1024 turn2 identical to fresh: true turn3 correct identical to fresh: true
```

Every resume produced exactly the tokens of a fresh read, and a correct call. The resume from 1,299 tokens also matched, because that prefix was read, not partly decoded.

Conclusion: the model does not prefer the malformed call. The engine's arithmetic depends on how tokens are grouped into passes and on whether they were read or decoded, and expert routing amplifies those differences. A cached continuation groups a conversation differently from a fresh read, and for this prompt the difference moves one token of call syntax across the decision. The host's correction round edits the system message, which forces a fresh read, and that alone yields a correct call here. Of the other seven tasks that took the same path, none failed. Resuming from pass boundaries removed the dependence on cache history in this conversation. Renaming the fields was not needed: the original names gave correct calls on every fresh read. The fields renamed to `old_text` and `new_text` gave correct calls on the eight tasks run before those runs were stopped.

## Helper mode matrix

Every helper mode against small fixtures, using the release helper and the pinned dbmd. The Excel, EPUB and HTML files come from db.md's format test corpus; the PDF, RTF, Word, image and knowledge base fixtures were generated for this work. Here the self-test probe is an ordinary file in a scratch folder; the suite's own sandbox check places its probe in the per-user temporary folder, beside the helper's work folders. Each line shows at most the first 160 bytes of output:

```
pdf: {"format":"pdf","pages":["Page 1 heading: Cedar pilot notes\nThe budget on page 1 is 100 dollars. Launch date October 12.","Page 2 heading: Cedar pilot notes\nT
rtf: {"format":"rtf","pages":["Hello from RTF with owner Maya."],"textless":[]}
docx: {"format":"docx","pages":["Memo title\nThe owner is Maya. Rollback plan needs review.\n"],"textless":[]}
xlsx: {"format":"xlsx","pages":["Vendor\tCategory\tAmount\nAcme Cloud\tHosting\t1200\nNorthStar\tLogistics\t3450\n"],"textless":[]}
epub: {"format":"epub","pages":["Onboarding\n\nEvery new customer starts with a kickoff call within two business days.\n\nThe operations lead records the call notes a
html: {"format":"html","pages":["Quarterly Operations Summary\n\nThis document summarizes operations for Acme Corp in Q1 2026. It is used as an extraction fixture for
render: SVRF
ocr: {"pages":["Invoice total 482 dollars due October 30"]}
search: records/fact/y.md:8:Project Juniper launches October 12. records/x/concept.md:8:Project Juniper launches October 12. records/x/decision.md:8:Project Juniper lau
query: records/fact/y.md records/facts/m12441.md records/facts/m15940.md records/facts/m937.md records/x/fact.md 
write: records/facts/m8227.md 
selftest: {"connect_loopback":false,"list_folder":false,"read_file":false,"read_home":false,"spawn_process":false,"window_server":false,"write_file":false}
selftest-ocr: {"connect_loopback":false,"list_folder":false,"read_file":false,"read_home":false,"spawn_process":false,"window_server":false,"write_file":false}
```

## App bundle and Xcode project

After the suite, `bash Tools/build_sevra_mac.sh` in the snapshot built `.build/Sevra.app` from the same sources, with the helper hash above, with `Contents/Helpers/sevra-extract` and `Contents/Helpers/dbmd`, and `codesign --verify --deep --strict` accepted the bundle. The bundled helper, signed ad hoc, reported every forbidden operation as denied under both profiles:

```
codesign --verify --deep --strict .build/Sevra.app: ok
Contents/Helpers/sevra-extract selftest --profile strict: {"connect_loopback":false,"list_folder":false,"read_file":false,"read_home":false,"spawn_process":false,"window_server":false,"write_file":false}
Contents/Helpers/sevra-extract selftest --profile ocr: {"connect_loopback":false,"list_folder":false,"read_file":false,"read_home":false,"spawn_process":false,"window_server":false,"write_file":false}
```

Xcode is not installed on this Mac; the active developer directory is the Command Line Tools. So the Xcode project was not built. Its target compiles all ten files in `apps/macos/App`, with none missing and no stale references, and takes the runtime from the package. Its script phase was run outside Xcode with Debug build variables and `DEVELOPER_DIR` set to the Command Line Tools. It built, copied and signed a debug helper whose strict self-test denied every operation.

## Context window planning

`slotstream doctor --memory-gb 10 --mtp off --vision off --max-context N --json` with the installed 0.2.20 CLI, which never loads the model:

| Window | Expected peak (GB) | Expected peak (bytes) | Experts per layer | Pool (GB) | Pool slots | Estimated wait for a full-window prompt (s) |
| --- | --- | --- | --- | --- | --- | --- |
| 8,192 | 9 | 8,999,773,440 | 21 | 2.8 | 1013 | 96.4 |
| 32,768 | 9 | 8,999,496,960 | 20 | 2.7 | 961 | 385.5 |

The wait is the planner's estimate for this target, not a measurement.

## Defects found and fixed during verification

- A draft app could open network connections despite the content rules and the security policy: a peer connection from a child frame, and a TCP connection from a link-click preconnect. WebKit's network feature switches, a refusing proxy and the bridge in every frame now stop them, and the host refuses to run an app unless WebKit reads back peer connections, link preconnects and DNS prefetching as off. The hostile page then produced no loopback connection and no datagram.
- An open app heard its own saves as changes from elsewhere. An app that reloads and saves on every change event could then create records without end, and the counter app from the first real-model run did exactly that. Open apps and previews now hear only about changes they did not make, and the app guidance says so.
- Nothing limited how often an app could write. Each app now has a write budget of 120 requests that refills at two per second, and invalid requests spend it too.
- The app guidance did not say that Sevra assigns record ids. The model's counter app looked for an id it had chosen and created a new record each time. The guidance now says so and describes how to keep a single value.
- After a restart, a run waiting for review blocked attaching the folder it needed. Only working runs block attachment changes now.
- The knowledge helper waited for input it never received. It reads input only when a record body is passed.
- A helper killed mid-request left its work folder behind. Later helpers remove such folders after 15 minutes.
- Model-facing tool results escaped the slashes in paths. They now keep plain slashes, while stored Home bytes stay unchanged.
- A record edited while earlier records in the same set were written would have been overwritten, because dbmd has no compare-and-set. Each record's base is checked again just before dbmd writes it.
- The helper memory limit ignored a dbmd process the helper starts. The whole process group is measured now.
- The app review said an app cannot reach other apps, while collections are shared by name across apps. The review now counts records already saved in each requested collection and says that apps using a collection share its records.
- Single-suite check modes signaled completion before removing their temporary folder, so each run could leave files behind. The signal now follows cleanup.
- The Mac guide said a skill never grants access to tools, while a skill that declares apps offers the app proposal tools. The guide now says a skill never grants access to files and that its proposals still wait for review.

## Not run and limits

- Each real-model run is one pass over three synthetic jobs. It shows that the path works end to end, not how often it does.
- The engine's results depend on how a conversation's tokens were grouped across cached turns, so the same prompt can give different answers with and without the prompt cache. The check's edit prompt fails only on the cached path, and the host's one correction costs a full prompt re-read. Resuming each turn from the last 256-token pass boundary, with the rest read in the passes a fresh read uses, reproduced a fresh read exactly in an emulation on this conversation. The engine does not resume that way yet.
- No VoiceOver pass and no person's review of the new panels in the live app.
- The app and helper are signed ad hoc. App Sandbox, Developer ID signing and notarization remain open.
- The WebKit network switches are private preference interfaces and must be rechecked on each macOS release. A WebKit that drops them stops apps from running until Sevra is updated.
- Helper residuals: metadata reads stay global, and the dbmd modes can list the folders above their work folder and an attached store.
- A narrow window remains between the record re-check and dbmd's own write.
- The new limits are development operating bounds, not measured optima.
