---
type: "run"
title: "Complete existing-engine acceptance after quantization foundations"
tool: "native checks and bounded research tools"
command: "SLOTSTREAM_BUILD_JOBS=2 SLOTSTREAM_VERIFY_OUT=.build/quantization-research/full-verification bash Tools/verify.sh"
binary: "SHA-256 014e8b64dca500745cb00032dcc8fee13fdcbf1715f016d0cf467743f1535043"
machines: "[[records/machines/macbook-pro-m5-pro-48gb]]"
captured_at: "2026-10-02"
discarded: false
created: "2026-10-02T22:18:41.922011+00:00"
updated: "2026-10-02T22:18:41.922011+00:00"
summary: "Complete existing-engine acceptance after quantization foundations; scope and limitations below."
---

This full acceptance run tested the existing affine engine implementation from commit `4879921`, before the subsequent fused VQ prototype was built. It completed with 35 gates passed and none failed, including the full vision-serving suite. The historical MLX 0.31 draft reference remained a diagnostic difference; the required current-backend reference passed. These are correctness, lifecycle and memory gates, not a new performance qualification. The later isolated context harness fix in `9be9637` was separately checked and CI passed. No VQ model pack ran here.

Only local home prefixes are replaced with `<HOME>` in the following text. Each original byte count and digest is preserved. No model weights or binary arrays are copied into this record.

### full-verification.log

Original bytes: 20744; SHA-256: `de80ef3cf1ed4d8651d8a4a65b6f8442fe8a7ea7f8be8de74bcf2c622a71bcb9`.

````text
== build ==
== weights provenance (hashes all 105.3 GB vs the pinned revisions; the draft head is optional) ==
PASS  pull --verify: every pinned file matches
== goldens (need bench/parity31 from Tools/parity_ref.py under mlx==0.31.1) ==
PASS  ngram row ids == python reference
PASS  chat template == transformers
PASS  layer parity (historical reference, one-row projections)
PASS  independent current-backend layer reference
PASS  production layer parity against current backend
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
PASS  elastic governor policy (38 branches)
sampler + governor: passed 17, failed 0
PASS  sampler + governor gates
== golden equivalence: streaming must not change the math ==
PASS  8.1 GB cache output == 10 GB cache output
== elastic pool: live resizes must not change the math ==
PASS  grow/shrink/regrow byte-identical (elastic-check)
== elastic governor: shrinks, honors the cooldown, grows back ==
PASS  ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical
== small adaptive cache: pressure recovery below the normal growth band ==
PASS  small adaptive cache recovery
== adaptive server: saved ceiling survives startup and the live timer ==
{
  "passed": true,
  "binary_sha256": "014e8b64dca500745cb00032dcc8fee13fdcbf1715f016d0cf467743f1535043",
  "limit_gb": 10,
  "no_elastic": false,
  "preflight_available_gb": 22.656630784,
  "command": [
    "slotstream",
    "serve",
    "--memory-limit-gb",
    "10",
    "--max-context",
    "32768",
    "--max-prefill-wait",
    "17",
    "--mtp",
    "off",
    "--vision",
    "off",
    "--port",
    "60119"
  ],
  "completion": {
    "message": {
      "content": "The Nile.",
      "role": "assistant"
    },
    "index": 0,
    "finish_reason": "stop"
  },
  "server_reaped": true
}
PASS  adaptive server lifecycle
== conversation prefix cache: live determinism and exact scheduled reuse ==
PASS  prefix reuse, invalidation and live reply equality (prefix-check)
PASS  a continued conversation equals a cold one (prefix-exact-check)
== prefill sweep: matches the pool path, deterministic, blind to the pool ==
PASS  sweep within the prefill-rechunk control, identical cold and warm (sweep-check)
== decode overlap: direct demand reads and the GPU keepalive leave output exact ==
PASS  direct reads and keepalive equal the staged path on a cold cache (decode-overlap-check)
PASS  streamed draft experts and the plain-decode lookahead leave output exact (draft-stream-check)
== MTP draft head: parity with the Python reference + speculative gates ==
PASS  independent current-backend draft-head reference
PASS  mtp head parity vs current Python reference (mtp-parity)
DIAGNOSTIC  historical MLX 0.31 draft-head reference differs (retained in mtp-legacy-reference.txt)
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
{"name": "plain-cap", "finish": "length", "usage": {"prompt_tokens": 36, "total_tokens": 164, "prompt_tokens_details": {"cached_tokens": 0}, "completion_tokens": 128}, "data_events": 130}
{"name": "tools-unused-cap", "finish": "length", "usage": {"prompt_tokens": 275, "completion_tokens": 128, "prompt_tokens_details": {"cached_tokens": 0}, "total_tokens": 403}, "data_events": 130}
{"name": "large-allowance-unused-tools", "finish": "stop", "usage": {"prompt_tokens": 269, "total_tokens": 270, "prompt_tokens_details": {"cached_tokens": 0}, "completion_tokens": 1}, "data_events": 3}
{"name": "long-truncated-argument", "finish": "length", "usage": {"prompt_tokens": 289, "completion_tokens": 256, "prompt_tokens_details": {"cached_tokens": 0}, "total_tokens": 545}, "data_events": 242}
{"name": "nullable-truncated-argument", "finish": "length", "usage": {"prompt_tokens": 292, "total_tokens": 548, "prompt_tokens_details": {"cached_tokens": 0}, "completion_tokens": 256}, "data_events": 242}
{"name": "branch-alpha-seed", "finish": "stop", "usage": {"prompt_tokens": 1526, "completion_tokens": 49, "prompt_tokens_details": {"cached_tokens": 0}, "total_tokens": 1575}, "data_events": 49}
{"name": "branch-beta-seed", "finish": "stop", "usage": {"prompt_tokens": 1976, "completion_tokens": 54, "prompt_tokens_details": {"cached_tokens": 768}, "total_tokens": 2030}, "data_events": 54}
{"name": "branch-alpha-followup", "finish": "stop", "usage": {"prompt_tokens": 1597, "total_tokens": 1621, "prompt_tokens_details": {"cached_tokens": 1280}, "completion_tokens": 24}, "data_events": 24}
{"name": "cache-turn-1", "finish": "stop", "usage": {"prompt_tokens": 1029, "completion_tokens": 29, "total_tokens": 1058, "prompt_tokens_details": {"cached_tokens": 0}}, "data_events": 29}
{"name": "cache-turn-2", "finish": "stop", "usage": {"prompt_tokens": 1603, "total_tokens": 1632, "prompt_tokens_details": {"cached_tokens": 1024}, "completion_tokens": 29}, "data_events": 29}
{"name": "cache-turn-3", "finish": "stop", "usage": {"prompt_tokens": 1654, "completion_tokens": 29, "total_tokens": 1683, "prompt_tokens_details": {"cached_tokens": 1536}}, "data_events": 29}
PASS stream reset leaves the server able to complete another request
PASS issue 21 streaming, length termination, three-turn reasoning reuse and server survival
PASS runtime context discovery agrees
PASS nonstream returns executable OpenAI function
PASS nonstream preserves function and typed arguments
PASS nonstream includes call identity and usage
PASS nonstream completes tool-result round trip
PASS stream returns executable OpenAI function
PASS stream preserves function and typed arguments
PASS stream includes call identity and usage
PASS stream completes tool-result round trip
PASS parallel false returns one complete call
PASS parallel stream has distinct complete calls
PASS parallel results match by call ID
PASS tool choice none remains text-only
PASS multiple initial instructions survive rendering
PASS reasoning separated from answer
PASS orphan-result rejected before inference
PASS missing-result rejected before inference
PASS context-inflation rejected before inference
PASS reasoning-conflict rejected before inference
PASS unknown-function rejected before inference
PASS unsupported structured output has actionable rejection
PASS budget exhaustion reports length False
PASS budget exhaustion reports length True
PASS request context limit is enforced before inference
{"passed": 24, "context": 32768, "model": "qwen3.8-flash-next:4bit"}
server reaped 66871 0
PASS exact conversation replay after restart {'prompt_tokens': 1654, 'total_tokens': 1683, 'prompt_tokens_details': {'cached_tokens': 1536}, 'completion_tokens': 29}
server reaped 69350 0
PASS  issue 21 streaming, branched reuse and exact restart
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
PASS  /api/version (0.2.27) matches the binary
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
  swift        vs mlx  f32:  cosine 0.99846047  worst token 0.905454
  swift        vs mlx  bf16:  cosine 0.99866360  worst token 0.921946
  mlx bf16     vs numpy f32:  cosine 0.99840382  worst token 0.839186
  mlx f32      vs numpy f32:  cosine 0.99996241  worst token 0.997329
  float32 implementations agree      True
  slotstream inside the dtype band   True
  slotstream matches bf16 reference  True
VISION PARITY PASS
PASS  vision tower matches the float32 reference within the bf16 band
PASS  ollama /api/chat answers an image request
PASS  and it recognises the dog
      -> 'Dog nose close-up.' in 10.6s, 725 prompt tokens
PASS  the picture is worth its 702 placeholder tokens, plus the two sentinels
PASS  /v1/chat/completions answers an image_url part
PASS  and it sees the fruit on the tree
      -> 'Green citrus fruit'
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
      -> first 19.9s, follow-up 4.5s
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

passed 35, failed 0

````

### full-verification/build-identity.json

Original bytes: 27107; SHA-256: `e41a2729ed0c7458c22e9899c6f754936e860bb802c81d289d34d59b16ef8ea1`.

