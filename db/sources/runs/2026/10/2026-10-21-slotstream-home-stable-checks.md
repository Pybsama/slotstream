---
type: run
id: 01m5gvhge41rb99kmkb0c75qns
created: 2026-10-22T03:47:40.612611+00:00
updated: 2026-10-22T03:47:41.272093+00:00
summary: Complete stable-source Mac suite and pinned dbmd Home integration compatibility
binary: apps/macos release products from 0c6f328
captured_at: 2026-10-22
command: Tools/check_slotstream_mac.sh and Tools/check_home_integration.py with dbmd 0.14.0
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Stable-source Home integration verification
tool: native Mac checks and pinned dbmd
---
# Final stable-source local Home verification

Implementation commit: `0c6f328a39ad295e8117cd190ebafef6dac8cf87`.

`bash Tools/check_slotstream_mac.sh` completed with exit code 0 with the
production sources unchanged throughout. This closes the earlier local
source-identity refusal. The entire native regression suite, Home Data UI,
CLI/MCP subprocess checks and final source-identity guard passed.

The complete locally retained log has SHA-256 `eba7b2475812e680d51c55ae94d88c561a61caf83b231e4514126006429064b5`.
The following are unmodified output lines from its Home/data integration suites:

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
PASS: PATH invocation resolves the real executable for portable MCP configuration
PASS: filtering, literal search, sorting, complete pagination, schema, backlinks and byte-preserving offline reads
PASS: stale pages, bounds, traversal, symlinks, missing Homes and cross-Home isolation
PASS: concurrent Home registration and stable explicit selection
PASS: real MCP initialization, discovery, calls, error handling, read-only scope and session Home binding
PASS: live owner attachment, CLI ask and nonce reconciliation, MCP observations, Incognito exclusion and offline reopen
HOME INTEGRATION CHECKS PASS
```

## Pinned dbmd compatibility

The independently downloaded dbmd 0.14.0 tarball matched the checksum pinned
in Tools/dbmd_install.sh. It was installed in a separate disposable build
directory; the user's newer dbmd installation was preserved.

Command: `python3 Tools/check_home_integration.py --bin-dir apps/macos/.build/arm64-apple-macosx/release --dbmd .build/dbmd-ci/dbmd`, exit 0.

```text
PASS: PATH invocation resolves the real executable for portable MCP configuration
PASS: filtering, literal search, sorting, complete pagination, schema, backlinks and byte-preserving offline reads
PASS: stale pages, bounds, traversal, symlinks, missing Homes and cross-Home isolation
PASS: concurrent Home registration and stable explicit selection
PASS: real MCP initialization, discovery, calls, error handling, read-only scope and session Home binding
PASS: live owner attachment, CLI ask and nonce reconciliation, MCP observations, Incognito exclusion and offline reopen
HOME INTEGRATION CHECKS PASS
```

## Hosted state at capture

Documentation and context-proxy checks passed on the implementation commit.
The engine public-library job passed; its coverage and weights-free jobs and
both native Mac jobs were still running. Hosted completion is not asserted
by this local receipt. The app was opened normally afterward: the existing
Home remained in place and became the shared registry default, and the global
CLI read that same Home. No private Home contents are included here.

[[sources/runs/2026/10/2026-10-21-slotstream-home-data-integrations]]
