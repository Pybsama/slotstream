---
type: run
created: 2026-09-15T16:01:01.546090+00:00
updated: 2026-09-15T16:01:01.550333+00:00
summary: Adversarial fixes with real model replay, native recovery, bounded context, passing regressions and verified development bundle
binary: 25a135dff6780be35daa5a66f7d61e37bd2316dfed1f3d82ef35abed9b381d6d
captured_at: 2026-09-15
command: bash Tools/check_sevra_mac.sh; sevra-mac-checks --real with frozen Cedar fixture; isolated native UI walkthrough
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra Mac adversarial fixes and native recovery
tool: Swift build, production composer/runtime checks, dbmd, real local model, native AppKit UI and codesign
---
# Adversarial corrections and follow-up verification

This is a development-app verification receipt, not a claim of bug freedom, a supported public release or completion of the entire Mac plan. Earlier failures remain in [[sources/runs/2026/09/2026-09-15-sevra-mac-adversarial-review]]. This receipt supersedes its pending real-model replay and blocked native-refinement status.

The complete final scripted suite passed. The final real Cedar workflow also passed the unchanged rubric, exact approval and reopened-file checks. It reproduced the `artifact=propose` mistake, rejected that response without execution, accepted the corrected `artifact.propose`, and saved exactly the approved content. The correction must be appended to the leading system instruction because the pinned model template refuses a later system-role message. Both the initial template failure and successful replay are retained below.

## Corrections and bounded scope

- Native Find closes before panel dismissal and returns focus to the searched document. The final positive toolbar spacer also removes the startup zero-size warning; the final sampled app logs are empty.
- Home backups use bounded ordinary-file manifests, full file hashes, private staging, physical macOS destination paths and create-only publication. Device control files, source grants, caches and Incognito do not ride. Original attached files remain explicit external dependencies. Unknown hidden assets are refused rather than silently omitted.
- Restore verifies the complete declared closure and official dbmd validation before publication. It cannot replace a destination or nest inside its own backup. The exact legacy Home template missing `owner` is upgraded only inside private restore staging. New templates contain the required field. Restored AI is paused until a dated snapshot review; known newer Forget decisions merge monotonically. Unknown later privacy choices are disclosed.
- External edits to valid bounded draft records can be inspected and explicitly adopted, including after restart. Review binds exact hashes and preserves the external file plus the previously acknowledged draft when available. A competing unsaved composer keeps its existing two-version choice. Conversation evidence, missing files, malformed drafts and unsupported owned-state changes remain refused. No conflict record enters AI context.
- Long conversations retain full history and use a bounded window of complete exchanges, partial earlier excerpts and deterministic memory selection. The context inspector exposes included messages, eligible memories and omission information. Forget suppresses exact source IDs and derived excerpts. New Thread only records may read shared memories while retaining local writes; older strict records require explicit opt-in. Continuation preserves that reading choice.

## Native observations

Synthetic Homes and public fixtures only. UI actions used the native application, not injected view state.

1. Archived filter followed by New Thread displayed the new open thread. A pending review in another thread did not relabel Home Send as Queue. Reject removed the pending review without saving its proposal.
2. A retained saved document opened from Documents. Native Find searched its text. Escape removed Find and focused `artifact-document`; a second Escape closed the panel and preserved the conversation draft.
3. An externally edited Unicode draft was detected after restart. Inspect Home changes showed the exact external text. Adoption cleared the warning and retained the draft; the final coordinator also preserves competing unsaved local text. Draft conflict records are local evidence, not memory.
4. Back up Home used the native save picker. The initial macOS alias failure was reproduced, fixed and added to regression checks. The final UI reported successful backup and exposed Reveal backup. Selecting an ordinary non-backup folder was refused. A later successful restore now clears that old error.
5. The verified backup restored to a separate Home. The older template passed its explicit compatibility migration and official dbmd validation. Opening the copy showed AI paused, with Attach and Send disabled. Keep reviewing retained the pause. Explicit activation removed the pause without starting a job, attaching a source or saving an artifact.
6. The final real-run Home reopened in the native app. Context showed the exact initial request inside Messages included and distinguished later tool reads. Model-file Check/Stop ended at `Setup paused` and `Stopped. No further actions will run.`, without a global error banner.
7. Light and Dark screenshots showed the backup controls, status and brand without clipping. System and default reading/sidebar sizes were restored. The final packaged app was verified again after the positive toolbar sizing and context-disclosure refinements.

Native backup manifest SHA256: `35f2ca41b6b734729610b1cc95ddd7bde0bf132606804cd90a33fd502fb10409`.

## Packaging and source identity

The app/runtime checks used the isolated source snapshot at `.build/adversarial-snapshot/slotstream`. Original dependency revisions remain pinned. The independent root engine was being edited during this work; root engine changes were not silently folded into these receipts. All current Mac App/Presentation/Runtime/Checks/ComposerChecks source bytes match the tested snapshot. The final UI-only refinements were rebuilt and checked natively after the complete scripted suite; the runtime and model check identity did not change.

The tested development executable and manifest were installed in `.build/Sevra.app`, retaining its usual application identity and resources. Its ad-hoc signature verifies. The previous bundle is retained locally as a rollback copy. The existing Home reopened successfully with its canonical records unchanged. No private Home content is included in this public receipt. No model test or audit app was left running, and no release, commit, push, cloud work or analytics integration was performed.

## Remaining qualification

Large Home load/backup scale, physical power loss and broad cross-hardware behavior remain open. Deterministic lexical memory retrieval is not qualified semantic recall. The engine token bound can still refuse an oversized request or source-heavy tool round. Arbitrary external changes to runtime-owned evidence are not reconciled as ordinary data edits. Rich extraction containment, skills/mini-app lifecycle, complete interoperability/CLI/event surfaces, full VoiceOver/IME and sustained native interaction, signed distribution/notarization/updater/rollback and clean-machine/external-user qualification remain separate unfinished plan work.

## Captured raw output and identities

### First real replay: late-system template failure

Capture SHA256: `16d71474b85233377de52e5aec00ad52d552b2308a213b2e9f60ab0c5b706a88`.

~~~~text
Verifying the local model
Loading the local model
engine ready in 1.4s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
Reading context: 0 of 780 tokens
Reading context: 256 of 780 tokens
Reading context: 512 of 780 tokens
Reading context: 768 of 780 tokens
Responding
Reading context: 808 of 873 tokens
Responding
Reading context: 936 of 1317 tokens
Reading context: 1192 of 1317 tokens
Responding
The operation couldn’t be completed. (Jinja.TemplateException error 1.)
Real workflow did not reach review: The operation couldn’t be completed. (Jinja.TemplateException error 1.)

~~~~

### Successful leading-system correction replay

Capture SHA256: `84990896868b216b25a1276f309c54dec2b0e8f4960b20fef4c7a4bd588291ea`.

