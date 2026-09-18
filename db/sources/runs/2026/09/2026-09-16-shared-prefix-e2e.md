---
type: run
id: 01m2nxqta8fpjh95p0ebeagc5v
created: 2026-09-16T20:15:11.176452+00:00
updated: 2026-09-16T20:16:06.844459+00:00
summary: 'Shared prefix e2e at 10 GB: a 3,584-token system prompt kept during the first prefill was reused from memory and, across two restarts, from disk; output ids equal a cold server; 17 of 17 checks'
binary: ecc10b848d6413de33a3ee13da8bd5e29c54b7caea21a06dedd7941dab405eea
captured_at: 2026-09-16
command: python3 Tools/shared_prefix_e2e.py --memory-gb 10 --words 2300 --num-predict 48
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Shared prefixes through serve: memory reuse, two restarts, a sibling system prompt and a cold control at 10 GB'
tool: Tools/shared_prefix_e2e.py
---
Captured 2026-09-16 on the development Mac with every user application open. One model process at a time: the script refuses to start a server while another `slotstream` process runs, waits through the one-model lock when a process it cannot see holds it, and checks reclaimable memory before each start (first 26.9 GB, restart 29.9 GB, again 30.4 GB, cold 29.6 GB).

Binary SHA-256 `ecc10b848d6413de33a3ee13da8bd5e29c54b7caea21a06dedd7941dab405eea`: a local `make build` of a detached worktree at `main` 3fe5f54 (0.2.19) with the uncommitted shared-prefix change for issue #18, the same build as [[sources/runs/2026/09/2026-09-16-shared-prefix-exactness]].

Command:

```
python3 Tools/shared_prefix_e2e.py --memory-gb 10 --words 2300 --num-predict 48 --work <work> --keep --out <work>/result.json
```

Four `serve` processes ran one after another over one state directory: `first` (conversations A and B with system prompt S, then A's second turn), `restart` (C with S, then D with S', whose notes share their first 70% with S), `again` (E with S', then C's second and third turns) and `cold` (`--no-prefix-cache`: B and C from scratch). The system prompt S is the river-maintenance preamble plus about 2,300 words of generated notes; every request uses `temperature 0`, `seed 7`, `think false` and `num_predict 48`.

The first server's disk tier lines:

```
<work>/states holds 0 states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
saved shared 3584-token prefix (214.8 MB written) in 0.04 s
saved 3710 tokens (119.2 MB written, 99.1 MB of rows reused) in 0.05 s
saved 3707 tokens (119.1 MB written, 99.1 MB of rows reused) in 0.07 s
saved 3780 tokens (117.6 MB written, 102.6 MB of rows reused) in 0.07 s
```

The restarted server's:

```
<work>/states holds 4 states (0.57 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
restored 3584 tokens (214.7 MB) in 0.03 s
saved 3683 tokens (118.4 MB written, 99.1 MB of rows reused) in 0.09 s
saved shared 2304-token prefix (179.4 MB written) in 0.06 s
saved shared 3584-token prefix (151.1 MB written, 63.7 MB of rows reused) in 0.08 s
saved 3687 tokens (118.5 MB written, 99.1 MB of rows reused) in 0.08 s
```

The third server's:

```
<work>/states holds 8 states (1.14 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
restored 3584 tokens (214.7 MB) in 0.04 s
saved 3687 tokens (118.5 MB written, 99.1 MB of rows reused) in 0.09 s
restored 3683 tokens (217.5 MB) in 0.03 s
saved 3748 tokens (117.5 MB written, 101.8 MB of rows reused) in 0.07 s
saved 3774 tokens (116.4 MB written, 103.6 MB of rows reused) in 0.09 s, removed 1 older file
```

Per request, from the servers' own statistics (`slotstream_benchmark`):

