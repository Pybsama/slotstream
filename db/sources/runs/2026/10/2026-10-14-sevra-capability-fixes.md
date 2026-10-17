---
type: run
id: 01m4y5gsapxn5scd5r4c14wa3j
created: 2026-10-14T21:36:28.502057+00:00
updated: 2026-10-14T21:37:00.798994+00:00
summary: Native capability fixes pass deterministic and app checks; real-model replay refused before loading for insufficient headroom
binary: Base HEAD 7940bfd plus captured patch and new sources; exact hashes in after-bundle.json
captured_at: 2026-10-14
command: Exact commands and harnesses in capture.tar.gz
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra native capability fixes
tool: Native Swift runtime, presentation and app bundle
---
# Native capability fixes and bounded qualification

This follows the [baseline audit](2026-10-14-sevra-capability-audit.md). The implementation adds schema-derived correction within the existing retry/review boundary, direct attached-file IDs, shared citation parsing, syntax-validated raw JSON finalization, deterministic CSV/TSV calculations, scoped conversation/memory retrieval, clear capability help and native build-input invalidation. It changes no engine inference default or model-selection policy.

## Observed verification

The full native regression command passed with stable sources. Later changes were limited to the help layout and its check, and an explicit bounded memory option in the real-workflow harness. The focused capability suite and production thinking/help UI check then passed. The expanded help was also inspected at a narrow window size. The development bundle rebuilt successfully, passed deep strict ad-hoc signature verification, matched its source manifest, and opened a disposable Home through its native local endpoint. The smoke used an empty model directory; it does not demonstrate inference in the app. Its owned process exited.

The old app had 49 GPUKeepAlive symbol matches; the rebuilt app has none. Exact before/after manifests and executable/helper hashes are preserved. Updating the CLI alone had left the old app untouched; the build workflow now guards native consumers against dependency-layout drift.

The deterministic suite covers complete filtered/grouped decimal sums, malformed/oversized inputs, cancellation, citation provenance, bounded correction without executing rejected calls, preserved staged edits without unreviewed writes, omitted history, paginated recall, Forget, cross-thread isolation and Incognito refusal. Presentation checks in the full suite cover annotated/grouped citations, literal code and links, malformed long input and raw JSON copy/render semantics.

## Real-model verification remains pending

No model allocation occurred in this follow-up. The prepared real-workflow harness preserves the original prompts and inputs and adds complete-table, older-history and supplied-transcript jobs. It requires a new disposable Home, one model, an explicit budget in the repository's 8.1–10 GB test range, and three additional GB of real available memory. The original default was 9 GB. With desktop availability near 11 GB, the harness was parameterized before execution; two attempts at 8.1 GB refused before loading because availability had fallen below 11.1 GB. The later snapshot was about 10.2 GB. No guard was relaxed and no other application's process was stopped.

The baseline real-model successes remain evidence for their original build only. The new deterministic tests prove the host mechanisms, not that the model will always choose the new tools or correct its earlier spelling. Replay `sevra-mac-checks --real-capabilities --memory-gb 8.1 --home NEW_DISPOSABLE_PATH` with the document helper when headroom is available, inspect every answer and preserve failed attempts. Do not call this a completed real-model qualification, performance comparison, public release or installer test.

## Earlier failed checks

Initial Swift compilation exposed overlapping optional-state access in the retrieval receipt update; this was corrected before successful builds. One full-suite attempt overlapped a source edit, which the compiler rejected, and included an old no-tools assertion that did not allow the newly scoped recall tools. A subsequent attempt found an old trace-suffix assertion after refusal messages gained useful reasons. Those assertions were updated to check the actual authorization and refusal contracts. The final full suite passed. The first help probe clicked the label without expanding the native disclosure; a full-label button and scrollable layout replaced it, and the permanent UI check now checks displayed content rather than merely a successful click dispatch. Existing expired Clang module-cache debug-information warnings remain; they did not fail compilation or these checks.

## Preserved evidence

[capture.tar.gz](../../../artifacts/sevra-capability-fixes-2026-10-14/capture.tar.gz), SHA-256 `972e1869a6b3b2cfa6f3ef42f91991f0166335ec838f35804ee37c4ef71d06dc`, preserves 46 hash-verified evidence members: code/harness sources, failing and passing build/check logs, model preflight refusals, exact build identities, before/after symbol checks, synthetic bundle smoke output and help-panel screenshots. User Homes, model weights, binaries and process inventories are excluded. Timings are diagnostics from a live desktop, not clean performance evidence; `discarded: true` excludes performance qualification only.