````text
{
  "source": {
    "Makefile": "692cb361f9920d914aa394e6be98a05517e25df25556d5aa2f8da1976ee7874a",
    "Package.resolved": "dfafdad45c4d8c76e978e80f44c74b623d9ba224f94b7feb8c123515c07efcb1",
    "Package.swift": "ba6b728ad4071166eb54f698c96a1332418dbc94994330f98b18ffb04226ec67",
    "Sources/CSlotpack/include/slotpack.h": "07301354bebebac253975abbd5981006be411fed444abab0b6bbc857e28bdd1b",
    "Sources/CSlotpack/slotpack.c": "be45d2daf3e7e95d66cb9178f40dab292b85b1998086d71c53e41f59596d57a2",
    "Sources/Slotstream/AdaptiveSpeculation.swift": "da8062ff16c1d72ccd28852ba18e43cd434a8165483d045759cd29a499f5fff6",
    "Sources/Slotstream/AnthropicDialect.swift": "8741e81474a54f97d0527b43766f9265509d396d2f4ed4aa9869b42943c9d433",
    "Sources/Slotstream/BlockSelection.swift": "16e5fb4a4ea82728e3caaf3d6f4cdbf7d91614b757b0624913ae14c052d6f27d",
    "Sources/Slotstream/BoundedOutput.swift": "727c83b664e681539093f3c3a9c65c9ac58893e4a40bb26ac38948ac837486fc",
    "Sources/Slotstream/CPUSlotWrite.swift": "da137aec8944dab6590cbea17afff28f094aef876688d20782b5791028d83349",
    "Sources/Slotstream/CacheBookkeeping.swift": "54aed1fa8d1fee047b1e0d90d0ced2a80e215eba2e12d09ba7a0c1c45ff54916",
    "Sources/Slotstream/Checkpoint.swift": "1d978203cdceea932a94e83b0967adf01e0c80bee4c70e0f818ca34cd235fe2d",
    "Sources/Slotstream/CodingToolLaunch.swift": "5576d72a4a60fbe84b968f247e74eb77074f2c18e11077ccf33497bd8012c4e9",
    "Sources/Slotstream/CompiledArithmetic.swift": "98611b31035459d237d901be7fff175072c30b32b992c7534d770b1bc6d117f2",
    "Sources/Slotstream/Context.swift": "fc4cd04f6041348d4567d1ab50c7c9cfcefbdf6db16dfcdb8cc8b7d3f2044348",
    "Sources/Slotstream/ContextFeasibility.swift": "5e7d185542e5ef173683afd5e6999c7ec76c36bfa8e6d3356ec40d1b695edcfe",
    "Sources/Slotstream/ContextMemory.swift": "31da5a698303ec9898747052996996eeec2ac46d40b7c011791ea7b00e6bd23b",
    "Sources/Slotstream/ContextWindowPolicy.swift": "73b2321aae6a2c22fc7173467136770dbf45a1eca4a185293491472680a13a24",
    "Sources/Slotstream/DecodeLookahead+Configuration.swift": "82f8ebe02a37b882ea00c7b625008597bcfddf5df819df2592451d600ee0a9bd",
    "Sources/Slotstream/DecodeLookahead.swift": "9cf0cb2d1ac342c85279764e39fe12dc169c24ffb5e85c42a66828271dbad2e0",
    "Sources/Slotstream/DownloadConcurrency.swift": "cf872e6e99b9e1df121a9feba4c0c8420719fe62a5f5a50e58b26bf11cb8126e",
    "Sources/Slotstream/DownloadHTTP.swift": "341a7a7157c575658ee7d7bc6c77ed593bf30f79d8c262906d7672e2e40c6cbc",
    "Sources/Slotstream/EmbeddingRows.swift": "10c722abb55b03bd6ae0f8188ec156f97e2a7603a516bd91919e060d8fc5a645",
    "Sources/Slotstream/Engine.swift": "24ca04e99cf4195e59bc08692b6bf62393872161c52f8b5eb1913c6282c9fb32",
    "Sources/Slotstream/Errors.swift": "3eaf858cc73980a2ca1e728478c302b8704de3ab95294029aa924ac632a21e0b",
    "Sources/Slotstream/ExactRead.swift": "bd90fbeb1d400cb7dda746d434a5c4f1fbb4d767506013e4398de9ba1253a47e",
    "Sources/Slotstream/ExpertLookaheadTrace.swift": "a867f9e10cb854ceb455f48528602758d5671e10e5921ab6a45fb94c23f662c1",
    "Sources/Slotstream/ExpertPredictor.swift": "2f25044ff7258ac53973c3e5de7138ad078b0b90a1ab13cc332cab8bcfa0740e",
    "Sources/Slotstream/ExpertPrefetch.swift": "46fb601813d05b788a3648139cbde2b88c94714a5e15f99456e4b2e7072f4b6a",
    "Sources/Slotstream/ExpertStore.swift": "4dae1ae2ff59f671ad4b6e0dbc6405fb198d2dc523ec9f2d9e00c9b2dfce7bcc",
    "Sources/Slotstream/ExpertTransferProfile.swift": "17fe476f01b03d3a151506d324d9ad0d83d8dcf152489c9e88805ddea2b302ad",
    "Sources/Slotstream/FusedPrefillAttention.swift": "a1464f0c495c72626969ce78c8ffc1646171d91acc894eb7cf2f7212f2c20a86",
    "Sources/Slotstream/GDNPhaseProfile.swift": "f74d843773b549530cebe9e5df79a02b0104068e05c39ff6adfcbae3effaef66",
    "Sources/Slotstream/GPUKeepAlive.swift": "9f8c0e9a8201b46a58069971b421f6a664edd72eded5597c715f10b574307fc1",
    "Sources/Slotstream/GatewayDialect.swift": "1e805ed8ef4a0005be5ab343e11485f7df80f60859b1473568a0316a02e0f6d6",
    "Sources/Slotstream/GatewayOutput.swift": "dc682c686859450a2ca4815d3f8de833752763360e45f5b0d08531ffa418293f",
    "Sources/Slotstream/Generate.swift": "792159f8e9f11d1c98373c08e066b79908192d142d25a9f8bf2a6fbb22b48c82",
    "Sources/Slotstream/GenerationPhase.swift": "1fd6b1d3b5a41c8626ec87b00a988ae85271c92853ce6a7f01e9af46fc5ea7e3",
    "Sources/Slotstream/Governor.swift": "707f5b3e100a8f50d4bc9e3698607e813dabaf2f014116182e8c5e014a340954",
    "Sources/Slotstream/LayerLocalVictim.swift": "9615385e6c2ac18573f4d2089a75a70d356d803c0c4a603b4db3397fafa6275c",
    "Sources/Slotstream/Layers.swift": "3d84885d4452d14845271fc6deb2d9146d1b0d00ae78ab3fbcf98528e95560c9",
    "Sources/Slotstream/MTP.swift": "973fded18e26361262bb635a3e9dbfa1b8e3f8281dfda8682904638096c8fca2",
    "Sources/Slotstream/MTPExpertStream.swift": "391b13fed457ba61a7cb4e107472a699ba87adc9a57cfd14580faa2dfbe50fd7",
    "Sources/Slotstream/Machine.swift": "34bffbaad9bd1a80f8d8aacc6b1abbbfa2d616690546a2a709363c4fb44033f6",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "1048ad7bcd1c9f93f5316465ed38d7bd93046fe4bfbd0fc138d972e646ee12ab",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/OpenAIDialect.swift": "1b73944ffa18ad19980711d016508e20654a93cf59803afb2d8217faee39bddd",
    "Sources/Slotstream/OpenAIOutput.swift": "7bc6c7a0bdccef3ea566643aa051a95855df5f6d30a7053db398b3a77fb22a59",
    "Sources/Slotstream/OptimizationPlatform.swift": "faabf07d19c1dc6247e885ff426ade08a4252aa7f9594e234ac15653838d667e",
    "Sources/Slotstream/Optimizations.swift": "04154a27824a3f451276eae38587f327e339b979f82af56c76dfc3f65f7807ea",
    "Sources/Slotstream/PackedExpertLayout.swift": "c74e9867e2c37ba92d84bf7ce90253eea6db6f8531a6d6b8792874d4810cc6ee",
    "Sources/Slotstream/PackedProjectionPair.swift": "84fa87130270092c16a538f7d50cfee55e71b52ecd8250a1bce7e0547c8b1d96",
    "Sources/Slotstream/PartialRotation.swift": "57177495e6ba630c66744b2b9e2bde23acf9349fca52b97a4ea406c5839c7f8f",
    "Sources/Slotstream/PersistentPrefixCache.swift": "32f9a37ab3b3d95a7c8c61e8471007545040fd363468484d69c03114d6b3843d",
    "Sources/Slotstream/PersistentPrefixConversation.swift": "e8b60b48c117448165ab8c2e37aae67347b4d84c6983be6b5832f3da9330b654",
    "Sources/Slotstream/PersistentPrefixFormat.swift": "d03795ee46252fe5df904591289af41a69811f2a211f437764d3f80ddb0d20ad",
    "Sources/Slotstream/PersistentPrefixGenerator.swift": "f34dfd0ad9ee401e6a7498ccc9df50e136513d958dfa084a8d640dd452f16c8f",
    "Sources/Slotstream/PersistentPrefixPolicy.swift": "978e48761103215b432d07dd3e7eb88c46e66f0be9d9ff704d1f0416844496b3",
    "Sources/Slotstream/PersistentPrefixRestore.swift": "d15ad3092be190ee6c9650adacf1f84d684abab2220b2aa5663ddb789b4b27bf",
    "Sources/Slotstream/PersistentPrefixSave.swift": "7291f3bde43fbf51ac6b1eef27875c321a8d5e7a2106a6286ca6b83f82f95a36",
    "Sources/Slotstream/PinnedModel.swift": "0c7c16539bcb54924ff7306b03b470e2915b5bb41c4ecff9e60dc7912e7afdd2",
    "Sources/Slotstream/PinnedTransport.swift": "f30c4c4bfeaf49c5e2dfcbfa728d6eab44d02a1f77d40217e84723fd03761d87",
    "Sources/Slotstream/PinnedTransportManifest.swift": "6b0de220938fc91dd4dc24cd0fc9dffa086f09f04cd83823dc3de3a13de8ac11",
    "Sources/Slotstream/Plan.swift": "240766430e77e186107a2b3eea844b8876bb509f92e2fbcfcea9d989e1a37b54",
    "Sources/Slotstream/PlannerCostModel.swift": "6be8eadea4c22ebc7e639e3a0b4437f0dd278dc78a582a35a8ee8af99e53e7b1",
    "Sources/Slotstream/PlannerDevice.swift": "528cdf93cf0fe600b8c53a3eb828b9b1922ee4817fa100393a11d4e2714784f8",
    "Sources/Slotstream/PrefillReadPolicy.swift": "ec6fa9372390ba9812ba62f09f3ff91755f2e9d20d9d5ef9d587eb42b6f2b341",
    "Sources/Slotstream/PrefixCache.swift": "18698bac7cf6632c07c70396cd44c152cbc16d29a7a8174599fbe57f34713f67",
    "Sources/Slotstream/PressureBoundary.swift": "ed22537fccc321589eb3d33b3538984630daae951d00e4ac829412897b181a3d",
    "Sources/Slotstream/ProcessMemory.swift": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5",
    "Sources/Slotstream/QuantizationLayout.swift": "310e2ae54e9990e4519b5f036d00cb61a35f7091eaa3ac683083f2ec843290e7",
    "Sources/Slotstream/RequestControl.swift": "56c5e664aaf33454f5ef45efedb3849ee539fd91e844d58885bf304f5aab3c1d",
    "Sources/Slotstream/ResidentExpertOverlap.swift": "4ddb3a027d92697dcc1e7373e66fc139abdc12063448d864ef635e5202f57dde",
    "Sources/Slotstream/ResponsesDialect.swift": "7462a141d9c8e1baffa21dc46b31760ba0443dbd2db95f776b63960ac094d411",
    "Sources/Slotstream/RouterProjection.swift": "880d9ee9a46eeb2cdae2560c5d4def671f3fe98e56f04cc036cb3e775d20baed",
    "Sources/Slotstream/RouterSelection.swift": "35b122748ab05c00122bfb5b4c78416ee28b55abaa4d4e1379fd163aaf47b4a6",
    "Sources/Slotstream/RouterTapCorrection.swift": "2bd9e634d1022b840c2a74ca690196e84cea89ea263e6c3499e6a7c63e704652",
    "Sources/Slotstream/RouterTrace.swift": "b34c1974f60015c913649a285023e57b15d92f37c2f7aa282b821eb2043652c1",
    "Sources/Slotstream/RoutingReadbackQueue.swift": "477ad597e6e741cb939c9ade983934814e2a7c6b8e7c59fc659a1dc02eb4b4ab",
    "Sources/Slotstream/SelectedAttention.swift": "70e61a089444f74cc74494d7f05005b0ff4dfe67043782befbbef80d96b911db",
    "Sources/Slotstream/Server.swift": "8566a2a7734ae19f07aa3b4216b2c219687b52819b3ac86a2f79533d31ad03a5",
    "Sources/Slotstream/ServerActivity.swift": "c0194df615bcb815d188255823fd30d3373bee6d166fc7a13ccb2a5278b5875b",
    "Sources/Slotstream/SlotWritePlan.swift": "9abde1de815522ff835d3c685a2e342293f3c9c7019cfc742265193ea2e286c1",
    "Sources/Slotstream/SlotpackDownload.swift": "fb6f47ce70f30713cf1679ebda619c980e9d783dd6ae4cd1cc4e0a68b14705b7",
    "Sources/Slotstream/SlotpackManifest.swift": "8664440e22653e64b85c0100345169dd93b3836d1bbd125ac2add4f621b9876d",
    "Sources/Slotstream/StatePrefixFork.swift": "35ed6954bc927e37c117d53eb25e007b83b3385099bc9b18e01607f30abb7df7",
    "Sources/Slotstream/StateRecovery.swift": "078521e0e08233c06706408bb6dbc53f902285fc4c891af2e164386bd41bf98b",
    "Sources/Slotstream/TapCorrectionSidecar.swift": "581d7438fd01ce576691f5b322464337e85f03cca2911a6c8631f32484e72d82",
    "Sources/Slotstream/ToolCallSplitter.swift": "28fbe792a074f8ec374bca592595d239dcac63aa8081836d085fd501c7d20626",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
    "Sources/Slotstream/VerifyPassSelfCheck.swift": "4355a74e73b967e6331dc2d780aa506ccccc6655df253a593cd24a3276325ded",
    "Sources/Slotstream/Version.swift": "d68b6b9f343402041c33452b885eebce140773cc26379b4adaae996640427b40",
    "Sources/Slotstream/Vision.swift": "639b5c4bbe05654db411d587f31e7962d3db857aa4be38a2b54f982199d51eb5",
    "Sources/Slotstream/VisionAttention.swift": "e8564b8cd946a6b049b3702a91f4441f18a7c3c51f19fae7f31c3cfa92522d25",
    "Sources/Slotstream/VisionPrompt.swift": "561ecd55588533a21571eea4deaa820b7e906b9d228ee002d6bfa9918dfd45a9",
    "Sources/Slotstream/WeightDownload.swift": "869b1ff398417f5aeebd57cb938feaf6829196f67a4ef1d254bb7bf138675673",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "350c3eef0d1dc5d5f721cb90e4c91df82e74937a1584ec6a635025c46175b00f",
    "Sources/Slotstream/WordSlotWrite.swift": "1c19def2346669acc1afa811a7244233c6f593de91c02bfc4ff145465b95187e",
    "Sources/SlotstreamDiagnostics/CheckReport.swift": "9bbe2106b5b55331cc3fbc093edd803eff6f9f00ebd5f30ce587754fe0bc7e47",
    "Sources/SlotstreamDiagnostics/Diagnostics+AdaptiveSpeculation.swift": "e53d32c4f5a3fc7039a258db5c5b3c530416d07828c5d424a8f35e67d80dc256",
    "Sources/SlotstreamDiagnostics/Diagnostics+AlignedResume.swift": "0f4f448f2d7d3438f5504ced42949607f9a2855ceb69b98aaab0e8eacea11b43",
    "Sources/SlotstreamDiagnostics/Diagnostics+AllHitReplay.swift": "187a98c70c2e66008622db3727f0bf58126928862bc102782574fa0ba5f57513",
    "Sources/SlotstreamDiagnostics/Diagnostics+BlockSelection.swift": "08d3f1fc29b6353443b795198295bacb85f57d0a2bdbac67450cf66d505f852c",
    "Sources/SlotstreamDiagnostics/Diagnostics+CacheBookkeeping.swift": "4e5cc7615562ab4321bc221e92dd861d7bd57ec5329f7e16773e8243ab5c3380",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompactIndexer.swift": "3dd65c8fac32f2804cce942845946debe74ca83b9cf6485a441ed15331711a5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompiledNorm.swift": "9f1beb774172bc33a27020261532e06723f0794adba9ab5dbca7807d01a0748f",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompletePrompt.swift": "2810f4873be52bc4b72e084a756bc5b58e7d9cff0248a7779a3ee1cb19b89aa4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ComputeIslands.swift": "ac7f3b5ed140a566348e9be06274cf757144d2db099fe5af097c4a3807dc6801",
    "Sources/SlotstreamDiagnostics/Diagnostics+Context.swift": "6f37df30a9437c56cf10324e89e7f9b4b8b4b0df9b201fdf30fd495828c466ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift": "19afe7d5f2a5c413c669f5f32725d2b4ab140fe1ea7a32d0c6c8b21d8737a6ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift": "90b83306d1966da794daf28cc84f426a42cd853075f5e236cf1bacae10787d8f",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeLookahead.swift": "cbfd71ebc272c439f31cbd70cc03c59de7001f864d0f5f8bf27ac9c0d8877b35",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeOverlap.swift": "7653c5f5e48eedd2e1f07b9073ed2a182a7ac2f4cd0adebdf270c800a04313fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+DraftStream.swift": "16e46c6c40782200520de773b06f2466b3e142bf8b38935d5576021f047048f8",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRows.swift": "a0f0532a43c1329b3a69f8a3bd8607df9f27793c0994ad23203936896b44e81f",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRuntime.swift": "c5c37fafb45b2ac2434a36cd7c8b8804fac0e271e9e3f0fb10ef97481db77e24",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExactRead.swift": "77a357f55c3f5aced5ba0d74012e35f73e678e0840024f24a5ab86909d335c59",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift": "b423d7acfd1c8f8895d542031f3965af9d0b592c745f2e1fd3671285ea117b11",
    "Sources/SlotstreamDiagnostics/Diagnostics+FusedPrefill.swift": "e252d52ac1f86f39aa77d3cf4f5f4d1476143467f8b226eaa6e5505966402177",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProfile.swift": "6d982a575d6c6282941a9f9f3ac063b75d31996fcde387a63ca3ce44fea93242",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProjection.swift": "983a071e562451dbc22cfe09b005d9c68af687c10e7d94802d7d3cb28af1c7cd",
    "Sources/SlotstreamDiagnostics/Diagnostics+GenerationPhase.swift": "b1937b268bc5c830ac3370c776719f753d2001111b99868d82b5a1b946fb2ab7",
    "Sources/SlotstreamDiagnostics/Diagnostics+Governor.swift": "6e6386ef8131c8742279e08d9ea71e04f42d10173a8a5f8084a78ac8742ee768",
    "Sources/SlotstreamDiagnostics/Diagnostics+HTTP.swift": "1c1e713b274de6c7021d1a59fa10fec5d7b647433c1e18cd25ccaaa1960f2b4f",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageFailure.swift": "766742295107f924177f7f724a7be61f8ccb29b3e044a7de345523598c31cead",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageReuse.swift": "5d0e619769c0f7d4ea8c73439ac44bc499db6184c4954b417f4cb7804aec20e8",
    "Sources/SlotstreamDiagnostics/Diagnostics+Integrated.swift": "42f78edbc4592de08e11e7fdade5f5b01c51a25a6d503c321f544515a4c8e141",
    "Sources/SlotstreamDiagnostics/Diagnostics+LayerLocalVictim.swift": "d512d93741a6675412cc9e6c739b940132ca3f20ebecd709884b00b1ebbc49b7",
    "Sources/SlotstreamDiagnostics/Diagnostics+MTPIndexer.swift": "7784a18a1eddafa25ecaee9eeacfbcddf8bcabac8d53919f80367a4f4e5be476",
    "Sources/SlotstreamDiagnostics/Diagnostics+Machine.swift": "20f6edb816fc3a794143042e59847adbfc1fe06514fc990e8a3d81eb87abe50c",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramCache.swift": "9bee4eb6c6cf09df5673e177d4b7f006681794bf680366b4549e4fa3d38b7368",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramLookahead.swift": "3b0bc7ea21a57d2ce65e58773879f5f86ba7f0f37c47d8f1d08d51e61c486370",
    "Sources/SlotstreamDiagnostics/Diagnostics+Optimization.swift": "cb188627bde827821bfeebf061c85586c55d8e6b569d9bb329de9585d39bb216",
    "Sources/SlotstreamDiagnostics/Diagnostics+Output.swift": "e39951dc83e8410abdc840d0a739e1e1b2fbbdf1e2d06b3cb2d28c39ee9329cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+OutputServing.swift": "25b469da9856405dd6421d6754d7caaeae378fc5e77ae1637a2552a139a810f7",
    "Sources/SlotstreamDiagnostics/Diagnostics+PackedLayout.swift": "14c31f94ebdd8bbbbb1479c77d0649b4c0632d978e4d8a60a8048214a1e08e65",
    "Sources/SlotstreamDiagnostics/Diagnostics+PartialRotation.swift": "de75d07feedc163834fe8e716683af8b2d373c51b0588ccc2cac922f775367ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentConversation.swift": "579f41ecd3610bb996adcab74ef70811d6563384aceae676011d3babefa7638a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefix.swift": "6ff041e28462df708b5ab84159223bd3a31c8c422e4a3c70110397386531954a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixModel.swift": "3e06c67777ce3572d9bd7cce5d220be5f41af90e31b6f5da349ba6f3ec667798",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixPolicy.swift": "dcd983900b4439d6d945d9b37e87a65a312497993db8062d9435c0dfcf1667f0",
    "Sources/SlotstreamDiagnostics/Diagnostics+PoolRequests.swift": "627e5c7d56ee8a0206cc16d1355b2dfeb956e6fbc7880c193c239e11fa9be7b2",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillOpportunities.swift": "f1790a8d1ea348ac483aeff385a468d03038ba64666cab7d1bbe9493b107805c",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillQualification.swift": "3641584e0ec8fb0b2f58abf027e83b293820250f880571a2d3f984bd3effb76f",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixCapacity.swift": "d42d50be6fa6a1415cf58cee63872f926b4129d8b687fd9db3c4a6db9a99cb5c",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixFork.swift": "e7a7094b3930cef8e380d711f20e8f82e2821c070579549692a6120e9ba3afc4",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixRetention.swift": "5de9452266e8e59da03b078990689554fc7a419a5cd8e5879cc68e2e277ea8cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixVision.swift": "5e4737dbe5344492fc2f9c6881f8d56e997668f674c91b28b9349c9420465f72",
    "Sources/SlotstreamDiagnostics/Diagnostics+PressureBoundary.swift": "4b4157ef099e54ce4dff34f1bdc4c610df9356b4c48ac41f2c0fcc9b5ea93876",
    "Sources/SlotstreamDiagnostics/Diagnostics+PromptSpeed.swift": "ac50212dc0af91f64337fa6aa911294157d32b94e711ca135acbed33c1e46f0e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Pull.swift": "224e4bf5210afbddd992894860343add73d1f52b12b2d9a00abf78fdc492ada0",
    "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "58514bba13fe3102ede121a15d27e330c4912aa644bca263e35542c9b9786ce5",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationBench.swift": "099cc2fedc981247e470938c3cab5623fd82dc1caaeddb3a7b84c3948111033f",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationFixtures.swift": "04de1a4d8699af8421bc2caddd1ce6d4810384d04ce440a68d3de06f2abee2f0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift": "1532f45714ceb98a5adcfa31abd31f065493164f49d2ee3aac868d5d4080b04c",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift": "9e98b6e0fd6c30f36d1d3ec8d556216f351a2f09ee5d15dbb4f5580858fad4b4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadRecovery.swift": "a7e21ea833e6063325f03e88309d1b78690d913a778721e8fb003f08c967567a",
    "Sources/SlotstreamDiagnostics/Diagnostics+ResidentOverlap.swift": "c1e7b847cffa51939b0ae20027b289efcae5585a94ae5c1c751a66f110a25522",
    "Sources/SlotstreamDiagnostics/Diagnostics+RopePerformance.swift": "19d040f21391a1ea87831b73a8adf055a78aeafe9d902bd11ce22fd6a492d892",
    "Sources/SlotstreamDiagnostics/Diagnostics+RouterProjection.swift": "3981e415003e6258d41690216a7ab668652a0ce436bf644d99d88dbc2799db9e",
    "Sources/SlotstreamDiagnostics/Diagnostics+RoutingReadback.swift": "f29aad2cde3bbb526f83dcec4565f3c382d071734acc47a0e31d7223312713cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+Runtime.swift": "b4e5c445d839a58667b60e7d523a6ce9882df3f939cbe310f62a5303afb2b1cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+RuntimeBudget.swift": "b18979a76cb2112a2beb8fd3196c1d26e36c2626c2a8de732b6b4fc134be61c9",
    "Sources/SlotstreamDiagnostics/Diagnostics+SamplerPerformance.swift": "4e6dd7e85d7ac0f2b2af291343ab4cdc52fa94fe6edb588c1d517008a0c35cb3",
    "Sources/SlotstreamDiagnostics/Diagnostics+SelectedAttention.swift": "8dd385da9b79c3625d1cc9ccc6c8821978f88437fcded918f049328b7a969e7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Selection.swift": "b737794c5a57cd224f36a93b960fa9834cabb51ef810945bab64fd71e59c91d0",
    "Sources/SlotstreamDiagnostics/Diagnostics+SharedPrefix.swift": "63b48ea779e7364e168fffbc874525279e32b6b3976d072a9eba83db0fb85409",
    "Sources/SlotstreamDiagnostics/Diagnostics+SlotSlices.swift": "32c10a839423b13a4dceff67a5b2a617f90d145376a70b19bd27f2e62452e288",
    "Sources/SlotstreamDiagnostics/Diagnostics+StateRecovery.swift": "a53db99ff0f97a26e87586e35bf05daa26b9281fe7d686a1670c14984da2dd77",
    "Sources/SlotstreamDiagnostics/Diagnostics+TerminalPrefill.swift": "7ef27bec8489f52ccdd3ea51c125d21eb94512924b163e854b7aaf25ef39f57a",
    "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "7779c1339db28cce006d300d6bdd41e3e9a27c55314153aa12659c3e11d575b3",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/AnthropicChecks.swift": "a15f7854d8f2da41184d30fac17f94f1e6e1cb68fd4236eb3c63f60e12714648",
    "Sources/SlotstreamTestKit/AnthropicTurnChecks.swift": "4d585e3ddb8692c1668d065a99c6ff1a56109f6da33328600f646bdc16f43aa5",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/CodexFixture.swift": "23839d1d776252c1c5cec6a3acaf6c08c1e89bc7def714f7b5f3180fae57aac0",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "a9e798d056582f4d97554b9131b3f8c7220a37a314312bb3c0e590883c7c8ad4",
    "Sources/SlotstreamTestKit/LaunchChecks.swift": "8fd6f5920b219d68f0ea69295810a0a6b34effdee69ac855b04212399379e54d",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "cb813af4c908567161db660aa8c6b78710be6a2b80a97a6e6d90e995ecd8806f",
    "Sources/SlotstreamTestKit/PersistentPrefixChecks.swift": "2a5cc8ffaf4befb90a732f350f84c34f162ad7ca67b0fb50eae3060fdeb0b0b3",
    "Sources/SlotstreamTestKit/PersistentPrefixIOChecks.swift": "c16d39aaf50f66ffa0f4f5fef02937dd141d5ba2ad7f42bcc9f387416d503f2c",
    "Sources/SlotstreamTestKit/PersistentPrefixMetadataChecks.swift": "65b5a45b3954c98517b777039373030f309e0271a6343037c6a452b4e03a82e8",
    "Sources/SlotstreamTestKit/PersistentPrefixRemovalChecks.swift": "a910392fe22933480cba14e3c604933066ba9178b670db4442e8c53b1c79a459",
    "Sources/SlotstreamTestKit/ResponsesChecks.swift": "6f692f86a68f6bbd1f62b6bdc544fdebaba1196e902b58a59313755af68be130",
    "Sources/SlotstreamTestKit/T0Checks.swift": "0cc6543c5f9210c500373aa8c316b2634ae5612f2336f158a2629355eb699321",
    "Sources/SlotstreamTestKit/ToolCallChecks.swift": "272df6215d16cf55f2e2b1b4ec28e0ef338292a4b856c643810ae96f19df46c5",
    "Sources/SlotstreamTestKit/WeightStoreChecks.swift": "d26e43367ba2d61d7afd9f5b175e95b714409b1717b86b9fe71f1306e36b6a81",
    "Sources/slotstream-checks/main.swift": "02ebabaf058afa95622ccd29fb65d80b7eac41c9e6232f0167ef288c2126e0d9",
    "Sources/slotstream-cli/CheckRendering.swift": "0905dcbae17a5b3d66e13a760c4054fb29d930331d32942a528510ecfe9769a1",
    "Sources/slotstream-cli/ContextCommands.swift": "3ba24ae3e24dd10214e3288f007952d9e2b06241c081e29313b42ac7aa7a31bb",
    "Sources/slotstream-cli/DecodeOverlapCommands.swift": "8f85603d0608ed2f08a3bc94714902cd9967f82e7ee97a7cb7964e518fbcf1d3",
    "Sources/slotstream-cli/DraftStreamCommands.swift": "4fd131e2303fd4f2c9765fff9b2543011d565dd5c070b8b380910528c9026a33",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift": "249274657b4f4f4c3e694a2b0db671b3af8b92a2148495647f3be9092f48f6b2",
    "Sources/slotstream-cli/LaunchCommand.swift": "a18212935aa5aa2c956593838ef181ccbf0aae2501b7a0071f4b4b44298ea0f9",
    "Sources/slotstream-cli/MTPCommands.swift": "04d06d66f29339b4d88dfbae7be18ef873c32c09320536ee7916e7d621816e08",
    "Sources/slotstream-cli/OptimizationCommands.swift": "c309616492d2347ddee38842a18f92c35283bd8ba2fac8c2e131d79858e73c19",
    "Sources/slotstream-cli/PackedExpertCommands.swift": "ea7f4485d60a985a0a1f759f077d28dc42f36512dc1dd07a7644a22e31346b12",
    "Sources/slotstream-cli/PrefixCacheCommand.swift": "6941b38c78ab2975350f33f852b7eec7b780e082f6817fcf70814181bff38f6f",
    "Sources/slotstream-cli/PrefixExactCommands.swift": "b70f0a6f2536f0eb1fc00007260cc6dffe2592b1f32271225fe1304261346e28",
    "Sources/slotstream-cli/Pull.swift": "ca9f9e90ef959b194653945e29ebd3b9f1932ef3e46dfceaa7b09562fa2c9d7b",
    "Sources/slotstream-cli/QuantizationCommands.swift": "ee000384d5f11da35e0d928181cc9e4e3240a2d079c3666039da80b975c0f245",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "7a04d4417d2b5c6e879c75601349364815a2d75fb958f2879878c3e5559d5d49",
    "Tools/build_identity.py": "d70a97380b1244727674861ae64ab166d034c941878e6e2c18f3ffd77bbf2e86",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "91a59aeed2f70fbc0752f7d0edf4a63021a1d1b1b86a0ef39a38a139c86b2810",
  "binary_sha256": "014e8b64dca500745cb00032dcc8fee13fdcbf1715f016d0cf467743f1535043",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}

````

### full-verification/check-1.txt

Original bytes: 87; SHA-256: `47e135e10a066f5ae8612148e92bddbc9ed3b585f467dad9261307f96c311234`.

````text
ngram row ids == python reference
diff /tmp/ssv_ngram.txt bench/parity31/ngram_ids.txt

````

### full-verification/check-10.txt

Original bytes: 802; SHA-256: `b2d4774c5462b3653b5c49d8c08bb07e696b30d894098b01857458194ac70b92`.

````text
sweep within the prefill-rechunk control, identical cold and warm (sweep-check)
run_binary sweep-check
engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  sweep on a cold pool, run twice: identical
  sweep vs pool path: 3.820% of logit spread (prefill-rechunk control 5.198%, bound 15.593%), top-1 same
  sweep whole vs sweep in 256-token passes: 4.339% of spread
  sweep on the warm pool (636 experts copied out of it): identical to the cold sweep
  after a generate that admitted the prompt's hot experts (prefill 549 tokens): pool path identical, sweep identical
SWEEP CHECK PASS: deterministic; 3.820% of spread vs the pool path inside the 15.593% prefill-rechunk bound; identical on a cold and a warm pool; admission leaves the pool consistent

````

### full-verification/check-11.txt

Original bytes: 210727; SHA-256: `eaf56146fa63b75fd04d30ba27d9274b8006f466d517366ea94fa9ebd63a6c40`.

````text
direct reads and keepalive equal the staged path on a cold cache (decode-overlap-check)
run_binary decode-overlap-check
PASS  decode-overlap: plain: every run succeeds
PASS  decode-overlap: plain: staged run generated every token
PASS  decode-overlap: plain: direct reads leave the ids unchanged
PASS  decode-overlap: plain: the keepalive leaves the ids unchanged
PASS  decode-overlap: plain: the staged run scattered its misses
PASS  decode-overlap: plain: the direct run read its misses in place
PASS  decode-overlap: plain: both runs read the same records
PASS  decode-overlap: speculative: every run succeeds
PASS  decode-overlap: speculative: staged run generated every token
PASS  decode-overlap: speculative: direct reads leave the ids unchanged
PASS  decode-overlap: speculative: the keepalive leaves the ids unchanged
PASS  decode-overlap: speculative: the staged run scattered its misses
PASS  decode-overlap: speculative: the direct run read its misses in place
PASS  decode-overlap: speculative: both runs read the same records
PASS  decode-overlap: speculative: the draft head verified
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: only complete records counted
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=false: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: only complete records counted
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=false, descriptors=true: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: only complete records counted
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=false: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: only complete records counted
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=false, sparse=true, descriptors=true: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: only complete records counted
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=false: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: only complete records counted
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=false, descriptors=true: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: only complete records counted
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=false: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: first-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: first failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: no failed record counted complete
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: no new mapping after failed first batch
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: only the failed batch's victim is unmapped
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: requested hits survive the failure
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: a failed direct batch is not counted
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: original data after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: later-batch failure is returned
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: later failure restores prior pins
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: only complete records counted
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: completed batch mappings retained
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: partial batch mappings absent
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: requested prior hits never evicted
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: every published mapping after failure: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: retry reads only the two uncommitted records
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: retry restores unique requested pin count
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: first duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: last duplicate retains alias
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 8, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 16, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 24, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: successful retry: rows 32, piece 8 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: the retry read directly into its slots
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 0 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 1 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 2 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 3 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 4 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 5 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 6 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 7 exact
PASS  optimization-read-recovery-direct: dense=true, sparse=true, descriptors=true: resize after recovery: rows 0, piece 8 exact
PASS  optimization-read-recovery-direct: runs depth 0: failure returned
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 0
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 1
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 2
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 3
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 4
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 5
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 6
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 7
PASS  optimization-read-recovery-direct: runs depth 0: retries preserve unsorted/duplicate row 8
PASS  optimization-read-recovery-direct: runs depth 1: failure returned
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 0
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 1
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 2
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 3
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 4
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 5
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 6
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 7
PASS  optimization-read-recovery-direct: runs depth 1: retries preserve unsorted/duplicate row 8
PASS  optimization-read-recovery-direct: runs depth 32: failure returned
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 0
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 1
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 2
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 3
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 4
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 5
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 6
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 7
PASS  optimization-read-recovery-direct: runs depth 32: retries preserve unsorted/duplicate row 8
PASS  optimization-read-recovery-direct: runs depth 128: failure returned
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 0
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 1
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 2
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 3
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 4
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 5
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 6
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 7
PASS  optimization-read-recovery-direct: runs depth 128: retries preserve unsorted/duplicate row 8
PASS  optimization-read-recovery-direct: invalid runs -1/[0] rejected
PASS  optimization-read-recovery-direct: invalid runs 48/[0] rejected
PASS  optimization-read-recovery-direct: invalid runs 0/[-1] rejected
PASS  optimization-read-recovery-direct: invalid runs 0/[512] rejected
PASS  optimization-read-recovery-direct: invalid runs 0/[] rejected
PASS  optimization-read-recovery-direct: empty raw batch rejected
PASS  optimization-read-recovery-direct: invalid batch key identified
PASS  optimization-read-recovery-direct: invalid batch key identified
PASS  optimization-read-recovery-direct: invalid batch key identified
PASS  optimization-read-recovery-direct: invalid batch key identified
PASS  optimization-request-read-recovery-direct: pool prefill: reference succeeds
PASS  optimization-request-read-recovery-direct: pool prefill: injected read actually fails
PASS  optimization-request-read-recovery-direct: pool prefill: read error is reported
PASS  optimization-request-read-recovery-direct: pool prefill: error completion
PASS  optimization-request-read-recovery-direct: pool prefill: no provisional output
PASS  optimization-request-read-recovery-direct: pool prefill: no provisional callback
PASS  optimization-request-read-recovery-direct: pool prefill: invalid state is never cached
PASS  optimization-request-read-recovery-direct: pool prefill: all request pins released
PASS  optimization-request-read-recovery-direct: pool prefill: admission reset
PASS  optimization-request-read-recovery-direct: pool prefill: allocator limit restored
PASS  optimization-request-read-recovery-direct: pool prefill: only completed chronological passes counted
PASS  optimization-request-read-recovery-direct: pool prefill: cached prefix really reused
PASS  optimization-request-read-recovery-direct: pool prefill: failure retains physical observations
PASS  optimization-request-read-recovery-direct: pool prefill: failure retains VM interval
PASS  optimization-request-read-recovery-direct: pool prefill: retry succeeds
PASS  optimization-request-read-recovery-direct: pool prefill: retry does a coherent rebuild
PASS  optimization-request-read-recovery-direct: pool prefill: retry has exact reference output
PASS  optimization-request-read-recovery-direct: pool prefill: successful retry can be cached
PASS  optimization-request-read-recovery-direct: ngram prefill: reference succeeds
PASS  optimization-request-read-recovery-direct: ngram prefill: injected read actually fails
PASS  optimization-request-read-recovery-direct: ngram prefill: read error is reported
PASS  optimization-request-read-recovery-direct: ngram prefill: error completion
PASS  optimization-request-read-recovery-direct: ngram prefill: no provisional output
PASS  optimization-request-read-recovery-direct: ngram prefill: no provisional callback
PASS  optimization-request-read-recovery-direct: ngram prefill: invalid state is never cached
PASS  optimization-request-read-recovery-direct: ngram prefill: all request pins released
PASS  optimization-request-read-recovery-direct: ngram prefill: admission reset
PASS  optimization-request-read-recovery-direct: ngram prefill: allocator limit restored
PASS  optimization-request-read-recovery-direct: ngram prefill: only completed chronological passes counted
PASS  optimization-request-read-recovery-direct: ngram prefill: cached prefix really reused
PASS  optimization-request-read-recovery-direct: ngram prefill: failed prefetch publishes no partial row batch
PASS  optimization-request-read-recovery-direct: ngram prefill: failure retains physical observations
PASS  optimization-request-read-recovery-direct: ngram prefill: failure retains VM interval
PASS  optimization-request-read-recovery-direct: ngram prefill: retry succeeds
PASS  optimization-request-read-recovery-direct: ngram prefill: retry does a coherent rebuild
PASS  optimization-request-read-recovery-direct: ngram prefill: retry has exact reference output
PASS  optimization-request-read-recovery-direct: ngram prefill: successful retry can be cached
PASS  optimization-request-read-recovery-direct: sweep prefill: reference succeeds
PASS  optimization-request-read-recovery-direct: sweep prefill: injected read actually fails
PASS  optimization-request-read-recovery-direct: sweep prefill: read error is reported
PASS  optimization-request-read-recovery-direct: sweep prefill: error completion
PASS  optimization-request-read-recovery-direct: sweep prefill: no provisional output
PASS  optimization-request-read-recovery-direct: sweep prefill: no provisional callback
PASS  optimization-request-read-recovery-direct: sweep prefill: invalid state is never cached
PASS  optimization-request-read-recovery-direct: sweep prefill: all request pins released
PASS  optimization-request-read-recovery-direct: sweep prefill: admission reset
PASS  optimization-request-read-recovery-direct: sweep prefill: allocator limit restored
PASS  optimization-request-read-recovery-direct: sweep prefill: only completed chronological passes counted
PASS  optimization-request-read-recovery-direct: sweep prefill: cached prefix really reused
PASS  optimization-request-read-recovery-direct: sweep prefill: failure retains physical observations
PASS  optimization-request-read-recovery-direct: sweep prefill: failure retains VM interval
PASS  optimization-request-read-recovery-direct: sweep prefill: retry succeeds
PASS  optimization-request-read-recovery-direct: sweep prefill: retry does a coherent rebuild
PASS  optimization-request-read-recovery-direct: sweep prefill: retry has exact reference output
PASS  optimization-request-read-recovery-direct: sweep prefill: successful retry can be cached
PASS  optimization-request-read-recovery-direct: cached-prefix append: reference succeeds
PASS  optimization-request-read-recovery-direct: cached-prefix append: seed owns exactly the prompt
PASS  optimization-request-read-recovery-direct: cached-prefix append: injected read actually fails
PASS  optimization-request-read-recovery-direct: cached-prefix append: read error is reported
PASS  optimization-request-read-recovery-direct: cached-prefix append: error completion
PASS  optimization-request-read-recovery-direct: cached-prefix append: no provisional output
PASS  optimization-request-read-recovery-direct: cached-prefix append: no provisional callback
PASS  optimization-request-read-recovery-direct: cached-prefix append: invalid state is never cached
PASS  optimization-request-read-recovery-direct: cached-prefix append: all request pins released
PASS  optimization-request-read-recovery-direct: cached-prefix append: admission reset
PASS  optimization-request-read-recovery-direct: cached-prefix append: allocator limit restored
PASS  optimization-request-read-recovery-direct: cached-prefix append: only completed chronological passes counted
PASS  optimization-request-read-recovery-direct: cached-prefix append: cached prefix really reused
PASS  optimization-request-read-recovery-direct: cached-prefix append: failure retains physical observations
PASS  optimization-request-read-recovery-direct: cached-prefix append: failure retains VM interval
PASS  optimization-request-read-recovery-direct: cached-prefix append: retry succeeds
PASS  optimization-request-read-recovery-direct: cached-prefix append: retry does a coherent rebuild
PASS  optimization-request-read-recovery-direct: cached-prefix append: retry has exact reference output
PASS  optimization-request-read-recovery-direct: cached-prefix append: successful retry can be cached
PASS  optimization-request-read-recovery-direct: second chronological pass: reference succeeds
PASS  optimization-request-read-recovery-direct: second chronological pass: injected read actually fails
PASS  optimization-request-read-recovery-direct: second chronological pass: read error is reported
PASS  optimization-request-read-recovery-direct: second chronological pass: error completion
PASS  optimization-request-read-recovery-direct: second chronological pass: no provisional output
PASS  optimization-request-read-recovery-direct: second chronological pass: no provisional callback
PASS  optimization-request-read-recovery-direct: second chronological pass: invalid state is never cached
PASS  optimization-request-read-recovery-direct: second chronological pass: all request pins released
PASS  optimization-request-read-recovery-direct: second chronological pass: admission reset
PASS  optimization-request-read-recovery-direct: second chronological pass: allocator limit restored
PASS  optimization-request-read-recovery-direct: second chronological pass: only completed chronological passes counted
PASS  optimization-request-read-recovery-direct: second chronological pass: cached prefix really reused
PASS  optimization-request-read-recovery-direct: second chronological pass: failure retains physical observations
PASS  optimization-request-read-recovery-direct: second chronological pass: failure retains VM interval
PASS  optimization-request-read-recovery-direct: second chronological pass: retry succeeds
PASS  optimization-request-read-recovery-direct: second chronological pass: retry does a coherent rebuild
PASS  optimization-request-read-recovery-direct: second chronological pass: retry has exact reference output
PASS  optimization-request-read-recovery-direct: second chronological pass: successful retry can be cached
PASS  optimization-request-read-recovery-direct: read-scope transaction: reference succeeds
PASS  optimization-request-read-recovery-direct: read-scope transaction: injected read actually fails
PASS  optimization-request-read-recovery-direct: read-scope transaction: read error is reported
PASS  optimization-request-read-recovery-direct: read-scope transaction: error completion
PASS  optimization-request-read-recovery-direct: read-scope transaction: no provisional output
PASS  optimization-request-read-recovery-direct: read-scope transaction: no provisional callback
PASS  optimization-request-read-recovery-direct: read-scope transaction: invalid state is never cached
PASS  optimization-request-read-recovery-direct: read-scope transaction: all request pins released
PASS  optimization-request-read-recovery-direct: read-scope transaction: admission reset
PASS  optimization-request-read-recovery-direct: read-scope transaction: allocator limit restored
PASS  optimization-request-read-recovery-direct: read-scope transaction: only completed chronological passes counted
PASS  optimization-request-read-recovery-direct: read-scope transaction: cached prefix really reused
PASS  optimization-request-read-recovery-direct: read-scope transaction: failed scope counted
PASS  optimization-request-read-recovery-direct: read-scope transaction: failure retains physical observations
PASS  optimization-request-read-recovery-direct: read-scope transaction: failure retains VM interval
PASS  optimization-request-read-recovery-direct: read-scope transaction: retry succeeds
PASS  optimization-request-read-recovery-direct: read-scope transaction: retry does a coherent rebuild
PASS  optimization-request-read-recovery-direct: read-scope transaction: retry has exact reference output
PASS  optimization-request-read-recovery-direct: read-scope transaction: successful retry can be cached
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: reference succeeds
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: injected read actually fails
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: read error is reported
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: error completion
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: no provisional output
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: no provisional callback
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: invalid state is never cached
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: all request pins released
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: admission reset
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: allocator limit restored
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: only completed chronological passes counted
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: cached prefix really reused
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: failed scope counted
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: failed prefetch publishes no partial row batch
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: failure retains physical observations
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: failure retains VM interval
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: retry succeeds
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: retry does a coherent rebuild
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: retry has exact reference output
PASS  optimization-request-read-recovery-direct: ngram read-scope transaction: successful retry can be cached
PASS  optimization-request-read-recovery-direct: expert decode: actual read failure
PASS  optimization-request-read-recovery-direct: expert decode: error finish
PASS  optimization-request-read-recovery-direct: expert decode: explicit error
PASS  optimization-request-read-recovery-direct: expert decode: emitted prefix preserved
PASS  optimization-request-read-recovery-direct: expert decode: callbacks equal committed output
PASS  optimization-request-read-recovery-direct: expert decode: no partial state cached
PASS  optimization-request-read-recovery-direct: expert decode: pins released
PASS  optimization-request-read-recovery-direct: expert decode: admission reset
PASS  optimization-request-read-recovery-direct: expert decode: retry succeeds
PASS  optimization-request-read-recovery-direct: expert decode: exact retry
PASS  optimization-request-read-recovery-direct: ngram decode: actual read failure
PASS  optimization-request-read-recovery-direct: ngram decode: error finish
PASS  optimization-request-read-recovery-direct: ngram decode: explicit error
PASS  optimization-request-read-recovery-direct: ngram decode: emitted prefix preserved
PASS  optimization-request-read-recovery-direct: ngram decode: callbacks equal committed output
PASS  optimization-request-read-recovery-direct: ngram decode: no partial state cached
PASS  optimization-request-read-recovery-direct: ngram decode: pins released
PASS  optimization-request-read-recovery-direct: ngram decode: admission reset
PASS  optimization-request-read-recovery-direct: ngram decode: retry succeeds
PASS  optimization-request-read-recovery-direct: ngram decode: exact retry
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: reference succeeds
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: injected read actually fails
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: read error is reported
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: error completion
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: no provisional output
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: no provisional callback
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: invalid state is never cached
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: all request pins released
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: admission reset
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: allocator limit restored
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: only completed chronological passes counted
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: cached prefix really reused
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: failure retains physical observations
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: failure retains VM interval
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: retry does a coherent rebuild
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: retry has exact reference output
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: successful retry can be cached
PASS  optimization-request-read-recovery-mtp-direct: pool prefill: speculative verification works after recovery
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: reference succeeds
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: injected read actually fails
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: read error is reported
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: error completion
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: no provisional output
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: no provisional callback
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: invalid state is never cached
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: all request pins released
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: admission reset
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: allocator limit restored
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: only completed chronological passes counted
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: cached prefix really reused
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: failed prefetch publishes no partial row batch
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: failure retains physical observations
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: failure retains VM interval
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: retry does a coherent rebuild
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: retry has exact reference output
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: successful retry can be cached
PASS  optimization-request-read-recovery-mtp-direct: ngram prefill: speculative verification works after recovery
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: reference succeeds
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: injected read actually fails
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: read error is reported
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: error completion
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: no provisional output
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: no provisional callback
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: invalid state is never cached
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: all request pins released
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: admission reset
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: allocator limit restored
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: only completed chronological passes counted
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: cached prefix really reused
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: failure retains physical observations
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: failure retains VM interval
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: retry does a coherent rebuild
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: retry has exact reference output
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: successful retry can be cached
PASS  optimization-request-read-recovery-mtp-direct: sweep prefill: speculative verification works after recovery
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: reference succeeds
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: seed owns exactly the prompt
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: injected read actually fails
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: read error is reported
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: error completion
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: no provisional output
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: no provisional callback
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: invalid state is never cached
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: all request pins released
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: admission reset
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: allocator limit restored
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: only completed chronological passes counted
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: cached prefix really reused
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: failure retains physical observations
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: failure retains VM interval
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: retry does a coherent rebuild
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: retry has exact reference output
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: successful retry can be cached
PASS  optimization-request-read-recovery-mtp-direct: cached-prefix append: speculative verification works after recovery
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: reference succeeds
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: injected read actually fails
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: read error is reported
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: error completion
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: no provisional output
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: no provisional callback
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: invalid state is never cached
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: all request pins released
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: admission reset
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: allocator limit restored
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: only completed chronological passes counted
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: cached prefix really reused
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: failure retains physical observations
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: failure retains VM interval
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: retry does a coherent rebuild
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: retry has exact reference output
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: successful retry can be cached
PASS  optimization-request-read-recovery-mtp-direct: second chronological pass: speculative verification works after recovery
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: reference succeeds
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: injected read actually fails
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: read error is reported
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: error completion
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: no provisional output
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: no provisional callback
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: invalid state is never cached
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: all request pins released
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: admission reset
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: allocator limit restored
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: only completed chronological passes counted
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: cached prefix really reused
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: failed scope counted
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: failure retains physical observations
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: failure retains VM interval
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: retry does a coherent rebuild
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: retry has exact reference output
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: successful retry can be cached
PASS  optimization-request-read-recovery-mtp-direct: read-scope transaction: speculative verification works after recovery
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: reference succeeds
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: injected read actually fails
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: read error is reported
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: error completion
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: no provisional output
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: no provisional callback
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: invalid state is never cached
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: all request pins released
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: admission reset
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: allocator limit restored
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: only completed chronological passes counted
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: cached prefix really reused
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: failed scope counted
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: failed prefetch publishes no partial row batch
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: failure retains physical observations
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: failure retains VM interval
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: retry does a coherent rebuild
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: retry has exact reference output
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: successful retry can be cached
PASS  optimization-request-read-recovery-mtp-direct: ngram read-scope transaction: speculative verification works after recovery
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: actual read failure
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: error finish
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: explicit error
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: emitted prefix preserved
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: callbacks equal committed output
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: no partial state cached
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: pins released
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: admission reset
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: exact retry
PASS  optimization-request-read-recovery-mtp-direct: expert speculative verify: draft alignment restored on new state
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: actual read failure
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: error finish
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: explicit error
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: emitted prefix preserved
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: callbacks equal committed output
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: no partial state cached
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: pins released
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: admission reset
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: retry succeeds
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: exact retry
PASS  optimization-request-read-recovery-mtp-direct: ngram speculative verify: draft alignment restored on new state
DECODE OVERLAP CHECK PASS

````

### full-verification/check-12.txt

Original bytes: 2201; SHA-256: `b0edbfb258dec05efcccb52302cdef7a6e1f90bb5e2d2468aad2b383e65887e1`.

````text
streamed draft experts and the plain-decode lookahead leave output exact (draft-stream-check)
run_binary draft-stream-check
engine ready in 0.9s: expert cache ~23/512 per layer (1091 global slots = 3.0 GB), mtp draft head on, eos [248044, 248046]
engine ready in 0.7s: expert cache ~28/512 per layer (1365 global slots = 3.8 GB), mtp draft head on, eos [248044, 248046]
engine ready in 0.7s: expert cache ~20/512 per layer (961 global slots = 2.7 GB), eos [248044, 248046]
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.7s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
PASS  draft-stream-head: the resident plan keeps the experts resident
PASS  draft-stream-head: resident run succeeds
PASS  draft-stream-head: resident run verified drafts
PASS  draft-stream-head: resident run reports no draft cache
PASS  draft-stream-head: resident run generated every token
PASS  draft-stream-head: the streamed plan streams the experts
PASS  draft-stream-head: streamed run succeeds
PASS  draft-stream-head: streamed experts leave the ids unchanged
PASS  draft-stream-head: streamed run generated every token
PASS  draft-stream-head: the streamed head read experts on demand
PASS  draft-stream-head: the streamed head reused cached experts
PASS  draft-stream-head: a failed draft read ends the request with an error
PASS  draft-stream-head: the failure was consumed
PASS  draft-stream-head: the next request succeeds
PASS  draft-stream-head: the next request decodes the same ids
PASS  draft-stream-plain-lookahead: the reference plan runs no lookahead
PASS  draft-stream-plain-lookahead: plain run succeeds
PASS  draft-stream-plain-lookahead: plain run generated every token
PASS  draft-stream-plain-lookahead: the plan runs the lookahead without the head
PASS  draft-stream-plain-lookahead: lookahead run succeeds
PASS  draft-stream-plain-lookahead: the lookahead leaves plain decode's ids unchanged
PASS  draft-stream-plain-lookahead: plain decode passes were forecast
PASS  draft-stream-plain-lookahead: the lookahead issued reads
DRAFT STREAM CHECK PASS

````

### full-verification/check-13.txt

Original bytes: 136; SHA-256: `7633a68ba286dd4b84e4b0da18e6c8e279c6ec38bcdb1af8f4a3904ef0011dbb`.

````text
independent current-backend draft-head reference
"$REFERENCE_PYTHON" Tools/current_backend_reference.py --kind mtp --out "$CURRENT_MTP"

````

### full-verification/check-14.txt

Original bytes: 335; SHA-256: `5166967d4b66222017f8b04c8638cabd3bbf00bfa003a3928b9ac915dd9c5063`.

````text
mtp head parity vs current Python reference (mtp-parity)
run_binary mtp-parity --fixture "$CURRENT_MTP/comparison.safetensors"
prefill sample: max abs 0.00000  rel 0.00000  OK
prefill multi: max abs 0.00000  rel 0.00000  OK
decode sample: max abs 0.00000  rel 0.00000  OK
decode multi: max abs 0.00000  rel 0.00000  OK
MTP PARITY PASS

````

### full-verification/check-15.txt

Original bytes: 3526; SHA-256: `7f1301500ec6252cb241b5d0ff769d7f2777c498b6684e4ad80baa443cd1675b`.

````text
verify pass rows equal plain decode bit for bit (mtp-rowcheck)
run_binary mtp-rowcheck --memory-gb 10
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (26.0 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (834 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode; its experts stream through a 64-expert cache (0.4 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11975 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~17/512 per layer (834 global slots = 2.3 GB), mtp draft head on, eos [248044, 248046]
prompt: 973-token prompt, below the indexer budget, rows across 1024 keys (2048); positions from 1019 every 1 tokens; context window 32768
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: exact verify attention engaged (180 layer passes)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: row-invariant projections engaged (11040 matmuls)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0141, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0173, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0156, 0 flips)
prompt: 2826-token prompt, above the indexer budget (2048); positions from 2826 every 4 tokens; context window 32768
PASS  2826-token prompt, above the indexer budget: exact verify attention engaged (180 layer passes)
PASS  2826-token prompt, above the indexer budget: row-invariant projections engaged (11040 matmuls)
PASS  2826-token prompt, above the indexer budget: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0208, 0 flips)
PASS  2826-token prompt, above the indexer budget: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0241, 0 flips)
PASS  2826-token prompt, above the indexer budget: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0253, 0 flips)
MTP ROWCHECK PASS