| request | prompt tokens | reused | restored from disk | shared prefix kept at | first token | prefill | peak memory | output ids |
|---|---|---|---|---|---|---|---|---|
| A | 3663 | 0 | 0 | [3584] (hint 3638, common 0) | 37.33 s | 37.33 s | 8.11 GB | 48, `0330ef2e130f20bc…` |
| B | 3660 | 3584 | 0 | nothing (hint 3638, common 3641) | 3.05 s | 3.05 s | 8.11 GB | 48, `e256727d9d54b7e7…` |
| A_turn_2 | 3733 | 3710 | 0 | nothing (hint 3638, common 3710) | 1.39 s | 1.39 s | 8.11 GB | 48, `301111ab3827fcce…` |
| C | 3660 | 3584 | 3584 | nothing (hint 3638, common 3642) | 4.39 s | 4.35 s | 7.05 GB | 23, `59a097e2eff5eac5…` |
| D | 3640 | 0 | 0 | [2304, 3584] (hint 3619, common 2526) | 51.85 s | 51.85 s | 7.96 GB | 48, `91e689bfb38578b6…` |
| E | 3640 | 3584 | 3584 | nothing (hint 3619, common 3622) | 2.59 s | 2.54 s | 6.92 GB | 48, `09911d3eb02f347f…` |
| C_turn_2 | 3701 | 3683 | 3683 | nothing (hint 3638, common 3683) | 1.10 s | 1.07 s | 7.17 GB | 48, `cc1518cb88053325…` |
| C_turn_3 | 3769 | 3748 | 0 | nothing (hint 3638, common 3748) | 1.19 s | 1.19 s | 7.17 GB | 5, `6a03b853a968d2a8…` |
| B_cold | 3660 | 0 | 0 | nothing (hint None, common None) | 21.23 s | 21.22 s | 8.63 GB | 48, `e256727d9d54b7e7…` |
| C_cold | 3660 | 0 | 0 | nothing (hint None, common None) | 45.47 s | 45.47 s | 8.63 GB | 23, `59a097e2eff5eac5…` |

Derived boundaries: {"system_boundary": 3638, "system_floor": 3584, "sibling_boundary": 3619, "sibling_floor": 3584, "shared_head": 2526, "shared_head_floor": 2304, "expected_shared_prefixes": [2304, 3584, 3584]}.

The final directory listing (`slotstream prefix-cache --json`): 10 states of which 3 shared prefixes ([2304, 3584, 3584] tokens), 11 segments, 1.37 GB.

Checks: 17 of 17 passed.

```json
{
  "A found its system boundary": true,
  "A kept its system prompt at the last pass end at or before the boundary": true,
  "A wrote it to disk as a shared prefix": true,
  "A's own state reused the shared prefix's rows": true,
  "B reused the shared prefix from memory": true,
  "B's first token came sooner than A's": true,
  "A's second turn kept the shared prefix": true,
  "a restarted server restored the shared prefix for C": true,
  "D kept the head it shares with S": true,
  "D kept its own system prompt too": true,
  "another restarted server restored D's system prompt for E": true,
  "C's later turns left the shared prefixes in place": true,
  "prefix-cache lists them as shared prefixes": true,
  "no shared prefix was refused or failed": true,
  "the cold server reused nothing": true,
  "B's output ids equal the cold server's": true,
  "C's output ids equal the cold server's": true
}
```

Every request's statistics as the script recorded them (prompt and output ids reduced to counts and SHA-256 digests):

