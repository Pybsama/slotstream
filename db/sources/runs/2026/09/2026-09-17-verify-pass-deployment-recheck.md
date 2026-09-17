---
type: run
id: 01m2rtv3d8bw5epp2zzq1j5snb
created: 2026-09-17T23:22:16.359706+00:00
updated: 2026-09-17T23:22:20.231946+00:00
summary: 'Decode comparisons re-run on a quiet machine after the commit: 16k and 32k'
binary: 8ea3c360959fd20c21d61f3d7f80230831f3cb594713ab5031180152fd5cb494
captured_at: 2026-09-17
command: SLOTSTREAM_OPT_VERIFY_SPLIT=0 slotstream mtp-bench --arms spec,split --memory-gb 22 [--max-context 33024] --prompt-file prompt_16384.txt|prompt_32768.txt --max-tokens 64|128 --pairs 2|3; slotstream run --memory-gb 16|22 [--mtp on] --prompt-file prompt_16384.txt --max-tokens 64
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Decode comparisons re-run on a quiet machine after the commit: 16k and 32k'
tool: slotstream mtp-bench --arms, plus two ordinary slotstream run invocations
---
Raw output of the decode comparisons re-run after the change was committed
(553f7f8), on binary `8ea3c360959fd20c`, 2026-09-17 from 17:31 local. Same
protocol as the pre-commit comparisons: one warm engine per step at the 22 GB
target, `SLOTSTREAM_OPT_VERIFY_SPLIT=0` so `spec` is the previous dense pass
and `split` is the shipped default, each arm once untimed and then once per
round with the order rotating, greedy. The machine was quiet: 1-minute load
1.89 to 2.29 at the start of each step, 35 GB reclaimable, no other model
process and no build running.

## 16k, 64 tokens (too short, kept for the record)

```text
  target: 22.0 GB total for this process
  cache:  ~74 of 512 experts per layer  (3531 global slots = 9.8 GB pool)
engine ready in 1.1s: expert cache ~74/512 per layer (3531 global slots = 9.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; ~73 experts/layer; arms: spec,split
round 1: spec 10.75 tok/s (accept 78.0%, 25 passes); split 10.79 tok/s (accept 60.3%, 29 passes);
round 2: split 11.08 tok/s (accept 60.3%, 29 passes); spec 11.84 tok/s (accept 78.0%, 25 passes);
medians (tok/s) over 2 rounds, greedy=true:
  spec          11.84
  split         11.08   x0.936 against spec
  every arm repeats its own output across rounds: true
  split verify attention engaged in: split
```

Twenty-five to twenty-nine verify passes per arm and a 10% swing between the
two rounds of the same arm. The reported median of two rounds is the larger
value, so this step measures the better of two noisy samples; it is not
evidence either way and the 128-token step below replaces it.

## 16k, 128 tokens, three rounds

```text
== start 17:48:20 load { 1.89 2.84 2.31 } reclaimable 35.2 GB
  target: 22.0 GB total for this process
  cache:  ~74 of 512 experts per layer  (3531 global slots = 9.8 GB pool)
engine ready in 1.1s: expert cache ~74/512 per layer (3531 global slots = 9.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 16356 tokens; context window 32768; ~73 experts/layer; arms: spec,split
round 1: spec 11.74 tok/s (accept 69.8%, 53 passes); split 11.74 tok/s (accept 63.4%, 56 passes);
round 2: split 11.82 tok/s (accept 63.4%, 56 passes); spec 11.61 tok/s (accept 69.8%, 53 passes);
round 3: spec 11.67 tok/s (accept 69.8%, 53 passes); split 11.96 tok/s (accept 63.4%, 56 passes);
medians (tok/s) over 3 rounds, greedy=true:
  spec          11.67
  split         11.82   x1.013 against spec
  every arm repeats its own output across rounds: true
  split verify attention engaged in: split
== end 17:58:30 load { 3.48 3.45 2.97 }
```

The split is 1.013 times the dense pass here. Its own acceptance on this
prompt is lower, 63.4% against 69.8%, so it runs 56 verify passes to the dense
arm's 53, and the cheaper pass mostly pays for the extra passes. The
pre-commit step of the same shape measured x1.079 on a busier machine, where
both arms ran about 10% slower.

## 16k, a second prompt, 128 tokens, three rounds

```text
== start 18:38:18 load { 2.99 2.79 3.00 }
engine ready in 1.1s: expert cache ~74/512 per layer (3531 global slots = 9.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 16375 tokens; context window 32768; ~73 experts/layer; arms: spec,split
round 1: spec 9.70 tok/s (accept 73.1%, 52 passes); split 13.90 tok/s (accept 70.8%, 53 passes);
round 2: split 14.38 tok/s (accept 70.8%, 53 passes); spec 13.00 tok/s (accept 73.1%, 52 passes);
round 3: spec 12.82 tok/s (accept 73.1%, 52 passes); split 13.81 tok/s (accept 70.8%, 53 passes);
medians (tok/s) over 3 rounds, greedy=true:
  spec          12.82
  split         13.90   x1.085 against spec
  every arm repeats its own output across rounds: true
  split verify attention engaged in: split
== end 18:48:19 load { 3.27 3.59 3.42 }
```

The same shape on a different 16,356-token prompt: the split is 1.085 times
the dense pass, and the two arms accept almost alike here, 70.8% against
73.1%, over 53 and 52 passes. Taken with the first prompt's x1.013, the 16k
end-to-end gain depends on the acceptance the prompt happens to draw, and the
direction is not fixed: the exact arm on the first prompt accepted more than
the dense pass, 70.8% against 69.8%.

## 32k, 128 tokens, two rounds

```text
== start 17:59:02 load { 2.29 3.16 2.88 } reclaimable 35.3 GB
  target: 22.0 GB total for this process
  cache:  ~76 of 512 experts per layer  (3671 global slots = 10.1 GB pool)
engine ready in 1.1s: expert cache ~76/512 per layer (3671 global slots = 10.1 GB), mtp draft head on, eos [248044, 248046]
prompt: 32740 tokens; context window 33024; ~76 experts/layer; arms: spec,split
round 1: spec 8.97 tok/s (accept 62.3%, 57 passes); split 11.31 tok/s (accept 61.4%, 57 passes);
round 2: split 11.63 tok/s (accept 61.4%, 57 passes); spec 8.98 tok/s (accept 62.3%, 57 passes);
medians (tok/s) over 2 rounds, greedy=true:
  spec           8.98
  split         11.63   x1.294 against spec
  every arm repeats its own output across rounds: true
  split verify attention engaged in: split
== end 18:20:44 load { 4.67 4.51 4.22 }
```

Both arms run 57 passes at nearly the same acceptance, so this ratio is the
per-pass saving and nothing else. The dense arm repeats itself to within
0.01 tok/s across rounds.

## Two ordinary runs

`slotstream run --memory-gb 16 --prompt-file prompt_16384.txt --max-tokens 64`
completed at 8.45 tok/s decode with the draft head off: at a 16 GB target the
plan drops speculative decode, so the verify pass never runs. The same prompt
at `--memory-gb 22 --mtp on` completed at 13.44 tok/s with 37 accepted drafts
over 26 verify passes.
