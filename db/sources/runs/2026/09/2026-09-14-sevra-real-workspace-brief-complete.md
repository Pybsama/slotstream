---
type: run
id: 01m2ge1jjppn2mh595d1bw4z0n
created: 2026-09-14T17:04:41.558499+00:00
updated: 2026-09-14T17:16:17.246165+00:00
summary: Real local Mac runtime completes cited Workspace Brief, exact reviewed artifact commit and reopened Home
binary: 1ca88158cf61bddb866dd6d88ed96c17cdd90326fc05e3693939fc6b3283bc65
captured_at: 2026-09-14
command: sevra-mac-checks --real with explicit synthetic Cedar source and new disposable Home
discarded: 'false'
machine: '[[records/machines/macbook-pro-m5-pro-48gb]]'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra real Workspace Brief complete
tool: sevra-mac-checks
---
# Real native-runtime Workspace Brief acceptance

The synthetic harness reviews and commits only after capturing the proposal and checking its fixed Cedar rubric. The UI review action remains a separate pending check because macOS locked during native interaction.

```json
{
  "build_inputs_sha256": "a6ed8505e646ccb7703e0a482573906a46226beb285772a780880c2e2f09b3af",
  "command": "apps/macos/.build/release/sevra-mac-checks --real --source apps/macos/Fixtures/private-workspace-brief --home .build/sevra-qa/real-complete-20260914",
  "executable_sha256": "1ca88158cf61bddb866dd6d88ed96c17cdd90326fc05e3693939fc6b3283bc65",
  "hardware": "M5 Pro, 48 GB",
  "macos": "26.6.2",
  "scope": "Functional acceptance on the development Mac. No clean timing, native click-through completion, automatic model qualification, alpha or distribution claim.",
  "test_source_sha256": "c9020d34375a4eb8d788c767419ac381b75a3b1f1f10f2fd13a96b4fd0c95d42"
}
```

Exact command output:

```text
Verifying the local model
Loading the local model
engine ready in 1.1s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
Reading context: 0 of 769 tokens
Reading context: 256 of 769 tokens
Reading context: 512 of 769 tokens
Responding
Preparing
Reading context: 792 of 857 tokens
Responding
Reading context: 919 of 1300 tokens
Reading context: 1175 of 1300 tokens
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
  "content" : "# Cedar Pilot Briefing\n\n**Launch date:** October 12 [S2].\n\n**Owners:** Maya (documentation) and Leo (installer) [S2].\n\n**Budget:** 400 dollars [S2].\n\n**Prerequisites:** Keyboard testing must be finished before inviting testers [S2]; five testers will be invited only after keyboard testing and the rollback rehearsal pass [S1]. A rollback rehearsal is scheduled before the pilot [S2]. The pilot is local-only, requiring no account or remote service [S1].\n\n**Main risk:** An interrupted installer update [S2].\n\n**Success:** Each tester can create a briefing, inspect its sources, and reopen the saved document unaided [S1].\n",
  "phase" : "needsYou",
  "prompt" : "Read both Cedar pilot documents in the attached folder. Use your source tools, then propose cedar-briefing.md with a short cited briefing: launch date, owners, budget, prerequisites and main risk. Keep it under 150 words.",
  "proposal_digest" : "b8debe07c78314bd31936fa8c0d915bff0a5f3159e90a919ee4913f4b0eb05f8",
  "run_id" : "89edbf53-5d53-4844-8dad-189077e45233",
  "trace" : [
    "source.list: returned bounded source data",
    "source.read: returned bounded source data",
    "source.read: returned bounded source data",
    "artifact.propose: awaiting exact-content approval"
  ]
}
PASS: real local model, typed source loop, frozen Cedar rubric, exact reviewed commit and reopened durable Home
artifact_sha256=cf12cd4c1f1e6dec82fe818f85989c55b8e0c4009b0abfc6e7770c4a67562213

```