````

### full-verification/check-16.txt

Original bytes: 468; SHA-256: `ccea4cf6b66396aaae2e835c45e8de55f6f2b24154851eed0c76e14dfcad9712`.

````text
--memory-gb 10 process footprint and RSS stay under target
python3 Tools/memory_gate.py /tmp/ssv_mem.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 5780558600, "sampled_footprint_bytes": 5780558600, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 5143953408, "physical_footprint_end_bytes": 5780558600, "lifetime_footprint_peak_bytes": 5780558600, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}

````

### full-verification/check-17.txt

Original bytes: 71; SHA-256: `29c9a3eb030bd06f358d49a86ee2a5f435b93ad3a3710b689ecdc9afb4af0f00`.

````text
--memory-gb 10 output is stable
diff /tmp/ssv_mem.txt /tmp/ssv_big.txt

````

### full-verification/check-18.txt

Original bytes: 486; SHA-256: `ae1eec2db75086d99320d7ba6eff73f3f47a739e601464885c5f74e15687f742`.

````text
--memory-gb 10 process footprint and RSS under target on the long prompt
python3 Tools/memory_gate.py /tmp/ssv_longmem.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 8029703336, "sampled_footprint_bytes": 7990971560, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 3046621184, "physical_footprint_end_bytes": 6326899560, "lifetime_footprint_peak_bytes": 8029703336, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}