~~~~text
Verifying the local model
Loading the local model
engine ready in 1.0s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
Reading context: 0 of 780 tokens
Reading context: 256 of 780 tokens
Reading context: 512 of 780 tokens
Reading context: 768 of 780 tokens
Responding
Reading context: 808 of 873 tokens
Responding
Reading the conversation
Reading context: 936 of 1317 tokens
Reading context: 1192 of 1317 tokens
Responding
Reading context: 0 of 1401 tokens
Reading context: 256 of 1401 tokens
Reading context: 512 of 1401 tokens
Reading context: 768 of 1401 tokens
Reading context: 1024 of 1401 tokens
Reading context: 1280 of 1401 tokens
Responding
Review the document before saving
{
  "artifact_exists_before_approval" : false,
  "citations" : [
    {
      "excerpt" : "# Pilot decision\n\nSynthetic source for the Sevra native application acceptance workflow.\n\nThe team will invite five testers after keyboard testing and the rollback\nrehearsal pass. The pilot is local-only. No account or remote service is needed.\nSuccess means each tester can create a briefing, inspect its sources and\nreopen the saved document without help.\n",
      "id" : "S1",
      "length" : 358,
      "path" : "decision.md",
      "source_sha256" : "74800c822c7e261975707d95aff71a03e890fca90b94683e4d4241cbd3ef6a77",
      "start" : 0
    },
    {
      "excerpt" : "# Cedar release notes\n\nSynthetic source for the Sevra native application acceptance workflow.\n\nThe Cedar pilot starts on October 12. Maya owns the documentation. Leo owns\nthe installer. The pilot budget is 400 dollars. The team must finish keyboard\ntesting before inviting testers. The current open risk is an interrupted\ninstaller update. A rollback rehearsal is scheduled before the pilot.\n",
      "id" : "S2",
      "length" : 392,
      "path" : "launch-notes.md",
      "source_sha256" : "fa60942aa782c8aff47fb0e6a8c7a2012817889c39e693b39a58ac54fdf65f58",
      "start" : 0
    }
  ],
  "content" : "# Cedar Pilot Briefing\n\n**Launch date:** October 12 [S2].\n\n**Owners:** Maya — documentation; Leo — installer [S2].\n\n**Budget:** $400 [S2].\n\n**Prerequisites:** Keyboard testing must be completed before inviting testers [S2], and the rollback rehearsal must pass before the five testers are invited [S1]. The pilot is local-only, requiring no account or remote service [S1].\n\n**Main risk:** An interrupted installer update [S2]. A rollback rehearsal is scheduled before the pilot to mitigate this [S2].\n\n**Success criteria:** Each tester can create a briefing, inspect its sources, and reopen the saved document unaided [S1].",
  "phase" : "needsYou",
  "prompt" : "Read both Cedar pilot documents in the attached folder. Use your source tools, then propose cedar-briefing.md with a short cited briefing: launch date, owners, budget, prerequisites and main risk. Keep it under 150 words.",
  "proposal_digest" : "7208e9497c209152352b0406d084543f8366c942fbf358015f0c48a390a96709",
  "run_id" : "2a272ab2-89ab-4d05-befa-c2a279bb0fd2",
  "trace" : [
    "source.list: returned bounded source data",
    "source.read: returned bounded source data",
    "source.read: returned bounded source data",
    "The model used \"artifact=propose\" instead of artifact.propose. No calls from that response were executed. Requested one corrected response.",
    "artifact.propose: awaiting exact-content approval"
  ]
}
PASS: real local model, typed source loop, frozen Cedar rubric, exact reviewed commit and reopened durable Home
artifact_sha256=7d66e65315fa81dfe4906f07192bad312dada897be85a3c74618c4778be08431

~~~~

### Backup validation found missing owner

Capture SHA256: `9eb906e0c1ff955753dbbb3ee846c79cbfce9d65245815a3cefeed080c2a99f9`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/4] Write sources
[2/4] Write swift-version--1AB21518FC5DEDBE.txt
[4/5] Compiling SevraRuntime ConversationContext.swift
[5/6] Compiling SevraMacChecks AdverseChecks.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (14.29s)
db.md could not complete the operation: {
  "issues": [
    {
      "code": "DB_MD_MISSING_FIELD",
      "file": "DB.md",
      "key": "owner",
      "line": 1,
      "message": "DB.md frontmatter is missing required field `owner`",
      "related": [],
      "severity": "error",
      "suggestion": "add `owner:` to the DB.md frontmatter"
    }
  ],
  "scope": "all",
  "store": ".",
  "summary": {
    "errors": 1,
    "info": 0,
    "total": 1,
    "warnings": 0
  }
}
{"error":{"code":"VALIDATION_FAILED","message":"validation found 1 error"}}


~~~~

### Backup/context targeted corrections

Capture SHA256: `d913f4f502b44b7bb9c15443ef32085bebdc97e95ddc365f2bc7da8452edaa2c`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/4] Write sources
[4/5] Compiling SevraRuntime ConversationContext.swift
[5/6] Compiling SevraMacChecks AdverseChecks.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (16.29s)
PASS: coherent Home backup, complete manifest, exact drafts, pending review, inert restore, explicit activation, monotonic Forget, unknown epochs, corruption/missing/symlink/path/collision/closure refusal and create-only publication
PASS: long Home recent windows, exact retained history, inspectable partial excerpts, matching-memory ranking, bounded full-memory text, suppression lineage and thread-only read/write scope

~~~~

### External draft checks

Capture SHA256: `cc7c9f7e35086066378534ff613a8c396bbec08336d69c8e684d7c2fa6628834`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/5] Write sources
[2/5] Write swift-version--1AB21518FC5DEDBE.txt
[4/6] Compiling SevraRuntime ConversationContext.swift
[5/7] Compiling SevraMacChecks AdverseChecks.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (18.83s)
PASS: external draft inspection, exact review race refusal, preserved versions, revision adoption, restart review, no implicit inference, malformed record refusal and normal work after reconciliation

~~~~

### Full pass exposed Home memory-mode regression

