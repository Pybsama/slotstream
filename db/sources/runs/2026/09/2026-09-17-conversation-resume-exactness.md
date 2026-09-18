---
type: run
id: 01m2sdpcwxcmmts3vts6cyt12b
created: 2026-09-18T04:51:45.180587+00:00
updated: 2026-09-18T05:37:45.627572+00:00
summary: A continued conversation computed different logits from a cold one, 3.7% to 5.9% of their spread, and after the resume rule computes them bit for bit
binary: slotstream 7ff55ced5ed9a27f (final; f7ef47c2f229e071 for the runs before the disk-tier reorder); slotstream-checks 25dc82a8a2f7d842; sevra-mac-checks c699fe4614636663 (final; 1fa19518a8746aee earlier)
captured_at: 2026-09-17
command: slotstream prefix-exact-check; SLOTSTREAM_OPT_ALIGNED_RESUME=0 slotstream prefix-exact-check; slotstream prefix-check --slots 961 both ways; sevra-mac-checks --real-basics
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Conversation resume exactness: before, after, and what it costs'
tool: slotstream prefix-exact-check, prefix-check, optimization-state-check, slotstream-checks, sevra-mac-checks
---
The engine's numerical results depended on how a conversation reached its prompt: a turn that resumed the state the previous turn left behind did not compute what reading the same ids computes. This is the before and after of the fix, on one development Mac, every run on the same weights.

## The defect, on the build that had it

`prefix-exact-check` with the new rule switched off is the behavior every release until now shipped. It drives one conversation twice, once with the prefix cache off and once with it on, and compares the raw next-token logits the prompt ends on:

```

engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  pass size 256 tokens, aligned resume OFF
  long turn 1: 1521 prompt tok, reused 0, logit delta 0.000000%
  long turn 2: 1548 prompt tok, reused 1524, logit delta 5.871795%
  long turn 3: 1576 prompt tok, reused 1550, logit delta 3.821656%
  repeat turn 1: 1521 prompt tok, reused 1521, logit delta 0.000000%
  short turn 1: 22 prompt tok, reused 0, logit delta 0.000000%
  short turn 2: 49 prompt tok, reused 24, logit delta 3.707743%
  short turn 3: 70 prompt tok, reused 50, logit delta 4.069768%
  shared prefix turn 1: 1520 prompt tok, reused 256, logit delta 0.000000%
PREFIX EXACT CHECK FAIL
  - long turn 2: resumed prompt logits differ from a cold read by 5.8718% of their spread; a continued conversation must compute the same sums
  - long turn 3: resumed prompt logits differ from a cold read by 3.8217% of their spread; a continued conversation must compute the same sums
  - short turn 2: resumed prompt logits differ from a cold read by 3.7077% of their spread; a continued conversation must compute the same sums
  - short turn 3: resumed prompt logits differ from a cold read by 4.0698% of their spread; a continued conversation must compute the same sums
```

A continued turn moved the logits 3.7% to 5.9% of their spread, at both conversation lengths. The 49-token second turn shows it is not a long-context effect. Two lines are already exact: an identical prompt reuses its own retained logits, and the 256-token common-prefix snapshot, which is the one state the old engine retained that a fresh read also produces.

## After the fix

```

engine ready in 0.7s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  pass size 256 tokens, aligned resume on
  long turn 1: 1521 prompt tok, reused 0, logit delta 0.000000%
  long turn 2: 1548 prompt tok, reused 1280, logit delta 0.000000%
  long turn 3: 1576 prompt tok, reused 1536, logit delta 0.000000%
  repeat turn 1: 1521 prompt tok, reused 1521, logit delta 0.000000%
  short turn 1: 22 prompt tok, reused 0, logit delta 0.000000%
  short turn 2: 49 prompt tok, reused 0, logit delta 0.000000%
  short turn 3: 70 prompt tok, reused 0, logit delta 0.000000%
  shared prefix turn 1: 1520 prompt tok, reused 1280, logit delta 0.000000%
PREFIX EXACT CHECK PASS: every continued turn produced the same tokens and the same prompt logits as a cold read, 2 of 2 follow-up turns resumed a boundary state, an identical prompt reused its complete state, an edited history rebuilt, and a second conversation resumed the shared prefix
```