```json
{
  "A": {
    "content": "Based on the provided notes, here is a summary of the activities and readings regarding the **spillway gate**:\n\n**Inspections and Logging:**\n*   A visiting hydrologist logged the spillway gate while the dredger idled",
    "decode_tokens": 48,
    "finish_reason": "length",
    "first_token_seconds": 37.334469667,
    "output_ids": {
      "count": 48,
      "sha256": "0330ef2e130f20bc86ccaee3be4236fd83cd988cb633dcc89bcc7cbe7260cfc9"
    },
    "peak_memory_gb": 8.11159088,
    "persistent": {
      "removedFiles": 0,
      "restoreBytes": 0,
      "restoreSeconds": 0,
      "restoredTokens": 0,
      "reusedBytes": 99090432,
      "saveBytes": 119169231,
      "saveOutcome": "saved",
      "saveSeconds": 0.04508025,
      "savedTokens": 3710,
      "sharedSaveBytes": 214772649,
      "sharedSaveOutcome": "saved",
      "sharedSaveSeconds": 0.042116541,
      "sharedSavedTokens": 3584
    },
    "prefill_seconds": 37.325042667,
    "prefill_tokens": 3663,
    "prompt_ids": {
      "count": 3663,
      "sha256": "e79a149a375902419cf57e722ff17db768b35585e15865d52e021ec65a32453b"
    },
    "prompt_tokens": 3663,
    "request_seconds": 44.962102,
    "reused_prefix_tokens": 0,
    "shared_boundaries": [
      3584
    ],
    "shared_common": 0,
    "shared_errors": 0,
    "shared_hint": 3638,
    "shared_refusals": 0,
    "shared_stores": 1,
    "wall_seconds": 44.965
  },
  "A_turn_2": {
    "content": "Based on the notes provided, **none** of the entries regarding the spillway gate happened \"after the overnight storm.\"\n\nThe only note mentioning an event occurring **\"after the overnight storm\"** is Note 8, which refers to a **",
    "decode_tokens": 48,
    "finish_reason": "length",
    "first_token_seconds": 1.385602834,
    "output_ids": {
      "count": 48,
      "sha256": "301111ab3827fccef511e324ea77a91b7f6c467c61048ad1766d0337b739a0fd"
    },
    "peak_memory_gb": 8.11159088,
    "persistent": {
      "removedFiles": 0,
      "restoreBytes": 0,
      "restoreSeconds": 0,
      "restoredTokens": 0,
      "reusedBytes": 102574080,
      "saveBytes": 117624029,
      "saveOutcome": "saved",
      "saveSeconds": 0.069399125,
      "savedTokens": 3780,
      "sharedSaveBytes": 0,
      "sharedSaveSeconds": 0,
      "sharedSavedTokens": 0
    },
    "prefill_seconds": 1.38525,
    "prefill_tokens": 23,
    "prompt_ids": {
      "count": 3733,
      "sha256": "3aa8c37a95c1d9d011a50f511df34ace5eb06c0ab3806fdeb7e1352d762ad6b0"
    },
    "prompt_tokens": 3733,
    "request_seconds": 8.992344792,
    "reused_prefix_tokens": 3710,
    "shared_boundaries": [],
    "shared_common": 3710,
    "shared_errors": 0,
    "shared_hint": 3638,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 8.993
  },
  "B": {
    "content": "Based on the provided logs, **no stations are explicitly flagged as needing a \"second visit\"** in the text.\n\nHowever, if we interpret \"needs a second visit\" as **stations that appear more than once** (implying",
    "decode_tokens": 48,
    "finish_reason": "length",
    "first_token_seconds": 3.046470291,
    "output_ids": {
      "count": 48,
      "sha256": "e256727d9d54b7e73b7992e7a240c0b37b761f2807658210563b4bfd0aea0ae7"
    },
    "peak_memory_gb": 8.11159088,
    "persistent": {
      "removedFiles": 0,
      "restoreBytes": 0,
      "restoreSeconds": 0,
      "restoredTokens": 0,
      "reusedBytes": 99090432,
      "saveBytes": 119086270,
      "saveOutcome": "saved",
      "saveSeconds": 0.066711416,
      "savedTokens": 3707,
      "sharedSaveBytes": 0,
      "sharedSaveSeconds": 0,
      "sharedSavedTokens": 0
    },
    "prefill_seconds": 3.045152167,
    "prefill_tokens": 76,
    "prompt_ids": {
      "count": 3660,
      "sha256": "267a97af682dcb455bdce1b96fd7c54308ccdba57cc42b08f1013cdd3890a3b6"
    },
    "prompt_tokens": 3660,
    "request_seconds": 10.732299792,
    "reused_prefix_tokens": 3584,
    "shared_boundaries": [],
    "shared_common": 3641,
    "shared_errors": 0,
    "shared_hint": 3638,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 10.734
  },
  "B_cold": {
    "content": "Based on the provided logs, **no stations are explicitly flagged as needing a \"second visit\"** in the text.\n\nHowever, if we interpret \"needs a second visit\" as **stations that appear more than once** (implying",
    "decode_tokens": 48,
    "finish_reason": "length",
    "first_token_seconds": 21.225006417,
    "output_ids": {
      "count": 48,
      "sha256": "e256727d9d54b7e73b7992e7a240c0b37b761f2807658210563b4bfd0aea0ae7"
    },
    "peak_memory_gb": 8.626097392,
    "persistent": {},
    "prefill_seconds": 21.2187535,
    "prefill_tokens": 3660,
    "prompt_ids": {
      "count": 3660,
      "sha256": "267a97af682dcb455bdce1b96fd7c54308ccdba57cc42b08f1013cdd3890a3b6"
    },
    "prompt_tokens": 3660,
    "request_seconds": 28.731412791,
    "reused_prefix_tokens": 0,
    "shared_boundaries": [],
    "shared_common": null,
    "shared_errors": 0,
    "shared_hint": null,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 28.734
  },
  "C": {
    "content": "Note 12 reports the highest reading of **97 units**, located at **station 916**.",
    "decode_tokens": 23,
    "finish_reason": "stop",
    "first_token_seconds": 4.390777542,
    "output_ids": {
      "count": 23,
      "sha256": "59a097e2eff5eac53fcc2f8ccd00a4a910f256d31011c535ab83ed2effcdf58d"
    },
    "peak_memory_gb": 7.046877288,
    "persistent": {
      "removedFiles": 0,
      "restoreBytes": 214747136,
      "restoreSeconds": 0.033739,
      "restoredTokens": 3584,
      "reusedBytes": 99090432,
      "saveBytes": 118422621,
      "saveOutcome": "saved",
      "saveSeconds": 0.091806166,
      "savedTokens": 3683,
      "sharedSaveBytes": 0,
      "sharedSaveSeconds": 0,
      "sharedSavedTokens": 0
    },
    "prefill_seconds": 4.3466855,
    "prefill_tokens": 76,
    "prompt_ids": {
      "count": 3660,
      "sha256": "7f0afe15afd9095e9291b185139c25660b6cdea16fdec5c5bd7949aa7730a9bc"
    },
    "prompt_tokens": 3660,
    "request_seconds": 10.925958834,
    "reused_prefix_tokens": 3584,
    "shared_boundaries": [],
    "shared_common": 3642,
    "shared_errors": 0,
    "shared_hint": 3638,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 10.929
  },
  "C_cold": {
    "content": "Note 12 reports the highest reading of **97 units**, located at **station 916**.",
    "decode_tokens": 23,
    "finish_reason": "stop",
    "first_token_seconds": 45.467908625,
    "output_ids": {
      "count": 23,
      "sha256": "59a097e2eff5eac53fcc2f8ccd00a4a910f256d31011c535ab83ed2effcdf58d"
    },
    "peak_memory_gb": 8.626097392,
    "persistent": {},
    "prefill_seconds": 45.466933209,
    "prefill_tokens": 3660,
    "prompt_ids": {
      "count": 3660,
      "sha256": "7f0afe15afd9095e9291b185139c25660b6cdea16fdec5c5bd7949aa7730a9bc"
    },
    "prompt_tokens": 3660,
    "request_seconds": 49.084995292,
    "reused_prefix_tokens": 0,
    "shared_boundaries": [],
    "shared_common": null,
    "shared_errors": 0,
    "shared_hint": null,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 49.087
  },
  "C_turn_2": {
    "content": "The lowest reading is **2 units**, which appears in two notes:\n\n*   **Note 3**: The survey team inspected a leaking valve in falling light, reading 2 units at **station 812**.\n*  ",
    "decode_tokens": 48,
    "finish_reason": "length",
    "first_token_seconds": 1.096080209,
    "output_ids": {
      "count": 48,
      "sha256": "cc1518cb880533251312cb137696513cfea1543c949a60389bde1921c7ba241b"
    },
    "peak_memory_gb": 7.17498376,
    "persistent": {
      "removedFiles": 0,
      "restoreBytes": 217484684,
      "restoreSeconds": 0.030502834,
      "restoredTokens": 3683,
      "reusedBytes": 101827584,
      "saveBytes": 117485664,
      "saveOutcome": "saved",
      "saveSeconds": 0.074358458,
      "savedTokens": 3748,
      "sharedSaveBytes": 0,
      "sharedSaveSeconds": 0,
      "sharedSavedTokens": 0
    },
    "prefill_seconds": 1.065111791,
    "prefill_tokens": 18,
    "prompt_ids": {
      "count": 3701,
      "sha256": "dc19cf570de2f800773d8f92d8b45e526b4ad28a544c4ee33893d27df2b9bf64"
    },
    "prompt_tokens": 3701,
    "request_seconds": 9.080856416,
    "reused_prefix_tokens": 3683,
    "shared_boundaries": [],
    "shared_common": 3683,
    "shared_errors": 0,
    "shared_hint": 3638,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 9.082
  },
  "C_turn_3": {
    "content": "Station 812",
    "decode_tokens": 5,
    "finish_reason": "stop",
    "first_token_seconds": 1.190183833,
    "output_ids": {
      "count": 5,
      "sha256": "6a03b853a968d2a8ef34d96cf4b7d2affdcd61468b0289ca369255e5da3da67a"
    },
    "peak_memory_gb": 7.17498376,
    "persistent": {
      "removedFiles": 1,
      "restoreBytes": 0,
      "restoreSeconds": 0,
      "restoredTokens": 0,
      "reusedBytes": 103624704,
      "saveBytes": 116410296,
      "saveOutcome": "saved",
      "saveSeconds": 0.087615417,
      "savedTokens": 3774,
      "sharedSaveBytes": 0,
      "sharedSaveSeconds": 0,
      "sharedSavedTokens": 0
    },
    "prefill_seconds": 1.189306291,
    "prefill_tokens": 21,
    "prompt_ids": {
      "count": 3769,
      "sha256": "fe292dd26adbc11cc0e658c8d93a72a0e57eb0d158cc1b6359bc98be2744b876"
    },
    "prompt_tokens": 3769,
    "request_seconds": 2.136145625,
    "reused_prefix_tokens": 3748,
    "shared_boundaries": [],
    "shared_common": 3748,
    "shared_errors": 0,
    "shared_hint": 3638,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 2.137
  },
  "D": {
    "content": "Here are the notes regarding the **telemetry uplink**:\n\n*   **Note 12:** The data desk recorded the telemetry uplink while the dredger idled, reading 97 units at station 916.",
    "decode_tokens": 48,
    "finish_reason": "length",
    "first_token_seconds": 51.848684542,
    "output_ids": {
      "count": 48,
      "sha256": "91e689bfb38578b67486bb426a2c8d9093266453705ea47a7303e5775d238d6c"
    },
    "peak_memory_gb": 7.958499504,
    "persistent": {
      "removedFiles": 0,
      "restoreBytes": 0,
      "restoreSeconds": 0,
      "restoredTokens": 0,
      "reusedBytes": 162791424,
      "saveBytes": 118536066,
      "saveOutcome": "saved",
      "saveSeconds": 0.081673417,
      "savedTokens": 3687,
      "sharedSaveBytes": 330452682,
      "sharedSaveOutcome": "saved",
      "sharedSaveSeconds": 0.139045834,
      "sharedSavedTokens": 3584
    },
    "prefill_seconds": 51.847321292,
    "prefill_tokens": 3640,
    "prompt_ids": {
      "count": 3640,
      "sha256": "be9e092886faf2a606374fc7ee1d90c8871896b055d0fea4a3618e2917a31547"
    },
    "prompt_tokens": 3640,
    "request_seconds": 68.055468333,
    "reused_prefix_tokens": 0,
    "shared_boundaries": [
      2304,
      3584
    ],
    "shared_common": 2526,
    "shared_errors": 0,
    "shared_hint": 3619,
    "shared_refusals": 0,
    "shared_stores": 2,
    "wall_seconds": 68.057
  },
  "E": {
    "content": "Based on the provided notes, the **survey team** inspected a leaking valve (Note 3), but no note explicitly states that anyone *inspected* the sediment trap.\n\nHowever, several other actions were taken regarding the **sediment",
    "decode_tokens": 48,
    "finish_reason": "length",
    "first_token_seconds": 2.585604667,
    "output_ids": {
      "count": 48,
      "sha256": "09911d3eb02f347f4deb7509aa9183a1d070928dc3918aededf0bf9c599c1859"
    },
    "peak_memory_gb": 6.919016456,
    "persistent": {
      "removedFiles": 0,
      "restoreBytes": 214747136,
      "restoreSeconds": 0.039994709,
      "restoredTokens": 3584,
      "reusedBytes": 99090432,
      "saveBytes": 118536070,
      "saveOutcome": "saved",
      "saveSeconds": 0.086708875,
      "savedTokens": 3687,
      "sharedSaveBytes": 0,
      "sharedSaveSeconds": 0,
      "sharedSavedTokens": 0
    },
    "prefill_seconds": 2.536150834,
    "prefill_tokens": 56,
    "prompt_ids": {
      "count": 3640,
      "sha256": "fff1cca6fbe79044480c998f57f024e75c23cd92f74154851106b340ec7010c8"
    },
    "prompt_tokens": 3640,
    "request_seconds": 10.68728275,
    "reused_prefix_tokens": 3584,
    "shared_boundaries": [],
    "shared_common": 3622,
    "shared_errors": 0,
    "shared_hint": 3619,
    "shared_refusals": 0,
    "shared_stores": 0,
    "wall_seconds": 10.691
  }
}
```

