---
type: run
id: 01m2rehshzks4ekppch8vg839g
created: 2026-09-17T19:47:28.446780+00:00
updated: 2026-09-17T20:18:44.385870+00:00
summary: Check catalogue, static gates and verify battery on the final verify-pass build
binary: 8d86f10f5b6696d444769308c07d678447b80a531476b48fb70a50988102dbc6
captured_at: 2026-09-17
command: .build/release/slotstream-checks --tier t0 --tier t1; Tools/static_gates.sh; Tools/verify.sh
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Check catalogue, static gates and verify battery on the final verify-pass build
tool: slotstream-checks, Tools/static_gates.sh and Tools/verify.sh
---
The check catalogue, the static gates and the verification battery on the final verify-pass build, binary 8d86f10f5b6696d444769308c07d678447b80a531476b48fb70a50988102dbc6, 2026-09-17. The catalogue and the battery run the frozen copy in `.build/frozen-verify-pass-8d86f10f`, whose binary, Metal library and source archive match its `build-identity.json`.

## Check catalogue, T0 and T1 (12:53)

Every check in both tiers, including the new `verify-pass-rows` and the verify-pass assertions inside `runtime-check` (the 6,144-key default, the five-row promise of the exact mode, which controls select which mode, and which passes each mode engages for).

```text
== catalogue t0+t1 on dce7210cef63999c (slotstream-checks of build 8d86f10f) 12:53:24 load { 3.51 3.81 3.33 }
PASS  prefill-schedule (22 assertions)
PASS  context-policy (8 assertions)
PASS  automatic-context-window (82 assertions)
PASS  configurable-context (5127 assertions)
PASS  optimization-exact-read (14 assertions)
PASS  optimization-packed-layout (288 assertions)
PASS  optimization-ngram-prefetch-ticket (28 assertions)
PASS  optimization-cache-bookkeeping (20571 assertions)
PASS  optimization-adaptive-policy (75 assertions)
PASS  optimization-runtime-budget (561 assertions)
PASS  optimization-layer-local-victim (226 assertions)
PASS  optimization-pressure-boundary (74 assertions)
PASS  runtime-check (171 assertions)
PASS  optimization-prefix-client-capacity (61 assertions)
PASS  persistent-prefix-policy (98 assertions)
PASS  governor-check (26 assertions)
PASS  pull-check (14 assertions)
PASS  machine-planning (15 assertions)
PASS  http-framing (11 assertions)
PASS  http-routing (23 assertions)
PASS  optimization-bounded-output (38 assertions)
PASS  expert-lookahead-lane-budget (16 assertions)
PASS  expert-lookahead-tickets (61 assertions)
PASS  expert-lookahead-scheduler (26 assertions)
PASS  expert-lookahead-forecast-merge (37 assertions)
PASS  expert-lookahead-forecast-tap (71 assertions)
PASS  decode-lookahead-defaults (39 assertions)
PASS  vision-check (136 assertions)
PASS  sampler-behaviour (647 assertions)
PASS  expert-lookahead-adoption (10 assertions)
PASS  expert-lookahead-routing-readback (14 assertions)
PASS  optimization-compact-indexer (84 assertions)
PASS  persistent-prefix-round-trip (84 assertions)
PASS  optimization-slot-slices (196 assertions)
PASS  optimization-slot-words (436 assertions)
PASS  vision-splice (12 assertions)
PASS  optimization-vision-attention (60 assertions)
PASS  optimization-router-selection (43 assertions)
PASS  optimization-compiled-norm (49 assertions)
PASS  optimization-router-projection (30 assertions)
PASS  verify-pass-rows (45 assertions)
PASS  optimization-indexer-block-selection (163 assertions)
PASS  optimization-indexer-visibility (262 assertions)
PASS  toolcall-check (19 assertions)
PASS  toolcall-stream-check (14 assertions)
PASS  toolcall-coercion (23 assertions)
PASS  gateway-request (37 assertions)
PASS  gateway-prompt (23 assertions)
PASS  gateway-catalog (28 assertions)
PASS  gateway-events (19 assertions)
PASS  chat-splice (10 assertions)
PASS  gateway-null-bridge (10 assertions)
PASS  gateway-anyof-types (13 assertions)
PASS  openai-conversation (40 assertions)
PASS  openai-tool-output (163 assertions)
PASS  openai-context-budget (19 assertions)
PASS  responses-request (71 assertions)
PASS  responses-events (54 assertions)
PASS  responses-codex-tools (13 assertions)
PASS  responses-codex-fixture (15 assertions)
PASS  weightstore-cancellable (9 assertions)

61 passed, 0 failed, 0 skipped (30634 assertions)
catalogue-exit 0
```

