---
type: run
id: 01m5gtra5x3h7bq3s714tn2dng
created: 2026-10-22T03:33:55.005205+00:00
updated: 2026-10-22T03:35:09.014289+00:00
summary: Native Home data browser, global CLI, bundled skills and MCP integration verification
binary: apps/macos release products and .build/Slotstream.app
captured_at: 2026-10-22
command: Tools/check_slotstream_mac.sh; Tools/check_slotstream_home_ui.sh; Tools/build_slotstream_mac.sh; installed CLI and MCP checks
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Home data and local integrations verification
tool: native Mac checks, Home CLI, MCP SDK and packaged app
---
# Home data and integration verification

Captured October 21 local time, October 22 UTC, on the registered development Mac.
This records a local development implementation, with ad-hoc bundle signing.

## Scope and retained corrections

The native Mac regression run completed every functional suite successfully.
Its final source-identity guard refused the aggregate run because the PATH
executable-location correction was made during verification. That refusal is
retained below. The final Data UI was subsequently rebuilt and rechecked; the
final bundle build verified unchanged inputs across compilation, signatures,
and the source-identity guard. Hosted full-suite verification is pending at
capture time. No public release is claimed.

Earlier fixtures used db.md's source-routed `note` type for record-list tests,
tried a document proposal without an authorized attached source, and used an
offscreen NSTableView mouse-tracking loop that exited before assertions finished.
The final fixtures use project-note records, an attached source and read/citation
before the review proposal, plus native-table selection. The shell now requires
the terminal success marker. The installed app was separately tested through a
real native row click. These were test corrections, not reasons to weaken app
review or store isolation. A real product defect in argv[0]-based bundle lookup
was fixed with the operating system's executable path and a PATH regression.

## Functional suite output

