---
type: run
id: 01m2gf5wm7xxfpxcbsn6br0h1r
created: 2026-09-14T17:24:31.495834+00:00
updated: 2026-09-14T17:24:32.016488+00:00
summary: Engine static regressions pass after native Mac integration; no release or native UI qualification claim
binary: c965c9ebfc10082baf106178a6dc0a7027991e4a25dcd43171e4a4f6e3097e85
captured_at: 2026-09-14
command: SLOTSTREAM_TEST_BINARY=apps/macos/.build/release/slotstream Tools/static_gates.sh; resume from Tools/brain_gates.sh after new receipt metadata correction
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra Mac integration static regressions
tool: Tools/static_gates.sh
---
# Existing engine regression gates after Mac integration

```json
{
  "binary_sha256": "c965c9ebfc10082baf106178a6dc0a7027991e4a25dcd43171e4a4f6e3097e85",
  "logs_sha256": {
    "sevra-static-gates.log": "3634f7fc7325626a2f124dd1ea00ddf201c9e0f5b8807263b783fe5736d0d442",
    "sevra-static-remaining.log": "a183a48d6824f9b213f288d30979b241bf96fecf404127001b31198b0c7fc0f7"
  },
  "result": "All static stages passed across the two invocations. The two historical engine-brain log warnings remain; no clean-brain warning claim is made. No large model was loaded by this suite.",
  "sequence": "The initial static invocation passed the preceding suites and stopped at missing required metadata in the two newly authored Sevra receipts. Metadata was registered without changing raw output. The remaining script, starting at Tools/brain_gates.sh, then passed. Later documentation-only additions separately passed the claims, generation and shell-syntax checks."
}
```

## sevra-static-gates.log

```text
........................
----------------------------------------------------------------------
Ran 24 tests in 16.972s

OK
..........
----------------------------------------------------------------------
Ran 10 tests in 6.992s

OK
................
----------------------------------------------------------------------
Ran 16 tests in 6.029s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 8.930s

OK
.......
----------------------------------------------------------------------
Ran 7 tests in 4.030s

OK
.........
----------------------------------------------------------------------
Ran 9 tests in 8.087s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.816s

OK
............................
----------------------------------------------------------------------
Ran 28 tests in 36.943s

OK
coverage ratchet checks pass
..{"phase": "starting", "prompt_tokens": 16, "reclaimable_gb": 20.0}
{"prompt_tokens": 16, "passed": false, "error": "ValueError: capacity rung was incomplete, aborted or over its plan"}
.......
----------------------------------------------------------------------
Ran 9 tests in 0.027s

OK
...
----------------------------------------------------------------------
Ran 3 tests in 3.082s

OK
.....
----------------------------------------------------------------------
Ran 5 tests in 0.497s

OK
.....{"phase": "waiting for build reservation", "seconds": 0.0}
.
----------------------------------------------------------------------
Ran 6 tests in 0.005s

OK
..............
----------------------------------------------------------------------
Ran 14 tests in 1.291s

OK
....
----------------------------------------------------------------------
Ran 4 tests in 0.000s

OK
........
----------------------------------------------------------------------
Ran 8 tests in 0.002s

OK
..................................................
----------------------------------------------------------------------
Ran 50 tests in 0.015s

OK
......
----------------------------------------------------------------------
Ran 6 tests in 0.019s

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
Ran 30 tests in 2.261s

OK
...........
----------------------------------------------------------------------
Ran 11 tests in 0.078s

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
Ran 13 tests in 1.121s

OK
..........{"starting": "native/combined-plain"}
{"starting": "native/combined-mtp"}
{"starting": "native/read-failure-serving"}
{"starting": "paired/short-one"}
.
----------------------------------------------------------------------
Ran 11 tests in 0.082s

OK
llms-full.txt is current
warning LOG_UNKNOWN_KIND log.md:124 — log entry kind `change` is not recognized
    hint: use one of: ingest, create, update, delete, rename, link, validate, index-rebuild, contradiction
warning LOG_OUT_OF_ORDER log.md:883 — log entry is older than the entry above it (possible rewrite)
    hint: append corrective entries; never reorder past ones
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-real-workspace-brief-complete.md:1 [binary] — required field `binary` is absent or empty
    hint: set `binary` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-real-workspace-brief-complete.md:1 [captured_at] — required field `captured_at` is absent or empty
    hint: set `captured_at` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-real-workspace-brief-complete.md:1 [command] — required field `command` is absent or empty
    hint: set `command` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-real-workspace-brief-complete.md:1 [machines] — required field `machines` is absent or empty
    hint: set `machines` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-real-workspace-brief-complete.md:1 [title] — required field `title` is absent or empty
    hint: set `title` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-real-workspace-brief-complete.md:1 [tool] — required field `tool` is absent or empty
    hint: set `tool` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-runtime-recovery-and-bundle.md:1 [binary] — required field `binary` is absent or empty
    hint: set `binary` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-runtime-recovery-and-bundle.md:1 [captured_at] — required field `captured_at` is absent or empty
    hint: set `captured_at` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-runtime-recovery-and-bundle.md:1 [command] — required field `command` is absent or empty
    hint: set `command` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-runtime-recovery-and-bundle.md:1 [machines] — required field `machines` is absent or empty
    hint: set `machines` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-runtime-recovery-and-bundle.md:1 [title] — required field `title` is absent or empty
    hint: set `title` to a non-empty value
error SCHEMA_MISSING_REQUIRED sources/runs/2026/09/2026-09-14-sevra-runtime-recovery-and-bundle.md:1 [tool] — required field `tool` is absent or empty
    hint: set `tool` to a non-empty value
14 issue(s): 12 error(s), 2 warning(s), 0 info
dbmd: validation found 12 errors

```

