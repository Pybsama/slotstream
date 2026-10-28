> **Archived October 26, 2026.** The Mac app and its Home integrations are no
> longer maintained in this repository. The guide below describes the fixed
> archive revision `ca4bd6869f394a5d03ddb459e8202ad897d1d03a`; its build commands
> apply only to that checkout. See the [archive index](../experiments/mac-app/README.md)
> for source, tests, licenses and reproduction instructions. Existing local
> Homes and model downloads are not removed. Current engine setup is in
> [Getting started](GETTING-STARTED.md).

# Homes, data and integrations

A Slotstream Home contains its own conversations, memory, journal and app data.
The **Current Home** switcher at the top of the sidebar chooses the active Home.
The **Data** view lets you inspect its saved records without changing them.
The same Home can be used from the terminal or an MCP client.

## Browse your data

Open **Data** in the sidebar or **View → Data** (⌘3). The current Home's name and
path stay visible. Choose a collection:

- **Records:** user records and data saved by mini-apps.
- **Sources:** saved source evidence.
- **Conversations:** saved thread records, with an action to open the conversation.
- **Activity:** immutable conversation events and their saved evidence.
- **Advanced:** the app's saved state and unsent drafts.
- **Schemas:** declared record types and field requirements.
- **Database log:** db.md maintenance entries, when present.

Search matches literal text without regard to case. Filter by record type or a
structured `field=value`, then sort by update time, title or path. Results have
explicit pages and counts. If the data changes while paging, refresh before
continuing. Select a record to inspect its fields, exact saved content, links,
backlinks and file fingerprint. The compact layout opens details with a back
action; larger windows keep results and details side by side.

Memory and Journal remain their own native editing views and are reachable
from Data. Browsing does not make a record available to the model as memory.
Use **Memory** to admit, correct or forget memories. App-owned state, drafts
and immutable evidence are read-only in Data; use the corresponding native
controls to change them. There is no SQL layer or SQL console.

## Install the command and skill

Open **Data → Connections** and choose **Install command line tool**. The app
bundles `slotstream-home` and its pinned dbmd helper. Installation creates a
link in `~/.local/bin`; the independent `slotstream` engine command keeps its
existing behavior. Moving or replacing the app may require reinstalling that
link. An unrelated existing command is never overwritten.

If a new shell cannot find the command, add `~/.local/bin` to PATH, or invoke
`~/.local/bin/slotstream-home` directly. The bundle can also install it:

```bash
/path/to/Slotstream.app/Contents/Helpers/slotstream-home install-cli
slotstream-home --help
slotstream-home homes list --json
```

Connections also installs the bundled `slotstream-home` skill for Codex or
Claude Code. The CLI equivalents are:

```bash
slotstream-home skill install codex
slotstream-home skill install claude
slotstream-home skill show
```

A custom existing skill is preserved. Restart or refresh your agent's skill
discovery after installation. The skill explains Home selection, retrieval,
pagination, privacy and the app's review boundary; it does not supply a model.

## Select a Home

```bash
slotstream-home homes create "$HOME/Slotstream/Research"
slotstream-home homes add "/Volumes/Work/Project Home"
slotstream-home homes use "$HOME/Slotstream/Home"
slotstream-home data list --home "$HOME/Slotstream/Research" --json
```

Selection resolves an explicit `--home` first, then `SLOTSTREAM_HOME`, then the
shared registry's selected Home. An explicit value can be a full path, a
registry ID or an unambiguous registered name. `homes create` creates and
selects a new Home; `homes add` registers an existing one. `homes use` changes
the default for subsequent commands and the next app launch. It does not
interrupt or silently switch an already open app. Opening a Home in the app
updates the same default, and the switcher's list refreshes from the registry.
A command or server binds its Home once; later default changes cannot redirect
it. Prefer explicit paths for scripts and agent connections.