```text
PASS: local package products, Xcode app target and module have distinct identities
PASS: changed dependencies invalidate native objects; stable inputs and dependency caches survive
PASS: External adoption refreshes clean drafts and preserves competing unsaved text
PASS: Continue in thread saves Home before creation and rejects overlapping clicks
PASS: Continue in thread cannot create a destination when saving Home fails
PASS: old stale-snapshot sequence reproduces a rejected draft
PASS: back-to-back saves use acknowledged revisions without any display refresh
PASS: overlapping save callers coalesce edits and never write concurrently
PASS: undo to the previous saved text during an in-flight write persists the undo
PASS: debounce saves only the newest edit and cancels pending work after Send
PASS: typing that never pauses still saves about once per wait, never back to back
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
PASS: 26 composer scenarios plus real-runtime persistence checks
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse, limits, message annotations and streaming replacement bounds
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
PASS: a long page opens at its latest text
PASS: the middle of a long page is laid out without the text above it
PASS: a reader's line holds while the rest of a long page is laid out
PASS: a reader stays on their line when the window narrows
PASS: production native transcript scroll lifecycle
PASS: Home composer shows the Think longer switch
PASS: Home hint stays plain while thinking is off
PASS: capability help label is clickable
PASS: capability help actually opens and states unavailable features
PASS: expanded capability help label is clickable
PASS: capability help closes again
PASS: a new thread starts with Think longer off
PASS: Think longer is clickable
PASS: the thread remembers the switch
PASS: the hint explains the switch while it is on
PASS: Send is clickable
PASS: run status shows Thinking with a clock: Thinking… 0:01
PASS: Thinking status and Answer now are visible while the thought runs
PASS: the collapsed notes box is gone
PASS: the last lines of the thought are visible while it runs
PASS: the preview keeps to a few lines: 45 points
PASS: clicking the preview opens the response's details
PASS: the details show the streaming working notes
PASS: the working notes state their privacy
PASS: a long thought stays within the preview's few lines: 45 points
PASS: Answer now is clickable
PASS: the run records an Answer now receipt: Thought for 6 s, then answered when you asked.
PASS: the answer arrived after Answer now
PASS: the run recorded its numbers
PASS: the reply shows how long Slotstream thought, above the answer
PASS: Answer now is gone and no speed line shows while details are off
PASS: the composer hint now quotes a typical thinking time
PASS: the thinking line is clickable
PASS: the details state how thinking ended
PASS: the details show the recorded speed
PASS: the working notes remain while Slotstream is open
PASS: turning details on adds the speed line under the reply
PASS: the speed line is clickable
PASS: the speed line opens the full numbers
PASS: dark appearance keeps both lines readable
PASS: the thinking line is clickable in dark appearance
PASS: the details render in dark appearance
PASS: Think longer is clickable again
PASS: clicking again turns thinking off and restores the plain hint (thinking=nil)
PASS: Send is clickable for a plain reply
PASS: the status shows the live writing speed
PASS: the plain run has numbers and no thought
PASS: turning details off removes the speed lines and keeps the thinking line
PASS: thinking controls render and respond in the production Mac views
PASS: the page made no network connection (attempts seen: [])
PASS: WebKit reports peer connections, link preconnects and DNS prefetching off (["LinkDNSPrefetchEnabled": true, "PeerConnectionEnabled": true, "LinkPreconnect": true])
PASS: fetch is blocked
PASS: fetchSelf is blocked
PASS: xhr is blocked
PASS: websocket is blocked
PASS: eventsource is blocked
PASS: peer connections are unavailable
PASS: no peer connection sent a datagram (0 seen; fresh frame: unavailable, srcdoc frame: undefined)
PASS: the page cannot open windows
PASS: an undeclared collection is refused
PASS: the page cannot replace the Slotstream API
PASS: info reports only the declared collection
PASS: navigation away is refused (at slotstream-app://app/index.html)
PASS: the page hears changes to its own collection only
PASS: saved apps retain the same scoped API and change notifications
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
PASS: light-automatic, rendered controls, current budget, supported range and pending state
PASS: light-unloaded-automatic, rendered controls, current budget, supported range and pending state
PASS: light-custom, rendered controls, current budget, supported range and pending state
PASS: light-saved-fractional, rendered controls, current budget, supported range and pending state
PASS: light-saved-above-range, rendered controls, current budget, supported range and pending state
PASS: light-saved-below-range, rendered controls, current budget, supported range and pending state
PASS: light-unavailable-range, rendered controls, current budget, supported range and pending state
PASS: light-failed-settings, rendered controls, current budget, supported range and pending state
PASS: light-failed-activation, rendered controls, current budget, supported range and pending state
PASS: light-corrupt-activation, rendered controls, current budget, supported range and pending state
PASS: light-corrupt-pending-settings, rendered controls, current budget, supported range and pending state
PASS: light-fixed, rendered controls, current budget, supported range and pending state
PASS: light-unavailable-pack, rendered controls, current budget, supported range and pending state
PASS: light-setup-reviewed, reviewed pack, complete installation and file-versus-load status remain readable
PASS: light-setup-stale, reviewed pack, complete installation and file-versus-load status remain readable
PASS: light-setup-verified, reviewed pack, complete installation and file-versus-load status remain readable
PASS: light-setup-unavailable, reviewed pack, complete installation and file-versus-load status remain readable
PASS: light-response-budget, reduced budget and saved ceiling remain readable
PASS: dark-automatic, rendered controls, current budget, supported range and pending state
PASS: dark-unloaded-automatic, rendered controls, current budget, supported range and pending state
PASS: dark-custom, rendered controls, current budget, supported range and pending state
PASS: dark-saved-fractional, rendered controls, current budget, supported range and pending state
PASS: dark-saved-above-range, rendered controls, current budget, supported range and pending state
PASS: dark-saved-below-range, rendered controls, current budget, supported range and pending state
PASS: dark-unavailable-range, rendered controls, current budget, supported range and pending state
PASS: dark-failed-settings, rendered controls, current budget, supported range and pending state
PASS: dark-failed-activation, rendered controls, current budget, supported range and pending state
PASS: dark-corrupt-activation, rendered controls, current budget, supported range and pending state
PASS: dark-corrupt-pending-settings, rendered controls, current budget, supported range and pending state
PASS: dark-fixed, rendered controls, current budget, supported range and pending state
PASS: dark-unavailable-pack, rendered controls, current budget, supported range and pending state
PASS: dark-setup-reviewed, reviewed pack, complete installation and file-versus-load status remain readable
PASS: dark-setup-stale, reviewed pack, complete installation and file-versus-load status remain readable
PASS: dark-setup-verified, reviewed pack, complete installation and file-versus-load status remain readable
PASS: dark-setup-unavailable, reviewed pack, complete installation and file-versus-load status remain readable
PASS: dark-response-budget, reduced budget and saved ceiling remain readable
PASS: system-automatic, rendered controls, current budget, supported range and pending state
PASS: system-unloaded-automatic, rendered controls, current budget, supported range and pending state
PASS: system-custom, rendered controls, current budget, supported range and pending state
PASS: system-saved-fractional, rendered controls, current budget, supported range and pending state
PASS: system-saved-above-range, rendered controls, current budget, supported range and pending state
PASS: system-saved-below-range, rendered controls, current budget, supported range and pending state
PASS: system-unavailable-range, rendered controls, current budget, supported range and pending state
PASS: system-failed-settings, rendered controls, current budget, supported range and pending state
PASS: system-failed-activation, rendered controls, current budget, supported range and pending state
PASS: system-corrupt-activation, rendered controls, current budget, supported range and pending state
PASS: system-corrupt-pending-settings, rendered controls, current budget, supported range and pending state
PASS: system-fixed, rendered controls, current budget, supported range and pending state
PASS: system-unavailable-pack, rendered controls, current budget, supported range and pending state
PASS: system-setup-reviewed, reviewed pack, complete installation and file-versus-load status remain readable
PASS: system-setup-stale, reviewed pack, complete installation and file-versus-load status remain readable
PASS: system-setup-verified, reviewed pack, complete installation and file-versus-load status remain readable
PASS: system-setup-unavailable, reviewed pack, complete installation and file-versus-load status remain readable
PASS: system-response-budget, reduced budget and saved ceiling remain readable
PASS: renamed bundle retains selected Home and preferences once; existing defaults remain discoverable
PASS: initial Home opens
PASS: create and switch to a separate Home
PASS: new Home has no previous Home drafts
PASS: Homes have separate identities
PASS: closed runtime rejects stale writes
PASS: return to prior Home while old runtime is still retained
PASS: conversation draft restored exactly
PASS: journal draft restored exactly
PASS: last selected Home persists for next launch
PASS: explicit development Home does not replace saved startup Home
PASS: missing recent Home is refused
PASS: missing Home is not silently recreated
PASS: new Home refuses a nonempty folder
PASS: existing unrelated files preserved
PASS: nested Homes refused
PASS: symbolic-link Home refused
PASS: Home owned by another session is refused
PASS: failed open leaves the current Home usable
PASS: draft conflict blocks switching
PASS: conflicting draft remains visible in old Home
PASS: cancel preserves Incognito and current Home
PASS: cancel does not erase Incognito
PASS: confirmed switch closes Incognito
PASS: second Home retains only its own draft
PASS: switch back after private session
PASS: Incognito does not survive reopening
PASS: cancel keeps active Home
PASS: confirmed switch stops active work before handoff
PASS: old work is terminal before next Home is shown
PASS: chooser renders current and recent Homes with create/open actions
PASS: clicking the rendered recent Home switches the actual session
PASS: Home switcher is visible in production sidebar
PASS: Home menu remains reachable with collapsed navigation
PASS: seed real data: {"type":"project-note","written":"records/notes/workshop.md"}
PASS: seed real data: {"type":"project-note","written":"records/notes/reading.md"}
PASS: native browser loads the current Home's real records
PASS: organized data list and connections render
PASS: rendered record maps to a native table row
PASS: native table selection opens exact saved content
PASS: selected content is visible
PASS: compact data view preserves a back action and detail
PASS: native search narrows saved content
PASS: native no-match query is empty
PASS: schemas render as organized fields
PASS: connection setup is visible with CLI, skill and MCP controls
PASS: final Home closes cleanly
PASS: PATH invocation resolves the real executable for portable MCP configuration
PASS: filtering, literal search, sorting, complete pagination, schema, backlinks and byte-preserving offline reads
PASS: stale pages, bounds, traversal, symlinks, missing Homes and cross-Home isolation
PASS: concurrent Home registration and stable explicit selection
PASS: real MCP initialization, discovery, calls, error handling, read-only scope and session Home binding
PASS: live owner attachment, CLI ask and nonce reconciliation, MCP observations, Incognito exclusion and offline reopen
HOME INTEGRATION CHECKS PASS
PASS: bundled command and skill installers, custom-file preservation and MCP configuration
PASS: literal JSON table results, Markdown-looking text, Unicode and exact interrupted-save recovery through real dbmd
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
PASS: source Unicode boundaries and skipped symbolic links
PASS: model verification hash parity and mid-read cancellation without model allocation
PASS: complete filtered/grouped decimal table calculations, quoted Unicode/CSV cells, provenance, sample disclosure, malformed/oversize/precision refusals and cancellation
PASS: malformed names/types and unavailable tools correct within the existing boundary; staged edits survive without unreviewed writes
PASS: omitted history retrieval, exact source receipts, saved-memory lookup, forgotten-source suppression and cross-thread isolation
PASS: bounded recall pagination, honest incomplete pages and Incognito refusal
PASS: coherent Home backup, complete manifest, exact drafts, pending review, inert restore, explicit activation, monotonic Forget, unknown epochs, corruption/missing/symlink/path/collision/closure refusal and create-only publication
PASS: external draft inspection, exact review race refusal, preserved versions, revision adoption, restart review, no implicit inference, malformed record refusal and normal work after reconciliation
PASS: long Home recent windows, exact retained history, inspectable partial excerpts, matching-memory ranking, bounded full-memory text, suppression lineage and thread-only read/write scope
PASS: Home promotion selection, visible quotations, exact model context, idempotence, drafts, permissions, scope, restart, Forget, active-run refusal and external edits
PASS: loaded profile generation, allocation, preferences and operating conditions govern speed evidence
PASS: manifest-bound session verification, same-size corruption, restored mtime, repair, optional arrival, replacement, symlink, cancellation and verification mutation; cached=true
PASS: durable accepted versions, offline restart, exact setup ownership and nonmutating offers
PASS: durable activation phases, exclusive ownership, stale callbacks, interrupted writes, rollback, bounded state, explicit preserved-record repair and weights-free retry
PASS: memory plans 89 accepted / 211 safely refused; custom ceilings, unavailable readings, persistence, stable ranges and idle/pressure policy
PASS: deferred budget coalescing, queued submission during handoff, active release refusal, idle release and draft preservation
PASS: accepted setup remains inside maintenance and forces the next configuration boundary
PASS: sleep cancellation, queued interruption, unload, admission guard, wake without replay and explicit recovery
PASS: context overflow preserves messages and refuses instead of silently trimming history
PASS: clicks apply at once, saves merge in the background, a saved draft waits for disk, nothing is lost (2 saves)
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget
PASS: thinking off by default, sticky switch, live thought, receipt, answer now, tool turns think within their budget, restart, no thought on disk
PASS: incognito thought stays in memory and leaves with its thread; local endpoint thinking intents
PASS: response numbers add up across rounds, the reply line and copied details state them, receipts merge, the thought preview flows
PASS: a thinking job records exact per-round numbers, a refused round counts, thoughts keep one step per round, numbers persist without text, older runs still decode, live speed while thinking and writing, notes for the eight most recent runs
PASS: document helper sandbox denies file reads, folder listing, writes, loopback network, process launch, window server and home access; its memory limit counts the whole process group
PASS: multi-source attach, hidden and dependency folders skipped, PDF pages, word search fallback, image and scan recognition, RTF, Word, locked/damaged/oversized refusals, detach
PASS: tool groups follow access; cancelled document reading stops its helper
PASS: documented limits: eight attachments, 8 MB text files, 64 MB documents, 40 recognized pages per request, live folder navigation
PASS: tool-round narration stays out of answers and leads its activity
PASS: the model is told which files are attached, so "what is this?" has a referent
PASS: a refused proposal is corrected once, and a job that keeps being refused still stops
PASS: change tools follow access, read-before-edit, exact diff review, digest-bound approval, exact writes preserving mode and tags, undo with Trash recovery
PASS: external edits win, discard, hard-link refusal, symbolic-link swap refusal, review across restart with re-attached folder, Incognito read-only
PASS: process death while writing is reported after restart, never replayed, and undoable
PASS: knowledge base search and query, record-only tools, protected frontmatter/contract/paths, db.md writes, index and validation, undo with index rebuild, mid-write record edits kept
PASS: /skill proposal, reserved names, exact publication, /name use, no implied tools, tamper refusal, deactivation, restart
PASS: app review, exact publication, grants, host document, create/get/update/archive/restore, revision conflicts, scope and version refusals, malformed and nested data, db.md validation
PASS: app revision with shared data, version switching, tamper refusal, removal keeps data, Incognito, restart, write budget, inert restore, outside-edit pause
PASS: immediate folder grant, directory browsing, live creation/edit/rename/deletion, direct reads, stale-edit refusal
PASS: root confinement, hidden files, symlink boundaries, scoped dependency traversal, file-only grants, multi-source identity and detach
PASS: large folder acceptance, gap-free listing and search, changed-directory refusal, cancellation and descriptor cleanup
PASS: within-file pagination, UTF-8 offsets, query binding, content mutation and explicit word matching
PASS: global stream ceiling, honest cursor eviction and complete restart
PASS: explicit depth coverage, direct deep navigation, accurate capability context and owner tool-loop integration
PASS: bundled command and skill installers, custom-file preservation and MCP configuration
PASS: loaded profile generation, allocation, preferences and operating conditions govern speed evidence
PASS: manifest-bound session verification, same-size corruption, restored mtime, repair, optional arrival, replacement, symlink, cancellation and verification mutation; cached=true
PASS: durable accepted versions, offline restart, exact setup ownership and nonmutating offers
PASS: durable activation phases, exclusive ownership, stale callbacks, interrupted writes, rollback, bounded state, explicit preserved-record repair and weights-free retry
PASS: memory plans 89 accepted / 211 safely refused; custom ceilings, unavailable readings, persistence, stable ranges and idle/pressure policy
PASS: deferred budget coalescing, queued submission during handoff, active release refusal, idle release and draft preservation
PASS: accepted setup remains inside maintenance and forces the next configuration boundary
PASS: sleep cancellation, queued interruption, unload, admission guard, wake without replay and explicit recovery
PASS: context overflow preserves messages and refuses instead of silently trimming history
swift-driver version: 1.148.6 Native inputs changed during verification. Repeat with stable sources.
FAILED SUITE: python3 Tools/prepare_slotstream_build.py --configuration release --check
```