Every delta is exactly zero: the continued conversation and the cold one computed the same numbers, bit for bit. Turn 2 resumed the boundary at 1,280 that turn 1 left, turn 3 the boundary at 1,536 that turn 2 left, and the short conversation resumed nothing because 22, 49 and 70 tokens never reach a boundary.

## What it costs

The same three-turn chat at 961 slots, the pool the Sevra Mac app plans at a 10 GB target, with the rule off and then on. `prefix-check` prints each turn's prefill and the follow-up total:

```

rule off (the old reuse)
  shed: retained 1411 tokens, dropped, next turn rebuilt 1436
  turn 1: 1409 prompt tok, 0 reused, prefill 12.46s -> Mars
  turn 2: 1436 prompt tok, 1411 reused, prefill 1.35s -> No
  turn 3: 1457 prompt tok, 1437 reused, prefill 1.12s -> Mars has a smaller diameter and mass than Ea
PREFIX CHECK PASS: reuse moves logits 4.37% vs 5.90% for the prefill-rechunk control, flat with depth, top-1 2/3; 2 of 2 turns reused a prefix; cached and edited-history runs deterministic; follow-up prefill 27.18s -> 2.47s (0 of 3 replies differ from a cold rebuild)

rule on (the fix)
  shed: retained 1411 tokens, dropped, next turn rebuilt 1436
  turn 1: 1409 prompt tok, 0 reused, prefill 11.91s -> Mars
  turn 2: 1436 prompt tok, 1280 reused, prefill 3.70s -> No
  turn 3: 1457 prompt tok, 1280 reused, prefill 4.86s -> Mars has a smaller diameter and mass than Ea
PREFIX CHECK PASS: reuse moves logits 4.37% vs 5.90% for the prefill-rechunk control, flat with depth, top-1 2/3; 2 of 2 turns reused a prefix; cached and edited-history runs deterministic; follow-up prefill 26.28s -> 8.56s (0 of 3 replies differ from a cold rebuild)
```

A follow-up turn re-reads back to the last pass boundary instead of reading only what is new, so it pays one partial pass: 2.47 s of follow-up prefill against 8.56 s, both well under the 26.3 s of reading the conversation cold. Reuse still removes two thirds of the work; it used to remove nine tenths of it, and it was removing them by continuing a state that held different numbers.

## The job that found it

The Sevra Mac app's real-model basics run is where the malformed tool call appeared. Its edit job asks the model to change one line of a Markdown file. Both earlier runs of 2026-09-17 produced this trace, byte for byte:

```
source.list: returned bounded source data
source.read: returned bounded source data
The model returned unsupported arguments for file.edit: old]\n</parameter. No calls from that response were executed. Requested one corrected response.
file.edit: staged for review
files: 1 staged for exact-content review
```

The same run on the fixed engine, same fixtures, same 10 GB plan:

```

source.list: returned bounded source data
source.read: returned bounded source data
file.edit: staged for review
files: 1 staged for exact-content review
```

The correction round is gone and the file written is the same one, SHA-256 `646bb50f7a5184693ac355518a0ddaca2854e55e528f640b897bbf7b8d00db7d`. Twelve of twelve checks passed in 528 s with no failures.

## Checks

| check | result |
| --- | --- |
| `slotstream-checks --tier t0` (47 checks, including the new weights-free `aligned-prefix-resume`) | 47 passed, 0 failed, 28,540 assertions |
| `slotstream-checks --tier t1` (15 checks) | 15 passed, 0 failed, 2,135 assertions |
| `slotstream prefix-exact-check` | PASS |
| `slotstream prefix-check` | PASS, 0 of 3 replies differ from a cold rebuild |
| `optimization-state-check --variant prefix-retention` | PASS |
| `optimization-state-check --variant prefix-retention-mtp` | PASS, 198 assertions |
| `optimization-state-check --variant prefix-vision` | PASS |
| `optimization-state-check --variant state-recovery-lineage` | PASS |
| `sevra-mac-checks` (scripted suite) and `--real-basics` | 38 scripted checks pass; 12 of 12 real checks pass |

