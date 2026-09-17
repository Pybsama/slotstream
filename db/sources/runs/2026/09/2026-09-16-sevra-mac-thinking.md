---
type: run
id: 01m2nxyt8xm6hdqh33qgq1gdze
created: 2026-09-16T20:19:00.509756+00:00
updated: 2026-09-17T02:31:54.816168+00:00
summary: 'Opt-in thinking in the Mac app: scripted checks, four real-model runs at the 10 GB plan, defects fixed, final run passing, offscreen UI check of the production views passing'
binary: 18572abdb6b1d725cd5d2756e2f4d2bf91ed599302916343824017f61459bf68
captured_at: 2026-09-16
command: swift build --package-path apps/macos; sevra-mac-checks --thinking; sevra-mac-checks; sevra-mac-checks --real-thinking --home <new> --budget 96 --answer-after 8; bash Tools/check_sevra_thinking_ui.sh
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra Mac thinking before answers
tool: Swift build, scripted runtime checks, dbmd, real local model at the app's 10 GB plan
---
# Thinking before answers: scripted and real-model verification

Development receipt for the Mac app's opt-in thinking feature: a sticky per-thread "Think longer" switch, a bounded `low`-effort thought with forced closure, Answer now, a live clock and working-notes disclosure, a per-run receipt with no persisted thought text, and endpoint/CLI intents. This is a functional verification of one development build on one Mac at the app's bounded 10 GB plan. It is not a quality comparison of thinking versus plain answers, not a latency claim for other Macs or the maintained product profile, and not a UI review.

## Scripted checks

`sevra-mac-checks --thinking` and the complete scripted suite (27 passing groups) run with the scripted engine and the real bundled dbmd: thinking off by default with no request sent; sticky switch persisted with the thread; live thought observable with a clock in the run status; receipt with token count and `closed` ending; the answer excludes the thought; Answer now ends a 401-word scripted thought early with an `answerNow` receipt and a completed run; a tool turn receives no thinking request and records `offForTools`; receipts and the switch survive restart; a canary in the thought never appears in any Home file; an Incognito thought is readable only while its thread is open and leaves with it; the local endpoint accepts `think on/off`, rejects other values, and accepts `answer-now`.

## Real model, four runs

All runs used the development build of `sevra-mac-checks --real-thinking` (final binary SHA-256 `18572abdb6b1d725cd5d2756e2f4d2bf91ed599302916343824017f61459bf68`, app sources under `apps/macos` hashed together `37f108194f1b8619df2485284fefd5172bf89d040fa0892fddf2426cb05b6dea`), `LocalInference(memoryGB: 10)` on the 48 GB M5 Pro with the local 4-bit Qwen3.8-Flash-Next checkpoint (engine ready in 1.7 to 2.4 s, expert cache about 21 of 512 experts per layer, 2.8 GB of slots), a forced budget of 96 tokens for the first phase and Answer now requested 8 s into the second.

| Run | Build state | Forced close (96) | Answer now | App budget (768) | Plain turn after | Result |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | first build: sampled answer phase, clock started before prefill | 96 tokens, `budget`, answered "12:15" | 25 tokens, `answerNow`, 2,546-char plan | closed at 26 tokens, "144" | "hello" | all phases correct; the check then failed reopening the Home while the runtime still owned it (check defect) |
| 2 | clock starts at the first thought token | 96 tokens, 25.1 s, `budget`, "12:15" | thought ended at 8.1 s, but the sampled answer outran the 1,024-token reply cap and the run failed as `length`; receipt recorded `stopped` with 0 tokens (defect) | not reached | not reached | failed at phase 2 |
| 3 | greedy answer phase, exact receipts on failure | model did not load: another process held the one-model-process lock | | | | no evidence |
| 4 | same code as run 3 | 96 tokens, 20.9 s, `budget`, "12:15" (168 chars) | requested at 8.2 s after 144 bytes of thought; 37 tokens, 8.4 s, `answerNow`; 618-char answer, completed | closed at 34 tokens in 8.7 s, "144" | "hello" | pass: three receipts persisted, no thought canary in any Home file |

The observed thought rate at this plan was about 4 to 5 tokens per second (96 tokens in 20.9 to 28.7 s). Prefix reuse was observed inside a turn (the answer phase reused 511 of its 537 prompt tokens after Answer now) and across turns in run 1; in run 4 the third and fourth turns re-read 575 tokens because the elastic governor resized the cache when memory freed up and dropped retained prefix states, which is its documented behavior. Flipping the switch off changes the rendered system instructions, so the plain fourth turn always re-reads.

## Defects found and fixed during verification