## Final native Data view checks

Command: `bash Tools/check_slotstream_home_ui.sh`, exit 0.

```text
PASS: renamed bundle retains selected Home and preferences once; existing defaults remain discoverable
PASS: initial Home opens
PASS: create and switch to a separate Home
PASS: new Home has no previous Home drafts
PASS: Homes have separate identities
PASS: closed runtime rejects stale writes
PASS: return to prior Home while old runtime is still retained
PASS: conversation draft restored exactly
PASS: journal draft restored exactly
PASS: last selected Home persists for next launch
PASS: explicit development Home does not replace saved startup Home
PASS: missing recent Home is refused
PASS: missing Home is not silently recreated
PASS: new Home refuses a nonempty folder
PASS: existing unrelated files preserved
PASS: nested Homes refused
PASS: symbolic-link Home refused
PASS: Home owned by another session is refused
PASS: failed open leaves the current Home usable
PASS: draft conflict blocks switching
PASS: conflicting draft remains visible in old Home
PASS: cancel preserves Incognito and current Home
PASS: cancel does not erase Incognito
PASS: confirmed switch closes Incognito
PASS: second Home retains only its own draft
PASS: switch back after private session
PASS: Incognito does not survive reopening
PASS: cancel keeps active Home
PASS: confirmed switch stops active work before handoff
PASS: old work is terminal before next Home is shown
PASS: chooser renders current and recent Homes with create/open actions
PASS: clicking the rendered recent Home switches the actual session
PASS: Home switcher is visible in production sidebar
PASS: Home menu remains reachable with collapsed navigation
PASS: seed real data: {"type":"project-note","written":"records/notes/workshop.md"}
PASS: seed real data: {"type":"project-note","written":"records/notes/reading.md"}
PASS: native browser loads the current Home's real records
PASS: organized data list and connections render
PASS: rendered record maps to a native table row
PASS: native table selection opens exact saved content
PASS: selected content is visible
PASS: compact data view preserves a back action and detail
PASS: native search narrows saved content
PASS: native no-match query is empty
PASS: schemas render as organized fields
PASS: database log has an explicit native empty state
PASS: connection setup is visible with CLI, skill and MCP controls
PASS: final Home closes cleanly
Home switching and native UI checks passed.
```