````

### full-verification/check-19.txt

Original bytes: 292; SHA-256: `4c4914bb3dcec6b643d6db1274eb322f10e2c2a19a5d02eb15779b0ad7e5bb15`.

````text
long-context answer still correct (sparse indexer active)
python3 Tools/long_context_gate.py /tmp/ssv_longmem.json /tmp/ssv_longmem.txt --expected SEVENTEEN --minimum-prompt-tokens 7000 --maximum-output-tokens 16
{"passed": true, "prompt_tokens": 7972, "output_tokens": 4, "completed": true}

````

### full-verification/check-2.txt

Original bytes: 202; SHA-256: `41d318695c0502e1ca324367f323bf4c936119ecba79f9fe78dddd3cafe25fb6`.

````text
chat template == transformers
[ "$(run_binary template-check 2>/dev/null)" = '248045,8678,198,2523,513,10631,13,248046,198,248045,846,198,12675,1017,248046,198,248045,74455,198,248068,271,248069,271' ]

````

### full-verification/check-20.txt

Original bytes: 265; SHA-256: `7acff6429e179baad49cf31a8f9ac3c44bbba0aca91eb97fd240ad734d70a1da`.

````text
context-check: 2k rung reads inside the plan and reports it
[ "$CONTEXT_STATUS" -eq 0 ] && python3 -c 'import json; d=json.loads(open("/tmp/ssv_ctx.json").read().strip().splitlines()[-1]); assert d["fits"] and d["aborted"] is None and d["prefill_tokens"]==2048, d'

