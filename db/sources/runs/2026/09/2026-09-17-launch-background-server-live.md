---
type: run
id: 01m2ra59tazcpgz68yexeeg729
created: 2026-09-17T18:30:44.810525+00:00
updated: 2026-09-17T18:30:55.688247+00:00
summary: 'slotstream launch starts, records, reuses, restarts and stops its own server: 54 of 54 live checks at 12 GB'
binary: 918a1da5ecc21c921f499447a9fe6b720973f4a955799b4ffdabb23d5668d875
captured_at: 2026-09-17
command: AGENT_PATH=<agents> Tools/launch_start_gate.sh .build/arm64-apple-macosx/release/slotstream <out>
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: slotstream launch and its background server, live at 12 GB with Claude Code, Pi and Hermes
tool: Tools/launch_start_gate.sh
---
Captured 2026-09-17 on the development Mac with user applications open and another session's measurement running between phases, one model process at a time: each phase that loads the model waited until no Slotstream process ran and the model lock was free for 60 seconds, with 35 to 36 GB reclaimable at each start.

Binary: SHA-256 `918a1da5ecc21c921f499447a9fe6b720973f4a955799b4ffdabb23d5668d875`, a local `swift build -c release` of the coding-agent worktree on `main` 6e25b00 (0.2.20) with the background-server work: `slotstream launch` starts, records, reuses, restarts and registers agents with its own server; `slotstream stop`; `serve --idle-exit`; `GET /slotstream/status` and `POST /slotstream/clients`. Gate script SHA-256 `78c69d27e6c2e42864183cf9759fcd177081aa1b230cc883d7b6523f323cb101`.

Agents: Claude Code 2.1.270, Pi 0.85.1 and Hermes 0.21.1, with Node 22.18.0 for Pi. Every command ran with `env -i` and a throwaway HOME whose `.slotstream/models` links to the real weights, in a fresh git project, on port 11531 with `--memory-gb 12`.

Command, with the gate as it is in the repository:

```
AGENT_PATH=<agents> Tools/launch_start_gate.sh .build/arm64-apple-macosx/release/slotstream <out>
```

Result: **54 checks passed, 0 failed**, 13:07:16 to 13:29:57. Output, with each server's repeated memory-plan block after the first shortened and the output folder written `<out>`:

```
== nostart 13:07:16
  nostart: exit 1 in 0 s
    err: slotstream launch: no Slotstream server answered on port 11531. Start it in another Terminal window with `slotstream serve --port 11531` and run this again, or run this without --no-start and launch starts one.
PASS  --no-start refuses when nothing answers
PASS  --no-start starts nothing
== dry 13:07:16
  dry: exit 0 in 0 s
PASS  a dry run succeeds with nothing running
PASS  a dry run describes the server it would start
PASS  a dry run starts nothing and writes no record
== picker 13:07:16
    ^D1
    Which agent should Slotstream start?
      1. Claude Code (slotstream launch claude)
      2. Codex (slotstream launch codex)
      3. Pi (slotstream launch pi)
      4. opencode (slotstream launch opencode)
PASS  a terminal is asked which agent to start
PASS  the chosen agent is planned
  picker-pipe: exit 1 in 0 s
    err: slotstream launch: name the agent to start, for example `slotstream launch claude`. Installed: claude, codex, pi, opencode, hermes.
PASS  without a terminal, launch asks for the agent's name
== settings 13:07:16
  settings: exit 1 in 0 s
    err: slotstream launch: <out>/hermes-other/config.yaml has no `slotstream` provider. Add the configuration from docs/HERMES.md, or set HERMES_HOME to a new folder and run this again.
PASS  a Hermes folder without the slotstream provider is refused
PASS  before any server starts
== start 13:07:16
model slot idle (13:08:20): 35 GB reclaimable
  start: exit 0 in 424 s
    err: Starting Slotstream in the background: slotstream serve --port 11531 --memory-gb 12 --prefix-cache-dir <out>/home/.slotstream/prefix-cache --idle-exit 30
    err:   slotstream memory plan (--memory-gb)
    err:     device: 52 GB RAM (35.8 GB reclaimable now), 40.2 GB Metal working set
    err:     target: 12.0 GB total for this process
    err:     cache:  ~31 of 512 experts per layer  (1491 global slots = 4.1 GB pool)
    err:     expect: ~11.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
    err:     disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
    err:     prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
    err:     vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
    err:     context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
    err:     reuse:  up to 20616 tokens across 4 conversations (~0.9 GB), so a follow-up turn re-prefills only what is new
    err:     window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to a typical request; --max-context N chooses another window up to 262144
    err:   engine ready in 0.8s: expert cache ~31/512 per layer (1491 global slots = 4.1 GB), eos [248044, 248046]
    err:   prefix cache disk: <out>/home/.slotstream/prefix-cache holds 0 states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
    result='LAUNCH ONE' input=17801 cache_read=28182
PASS  Claude Code answers through a server launch started
PASS  launch says it starts the server, and where it runs
PASS  the server's start is shown in the terminal
    server pid 77710; status: window 32768, clients 0, idle stop 30 min
PASS  the server outlives Claude Code
PASS  no client is left once Claude Code exits
PASS  launch recorded the server it started
    /Users/carlos/Projects/slotstream-coding-tools/.build/arm64-apple-macosx/release/slotstream serve --port 11531 --memory-gb 12 --prefix-cache-dir <out>/home/.slotstream/prefix-cache --idle-exit 30
PASS  it runs with the disk prompt cache, the memory target and the idle stop
    session of the server: 77710; of this gate: 76718
PASS  it leads its own session, out of the Terminal's reach
PASS  its log holds the start
PASS  the window is the automatic one, which fits Claude Code
== reuse 13:15:25
  reuse: exit 0 in 162 s
    err: The server on port 11531 was already running with a 12 GB memory target, so --memory-gb 11 did not apply. Stop it with `slotstream stop --port 11531` and run this again to start one with that target.
    err: Claude Code will use qwen3.8-flash-next:4bit with a 32768-token window.
    err: Claude Code's instructions and tools take about 15,000 tokens of that window. For longer sessions, stop the server and start it yourself with `slotstream serve --max-context 65536`; `slotstream doctor --max-context 65536` first shows how much of a conversation this Mac keeps at that size.
    err: Starting Claude Code. Its first reply reads the whole prompt; `tail -f <out>/home/.slotstream/logs/serve-11531.log` shows its progress.
    err: [claude-code:unrecognized_model] {"model":"qwen3.8-flash-next:4bit","query_source":"sdk"}
    result='LAUNCH TWO' input=4511 cache_read=41038
PASS  a second launch answers
PASS  it uses the running server and starts nothing
PASS  it says another memory target did not apply, and which one runs
PASS  it points at the server's log for progress
PASS  Claude Code's instructions come from the cache (41038 tokens)
== restart 13:18:07
  restart: exit 0 in 118 s
    err: Restarting Slotstream: the server `slotstream launch` started on port 11531 has a 32768-token window and Hermes needs 65536.
    err: Starting Slotstream in the background: slotstream serve --port 11531 --max-context 65536 --memory-gb 12 --prefix-cache-dir <out>/home/.slotstream/prefix-cache --idle-exit 30
    err:   slotstream memory plan (--memory-gb)
    err:   ... (plan lines as above)
    err: Slotstream is running in the background on port 11531. It stops 30 minutes after its last agent exits; `slotstream stop --port 11531` stops it sooner. Its log is <out>/home/.slotstream/logs/serve-11531.log.
    err: Created <out>/home/.hermes-slotstream/config.yaml for Hermes, following docs/HERMES.md.
    err: Hermes will use qwen3.8-flash-next:4bit with a 65536-token window.
    err: Starting Hermes. Its first reply reads the whole prompt; `tail -f <out>/home/.slotstream/logs/serve-11531.log` shows its progress.
    out: Session:        20260917_131817_1248f8
    out: Title:          Read note.txt content
    out: Duration:       1m 47s
    out: Messages:       4 (1 user, 2 tool calls)
PASS  Hermes answers
PASS  launch restarted its idle server with Hermes's window
PASS  the old server is gone and the new one is recorded
PASS  the new server was asked for the window
== stop 13:20:06
  stop: exit 0 in 1 s
    Stopped the Slotstream server on port 11531.
PASS  slotstream stop ends the server
PASS  the record and the model lock go with it
PASS  the log says why it stopped
  stop-again: exit 0 in 0 s
PASS  a second stop finds nothing
== race 13:20:07
model slot idle (13:21:10): 35 GB reclaimable
  race-a: exit 0 in 28 s
    err: Waiting for another `slotstream launch` on port 11531 to finish starting.
    err: Set the `slotstream` provider in <out>/home/.pi/agent/models.json; other providers are unchanged.
    err: Pi will use qwen3.8-flash-next:4bit with a 32768-token window.
    err: Starting Pi. Its first reply reads the whole prompt; `tail -f <out>/home/.slotstream/logs/serve-11531.log` shows its progress.
  race-b: exit 0 in 31 s
    err: Starting Slotstream in the background: slotstream serve --port 11531 --memory-gb 12 --prefix-cache-dir <out>/home/.slotstream/prefix-cache --idle-exit 30
    err:   ... (plan lines as above)
PASS  both launches answer
PASS  only one of them starts a server (1)
PASS  the other waits for it
PASS  and finds the memory target it asked for
PASS  the record names the server that answers
  stop-race: exit 0 in 0 s
PASS  stop ends it
== idle 13:21:42
model slot idle (13:22:45): 36 GB reclaimable
  idle: exit 0 in 32 s
    err: Starting Slotstream in the background: slotstream serve --port 11531 --memory-gb 12 --prefix-cache-dir <out>/home/.slotstream/prefix-cache --idle-exit 0.25
    err:   ... (plan lines as above)
PASS  a launch with a short idle stop answers
    {"clients":1}
PASS  a registered process counts
PASS  the server stays while it runs, past the idle time
    the server stopped 18 s after the process exited
PASS  then it stops by itself, 15 to 25 seconds later
PASS  its log says why
  stop-idle: exit 0 in 0 s
PASS  stop after an idle stop finds nothing
== manual 13:24:16
model slot idle (13:25:19): 36 GB reclaimable
    server started by hand: pid 83372
  manual-hermes: exit 1 in 0 s
    err: slotstream launch: Hermes needs a context window of at least 65536 tokens, and the server on port 11531 has 32768. It was not started by `slotstream launch`, so it was left running. Stop it (`slotstream stop --port 11531` or Control-C in its window) and run this again, and launch starts one with that window; or restart it yourself with `slotstream serve --max-context 65536`. See docs/HERMES.md.
PASS  launch does not restart a server it did not start
  manual-claude: exit 0 in 141 s
    err: Claude Code will use qwen3.8-flash-next:4bit with a 32768-token window.
    err: Claude Code's instructions and tools take about 15,000 tokens of that window. For longer sessions, stop the server and start it yourself with `slotstream serve --max-context 65536`; `slotstream doctor --max-context 65536` first shows how much of a conversation this Mac keeps at that size.
    err: Starting Claude Code. Its first reply reads the whole prompt; the server window shows its progress.
    err: [claude-code:unrecognized_model] {"model":"qwen3.8-flash-next:4bit","query_source":"sdk"}
PASS  launch uses a server started by hand
PASS  and points at its window for progress
  manual-stop: exit 0 in 0 s
PASS  slotstream stop ends a server started by hand
== interrupt 13:27:50
model slot idle (13:28:53): 36 GB reclaimable
    launcher exit 130; server pid(s) at the interrupt: 84634 ; answering then: no
PASS  Control-C while the server starts ends launch
PASS  and stops the server it was starting
PASS  and removes its record
== stopstart 13:28:54
model slot idle (13:29:57): 35 GB reclaimable
    server starting: pid 85615; answering: no
  stop-starting: exit 0 in 0 s
    Stopped the Slotstream server that was starting on port 11531.
    err:   [1:29:57 PM] stopping: asked to stop (SIGTERM)
    err: slotstream launch: Slotstream stopped while starting; the lines above say why. Its log is <out>/home/.slotstream/logs/serve-11531.log.
PASS  stop ends a server that is still starting
PASS  and the launch that was starting it says so
SUMMARY 54 passed, 0 failed (13:29:57)
servers on port 11531 stopped 13:29:57
```

Earlier passes of the same gate, on earlier builds of the same work, are not separate evidence and are listed here: a first pass (binary `03266952…`, 12:16 to 12:29) passed 26 checks and failed one, `launch recorded the server it started`, because that check read the record with `grep` and JSON escapes the slashes in a path; the record itself was correct, the check now parses the JSON, and the record is written without escaped slashes. It was stopped before its idle phase to build the start lock and the process-identity record. A second attempt (12:32) was stopped at once: it ran from a copy of the script outside the repository, where the copy could not import the memory reader, so its model-slot wait would not have checked reclaimable memory; both gates now treat an unreadable reading as not enough memory. A third pass (binary `03266952…`, 12:42 to 13:03) passed 49 and failed 3: `the server stays while it runs, past the idle time` compared the server's `idle_seconds` as the text `0.0` against the `0` it sends, and the two `stopstart` checks ran before the launch under test had started its server, because a Control-C in the phase before had left a stale record that the phase waited on. The launch now removes its record when it stops the server it was starting, the phase waits for the new server, and the check compares numbers.