Two checks did not pass, neither from this change:

- `optimization-state-check --variant complete-prompt` fails its last case, a 273-token prompt carrying an image, with `complete-prompt diagnostic lost consumed state`. It fails identically with the rule switched off and on the frozen build of 12:31 today, which contains none of this work. Its five text cases pass. Unresolved, and someone else's ground.
- `optimization-state-check --variant all-hit-replay` fails only `nominal operating conditions`: the machine was thermally throttled after a day of model runs. Its substantive assertions, exact logits and ordered routes, zero expert reads and no swap, all pass.
## Speculative decoding, and a larger pass

The same check under a real 14 GB plan: the MTP draft head on, so the draft cache is part of every retained state, and a 512-token prefill pass, so the boundaries are further apart.

```
  pass size 512 tokens, aligned resume on
  long turn 1: 1521 prompt tok, reused 0, logit delta 0.000000%
  long turn 2: 1548 prompt tok, reused 1024, logit delta 0.000000%
  long turn 3: 1576 prompt tok, reused 1536, logit delta 0.000000%
  long turn 1 prefill: 12.92s cold, 9.43s continued (1521 of 1521 tokens read)
  long turn 2 prefill: 10.41s cold, 4.33s continued (524 of 1548 tokens read)
  long turn 3 prefill: 10.82s cold, 1.85s continued (40 of 1576 tokens read)
  repeat turn 1: 1521 prompt tok, reused 1521, logit delta 0.000000%
  shared prefix turn 1: 1520 prompt tok, reused 1024, logit delta 0.000000%
PREFIX EXACT CHECK PASS
```

Turn 3 landed 40 tokens past its boundary and read those 40, which is the shape the rule aims for; turn 2 landed 524 past its own and paid for all of them. What a turn re-reads is wherever its prompt ends relative to the grid, between nothing and one pass, and a larger pass moves the grid further apart in both directions.
## The disk tier

A state that holds generated tokens cannot be restored under the rule either, so the optional persistent tier now writes the boundary snapshot instead of the conversation, and restores only a length that is a boundary of the incoming prompt. `Tools/persistent_prefix_e2e.py --memory-gb 10 --words 2400` drives three turns through one server, restarts over a copy taken after turn 2, regenerates turn 3, and reads a cold server for contrast:

```
turn 1            prompt 3849, reused 0    | saved 3840, reused 0 bytes of rows
turn 2            prompt 4571, reused 3840 | saved 4352, reused 106168320 bytes
turn 3            prompt 5279, reused 4352 | saved 5120, reused 120324096 bytes
turn 3 restarted  prompt 5279, reused 4352 | restored 4352 from disk, saved 5120
12 of 12 checks pass, including both turn-3 prompt and output ids equal to the first server's
```

Two things had to change for that. The turn's snapshot is written before it is forked into the cache, so the snapshot the next turn resumes carries its disk lineage and its own save references those rows instead of writing them again: without the reorder every turn wrote its whole state, 236 MB instead of 130. And the check's own conversation now carries a round of notes per turn (`--turn-words`, 400), because a turn that adds only a short question stays inside the pass band its parent already wrote and correctly writes nothing at all; real conversations carry tool results and pasted work, so this is the shape that exercises the incremental save. One assertion was relaxed: a regenerated turn may now restore the deeper state the restart wrote rather than the kept parent, which is still a state of that conversation, and the output ids are what the check actually holds.
## The shipping build

Every number above comes from the build that carried the change at the time; the final build repeats the two that matter.

```
slotstream prefix-exact-check                       every delta 0.000000%, PASS
sevra-mac-checks --real-basics --home <new>         12 of 12 in 526 s, no failures
  edit trace: source.list, source.read, file.edit: staged for review
  file written: 646bb50f7a5184693ac355518a0ddaca2854e55e528f640b897bbf7b8d00db7d
sevra-mac-checks (scripted)                         38 checks pass
slotstream-checks --tier t0 / --tier t1             47 and 15 pass
Tools/static_gates.sh                               PASS
```
