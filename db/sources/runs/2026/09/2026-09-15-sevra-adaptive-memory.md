---
type: run
id: 01m2hbg12qkqeb64wj6wmpqhf5
created: 2026-09-15T01:39:23.862814+00:00
updated: 2026-09-15T01:39:33.941745+00:00
summary: Native adaptive memory, deferred settings, safe lifecycle, real-model handoff and scoped UI verification
binary: be3a985918218d525b937d572b53d1e9f280050589f395f0e9a997343a6acfbc
captured_at: 2026-09-15
command: bash Tools/check_sevra_mac.sh; sevra-mac-checks --performance-real; native UI walkthrough
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra adaptive memory and model readiness
tool: Native Mac regression executables and UI
---
# Native adaptive memory and readiness evidence

Scoped development implementation and functional verification. This is not a
public release, universal performance recommendation, real OS-pressure stress
experiment, or physical sleep/wake qualification across supported hardware.

## Implementation

Automatic and bounded custom ceilings both use the existing planner and elastic
governor. Full feasibility checks refuse unsafe advisory floors and unreadable
availability. The runtime defers configuration until the whole job ends and
accepts new work into the queue during the handoff. A dedicated inference
executor drains autoreleased objects; governor work is drained before engine
release and unused allocator buffers are returned. Metadata reads avoid the
generation lock. Idle/keep-ready, sleep/wake admission and cancellation, saved
preferences and physical-footprint display are connected to the native app.
Context overflow explicitly refuses while preserving messages.

## Artifact identities

- `.build/Sevra.app/Contents/MacOS/Sevra` SHA-256 `be3a985918218d525b937d572b53d1e9f280050589f395f0e9a997343a6acfbc`
- `.build/Sevra.app/Contents/Resources/build-inputs.json` SHA-256 `81f97e34f0917c1423eb48e59f37f8ae46474abbb60cfbbcd3613b5d8ea65c37`
- `apps/macos/.build/arm64-apple-macosx/release/sevra-mac-checks` SHA-256 `f3ca0c75b99986e794b8633848ad12189b979033a55f74cdb0b17961cb230d7a`

The bundle input manifest matched before/after its final build and its ad-hoc
signature verified. Original CLI sizing semantics remain unchanged. Root
engine additions are a drained governor-stop API and unused allocator release.

## Regression suite

Command: `bash Tools/check_sevra_mac.sh`. Exit 0. The following tail contains
all scenario verdicts from the final complete suite. Build chatter is omitted.

```text
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
PASS: 22 composer scenarios plus real-runtime persistence checks
PRESENTATION_RENDER_MS 15.081,0.287,0.257,0.246,0.251,0.248,0.247,0.290,0.271,0.258,0.252,0.251,0.252,0.252,0.257,0.253,0.249,0.246,0.253,0.249
PASS: native Markdown structure, exact code, table attributes, inert HTML/images, link/citation boundaries, Unicode source coordinates, late references, cache reuse and limits
PASS: saved document preview, symlink refusal and read budget
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, single-file scope, sibling refusal, source symlink substitution
PASS: memory plans 28 accepted / 59 safely refused; custom ceilings, unavailable readings, persistence, stable ranges and idle/pressure policy
PASS: deferred budget coalescing, queued submission during handoff, active release refusal, idle release and draft preservation
PASS: sleep cancellation, queued interruption, unload, admission guard, wake without replay and explicit recovery
PASS: context overflow preserves messages and refuses instead of silently trimming history
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget
```

## Real-model handoff failure retained

The first bounded functional run found a real admission bug: a message sent
while the completed job was applying settings was refused as model setup.
The raw output below is retained as failed evidence. The correction queues
that message through the handoff; a controlled suspension fixture now gates it.
These timings compare different prompts and are not benchmark evidence.

```text
engine ready in 1.4s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
REAL_TURN cold seconds=15.016780041667516 status=completed
REAL_TURN warm-change seconds=7.2502761666692095 status=completed
Finish model setup before sending.
```

## Corrected real-model run

Command: `apps/macos/.build/arm64-apple-macosx/release/sevra-mac-checks --performance-real --home <new-disposable-home>`.
Exit 0. Explicit custom budgets bounded the actual allocations; initial
reclaimable memory exceeded the test budget plus headroom. No parallel model,
availability override, memory hog or paid provider was used. Global paging is
diagnostic. Idle expiry was driven through the runtime clock argument rather
than waiting out the whole idle period. Sleep coverage above invokes the
runtime lifecycle; no physical system sleep was induced.

```text
engine ready in 1.1s: expert cache ~21/512 per layer (1013 global slots = 2.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
REAL_TURN cold seconds=13.832832083331596 status=completed
REAL_TURN warm-change seconds=7.870174374998896 status=completed
engine ready in 1.0s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
elastic: on — cache auto-resizes with memory availability between requests (--no-elastic to pin)
REAL_TURN reloaded seconds=15.120076874998631 status=completed
REAL_MEMORY peak_sampled_gb=7.310872656 released_gb=1.416202664 maximum_metadata_seconds=0.13981574999343138
GLOBAL_VM before=Optional(Slotstream.ProcessMemory.VMActivity(swapins: 48, swapouts: 64, reclaimableBytes: 22625304576)) after=Optional(Slotstream.ProcessMemory.VMActivity(swapins: 48, swapouts: 64, reclaimableBytes: 21749841920))
PASS: real lazy load, warm follow-up, deferred custom change, drained release/reload, lower ceiling, automatic idle release and preserved draft
```

## Native walkthrough on the final bundle

Opened Settings and verified persisted custom memory and keep-ready values.
An accessibility Increment action changed the native slider and persisted its
value. A malformed numeric value (`10abc`) and an out-of-range value were
rejected with an inline explanation. Valid decimal entry worked. Inspected
System, explicit Light and explicit Dark settings and control contrast.
The Performance section precedes model setup and its numeric field has no
redundant visible label.

Ran one real native Incognito prompt with the bounded custom budget. Settings
remained operable during loading; changing the ceiling showed “Applies after
the current response.” The response completed with `OK`, the new budget
applied, and the model unloaded. Closed the temporary Incognito thread. Saved
ordinary Home data was preserved. Restored Automatic memory, Automatic
readiness and System appearance, leaving Settings open. This does not claim
full screen-reader, narrow-layout, actual OS appearance-transition, thermal,
physical sleep, installed-update or hardware-matrix qualification.

## Policy and remaining qualification

[[records/design/sevra-spec/mac-platform]] defines the supported profile,
operating limits, idle-delay purpose and revision criteria. Those defaults
remain development operating policy. Same-hardware paired cold/warm and model
value comparisons, broad native lifecycle/pressure qualification and public
release gates remain open. No private disk prefix cache or cloud integration
was added.