## sevra-static-remaining.log

```text
warning LOG_UNKNOWN_KIND log.md:124 — log entry kind `change` is not recognized
    hint: use one of: ingest, create, update, delete, rename, link, validate, index-rebuild, contradiction
warning LOG_OUT_OF_ORDER log.md:883 — log entry is older than the entry above it (possible rewrite)
    hint: append corrective entries; never reorder past ones
2 issue(s): 0 error(s), 2 warning(s), 0 info
MEASUREMENTS.md is current
PLAN.md is current
claims gate: 216 needle checks, 0 failures
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
PASS  monotonic duration is nonnegative
PASS  footprint sampler includes endpoints
PASS  automatic platform-qualified optimization defaults
PASS  qualified platform keeps the complete joint candidate
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
      "lifetime_rss_peak_bytes": 12992512,
      "phase": "baseline",
      "physical_footprint_bytes": 4244056,
      "reported_peak_bytes": 12976128,
      "sampled_peak_bytes": 4244056
    },
    {
      "lifetime_rss_peak_bytes": 16433152,
      "phase": "transient_128_mib",
      "physical_footprint_bytes": 200295072,
      "reported_peak_bytes": 200295072,
      "sampled_peak_bytes": 200295072
    },
    {
      "lifetime_rss_peak_bytes": 16433152,
      "phase": "transient_freed",
      "physical_footprint_bytes": 66077344,
      "reported_peak_bytes": 200295072,
      "sampled_peak_bytes": 200295072
    },
    {
      "lifetime_rss_peak_bytes": 16449536,
      "phase": "persistent_64_mib",
      "physical_footprint_bytes": 133202592,
      "reported_peak_bytes": 200295072,
      "sampled_peak_bytes": 200295072
    },
    {
      "lifetime_rss_peak_bytes": 16465920,
      "phase": "persistent_plus_transient",
      "physical_footprint_bytes": 267436704,
      "reported_peak_bytes": 267436704,
      "sampled_peak_bytes": 267436704
    },
    {
      "lifetime_rss_peak_bytes": 16465920,
      "phase": "persistent_after_transient_freed",
      "physical_footprint_bytes": 133218976,
      "reported_peak_bytes": 267436704,
      "sampled_peak_bytes": 267436704
    },
    {
      "lifetime_rss_peak_bytes": 16465920,
      "phase": "all_gpu_buffers_freed",
      "physical_footprint_bytes": 66110112,
      "reported_peak_bytes": 267436704,
      "sampled_peak_bytes": 267436704
    },
    {
      "lifetime_rss_peak_bytes": 24870912,
      "phase": "cpu_allocation_after_gpu_peak",
      "physical_footprint_bytes": 74515104,
      "reported_peak_bytes": 267436704,
      "sampled_peak_bytes": 267436704
    },
    {
      "lifetime_rss_peak_bytes": 24870912,
      "phase": "after_concurrent_reads",
      "physical_footprint_bytes": 66355896,
      "reported_peak_bytes": 267436704,
      "sampled_peak_bytes": 267436704
    }
  ],
  "passed": true,
  "source_sha256": {
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Tools/process_memory_check.swift": "17c4ee5dfdff19b1bc467ad896047f6cc8c35d27850d1a62b88f39ea59ff704b",
    "Tools/process_memory_gate.py": "4eb64b24a9fe7d25ac6c970da91688751303a5cc7dd6d2fc340486220b3fdb58"
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
.......
----------------------------------------------------------------------
Ran 7 tests in 0.008s

OK
{"bf16_predictions":16711680,"centers":1000000,"roundtrips":60,"malformed_inputs":39583,"pass":true}
MANIFEST CHECKS PASS
{"name": "normal", "pass_": true, "seconds": 0.245, "returncode": 0}
{"name": "cache-miss-reporting", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "redirect", "pass_": true, "seconds": 0.033, "returncode": 0}
{"name": "bad-object-fallback", "pass_": true, "seconds": 0.032, "returncode": 0}
{"name": "missing-object-raw-fallback", "pass_": true, "seconds": 0.034, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.016, "returncode": 1}
{"name": "raw-ignored-range-fails", "pass_": true, "seconds": 0.017, "returncode": 1}
{"name": "optional-absent", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "optional-corrupt-and-unavailable", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "bad-object-fails", "pass_": true, "seconds": 0.014, "returncode": 1}
{"name": "retry-after", "pass_": true, "seconds": 0.034, "returncode": 0}
{"name": "hugging-face-rate-limit", "pass_": true, "seconds": 5.094, "returncode": 0}
{"name": "cancel-during-hugging-face-rate-limit", "pass_": true, "seconds": 0.399, "returncode": 1}
{"name": "transient-retry", "pass_": true, "seconds": 5.169, "returncode": 0}
{"name": "wrong-length-fallback", "pass_": true, "seconds": 11.118, "returncode": 0}
{"name": "short-body-fallback", "pass_": true, "seconds": 35.442, "returncode": 0}
{"name": "content-encoding-fallback", "pass_": true, "seconds": 35.495, "returncode": 0}
{"name": "cancel-preserves-progress", "pass_": true, "seconds": 1.326, "returncode": 1}
{"name": "damaged-resumed-chunk-rejected", "pass_": true, "seconds": 0.024, "returncode": 1}
{"name": "damaged-resumed-chunk-repair", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "resume", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "already-installed", "pass_": true, "seconds": 0.015, "returncode": 0}
{"name": "valid-symlinks-reused", "pass_": true, "seconds": 0.013, "returncode": 0}
{"name": "corruption-seed", "pass_": true, "seconds": 0.029, "returncode": 0}
{"name": "same-size-final-repair", "pass_": true, "seconds": 0.02, "returncode": 0}
{"name": "invalid-resume-map", "pass_": true, "seconds": 0.03, "returncode": 0}
{"name": "forged-complete-map-without-parts", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "oversized-map-is-discarded", "pass_": true, "seconds": 0.028, "returncode": 0}
{"name": "part-symlink-rejected", "pass_": true, "seconds": 0.006, "returncode": 1}
{"name": "part-hardlink-rejected", "pass_": true, "seconds": 0.006, "returncode": 1}
{"name": "part-fifo-rejected", "pass_": true, "seconds": 0.005, "returncode": 1}
{"name": "concurrent-writer-rejected", "pass_": true, "seconds": 0.006, "returncode": 1}
ALL HTTP CHECKS PASS
{"name": "raw-multichunk", "pass_": true, "seconds": 0.724, "returncode": 0}
{"name": "raw-installed-no-http", "pass_": true, "seconds": 0.27, "returncode": 0}
{"name": "raw-source-fallback-missing", "pass_": true, "seconds": 0.36, "returncode": 0}
{"name": "raw-source-fallback-wrong-range", "pass_": true, "seconds": 0.356, "returncode": 0}
{"name": "raw-source-fallback-encoding", "pass_": true, "seconds": 40.871, "returncode": 0}
{"name": "raw-source-fallback-ignore-range", "pass_": true, "seconds": 0.369, "returncode": 0}
{"name": "raw-wrong-range-fails", "pass_": true, "seconds": 0.028, "returncode": 1}
{"name": "raw-corrupt-final-rejected", "pass_": true, "seconds": 0.182, "returncode": 1}
{"name": "raw-optional-inflight-writers", "pass_": true, "seconds": 0.225, "returncode": 0}
{"name": "raw-cancel", "pass_": true, "seconds": 3.322, "returncode": 1}
{"name": "raw-resume", "pass_": true, "seconds": 0.35, "returncode": 0}
{"name": "raw-same-size-repair", "pass_": true, "seconds": 0.491, "returncode": 0}
ALL RAW HTTP CHECKS PASS
SUSTAINED MEMORY PASS 296632320 bytes peak RSS
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
PASS  MTP auto stays off on a 16GB machine
PASS  MTP auto on at --memory-gb 30 (137/layer after the charge)
PASS  MTP auto on at --memory-gb 22 (above the 76/layer floor after the charge)
PASS  decode lookahead rides the head at --memory-gb 22
PASS  32 GB Mac: auto runs the head and the lookahead
PASS  24 GB Mac: auto runs neither
PASS  32 GB Mac at 65,536 tokens runs without the head
PASS  36 GB Mac at 65,536 tokens keeps the head and the lookahead
PASS  MTP auto off at --memory-gb 16 (below the 76/layer floor)
PASS  SLOTSTREAM_OPT_EXPERT_PREFETCH=0 keeps the head without the lookahead
PASS  decode lookahead charge visible in json
PASS  --mtp on forces the head onto a small machine
PASS  a head forced below the floor runs without the lookahead
PASS  --mtp off suppresses it everywhere
PASS  --mtp on without mtp.safetensors is a clean error
PASS  --mtp on cannot squeeze under the minimum target
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
PASS  32 GB Mac: automatic window is 32,768 (65,536 drops the head)
PASS  36 GB Mac: automatic window is 65,536
PASS  48 GB Mac: automatic window is 65,536
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
planner: passed 90, failed 0
{
  "passed": true,
  "model_loaded": false,
  "hardware_qualified": false,
  "binary_sha256": "c965c9ebfc10082baf106178a6dc0a7027991e4a25dcd43171e4a4f6e3097e85",
  "cases": 304,
  "failures": []
}

######################################################################## 100.0%

######################################################################## 100.0%

######################################################################## 100.0%
INSTALLER GATES PASS
STATIC GATES PASS

```