## Static gates (12:21 to 12:30)

`Tools/static_gates.sh`: the weights-free suites, the brain gates (`dbmd validate --all`, the MEASUREMENTS.md and PLAN.md projections, the claims gate over 249 needles), `llms-full.txt`, the parity fixture hashes, `runtime-check`, the process memory gate, `pull-check`, the slotpack checks, the planner gates, the memory override gate and the installer gates. Tail of the output; the whole log is in the artifact.

```text
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
INSTALLER GATES PASS
STATIC GATES PASS
```

## Verification battery (14:15 to 14:39)

`Tools/verify.sh` with `SLOTSTREAM_TEST_BINARY` pointing at the frozen build, so the battery verified that copy's identity instead of rebuilding: weights provenance over all 105.3 GB, the Python-reference goldens, the planner and sampler gates, streaming and elastic-pool equality, the governor drill, the prefix and sweep controls, the draft-head parity and the speculative gates including the new `mtp-rowcheck`, the memory-target promises, the long-prompt recall with the sparse indexer active, `context-check`, serving robustness, behavioural sanity, the symlinked model directory, vision parity and the vision serving suite. Every check passed: 247 PASS lines, no FAIL and no SKIP, and the battery's own tally of its gated checks reads 26 passed, 0 failed.

Two notes on how it ran. The quiet runner treated another session's shell as a busy machine at 14:24 and signalled the step to stop, but its signal reached only the wrapper: the battery itself ran on to completion, which is why its output continues past that line. A retry started at 14:39 on the same binary and was stopped by hand once this run was seen to have finished; its partial output is in the log after this block, and an earlier attempt at 13:57 failed instantly because a previous run's output directory already existed (`out.mkdir(exist_ok=False)`), not because a check failed.

