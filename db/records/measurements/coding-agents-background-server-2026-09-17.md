---
type: measurement
id: 01m2ra78q8psy6e4wfm24kewyc
created: 2026-09-17T18:31:49.204021+00:00
updated: 2026-09-18T13:22:36.019024+00:00
summary: 'slotstream launch starts, keeps, restarts and stops its own server: 54 of 54 live checks at 12 GB, and why the window stays automatic'
date: 2026-09-17
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Functional acceptance with single-run timings on a machine with user applications open; not a paired or interleaved benchmark.
order: '1530'
runs: '[[sources/runs/2026/09/2026-09-17-launch-background-server-live]], [[sources/runs/2026/09/2026-09-17-launch-window-doctor]]'
title: 'The server slotstream launch starts: 54 live checks at 12 GB'
status: measured
---
**`slotstream launch <agent>` now starts the server itself when none is running, keeps it while agents use it, and stops it when they are done.** One command works on a Mac with nothing running: the launch starts `slotstream serve` in the background with the window the agent needs, prompt caches on disk and a log, shows the start until the model answers, registers the agent it opens, and leaves the server running for the next session. The server stops 30 minutes after the last agent exits, or at once with the new `slotstream stop`. The sources are `CodingToolLaunch.swift`, `LaunchCommand.swift`, `StopCommand.swift`, `ServerActivity.swift` and `Server.swift`; `Tools/launch_start_gate.sh` is the acceptance, and `launch-server` (94 assertions) pins the paths, messages, policy and status wire in T0.

**Setup.** One model process at a time on the development Mac with user applications open, 35 to 36 GB reclaimable at each start, port 11531, `--memory-gb 12`, a throwaway HOME per command whose `.slotstream/models` links to the real weights, Claude Code 2.1.270, Pi 0.85.1 and Hermes 0.21.1. Full output: [[sources/runs/2026/09/2026-09-17-launch-background-server-live]].

**Live result: 54 of 54 checks.**

| What was checked | Result |
|---|---|
| Nothing running, `--no-start` | Refused, named the `serve` command and `--no-start`, started nothing |
| Nothing running, `--dry-run` | Printed the server it would start, wrote nothing, started nothing |
| No agent named, a terminal | Listed the installed agents and planned the one chosen |
| A Hermes folder without the `slotstream` provider | Refused before any server started |
| First launch, nothing running | Claude Code answered in 424 s, including the server's start and its 15,284-token first prompt; the server kept running with 0 clients after it exited, in its own session, with the recorded process id, the disk cache, the memory target and the 30-minute stop |
| Second launch | Answered in 162 s, reusing 41,038 prompt tokens from the running server, started nothing, named its log and the running server's 12 GB target against the 11 GB asked for |
| Hermes against that 32,768-token server | Restarted it with `--max-context 65536` and answered in 118 s; the old process was gone and the new one recorded |
| `slotstream stop` | Stopped it, removed the record, released the model lock, logged `stopping: asked to stop (SIGTERM)`; a second stop said nothing was running |
| Two launches at once | One server, the other waited for it and both agents answered in 28 and 31 s |
| `--idle-exit 0.25` with a registered process | Stayed while that process ran, past the idle time, and stopped 18 s after it exited, logging the reason |
| A server started by hand | Hermes refused it and left it running; Claude Code used it and pointed at its window; `slotstream stop` stopped it |
| Control-C while the server starts | Exit 130, the server stopped, its record removed |
| `slotstream stop` while the server starts | Stopped it and said so; the launch reported `Slotstream stopped while starting` with the server's own SIGTERM line above it |

**Why the automatic window, and not 65,536 for every agent.** The guides recommended `serve --max-context 65536` for coding agents. A launch that forced it on every Mac would cost more than it gives at small memory targets: `slotstream doctor` prices the same plan at 12, 10 and 9 GB in [[sources/runs/2026/09/2026-09-17-launch-window-doctor]]. The launch therefore keeps the automatic window, which is never below 32,768 tokens, and asks for 65,536 only for Hermes, whose own `MINIMUM_CONTEXT_LENGTH` refuses less.

**Limits.** Single runs on a machine with user applications open, one request at a time; the timings describe this Mac's SSD and these short tasks and are not a benchmark. Only the 12 GB target ran live, with Claude Code, Pi and Hermes; Codex and opencode are covered by the plan checks and the older live pass, not by this gate. The idle stop was exercised at 0.25 minutes, not at its 30-minute default; what the default changes is when the memory comes back, not the mechanism. Three earlier passes of this gate, on earlier builds, are described in the run record: their failures were two wrong checks and one stale record a Control-C left behind, all fixed here.