````

### full-verification/check-21.txt

Original bytes: 460; SHA-256: `d53da7c9e4b05c0dd896ef94b0b7c5f36b368bff5f40bb043c15cb1197e464a9`.

````text
context-check: process memory remains under target
python3 Tools/memory_gate.py /tmp/ssv_ctx.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 8339803376, "sampled_footprint_bytes": 8291077360, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 3372826624, "physical_footprint_end_bytes": 7318689144, "lifetime_footprint_peak_bytes": 8339803376, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}

````

### full-verification/check-22.txt

Original bytes: 2133; SHA-256: `c8708bf70e0892cb86eb3062ee95e7a8e8547b8f7274a8381d2dcb2b267f933d`.

````text
run through a symlinked model dir
run_binary run --model "$SYM" --memory-gb 8.1 --max-tokens 1 --greedy --prompt hi
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (18.5 GB reclaimable now), 40.2 GB Metal working set
  target: 8.1 GB total process budget, not a RAM usage goal
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  plan:   ~7.9 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 1.8 GB expert cache at load; 6.2 GB allowed for runtime, context and workspace; 0.2 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 6510 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
engine ready in 0.7s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
prompt tokens: 13 (~0 s to the first token at this plan)
Hello
-- prefill 13 tok in 0.83s (15.7 tok/s)
-- prefill split: io 0.47s + scatter 0.00s | 2185 records (6.0 GB, 12.8 GB/s)
-- decode 1 tok in 0.00s (2857.14 tok/s)
-- decode split: io 0.00s + scatter 0.00s | 0 records
-- expert cache ~13/512 experts per layer, hit rate 0.000 | ngram rows 0h/0m | lifetime footprint peak 4.763 GB, current footprint 4.763 GB | total 0.8s