```text
== verify battery (attempt 1) 14:15:43 reclaimable 33.4 GB target 21 GB load { 1.34 2.24 2.86 } total = 7168.00M  used = 5996.00M  free = 1172.00M  (encrypted)
== frozen build: /Users/carlos/Projects/slotstream/.build/frozen-verify-pass-8d86f10f/slotstream ==
== weights provenance (hashes all 105.3 GB vs the pinned revisions; the draft head is optional) ==
PASS  pull --verify: every pinned file matches
== goldens (need bench/parity31 from Tools/parity_ref.py under mlx==0.31.1) ==
PASS  ngram row ids == python reference
PASS  chat template == transformers
PASS  layer parity (0-1 bit-exact gate)
== planner: right thing across machine setups (simulated, no model needed) ==
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
PASS  planner gates
== sampler vs numpy reference + elastic governor policy (no weights needed) ==
PASS  sampler == numpy reference: defaults (t0.8 p0.95 k40)
PASS  sampler == numpy reference: greedy (temperature 0)
PASS  sampler == numpy reference: pure sampling, no filters
PASS  sampler == numpy reference: top-k 1 (degenerate)
PASS  sampler == numpy reference: tight nucleus (top-p 0.1)
PASS  sampler == numpy reference: min-p 0.3
PASS  sampler == numpy reference: presence penalty, accumulating
PASS  sampler == numpy reference: greedy + penalty (API temp-0)
PASS  sampler == numpy reference: vocab 4096
PASS  sampler == numpy reference: real vocab (248,320)
PASS  sampler == numpy reference: top-p 0 (sanitizer)
PASS  sampler == numpy reference: min-p 5 (sanitizer)
PASS  sampler == numpy reference: seed 0 (remapped)
PASS  sampler == numpy reference: exact zero RNG draw skips removed tokens
PASS  sampler == numpy reference: high temp, large vocab
PASS  seeded sampling is reproducible and seed-sensitive
PASS  elastic governor policy (26 branches)
sampler + governor: passed 17, failed 0
PASS  sampler + governor gates
== golden equivalence: streaming must not change the math ==
PASS  8.1 GB cache output == 10 GB cache output
== elastic pool: live resizes must not change the math ==
PASS  grow/shrink/regrow byte-identical (elastic-check)
== elastic governor: shrinks, honors the cooldown, grows back ==
PASS  ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical
== conversation prefix cache: bounded, flat with depth, deterministic ==
PASS  prefix reuse within the prefill-rechunk control (prefix-check)
== prefill sweep: matches the pool path, deterministic, blind to the pool ==
PASS  sweep within the prefill-rechunk control, identical cold and warm (sweep-check)
== MTP draft head: parity with the Python reference + speculative gates ==
PASS  mtp head bit-parity vs Python reference (mtp-parity)
#### yielded verify battery at 14:24:07 to: 30448 /bin/zsh -c source /Users/carlos/.claude/shell-snapshots/snapshot-zsh-1789; discarded, will retry
PASS  speculative decode gates (determinism, state integrity, accept sanity)
PASS  verify pass rows equal plain decode bit for bit (mtp-rowcheck)
== memory target keeps its promise ==
PASS  --memory-gb 10 process footprint and RSS stay under target
PASS  --memory-gb 10 output is stable
PASS  --memory-gb 10 process footprint and RSS under target on the long prompt
PASS  long-context answer still correct (sparse indexer active)
PASS  context-check: 2k rung reads inside the plan and reports it
PASS  context-check: process memory remains under target
== serving robustness (inputs that used to crash or corrupt output) ==
== behavioural sanity: has the conversion lost anything obvious? ==
== factual recall ==
PASS  capital of France
PASS  author of Hamlet
PASS  symbol for gold
PASS  continent count
== arithmetic and reasoning ==
PASS  17x23
PASS  elapsed time
PASS  multi-step arithmetic
PASS  sorting
PASS  decimal comparison
== instruction following ==
PASS  exact-word obedience
PASS  list format
PASS  yes/no obedience
== language and code ==
PASS  translation
PASS  python one-liner
PASS  cloze completion

quality probe: passed 15, failed 0
PASS  behavioural quality probe (15 items)
== weights behind a symlink (Foundation will not list a symlinked dir) ==
PASS  run through a symlinked model dir
PASS  non-loopback browser origin is refused
PASS  loopback browser origin is allowed exactly
PASS  wrong model is rejected instead of silently relabeled
PASS  unsupported Ollama tools are rejected explicitly
PASS  unsupported OpenAI response_format is rejected explicitly
PASS  numeric stream is not mistaken for a JSON boolean
PASS  wrongly typed sampling options are rejected
PASS  numbers that overflow the sampler are rejected
PASS  unsupported message semantics are not silently dropped
PASS  OpenAI max_tokens 0 cannot become an unbounded generation
PASS  seed -1 (Ollama's random default) does not kill the server
PASS  num_predict -1 (until EOS) generates instead of trapping
PASS  client disconnecting mid-stream does not kill the server (SIGPIPE)
PASS  streamed deltas reassemble to the non-streamed text (10 cases)
PASS  out-of-range "top_p":0 falls back sanely (got 'OK')
PASS  out-of-range "top_p":-1 falls back sanely (got 'OK')
PASS  out-of-range "min_p":1.5 falls back sanely (got 'OK')
PASS  empty prompt is the load request: acknowledged, never answered from an uninitialized tensor
PASS  OpenAI array-form content is read, not dropped
PASS  stop sequence honored (got '1 2 3')
PASS  over-length prompt is refused with a typed 400, not a silent stall
PASS  /api/version (0.2.20) matches the binary
PASS  /api/tags size matches the pinned manifest
PASS  /api/show accepts the Ollama CLI request shape and advertises capabilities
PASS  /api/show accepts the deprecated name alias
PASS  /api/show refuses a non-empty system override instead of ignoring it
PASS  /api/show still rejects unknown fields
PASS  /api/chat accepts keep_alive and null options (the CLI's defaults)
PASS  /api/generate accepts the Ollama CLI one-shot shape (empty suffix/system/template)
PASS  /api/generate refuses a non-empty suffix instead of ignoring it
PASS  /api/generate with an empty prompt is the Ollama load request, acknowledged
PASS  /api/chat with no messages is the Ollama load request, acknowledged
PASS  HEAD returns no body
PASS  malformed JSON returns 400
PASS  metadata endpoints answer during a generation, and the accept loop keeps accepting
PASS  /api/show accepts an empty model with the name in the alias (ollama show)
PASS  an untagged model name resolves to the only model
PASS  a semantic Ollama knob (num_ctx) is still refused, never silently dropped
PASS  /v1 treats "max_tokens":null as unset
PASS  /v1 treats "stop":null as unset
PASS  /v1 treats "temperature":null as unset
PASS  /v1 treats "seed":null as unset
PASS  /v1 treats "stream_options":null as unset
PASS  /v1 accepts the no-op default "n":1
PASS  /v1 accepts the no-op default "frequency_penalty":0
PASS  /v1 accepts the no-op default "user":"u1"
PASS  /v1 accepts the no-op default "logprobs":false
PASS  /v1 accepts the no-op default "logit_bias":{}
PASS  /v1 accepts the no-op default "tools":[]
PASS  /v1 accepts the no-op default "response_format":{"type":"text"}
PASS  /v1 still refuses the real feature "n":2
PASS  /v1 still refuses the real feature "frequency_penalty":0.5
PASS  /v1 still refuses the real feature "logprobs":true
PASS  /v1 still refuses the real feature "tools":[{"type":"function"}]
PASS  /v1 still refuses the real feature "response_format":{"type":"json_object"}
PASS  think:true splits reasoning into message.thinking and leaves the answer clean
16 content deltas for 16 tokens
PASS  a short reply arrives as per-token deltas, not one batched chunk
PASS  unseeded requests vary, as the API documents
PASS  an explicit seed still reproduces exactly
PASS  a query string does not 404 the route
PASS  HEAD on a real path is 200
PASS  HEAD on an unknown path is 404, not a blanket 200
PASS  a chunked body is refused with 411, not read as empty
PASS  an oversized body gets 413, not a bare connection reset
PASS  a malformed Content-Length gets 400
PASS  a file:// image is refused and says URLs are not fetched
PASS  an https:// image is refused on the OpenAI route too
PASS  a non-string images array is a 400, not a silently text-only answer
PASS  an image part with no url is a 400
PASS  bytes that are not an image are a 400 with the reason
PASS  raw generate refuses images instead of dropping them
PASS  /v1/models carries created
PASS  the first SSE delta announces the role
PASS  server still up after every probe

robustness: passed 74, failed 0
PASS  serving robustness suite
== vision ==
PASS  vision tower dumps its pixels and embeddings
  swift        vs mlx  f32:  cosine 0.99870270  worst token 0.919064
  swift        vs mlx  bf16:  cosine 0.99878263  worst token 0.950250
  mlx bf16     vs numpy f32:  cosine 0.99840382  worst token 0.839186
  mlx f32      vs numpy f32:  cosine 0.99996241  worst token 0.997329
  float32 implementations agree      True
  slotstream inside the dtype band   True
  slotstream matches bf16 reference  True
VISION PARITY PASS
PASS  vision tower matches the float32 reference within the bf16 band
PASS  ollama /api/chat answers an image request
PASS  and it recognises the dog
      -> 'Dog nose close-up' in 8.6s, 725 prompt tokens
PASS  the picture is worth its 702 placeholder tokens, plus the two sentinels
PASS  /v1/chat/completions answers an image_url part
PASS  and it sees the fruit on the tree
      -> 'Green citrus fruits'
PASS  /api/generate answers an image request
PASS  and it recognises the dog there too
PASS  the fx gateway accepts an image file part
PASS  and answers about the dog
PASS  and still refuses a file part that is not an image
PASS  two pictures in one turn are accepted
PASS  and they arrive in the order they were sent
      -> 'dog, pomelo'
PASS  a follow-up turn on the same picture succeeds
PASS  and reuses the state instead of re-running the tower
      -> first 8.3s, follow-up 1.8s
PASS  the same words with a different picture get a different answer
PASS  duplicate images preserve the visible subject
PASS  duplicate image work is counted
PASS  same-geometry seed acknowledges the image
PASS  changed image would extend the cached token IDs
PASS  same-geometry changed content misses and re-encodes
PASS  same-geometry changed image is blue
PASS  a file:// image is a 400
PASS  that says URLs are not fetched
PASS  bytes that are not an image are a 400
PASS  a truncated image is a 400, not a blank description

25 passed, 0 failed
VISION SERVING PASS
PASS  vision serving suite

passed 26, failed 0
```

## The build under test and the tree

The frozen build 8d86f10f5b6696d4 is the source tree as it stood at 11:57 local. The tree's last build, 8ea3c360959fd20c at 14:05, differs from it by one comment in `Sources/Slotstream/Layers.swift` and nothing else; the diff of the two source archives is in the artifact (`logs/source-diff-8d86f10f-to-8ea3c360959fd20c.diff`). `runtime-check` (171 assertions) and `verify-pass-rows` (45) pass on that later build too. An intermediate build, 7a58174783256625 at 11:20, ran the row-equality gate and the 16k decode comparison; it differs from 8d86f10f by a behaviour-preserving refactor of the mode selection and the new T0 assertions (`logs/source-diff-7a58174-to-8d86f10f.diff`).

`Tools/static_gates.sh` was then re-run once more on the tree after the
documentation reflow, with no model process of ours running: 44 measured
checks, zero failures, the slotpack and raw-HTTP suites and the auto-sizing
cases included, ending in `STATIC GATES PASS` and exit 0.
