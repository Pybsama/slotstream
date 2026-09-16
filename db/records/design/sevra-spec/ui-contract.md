---
type: native-spec
meta-type: operational
id: 01m2gb63b06sdk41zzcbfevt7c
created: 2026-09-14T16:14:44.064879+00:00
updated: 2026-09-16T20:06:24.453141+00:00
summary: Mac UI geometry, native text, appearance and review requirements
---
# Mac native UI contract

S2c/S2h: Compose with SwiftUI and native AppKit controls. The conversation is one logical selectable TextKit document, not one selectable island per message. Preserve IME composition, cross-message selection, standard Copy/Undo/Find and logical scroll state while streaming. Token arrival must not move focus. Native controls use system fonts; content retains Inter, Poppins and the approved Observer identity when packaged.

System is the default appearance. Explicit Light and Dark persist across relaunch, apply before first paint and cover every app-owned view. System follows live OS changes. Light starts from warm #f4f3ee with #141414 text; Dark from #1b1b19 with #f1f0e9 text. Use semantic native colors for controls, selection and accessibility. Test contrast, Increase Contrast, reduced motion/transparency and active/inactive states on actual renders.

Initial client size 1120 by 760 points, minimum test case 620 by 480, rail 232, conversation/composer column at most 720. Narrow mode must expose an explicit navigation action, preserve memory mode, Stop and pending decisions, and keep draft/selection when switching panels.

Commands: Cmd+N New Thread; Cmd+Shift+N New Incognito Thread; Cmd+K Search Home; Cmd+F Find in the current document; Cmd+, Settings; Return Send; Shift+Return newline. Marked IME text commits normally and never submits. Closing a persistent window only detaches it; Quit stops owned work and flushes persistent drafts. Incognito closes and discards its session.

Before claiming UI-D2/D3, run visual/layout, keyboard/accessibility, then load/regression passes. Include ordinary/long/hostile documents, sustained streaming, draft/crash/stop/needs-you and live appearance transitions. The product plan's latency, frame, footprint and draft-loss budgets remain unchanged and require measurements. Screenshots and compilation do not pass unmeasured budgets. Installed alpha additionally needs the external user and screen-reader sessions; stable requires the full cumulative unfamiliar-user sessions.

[[records/design/sevra-spec/overview]]

## Current document implementation and limits

The Mac-owned presentation package pins upstream Swift Markdown and uses native AppKit attributed text. NSTextTable requires the compatible TextKit document engine; the implementation chooses it explicitly instead of silently falling back from an assumed TextKit 2 path. Review the native performance/accessibility matrix before accepting this choice for release. The public engine package remains independent.

The renderer applies a 256 KiB rich-source limit per message, depth 32, a node-work cap, and native tables up to 20 columns and 200 body rows. Larger or complex inputs remain readable as source with an explicit notice. History pages load up to 80 messages and 512 KiB aggregate source, retaining an oversized single message intact. Earlier/Newer page through the conversation without accumulating every earlier page; Find and ordinary selection cover the loaded page. Complete Markdown copy/export includes all messages. Clipboard content above 4 MiB is refused with full export offered. These are operating bounds, not measured saturation points or permission to truncate data. Changes must preserve the exact-source and history-coverage checks and requalify UI budgets.

Source coordinates use UTF-8 bytes; AppKit display/selection coordinates use native UTF-16 ranges. Code copy preserves its original decoded code exactly. Citation and code-copy links bind to their native document region, not arbitrary model-provided navigation. External links allow explicit HTTP/HTTPS destinations with no embedded credentials; HTML is literal and remote image loading is absent.

The outline and accessibility rotors expose headings, table headers and code blocks. Native table-cell semantics, cross-page selection and the full screen-reader matrix remain unqualified. Composer views retain local Undo/marked-text/caret state for a bounded recent set; older evicted views restore durable draft text but cannot promise the same Undo stack. A preference change never triggers generation or a network request.

[[sources/runs/2026/09/2026-09-14-sevra-rich-markdown-native-polish]]

## Shared layout geometry
Conversation content and its composer, status, notices and document actions share a readable column up to 720 points with 24-point minimum edge gutters. Search, Journal, Knowledge and review panels use the same grid where applicable. Native Settings retains grouped-form metrics. TextKit line-fragment padding must be accounted for explicitly so native text and SwiftUI controls align. Artifact title, text, notices, sources and footer use matching 24-point insets.

The titlebar measures native control positions and aligns its heading to the detail-pane gutter when the sidebar is visible. Window updates reconcile native grouping after panel navigation. Remove the alignment toolbar item for compact, hidden-sidebar and document-split layouts so its reserved width cannot displace the title. Preserve native traffic-light behavior and accessible memory/lifecycle status.

Sidebar rows share a fixed icon column and consistent normal/selected/hover/pressed treatment, with inactive selection subdued. Conversation speaker labels and section gaps stay distinct without full-body blank paragraphs. Preserve exact source copy/export and all native focus, selection and marked-text behavior.

Observed scope and build identity: [[sources/runs/2026/09/2026-09-15-sevra-native-layout-refinement]].

## Settings and keyboard navigation
Group native Settings into General, Model and Keyboard. Keep ordinary controls and current model state visible, and disclose detailed memory diagnostics on demand. Distinguish unchecked model files from known missing files. Every setting value and shortcut must expose its identifying label through accessibility.

Search keeps keyboard selection visible and supports Up/Down followed by Return. An active input method owns marked-text arrows. Escape closes the innermost transient interface first, including native Find, then returns from a panel to the unchanged conversation. Preserve native responder behavior and draft focus; do not add a global key monitor.

Memory menus describe the actual selected scope and show only applicable changes. Incognito cannot become a saved memory scope through that menu. Knowledge explains save/forget in plain language, hides already active saved candidates, and gives a reason for length-based refusal. This presentation does not change runtime privacy boundaries.

Scoped implementation evidence: [[sources/runs/2026/09/2026-09-15-sevra-native-ux-settings-audit]]. Full VoiceOver, live IME and the existing native qualification matrix remain required.

## Thinking controls
A native "Think longer" toggle button sits in the composer bar beside the memory scope control. It shows the thread's sticky state, is unavailable while a source is attached or AI is paused, and explains why through its help text. Its help and the composer hint carry the honest cost line: before any measured thought, "Adds time on this Mac" and that Answer now ends a thought early; afterwards the median of the last ten completed thoughts on this Mac, for example "Recently about 42 s extra". The File menu mirrors the control as "Think Longer" with a checked state and "Answer Now"; neither has a shortcut.

While a thought runs, the run status reads "Thinking… 0:42" with a live clock from the first thought token, or "Finishing the thought… 0:42" after Answer now, and an "Answer now" button appears beside Stop. A collapsed "Working notes (thinking)" disclosure streams the thought under the status; it states that the notes are not saved or remembered and are kept only while Sevra is open. After the run, one plain receipt line replaces the clock, for example "Thought for 42 s before answering", "Thought for 3 min, up to its limit, then answered", "Thought for 12 s, then answered when you asked", "Thinking stopped after 8 s" or "Thinking is off while a source is attached", and the disclosure remains while the notes are still in memory. Accessibility identifiers: `think-longer`, `answer-now`, `thinking-receipt`, `working-notes`. The thought is never part of the conversation document, copy, export, search or Find. Visual and screen-reader review of these controls is still required before the UI gates are claimed; compilation and the scripted checks do not pass them.
