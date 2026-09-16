# Sevra for Mac

Sevra is being built as a native personal AI application around Slotstream.
The development app lives under `apps/macos`. This is ongoing implementation,
not an announced alpha or a supported installer.

## Native philosophy

Product behavior is shared through Markdown/text specifications, schemas and
declarative fixtures. Each platform owns its UI, runtime, memory, tools,
permissions and inference integration. Independent upstream libraries are
allowed; sharing application source is not a requirement.

Mac uses SwiftUI and AppKit/TextKit over a Swift application runtime. That
runtime calls Slotstream in process and uses the official bundled dbmd tool
for deterministic file-database operations. Metal and dbmd keep their own
implementations. The native interface needs no web server or account.
Slotstream itself is native Swift on MLX and Metal end to end
([native stack](ENGINEERING.md#native-stack)), which is what makes the
in-process call possible.

The [engineering specification](../db/records/design/sevra-spec/overview.md)
owns the detailed contracts. Its
[implementation ledger](../db/records/design/sevra-spec/implementation-status.md)
distinguishes code, observed behavior and unpassed qualification. Windows and
Linux have independent implementation plans; this change builds the Mac app.
Cloud development, paid sync and remote inference remain deferred until users
ask for them.

## Build and run locally

Use a Mac development checkout with Swift Command Line Tools, the existing
Slotstream dependencies and Metal resource, and the official dbmd executable.
Set `SEVRA_DBMD` to the reviewed absolute executable path if it is not installed
at the default location used by the build script.

```bash
bash Tools/build_sevra_mac.sh
open .build/Sevra.app
```

The script copies the runtime dependencies into the development bundle and
ad-hoc signs it. Developer ID signing, notarization, the installed updater and
clean-machine qualification are separate work. A successful ad-hoc build does
not establish a trusted public distribution.

By default the app opens `~/Sevra/Home`. For disposable development data, launch
the executable directly with a dedicated Home:

```bash
SEVRA_HOME="$HOME/Sevra/DevelopmentHome" .build/Sevra.app/Contents/MacOS/Sevra
```

The current integration verifies and uses the existing Slotstream model
location. Settings can check that installation or explicitly download, resume
or repair its pinned files. Opening Sevra starts no download. Fresh-download
and cancellation qualification remain separate from the installed-model test. No model is loaded merely to inspect history or edit a draft. Before
running real inference, follow the repository's memory-safety rules and stop
any other model process you own. Never stop somebody else's process without
coordination. The bounded functional-test configuration is documented in the
[Mac baseline](../db/records/design/sevra-spec/mac-platform.md); it is not yet a
qualified automatic product recommendation.

The current engine keeps its model-process lock until the process exits.
After running inference in Sevra, quit Sevra before starting another model
process; the Unload control alone does not release that process-wide lock.

## Exercise the local workflow

Open a new thread, attach an ordinary UTF-8 text file or a small folder of text/source files,
and ask Sevra to read them and propose a cited briefing. The model can request
bounded reads but cannot change the source folder. Review the complete document
before choosing **Save document**. Saved artifacts use create-only publication
inside the Home. Unsupported rich formats are explicitly unavailable until
their extraction isolation is qualified.

Settings exposes System, Light and Dark. System follows macOS; overrides
persist. Saved drafts and threads reopen with the same Home. Incognito is a
separate session and cannot create persistent memories or staged artifacts.

After a completed Home exchange, **Continue in thread** opens a work thread
with that exchange visibly labeled **From Home**. The original messages stay
in Home and are quoted by reference. Further messages in Home do not become
part of the continuation. **Open thread** returns to the existing continuation;
repeated clicks do not create duplicates. **View in Home** returns to Home.
The continuation keeps the memory scope, and both composers retain their own
drafts. File attachments and approval authority stay with the original thread;
attach a file again to let the continuation read it. Search, copy and export
include the visible quoted exchange. Forget still suppresses its source from
future AI context without erasing the inspectable history.

## Draft saving and regression checks

The composer serializes draft writes and tracks each acknowledged revision
independently of the display refresh. Typing during a save stays in the editor;
the writer drains the latest text before switching threads or closing. Send
accepts the message and updates its draft in one durable transaction. A pending
save cannot restore a sent message. Incognito closing drains pending work
before removing the thread.

Recoverable revision changes are handled quietly. A real competing draft offers
both versions for an explicit choice. Save failures keep the text visible, offer
Retry Save and Copy Draft, and prevent closing with unpersisted edits. Send
retries reuse an acceptance nonce so an uncertain result cannot create a
duplicate message. Successful recovery clears its own warning.

Journal uses the same draft coordinator. Unsaved entries survive reopening,
and Save entry commits the entry and remaining draft together. Repeated clicks
and uncertain-result retries keep one accepted entry. Text typed while saving
remains available for the next entry. Model-file verification also checks for
cancellation between bounded reads, so Stop does not wait for a complete hash
scan.

Run the Mac development regressions without loading a model:

```bash
bash Tools/check_sevra_mac.sh
```

The script builds the app and local CLI, then checks the production composer
state machine with delayed and failing storage, native Markdown presentation,
and the runtime using scripted inference and real dbmd persistence. Disposable
Homes exercise restart, crash recovery, tool boundaries and data isolation.
Native UI walkthroughs and real-model checks remain separate evidence; this
suite does not qualify every OS, input method, accessibility mode or release.

## Home backup and recovery

Settings → General → **Back up Home…** saves a verified folder containing saved
conversations, drafts, memories, journal and owned files. **Reveal backup** opens
its location. Attached source folders and model weights remain separate; a
retained citation is only an excerpt of its original source. Device credentials,
source grants and Incognito content are excluded.

**Restore backup…** creates a new Home beside the backup or in another folder.
It refuses an existing destination and verifies the declared files before
publishing the restored copy. Opening that copy keeps AI paused for a dated
privacy review. Inspect Knowledge first. Known newer Forget decisions from the
current Home are retained; a backup restored without that current state may be
missing later privacy choices. Enabling AI does not restart old jobs, reattach
sources or approve a document. Large Homes and physical power-loss recovery
still need broader qualification.

When a saved draft changes in another editor, **Inspect Home changes…** shows
the changed text. **Adopt reviewed drafts** accepts only the exact version you
reviewed and preserves local conflict records. If the composer also has unsaved
text, the existing two-version choice protects it. This works after restart,
although a previous draft that was never retained is explicitly unavailable.
Drafts and conflict records are excluded from AI context. Changed conversation
evidence, missing records and malformed drafts remain paused for recovery;
arbitrary edits to owned state are not silently imported.

## Long conversations and inspectable context

Sevra keeps the full saved conversation while selecting a bounded recent window
of complete exchanges for each request. Older partial excerpts are labeled as
such. **Context** shows which messages and saved memories were used and what was
omitted. An oversized current request or pinned Home exchange is refused with
its text preserved; attach long material as a source instead.

Saved memories are selected by word overlap with the request, thread scope and
recency, within a bounded budget. This is deterministic retrieval, not a claim
of semantic recall. Forget excludes the source event from future windows and
derived excerpts. New Thread only conversations may read shared memories but
keep newly saved memories within that thread. Older Thread only conversations
retain their stricter reading scope until you explicitly allow shared memories.
Incognito uses neither saved memories nor persistent conflict records.

## Brand and native UI review

The unified macOS toolbar brings the window controls, sidebar toggle, current
page, memory status, Search and three-dot actions into one row. Long thread
titles truncate while their full text remains available to accessibility and
in the tooltip. Control-Command-S toggles the sidebar or compact navigation.
The actions menu follows the current thread and includes Settings.

The heading follows the sidebar divider as navigation resizes, and sits beside
the native navigation controls when the sidebar is hidden. Conversation text,
composer, status and document actions share a reading column. Search, Journal
and Knowledge use matching gutters. Sidebar icons and row spacing follow a
consistent grid; document titles, text and footer actions align in split review.

Settings separates General, Model and Keyboard into native sections. General
holds appearance and Home location; Model keeps automatic memory and readiness
controls together, with usage details available through a disclosure. Model-file
checks show their own progress and readiness. Keyboard lists the same shortcuts
used by the app menus.

Search supports arrow-key selection and Return to open the selected thread.
Arrow keys remain with the input method while composing text. Escape closes
native Find before leaving a document, and returns from a panel to the
conversation. Memory choices show their selected scope; Incognito explains its
restriction instead of offering scope changes it cannot apply. Knowledge uses
plain save/forget wording and explains memories that are too long to save.

The sidebar uses the approved Observer mark and lowercase Poppins wordmark.
The app bundle includes a multiresolution Observer icon for Finder, the Dock
and About. Both the command-line bundle script and Xcode target package it.
To regenerate the icon from the same native vector used by the sidebar:

```bash
bash Tools/generate_sevra_icon.sh
bash Tools/build_sevra_mac.sh
```

The source mark retains the approved geometry; the rounded warm tile is specific
to the Mac app icon. Modern layered-icon qualification through
[Apple's Icon Composer workflow](https://developer.apple.com/documentation/Xcode/creating-your-app-icon-using-icon-composer)
remains release work.

A native walkthrough verified the logo in Light and Dark, appearance persistence,
Save and relaunch, saved-document viewing, large text, narrow navigation, draft
continuity through appearance changes and scoped Find. **Open document** now
shows the current saved UTF-8 file inside Sevra, with a separate Finder action.
Its owner-mediated preview has a bounded read and refuses symbolic links.
Saved documents also remain available from the conversation’s **Documents** menu
after later messages. Earlier citations resolve to their own retained run and
source excerpt, including after reopening the Home.

The runtime validates the complete tool response before executing any call.
It can request bounded schema feedback for unsupported argument keys or a
recognized tool-name spelling mistake. The rejected response executes nothing;
the model must return a valid new response, and saving still requires exact
document approval. The final adversarial replay passed this path with the real local model,
including correction, cited proposal, exact approval and reopening the saved
file. This qualifies the bounded fixture, not every possible user task.
See the [feature audit](../db/records/design/sevra-spec/implementation-status.md#adversarial-mac-app-review)
for the current evidence and open requirements.

The conversation and saved-document view render headings, emphasis, lists,
quotes, syntax-colored code and native tables. Code has an exact-copy action;
the outline jumps to headings, code blocks and tables. Standard selection and
Find operate within the loaded history page. Earlier/Newer navigate bounded
pages; Copy conversation and Export Markdown preserve the complete source.
Raw HTML stays literal, images do not download, and opening a web link requires
a destination review. Evidence links resolve only to excerpts supplied by the
native owner. Unsupported or oversized Markdown remains readable as source.

Hover over the conversation icons for their native help: **Outline** jumps
to a heading, code block or table and appears when the rendered view has
sections to navigate. **Conversation options** holds Markdown source, copy,
export and Find. Document previews have their own options and Find; source
mode and Find stay scoped to the pane you choose.

**Jump to latest message** is a round down-arrow above the composer. It appears
when newer content is below or you are reading an earlier page, and disappears
at the latest message. Click it or press **⌃⌘↓** to return to the newest content.
New output follows while you are at the bottom; scrolling up or selecting text
preserves your reading position. Sending your own message returns to the latest
page while keeping the composer focused. The shortcut also appears in the View
menu and Keyboard settings.

The composer grows with the draft, retains native Undo and marked-text handling,
and accepts a file or folder through its picker, drag or paste. Thread controls
cover pin, rename, lifecycle and memory scope. Review opens beside the conversation
when space allows; compact windows use explicit navigation and a single document
pane. Search, Settings and document commands have deliberate focus behavior.

Markdown parsing uses the upstream Swift Markdown library off the UI thread.
Completed messages are cached during streaming. Native tables use AppKit's
compatible text-layout path deliberately; this does not claim a wholly
TextKit 2 implementation. The Markdown dependencies' notices ship in the app.

This remains a development interface. Complete screen-reader/IME qualification,
live OS accessibility transitions, sustained interaction and measured frame,
latency and memory budgets still require the full native test matrix. Ad-hoc
builds do not establish installed-release quality. The
[implementation ledger](../db/records/design/sevra-spec/implementation-status.md)
records the exact observed scope and remaining gates.

## Memory and readiness

Settings → Model → Memory budget defaults to **Automatic (Recommended)**. The app uses
Slotstream’s memory planner and elastic cache governor, keeping the current
text model and context fixed while adapting cache residency to the Mac and
other applications. The recommendation inherits the engine’s measured
operating ceiling; it is not a promise of optimal performance on every Mac.

**Custom limit** means “use up to” the selected budget within the displayed
supported range. It retains automatic pressure protection. The saved limit
stays stable when available memory changes. Settings distinguish the app’s
physical memory use from its estimated current allocation budget. Unified
CPU/GPU memory is counted once.

The model loads with the first request. **Keep model ready → Automatic**
releases it after inactivity, with a bounded delay informed by observed
preparation time and power conditions. **While app is open** favors warm
follow-ups but still yields to memory pressure and sleep. **Release memory
now** preserves saved conversations and personal memory. It does not create
a disk cache of private inference state.

Budget changes during a response apply after that job finishes. New messages
wait through the short resource handoff. Closing the window follows the
existing accepted-work policy; quitting drains work and releases the model.
Sleep stops active work and interrupts queued work. Wake permits new requests
without replaying interrupted actions. An unavailable memory reading or a
configuration that cannot fit produces an explicit refusal. The full
conversation stays on disk while each request uses its disclosed context window.

The native lifecycle and policy checks are in the ordinary regression runner.
The separate `--performance-real --home <new-disposable-directory>` check uses
a bounded custom budget to exercise lazy loading, warm reuse, changing a budget
during generation, release/reload, responsive metadata and automatic idle
release. Follow the same model-process and headroom rules as the real fixture
below. Full hardware qualification and clean paired performance measurements
remain separate from these functional checks.

## Checks and internal CLI

```bash
swift build --package-path apps/macos -c release --product sevra-mac-checks
apps/macos/.build/release/sevra-mac-checks
swift build --package-path apps/macos -c release --product sevra-presentation-checks
apps/macos/.build/release/sevra-presentation-checks
swift build --package-path apps/macos -c release --product sevra-local
apps/macos/.build/release/sevra-local --help
```

The check runner uses fake inference and real dbmd mutations in disposable
Homes. It does not load the large model. Real-engine and native interaction
results must be recorded separately. The internal `sevra-local` executable
does not replace the existing `sevra` compatibility CLI. An active Home is
exclusive. The internal CLI attaches through a user-local authenticated Unix
socket to the existing owner, or acquires the Home lock itself when given an
explicit dbmd executable. It never starts a second owner for an active Home.
Incognito is unavailable to this initial CLI attachment.

```bash
apps/macos/.build/release/sevra-local status --home "$HOME/Sevra/Home"
apps/macos/.build/release/sevra-local chat --home "$HOME/Sevra/Home" --prompt "Hello"
```

The app must already own that Home for these commands. A CLI connection may
detach while the app continues its accepted job. Preserve the printed nonce
to reconcile uncertain submission; a lost response is not permission to retry
with a new request id. The optional network server is not implemented.

The real-model fixture additionally exercises source reading, citation review,
create-only document publication and reopening its durable Home. Run it only
under the repository memory rules, with a new disposable destination:

```bash
cp Tools/lib/mlx-0.31.1.metallib apps/macos/.build/release/mlx.metallib
apps/macos/.build/release/sevra-mac-checks --real \
  --source "$PWD/apps/macos/Fixtures/private-workspace-brief" \
  --home "$PWD/.build/sevra-disposable-real-check"
```

The harness reviews a synthetic fixture after checking its frozen rubric. It
does not certify the native Save button, appearance, accessibility or public
release. See the implementation ledger for observed and pending evidence.

Slotstream's original CLI, serving APIs, library products and package coordinates
remain independently usable. This application work does not rename the public
repository, publish a release or change existing credentials and services.
