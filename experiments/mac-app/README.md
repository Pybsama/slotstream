# Native Mac app archive

Archived on October 26, 2026. Slotstream now focuses on its native Swift/MLX/Metal
inference engine, CLI and serving APIs for Qwen3.8-Flash-Next 4-bit.

The complete Mac app is preserved at
[`ca4bd6869f394a5d03ddb459e8202ad897d1d03a`](https://github.com/carloslfu/slotstream/tree/ca4bd6869f394a5d03ddb459e8202ad897d1d03a/apps/macos),
with the Git tag `archive-mac-app-2026-10-26`. This is an archive tag, not a release.
It includes the SwiftUI/AppKit interface, Home storage, Data browser,
`slotstream-home` CLI, MCP server, agent skill, resources and licenses, plus
the app's build scripts, tests and CI workflow. They are no longer maintained
or built on `main`.

To inspect or reproduce the app in a separate checkout:

```sh
git worktree add --detach ../slotstream-mac-app-archive ca4bd6869f394a5d03ddb459e8202ad897d1d03a
```

Read the [archived app guide](../../docs/SLOTSTREAM-MAC.md) and
[Home integration guide](../../docs/SLOTSTREAM-HOMES.md) from that checkout.
Their original documentation paths remain available for historical links.
The archive contains source and development builds, not a qualified public
installer. Follow its memory and single-process safeguards before loading a model.

The latest app included relevant conversation retrieval, literal JSON storage
and interrupted-save fixes. Those were app changes, not changes to the
independent engine. [The verification record](../../db/records/measurements/single-model-maintenance.md)
preserves their checks and limits. Earlier plans and measurements remain dated
history; archiving them does not turn pending work into completed features.

This repository change does not uninstall a local development bundle or remove
Homes, preferences, model downloads or other user data. Existing app bundles
keep their embedded engine; updating the independent CLI never updates them.

[Engine-only maintenance decision](../../db/records/decisions/engine-only-maintenance.md).
