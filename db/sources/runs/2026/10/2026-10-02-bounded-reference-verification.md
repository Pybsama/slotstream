---
type: run
created: 2026-10-03T00:24:12.708084+00:00
updated: 2026-10-03T00:24:12.708084+00:00
summary: Complete static and native catalogue verification for the bounded reference and PLE implementation.
binary: frozen-ple-native-v1, identified by the source-bound build captured in the bounded-reference run
captured_at: 2026-10-02
command: SLOTSTREAM_TEST_BINARY=.build/quantization-research/frozen-ple-native-v1/slotstream bash Tools/static_gates.sh; slotstream-checks --tier t0 --tier t1 --json
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Bounded reference implementation verification
tool: static_gates.sh and slotstream-checks
---

The first complete static attempt became invalid when the agent edited its shell script's test-registration list while Bash was still consuming the file. Its final partial-line command failed. This is retained as an instrument execution error, not an engine failure or a successful static run. The corrected complete run leaves the driver unchanged and reports STATIC GATES PASS. The added pilot adapter tests and test-driver registration tests also pass.

The native t0/t1 catalogue reports every check passed, no failures or skips. Its complete original JSON is retained locally under the named path; the machine-generated summary below preserves each check's verdict/count and the full report's original size/hash. Component real-row fixtures and frozen binary/source identities are in [[sources/runs/2026/10/2026-10-02-bounded-vq-reference-and-ple]]. These checks do not establish native full-model VQ parity or candidate qualification.

Only local home prefixes are replaced with `<HOME>` in these transcripts. Original size/hash values refer to captured file bytes.

### ple-native-static.log

Original bytes: 32840; SHA-256: `4fe94c4f8a6a54cbf48732140a556c6855741277dbfad86d7534fdccf6f507a4`.

````text
..............................
----------------------------------------------------------------------
Ran 30 tests in 21.864s

OK
..........
----------------------------------------------------------------------
Ran 10 tests in 8.101s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 1.231s

OK
........................
----------------------------------------------------------------------
Ran 24 tests in 10.315s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.649s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 8.459s

OK
.......
----------------------------------------------------------------------
Ran 7 tests in 4.995s

OK
.........
----------------------------------------------------------------------
Ran 9 tests in 7.835s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 1.058s

OK
............................
----------------------------------------------------------------------
Ran 28 tests in 36.457s

OK
coverage comparison and report failure checks pass
..{"phase": "starting", "prompt_tokens": 16, "reclaimable_gb": 20.0}
{"prompt_tokens": 16, "passed": false, "error": "ValueError: capacity rung was incomplete, aborted or over its plan"}
.......
----------------------------------------------------------------------
Ran 9 tests in 0.024s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 3.128s

OK
test_fast_response_remains_complete (__main__.RequestDeadlines) ... ok
test_idle_peer_returns_no_answer (__main__.RequestDeadlines) ... ok
test_incomplete_body_is_not_reported_as_success (__main__.RequestDeadlines) ... ok
test_redirect_remains_supported (__main__.RequestDeadlines) ... ok
test_slow_progress_cannot_extend_the_total_deadline (__main__.RequestDeadlines) ... ok
test_successful_empty_response_is_preserved (__main__.RequestDeadlines) ... ok

----------------------------------------------------------------------
Ran 6 tests in 2.725s

OK
test_gaps_overlaps_and_wrong_spans_stay_rejected (__main__.EmptyTensors) ... ok
test_valid_empty_layouts_are_independent_of_dictionary_order (__main__.EmptyTensors) ... ok

----------------------------------------------------------------------
Ran 2 tests in 0.547s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.503s

OK
.....{"phase": "waiting for build reservation", "seconds": 0.0}
.
----------------------------------------------------------------------
Ran 6 tests in 0.004s

OK
..............
----------------------------------------------------------------------
Ran 14 tests in 1.329s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.000s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 0.001s

OK
...................................................
----------------------------------------------------------------------
Ran 51 tests in 0.015s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.022s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.004s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.000s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.002s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.010s

OK
..............................
----------------------------------------------------------------------
Ran 30 tests in 2.137s

OK
...........
----------------------------------------------------------------------
Ran 11 tests in 0.076s