The registry lives at `~/Library/Application Support/Slotstream/homes.json`.
It contains navigation metadata, not Home contents or credentials. Existing
app selections migrate into it without moving data. New users start at
`~/Slotstream/Home`; an existing legacy `~/Sevra/Home` remains discoverable.
A missing Home is reported instead of creating an empty replacement.
`homes forget PATH_OR_ID` removes only a registry entry, never its data; select
another default first if necessary.

## Query records

```bash
slotstream-home data list --section records --json
slotstream-home data search "workshop" --section sources --json
slotstream-home data list --type task --where status=open --sort title --json
slotstream-home data show records/tasks/workshop.md --json
slotstream-home data schema --json
slotstream-home data log --json
```

Repeated `--where` filters are combined with AND. `--section` selects the
collection. A list returns `total`, `records`, `nextOffset` when another page
exists, and `revision`. Continue the same query with `--offset` and `--revision`.
Record details include `sha256`, fields, body, links and backlinks. Oversized
responses and unsupported queries return an error instead of silently
reporting partial results as complete. Metadata comes from db.md sidecars;
raw external imports must follow db.md's index maintenance contract.

Reads attach to the app's authenticated local owner while it is open. With the
app closed, they briefly acquire the Home lock and read through the official
helper without loading a model or rewriting saved conversation state. Raw
dbmd writes into runtime-owned records are not a supported integration path.
Incognito data and device credentials are not exposed.

## Ask the local app

```bash
slotstream-home ask "Summarize what we decided in this conversation." --home "$HOME/Slotstream/Home"
slotstream-home status --home "$HOME/Slotstream/Home" --json
slotstream-home stop --home "$HOME/Slotstream/Home"
```

Open that Home in Slotstream first. `ask` uses the app's selected local model,
thread context, admitted memory and authorized attachments. It does not
implicitly read every record in the Home or use a hosted fallback. Add
`--thread ID` for a saved thread and `--think` to enable thinking there.
The command prints an acceptance nonce and run ID. Reuse the same `--nonce`
when reconciling an uncertain submission; do not blindly submit a duplicate.
A proposal awaiting review is reported as such and must be reviewed in the
native app. Disconnecting an observer does not cancel accepted work; an
explicit stop or Ctrl-C requests cancellation.

The older `slotstream-local chat --prompt TEXT` development command remains
compatible. Its explicit `--dbmd PATH` standalone-owner mode is for development;
normal installed `ask` commands use the open app.

## Connect an MCP client

**Data → Connections → Copy MCP configuration** produces a stdio configuration
bound to the visible Home and the app's bundled executable. The CLI also prints
an example with `slotstream-home mcp-config --home PATH`. Merge the server entry
into the client's existing configuration using that client's settings.

```json
{
  "mcpServers": {
    "slotstream-home": {
      "command": "/absolute/path/to/slotstream-home",
      "args": ["serve", "--home", "/absolute/path/to/Home"]
    }
  }
}
```

The client starts the process and speaks MCP over stdin/stdout. No network port,
cloud account or separate model is needed. Default tools are `home_info`,
`data_list`, `data_show`, `data_schema` and `data_log`. They work with the app
open or closed. Adding `--allow-ask` also exposes `ask`, `run_status` and
`run_stop`; these attach to the open app. `ask` returns a run ID immediately,
then the client observes completion or pending review with `run_status`.
There is no tool to approve a proposal or bypass native review.

This server implements the [MCP stdio transport](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports).
It is a local integration; an HTTP listener, remote publication and SQL are
outside this implementation.

## Development checks

`Tools/check_slotstream_mac.sh` includes the native browser and Home switcher
checks plus `Tools/check_home_integration.py`. The integration suite uses real
dbmd records, separate disposable Homes, actual CLI subprocesses, MCP messages
and the protected local owner socket. Inference in this suite is scripted to
verify transport, durable acceptance and review behavior without loading model
weights. Real-model qualification remains a separate app check.