## Real local-model request

The external CLI attached to a real native runtime owner and its authenticated
local endpoint, with production LocalInference, a 10 GB test target, an attached
workshop.txt fixture, and the installed local weights. No second model process
was running at launch; reclaimable memory exceeded the target plus headroom.
The owner was closed immediately after the test. This is one functional smoke
check, not a general model-quality or performance qualification.

```json
{
  "result": "PASS: real local-model Home CLI question",
  "prompt": "Read the attached workshop.txt. What day is the workshop and what should I bring? Reply in one sentence with a citation.",
  "answer": "The workshop is on Friday, and you should bring the prototype [S1].",
  "tools": [
    "document",
    "read"
  ],
  "state": "completed"
}
```

## Packaged app and installed integrations

Command: `bash Tools/build_slotstream_mac.sh`, exit 0.
`codesign --verify --deep --strict .build/Slotstream.app`, exit 0.
`python3 Tools/prepare_slotstream_build.py --configuration release --check`, exit 0.

The packaged app opened a disposable Integration Home. The native Data button,
real record-row click, Fields disclosure and Connections sheet worked. The
Connections installer returned the global CLI path. Command-Q closed the app
cleanly. The same installed command read data while the native app owned its
Home, and the standard MCP client read it after the app closed. The default
Home registry was not changed by the explicit development Home.