The final listing:

```json
{
  "in_use": false,
  "other_format_bytes": 0,
  "other_format_files": 0,
  "segment_bytes": 218011402,
  "segments": 11,
  "states": [
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115685846,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:12:28Z",
      "segments": 4,
      "shared": false,
      "tokens": 3774
    },
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115682910,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:12:26Z",
      "segments": 3,
      "shared": false,
      "tokens": 3748
    },
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115682658,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:12:17Z",
      "segments": 3,
      "shared": false,
      "tokens": 3687
    },
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115679420,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:12:06Z",
      "segments": 2,
      "shared": true,
      "tokens": 3584
    },
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115682655,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:11:57Z",
      "segments": 3,
      "shared": false,
      "tokens": 3687
    },
    {
      "continued": false,
      "draft": false,
      "head_bytes": 115671455,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:11:21Z",
      "segments": 1,
      "shared": true,
      "tokens": 2304
    },
    {
      "continued": false,
      "draft": false,
      "head_bytes": 115676576,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:10:38Z",
      "segments": 1,
      "shared": true,
      "tokens": 3584
    },
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115683037,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:10:29Z",
      "segments": 3,
      "shared": false,
      "tokens": 3780
    },
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115679899,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:10:20Z",
      "segments": 2,
      "shared": false,
      "tokens": 3707
    },
    {
      "continued": true,
      "draft": false,
      "head_bytes": 115679915,
      "identity": "b3f7fd581102928a87d3b18584cdba351f8d0ce8b59f0e04e291ce0ba603ee57",
      "last_used": "2026-09-16T20:10:09Z",
      "segments": 2,
      "shared": false,
      "tokens": 3710
    }
  ],
  "total_bytes": 1374815773,
  "unreadable_bytes": 0,
  "unreadable_files": 0
}
```
