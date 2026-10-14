---
type: run
id: 01m4y4cxzmmrtrhxbx4fcssp9q
created: 2026-10-14T21:16:53.620461+00:00
updated: 2026-10-14T21:17:17.243243+00:00
summary: 'Real native capability audit: successful narrow jobs, failed reviewed edit, JSON and citation mismatch, and stale app artifacts'
binary: HEAD 7940bfd; harness and source hashes in identity.json
captured_at: 2026-10-14
command: Exact commands and harnesses in capture.tar.gz
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra native capability audit before fixes
tool: Native Swift runtime with local inference and production renderer
---
# Native capability audit before fixes

Captured from source HEAD `7940bfd` with a clean working tree. All model work used the native `SevraRuntime` with `LocalInference(memoryGB: 9)`, one model process at a time and disposable synthetic Homes. The local machine remained in ordinary desktop use. These timings are diagnostic, not a speed comparison; `discarded: true` excludes performance qualification, not the functional observations.

The baseline completed writing, translation, a cache explanation, a constrained story, comparison of supplied options, explicit saved-memory recall, PDF reading, receipt OCR and a tiny CSV question. A website request correctly reported no live web access. These are narrow fixtures, not broad model-quality qualification.

The code-edit job read the file and staged the correct inclusive-range edit, then failed on the undeclared `artifact_propose` tool name. The runtime discarded the staging and left the original file unchanged. The raw receipt answer fenced its otherwise correct JSON. A traced PDF replay initially tried attachment ID `a1` as a file ID and needed extra discovery. It later returned page-annotated citation labels. The production renderer produced no clickable evidence links for that answer, while the canonical-label control produced one.

The first full native check hit a reproducible SIGBUS in ModelPack destruction. The debug app's old ContentView object predated the removal of a ModelPack field while the engine/runtime objects were current. Rebuilding that consumer, with no production source edit, made the same memory UI check pass; the subsequent whole native check also passed. The existing development bundle's manifest and symbol table still included GPUKeepAlive from its older embedded engine. Updating the independent CLI had not rebuilt the app.

## Preserved evidence

[capture.tar.gz](../../../artifacts/sevra-capability-audit-2026-10-14/capture.tar.gz), SHA-256 `16297a6b051911f51d67d3cb7d2209d1ae3c4b19dd537a8f53a044a101705247`, contains raw baseline/model outputs, exact harness sources and build helpers, the traced file-ID replay, the renderer reproduction, build identities, preflight and native check logs. Its inventory verifies all 19 evidence members. Compiled binaries, the user Home and personal data are not included. The synthetic input fixtures are maintained under `apps/macos/Fixtures/capabilities`.

Every owned model process exited. No source code, user data, GitHub issue or installed app was changed during this baseline audit.