````

### full-verification/check-23.txt

Original bytes: 246; SHA-256: `81ad76629a6cefebc146edb24986efe0e4c61a8dbdb64d2976b913ffc22c8d6e`.

````text
vision tower dumps its pixels and embeddings
run_binary vision-parity --out "$VP"
loading the vision tower (0.898 GB resident)
wrote 2808 patches -> 702 tokens (832x864, grid 52x54) to .build/quantization-research/full-verification/vision-parity

````

### full-verification/check-3.txt

Original bytes: 260; SHA-256: `fcfaedd51d025cbf44a9d614286b0393963d979add8bbe925a6ff2cb60f580c0`.

````text
layer parity (historical reference, one-row projections)
run_binary parity --tokens '9707,11,1246,525,498,30' --layers 2 --compare bench/parity31 --row-invariant
layer  0: max abs 0.00098, rel 0.00225  OK
layer  1: max abs 0.00293, rel 0.00679  OK
PARITY PASS

````

### full-verification/check-4.txt

Original bytes: 197; SHA-256: `fb8f6a90ca599063a57942a9de67373f5c337d3f63ae2660732648b2613c309f`.

````text
independent current-backend layer reference
"$REFERENCE_PYTHON" Tools/current_backend_reference.py --kind layers --out "$CURRENT_LAYERS"
completed independent layer 0
completed independent layer 1

````

### full-verification/check-5.txt

Original bytes: 236; SHA-256: `b39cf14334899c78c6a28d68a1e90c2d4ca8542845a0a8e8734110aff00c5084`.

````text
production layer parity against current backend
run_binary parity --tokens 9707,11,1246,525,498,30 --layers 2 --compare "$CURRENT_LAYERS"
layer  0: max abs 0.00000, rel 0.00000  OK
layer  1: max abs 0.00049, rel 0.00114  OK
PARITY PASS

````

### full-verification/check-6.txt

Original bytes: 83; SHA-256: `f004e9fdfdc5f1a7ecb88d5c2cbe6963c972bc4a07427b162e62bfa5808f68c1`.

````text
8.1 GB cache output == 10 GB cache output
diff /tmp/ssv_big.txt /tmp/ssv_small.txt

````

### full-verification/check-7.txt

Original bytes: 414; SHA-256: `3763e86d33221de6ee6c6f3256b1bf155a50a4b8e798f0ea40273a42adbd44ec`.

````text
grow/shrink/regrow byte-identical (elastic-check)
run_binary elastic-check --big-slots 960
engine ready in 0.6s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  baseline     (640 slots): 4.0s
  after grow   (960 slots): 2.8s
  after shrink (640 slots): 3.1s
  after regrow (800 slots): 2.9s
ELASTIC CHECK PASS: 4 generations byte-identical across 13→20→13→16 experts/layer

````

### full-verification/check-8.txt

Original bytes: 1145; SHA-256: `040b42d601a14041d144f5d5f39215f28d2dade843a5c44913d1b21037d73bca`.

````text
prefix reuse, invalidation and live reply equality (prefix-check)
run_binary prefix-check
engine ready in 0.7s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  equivalence at 28 tokens: reuse 1.557% vs prefill-rechunk control 1.698% of logit spread, top-1 same
  equivalence at 100 tokens: reuse 3.808% vs prefill-rechunk control 3.649% of logit spread, top-1 same
  equivalence at 196 tokens: reuse 5.669% vs prefill-rechunk control 3.741% of logit spread, top-1 differs
  shed: retained 1411 tokens, dropped, next turn rebuilt 1436
  turn 1: 1409 prompt tok, 0 reused, prefill 13.21s -> Mars
  turn 2: 1436 prompt tok, 1280 reused, prefill 3.10s -> No
  turn 3: 1457 prompt tok, 1280 reused, prefill 3.27s -> Mars has a smaller diameter and mass than Ea
  historical rechunk bounds: diagnostic only; prefix-exact-check gates identical cold/warm logits
PREFIX CHECK PASS: historical cross-schedule drift 5.67% vs 3.74% for the rechunk control, top-1 2/3; 2 of 2 turns reused a prefix; cached and edited-history runs deterministic; follow-up prefill 25.18s -> 6.37s (0 of 3 replies differ from a cold rebuild)

````

### full-verification/check-9.txt

Original bytes: 1295; SHA-256: `fe0a37c351267133fa7cfb07fe7db1865b16b2080b665755c470c55b1c7f1497`.

````text
a continued conversation equals a cold one (prefix-exact-check)
run_binary prefix-exact-check
engine ready in 0.7s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  pass size 256 tokens, aligned resume on
  long turn 1: 1521 prompt tok, reused 0, logit delta 0.000000%
  long turn 2: 1548 prompt tok, reused 1280, logit delta 0.000000%
  long turn 3: 1576 prompt tok, reused 1536, logit delta 0.000000%
  long turn 1 prefill: 13.21s cold, 14.66s continued (1521 of 1521 tokens read)
  long turn 2 prefill: 11.08s cold, 4.94s continued (268 of 1548 tokens read)
  long turn 3 prefill: 12.02s cold, 1.53s continued (40 of 1576 tokens read)
  repeat turn 1: 1521 prompt tok, reused 1521, logit delta 0.000000%
  short turn 1: 22 prompt tok, reused 0, logit delta 0.000000%
  short turn 2: 49 prompt tok, reused 0, logit delta 0.000000%
  short turn 3: 70 prompt tok, reused 0, logit delta 0.000000%
  shared prefix turn 1: 1520 prompt tok, reused 1280, logit delta 0.000000%
PREFIX EXACT CHECK PASS: every continued turn produced the same tokens and the same prompt logits as a cold read, 2 of 2 follow-up turns resumed a boundary state, an identical prompt reused its complete state, an edited history rebuilt, and a second conversation resumed the shared prefix

````

### full-verification/elastic-drill.txt

Original bytes: 1470; SHA-256: `8d00d6540f6ee795ae9a1c557a72d072d3f673db853fae6c383dfc20f28827fa`.

````text
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.7s: expert cache ~35/512 per layer (1690 global slots = 4.7 GB), eos [248044, 248046]
  (machine has 19.9 GB reclaimable; drill capped at a 4.7 GB pool)
  start:  1690 slots (~35/layer) -> Nile, Amazon, Mississippi
elastic: availability dropped — cache ~35 → ~16 experts/layer (4.7 → 2.1 GB pool, cold — refills from SSD)
  squeeze: 764 slots (~16/layer) -> Nile, Amazon, Mississippi
  recovery stimulus: 7.8 GB available -> 1690 desired slots (2.6 GB growth)
  cooldown: held at 764 slots, as designed
  waiting out the 60 s grow cooldown...
elastic: memory freed — cache ~16 → ~35 experts/layer (2.1 → 4.7 GB pool, contents kept)
  recover: 1690 slots (~35/layer) -> Nile, Amazon, Mississippi
ELASTIC DRILL MEMORY {"ceiling_gb":13,"complete":true,"lifetime_physical_footprint_peak_bytes":9588264536,"lifetime_rss_peak_bytes":7539671040,"output_ids":[[45,448,11,7919,11,27509],[45,448,11,7919,11,27509],[45,448,11,7919,11,27509]],"physical_footprint_end_bytes":8361761296,"sampled_peak_bytes":9583234672,"samples":3496,"swap_clean":true,"swapins_after":0,"swapins_before":0,"swapouts_after":0,"swapouts_before":0,"target_gb":13}
ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical

````

### full-verification/elastic-drill-small.txt

Original bytes: 1471; SHA-256: `55f81ff62337c25172365caa2ef5f0868bb0577f7e658f6cea20b842e5cfe3fe`.

````text
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.7s: expert cache ~17/512 per layer (833 global slots = 2.3 GB), eos [248044, 248046]
  (machine has 15.0 GB reclaimable; drill capped at a 2.3 GB pool)
  start:  833 slots (~17/layer) -> Nile, Amazon, Mississippi
elastic: memory pressure (warning) — cache ~17 → ~13 experts/layer (2.3 → 1.8 GB pool, cold — refills from SSD)
  squeeze: 640 slots (~13/layer) -> Nile, Amazon, Mississippi
  recovery stimulus: 5.1 GB available -> 833 desired slots (0.5 GB growth)
  cooldown: held at 640 slots, as designed
  waiting out the 60 s grow cooldown...
elastic: memory freed — cache ~13 → ~17 experts/layer (1.8 → 2.3 GB pool, contents kept)
  recover: 833 slots (~17/layer) -> Nile, Amazon, Mississippi
ELASTIC DRILL MEMORY {"ceiling_gb":10,"complete":true,"lifetime_physical_footprint_peak_bytes":6756128216,"lifetime_rss_peak_bytes":6173327360,"output_ids":[[45,448,11,7919,11,27509],[45,448,11,7919,11,27509],[45,448,11,7919,11,27509]],"physical_footprint_end_bytes":5912712160,"sampled_peak_bytes":6756128216,"samples":3458,"swap_clean":true,"swapins_after":0,"swapins_before":0,"swapouts_after":0,"swapouts_before":0,"target_gb":10}
ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical

````

### full-verification/mtp.txt