Capture SHA256: `80b23b59db8866da21e3e9cb5a2b774ed7690744088bcefc72af38b8584f0a9c`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/5] Write sources
[4/6] Compiling SevraPresentation ComposerSession.swift
[5/7] Compiling SevraMac AppModel.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking Sevra
Build of product 'Sevra' complete! (14.27s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraLocal main.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-local
Build of product 'sevra-local' complete! (3.79s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/4] Write sources
[3/5] Compiling SevraComposerChecks ComposerChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (5.57s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/3] Compiling SevraPresentationChecks MarkdownDocumentTests.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-presentation-checks
Build of product 'sevra-presentation-checks' complete! (1.17s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (8.17s)
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
PRESENTATION_RENDER_MS 20.164,0.331,0.321,0.326,0.335,0.317,0.318,0.322,0.312,0.313,0.291,0.289,0.295,0.289,0.291,0.290,0.288,0.294,0.299,0.293
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
Start a work or Incognito thread to choose another memory mode. Home keeps its saved shared history.
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
PASS: source Unicode boundaries and repeated unsafe-inventory cleanup
PASS: model verification hash parity and mid-read cancellation without model allocation
PASS: coherent Home backup, complete manifest, exact drafts, pending review, inert restore, explicit activation, monotonic Forget, unknown epochs, corruption/missing/symlink/path/collision/closure refusal and create-only publication
PASS: external draft inspection, exact review race refusal, preserved versions, revision adoption, restart review, no implicit inference, malformed record refusal and normal work after reconciliation
PASS: long Home recent windows, exact retained history, inspectable partial excerpts, matching-memory ranking, bounded full-memory text, suppression lineage and thread-only read/write scope

~~~~

### System alias publication diagnostic

Capture SHA256: `b63598466ad01ae5ce7e2a23af21e9bab7775ff257750240d1c812c6642b0861`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraRuntime ConversationContext.swift
[4/6] Compiling SevraMac AppModel.swift
[4/6] Write Objects.LinkFileList
[5/6] Linking Sevra
Build of product 'Sevra' complete! (17.15s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraLocal main.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-local
Build of product 'sevra-local' complete! (3.72s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraComposerChecks ComposerChecks.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (4.59s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.26s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (7.01s)
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
PRESENTATION_RENDER_MS 15.154,0.273,0.256,0.255,0.261,0.250,0.252,0.249,0.248,0.253,0.248,0.252,0.249,0.253,0.260,0.256,0.248,0.247,0.251,0.251
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
Cannot open the save directory.
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
PASS: source Unicode boundaries and repeated unsafe-inventory cleanup
PASS: model verification hash parity and mid-read cancellation without model allocation

~~~~

### Complete corrected suite

Capture SHA256: `4c9602dd0e70d9ca440d307200a8a0785a50b206572d3c476fa2e431a8103349`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraRuntime ConversationContext.swift
[3/6] Write sources
[5/7] Compiling SevraMac AppModel.swift
[5/7] Write Objects.LinkFileList
[6/7] Linking Sevra
Build of product 'Sevra' complete! (18.54s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraLocal main.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-local
Build of product 'sevra-local' complete! (3.62s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/4] Compiling SevraComposerChecks ComposerChecks.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (4.51s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.26s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[2/3] Compiling SevraMacChecks AdverseChecks.swift
[2/4] Write Objects.LinkFileList
[3/4] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (6.69s)
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
PRESENTATION_RENDER_MS 15.307,0.266,0.255,0.256,0.252,0.250,0.250,0.249,0.248,0.275,0.256,0.248,0.257,0.248,0.249,0.249,0.251,0.248,0.254,0.251
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
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
PASS: source Unicode boundaries and repeated unsafe-inventory cleanup
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

~~~~

### Final full suite including nested-restore refusal

Capture SHA256: `cac38df89458c4221b5102c54ae351675ab44192c87b283b664b67995d3e55eb`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/3] Write sources
[1/3] Write swift-version--1AB21518FC5DEDBE.txt
[3/4] Compiling SevraRuntime ConversationContext.swift
[3/6] Write sources
[5/7] Compiling SevraMac AppModel.swift
/Users/carlos/Projects/slotstream/.build/adversarial-snapshot/slotstream/apps/macos/App/AppModel.swift:172:102: warning: 'activateIgnoringOtherApps' was deprecated in macOS 14.0: ignoringOtherApps is deprecated in macOS 14 and will have no effect. [#DeprecatedDeclaration]
170 |         guard let url = restoredHomeURL, let executable = Bundle.main.executableURL else { return }
171 |         if let existing = openedHomes.first(where: { $0.isRunning && $0.environment?["SEVRA_HOME"] == url.path }) {
172 |             NSRunningApplication(processIdentifier: existing.processIdentifier)?.activate(options: [.activateIgnoringOtherApps])
    |                                                                                                      `- warning: 'activateIgnoringOtherApps' was deprecated in macOS 14.0: ignoringOtherApps is deprecated in macOS 14 and will have no effect. [#DeprecatedDeclaration]
173 |             return
174 |         }

[#DeprecatedDeclaration]: <https://docs.swift.org/compiler/documentation/diagnostics/deprecated-declaration>
[5/7] Write Objects.LinkFileList
[6/7] Linking Sevra
Build of product 'Sevra' complete! (18.81s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write Objects.LinkFileList
[2/3] Linking sevra-local
Build of product 'sevra-local' complete! (3.56s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write Objects.LinkFileList
[2/3] Linking sevra-composer-checks
Build of product 'sevra-composer-checks' complete! (3.58s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
Build of product 'sevra-presentation-checks' complete! (0.28s)
warning: '--skip-update' option is deprecated and will be removed in a future release
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMacChecks AdverseChecks.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking sevra-mac-checks
Build of product 'sevra-mac-checks' complete! (7.36s)
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
PRESENTATION_RENDER_MS 15.645,0.271,0.257,0.263,0.266,0.250,0.267,0.270,0.240,0.232,0.229,0.229,0.245,0.232,0.238,0.241,0.240,0.238,0.249,0.242
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
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
PASS: source Unicode boundaries and repeated unsafe-inventory cleanup
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

~~~~

### Final real model replay

Capture SHA256: `dafbdf1c6f384194b6957c023049fdbf9592af8c4426d86b3e408a2e16d27b10`.

~~~~text
Verifying the local model
Loading the local model
engine ready in 1.0s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
Reading context: 0 of 780 tokens
Reading context: 256 of 780 tokens
Reading context: 512 of 780 tokens
Reading context: 768 of 780 tokens
Responding
Reading context: 808 of 873 tokens
Responding
Reading the conversation
Reading context: 936 of 1317 tokens
Reading context: 1192 of 1317 tokens
Responding
Preparing
Reading context: 0 of 1401 tokens
Reading context: 256 of 1401 tokens
Reading context: 512 of 1401 tokens
Reading context: 768 of 1401 tokens
Reading context: 1024 of 1401 tokens
Reading context: 1280 of 1401 tokens
Responding
Review the document before saving
{
  "artifact_exists_before_approval" : false,
  "citations" : [
    {
      "excerpt" : "# Pilot decision\n\nSynthetic source for the Sevra native application acceptance workflow.\n\nThe team will invite five testers after keyboard testing and the rollback\nrehearsal pass. The pilot is local-only. No account or remote service is needed.\nSuccess means each tester can create a briefing, inspect its sources and\nreopen the saved document without help.\n",
      "id" : "S1",
      "length" : 358,
      "path" : "decision.md",
      "source_sha256" : "74800c822c7e261975707d95aff71a03e890fca90b94683e4d4241cbd3ef6a77",
      "start" : 0
    },
    {
      "excerpt" : "# Cedar release notes\n\nSynthetic source for the Sevra native application acceptance workflow.\n\nThe Cedar pilot starts on October 12. Maya owns the documentation. Leo owns\nthe installer. The pilot budget is 400 dollars. The team must finish keyboard\ntesting before inviting testers. The current open risk is an interrupted\ninstaller update. A rollback rehearsal is scheduled before the pilot.\n",
      "id" : "S2",
      "length" : 392,
      "path" : "launch-notes.md",
      "source_sha256" : "fa60942aa782c8aff47fb0e6a8c7a2012817889c39e693b39a58ac54fdf65f58",
      "start" : 0
    }
  ],
  "content" : "# Cedar Pilot Briefing\n\n**Launch date:** October 12 [S2].\n\n**Owners:** Maya — documentation; Leo — installer [S2].\n\n**Budget:** $400 [S2].\n\n**Prerequisites:** Keyboard testing must be completed before inviting testers [S2], and the rollback rehearsal must pass before the five testers are invited [S1]. The pilot is local-only, requiring no account or remote service [S1].\n\n**Main risk:** An interrupted installer update [S2]. A rollback rehearsal is scheduled before the pilot to mitigate this [S2].\n\n**Success criteria:** Each tester can create a briefing, inspect its sources, and reopen the saved document unaided [S1].",
  "phase" : "needsYou",
  "prompt" : "Read both Cedar pilot documents in the attached folder. Use your source tools, then propose cedar-briefing.md with a short cited briefing: launch date, owners, budget, prerequisites and main risk. Keep it under 150 words.",
  "proposal_digest" : "3a72456e16f8b267349b85e6d74498c59ccbcde76a96b03a0bdc6eec4952fcdb",
  "run_id" : "3a720383-551d-418d-8f7f-be58394cb469",
  "trace" : [
    "source.list: returned bounded source data",
    "source.read: returned bounded source data",
    "source.read: returned bounded source data",
    "The model used \"artifact=propose\" instead of artifact.propose. No calls from that response were executed. Requested one corrected response.",
    "artifact.propose: awaiting exact-content approval"
  ]
}
PASS: real local model, typed source loop, frozen Cedar rubric, exact reviewed commit and reopened durable Home
artifact_sha256=7d66e65315fa81dfe4906f07192bad312dada897be85a3c74618c4778be08431

~~~~

### Real test binary/source identity

Capture SHA256: `5c251fd19868afca939df595363a55fad9f1b272b7d85c89eb026e6964564595`.

~~~~text
{
  "apps/macos/.build/release/sevra-mac-checks": "aeeed633d2b902ff49e6fff82d290966ac2520b6f314ca329fa1c0bb67e0cb85",
  "apps/macos/.build/release/Sevra": "885ea0a5cf5959b2b9dcec14017cb07d92dd3daaa14d10775a8eb764b92829e2",
  "apps/macos/Runtime/Runtime.swift": "7d5dea91565caff9257049118b66f5ad9b1e7a7c77fcfe36611e363d64c14d33",
  "apps/macos/Runtime/HomeArchive.swift": "bf486419554aaa9d50309e83463c60292325c1028ba4dbd4ad7dcffec57d41b7",
  "apps/macos/Runtime/HomeStore.swift": "af1fa3286f7325d0836f44b02414ca2419683d299f652671eb06ef227a7f3c37",
  "apps/macos/Runtime/ConversationContext.swift": "89a1a6cfd9b3d879a53c40443e3c02bcef380f1599354fc386469bd4d39d81e7",
  "apps/macos/Checks/RealChecks.swift": "c9020d34375a4eb8d788c767419ac381b75a3b1f1f10f2fd13a96b4fd0c95d42"
}
~~~~

### Final context UI build

Capture SHA256: `84c8b9f6709b638d00aea02aa537e2376bfd1a9e2b3a81af2a6544e26ab8b0ad`.

~~~~text
warning: '--skip-update' option is deprecated and will be removed in a future release
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[0/1] Planning build
Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (14.99s)

~~~~

### Native restored Home validation

Capture SHA256: `1457f225946043cbd4a7515824c3e702be37d5fdadcfcffd271bae7ab3aa32fe`.

~~~~text
{
  "issues": [],
  "scope": "all",
  "store": ".",
  "summary": {
    "errors": 0,
    "info": 0,
    "total": 0,
    "warnings": 0
  }
}

~~~~

### Final full application input manifest

Capture SHA256: `b46ad98c63ab5818750f5d2453a86fec131141cbb5659b39b5951538adffc74c`.

~~~~text
{
  "dbmd_sha256": "cbf9ee106ab0162fc0ac1865cf09fb38269d5ab13dedb57e3e811ff509cee920",
  "files": {
    "Package.resolved": "6fc23da3ddc636949e84042cb70da34bc93c4355feef14857880caa6c3c7fceb",
    "Package.swift": "8e2faec45c5aa764014d61b5cc04dee63640660322ad3e943084d5cb6dee4f87",
    "Sources/CSlotpack/include/slotpack.h": "07301354bebebac253975abbd5981006be411fed444abab0b6bbc857e28bdd1b",
    "Sources/CSlotpack/slotpack.c": "be45d2daf3e7e95d66cb9178f40dab292b85b1998086d71c53e41f59596d57a2",
    "Sources/Slotstream/AdaptiveSpeculation.swift": "da8062ff16c1d72ccd28852ba18e43cd434a8165483d045759cd29a499f5fff6",
    "Sources/Slotstream/BlockSelection.swift": "16e5fb4a4ea82728e3caaf3d6f4cdbf7d91614b757b0624913ae14c052d6f27d",
    "Sources/Slotstream/BoundedOutput.swift": "70c21c3583edecdd856af06c2fae567bccaf0ea2005ddb932a7dd99642e7780f",
    "Sources/Slotstream/CPUSlotWrite.swift": "da137aec8944dab6590cbea17afff28f094aef876688d20782b5791028d83349",
    "Sources/Slotstream/CacheBookkeeping.swift": "0c3726c431b41a2c84fa2ea21ce49eb209f2c36955925754508a51cb54ae0779",
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/CompiledArithmetic.swift": "98611b31035459d237d901be7fff175072c30b32b992c7534d770b1bc6d117f2",
    "Sources/Slotstream/Context.swift": "2ec4523a59da75efba101b56e9d0e943feb477084e593e68827f84e1ee8b7f44",
    "Sources/Slotstream/ContextFeasibility.swift": "582f40326eea4d969834eefa13425dec345b5630206235640b4b9536ddb044d2",
    "Sources/Slotstream/ContextMemory.swift": "848df7f507cd1cc0d978ea29866f4c5c9635f5091ff236e551cde652cc668d9b",
    "Sources/Slotstream/ContextWindowPolicy.swift": "6da4b93a1a01b1d1b9be13b14d7c4d3b3751f1c38575672d4489f3545a913ab6",
    "Sources/Slotstream/DecodeLookahead+Configuration.swift": "0731bd8d9d7674b3b143bef039ca84d56f11bbb1f255ba7eb31292b17a91c33c",
    "Sources/Slotstream/DecodeLookahead.swift": "13ff2deb101b25f302828a25f090af7c2abf52c2f4baf8e927f6c050545e4668",
    "Sources/Slotstream/DownloadConcurrency.swift": "cf872e6e99b9e1df121a9feba4c0c8420719fe62a5f5a50e58b26bf11cb8126e",
    "Sources/Slotstream/DownloadHTTP.swift": "341a7a7157c575658ee7d7bc6c77ed593bf30f79d8c262906d7672e2e40c6cbc",
    "Sources/Slotstream/EmbeddingRows.swift": "10c722abb55b03bd6ae0f8188ec156f97e2a7603a516bd91919e060d8fc5a645",
    "Sources/Slotstream/Engine.swift": "3428ab0552cc27364fbfeb0c731ef8d73be412e12ed13bb6bfe04813afb02459",
    "Sources/Slotstream/Errors.swift": "0f65317656d38709f071fb58cb4c11f11f68f0949be02a781c675f37f76f5b57",
    "Sources/Slotstream/ExactRead.swift": "bd90fbeb1d400cb7dda746d434a5c4f1fbb4d767506013e4398de9ba1253a47e",
    "Sources/Slotstream/ExpertLookaheadTrace.swift": "16e69d2c91c54d9c45f3df7c7d6e8121fd0fcd8abc627801ee4a4e131556061a",
    "Sources/Slotstream/ExpertPredictor.swift": "2f25044ff7258ac53973c3e5de7138ad078b0b90a1ab13cc332cab8bcfa0740e",
    "Sources/Slotstream/ExpertPrefetch.swift": "7c3ceca11a8587942bb2c60d4c04afbd762b4643e4170a27281bab6366f4369e",
    "Sources/Slotstream/ExpertStore.swift": "f69c680e9c130a178a84db8b6df6e63aabe64a5da2b9963c7e724114e8715ce6",
    "Sources/Slotstream/ExpertTransferProfile.swift": "17fe476f01b03d3a151506d324d9ad0d83d8dcf152489c9e88805ddea2b302ad",
    "Sources/Slotstream/GDNPhaseProfile.swift": "f74d843773b549530cebe9e5df79a02b0104068e05c39ff6adfcbae3effaef66",
    "Sources/Slotstream/GatewayDialect.swift": "93561b74b171c78d107dca5985a1c0601f7ca0ce4388f0a3aa03e9bd0c6bd0c8",
    "Sources/Slotstream/Generate.swift": "2668a164ad5d82bd20ff58c682c11a754efa1c53a5572da619dfe01181e60d2a",
    "Sources/Slotstream/Governor.swift": "ddac4e5d20f3a771cd81767d7734f7b2206b93ea1b2981388b78d6ac5abe1406",
    "Sources/Slotstream/LayerLocalVictim.swift": "9615385e6c2ac18573f4d2089a75a70d356d803c0c4a603b4db3397fafa6275c",
    "Sources/Slotstream/Layers.swift": "a724e905905b256a5a463cc8585a227a0062976c879cf57d2b3f2d3ca4278b52",
    "Sources/Slotstream/MTP.swift": "10b63deee430c1e1d5792221f128bea0a6158161911676679665a168116cf743",
    "Sources/Slotstream/Machine.swift": "ffed1d45e029e21e42e1eb956d1b3f2647aae2bca689f532b5dc2dba897c89ee",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "26aa0f5c18d24e3692363570e92f59dfcd34c080aa213b846b39156a9047b4b5",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/OpenAIDialect.swift": "714263f4382c83835c4e617ffcb72e231c270a0f0d8be497881cdfc663d52f58",
    "Sources/Slotstream/OpenAIOutput.swift": "d13c9a29f3dbcf9fb9933e5a378f3ba8160d7eb4f96d3c7a61f3faed5a563b76",
    "Sources/Slotstream/OptimizationPlatform.swift": "e4c17aeb1ab294ac9d9e9c60095cc5360382c0809a4f579672b4d0b66a0ed3cf",
    "Sources/Slotstream/Optimizations.swift": "4f3b35ad41cef026e7bcccfeb03580a1d4c4ade57a21eacb5b195f0dff38bee8",
    "Sources/Slotstream/PackedExpertLayout.swift": "c74e9867e2c37ba92d84bf7ce90253eea6db6f8531a6d6b8792874d4810cc6ee",
    "Sources/Slotstream/PackedProjectionPair.swift": "84fa87130270092c16a538f7d50cfee55e71b52ecd8250a1bce7e0547c8b1d96",
    "Sources/Slotstream/PartialRotation.swift": "57177495e6ba630c66744b2b9e2bde23acf9349fca52b97a4ea406c5839c7f8f",
    "Sources/Slotstream/PersistentPrefixCache.swift": "2761c700990f8295e069108828ebd9c91aaf7cc12bc3649ce06690fc7ed25665",
    "Sources/Slotstream/PersistentPrefixFormat.swift": "eec16cb611bf9a5c617ea73f465f05db1f4fdae503b1b3655b59d6cbe7290702",
    "Sources/Slotstream/PersistentPrefixGenerator.swift": "36a24796df4c6d9c5bc56170888be142749d787d39dab79bbe9c9e4b278db47e",
    "Sources/Slotstream/PersistentPrefixPolicy.swift": "40cfc47a5e4a5f3cb91e1264e1bac3121bb871335313205a3529a89e9cb24aca",
    "Sources/Slotstream/PersistentPrefixRestore.swift": "ee3bc4123ac885375ac2be349454f92dcfecd28478eb905427d5f33e6925e8c4",
    "Sources/Slotstream/PersistentPrefixSave.swift": "3605a27cacf1c7b94bb228785d7be1b1e4bbb4a64f455c4b93ea6b2f292d811f",
    "Sources/Slotstream/PinnedModel.swift": "0c7c16539bcb54924ff7306b03b470e2915b5bb41c4ecff9e60dc7912e7afdd2",
    "Sources/Slotstream/PinnedTransport.swift": "f30c4c4bfeaf49c5e2dfcbfa728d6eab44d02a1f77d40217e84723fd03761d87",
    "Sources/Slotstream/PinnedTransportManifest.swift": "6b0de220938fc91dd4dc24cd0fc9dffa086f09f04cd83823dc3de3a13de8ac11",
    "Sources/Slotstream/Plan.swift": "a93709d5b77069ca9558846efc988f9c81ee2f88303e4dd407f8e417f961536b",
    "Sources/Slotstream/PlannerCostModel.swift": "a95e2781a7448418ec78480be356bac9eb80bb36cc64c63f6cb3e378043d29c0",
    "Sources/Slotstream/PlannerDevice.swift": "528cdf93cf0fe600b8c53a3eb828b9b1922ee4817fa100393a11d4e2714784f8",
    "Sources/Slotstream/PrefixCache.swift": "96f5c3aa54471582d5e8a6b4a2a6b37e8ea284c5e9ce29e5b133a306cf5a42d2",
    "Sources/Slotstream/PressureBoundary.swift": "ed22537fccc321589eb3d33b3538984630daae951d00e4ac829412897b181a3d",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Sources/Slotstream/RequestControl.swift": "a8bea5078dbd26458331af41fba986f9de05d386637b69768e2035c95345bdea",
    "Sources/Slotstream/ResidentExpertOverlap.swift": "4ddb3a027d92697dcc1e7373e66fc139abdc12063448d864ef635e5202f57dde",
    "Sources/Slotstream/RouterProjection.swift": "98ea668ac6f47549ec9cdee41b81109e66f11935946d2d1587ebf97ad106230d",
    "Sources/Slotstream/RouterSelection.swift": "35b122748ab05c00122bfb5b4c78416ee28b55abaa4d4e1379fd163aaf47b4a6",
    "Sources/Slotstream/RouterTrace.swift": "b34c1974f60015c913649a285023e57b15d92f37c2f7aa282b821eb2043652c1",
    "Sources/Slotstream/RoutingReadbackQueue.swift": "477ad597e6e741cb939c9ade983934814e2a7c6b8e7c59fc659a1dc02eb4b4ab",
    "Sources/Slotstream/SelectedAttention.swift": "70e61a089444f74cc74494d7f05005b0ff4dfe67043782befbbef80d96b911db",
    "Sources/Slotstream/Server.swift": "c20776840aa9551958d8fed92389c8fc32318c97639bd14d93609233dc449334",
    "Sources/Slotstream/SlotWritePlan.swift": "9abde1de815522ff835d3c685a2e342293f3c9c7019cfc742265193ea2e286c1",
    "Sources/Slotstream/SlotpackDownload.swift": "fb6f47ce70f30713cf1679ebda619c980e9d783dd6ae4cd1cc4e0a68b14705b7",
    "Sources/Slotstream/SlotpackManifest.swift": "8664440e22653e64b85c0100345169dd93b3836d1bbd125ac2add4f621b9876d",
    "Sources/Slotstream/StatePrefixFork.swift": "35ed6954bc927e37c117d53eb25e007b83b3385099bc9b18e01607f30abb7df7",
    "Sources/Slotstream/StateRecovery.swift": "078521e0e08233c06706408bb6dbc53f902285fc4c891af2e164386bd41bf98b",
    "Sources/Slotstream/ToolCallSplitter.swift": "2c2e1d722188d633508c871d73f011fa4053b666d10b7585b304c151c53925a8",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
    "Sources/Slotstream/Version.swift": "4a34c363a6357ae06fb07c9d58f959de072ae0d4dad889e8f9c0e88063a5613c",
    "Sources/Slotstream/Vision.swift": "38565f564bf8ba73d2dc87e2f1874fa6fda2652e094a324048bfa8cb1278a79e",
    "Sources/Slotstream/VisionAttention.swift": "83b1012cb0b3a2c22098f71515e3e853cf1ca3affb01cb667a8248e3c34c63a5",
    "Sources/Slotstream/VisionPrompt.swift": "61b90891a5ec9944406287fa73b4c0e5bdd29b4e3903dff345cbeb80638c6435",
    "Sources/Slotstream/WeightDownload.swift": "2758b2eea2631635cd3da5c18a87e724c57aab5c78ad816b7e18d7ff48c8c98d",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "4c6112412f38192de1955bedb6b7f3cddcb2d0b338b570b6b688df4638a55e5f",
    "Sources/Slotstream/WordSlotWrite.swift": "1c19def2346669acc1afa811a7244233c6f593de91c02bfc4ff145465b95187e",
    "Sources/SlotstreamDiagnostics/CheckReport.swift": "9bbe2106b5b55331cc3fbc093edd803eff6f9f00ebd5f30ce587754fe0bc7e47",
    "Sources/SlotstreamDiagnostics/Diagnostics+AdaptiveSpeculation.swift": "e53d32c4f5a3fc7039a258db5c5b3c530416d07828c5d424a8f35e67d80dc256",
    "Sources/SlotstreamDiagnostics/Diagnostics+AllHitReplay.swift": "187a98c70c2e66008622db3727f0bf58126928862bc102782574fa0ba5f57513",
    "Sources/SlotstreamDiagnostics/Diagnostics+BlockSelection.swift": "08d3f1fc29b6353443b795198295bacb85f57d0a2bdbac67450cf66d505f852c",
    "Sources/SlotstreamDiagnostics/Diagnostics+CacheBookkeeping.swift": "6db1e4743b6adce39f32c2c5c0ff9c38bb86d7e9548c41e6c0e7d64299dd9cae",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompactIndexer.swift": "3dd65c8fac32f2804cce942845946debe74ca83b9cf6485a441ed15331711a5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompiledNorm.swift": "9f1beb774172bc33a27020261532e06723f0794adba9ab5dbca7807d01a0748f",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompletePrompt.swift": "75cdd2137b2856407d2fb297504039b174b3ae116b40608d5f42fabf0237a66d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ComputeIslands.swift": "ac7f3b5ed140a566348e9be06274cf757144d2db099fe5af097c4a3807dc6801",
    "Sources/SlotstreamDiagnostics/Diagnostics+Context.swift": "76ea9c95cd2d20614533458ffe32c8e8fd6d29dee3b1bece7476e27d3f589ce0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift": "51e505bd3279983263ad731133b2f1e20606387cf03ba360ffcb2fba34dd33a3",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift": "90b83306d1966da794daf28cc84f426a42cd853075f5e236cf1bacae10787d8f",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeLookahead.swift": "a27f1040ec4bea2a5e02f25f2a4d51a6a15ff78bd0609b1c23bd97e1adc3822c",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRows.swift": "a0f0532a43c1329b3a69f8a3bd8607df9f27793c0994ad23203936896b44e81f",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRuntime.swift": "c5c37fafb45b2ac2434a36cd7c8b8804fac0e271e9e3f0fb10ef97481db77e24",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExactRead.swift": "77a357f55c3f5aced5ba0d74012e35f73e678e0840024f24a5ab86909d335c59",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift": "6a88a4b8bb8b35d6ca80d63cc1264f4da44218ca0229320960a8328ad2e95935",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProfile.swift": "6d982a575d6c6282941a9f9f3ac063b75d31996fcde387a63ca3ce44fea93242",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProjection.swift": "983a071e562451dbc22cfe09b005d9c68af687c10e7d94802d7d3cb28af1c7cd",
    "Sources/SlotstreamDiagnostics/Diagnostics+Governor.swift": "8ec85ff3609cd5657eae1a8434189e9474460aad0c850f6b88240457c8f0f1fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+HTTP.swift": "9526e51122c9e463ea9a3201da6e4628f3794f329bd4ca05f1496daf3c66c1e5",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageFailure.swift": "766742295107f924177f7f724a7be61f8ccb29b3e044a7de345523598c31cead",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageReuse.swift": "5d0e619769c0f7d4ea8c73439ac44bc499db6184c4954b417f4cb7804aec20e8",
    "Sources/SlotstreamDiagnostics/Diagnostics+Integrated.swift": "5eb2132959b1db779caa520a3eefe5d6c5ffdd9ed317750c8cee48f02bd05941",
    "Sources/SlotstreamDiagnostics/Diagnostics+LayerLocalVictim.swift": "d512d93741a6675412cc9e6c739b940132ca3f20ebecd709884b00b1ebbc49b7",
    "Sources/SlotstreamDiagnostics/Diagnostics+MTPIndexer.swift": "7784a18a1eddafa25ecaee9eeacfbcddf8bcabac8d53919f80367a4f4e5be476",
    "Sources/SlotstreamDiagnostics/Diagnostics+Machine.swift": "20f6edb816fc3a794143042e59847adbfc1fe06514fc990e8a3d81eb87abe50c",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramCache.swift": "9bee4eb6c6cf09df5673e177d4b7f006681794bf680366b4549e4fa3d38b7368",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramLookahead.swift": "3b0bc7ea21a57d2ce65e58773879f5f86ba7f0f37c47d8f1d08d51e61c486370",
    "Sources/SlotstreamDiagnostics/Diagnostics+Optimization.swift": "35d99deb614da4ffdfef075eabdc5a1c8b3518bf9accf265796e09f2c7c281ee",
    "Sources/SlotstreamDiagnostics/Diagnostics+Output.swift": "e39951dc83e8410abdc840d0a739e1e1b2fbbdf1e2d06b3cb2d28c39ee9329cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+OutputServing.swift": "50bb807143f1e5134f52a6f3d48b8da297f4186dd91895e016d191ca13ccf66a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PackedLayout.swift": "14c31f94ebdd8bbbbb1479c77d0649b4c0632d978e4d8a60a8048214a1e08e65",
    "Sources/SlotstreamDiagnostics/Diagnostics+PartialRotation.swift": "de75d07feedc163834fe8e716683af8b2d373c51b0588ccc2cac922f775367ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefix.swift": "46a5bc33ee3fd389694f22c9e7ff5cdd995539663b3141688414351f50ac3189",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixModel.swift": "3e06c67777ce3572d9bd7cce5d220be5f41af90e31b6f5da349ba6f3ec667798",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixPolicy.swift": "82dcadab2ac079d3662da6dd012d8a031c4bdea9ee8c022ac34d5faf66277f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+PoolRequests.swift": "e383c494263afa029a9ef107c90d6ba59f44cda5da7ca1035eae68cbda3562d2",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillQualification.swift": "f40d8e711121f12cbcd95f8880d483ac36995faeab06af714d201fa1671348f1",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixCapacity.swift": "b76e9185930a90d2509f9d7dfc247afee3ff2a083a1bc6bb3da6d090653d290f",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixFork.swift": "e7a7094b3930cef8e380d711f20e8f82e2821c070579549692a6120e9ba3afc4",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixRetention.swift": "5de9452266e8e59da03b078990689554fc7a419a5cd8e5879cc68e2e277ea8cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixVision.swift": "5e4737dbe5344492fc2f9c6881f8d56e997668f674c91b28b9349c9420465f72",
    "Sources/SlotstreamDiagnostics/Diagnostics+PressureBoundary.swift": "f84979a3da94bc5ac0cfeb5cc84b61af43716c5664cc71853085ffa1b116d325",
    "Sources/SlotstreamDiagnostics/Diagnostics+Pull.swift": "224e4bf5210afbddd992894860343add73d1f52b12b2d9a00abf78fdc492ada0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift": "1532f45714ceb98a5adcfa31abd31f065493164f49d2ee3aac868d5d4080b04c",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift": "9e98b6e0fd6c30f36d1d3ec8d556216f351a2f09ee5d15dbb4f5580858fad4b4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadRecovery.swift": "5d51636a62b376e74dfefab207fdd42da61436210973f714819c7cc11488a04d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ResidentOverlap.swift": "c1e7b847cffa51939b0ae20027b289efcae5585a94ae5c1c751a66f110a25522",
    "Sources/SlotstreamDiagnostics/Diagnostics+RopePerformance.swift": "19d040f21391a1ea87831b73a8adf055a78aeafe9d902bd11ce22fd6a492d892",
    "Sources/SlotstreamDiagnostics/Diagnostics+RouterProjection.swift": "3981e415003e6258d41690216a7ab668652a0ce436bf644d99d88dbc2799db9e",
    "Sources/SlotstreamDiagnostics/Diagnostics+RoutingReadback.swift": "f29aad2cde3bbb526f83dcec4565f3c382d071734acc47a0e31d7223312713cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+Runtime.swift": "b6debc0a68e2df94574964c13afa41a76a5aab783e75d1428da25110d241cffc",
    "Sources/SlotstreamDiagnostics/Diagnostics+RuntimeBudget.swift": "b5ce492456b9e27b19765a0bd4f23cbd81ccff034be5af3142737cdae7944d6e",
    "Sources/SlotstreamDiagnostics/Diagnostics+SamplerPerformance.swift": "4e6dd7e85d7ac0f2b2af291343ab4cdc52fa94fe6edb588c1d517008a0c35cb3",
    "Sources/SlotstreamDiagnostics/Diagnostics+SelectedAttention.swift": "8dd385da9b79c3625d1cc9ccc6c8821978f88437fcded918f049328b7a969e7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Selection.swift": "b737794c5a57cd224f36a93b960fa9834cabb51ef810945bab64fd71e59c91d0",
    "Sources/SlotstreamDiagnostics/Diagnostics+SlotSlices.swift": "32c10a839423b13a4dceff67a5b2a617f90d145376a70b19bd27f2e62452e288",
    "Sources/SlotstreamDiagnostics/Diagnostics+StateRecovery.swift": "a53db99ff0f97a26e87586e35bf05daa26b9281fe7d686a1670c14984da2dd77",
    "Sources/SlotstreamDiagnostics/Diagnostics+TerminalPrefill.swift": "7ef27bec8489f52ccdd3ea51c125d21eb94512924b163e854b7aaf25ef39f57a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "be63108d11318a9469d26587ade08c79bf34274c61b847d752663d8ce007f9af",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "da4b4a89d9b11d26a64cd244aae2887acfbca16a6d3aceefa8f40f90c8e39634",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "fe3aaf4ad816c02fc0b28771d6c3c7f9cf7b2a9f102ea4fce660c1dd8541a650",
    "Sources/SlotstreamTestKit/T0Checks.swift": "c3078392faebeddc26b250361a400ac66a756def9ee38edb972c21f3a80266e0",
    "Sources/SlotstreamTestKit/ToolCallChecks.swift": "f1b263239f4e82707c77a5887367fb5302e96d369f2f278e0e45a87d3006dad8",
    "Sources/slotstream-checks/main.swift": "02ebabaf058afa95622ccd29fb65d80b7eac41c9e6232f0167ef288c2126e0d9",
    "Sources/slotstream-cli/CheckRendering.swift": "0905dcbae17a5b3d66e13a760c4054fb29d930331d32942a528510ecfe9769a1",
    "Sources/slotstream-cli/ContextCommands.swift": "3ba24ae3e24dd10214e3288f007952d9e2b06241c081e29313b42ac7aa7a31bb",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift": "b921d4791feb0caab0ef50f74e92e0bba202e9ccf84ed1b9f4571e3a184ab696",
    "Sources/slotstream-cli/MTPCommands.swift": "190b88f5e069d11361597b0fa869ffbe21b003fecc635cc8907a9a55d3239576",
    "Sources/slotstream-cli/OptimizationCommands.swift": "9a0013222a0accfb268bb860f94e8939b2b99f8fb31bd949be9d5e9ace83e8d5",
    "Sources/slotstream-cli/PackedExpertCommands.swift": "ea7f4485d60a985a0a1f759f077d28dc42f36512dc1dd07a7644a22e31346b12",
    "Sources/slotstream-cli/PrefixCacheCommand.swift": "266b9571726fe280c11d5dededa565375af1749b76c7e70def4fe9530729914f",
    "Sources/slotstream-cli/Pull.swift": "4fa56def1edb0ae575bd898e3b53b669f0a16b04d734ef86e0f6c4a6ad185d14",
    "Sources/slotstream-cli/SweepCommands.swift": "37455d724a63b1689208dce9d55cd3d249bcab6d45bdf40d5c5e4f6992aa0d20",
    "Sources/slotstream-cli/VisionCommands.swift": "df80e089ea9cdbc6fc51ec7dc895b0dbf0eec5d4db80eb73b0ca9720a3ce8cc0",
    "Sources/slotstream-cli/main.swift": "9eff0455736b4d5ecf6825463d1a3fac5863ce549540f82c7b11734366a5f919",
    "Tools/build_sevra_mac.sh": "c54606315dafd8755b12b48aed50a95b90a527d9c7fc34ee8daf20c961b815d7",
    "Tools/generate_sevra_icon.sh": "8228ccb8e4d707c2a73336f283ed599f72cbc2213589ca36191d675e737141b6",
    "Tools/lib/mlx-0.31.1.metallib": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597",
    "Tools/mac_build_inputs.py": "8ea8316c74a1056182128c4f81a9651bb3ff9dd328569811d795301c4cb7b335",
    "Tools/render_sevra_icon.swift": "cbcf593dec275773cc86118bc4d6aff423534d9df7e62ef0fb014733c9aa3095",
    "apps/macos/App/AppModel.swift": "086a22f9fd329e94088f6ff5a3aaf0261017711023a8dbc85dd364d2fd19e352",
    "apps/macos/App/ContentView.swift": "4e739cea0131aa897726551fc8f3872e33b582334a0ab193b59c8ff1fd756b18",
    "apps/macos/App/MacCommands.swift": "059ebbbaf81cb83f3c57bdc1f635b1d30e0f8913fe776ce4c9c2615c979fa481",
    "apps/macos/App/NativeText.swift": "ffda81e14f2d8a59b54923e0a66a726b7ffd618a0e77d41dfd8e76c9d4f20dab",
    "apps/macos/App/ObserverMark.swift": "93f172ecc0b360338bb09913071a6ba6644077576abf9b323bfa95ebd4c5b764",
    "apps/macos/App/SevraMain.swift": "8e1e6a97fa3781239d2da22603aa5bbf0e16d8ce858ec9a8ddf8346bf92a3f3b",
    "apps/macos/Info.plist": "73cc83e91b2729b1ef576226fd95104e0bb763f874fe937d81d92d9785e8bdb6",
    "apps/macos/Package.resolved": "766f45a6da66031f58629e0446f18060a3c92699b1346c8e028181bc9aaeffd5",
    "apps/macos/Package.swift": "20288a7efe64b916a71e1dadd9a9e249fb1f5b6d10048b22e69c62e37a9f91a5",
    "apps/macos/Presentation/ComposerSession.swift": "e47d2480d6755e3b98f5862b683c003b5b3ee7f7d8aa0e0547bf173aafe6b492",
    "apps/macos/Presentation/HistoryPage.swift": "a97110301fe774fa0236f1b5dfced7a437620953f30e23656affb716b35f2032",
    "apps/macos/Presentation/MarkdownDocument.swift": "26a2501a3e1b10a60ef72e2d98748f0d6778cef7c5df28c648f7db99fcb58f9d",
    "apps/macos/Presentation/Module.swift": "dda9b75f64b106eb544de201f599122d75abc483c5b156bba6c05c0f956dbc3c",
    "apps/macos/Resources/Fonts/Inter-OFL.txt": "5b9321a4298cfeb6b34354164a1c3afc3db114569984c502b9b35d988fd58c57",
    "apps/macos/Resources/Fonts/Inter.ttf": "29160a80ff49ddcab2c97711247e08b1fab27a484a329ce8b813d820dc559031",
    "apps/macos/Resources/Fonts/Poppins-Medium.ttf": "90373e7d838d32468438fc3e152dca0bdb12edcab99ea639f158790b1ba1fd05",
    "apps/macos/Resources/Fonts/Poppins-OFL.txt": "6be04893d770899a015649c7aa3b582f871b272f8747a92b78b17c3e5c8b2573",
    "apps/macos/Resources/Fonts/manifest.json": "1e79dfd278dbe9bfd8afbf7e5cbaee64dff1574fc1cc3aca8fdd903f4056677e",
    "apps/macos/Resources/Licenses/swift-cmark-COPYING": "c22e885f33b821bddb24cf007145e5540655b6c0f403e49e6c76a93c28e6d9a9",
    "apps/macos/Resources/Licenses/swift-markdown-LICENSE.txt": "167beb36f181bd163c93c6feb45c68e5f9462fe1af55b278f7bfd1df20e673a3",
    "apps/macos/Resources/Licenses/swift-markdown-NOTICE.txt": "ee7da43afcac4a52196a2141024573ec2ceb84b14e74dfed38522d94586fbc52",
    "apps/macos/Resources/Sevra.icns": "b28f2df8e40cafc2e89fb3ae5a0e361b5470851d833495df9b3dd4ca0395471d",
    "apps/macos/Runtime/ConversationContext.swift": "89a1a6cfd9b3d879a53c40443e3c02bcef380f1599354fc386469bd4d39d81e7",
    "apps/macos/Runtime/HomeArchive.swift": "bf486419554aaa9d50309e83463c60292325c1028ba4dbd4ad7dcffec57d41b7",
    "apps/macos/Runtime/HomeStore.swift": "af1fa3286f7325d0836f44b02414ca2419683d299f652671eb06ef227a7f3c37",
    "apps/macos/Runtime/HomeTemplate.swift": "e25b0a112abdea7d915c1f553fb3b62078b8ab35ab60dc5c3d80a82468caa7a2",
    "apps/macos/Runtime/Inference.swift": "e1a8dbf38a10b4b36e8be5aaf3cbdb8448dfd13f30985c326c07fcbc263e9268",
    "apps/macos/Runtime/LocalIPC.swift": "896fdb1e597888c54c7d0ee79ba61e186b4bfd8c1d745d67196ce7b611242984",
    "apps/macos/Runtime/ModelSetup.swift": "0710c291b65007ed39cde6b77b10bc4c2636cdfc44bbb7975f9aec1b30d3c501",
    "apps/macos/Runtime/Models.swift": "e214b9140c26fbf0d01586a6715f5ef6c85bf2893c53096d016b74261c3af4df",
    "apps/macos/Runtime/Performance.swift": "b771d35aa8af3dcb6de0d88fe4585ac9b405b01e15d7a0fd1695f7ccad94dc00",
    "apps/macos/Runtime/Runtime.swift": "7d5dea91565caff9257049118b66f5ad9b1e7a7c77fcfe36611e363d64c14d33",
    "apps/macos/Runtime/SourceTools.swift": "2aaedf54990a266980c608d29ff2316dfba6c9d696cf20d8e273d8b9481c4c15",
    "apps/macos/Sevra.xcodeproj/project.pbxproj": "9cc99dbdd7fb8e54224e2f48993e99bdc8084a5432fbcb7f2483c1d812cf7a5a"
  },
  "scope": "Local development build inputs. Ad-hoc signing is not release qualification.",
  "sdk": "26.5",
  "swift": "Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101)\nTarget: arm64-apple-macosx26.0"
}

~~~~

### Installed development identity

Capture SHA256: `de979f73434d143cbb4f895eeff65dabbc332c565d71a8b3c4a00bce59486729`.

~~~~text
{
  ".build/Sevra.app/Contents/MacOS/Sevra": "25a135dff6780be35daa5a66f7d61e37bd2316dfed1f3d82ef35abed9b381d6d",
  ".build/Sevra.app/Contents/Resources/build-inputs.json": "b46ad98c63ab5818750f5d2453a86fec131141cbb5659b39b5951538adffc74c",
  ".build/Sevra.app/Contents/Helpers/dbmd": "cbf9ee106ab0162fc0ac1865cf09fb38269d5ab13dedb57e3e811ff509cee920"
}
~~~~

### Final synthetic native application log

Capture SHA256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

~~~~text

~~~~
