---
type: run
id: 01m2nxyt8xm6hdqh33qgq1gdze
created: 2026-09-16T20:19:00.509756+00:00
updated: 2026-09-16T20:19:29.944945+00:00
summary: 'Opt-in thinking in the Mac app: scripted checks, four real-model runs at the 10 GB plan, defects fixed, final run passing'
binary: 18572abdb6b1d725cd5d2756e2f4d2bf91ed599302916343824017f61459bf68
captured_at: 2026-09-16
command: swift build --package-path apps/macos; sevra-mac-checks --thinking; sevra-mac-checks; sevra-mac-checks --real-thinking --home <new> --budget 96 --answer-after 8
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