- The thinking clock started before prefill, so the first receipts and the live counter included prompt reading. The clock now starts at the first thought token.
- A run whose answer phase failed after a completed thought recorded a `stopped` receipt with zero tokens. The buffer now keeps the token count and the real ending, and the failure path records them.
- The answer phase originally used the model card's thinking sampling profile. One sampled answer outran the app's unchanged 1,024-token reply cap and failed the run as `length`, which the app treats as an unsuccessful completion. The thought keeps the sampled profile so it cannot loop; the answer phase is greedy like every other answer in this app.
- The real check reopened the Home while the runtime still owned it; the check now releases the owner first.

## Limits

No visual or screen-reader review of the new controls was possible in this session (screen-recording permission was unavailable). The 768-token ceiling and `low` level are development operating bounds. Thinking in tool loops, a heavier level, a coordinator-proposed automatic mode and persistence of thought text across relaunch are unimplemented follow-ups that need their own measurement. Engine-level budgets and API exposure remain Slotstream work.

## Offscreen UI check, later the same day

The visual gap above was closed without screen-recording permission by an offscreen check of the production views: `Tools/check_sevra_thinking_ui.sh` (SHA-256 `a965c0157b3eec1c577e734060de4195af2ada069dc4429ef7b719581a4094da`) builds the debug `Sevra` product, links the app's own compiled objects with `apps/macos/NativeChecks/ThinkingUIChecks.swift` (SHA-256 `33a49e3a46275777e3775fc06cf14ce3db691b5893933ea75b82e77f6975dc0d`) and runs the real `ContentView` and `AppModel` over `ScriptedInference` in a scratch Home with the bundled fonts. The window is ordered onto the window server far outside every display, the process never activates and nothing is drawn on a screen. Each control is located by its rendered label with on-device text recognition on a 2x render and clicked with a synthesized mouse press through the window; the message is typed into the real composer text view. Exit 0 in 52 s including the debug relink; all 24 checks passed:

```
PASS: Home composer shows the Think longer switch
PASS: Home hint stays plain while thinking is off
PASS: a new thread starts with Think longer off
PASS: Think longer is clickable
PASS: the thread remembers the switch
PASS: the hint explains the switch while it is on
PASS: Send is clickable
PASS: run status shows Thinking with a clock: Thinking… 0:01
PASS: Thinking status and Answer now are visible while the thought runs
PASS: Working notes can be opened while the thought runs
PASS: opened working notes show the streaming thought and its privacy line
PASS: Answer now is clickable
PASS: the run records an Answer now receipt: Thought for 3 s, then answered when you asked.
PASS: the answer arrived after Answer now
PASS: the receipt line is shown under the run
PASS: working notes stay readable and Answer now is gone
PASS: the composer hint now quotes a typical thinking time
PASS: Think longer is clickable again
PASS: clicking again turns thinking off and restores the plain hint (thinking=nil)
PASS: thinking controls render and respond in the production Mac views
```

Snapshots (1120 by 760 points at 2x, kept as build output in `.build/sevra-thinking-ui/`, not stored in this database): `01-home-idle.png` `1b775987e03cb14630061a844e1b1f11b8b1feec4ba7fb94babec825464c9d4d`, `02-thread-thinking-off.png` `5fe8a30979ca61d49c2310022e7a6cd3c964f5b703cd4cf6fbd12baf71186c02`, `03-thread-thinking-on.png` `009b4b48dcba1bd4219df485cf6f702b6f1511e0105be20eb5b1925006ca50aa`, `04-thinking-live.png` `575693c2063020cfaf19a3b1aca98de0255a338c05ec18c9747c95403b455c53`, `05-answered-receipt.png` `5d2e54e98d3e0f5b066f694cff690ff5b6f14441c117f731231e512693df5b93`, `06-answered-receipt-dark.png` `c3afa7f6557fa54a9de12573ef76ffffc0f08a5e473a050aeff89acae8de5b5d`.

Observed in the renders: the switch pill darkens when on; the hint reads "Thinks before answering. Answer now ends a thought early." before any thought and "Thinks before answering. Recently about 3 s extra." afterwards; the status reads "Thinking… 0:02" beside a spinner while the scripted thought streams; "Answer now" sits beside "Stop" in the composer; the opened notes show "Not saved or remembered. Kept only while Sevra is open." above the streaming text; after Answer now the status reads "Completed" with the receipt "Thought for 3 s, then answered when you asked." and a collapsed "Working notes" disclosure. Two behaviors worth knowing rather than defects: while a run is busy the composer hint shows "Local on this Mac." instead of the thinking hint, and the disclosure opens from its chevron, not from its label, which is the standard macOS disclosure behavior.

Limits of this check: it is not a VoiceOver pass and not a person's review of the live app; label recognition verifies visible text and click wiring, not pixel-exact layout; one window size, the default text size, explicit light and dark appearance, and the scripted engine rather than the model. Three probe-side false starts were fixed while building it (SwiftUI controls ignore clicks in a window the window server does not know; the app's composer-change forwarding had to be replicated; the disclosure needed its chevron). No app source changed for this check.