OK
{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
.{"starting": "native/combined-plain"}
..{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
{"starting": "paired/sampled-short"}
{"starting": "paired/mtp-resource"}
{"starting": "paired/distinct-tail"}
{"starting": "paired/complete-repeat"}
{"starting": "paired/unique-with-retention"}
{"starting": "paired/actual-default-one-token"}
{"starting": "soak/off"}
{"starting": "soak/on"}
....{"starting": "native/combined-plain"}
.{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
.{"starting": "native/combined-plain"}
..{"starting": "native/combined-plain"}
..
----------------------------------------------------------------------
Ran 13 tests in 0.992s

OK
..........{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
.
----------------------------------------------------------------------
Ran 11 tests in 0.076s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.001s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.000s

OK
..
----------------------------------------------------------------------
Ran 2 tests in 0.131s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.003s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.004s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.002s

OK
llms-full.txt is current
0 issue(s): 0 error(s), 0 warning(s), 0 info
MEASUREMENTS.md is current
PLAN.md is current
claims gate: 349 needle checks, 0 failures
BRAIN GATES PASS
dequant_row.txt: OK
layer_0.bin: OK
layer_1.bin: OK
layer_2.bin: OK
layer_3.bin: OK
ngram_ids.txt: OK
tokens.txt: OK
PASS  request VM counters are monotonic
PASS  request VM reclaimable bytes are available
PASS  process physical footprint is readable
PASS  process compatibility high-water is readable
PASS  lifetime RSS is separately readable
PASS  kernel lifetime footprint includes current allocation
PASS  statistics publish current and lifetime observations
PASS  statistics predating the lifetime footprint field still decode
PASS  disk tier statistics round trip
PASS  disk tier statistics from 0.2.18 to 0.2.20, without shared prefixes, still decode
PASS  monotonic duration is nonnegative
PASS  footprint sampler includes endpoints
PASS  automatic platform-qualified optimization defaults
PASS  qualified platform adds independently qualified fused prefill
PASS  unqualified platform 0 keeps portable work and original rotation
PASS  unqualified platform 1 keeps portable work and original rotation
PASS  unqualified platform 2 keeps portable work and original rotation
PASS  unqualified platform 3 keeps portable work and original rotation
PASS  unqualified platform 4 keeps portable work and original rotation
PASS  unqualified platform 5 keeps portable work and original rotation
PASS  unqualified platform 6 keeps portable work and original rotation
PASS  unqualified platform 7 keeps portable work and original rotation
PASS  unqualified platform 8 keeps portable work and original rotation
PASS  unqualified platform 9 keeps portable work and original rotation
PASS  unqualified platform 10 keeps portable work and original rotation
PASS  unqualified platform 11 keeps portable work and original rotation
PASS  unqualified platform 12 keeps portable work and original rotation
PASS  platform selection is deterministic
PASS  explicit kernel qualification remains available
PASS  explicit kernel fallback remains available
PASS  explicit fused attention fallback remains available
PASS  explicit fused attention qualification remains available
PASS  fused capability applegpu_g17s/26.2
PASS  fused capability applegpu_g17s/26.1
PASS  fused capability applegpu_g17p/26.2
PASS  fused capability applegpu_g18p/26.2
PASS  fused capability applegpu_g16s/26.3
PASS  fused capability applegpu_g17s/15.9
PASS  fused capability Unknown/26.2
PASS  fused capability applegpu_g17x/26.2
PASS  backend arithmetic overrides separate cache identity
PASS  unrelated environment does not invalidate arithmetic
PASS  legacy control encoding omits unset fused prefill
PASS  reference control encoding omits unset automatic policy
PASS  old control JSON remains decodable
PASS  automatic policy survives saved control round trip
PASS  absent overrides preserve an inherited automatic policy
PASS  explicit automatic zero restores the chronological policy
PASS  explicit automatic one enables only that policy
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_READ_SCOPE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_INDEXER_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_PLE_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_TILE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_SCOPE_FRONTIER
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_PIECES
PASS  malformed automatic policy refuses/true
PASS  malformed automatic policy refuses/-1
PASS  malformed automatic policy refuses/2
PASS  malformed automatic policy refuses/
PASS  absent vision overrides retain inherited tiling
PASS  explicit zero padding leaves inherited tiling enabled
PASS  explicit zero query tile selects original vision attention
PASS  explicit padding overrides inherited tiling/80
PASS  explicit tiling overrides inherited padding/80
PASS  explicit query zero retains inherited padding/80
PASS  explicit padding with query zero remains valid/80
PASS  explicit query tile with padding zero remains valid/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  explicit padding overrides inherited tiling/128
PASS  explicit tiling overrides inherited padding/128
PASS  explicit query zero retains inherited padding/128
PASS  explicit padding with query zero remains valid/128
PASS  explicit query tile with padding zero remains valid/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/256
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/128
PASS  combined candidate preserves the original MTP verification shape
PASS  absent overrides retain the selected default family
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit zero disables only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit one restores only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit zero disables only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit one restores only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit zero disables only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit one restores only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit zero disables only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit one restores only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit one restores only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit zero disables only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit zero disables only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit zero keeps demand reads staged
PASS  explicit one restores direct demand reads
PASS  explicit zeros restore the complete reference inference family
PASS  explicit numeric zero disables inherited prefix retention
PASS  non-optimization environment leaves the family intact
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_COMPLETE_PROMPT": "false"]
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_TYPO": "0"]
PASS  valid inherited read scope retains its prerequisites
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_STATE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_MTP
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_INDEXER_TILES
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_PLE_TILES
PASS  scope can be disabled while retaining its other independent work
PASS  public environment function value keeps its signature and automatic default
PASS  typed override enables compaction
PASS  combined candidate splits the speculative verify attention
PASS  explicit zero disables only SLOTSTREAM_OPT_VERIFY_SPLIT
PASS  explicit one restores only SLOTSTREAM_OPT_VERIFY_SPLIT
PASS  the verify split threshold override leaves the family intact
PASS  reference leaves the verify-pass controls unset
PASS  explicit verify split threshold is read
PASS  verify split threshold rejects -1
PASS  verify split threshold rejects x
PASS  verify split threshold rejects 1.5
PASS  verify split threshold rejects an empty value
PASS  explicit one enables row-invariant projections
PASS  explicit zero returns row-invariant projections to unset
PASS  row-invariant projections stay off unless selected
PASS  verify split engages from 6,144 keys by default
PASS  exact mode promises passes of up to five rows
PASS  no split control selects the stock verify attention
PASS  the split control alone selects the split
PASS  the split with row-invariant projections selects the exact mode
PASS  stock never engages
PASS  the split engages for three to eight rows from its threshold
PASS  the exact mode engages from two rows, never for one
PASS  malformed override refused
PASS  unknown optimization refused
PASS  invalid read scope -1 refused
PASS  invalid read scope 1 refused
PASS  invalid read scope 16384 refused
PASS  invalid read scope bad refused
PASS  unbounded read scope refused
PASS  explicit workspace tile is recorded
PASS  unbounded workspace tile refused
PASS  terminal output needs no speculative draft
PASS  draft count fits remaining output
PASS  public depth cannot exceed recording cap
PASS  negative remaining output cannot underflow
PASS  prefix cache reaches its four-entry bound
PASS  an identical history replaces instead of duplicating an entry
PASS  a miss evicts before allocating a fifth state
PASS  a smaller live token ceiling evicts immediately
PASS  held GB includes fixed recurrent state
PASS  growing hit still reuses its state
PASS  growing hit reserves future state before allocation
PASS  huge reservation safely misses
PASS  huge reservation releases held state
PASS  capacity reservation still hits
PASS  capacity growth reserves bytes before reuse
PASS  saturated byte reservation evicts safely
PASS  identical bytes hash alike
PASS  different bytes do not
PASS  the same image at the same offset matches
PASS  a swapped image does not
PASS  an entry ending inside a run still matches that run
PASS  a text-only entry rejects a prompt with an image inside its range
PASS  an image beyond the entry's range is irrelevant to the match
PASS  a vision conversation is held, not discarded
PASS  the same ids with a different picture miss
PASS  the text-only splice never sees a vision entry
PASS  prefix splice chooses the longest retained extension
PASS  prefix splice is strict, not an identical-history match
PASS  prefix splice lookup does not consume the retained state
PASS  a disabled prefix cache offers no splice
PASS  shard listing works through a symlinked model dir
PASS  8.1 GB plan stays inside its target
PASS  10.0 GB plan stays inside its target
PASS  16.0 GB plan stays inside its target
PASS  30.0 GB plan stays inside its target
RUNTIME CHECK PASS
{
  "device": "Apple M5 Pro",
  "exit_code": 0,
  "failures": [],
  "maximum_live_gpu_buffer_bytes": 201326592,
  "model_loaded": false,
  "observations": [
    {
      "lifetime_rss_peak_bytes": 12894208,
      "phase": "baseline",
      "physical_footprint_bytes": 4080120,
      "reported_peak_bytes": 12877824,
      "sampled_peak_bytes": 4080120
    },
    {
      "lifetime_rss_peak_bytes": 18464768,
      "phase": "transient_128_mib",
      "physical_footprint_bytes": 202310280,
      "reported_peak_bytes": 202310280,
      "sampled_peak_bytes": 202310280
    },
    {
      "lifetime_rss_peak_bytes": 18464768,
      "phase": "transient_freed",
      "physical_footprint_bytes": 68092552,
      "reported_peak_bytes": 202310280,
      "sampled_peak_bytes": 202310280
    },
    {
      "lifetime_rss_peak_bytes": 18546688,
      "phase": "persistent_64_mib",
      "physical_footprint_bytes": 135283336,
      "reported_peak_bytes": 202310280,
      "sampled_peak_bytes": 202310280
    },
    {
      "lifetime_rss_peak_bytes": 18546688,
      "phase": "persistent_plus_transient",
      "physical_footprint_bytes": 269501064,
      "reported_peak_bytes": 269501064,
      "sampled_peak_bytes": 269501064
    },
    {
      "lifetime_rss_peak_bytes": 18546688,
      "phase": "persistent_after_transient_freed",
      "physical_footprint_bytes": 135283336,
      "reported_peak_bytes": 269501064,
      "sampled_peak_bytes": 269501064
    },
    {
      "lifetime_rss_peak_bytes": 18546688,
      "phase": "all_gpu_buffers_freed",
      "physical_footprint_bytes": 68174472,
      "reported_peak_bytes": 269501064,
      "sampled_peak_bytes": 269501064
    },
    {
      "lifetime_rss_peak_bytes": 26935296,
      "phase": "cpu_allocation_after_gpu_peak",
      "physical_footprint_bytes": 76579488,
      "reported_peak_bytes": 269501064,
      "sampled_peak_bytes": 269501064
    },
    {
      "lifetime_rss_peak_bytes": 26935296,
      "phase": "after_concurrent_reads",
      "physical_footprint_bytes": 68240008,
      "reported_peak_bytes": 269501064,
      "sampled_peak_bytes": 269501064
    }
  ],
  "passed": true,
  "source_sha256": {
    "Sources/Slotstream/Checkpoint.swift": "1d978203cdceea932a94e83b0967adf01e0c80bee4c70e0f818ca34cd235fe2d",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/ProcessMemory.swift": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5",
    "Tools/process_memory_check.swift": "17c4ee5dfdff19b1bc467ad896047f6cc8c35d27850d1a62b88f39ea59ff704b",
    "Tools/process_memory_gate.py": "4c53de73f03cbd0a9483eab0a089cdd7e661db96300ade8ae1ca218d9c29d88a"
  }
}
PASS  matching file is accepted
PASS  same-size corruption is rejected
PASS  exact Content-Range is accepted
PASS  wrong range start is rejected
PASS  wrong range total is rejected
PASS  unknown range total is rejected
PASS  every pinned file has a digest
PASS  the draft head is pinned as the one optional file
PASS  an absent optional file is not a repair; an absent required one is
PASS  an empty directory reads as missing
PASS  missing needs the required model
PASS  status carries free disk
PASS  bytesToFetch agrees with required files
PASS  a missing copy is not ready
PULL CHECK PASS
[
  {
    "case": "success",
    "passed": true,
    "exit": 0,
    "output": "READY_SUCCESS\n"
  },
  {
    "case": "failure",
    "passed": true,
    "exit": 1,
    "output": "ORDINARY_FAILURE\n"
  },
  {
    "case": "cancel-throw",
    "passed": true,
    "exit": 130,
    "output": "download interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "cancel-return",
    "passed": true,
    "exit": 130,
    "output": "download interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "SIGINT",
    "passed": true,
    "exit": 130,
    "output": "WAITING\ndownload interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "SIGTERM",
    "passed": true,
    "exit": 130,
    "output": "WAITING\ndownload interrupted; rerun to resume verified chunks\n"
  }
]
.......
----------------------------------------------------------------------
Ran 7 tests in 0.007s

OK
{"bf16_predictions":16711680,"centers":1000000,"roundtrips":60,"malformed_inputs":39583,"pass":true}
MANIFEST CHECKS PASS
{"name": "normal", "pass_": true, "seconds": 0.302, "returncode": 0}
{"name": "cache-miss-reporting", "pass_": true, "seconds": 0.033, "returncode": 0}
{"name": "redirect", "pass_": true, "seconds": 0.03, "returncode": 0}
{"name": "bad-object-fallback", "pass_": true, "seconds": 0.032, "returncode": 0}
{"name": "missing-object-raw-fallback", "pass_": true, "seconds": 0.031, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.014, "returncode": 1}
{"name": "raw-ignored-range-fails", "pass_": true, "seconds": 0.013, "returncode": 1}
{"name": "optional-absent", "pass_": true, "seconds": 0.025, "returncode": 0}
{"name": "optional-corrupt-and-unavailable", "pass_": true, "seconds": 0.025, "returncode": 0}
{"name": "bad-object-fails", "pass_": true, "seconds": 0.012, "returncode": 1}
{"name": "retry-after", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "hugging-face-rate-limit", "pass_": true, "seconds": 5.415, "returncode": 0}
{"name": "cancel-during-hugging-face-rate-limit", "pass_": true, "seconds": 0.522, "returncode": 1}
{"name": "transient-retry", "pass_": true, "seconds": 5.672, "returncode": 0}
{"name": "wrong-length-fallback", "pass_": true, "seconds": 11.268, "returncode": 0}
{"name": "short-body-fallback", "pass_": true, "seconds": 36.414, "returncode": 0}
{"name": "content-encoding-fallback", "pass_": true, "seconds": 36.2, "returncode": 0}
{"name": "cancel-preserves-progress", "pass_": true, "seconds": 1.491, "returncode": 1}
{"name": "damaged-resumed-chunk-rejected", "pass_": true, "seconds": 0.04, "returncode": 1}
{"name": "damaged-resumed-chunk-repair", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "resume", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "already-installed", "pass_": true, "seconds": 0.013, "returncode": 0}
{"name": "valid-symlinks-reused", "pass_": true, "seconds": 0.013, "returncode": 0}
{"name": "corruption-seed", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "same-size-final-repair", "pass_": true, "seconds": 0.016, "returncode": 0}
{"name": "invalid-resume-map", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "forged-complete-map-without-parts", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "oversized-map-is-discarded", "pass_": true, "seconds": 0.026, "returncode": 0}
{"name": "part-symlink-rejected", "pass_": true, "seconds": 0.005, "returncode": 1}
{"name": "part-hardlink-rejected", "pass_": true, "seconds": 0.004, "returncode": 1}
{"name": "part-fifo-rejected", "pass_": true, "seconds": 0.004, "returncode": 1}
{"name": "concurrent-writer-rejected", "pass_": true, "seconds": 0.014, "returncode": 1}
ALL HTTP CHECKS PASS
{"name": "raw-inflight-peer-failure", "pass_": true, "seconds": 0.556, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-peer-hash-failure", "pass_": true, "seconds": 0.129, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-user-cancel", "pass_": true, "seconds": 0.341, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-success", "pass_": true, "seconds": 0.328, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 0}
{"name": "raw-inflight-optional-failure", "pass_": true, "seconds": 0.333, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 0}
{"name": "raw-retry-after-429", "pass_": true, "seconds": 3.116, "request_offsets": [0.0, 3.089], "returncode": 0}
{"name": "raw-retry-after-503", "pass_": true, "seconds": 3.028, "request_offsets": [0.0, 3.009], "returncode": 0}
{"name": "raw-ratelimit-429", "pass_": true, "seconds": 3.092, "request_offsets": [0.0, 3.064], "returncode": 0}
{"name": "raw-headerless-429-cancel", "pass_": true, "seconds": 3.43, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-long-retry-cancel", "pass_": true, "seconds": 3.45, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-short-retry-cancel", "pass_": true, "seconds": 0.345, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-404-retry-header-fallback", "pass_": true, "seconds": 0.029, "request_offsets": [0.0], "returncode": 0, "fallback_request_offsets": [0.002]}
{"name": "raw-protocol-retry-header-fallback", "pass_": true, "seconds": 0.019, "request_offsets": [0.0], "returncode": 0, "fallback_request_offsets": [0.002]}
{"name": "raw-retry-peer-failure", "pass_": true, "seconds": 0.334, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-retry-optional-skip", "pass_": true, "seconds": 0.354, "request_offsets": [0.0], "returncode": 0, "optional_request_counts": [1, 1]}
{"name": "raw-multichunk", "pass_": true, "seconds": 0.334, "returncode": 0}
{"name": "raw-installed-no-http", "pass_": true, "seconds": 0.254, "returncode": 0}
{"name": "raw-source-fallback-missing", "pass_": true, "seconds": 0.335, "returncode": 0}
{"name": "raw-source-fallback-wrong-range", "pass_": true, "seconds": 0.34, "returncode": 0}
{"name": "raw-source-fallback-encoding", "pass_": true, "seconds": 40.72, "returncode": 0}
{"name": "raw-source-fallback-ignore-range", "pass_": true, "seconds": 0.347, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.027, "returncode": 1}
{"name": "raw-corrupt-final-rejected", "pass_": true, "seconds": 0.172, "returncode": 1}
{"name": "raw-optional-inflight-writers", "pass_": true, "seconds": 0.21, "returncode": 0}
{"name": "raw-cancel", "pass_": true, "seconds": 3.277, "returncode": 1}
{"name": "raw-resume", "pass_": true, "seconds": 0.34, "returncode": 0}
{"name": "raw-same-size-repair", "pass_": true, "seconds": 0.461, "returncode": 0}
ALL RAW HTTP CHECKS PASS
SUSTAINED MEMORY PASS 293781504 bytes peak RSS
SLOTPACK GATES PASS
PASS  48GB pristine: 33.0 GB target and starts quiet
PASS  48GB busy: clamped to 15.4 GB, sized-down note
PASS  16GB pristine: 9.8 GB target, no notes
PASS  16GB busy: refuses an unphysical minimum allocation
PASS  8GB Mac: refuses an unphysical minimum allocation
PASS  128GB auto stops at the knee, not at 70% of RAM
PASS  128GB explains the measured basis for its default
PASS  128GB: --memory-gb still reaches full residency
PASS  --sim-ram alone plans instead of erroring
PASS  --max-ram-percent lowers the auto target
PASS  --max-ram-percent cannot exceed the knee
PASS  --max-ram-percent 0 refused
PASS  --max-ram-percent 150 refused
PASS  --max-ram-percent noted when outranked
PASS  more memory never plans slower (7-90 GB sweep)
PASS  explicit total target cannot authorize unavailable memory
PASS  --experts-per-layer 0 refused
PASS  --pool-gb 0 refused
PASS  --memory-gb below minimum refused
PASS  --memory-gb inf is a clean error
PASS  --pool-gb inf is a clean error
PASS  --pool-gb 1e300 saturates safely instead of trapping
PASS  --memory-gb 1e300 refuses physical overcommit without trapping
PASS  huge finite memory plan remains valid JSON
PASS  --sim-ram inf is a clean error
PASS  --sim-working-set inf is a clean error
PASS  --sim-available inf is a clean error
PASS  tiny pool raised to the floor, consistently
PASS  knob precedence noted, never silent
PASS  --model with no safetensors: clean error
PASS  --model with no safetensors: names the fix
PASS  MTP auto on a big quiet machine: knee + head = 34.6
PASS  a big cache keeps the head's experts resident
PASS  MTP auto stays off on a 16GB machine
PASS  MTP auto on at --memory-gb 30 (137/layer after the charge)
PASS  MTP auto on at --memory-gb 22 (resident: 76/layer after the charge)
PASS  decode lookahead rides the head at --memory-gb 22
PASS  32 GB Mac: auto runs the head and the lookahead
PASS  24 GB Mac: auto streams the head's experts and runs the lookahead
PASS  32 GB Mac at 65,536 tokens keeps the head by streaming its experts
PASS  36 GB Mac at 65,536 tokens keeps the head and the lookahead
PASS  --memory-gb 16: below 76/layer the head streams its experts, with the lookahead
PASS  streamed head charge visible in json
PASS  --memory-gb 12: the streamed head reaches its 28/layer floor
PASS  --memory-gb 11: below the head's floor, plain decode with the lookahead
PASS  SLOTSTREAM_MTP_EXPERTS=resident keeps the resident head's floor
PASS  SLOTSTREAM_MTP_EXPERTS gibberish refused
PASS  SLOTSTREAM_OPT_EXPERT_PREFETCH=0 keeps the head without the lookahead
PASS  decode lookahead charge visible in json
PASS  --mtp on forces the head onto a small machine
PASS  a head forced below the floor runs without the lookahead
PASS  --mtp off suppresses it everywhere
PASS  --mtp off runs the lookahead in plain decode
PASS  --mtp on without mtp.safetensors is a clean error
PASS  --mtp on cannot squeeze under the minimum target plus the streamed head
PASS  --mtp gibberish refused
PASS  MTP charge visible in json peak
PASS  --model with unparseable config: clean error
PASS  invalid config arithmetic is rejected before it traps
PASS  --model with a corrupt safetensors header
PASS  safetensors dtype/shape byte mismatch rejected
PASS  safetensors header over 100MB rejected before allocation
PASS  --model with a different model's tensors
PASS  serve --max-context 0 refused before load
PASS  plan announces the context cap and the wait
PASS  doctor --json carries max_context_tokens + wait
PASS  serve --max-context above the ceiling names the ceiling, not a knob
PASS  doctor --max-context above the ceiling is the same clean error
PASS  a lower --max-context caps the reuse ceiling too
PASS  16 GB Mac: automatic window is 32,768
PASS  24 GB Mac: automatic window is 32,768
PASS  32 GB Mac: automatic window is 32,768 (65,536 would stream the head)
PASS  36 GB Mac: automatic window is 65,536
PASS  48 GB Mac: auto preserves cache with unmeasured benefit
PASS  64 GB Mac: automatic window is 131,072
PASS  96 GB Mac: automatic window is 262,144
PASS  128 GB Mac: automatic window is 262,144
PASS  --max-context auto is the default
PASS  a fixed cache size keeps the default window
PASS  an explicit window is reported as explicit
PASS  128 GB: the window rides above the knee and doctor marks the choice
PASS  a busy big Mac lowers the automatic window and keeps the head
PASS  an explicit window too large to retain says how much follow-ups reuse
PASS  automatic window JSON lists every candidate and retains the chosen window
PASS  serve --max-context auto is accepted by the parser
PASS  an unparseable --max-context is refused
PASS  prefill-schedule: full model window obeys the product without exemptions
PASS  prefill-schedule agrees with the doctor wait for the same pass
PASS  prefill-schedule: a prefix hit reads only what is new
PASS  prefill-schedule --chunk 0 refused
PASS  context-check --tokens 4 refused before load
PASS  parity rejects an invalid layer count before model load
PASS  parity rejects malformed token ids without trapping
PASS  n-gram golden rejects malformed token ids without trapping
PASS  dequant golden rejects a negative row before model load
PASS  sampler golden rejects an empty vocabulary without trapping
PASS  sampler golden rejects a negative draw count without trapping
planner: passed 97, failed 0
{
  "passed": true,
  "model_loaded": false,
  "hardware_qualified": false,
  "binary_sha256": "405087b112d8981fde68bece9dc18b2a2f4fea2ae3f84ed92d936cdddd2d4127",
  "cases": 420,
  "failures": []
}
Tools/static_gates.sh: line 59: _gate.py: command not found
````

### ple-native-static-v2.log

Original bytes: 33167; SHA-256: `f15264093dee6279d2ed70af60e3253359a2539d98b01c2fe67aa1833263d7bb`.

````text
..............................
----------------------------------------------------------------------
Ran 30 tests in 21.062s

OK
..........
----------------------------------------------------------------------
Ran 10 tests in 6.947s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 1.104s

OK
........................
----------------------------------------------------------------------
Ran 24 tests in 9.105s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.836s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 8.356s

OK
.......
----------------------------------------------------------------------
Ran 7 tests in 4.806s

OK
.........
----------------------------------------------------------------------
Ran 9 tests in 7.548s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.846s

OK
............................
----------------------------------------------------------------------
Ran 28 tests in 35.562s

OK
coverage comparison and report failure checks pass
..{"phase": "starting", "prompt_tokens": 16, "reclaimable_gb": 20.0}
{"prompt_tokens": 16, "passed": false, "error": "ValueError: capacity rung was incomplete, aborted or over its plan"}
.......
----------------------------------------------------------------------
Ran 9 tests in 0.026s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 3.132s

OK
test_fast_response_remains_complete (__main__.RequestDeadlines) ... ok
test_idle_peer_returns_no_answer (__main__.RequestDeadlines) ... ok
test_incomplete_body_is_not_reported_as_success (__main__.RequestDeadlines) ... ok
test_redirect_remains_supported (__main__.RequestDeadlines) ... ok
test_slow_progress_cannot_extend_the_total_deadline (__main__.RequestDeadlines) ... ok
test_successful_empty_response_is_preserved (__main__.RequestDeadlines) ... ok

----------------------------------------------------------------------
Ran 6 tests in 2.664s

OK
test_gaps_overlaps_and_wrong_spans_stay_rejected (__main__.EmptyTensors) ... ok
test_valid_empty_layouts_are_independent_of_dictionary_order (__main__.EmptyTensors) ... ok

----------------------------------------------------------------------
Ran 2 tests in 0.587s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.508s

OK
.....{"phase": "waiting for build reservation", "seconds": 0.0}
.
----------------------------------------------------------------------
Ran 6 tests in 0.004s

OK
..............
----------------------------------------------------------------------
Ran 14 tests in 1.344s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.000s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 0.001s

OK
...................................................
----------------------------------------------------------------------
Ran 51 tests in 0.015s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.018s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.004s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.000s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.002s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.010s

OK
..............................
----------------------------------------------------------------------
Ran 30 tests in 2.129s

OK
...........
----------------------------------------------------------------------
Ran 11 tests in 0.069s

OK
{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
.{"starting": "native/combined-plain"}
..{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
{"starting": "paired/unique-prose"}
{"starting": "paired/sampled-short"}
{"starting": "paired/mtp-resource"}
{"starting": "paired/distinct-tail"}
{"starting": "paired/complete-repeat"}
{"starting": "paired/unique-with-retention"}
{"starting": "paired/actual-default-one-token"}
{"starting": "soak/off"}
{"starting": "soak/on"}
....{"starting": "native/combined-plain"}
.{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
.{"starting": "native/combined-plain"}
..{"starting": "native/combined-plain"}
..
----------------------------------------------------------------------
Ran 13 tests in 0.992s

OK
..........{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
.
----------------------------------------------------------------------
Ran 11 tests in 0.076s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.001s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.000s

OK
..
----------------------------------------------------------------------
Ran 2 tests in 0.136s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.002s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.003s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.004s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 0.001s

OK
llms-full.txt is current
0 issue(s): 0 error(s), 0 warning(s), 0 info
MEASUREMENTS.md is current
PLAN.md is current
claims gate: 349 needle checks, 0 failures
BRAIN GATES PASS
dequant_row.txt: OK
layer_0.bin: OK
layer_1.bin: OK
layer_2.bin: OK
layer_3.bin: OK
ngram_ids.txt: OK
tokens.txt: OK
PASS  request VM counters are monotonic
PASS  request VM reclaimable bytes are available
PASS  process physical footprint is readable
PASS  process compatibility high-water is readable
PASS  lifetime RSS is separately readable
PASS  kernel lifetime footprint includes current allocation
PASS  statistics publish current and lifetime observations
PASS  statistics predating the lifetime footprint field still decode
PASS  disk tier statistics round trip
PASS  disk tier statistics from 0.2.18 to 0.2.20, without shared prefixes, still decode
PASS  monotonic duration is nonnegative
PASS  footprint sampler includes endpoints
PASS  automatic platform-qualified optimization defaults
PASS  qualified platform adds independently qualified fused prefill
PASS  unqualified platform 0 keeps portable work and original rotation
PASS  unqualified platform 1 keeps portable work and original rotation
PASS  unqualified platform 2 keeps portable work and original rotation
PASS  unqualified platform 3 keeps portable work and original rotation
PASS  unqualified platform 4 keeps portable work and original rotation
PASS  unqualified platform 5 keeps portable work and original rotation
PASS  unqualified platform 6 keeps portable work and original rotation
PASS  unqualified platform 7 keeps portable work and original rotation
PASS  unqualified platform 8 keeps portable work and original rotation
PASS  unqualified platform 9 keeps portable work and original rotation
PASS  unqualified platform 10 keeps portable work and original rotation
PASS  unqualified platform 11 keeps portable work and original rotation
PASS  unqualified platform 12 keeps portable work and original rotation
PASS  platform selection is deterministic
PASS  explicit kernel qualification remains available
PASS  explicit kernel fallback remains available
PASS  explicit fused attention fallback remains available
PASS  explicit fused attention qualification remains available
PASS  fused capability applegpu_g17s/26.2
PASS  fused capability applegpu_g17s/26.1
PASS  fused capability applegpu_g17p/26.2
PASS  fused capability applegpu_g18p/26.2
PASS  fused capability applegpu_g16s/26.3
PASS  fused capability applegpu_g17s/15.9
PASS  fused capability Unknown/26.2
PASS  fused capability applegpu_g17x/26.2
PASS  backend arithmetic overrides separate cache identity
PASS  unrelated environment does not invalidate arithmetic
PASS  legacy control encoding omits unset fused prefill
PASS  reference control encoding omits unset automatic policy
PASS  old control JSON remains decodable
PASS  automatic policy survives saved control round trip
PASS  absent overrides preserve an inherited automatic policy
PASS  explicit automatic zero restores the chronological policy
PASS  explicit automatic one enables only that policy
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_READ_SCOPE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_INDEXER_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_PLE_TILES
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_TILE
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_SCOPE_FRONTIER
PASS  manual scope control suppresses inherited automatic policy/SLOTSTREAM_OPT_WORKSPACE_PIECES
PASS  malformed automatic policy refuses/true
PASS  malformed automatic policy refuses/-1
PASS  malformed automatic policy refuses/2
PASS  malformed automatic policy refuses/
PASS  absent vision overrides retain inherited tiling
PASS  explicit zero padding leaves inherited tiling enabled
PASS  explicit zero query tile selects original vision attention
PASS  explicit padding overrides inherited tiling/80
PASS  explicit tiling overrides inherited padding/80
PASS  explicit query zero retains inherited padding/80
PASS  explicit padding with query zero remains valid/80
PASS  explicit query tile with padding zero remains valid/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  two explicit vision alternatives refuse/80
PASS  explicit padding overrides inherited tiling/128
PASS  explicit tiling overrides inherited padding/128
PASS  explicit query zero retains inherited padding/128
PASS  explicit padding with query zero remains valid/128
PASS  explicit query tile with padding zero remains valid/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  two explicit vision alternatives refuse/128
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_PADDING/256
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/bad
PASS  inherited vision defaults still reject malformed override/SLOTSTREAM_OPT_VISION_QUERY_TILE/128
PASS  combined candidate preserves the original MTP verification shape
PASS  absent overrides retain the selected default family
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_STATE
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit one restores only SLOTSTREAM_OPT_COMPACT_MTP
PASS  explicit zero disables only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit one restores only SLOTSTREAM_OPT_NGRAM_ROWS
PASS  explicit zero disables only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit one restores only SLOTSTREAM_OPT_FINAL_FORWARD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_THRESHOLD
PASS  explicit zero disables only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit one restores only SLOTSTREAM_OPT_SAMPLER_DRAW
PASS  explicit zero disables only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit one restores only SLOTSTREAM_OPT_OUTPUT_QUEUE
PASS  explicit zero disables only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit one restores only SLOTSTREAM_OPT_RESPONSIVE_GOVERNOR
PASS  explicit zero disables only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit one restores only SLOTSTREAM_OPT_COMPLETE_PROMPT
PASS  explicit zero disables only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_SHARED_ROPE
PASS  explicit zero disables only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit one restores only SLOTSTREAM_OPT_FUSED_ROPE
PASS  explicit zero keeps demand reads staged
PASS  explicit one restores direct demand reads
PASS  explicit zeros restore the complete reference inference family
PASS  explicit numeric zero disables inherited prefix retention
PASS  non-optimization environment leaves the family intact
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_COMPLETE_PROMPT": "false"]
PASS  selected defaults still reject invalid override ["SLOTSTREAM_OPT_TYPO": "0"]
PASS  valid inherited read scope retains its prerequisites
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_STATE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_COMPACT_MTP
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_LAYER_WORKSPACE
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_INDEXER_TILES
PASS  inherited scope rejects disabled prerequisite SLOTSTREAM_OPT_PLE_TILES
PASS  scope can be disabled while retaining its other independent work
PASS  public environment function value keeps its signature and automatic default
PASS  typed override enables compaction
PASS  combined candidate splits the speculative verify attention
PASS  explicit zero disables only SLOTSTREAM_OPT_VERIFY_SPLIT
PASS  explicit one restores only SLOTSTREAM_OPT_VERIFY_SPLIT
PASS  the verify split threshold override leaves the family intact
PASS  reference leaves the verify-pass controls unset
PASS  explicit verify split threshold is read
PASS  verify split threshold rejects -1
PASS  verify split threshold rejects x
PASS  verify split threshold rejects 1.5
PASS  verify split threshold rejects an empty value
PASS  explicit one enables row-invariant projections
PASS  explicit zero returns row-invariant projections to unset
PASS  row-invariant projections stay off unless selected
PASS  verify split engages from 6,144 keys by default
PASS  exact mode promises passes of up to five rows
PASS  no split control selects the stock verify attention
PASS  the split control alone selects the split
PASS  the split with row-invariant projections selects the exact mode
PASS  stock never engages
PASS  the split engages for three to eight rows from its threshold
PASS  the exact mode engages from two rows, never for one
PASS  malformed override refused
PASS  unknown optimization refused
PASS  invalid read scope -1 refused
PASS  invalid read scope 1 refused
PASS  invalid read scope 16384 refused
PASS  invalid read scope bad refused
PASS  unbounded read scope refused
PASS  explicit workspace tile is recorded
PASS  unbounded workspace tile refused
PASS  terminal output needs no speculative draft
PASS  draft count fits remaining output
PASS  public depth cannot exceed recording cap
PASS  negative remaining output cannot underflow
PASS  prefix cache reaches its four-entry bound
PASS  an identical history replaces instead of duplicating an entry
PASS  a miss evicts before allocating a fifth state
PASS  a smaller live token ceiling evicts immediately
PASS  held GB includes fixed recurrent state
PASS  growing hit still reuses its state
PASS  growing hit reserves future state before allocation
PASS  huge reservation safely misses
PASS  huge reservation releases held state
PASS  capacity reservation still hits
PASS  capacity growth reserves bytes before reuse
PASS  saturated byte reservation evicts safely
PASS  identical bytes hash alike
PASS  different bytes do not
PASS  the same image at the same offset matches
PASS  a swapped image does not
PASS  an entry ending inside a run still matches that run
PASS  a text-only entry rejects a prompt with an image inside its range
PASS  an image beyond the entry's range is irrelevant to the match
PASS  a vision conversation is held, not discarded
PASS  the same ids with a different picture miss
PASS  the text-only splice never sees a vision entry
PASS  prefix splice chooses the longest retained extension
PASS  prefix splice is strict, not an identical-history match
PASS  prefix splice lookup does not consume the retained state
PASS  a disabled prefix cache offers no splice
PASS  shard listing works through a symlinked model dir
PASS  8.1 GB plan stays inside its target
PASS  10.0 GB plan stays inside its target
PASS  16.0 GB plan stays inside its target
PASS  30.0 GB plan stays inside its target
RUNTIME CHECK PASS
{
  "device": "Apple M5 Pro",
  "exit_code": 0,
  "failures": [],
  "maximum_live_gpu_buffer_bytes": 201326592,
  "model_loaded": false,
  "observations": [
    {
      "lifetime_rss_peak_bytes": 12910592,
      "phase": "baseline",
      "physical_footprint_bytes": 4112912,
      "reported_peak_bytes": 12894208,
      "sampled_peak_bytes": 4112912
    },
    {
      "lifetime_rss_peak_bytes": 18481152,
      "phase": "transient_128_mib",
      "physical_footprint_bytes": 202326664,
      "reported_peak_bytes": 202326664,
      "sampled_peak_bytes": 202326664
    },
    {
      "lifetime_rss_peak_bytes": 18481152,
      "phase": "transient_freed",
      "physical_footprint_bytes": 68108936,
      "reported_peak_bytes": 202326664,
      "sampled_peak_bytes": 202326664
    },
    {
      "lifetime_rss_peak_bytes": 18563072,
      "phase": "persistent_64_mib",
      "physical_footprint_bytes": 135299720,
      "reported_peak_bytes": 202326664,
      "sampled_peak_bytes": 202326664
    },
    {
      "lifetime_rss_peak_bytes": 18563072,
      "phase": "persistent_plus_transient",
      "physical_footprint_bytes": 269517448,
      "reported_peak_bytes": 269517448,
      "sampled_peak_bytes": 269517448
    },
    {
      "lifetime_rss_peak_bytes": 18563072,
      "phase": "persistent_after_transient_freed",
      "physical_footprint_bytes": 135299720,
      "reported_peak_bytes": 269517448,
      "sampled_peak_bytes": 269517448
    },
    {
      "lifetime_rss_peak_bytes": 18563072,
      "phase": "all_gpu_buffers_freed",
      "physical_footprint_bytes": 68190856,
      "reported_peak_bytes": 269517448,
      "sampled_peak_bytes": 269517448
    },
    {
      "lifetime_rss_peak_bytes": 26951680,
      "phase": "cpu_allocation_after_gpu_peak",
      "physical_footprint_bytes": 76595872,
      "reported_peak_bytes": 269517448,
      "sampled_peak_bytes": 269517448
    },
    {
      "lifetime_rss_peak_bytes": 26951680,
      "phase": "after_concurrent_reads",
      "physical_footprint_bytes": 68272800,
      "reported_peak_bytes": 269517448,
      "sampled_peak_bytes": 269517448
    }
  ],
  "passed": true,
  "source_sha256": {
    "Sources/Slotstream/Checkpoint.swift": "1d978203cdceea932a94e83b0967adf01e0c80bee4c70e0f818ca34cd235fe2d",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/ProcessMemory.swift": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5",
    "Tools/process_memory_check.swift": "17c4ee5dfdff19b1bc467ad896047f6cc8c35d27850d1a62b88f39ea59ff704b",
    "Tools/process_memory_gate.py": "4c53de73f03cbd0a9483eab0a089cdd7e661db96300ade8ae1ca218d9c29d88a"
  }
}
PASS  matching file is accepted
PASS  same-size corruption is rejected
PASS  exact Content-Range is accepted
PASS  wrong range start is rejected
PASS  wrong range total is rejected
PASS  unknown range total is rejected
PASS  every pinned file has a digest
PASS  the draft head is pinned as the one optional file
PASS  an absent optional file is not a repair; an absent required one is
PASS  an empty directory reads as missing
PASS  missing needs the required model
PASS  status carries free disk
PASS  bytesToFetch agrees with required files
PASS  a missing copy is not ready
PULL CHECK PASS
[
  {
    "case": "success",
    "passed": true,
    "exit": 0,
    "output": "READY_SUCCESS\n"
  },
  {
    "case": "failure",
    "passed": true,
    "exit": 1,
    "output": "ORDINARY_FAILURE\n"
  },
  {
    "case": "cancel-throw",
    "passed": true,
    "exit": 130,
    "output": "download interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "cancel-return",
    "passed": true,
    "exit": 130,
    "output": "download interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "SIGINT",
    "passed": true,
    "exit": 130,
    "output": "WAITING\ndownload interrupted; rerun to resume verified chunks\n"
  },
  {
    "case": "SIGTERM",
    "passed": true,
    "exit": 130,
    "output": "WAITING\ndownload interrupted; rerun to resume verified chunks\n"
  }
]
.......
----------------------------------------------------------------------
Ran 7 tests in 0.007s

OK
{"bf16_predictions":16711680,"centers":1000000,"roundtrips":60,"malformed_inputs":39583,"pass":true}
MANIFEST CHECKS PASS
{"name": "normal", "pass_": true, "seconds": 0.306, "returncode": 0}
{"name": "cache-miss-reporting", "pass_": true, "seconds": 0.031, "returncode": 0}
{"name": "redirect", "pass_": true, "seconds": 0.031, "returncode": 0}
{"name": "bad-object-fallback", "pass_": true, "seconds": 0.03, "returncode": 0}
{"name": "missing-object-raw-fallback", "pass_": true, "seconds": 0.03, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.013, "returncode": 1}
{"name": "raw-ignored-range-fails", "pass_": true, "seconds": 0.012, "returncode": 1}
{"name": "optional-absent", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "optional-corrupt-and-unavailable", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "bad-object-fails", "pass_": true, "seconds": 0.013, "returncode": 1}
{"name": "retry-after", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "hugging-face-rate-limit", "pass_": true, "seconds": 5.582, "returncode": 0}
{"name": "cancel-during-hugging-face-rate-limit", "pass_": true, "seconds": 0.483, "returncode": 1}
{"name": "transient-retry", "pass_": true, "seconds": 5.616, "returncode": 0}
{"name": "wrong-length-fallback", "pass_": true, "seconds": 11.392, "returncode": 0}
{"name": "short-body-fallback", "pass_": true, "seconds": 36.45, "returncode": 0}
{"name": "content-encoding-fallback", "pass_": true, "seconds": 36.608, "returncode": 0}
{"name": "cancel-preserves-progress", "pass_": true, "seconds": 1.466, "returncode": 1}
{"name": "damaged-resumed-chunk-rejected", "pass_": true, "seconds": 0.034, "returncode": 1}
{"name": "damaged-resumed-chunk-repair", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "resume", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "already-installed", "pass_": true, "seconds": 0.013, "returncode": 0}
{"name": "valid-symlinks-reused", "pass_": true, "seconds": 0.013, "returncode": 0}
{"name": "corruption-seed", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "same-size-final-repair", "pass_": true, "seconds": 0.016, "returncode": 0}
{"name": "invalid-resume-map", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "forged-complete-map-without-parts", "pass_": true, "seconds": 0.027, "returncode": 0}
{"name": "oversized-map-is-discarded", "pass_": true, "seconds": 0.033, "returncode": 0}
{"name": "part-symlink-rejected", "pass_": true, "seconds": 0.005, "returncode": 1}
{"name": "part-hardlink-rejected", "pass_": true, "seconds": 0.004, "returncode": 1}
{"name": "part-fifo-rejected", "pass_": true, "seconds": 0.004, "returncode": 1}
{"name": "concurrent-writer-rejected", "pass_": true, "seconds": 0.014, "returncode": 1}
ALL HTTP CHECKS PASS
{"name": "raw-inflight-peer-failure", "pass_": true, "seconds": 0.49, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-peer-hash-failure", "pass_": true, "seconds": 0.12, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-user-cancel", "pass_": true, "seconds": 0.339, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 1}
{"name": "raw-inflight-success", "pass_": true, "seconds": 0.337, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 0}
{"name": "raw-inflight-optional-failure", "pass_": true, "seconds": 0.337, "timed_out": false, "request_counts": {"slow.bin": 1, "peer.bin": 1}, "returncode": 0}
{"name": "raw-retry-after-429", "pass_": true, "seconds": 3.124, "request_offsets": [0.0, 3.094], "returncode": 0}
{"name": "raw-retry-after-503", "pass_": true, "seconds": 3.093, "request_offsets": [0.0, 3.067], "returncode": 0}
{"name": "raw-ratelimit-429", "pass_": true, "seconds": 3.125, "request_offsets": [0.0, 3.095], "returncode": 0}
{"name": "raw-headerless-429-cancel", "pass_": true, "seconds": 3.413, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-long-retry-cancel", "pass_": true, "seconds": 3.408, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-short-retry-cancel", "pass_": true, "seconds": 0.339, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-404-retry-header-fallback", "pass_": true, "seconds": 0.027, "request_offsets": [0.0], "returncode": 0, "fallback_request_offsets": [0.002]}
{"name": "raw-protocol-retry-header-fallback", "pass_": true, "seconds": 0.017, "request_offsets": [0.0], "returncode": 0, "fallback_request_offsets": [0.002]}
{"name": "raw-retry-peer-failure", "pass_": true, "seconds": 0.341, "request_offsets": [0.0], "returncode": 1}
{"name": "raw-retry-optional-skip", "pass_": true, "seconds": 0.345, "request_offsets": [0.0], "returncode": 0, "optional_request_counts": [1, 1]}
{"name": "raw-multichunk", "pass_": true, "seconds": 0.333, "returncode": 0}
{"name": "raw-installed-no-http", "pass_": true, "seconds": 0.255, "returncode": 0}
{"name": "raw-source-fallback-missing", "pass_": true, "seconds": 0.332, "returncode": 0}
{"name": "raw-source-fallback-wrong-range", "pass_": true, "seconds": 0.337, "returncode": 0}
{"name": "raw-source-fallback-encoding", "pass_": true, "seconds": 40.726, "returncode": 0}
{"name": "raw-source-fallback-ignore-range", "pass_": true, "seconds": 0.339, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.023, "returncode": 1}
{"name": "raw-corrupt-final-rejected", "pass_": true, "seconds": 0.172, "returncode": 1}
{"name": "raw-optional-inflight-writers", "pass_": true, "seconds": 0.209, "returncode": 0}
{"name": "raw-cancel", "pass_": true, "seconds": 3.29, "returncode": 1}
{"name": "raw-resume", "pass_": true, "seconds": 0.338, "returncode": 0}
{"name": "raw-same-size-repair", "pass_": true, "seconds": 0.463, "returncode": 0}
ALL RAW HTTP CHECKS PASS
SUSTAINED MEMORY PASS 292339712 bytes peak RSS
SLOTPACK GATES PASS
PASS  48GB pristine: 33.0 GB target and starts quiet
PASS  48GB busy: clamped to 15.4 GB, sized-down note
PASS  16GB pristine: 9.8 GB target, no notes
PASS  16GB busy: refuses an unphysical minimum allocation
PASS  8GB Mac: refuses an unphysical minimum allocation
PASS  128GB auto stops at the knee, not at 70% of RAM
PASS  128GB explains the measured basis for its default
PASS  128GB: --memory-gb still reaches full residency
PASS  --sim-ram alone plans instead of erroring
PASS  --max-ram-percent lowers the auto target
PASS  --max-ram-percent cannot exceed the knee
PASS  --max-ram-percent 0 refused
PASS  --max-ram-percent 150 refused
PASS  --max-ram-percent noted when outranked
PASS  more memory never plans slower (7-90 GB sweep)
PASS  explicit total target cannot authorize unavailable memory
PASS  --experts-per-layer 0 refused
PASS  --pool-gb 0 refused
PASS  --memory-gb below minimum refused
PASS  --memory-gb inf is a clean error
PASS  --pool-gb inf is a clean error
PASS  --pool-gb 1e300 saturates safely instead of trapping
PASS  --memory-gb 1e300 refuses physical overcommit without trapping
PASS  huge finite memory plan remains valid JSON
PASS  --sim-ram inf is a clean error
PASS  --sim-working-set inf is a clean error
PASS  --sim-available inf is a clean error
PASS  tiny pool raised to the floor, consistently
PASS  knob precedence noted, never silent
PASS  --model with no safetensors: clean error
PASS  --model with no safetensors: names the fix
PASS  MTP auto on a big quiet machine: knee + head = 34.6
PASS  a big cache keeps the head's experts resident
PASS  MTP auto stays off on a 16GB machine
PASS  MTP auto on at --memory-gb 30 (137/layer after the charge)
PASS  MTP auto on at --memory-gb 22 (resident: 76/layer after the charge)
PASS  decode lookahead rides the head at --memory-gb 22
PASS  32 GB Mac: auto runs the head and the lookahead
PASS  24 GB Mac: auto streams the head's experts and runs the lookahead
PASS  32 GB Mac at 65,536 tokens keeps the head by streaming its experts
PASS  36 GB Mac at 65,536 tokens keeps the head and the lookahead
PASS  --memory-gb 16: below 76/layer the head streams its experts, with the lookahead
PASS  streamed head charge visible in json
PASS  --memory-gb 12: the streamed head reaches its 28/layer floor
PASS  --memory-gb 11: below the head's floor, plain decode with the lookahead
PASS  SLOTSTREAM_MTP_EXPERTS=resident keeps the resident head's floor
PASS  SLOTSTREAM_MTP_EXPERTS gibberish refused
PASS  SLOTSTREAM_OPT_EXPERT_PREFETCH=0 keeps the head without the lookahead
PASS  decode lookahead charge visible in json
PASS  --mtp on forces the head onto a small machine
PASS  a head forced below the floor runs without the lookahead
PASS  --mtp off suppresses it everywhere
PASS  --mtp off runs the lookahead in plain decode
PASS  --mtp on without mtp.safetensors is a clean error
PASS  --mtp on cannot squeeze under the minimum target plus the streamed head
PASS  --mtp gibberish refused
PASS  MTP charge visible in json peak
PASS  --model with unparseable config: clean error
PASS  invalid config arithmetic is rejected before it traps
PASS  --model with a corrupt safetensors header
PASS  safetensors dtype/shape byte mismatch rejected
PASS  safetensors header over 100MB rejected before allocation
PASS  --model with a different model's tensors
PASS  serve --max-context 0 refused before load
PASS  plan announces the context cap and the wait
PASS  doctor --json carries max_context_tokens + wait
PASS  serve --max-context above the ceiling names the ceiling, not a knob
PASS  doctor --max-context above the ceiling is the same clean error
PASS  a lower --max-context caps the reuse ceiling too
PASS  16 GB Mac: automatic window is 32,768
PASS  24 GB Mac: automatic window is 32,768
PASS  32 GB Mac: automatic window is 32,768 (65,536 would stream the head)
PASS  36 GB Mac: automatic window is 65,536
PASS  48 GB Mac: auto preserves cache with unmeasured benefit
PASS  64 GB Mac: automatic window is 131,072
PASS  96 GB Mac: automatic window is 262,144
PASS  128 GB Mac: automatic window is 262,144
PASS  --max-context auto is the default
PASS  a fixed cache size keeps the default window
PASS  an explicit window is reported as explicit
PASS  128 GB: the window rides above the knee and doctor marks the choice
PASS  a busy big Mac lowers the automatic window and keeps the head
PASS  an explicit window too large to retain says how much follow-ups reuse
PASS  automatic window JSON lists every candidate and retains the chosen window
PASS  serve --max-context auto is accepted by the parser
PASS  an unparseable --max-context is refused
PASS  prefill-schedule: full model window obeys the product without exemptions
PASS  prefill-schedule agrees with the doctor wait for the same pass
PASS  prefill-schedule: a prefix hit reads only what is new
PASS  prefill-schedule --chunk 0 refused
PASS  context-check --tokens 4 refused before load
PASS  parity rejects an invalid layer count before model load
PASS  parity rejects malformed token ids without trapping
PASS  n-gram golden rejects malformed token ids without trapping
PASS  dequant golden rejects a negative row before model load
PASS  sampler golden rejects an empty vocabulary without trapping
PASS  sampler golden rejects a negative draw count without trapping
planner: passed 97, failed 0
{
  "passed": true,
  "model_loaded": false,
  "hardware_qualified": false,
  "binary_sha256": "405087b112d8981fde68bece9dc18b2a2f4fea2ae3f84ed92d936cdddd2d4127",
  "cases": 420,
  "failures": []
}
######################################################################## 100.0%
######################################################################## 100.0%
######################################################################## 100.0%
INSTALLER GATES PASS
STATIC GATES PASS
````

### ple-static-runner-v2.log

Original bytes: 130; SHA-256: `4785cbcae2d74117a69ed3ec9c6e8ddd463dc6a3ab074d3fb2a59b7462174899`.

````text
..............................
----------------------------------------------------------------------
Ran 30 tests in 22.687s

OK
````

### logit-pilot-v1-tests-v2.log

Original bytes: 102; SHA-256: `56e03afda220e7ba78bbcecf9a2e53a0149cfc3e311fa10bbd01b25e8e5ba671`.

````text
....
----------------------------------------------------------------------
Ran 4 tests in 0.003s

OK
````

### ple-native-catalogue-summary.json

Original bytes: 9400; SHA-256: `4384dc5d81aed28a46e896056014b7fdee43232c65cfb919019eedba274e80cd`.

````text
{
  "command": ".build/quantization-research/frozen-ple-native-v1/slotstream-checks --tier t0 --tier t1 --json",
  "full_report_bytes": 3426730,
  "full_report_sha256": "aa523c198992a46e1df100518e44235dfbd33f210375dbc4276625f0ec2e43df",
  "passed": 93,
  "failed": 0,
  "skipped": 0,
  "checks": [
    {
      "name": "quantization-geometry",
      "passed": true,
      "assertions": 12
    },
    {
      "name": "quantization-metadata",
      "passed": true,
      "assertions": 25
    },
    {
      "name": "quantization-ple-storage",
      "passed": true,
      "assertions": 49
    },
    {
      "name": "quantization-kernels",
      "passed": true,
      "assertions": 66
    },
    {
      "name": "persistent-prefix-metadata-bounds",
      "passed": true,
      "assertions": 99
    },
    {
      "name": "prefill-schedule",
      "passed": true,
      "assertions": 22
    },
    {
      "name": "context-policy",
      "passed": true,
      "assertions": 8
    },
    {
      "name": "automatic-context-window",
      "passed": true,
      "assertions": 82
    },
    {
      "name": "memory-budget-context",
      "passed": true,
      "assertions": 86
    },
    {
      "name": "configurable-context",
      "passed": true,
      "assertions": 5176
    },
    {
      "name": "optimization-exact-read",
      "passed": true,
      "assertions": 14
    },
    {
      "name": "optimization-packed-layout",
      "passed": true,
      "assertions": 288
    },
    {
      "name": "optimization-ngram-prefetch-ticket",
      "passed": true,
      "assertions": 28
    },
    {
      "name": "optimization-cache-bookkeeping",
      "passed": true,
      "assertions": 20619
    },
    {
      "name": "optimization-adaptive-policy",
      "passed": true,
      "assertions": 75
    },
    {
      "name": "optimization-runtime-budget",
      "passed": true,
      "assertions": 561
    },
    {
      "name": "optimization-layer-local-victim",
      "passed": true,
      "assertions": 226
    },
    {
      "name": "optimization-pressure-boundary",
      "passed": true,
      "assertions": 74
    },
    {
      "name": "runtime-check",
      "passed": true,
      "assertions": 188
    },
    {
      "name": "optimization-prefix-client-capacity",
      "passed": true,
      "assertions": 79
    },
    {
      "name": "persistent-prefix-policy",
      "passed": true,
      "assertions": 126
    },
    {
      "name": "persistent-prefix-clear",
      "passed": true,
      "assertions": 18
    },
    {
      "name": "persistent-conversation-ids",
      "passed": true,
      "assertions": 12
    },
    {
      "name": "persistent-prefix-removal-failures",
      "passed": true,
      "assertions": 50
    },
    {
      "name": "persistent-prefix-read-failures",
      "passed": true,
      "assertions": 36
    },
    {
      "name": "governor-check",
      "passed": true,
      "assertions": 38
    },
    {
      "name": "pull-check",
      "passed": true,
      "assertions": 14
    },
    {
      "name": "machine-planning",
      "passed": true,
      "assertions": 15
    },
    {
      "name": "http-framing",
      "passed": true,
      "assertions": 63
    },
    {
      "name": "http-routing",
      "passed": true,
      "assertions": 23
    },
    {
      "name": "optimization-bounded-output",
      "passed": true,
      "assertions": 38
    },
    {
      "name": "expert-lookahead-lane-budget",
      "passed": true,
      "assertions": 16
    },
    {
      "name": "expert-lookahead-tickets",
      "passed": true,
      "assertions": 61
    },
    {
      "name": "expert-lookahead-scheduler",
      "passed": true,
      "assertions": 26
    },
    {
      "name": "expert-lookahead-forecast-merge",
      "passed": true,
      "assertions": 38
    },
    {
      "name": "expert-lookahead-forecast-tap",
      "passed": true,
      "assertions": 72
    },
    {
      "name": "decode-lookahead-defaults",
      "passed": true,
      "assertions": 57
    },
    {
      "name": "gpu-keepalive-policy",
      "passed": true,
      "assertions": 9
    },
    {
      "name": "vision-check",
      "passed": true,
      "assertions": 169
    },
    {
      "name": "fused-workspace-reservation",
      "passed": true,
      "assertions": 164
    },
    {
      "name": "fused-prefill-attention",
      "passed": true,
      "assertions": 34
    },
    {
      "name": "sampler-behaviour",
      "passed": true,
      "assertions": 647
    },
    {
      "name": "expert-lookahead-adoption",
      "passed": true,
      "assertions": 10
    },
    {
      "name": "expert-lookahead-routing-readback",
      "passed": true,
      "assertions": 14
    },
    {
      "name": "optimization-compact-indexer",
      "passed": true,
      "assertions": 84
    },
    {
      "name": "persistent-prefix-round-trip",
      "passed": true,
      "assertions": 110
    },
    {
      "name": "aligned-prefix-resume",
      "passed": true,
      "assertions": 43
    },
    {
      "name": "optimization-slot-slices",
      "passed": true,
      "assertions": 196
    },
    {
      "name": "optimization-slot-words",
      "passed": true,
      "assertions": 436
    },
    {
      "name": "vision-splice",
      "passed": true,
      "assertions": 12
    },
    {
      "name": "optimization-vision-attention",
      "passed": true,
      "assertions": 60
    },
    {
      "name": "optimization-router-selection",
      "passed": true,
      "assertions": 43
    },
    {
      "name": "optimization-compiled-norm",
      "passed": true,
      "assertions": 49
    },
    {
      "name": "optimization-router-projection",
      "passed": true,
      "assertions": 30
    },
    {
      "name": "verify-pass-rows",
      "passed": true,
      "assertions": 48
    },
    {
      "name": "optimization-indexer-block-selection",
      "passed": true,
      "assertions": 163
    },
    {
      "name": "optimization-indexer-visibility",
      "passed": true,
      "assertions": 262
    },
    {
      "name": "gpu-keepalive-runs",
      "passed": true,
      "assertions": 4
    },
    {
      "name": "toolcall-check",
      "passed": true,
      "assertions": 19
    },
    {
      "name": "toolcall-stream-check",
      "passed": true,
      "assertions": 14
    },
    {
      "name": "toolcall-coercion",
      "passed": true,
      "assertions": 35
    },
    {
      "name": "tool-schema-refs",
      "passed": true,
      "assertions": 63
    },
    {
      "name": "tool-schema-ref-output",
      "passed": true,
      "assertions": 50
    },
    {
      "name": "tool-schema-ref-dialects",
      "passed": true,
      "assertions": 12
    },
    {
      "name": "gateway-request",
      "passed": true,
      "assertions": 37
    },
    {
      "name": "gateway-numeric",
      "passed": true,
      "assertions": 212
    },
    {
      "name": "gateway-tool-selection",
      "passed": true,
      "assertions": 58
    },
    {
      "name": "gateway-prompt",
      "passed": true,
      "assertions": 23
    },
    {
      "name": "gateway-tool-results",
      "passed": true,
      "assertions": 28
    },
    {
      "name": "gateway-v4-images",
      "passed": true,
      "assertions": 15
    },
    {
      "name": "gateway-catalog",
      "passed": true,
      "assertions": 28
    },
    {
      "name": "gateway-events",
      "passed": true,
      "assertions": 19
    },
    {
      "name": "chat-splice",
      "passed": true,
      "assertions": 20
    },
    {
      "name": "gateway-null-bridge",
      "passed": true,
      "assertions": 10
    },
    {
      "name": "gateway-anyof-types",
      "passed": true,
      "assertions": 53
    },
    {
      "name": "openai-conversation",
      "passed": true,
      "assertions": 56
    },
    {
      "name": "openai-tool-output",
      "passed": true,
      "assertions": 487
    },
    {
      "name": "prefill-progress",
      "passed": true,
      "assertions": 5
    },
    {
      "name": "openai-context-budget",
      "passed": true,
      "assertions": 19
    },
    {
      "name": "responses-request",
      "passed": true,
      "assertions": 71
    },
    {
      "name": "responses-events",
      "passed": true,
      "assertions": 54
    },
    {
      "name": "responses-replay",
      "passed": true,
      "assertions": 42
    },
    {
      "name": "responses-pending-turn",
      "passed": true,
      "assertions": 63
    },
    {
      "name": "responses-codex-tools",
      "passed": true,
      "assertions": 13
    },
    {
      "name": "responses-codex-fixture",
      "passed": true,
      "assertions": 15
    },
    {
      "name": "anthropic-request",
      "passed": true,
      "assertions": 87
    },
    {
      "name": "anthropic-logical-turns",
      "passed": true,
      "assertions": 285
    },
    {
      "name": "anthropic-events",
      "passed": true,
      "assertions": 40
    },
    {
      "name": "think-split-stream",
      "passed": true,
      "assertions": 4
    },
    {
      "name": "serving-edges",
      "passed": true,
      "assertions": 12
    },
    {
      "name": "launch-plans",
      "passed": true,
      "assertions": 156
    },
    {
      "name": "launch-server",
      "passed": true,
      "assertions": 107
    },
    {
      "name": "weightstore-cancellable",
      "passed": true,
      "assertions": 9
    }
  ]
}
````

### bounded-reference-brain-gates.log

Original bytes: 151; SHA-256: `1d1eaeed96f0bf440d028a8a6647f4a26d0d22ac0eea74a8dbeb3497374dbcd3`.

````text
0 issue(s): 0 error(s), 0 warning(s), 0 info
MEASUREMENTS.md is current
PLAN.md is current
claims gate: 349 needle checks, 0 failures
BRAIN GATES PASS
````