Original bytes: 3591; SHA-256: `cc7e75a98bba1a8ca430f4419d99750655922ae628a7f747dafc4c1985a8f95a`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (24.8 GB reclaimable now), 40.2 GB Metal working set
  target: 12.0 GB total process budget, not a RAM usage goal
  cache:  ~26 of 512 experts per layer  (1225 global slots = 3.4 GB pool)
  plan:   ~11.0 GB full-workload envelope, ~5 tok/s warm decode (est. from M5 Pro anchors)
  memory: 3.4 GB expert cache at load; 7.6 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 512 tokens per pass (~125 tok/s here; costs ~0.7 GB of the target)
  mtp:    draft head on — speculative decode; its experts stream through a 64-expert cache (0.4 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 17658 tokens across 4 conversations (~0.8 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.9s: expert cache ~26/512 per layer (1225 global slots = 3.4 GB), mtp draft head on, eos [248044, 248046]
PASS  determinism p1 (48 tokens)
PASS  speculation ran p1
  info  p1: plain vs spec shared prefix 48/48 (identical)
PASS  determinism p2 (48 tokens)
PASS  speculation ran p2
  info  p2: plain vs spec shared prefix 48/48 (identical)
PASS  determinism p3 (48 tokens)
PASS  speculation ran p3
  info  p3: plain vs spec shared prefix 6/48
  info  vision+mtp prompt: 721 tokens, 1 image(s), placeholder id 248056
PASS  vision speculation deterministic (48 tokens)
PASS  vision speculation ran
  info  vision plain vs spec shared prefix 48/48 (identical)
  info  overall accept rate 81.2%
PASS  accept rate is not degenerate (>5%)
  info  recording pass vs batched: 0.0000% of spread (top-1 same); rollback state vs plain: ssm 2.09e-02, conv 3.10e-02, ple 4.48e-03 relative (re-chunk control: ssm 9.11e-02, conv 6.83e-02, ple 1.79e-02); one more step: 1.270% vs control 2.312% (bound 6.935%, top-1 same)
PASS  recording verify pass matches the batched pass (<= 0.1% of spread)
PASS  rollback state stays inside 3x the re-chunk band (ssm, conv, ple)
PASS  rollback then one step stays inside the prefill-rechunk band
PASS  turn-2 reused the speculative turn-1 state
  info  turn-2 logits from the reused speculative state: 4.333% of spread vs a cold rebuild (prefill-rechunk control 4.655%, bound 13.964%), top-1 same; reused 64 of 71 tokens after a 48-token turn 1 (20 verify passes)
PASS  reused speculative state stays inside the prefill-rechunk band
PASS  turn-1 speculation ran
PASS  whole MTP check process memory fits the priced target
MTP CHECK PASS
MTP CHECK MEMORY {"lifetime_physical_footprint_peak_bytes":9475349272,"lifetime_rss_peak_bytes":6555516928,"memory_validated":true,"physical_footprint_end_bytes":9475332888,"sampled_peak_bytes":9475332888,"samples":6628,"swap_clean":true,"swapins_after":0,"swapins_before":0,"swapouts_after":0,"swapouts_before":0,"target_gb":12}

````

### full-verification/mtp-legacy-reference.txt

Original bytes: 216; SHA-256: `c0f4555eac5e1d29a189fb5f19faa160761a76eec8054a5cc645d7dcbcea5c06`.

````text
prefill sample: max abs 5.62500  rel 0.15625  FAIL
prefill multi: max abs 1.22070  rel 0.09527  FAIL
decode sample: max abs 1.90625  rel 0.05117  FAIL
decode multi: max abs 0.33545  rel 0.05650  FAIL
MTP PARITY FAIL

````

### full-verification/context-check.stderr.txt

Original bytes: 1775; SHA-256: `3190331fa10aab93518f7a1bfd2a51f488b171cfa0b296804a4317991d2c68b2`.

````text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (27.2 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~22 of 512 experts per layer  (1062 global slots = 2.9 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~4 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.9 GB expert cache at load; 6.1 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 2064 tokens per request (prompt + reply); a full-length prompt takes ~24 s before its first token here, follow-up turns read only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
  note:   prefill and prefix retention reservations match the explicit runtime controls
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 1.2s: expert cache ~22/512 per layer (1062 global slots = 2.9 GB), eos [248044, 248046]
  prefill: reading 2048 prompt tokens, ~24 s to the first token at this plan (follow-up turns read only what is new)
  prefill: 1792/2048 tokens (88%), 142 tok/s recently, ~2 s left at this rate
  prefill: done, 2048 tokens in 16 s (126 tok/s)

````

### full-verification/context-check.exit-status.txt

Original bytes: 2; SHA-256: `9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa`.

````text
0

````

### full-verification/transient-output/ssv_mem.json

Original bytes: 9158; SHA-256: `83253066d7239318eff5b2f01aa678a1f382bf347a3ec3ded3ad5d05c7573682`.

````text
{"effective_expected_peak_gb":9.2500687359999993,"effective_mtp":false,"effective_pool_slots":821,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.010519209,"experimental_memory_family":true,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0.25165823999999998,"launch_seconds":11.940427250000001,"load_seconds":8.5433543749999998,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[760,12515,7701,6105,15048,4016,310,264,24057,2512,2972,28232,60845,69377,159034,271,13962,14392,13909,12,8046,68868,25,271],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":true,"device_available_gb":26.399999999999999,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":3.4208333333333338,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":17,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":428867584,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8998410496,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2269900800,"prefill_bytes":332800000,"retained_capacity_bytes":327103488,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"mtp_streamed_experts":false,"non_cache_allowance_bytes":6728509696,"planned_headroom_gb":1,"pool_gb":2.2999999999999998,"pool_slots":821,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":11831,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":true,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0.90000000000000002,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,9930,369,279,12515,6105,30,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"24","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":28311552,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":1,"contextArithmetic":"standard","decodeForwardPasses":23,"decodeIOSeconds":0.85536701199999887,"decodeLocalVictims":0,"decodeModelTokens":23,"decodeReadBytes":6259507200,"decodeRecords":2264,"decodeScatterSeconds":0,"decodeSeconds":2.437359625,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":988,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":24,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":48960,"embeddingCachedRows":34,"embeddingRowHits":3,"embeddingRowMisses":34,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.40932971014492753,"expertPrefetch":{"adopted":4257,"adoptedBytes":11769753600,"adoption":"slot","adoptSeconds":0.15008849199999993,"arrivalIssues":1048,"cancelled":20,"candidates":4824,"capRefusals":0,"deferredLaneAcquisitions":4698,"demandBatches":1120,"demandMisses":2259,"dirtyRescans":0,"expired":547,"failed":0,"forecastBuildSeconds":0.017958315000000006,"forecastEvalSeconds":0.61475549349999992,"forecastMerged":4824,"forecastPasses":23,"forecastSeconds":0.036759486000000029,"forecastSelectSeconds":0.018774423999999977,"forecastTap":"attention-corrected","forecastTargets":1081,"issued":4824,"issuedBytes":13337395200,"joinSeconds":0.14751410600000206,"layersComplete":10,"layersWithMisses":1142,"mode":"on","passes":23,"peakLiveBytes":0,"pieceModeReads":4824,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":2872,"readShape":"piece","recordReads":0,"scheduleSeconds":0.010999134000000032,"slotEvictedKeys":4258,"slotRefusals":0,"slotReleases":567,"slotReservations":4824,"slotStale":0,"wastedBytes":1567641600},"finishReason":"length","firstTextSeconds":0.94855654099999998,"firstTokenSeconds":0.94655241599999995,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":576,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":21002567680,"swapins":0,"swapouts":0},"generatorVMBefore":{"reclaimableBytes":21604564992,"swapins":0,"swapouts":0},"gpuKeptAwake":true,"imageEncodeSeconds":3.7500000000000001e-07,"interTokenSeconds":[0.13794616700000001,0.117209334,0.101871959,0.102853584,0.105538875,0.095267416999999993,0.096124583999999999,0.092182249999999993,0.099497125000000006,0.106462375,0.10811800000000001,0.11988,0.092542625000000003,0.093419125000000006,0.120440292,0.10366499999999999,0.093720582999999996,0.091540583999999994,0.088222375000000006,0.13012879099999999,0.10182079199999999,0.11910670800000001,0.119343458],"lifetimePhysicalFootprintPeakBytes":5780558600,"lifetimeRSSPeakBytes":5143953408,"memoryPressureCancelled":false,"mlxActiveEndBytes":5424569496,"mlxCacheEndBytes":88113204,"mlxPeakMemoryGB":5.4311594300000001,"ngramCachedRows":656,"ngramCachePayloadBytes":209920,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.026103332000000003,"ngramRowHits":0,"ngramRowMisses":368,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":5.7805586,"physicalFootprintEndBytes":5780558600,"prefillComputeKeyExtents":[18],"prefillComputePasses":[18],"prefillComputeQueryRows":[18],"prefillGPUWaitSeconds":0,"prefillIOSeconds":0.69265358199999982,"prefillLocalVictims":0,"prefillMLXActiveBytes":5281904024,"prefillMLXCacheBytes":86653084,"prefillPasses":[18],"prefillPhysicalFootprintBytes":5616046688,"prefillReadBytes":9455616000,"prefillRecords":3420,"prefillRowSortSeconds":0,"prefillScatterSeconds":0,"prefillSeconds":0.92675341700000002,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":132,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":18,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":0,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.010682624999999999,"promptTokens":18,"queueSeconds":1.4833e-05,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":3.3961134579999999,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":24,"ropeTableHits":264,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":5780558600,"samples":171},"sampleSeconds":0.003092333999999999,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixCommon":0,"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.0011857950000000001,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"The sky appears blue primarily due to a phenomenon called **Rayleigh scattering**.\n\n### Step-by-Step Explanation:\n\n"}
````

### full-verification/transient-output/ssv_longmem.json

Original bytes: 49504; SHA-256: `ddb27a077738c6b5ce01426fde21fcfa9b27838973740a45ef4e614ce6b4e238`.

````text
{"effective_expected_peak_gb":9.2500687359999993,"effective_mtp":false,"effective_pool_slots":821,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.03529525,"experimental_memory_family":true,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0.25165823999999998,"launch_seconds":38.941512041999999,"load_seconds":8.6035279589999991,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[896,6571,36,923],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":true,"device_available_gb":26.199999999999999,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":3.4208333333333338,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":17,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":428867584,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8998410496,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2269900800,"prefill_bytes":332800000,"retained_capacity_bytes":327103488,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"mtp_streamed_experts":false,"non_cache_allowance_bytes":6728509696,"planned_headroom_gb":1,"pool_gb":2.2999999999999998,"pool_slots":821,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":11831,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":true,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0.90000000000000002,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,760,17593,7189,421,279,33439,10286,369,4890,6571,36,923,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,4558,14162,25,1092,369,279,33439,10286,30,21134,440,799,3299,13,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"16","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":226492416,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":0,"contextArithmetic":"standard","decodeForwardPasses":4,"decodeIOSeconds":0.18384900300000004,"decodeLocalVictims":0,"decodeModelTokens":4,"decodeReadBytes":1625702400,"decodeRecords":588,"decodeScatterSeconds":0,"decodeSeconds":0.51260158300000003,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":189,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":4,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":84960,"embeddingCachedRows":59,"embeddingRowHits":50,"embeddingRowMisses":59,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.35312500000000002,"expertPrefetch":{"adopted":654,"adoptedBytes":1808179200,"adoption":"slot","adoptSeconds":0.010555912999999993,"arrivalIssues":187,"cancelled":0,"candidates":882,"capRefusals":0,"deferredLaneAcquisitions":965,"demandBatches":425,"demandMisses":588,"dirtyRescans":0,"expired":228,"failed":0,"forecastBuildSeconds":0.0031032199999999985,"forecastEvalSeconds":0.14348860199999985,"forecastMerged":882,"forecastPasses":4,"forecastSeconds":0.006688050999999999,"forecastSelectSeconds":0.0035793730000000003,"forecastTap":"attention-corrected","forecastTargets":188,"issued":882,"issuedBytes":2438553600,"joinSeconds":0.010211049,"layersComplete":0,"layersWithMisses":240,"mode":"on","passes":4,"peakLiveBytes":0,"pieceModeReads":882,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":329,"readShape":"piece","recordReads":0,"scheduleSeconds":0.0022127099999999997,"slotEvictedKeys":656,"slotRefusals":0,"slotReleases":227,"slotReservations":882,"slotStale":0,"wastedBytes":630374400},"finishReason":"stop","firstTextSeconds":29.789930792,"firstTokenSeconds":29.788951292,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":1536,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":21797896192,"swapins":0,"swapouts":0},"generatorVMBefore":{"reclaimableBytes":21472952320,"swapins":0,"swapouts":0},"gpuKeptAwake":true,"imageEncodeSeconds":2.4999999999999999e-07,"interTokenSeconds":[0.15768620799999999,0.11831045799999999,0.107327125],"lifetimePhysicalFootprintPeakBytes":8029703336,"lifetimeRSSPeakBytes":3046621184,"memoryPressureCancelled":false,"mlxActiveEndBytes":5480581848,"mlxCacheEndBytes":368067833,"mlxPeakMemoryGB":7.6261152279999997,"ngramCachedRows":1192,"ngramCachePayloadBytes":381440,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.024480583999999996,"ngramRowHits":24,"ngramRowMisses":40,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":8.0297033360000007,"physicalFootprintEndBytes":6326899560,"prefillComputeKeyExtents":[256,512,768,1024,1280,1536,1792,2048,2304,2560,2816,3072,3328,3584,3840,4096,4352,4608,4864,5120,5376,5632,5888,6144,6400,6656,6912,7168,7424,7680,7936,7972],"prefillComputePasses":[256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,36],"prefillComputeQueryRows":[256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,36],"prefillGPUWaitSeconds":6.7980572070000065,"prefillIOSeconds":5.6382075099999982,"prefillLocalVictims":0,"prefillMLXActiveBytes":5479993496,"prefillMLXCacheBytes":360940478,"prefillPasses":[7936,36],"prefillPhysicalFootprintBytes":6304764632,"prefillReadBytes":68849049600,"prefillRecords":24902,"prefillRowSortSeconds":0.019107670000000007,"prefillScatterSeconds":1.2517708050000005,"prefillSeconds":29.771792583,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":236,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":7972,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":2,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.035325417000000005,"promptTokens":7972,"queueSeconds":4.7500000000000003e-06,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":30.337401792000001,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":655,"ropeTableHits":449,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":7990971560,"samples":1516},"sampleSeconds":0.00090541600000000003,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixCommon":0,"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.00036329100000000002,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"SEVENTEEN"}
````

### full-verification/transient-output/ssv_ctx.json

Original bytes: 16384; SHA-256: `0ee0c70255c50db8b356dc990aa748d80acc0708ed70fa9d1e7c7fbfe35a62b3`.

````text
{"aborted":null,"compute_key_extents":[256,512,768,1024,1280,1536,1792,2048],"compute_passes":[256,256,256,256,256,256,256,256],"compute_query_rows":[256,256,256,256,256,256,256,256],"configured_context":2064,"fits":true,"memory_ledger":{"active_capacity_bytes":84934656,"additional_active_bytes":0,"expected_peak_bytes":8997885184,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2936217600,"prefill_bytes":332800000,"retained_capacity_bytes":0,"retained_recurrent_bytes":0,"version":1,"vision_resident_bytes":0},"model_revision":"aa7c790e804bbf9d491ddb109c3d61bc4a555f7c","optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[20,12364,5020,220,16,20,13,271,248068,271,248069,271,27775,383,279,795],"pass_timings":[{"from":0,"seconds":12.649962,"tokens":1792},{"from":1792,"seconds":3.6080234170000001,"tokens":256}],"passes":[1792,256],"peak_rss_gb":3.372826624,"plan_expected_peak_gb":8.9978851839999994,"prefill_chunk":256,"prefill_seconds":16.258257541999999,"prefill_tok_s":125.96675841241881,"prefill_tokens":2048,"process_peak_bound_gb":8.3398033760000008,"prompt_ids":[1905,1716,13,13190,220,15,25,279,11661,383,1500,220,15,4800,220,18,22,7896,506,220,15,25,15,15,11,321,51715,220,15,12364,5020,220,15,13,13190,220,16,25,279,11661,383,1500,220,16,4800,220,21,23,7896,506,220,16,25,15,22,11,321,51715,220,16,18,12364,5020,220,16,13,13190,220,17,25,279,11661,383,1500,220,17,4800,220,24,24,7896,506,220,17,25,16,19,11,321,51715,220,17,21,12364,5020,220,17,13,13190,220,18,25,279,11661,383,1500,220,18,4800,220,16,18,15,7896,506,220,18,25,17,16,11,321,51715,220,18,24,12364,5020,220,18,13,13190,220,19,25,279,11661,383,1500,220,19,4800,220,16,21,16,7896,506,220,19,25,17,23,11,321,51715,220,20,17,12364,5020,220,19,13,13190,220,20,25,279,11661,383,1500,220,20,4800,220,16,24,17,7896,506,220,20,25,18,20,11,321,51715,220,21,20,12364,5020,220,20,13,13190,220,21,25,279,11661,383,1500,220,21,4800,220,17,17,18,7896,506,220,21,25,19,17,11,321,51715,220,22,23,12364,5020,220,21,13,13190,220,22,25,279,11661,383,1500,220,22,4800,220,17,20,19,7896,506,220,22,25,19,24,11,321,51715,220,24,16,12364,5020,220,22,13,13190,220,23,25,279,11661,383,1500,220,23,4800,220,17,23,20,7896,506,220,23,25,20,21,11,321,51715,220,16,15,19,12364,5020,220,23,13,13190,220,24,25,279,11661,383,1500,220,24,4800,220,18,16,21,7896,506,220,24,25,15,18,11,321,51715,220,16,16,22,12364,5020,220,24,13,13190,220,16,15,25,279,11661,383,1500,220,16,15,4800,220,18,19,22,7896,506,220,16,15,25,16,15,11,321,51715,220,16,18,15,12364,5020,220,16,15,13,13190,220,16,16,25,279,11661,383,1500,220,16,16,4800,220,18,22,23,7896,506,220,16,16,25,16,22,11,321,51715,220,16,19,18,12364,5020,220,16,16,13,13190,220,16,17,25,279,11661,383,1500,220,16,17,4800,220,19,15,24,7896,506,220,16,17,25,17,19,11,321,51715,220,16,20,21,12364,5020,220,16,17,13,13190,220,16,18,25,279,11661,383,1500,220,16,18,4800,220,19,19,15,7896,506,220,16,18,25,18,16,11,321,51715,220,16,21,24,12364,5020,220,16,18,13,13190,220,16,19,25,279,11661,383,1500,220,16,19,4800,220,19,22,16,7896,506,220,16,19,25,18,23,11,321,51715,220,16,23,17,12364,5020,220,16,19,13,13190,220,16,20,25,279,11661,383,1500,220,16,20,4800,220,20,15,17,7896,506,220,16,20,25,19,20,11,321,51715,220,16,24,20,12364,5020,220,16,20,13,13190,220,16,21,25,279,11661,383,1500,220,16,21,4800,220,20,18,18,7896,506,220,16,21,25,20,17,11,321,51715,220,17,15,23,12364,5020,220,16,21,13,13190,220,16,22,25,279,11661,383,1500,220,16,22,4800,220,21,19,7896,506,220,16,22,25,20,24,11,321,51715,220,17,17,16,12364,5020,220,16,22,13,13190,220,16,23,25,279,11661,383,1500,220,16,23,4800,220,24,20,7896,506,220,16,23,25,15,21,11,321,51715,220,17,18,19,12364,5020,220,16,23,13,13190,220,16,24,25,279,11661,383,1500,220,16,24,4800,220,16,17,21,7896,506,220,16,24,25,16,18,11,321,51715,220,17,19,22,12364,5020,220,16,24,13,13190,220,17,15,25,279,11661,383,1500,220,17,15,4800,220,16,20,22,7896,506,220,17,15,25,17,15,11,321,51715,220,17,21,15,12364,5020,220,17,15,13,13190,220,17,16,25,279,11661,383,1500,220,17,16,4800,220,16,23,23,7896,506,220,17,16,25,17,22,11,321,51715,220,17,22,18,12364,5020,220,17,16,13,13190,220,17,17,25,279,11661,383,1500,220,17,17,4800,220,17,16,24,7896,506,220,17,17,25,18,19,11,321,51715,220,17,23,21,12364,5020,220,17,17,13,13190,220,17,18,25,279,11661,383,1500,220,17,18,4800,220,17,20,15,7896,506,220,17,18,25,19,16,11,321,51715,220,17,24,24,12364,5020,220,17,18,13,13190,220,17,19,25,279,11661,383,1500,220,17,19,4800,220,17,23,16,7896,506,220,15,25,19,23,11,321,51715,220,18,16,17,12364,5020,220,17,19,13,13190,220,17,20,25,279,11661,383,1500,220,17,20,4800,220,18,16,17,7896,506,220,16,25,20,20,11,321,51715,220,18,17,20,12364,5020,220,17,20,13,13190,220,17,21,25,279,11661,383,1500,220,17,21,4800,220,18,19,18,7896,506,220,17,25,15,17,11,321,51715,220,18,18,23,12364,5020,220,17,21,13,13190,220,17,22,25,279,11661,383,1500,220,17,22,4800,220,18,22,19,7896,506,220,18,25,15,24,11,321,51715,220,18,20,16,12364,5020,220,17,22,13,13190,220,17,23,25,279,11661,383,1500,220,17,23,4800,220,19,15,20,7896,506,220,19,25,16,21,11,321,51715,220,18,21,19,12364,5020,220,17,23,13,13190,220,17,24,25,279,11661,383,1500,220,17,24,4800,220,19,18,21,7896,506,220,20,25,17,18,11,321,51715,220,18,22,22,12364,5020,220,17,24,13,13190,220,18,15,25,279,11661,383,1500,220,18,15,4800,220,19,21,22,7896,506,220,21,25,18,15,11,321,51715,220,18,24,15,12364,5020,220,18,15,13,13190,220,18,16,25,279,11661,383,1500,220,18,16,4800,220,19,24,23,7896,506,220,22,25,18,22,11,321,51715,220,19,15,18,12364,5020,220,18,16,13,13190,220,18,17,25,279,11661,383,1500,220,18,17,4800,220,20,17,24,7896,506,220,23,25,19,19,11,321,51715,220,19,16,21,12364,5020,220,18,17,13,13190,220,18,18,25,279,11661,383,1500,220,18,18,4800,220,21,15,7896,506,220,24,25,20,16,11,321,51715,220,19,17,24,12364,5020,220,18,18,13,13190,220,18,19,25,279,11661,383,1500,220,18,19,4800,220,24,16,7896,506,220,16,15,25,20,23,11,321,51715,220,19,19,17,12364,5020,220,18,19,13,13190,220,18,20,25,279,11661,383,1500,220,18,20,4800,220,16,17,17,7896,506,220,16,16,25,15,20,11,321,51715,220,19,20,20,12364,5020,220,18,20,13,13190,220,18,21,25,279,11661,383,1500,220,18,21,4800,220,16,20,18,7896,506,220,16,17,25,16,17,11,321,51715,220,19,21,23,12364,5020,220,18,21,13,13190,220,18,22,25,279,11661,383,1500,220,18,22,4800,220,16,23,19,7896,506,220,16,18,25,16,24,11,321,51715,220,19,23,16,12364,5020,220,18,22,13,13190,220,18,23,25,279,11661,383,1500,220,18,23,4800,220,17,16,20,7896,506,220,16,19,25,17,21,11,321,51715,220,19,24,19,12364,5020,220,18,23,13,13190,220,18,24,25,279,11661,383,1500,220,18,24,4800,220,17,19,21,7896,506,220,16,20,25,18,18,11,321,51715,220,20,15,22,12364,5020,220,18,24,13,13190,220,19,15,25,279,11661,383,1500,220,19,15,4800,220,17,22,22,7896,506,220,16,21,25,19,15,11,321,51715,220,20,17,15,12364,5020,220,19,15,13,13190,220,19,16,25,279,11661,383,1500,220,19,16,4800,220,18,15,23,7896,506,220,16,22,25,19,22,11,321,51715,220,20,18,18,12364,5020,220,19,16,13,13190,220,19,17,25,279,11661,383,1500,220,19,17,4800,220,18,18,24,7896,506,220,16,23,25,20,19,11,321,51715,220,20,19,21,12364,5020,220,19,17,13,13190,220,19,18,25,279,11661,383,1500,220,19,18,4800,220,18,22,15,7896,506,220,16,24,25,15,16,11,321,51715,220,20,20,24,12364,5020,220,19,18,13,13190,220,19,19,25,279,11661,383,1500,220,19,19,4800,220,19,15,16,7896,506,220,17,15,25,15,23,11,321,51715,220,20,22,17,12364,5020,220,19,19,13,13190,220,19,20,25,279,11661,383,1500,220,19,20,4800,220,19,18,17,7896,506,220,17,16,25,16,20,11,321,51715,220,20,23,20,12364,5020,220,19,20,13,13190,220,19,21,25,279,11661,383,1500,220,19,21,4800,220,19,21,18,7896,506,220,17,17,25,17,17,11,321,51715,220,20,24,23,12364,5020,220,19,21,13,13190,220,19,22,25,279,11661,383,1500,220,19,22,4800,220,19,24,19,7896,506,220,17,18,25,17,24,11,321,51715,220,21,16,16,12364,5020,220,19,22,13,13190,220,19,23,25,279,11661,383,1500,220,19,23,4800,220,20,17,20,7896,506,220,15,25,18,21,11,321,51715,220,21,17,19,12364,5020,220,19,23,13,13190,220,19,24,25,279,11661,383,1500,220,19,24,4800,220,20,21,7896,506,220,16,25,19,18,11,321,51715,220,21,18,22,12364,5020,220,19,24,13,13190,220,20,15,25,279,11661,383,1500,220,20,15,4800,220,23,22,7896,506,220,17,25,20,15,11,321,51715,220,21,20,15,12364,5020,220,20,15,13,13190,220,20,16,25,279,11661,383,1500,220,20,16,4800,220,16,16,23,7896,506,220,18,25,20,22,11,321,51715,220,21,21,18,12364,5020,220,20,16,13,13190,220,20,17,25,279,11661,383,1500,220,20,17,4800,220,16,19,24,7896,506,220,19,25,15,19,11,321,51715,220,21,22,21,12364,5020,220,20,17,13,13190,220,20,18,25,279,11661,383,1500,220,20,18,4800,220,16,23,15,7896,506,220,20,25,16,16,11,321,51715,220,21,23,24,12364,5020,220,20,18,13,13190,220,20,19,25,279,11661,383,1500,220,20,19,4800,220,17,16,16,7896,506,220,21,25,16,23,11,321,51715,220,22,15,17,12364,5020,220,20,19,13,13190,220,20,20,25,279,11661,383,1500,220,20,20,4800,220,17,19,17,7896,506,220,22,25,17,20,11,321,51715,220,22,16],"reply_tokens":16,"retained_after":{"allocated_sequence_bytes":0,"charged_token_capacity":0,"checkpoint_fork_failures":0,"checkpoint_hits":0,"checkpoint_stores":0,"conversations":0,"enabled":false,"evictions":0,"held_gb":0,"held_images":0,"held_tokens":0,"hits":0,"max_conversations":4,"max_tokens":0,"misses":0,"persistent_hits":0,"reusable_checkpoints":0},"retained_before":{"allocated_sequence_bytes":0,"charged_token_capacity":0,"checkpoint_fork_failures":0,"checkpoint_hits":0,"checkpoint_stores":0,"conversations":0,"enabled":false,"evictions":0,"held_gb":0,"held_images":0,"held_tokens":0,"hits":0,"max_conversations":4,"max_tokens":0,"misses":0,"persistent_hits":0,"reusable_checkpoints":0},"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":84934656,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":0,"contextArithmetic":"standard","decodeForwardPasses":15,"decodeIOSeconds":0.51791155599999938,"decodeLocalVictims":0,"decodeModelTokens":15,"decodeReadBytes":4725043200,"decodeRecords":1709,"decodeScatterSeconds":0,"decodeSeconds":1.8056809579999999,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":613,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":16,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":46080,"embeddingCachedRows":32,"embeddingRowHits":37,"embeddingRowMisses":32,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.44833333333333331,"expertPrefetch":{"adopted":2263,"adoptedBytes":6256742400,"adoption":"slot","adoptSeconds":0.053277721999999937,"arrivalIssues":665,"cancelled":5,"candidates":2871,"capRefusals":0,"deferredLaneAcquisitions":2871,"demandBatches":613,"demandMisses":1698,"dirtyRescans":0,"expired":603,"failed":0,"forecastBuildSeconds":0.011741703999999997,"forecastEvalSeconds":0.55310598199999905,"forecastMerged":2871,"forecastPasses":15,"forecastSeconds":0.02433007299999999,"forecastSelectSeconds":0.012561413000000016,"forecastTap":"attention-corrected","forecastTargets":705,"issued":2871,"issuedBytes":7937740800,"joinSeconds":0.051948938999999798,"layersComplete":18,"layersWithMisses":702,"mode":"on","passes":15,"peakLiveBytes":0,"pieceModeReads":2871,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":1213,"readShape":"piece","recordReads":0,"scheduleSeconds":0.007488249999999996,"slotEvictedKeys":2257,"slotRefusals":0,"slotReleases":608,"slotReservations":2871,"slotStale":0,"wastedBytes":1675468800},"finishReason":"length","firstTokenSeconds":16.295388750000001,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":912,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":22231875584,"swapins":0,"swapouts":0},"generatorVMBefore":{"reclaimableBytes":21991014400,"swapins":0,"swapouts":0},"gpuKeptAwake":true,"imageEncodeSeconds":2.91e-07,"interTokenSeconds":[0.29619470799999997,0.12533970899999999,0.123419125,0.14454325000000001,0.122093375,0.096575124999999998,0.10263133300000001,0.13701887500000001,0.102003708,0.083930709000000006,0.079005833999999997,0.1017435,0.095787874999999995,0.099850750000000002,0.094925583999999993],"lifetimePhysicalFootprintPeakBytes":8339803376,"lifetimeRSSPeakBytes":3372826624,"memoryPressureCancelled":false,"mlxActiveEndBytes":6004673176,"mlxCacheEndBytes":709379043,"mlxPeakMemoryGB":7.9795652600000002,"ngramCachedRows":7408,"ngramCachePayloadBytes":2370560,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.31464808700000008,"ngramRowHits":96,"ngramRowMisses":144,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":8.3398033760000008,"physicalFootprintEndBytes":7318689144,"prefillComputeKeyExtents":[256,512,768,1024,1280,1536,1792,2048],"prefillComputePasses":[256,256,256,256,256,256,256,256],"prefillComputeQueryRows":[256,256,256,256,256,256,256,256],"prefillGPUWaitSeconds":2.3563276619999987,"prefillIOSeconds":6.1713115169999995,"prefillLocalVictims":0,"prefillMLXActiveBytes":6095161544,"prefillMLXCacheBytes":540338018,"prefillPasses":[1792,256],"prefillPhysicalFootprintBytes":7224954312,"prefillReadBytes":72678297600,"prefillRecords":26287,"prefillRowSortSeconds":0.006470705999999997,"prefillScatterSeconds":1.4719276259999998,"prefillSeconds":16.258257541999999,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":0,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":2048,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":2,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":1.0708999999999999e-05,"promptTokens":2048,"queueSeconds":2.5582999999999999e-05,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":18.111168459000002,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":104,"ropeTableHits":532,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":8291077360,"samples":907},"sampleSeconds":0.0023809180000000001,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":3.7920000000000003e-06,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"swap_clean":true,"text":"5 filed note 15.\n\n<think>\n\n<\/think>\n\nBased on the data","tokens":2048,"verdict":"OK","warmup":[]}

````
