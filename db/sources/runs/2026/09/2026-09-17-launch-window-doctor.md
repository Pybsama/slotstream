---
type: run
id: 01m2rb1d27fwg8ah5nav9jm577
created: 2026-09-17T18:46:05.639035+00:00
updated: 2026-09-17T18:46:12.015614+00:00
summary: 'doctor plans at 12, 10 and 9 GB: the automatic window against a fixed 65,536, which loses the expert cache, the retention, or the plan'
binary: 918a1da5ecc21c921f499447a9fe6b720973f4a955799b4ffdabb23d5668d875
captured_at: 2026-09-17
command: for gb in 12 10 9; do slotstream doctor --memory-gb $gb; slotstream doctor --memory-gb $gb --max-context 65536; done
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: The automatic window against a fixed 65,536-token window at 12, 10 and 9 GB (doctor plans)
tool: slotstream doctor
---
Captured 2026-09-17 on the development Mac, machine quiet (36.6 GB reclaimable), with the binary of [[sources/runs/2026/09/2026-09-17-launch-background-server-live]]. `slotstream doctor` plans without loading a model, so these are plans, not runs.

Why: `slotstream launch` starts its server with the automatic window and asks for more only when the agent needs it. The guides recommended `--max-context 65536` for coding agents, so this prices that window against the automatic one at three memory targets a 16 to 32 GB Mac would use.

```
for gb in 12 10 9; do
  slotstream doctor --memory-gb $gb
  slotstream doctor --memory-gb $gb --max-context 65536
done
```

| Target | Automatic | Forced 65,536 |
|---|---|---|
| 12 GB | 32,768 tokens, ~31 experts per layer (4.1 GB pool), ~6 tok/s, 20,616 tokens retained, 4.4 min for a full prompt | 13 experts (1.8 GB), ~3 tok/s, 65,536 retained, 8.8 min |
| 10 GB | 32,768 tokens, ~20 experts (2.7 GB), ~4 tok/s, 13,382 retained, 6.4 min | 13 experts (1.8 GB), ~3 tok/s, 6,828 retained, 12.9 min |
| 9 GB | 32,768 tokens, ~13 experts (1.8 GB), ~3 tok/s, 9,765 retained | refused: `insufficient_memory`, maximum feasible window 38,912 tokens |

At 12 GB the fixed window buys a whole retained conversation and costs more than half the expert cache and about half the estimated decode rate. At 10 GB it also loses the retention it was meant to buy: 6,828 tokens is less than a coding agent's opening prompt, so every turn would be read again. At 9 GB the plan is refused outright. The lines that carry the comparison, with the estimate's caveats and the unchanged lines between them left out:

```
===== --memory-gb 12 --max-context auto
  target: 12.0 GB total for this process
  cache:  ~31 of 512 experts per layer  (1491 global slots = 4.1 GB pool)
  expect: ~11.0 GB peak, ~6 tok/s warm decode (est. from M5 Pro anchors)
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 20616 tokens across 4 conversations (~0.9 GB), so a follow-up turn re-prefills only what is new
memory-feasible window: 106496 tokens; separate from the 30.0-minute request-to-first-token policy
context window: automatic, 32768 tokens on this machine's memory tier. Auto takes the largest
exit 0
===== --memory-gb 12 --max-context 65536
  target: 12.0 GB total for this process
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  expect: ~11.7 GB peak, ~3 tok/s warm decode (est. from M5 Pro anchors)
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~8.8 min before its first token here, follow-up turns read only what is new
  reuse:  up to 65536 tokens across 4 conversations (~2.2 GB), so a follow-up turn re-prefills only what is new
memory-feasible window: 106496 tokens; separate from the 30.0-minute request-to-first-token policy
exit 0
===== --memory-gb 10 --max-context auto
  target: 10.0 GB total for this process
  cache:  ~20 of 512 experts per layer  (961 global slots = 2.7 GB pool)
  expect: ~9.0 GB peak, ~4 tok/s warm decode (est. from M5 Pro anchors)
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 13382 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
memory-feasible window: 70656 tokens; separate from the 30.0-minute request-to-first-token policy
context window: automatic, 32768 tokens on this machine's memory tier. Auto takes the largest
exit 0
===== --memory-gb 10 --max-context 65536
  target: 10.0 GB total for this process
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  expect: ~9.7 GB peak, ~3 tok/s warm decode (est. from M5 Pro anchors)
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~12.9 min before its first token here, follow-up turns read only what is new
  reuse:  up to 6828 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
memory-feasible window: 70656 tokens; separate from the 30.0-minute request-to-first-token policy
exit 0
===== --memory-gb 9 --max-context auto
  target: 9.0 GB total for this process
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  expect: ~8.3 GB peak, ~3 tok/s warm decode (est. from M5 Pro anchors)
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 9765 tokens across 4 conversations (~0.6 GB), so a follow-up turn re-prefills only what is new
memory-feasible window: 38912 tokens; separate from the 30.0-minute request-to-first-token policy
context window: automatic, 32768 tokens on this machine's memory tier. Auto takes the largest
exit 0
===== --memory-gb 9 --max-context 65536
Error: insufficient_memory: context, resident components, minimum pool and prefill workspace exceed the total-memory target; maximum feasible window: 38912 tokens
exit 1
```