```text
PASS: installed PATH command, bundled dbmd, live packaged-app Home, record detail, exact MCP executable and both installed skills
PASS: native UI click opened Workshop plan and displayed exact source text; Fields disclosure and Connections visible
```

Official Python MCP SDK 2.3.0, installed CLI and bundled dbmd:

```json
{
  "protocol": "2025-06-18",
  "tools": [
    "home_info",
    "data_list",
    "data_show",
    "data_schema",
    "data_log"
  ],
  "records": 1,
  "result": "PASS: official Python MCP client discovery and data read"
}
```

Both installed Codex and Claude Code skill copies exactly matched the bundled
source. The skill-creator quick validator, package identity check, Xcode project
property-list parse and shell syntax checks passed. Client MCP settings were
not overwritten. The server is stdio, with read-only tools by default and no
HTTP listener. SQL is outside this implementation.

## Final bundle identity

```json
{
  ".build/Slotstream.app/Contents/MacOS/Slotstream": "867b2da4e718d8a1274e9b4cff5266b6f5011dccfa92291003aeda2786d4e3ba",
  ".build/Slotstream.app/Contents/Helpers/slotstream-home": "984e32d3b891da53f6ce3d5ad7cd1820eb7642c5ce2174ff2069e692ad075771",
  ".build/Slotstream.app/Contents/Helpers/dbmd": "d831bfcb6f700e2f60dc80852b33ae504496f157992254fa92dab2de0027c46b",
  ".build/Slotstream.app/Contents/Resources/Skills/slotstream-home/SKILL.md": "f42004bb25df414fe0eb3d243ccd2e047bbf04a9a7519ae6929c8d1ee41eaab8",
  ".build/Slotstream.app/Contents/Resources/build-inputs.json": "212e384b858d76568e1c4bf1a441f29d7259f1a6e82ad712b197ff0c7ff6bf4c"
}
```
