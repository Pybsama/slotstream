---
type: decision
id: 01m5wt5xj9h9nbtcgha4saysaz
created: 2026-10-26T19:14:45.449607+00:00
updated: 2026-10-26T19:18:31.134204+00:00
summary: Retire the native Mac app and maintain only the Qwen3.8-Flash-Next 4-bit engine, CLI, APIs and Swift library.
decided_on: 2026-10-26
reversible_if: Carlos explicitly reopens app development or selects another qualified model.
title: Engine-only maintenance
status: standing
---
# Engine-only maintenance

On October 26, 2026, Carlos chose to remove the native Mac app as well as the
previously retired Fast and Q2 model tracks. Slotstream now maintains the
native Swift/MLX/Metal inference engine, CLI, serving APIs and public Swift
library for Qwen3.8-Flash-Next 4-bit. No desktop app, Home data service or
app-specific MCP integration remains in active scope.

## Preserve the work

The complete app tree, resources, licenses, Home CLI and MCP integration,
build scripts, UI/runtime checks and CI workflow are preserved at
`ca4bd6869f394a5d03ddb459e8202ad897d1d03a`, named by
`archive-mac-app-2026-10-26`. The [archive index](../../../experiments/mac-app/README.md)
provides a separate-checkout command and the historical guides. Those guides
keep their old paths for links, carry an archive notice and are excluded
from current combined documentation. This is an archive tag, not a release.

Remove the app's tracked implementation, dedicated tooling and workflow from
main. Keep the independent engine, licenses and tests. The VQ kernel test
continues to check the engine's reviewed kernel bytes and license; only its
duplicate-license assertion against the removed app bundle goes away.

Keep dated measurements, failures and app plans as history, clearly marked as
archived. Pending app gates are retired, not passed. This change does not
uninstall a local bundle or delete Homes, preferences, downloaded weights or
ignored development artifacts. Earlier app scope in
[[records/decisions/slotstream-app-identity]],
[[records/design/sevra-maintained-model-integration]] and
[[records/design/sevra-spec/overview]] is superseded. The one-model policy in
[[records/decisions/one-maintained-model]] remains, now within the engine scope.

## Release comparison

Immediately before app retirement, the net engine source difference from
v0.2.30 was one display label: "Original 4-bit" became
"Qwen3.8-Flash-Next 4-bit". Model files, quantization, group sizes, arithmetic,
MTP, lookahead, memory behavior, root dependencies, installer and serving
interfaces did not change. The app's literal JSON persistence, interrupted-save
recovery and relevant-history improvements were real app changes; the released
CLI did not call those paths. Archiving them does not expose an engine fix to
release. Retain v0.2.30 and create no release in this scope.

Qualify future engine changes through the native engine and real client
workflows, with exact arithmetic, memory, privacy and request-lifecycle gates.
A new app or successor model needs a new owner decision. Do not carry app
signing, updater, Home or UI work forward as engine release prerequisites.

## Verification

[[sources/runs/2026/10/2026-10-26-mac-app-retirement]] preserves the removed-file
inventory, exact engine diff, package graph, focused checks, document links and
CI evidence. Engine inputs remain unchanged by app retirement. Existing release
users receive no new inference fix from this scope and documentation change.
