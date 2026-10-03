---
type: run
created: 2026-10-03T15:10:46.173488+00:00
updated: 2026-10-03T15:10:46.173488+00:00
summary: Paired contiguous-record pilot improves generation within its research scope
binary: 0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Paired contiguous-record pilot improves generation within its research scope
tool: bounded VQ research diagnostics
---

The two independent full-vocabulary validations and all six interleaved measurements complete on the frozen native producer. Every timing meets the frozen observed eligibility rules and produces the same complete 128-token sequence. The composite values, 1536/288 bank capacities, buffered read policy, ten-GB process envelope and original immutable prefill sweep are unchanged. No cell is replaced or retried.

Median committed decode is 5.776163947978307 tokens/s with split ranges and 6.872380896608456 with contiguous records. Median TTFT is 3.0060759580228478 versus 3.007833749987185 seconds, and request duration is 24.993009916011943 versus 21.581774708989542 seconds. Median paired contiguous/split ratios are 1.1897828660167846 for decode, 0.98991835190062 for TTFT and 0.8576591458049302 for request duration. These are separate statistics; a median paired ratio need not equal the ratio of arm medians.

This supports the contiguous representation for continued controlled research. It remains far below twenty tokens/s on this fixed small-budget, short-context, non-speculative workload. No pack is installed, activated, qualified for Auto or promoted to a product default. Original parent filesets remain necessary for this overlay, so it is not a distribution artifact.

The cache-conditioning limitation was documented before timing: candidate-only derived files are authenticated after both parent filesets. OS page-cache history is uncontrolled and load order differs, so this comparison cannot isolate fewer pread calls as the cause, claim cold-SSD throughput, predict standalone-pack behavior or extrapolate to other Macs or memory budgets. Loading is reported separately in every raw receipt and the derived summary.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### capture-vq-contiguous-cost-v1.py

Original bytes: 3692. SHA-256: `2904649da4a2118bbcde2caf80cb97c67706907376284fbc40db2bcbc8f44d59`.

Normalized bytes: 3692. SHA-256: `2904649da4a2118bbcde2caf80cb97c67706907376284fbc40db2bcbc8f44d59`.

````text
from pathlib import Path
import runpy,json,hashlib,statistics
r=Path('.build/quantization-research');a='vq-contiguous-cost-v1';d=json.loads((r/a/'run.json').read_text());assert d['complete'] and d['all_observed_timings_eligible'] and len(d['runs'])==8
for path,sha in d['bound_files'].items():assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==sha
helper=runpy.run_path(str(r/'capture-vq-kernel-cache-v1.py'))
files=['capture-vq-contiguous-cost-v1.py','vq-contiguous-load-order-limitation-v1.json',a+'.log',a+'/run.json',a+'/split-profile.json',a+'/contiguous-profile.json','vq_contiguous_expert_pilot.py','vq_contiguous_expert_test.py','vq-pilot-admission-observer-v1/build.json','vq-pilot-admission-observer-v1/observer.swift']
sequences=[];extra={}
for row in d['runs']:
 name=row['name'];p=r/a/name/'receipt.json';j=json.loads(p.read_text());files += [a+'/'+name+'-admission.json',a+'/'+name+'/receipt.json']+helper['supervision'](a+'/'+name+'-supervision')
 if row['measurement']:
  sequences.append(j['generated']);extra.setdefault(row['arm'],[]).append({k:j[k] for k in ['load_seconds','metadata_seconds','peak_process_bytes','cache_after']})
assert len(sequences)==6 and all(s==sequences[0] and len(s)==128 for s in sequences)
summary={arm:{'median_load_seconds':statistics.median(x['load_seconds'] for x in rows),'median_metadata_seconds':statistics.median(x['metadata_seconds'] for x in rows),'peak_process_bytes':max(x['peak_process_bytes'] for x in rows),'loads':[x['cache_after']['loads'] for x in rows],'hits':[x['cache_after']['hits'] for x in rows]} for arm,rows in extra.items()}
(r/'vq-contiguous-cost-derived-v1.json').write_text(json.dumps(summary,indent=2)+'\n');files+=['vq-contiguous-cost-derived-v1.json']
helper['capture']('native-vq-contiguous-record-paired-cost','Paired contiguous-record pilot improves generation within its research scope', '''The two independent full-vocabulary validations and all six interleaved measurements complete on the frozen native producer. Every timing meets the frozen observed eligibility rules and produces the same complete 128-token sequence. The composite values, 1536/288 bank capacities, buffered read policy, ten-GB process envelope and original immutable prefill sweep are unchanged. No cell is replaced or retried.

Median committed decode is 5.776163947978307 tokens/s with split ranges and 6.872380896608456 with contiguous records. Median TTFT is 3.0060759580228478 versus 3.007833749987185 seconds, and request duration is 24.993009916011943 versus 21.581774708989542 seconds. Median paired contiguous/split ratios are 1.1897828660167846 for decode, 0.98991835190062 for TTFT and 0.8576591458049302 for request duration. These are separate statistics; a median paired ratio need not equal the ratio of arm medians.

This supports the contiguous representation for continued controlled research. It remains far below twenty tokens/s on this fixed small-budget, short-context, non-speculative workload. No pack is installed, activated, qualified for Auto or promoted to a product default. Original parent filesets remain necessary for this overlay, so it is not a distribution artifact.

The cache-conditioning limitation was documented before timing: candidate-only derived files are authenticated after both parent filesets. OS page-cache history is uncontrolled and load order differs, so this comparison cannot isolate fewer pread calls as the cause, claim cold-SSD throughput, predict standalone-pack behavior or extrapolate to other Macs or memory budgets. Loading is reported separately in every raw receipt and the derived summary.''',files,'vq-contiguous-build-v1/candidate')
print(json.dumps(summary))
````

### vq-contiguous-load-order-limitation-v1.json

Original bytes: 511. SHA-256: `9d980aa8ed3bfa5ce413a51e60a15660f0bfc443ab205beeb15975d90e8dce73`.

Normalized bytes: 511. SHA-256: `9d980aa8ed3bfa5ce413a51e60a15660f0bfc443ab205beeb15975d90e8dce73`.

````text
{
  "schema": 1,
  "status": "prospective interpretation constraint before timing",
  "authentication_order": [
    "parent VQ main payloads",
    "baseline dense overlay source files",
    "candidate-only derived expert files"
  ],
  "caveat": "The last derived-file pass changes OS file-cache conditioning. No purge is performed. Compare complete research load/request paths only; do not attribute a difference exclusively to fewer pread calls or project it to a standalone pack.",
  "qualification": false
}
````

### vq-contiguous-cost-v1.log

Original bytes: 4199. SHA-256: `e43d4c93d042b6488a870787f217d0308034b0204b97afe10754d8fab8d3998b`.

Normalized bytes: 4199. SHA-256: `e43d4c93d042b6488a870787f217d0308034b0204b97afe10754d8fab8d3998b`.

````text
{"name": "validation-split", "arm": "split", "measurement": false, "receipt_sha256": "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90", "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63", "committed_tokens": 16, "committed_decode_tokens_per_second": 5.24757069301845, "ttft_seconds": 3.115125292009907, "request_seconds": 5.973610583023401, "peak_process_bytes": 7815420096, "observed_timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens"], "stop": "length"}
{"name": "validation-contiguous", "arm": "contiguous", "measurement": false, "receipt_sha256": "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66", "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63", "committed_tokens": 16, "committed_decode_tokens_per_second": 6.152442975376083, "ttft_seconds": 2.976860416994896, "request_seconds": 5.414939291978953, "peak_process_bytes": 7837800616, "observed_timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens"], "stop": "length"}
{"name": "round-1-split", "arm": "split", "measurement": true, "receipt_sha256": "cc1a75fb939035a6aac4a79ccd818333654442ab5f46b6020ab759a8c080ee7e", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.781810497022112, "ttft_seconds": 2.9906116250203922, "request_seconds": 24.956068917002995, "peak_process_bytes": 7728683056, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-1-contiguous", "arm": "contiguous", "measurement": true, "receipt_sha256": "34cfe4358dc32fed8b9dbdd1937eb937cfb72db63d7f06eec1f242307bb80f67", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 6.875748834833812, "ttft_seconds": 2.9330649170151446, "request_seconds": 21.403800750005757, "peak_process_bytes": 7756028000, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-2-contiguous", "arm": "contiguous", "measurement": true, "receipt_sha256": "73b64259ae8ad428e97cc02e830117b2a139df8776334fc45614957520bea7df", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 6.872380896608456, "ttft_seconds": 3.1019891249889042, "request_seconds": 21.581774708989542, "peak_process_bytes": 7782275240, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-2-split", "arm": "split", "measurement": true, "receipt_sha256": "9f5c31e531fcb97b61a68ca59928433a57a3164440fc8fa57ea3ad55d2369df1", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.776163947978307, "ttft_seconds": 3.0060759580228478, "request_seconds": 24.993009916011943, "peak_process_bytes": 7750785096, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-3-split", "arm": "split", "measurement": true, "receipt_sha256": "e6d8458ca128ab9e0f019846e5730fdbde3cc3bdd49e90f48d00d2203d8e7db7", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.653798811626359, "ttft_seconds": 3.0384665000019595, "request_seconds": 25.501258916017832, "peak_process_bytes": 7742904368, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-3-contiguous", "arm": "contiguous", "measurement": true, "receipt_sha256": "6425427b617f283debff3cb25d74358e64e02b2accefbf55fcb8bbeca96cb519", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 6.767174753158532, "ttft_seconds": 3.007833749987185, "request_seconds": 21.77492270898074, "peak_process_bytes": 7760713800, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
````

### vq-contiguous-cost-v1/run.json

Original bytes: 63477. SHA-256: `11dd70643b66beeb7c037892ee2bfccf4a45a4a8825d8460203402fa47a1a97e`.

Normalized bytes: 63239. SHA-256: `91690ae4f0123ac6d50be3656939a42e81001885c0106b45cc7b988206bbe09e`.

````text
{
  "schema": 1,
  "scope": "Same-composite split tensor ranges versus lossless aligned contiguous expert records at unchanged banks and process ceiling",
  "qualification": "unproven",
  "complete": true,
  "started_at": "2026-10-03T14:53:49.733199+00:00",
  "producer": {
    "binary_sha256": "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "build": {
    "binary": "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "identity": {
      "source": {
        "Licenses/VQLab-Apache-2.0.txt": "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30",
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
        "Sources/Slotstream/Checkpoint.swift": "361b54ab482ab1b08debf846148d16fb811ee3550cb8ca1ae7526dc9b825e04b",
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
        "Sources/Slotstream/Layers.swift": "a1e16af9d664959605f2e135f08c6a8c9c8188cbe08044317e0d5ca023d51031",
        "Sources/Slotstream/MTP.swift": "973fded18e26361262bb635a3e9dbfa1b8e3f8281dfda8682904638096c8fca2",
        "Sources/Slotstream/MTPExpertStream.swift": "391b13fed457ba61a7cb4e107472a699ba87adc9a57cfd14580faa2dfbe50fd7",
        "Sources/Slotstream/Machine.swift": "34bffbaad9bd1a80f8d8aacc6b1abbbfa2d616690546a2a709363c4fb44033f6",
        "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
        "Sources/Slotstream/Model.swift": "1048ad7bcd1c9f93f5316465ed38d7bd93046fe4bfbd0fc138d972e646ee12ab",
        "Sources/Slotstream/NgramHash.swift": "62427b29d24b3638799197cbc45cf46b708e67bdc93b0bc30677a67d6bea8f6e",
        "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
        "Sources/Slotstream/NgramStore.swift": "361e9668f5e18558aae83045dccdad7a6db6a14a1fa269e22761c6ec4b41f791",
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
        "Sources/Slotstream/VQArithmetic.swift": "082e36a7c98a0b5ac7bf88a416f62c28622f73726daebc0fdb3097026530385d",
        "Sources/Slotstream/VQBankAdmission.swift": "9d075656ac572e5e721e8a22e5f898d4f766af844362bd590114138cf155c592",
        "Sources/Slotstream/VQCheckpoint.swift": "932755373957740dd6209140206504d7d307c5eb65f29f2ee33715acae552cae",
        "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
        "Sources/Slotstream/VQDenseOverlay.swift": "0102f31346cb84048b551265696cd4bcf4dd7f2a73c60be6840d654f9c4a2978",
        "Sources/Slotstream/VQExpert.swift": "b62435a1dec9cde5dd294db83909ea2b559554fed284f028df50cd0c92d682cb",
        "Sources/Slotstream/VQExpertKernels.swift": "3d0a9c22935d8984583ea59cf94a923f31ac03f8944ae570abb0b6b9749ded86",
        "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
        "Sources/Slotstream/VQModelProbe.swift": "4425a383cfce125065b3ba829272e640837596de3c0bc2e7f6940866c9de55e8",
        "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
        "Sources/Slotstream/VQPackedExperts.swift": "0952098135ade973559d16d131267eb27dd081f70814aa1b36b6e25992214e37",
        "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
        "Sources/Slotstream/VQRecord.swift": "3688d7bdaf9730e0cfd13635ac550706539585c91edaae9a13336e6e63db2616",
        "Sources/Slotstream/VQRecordBank.swift": "61d399967fa738ff864c544972adc0c57e07de60516a0afa49091adc2c231ce9",
        "Sources/Slotstream/VQRecordCache.swift": "c455334e4817587d1070dc13a6bc9172404db6d28eae5e205a2a4493356b44b8",
        "Sources/Slotstream/VQRecordReadBatch.swift": "6fdd78eaccd27b125d690782b7920a00226e60917f4dcfa05ada19e4bc57fc4e",
        "Sources/Slotstream/VQRecordReadPlan.swift": "588c8e0df5e917421252a2adb7352b1fb7f1fdf367b7e98247d8a8d497371ecb",
        "Sources/Slotstream/VQResidentText.swift": "4ac08a39de539afef273d7925779a9ce175319d21bf6c44b3205ef20393c9592",
        "Sources/Slotstream/VQRotaryTable.swift": "effaca0017e9bf7047f181e4e63de212aa64e6e3531278902b7d6353bcd619c1",
        "Sources/Slotstream/VQRouteStream.swift": "b4bf62f52ffe7cc3a8a6daece599f2fb077b65da2e5911f5f273f8d414e487ab",
        "Sources/Slotstream/VQTensorFile.swift": "34f45b06649d2c1ca11df11d887f7b48b51ae828cd03a074c9ed69e933fae52f",
        "Sources/Slotstream/VQTrunkProbe.swift": "43f7ec7848b35b30b8164bfcad44469dc79c249a318a4b36d33699584bac614f",
        "Sources/Slotstream/Vendored/GatedDelta.swift": "1e0edf00c535c1aa605b996f83bd4f3f39d14a628f0f8a2d21667f069d823175",
        "Sources/Slotstream/VerifyPassSelfCheck.swift": "4355a74e73b967e6331dc2d780aa506ccccc6655df253a593cd24a3276325ded",
        "Sources/Slotstream/Version.swift": "d68b6b9f343402041c33452b885eebce140773cc26379b4adaae996640427b40",
        "Sources/Slotstream/Vision.swift": "639b5c4bbe05654db411d587f31e7962d3db857aa4be38a2b54f982199d51eb5",
        "Sources/Slotstream/VisionAttention.swift": "e8564b8cd946a6b049b3702a91f4441f18a7c3c51f19fae7f31c3cfa92522d25",
        "Sources/Slotstream/VisionPrompt.swift": "561ecd55588533a21571eea4deaa820b7e906b9d228ee002d6bfa9918dfd45a9",
        "Sources/Slotstream/WeightDownload.swift": "869b1ff398417f5aeebd57cb938feaf6829196f67a4ef1d254bb7bf138675673",
        "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
        "Sources/Slotstream/Weights.swift": "01fb2c61390e6b7585eb80a34bf53a8c460fb6258908d57a3c1ed1fa77ec3ce8",
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
        "Sources/SlotstreamDiagnostics/Diagnostics+MixedDense.swift": "49be3469ae5e4ebdab68d313e338bdf094006530727cb030f56caef0dc3edf41",
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
        "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "3ddc642d68968ec4b3338ca9c2798e7e102dadbd18978382ddf402eeefd5a2d6",
        "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationBench.swift": "7037fa0693746e35b91d146180e74883ccdbfabcbe54df8e970948c177f54ad1",
        "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationFixtures.swift": "54a402b5a76d4abf8901c25e7428124d84eeee488acf4d9a65335d7858da733f",
        "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationLogits.swift": "a4dd86379bb4053fb1b8cee917a0cd88b3942de7805c1cf528a8d6924b84b915",
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
        "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "defd0b98fc8730c9c146000036bf9436c06c5480d356a4f8ce9722091b1e1408",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQBank.swift": "01911150249e70d8dddb155884f105b7bcf8fa4902c97b3f7bc14064900e1f5b",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "92b4ccad53dae57a23db4fb996db7e7a6e08b395c3c3102ebaeebe8e7c17f059",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "1d8139be68d72fbd6eacdbb22de07421abece787fe75e63b2e6623dbc11b66ba",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "0669a24eee258eee4c9dc00fbc88350a62d8654ee5ff89093614a2f96ad79e31",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "11da19085bd0f874b4741a542a298f286bf51091b9170fb8a2cabd4b7e399d4f",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "00b1b87ed24324e89bfee5ad88e3f8f3273ffe8f6e6b3c2e69576ffed65173fe",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQTrunk.swift": "6cd5fbd5d13d1c1f5a59545d1616abd67073bcac096b77da8d03d9a6c9f1d10b",
        "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
        "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "7779c1339db28cce006d300d6bdd41e3e9a27c55314153aa12659c3e11d575b3",
        "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
        "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
        "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
        "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
        "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
        "Sources/SlotstreamDiagnostics/VQReferenceExecution.swift": "f0675a955662708dc0e0618169baf112f9a6cf9db82a6cf20d41b8bbf613d35e",
        "Sources/SlotstreamTestKit/AnthropicChecks.swift": "a15f7854d8f2da41184d30fac17f94f1e6e1cb68fd4236eb3c63f60e12714648",
        "Sources/SlotstreamTestKit/AnthropicTurnChecks.swift": "4d585e3ddb8692c1668d065a99c6ff1a56109f6da33328600f646bdc16f43aa5",
        "Sources/SlotstreamTestKit/Catalogue.swift": "08d6e6caedbcba413a576bf3ae01cc3447ca3cd4f701a11bca77b7692e6db714",
        "Sources/SlotstreamTestKit/CodexFixture.swift": "23839d1d776252c1c5cec6a3acaf6c08c1e89bc7def714f7b5f3180fae57aac0",
        "Sources/SlotstreamTestKit/GatewayChecks.swift": "a9e798d056582f4d97554b9131b3f8c7220a37a314312bb3c0e590883c7c8ad4",
        "Sources/SlotstreamTestKit/LaunchChecks.swift": "8fd6f5920b219d68f0ea69295810a0a6b34effdee69ac855b04212399379e54d",
        "Sources/SlotstreamTestKit/OpenAIChecks.swift": "cb813af4c908567161db660aa8c6b78710be6a2b80a97a6e6d90e995ecd8806f",
        "Sources/SlotstreamTestKit/PersistentPrefixChecks.swift": "2a5cc8ffaf4befb90a732f350f84c34f162ad7ca67b0fb50eae3060fdeb0b0b3",
        "Sources/SlotstreamTestKit/PersistentPrefixIOChecks.swift": "c16d39aaf50f66ffa0f4f5fef02937dd141d5ba2ad7f42bcc9f387416d503f2c",
        "Sources/SlotstreamTestKit/PersistentPrefixMetadataChecks.swift": "65b5a45b3954c98517b777039373030f309e0271a6343037c6a452b4e03a82e8",
        "Sources/SlotstreamTestKit/PersistentPrefixRemovalChecks.swift": "a910392fe22933480cba14e3c604933066ba9178b670db4442e8c53b1c79a459",
        "Sources/SlotstreamTestKit/ResponsesChecks.swift": "6f692f86a68f6bbd1f62b6bdc544fdebaba1196e902b58a59313755af68be130",
        "Sources/SlotstreamTestKit/T0Checks.swift": "25bcf4ef6daeb29a31ebfacd2217bf12afb7788672f72c21d13ae7ac41aded97",
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
        "Sources/slotstream-cli/QuantizationCommands.swift": "d692da0260c0f0afbec0494cf60b8470ad8b5354f2419f33c64c12afca9a10d6",
        "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
        "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
        "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
        "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
        "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
        "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
        "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
      },
      "source_archive_sha256": "0f932f8bd1837ed149fccf89c33336ffc82480e25c93935817aca5e9af19fa8e",
      "binary_sha256": "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
      "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
    }
  },
  "source_archive_sha256": "0f932f8bd1837ed149fccf89c33336ffc82480e25c93935817aca5e9af19fa8e",
  "bound_files": {
    "<HOME>/Projects/slotstream/Tools/vq_contiguous_expert_pilot.py": "7c1d397a863db72b3e4b3bb6d7aaa703d4f3f6b7aaeaad54194dffac882dd5d6",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json": "4cdae0e9c26b9a0dd07659cd9d71dd025ed110b49161c152df09d5a7f75ac28b",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1/manifest.json": "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
    "<HOME>/Projects/slotstream/bench/quantization/dense-reinvestment-cost-v1.json": "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
    "<HOME>/Projects/slotstream/bench/quantization/contiguous-record-cost-v1.json": "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/run.json": "4ad53986f7c651d2e11c697d5d8b3d1b1e0292420268ba317d1c97435d435019",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/greedy-control/receipt.json": "b71aa46bb805867e8c275376ca6c4f854e82aadd0f2ed370557f8823bb171325",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/greedy-control-supervision/identity.json": "77b27d5caebd0de238c1db375b9312e1cd6860dbab9bd46d3c17f50980ca7f40",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/greedy-control-supervision/receipt.json": "48a1ff5a7e5268091390fd3ed30502698d9e01990a098373b3499cad86070719",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/greedy/receipt.json": "c8446081c77721c02af578c7040fba1598cc0fdfb642b387aaee45e5d5f734f6",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/greedy-supervision/identity.json": "2687294c1b3d15f2e32c72dffdcfcb0817c67de618747d51ad0416a76ebb8c9b",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/greedy-supervision/receipt.json": "f0f2b0b28585f5dce00491be9bb1fcb87f9ab74e070dbfbcdcf180e53f8e7abd",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/sparse-control/receipt.json": "c32b55245b57c58a247c52aa9b4299a682fc688a0eda4f7a870d74fc6f6ccede",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/sparse-control-supervision/identity.json": "d2bd4554923ec42c4fdd65526e03c845b0766288ff8433ff743d075a469584f6",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/sparse-control-supervision/receipt.json": "b2e6c89ea5c78d3fa192b83e0daafefa8575afb2b2e1635f9c130fda952ab470",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/sparse/receipt.json": "f20e9c175a84b08a81e31bd584c7c1aa24f3522f6482a075e1ac7c868fb20c63",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/sparse-supervision/identity.json": "7879b43c6ebd4e958acc3b2208be8ab785f92d3bcf9946edd0cf1e170bac9e9f",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-expert-v1/sparse-supervision/receipt.json": "545a9f19691bf3ca6c81f81e99162e3d60c957723c5e44856a81d2d7b523e9ae",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-pilot-admission-observer-v1/observer": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-pilot-admission-observer-v1/observer.swift": "1370c1be3803c5a36a2f5a3a2aab86dad29cbcf752bb397220246662c8186944",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-pilot-admission-observer-v1/build.json": "3636a4917670c357536cdfd2c5869620b7db56751fa0b702e6b7f6c77634a78c",
    "<HOME>/Projects/slotstream/Tools/prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
    "<HOME>/Projects/slotstream/Tools/memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc",
    "<HOME>/Projects/slotstream/Tools/context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34",
    "<HOME>/Projects/slotstream/Tools/quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb",
    "<HOME>/Projects/slotstream/Tools/vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
    "<HOME>/Projects/slotstream/Tools/vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
    "<HOME>/Projects/slotstream/Tools/vq_execution_profile.py": "0e298b9a73df41d55e1191ffdcbf5cc778112e7dae309e6a3b647080c1f4ce91",
    "<HOME>/Projects/slotstream/Tools/quantization_logit_run.py": "2caeb49d8b008a31ca981db7eedcd1eaa374c0b7cd106139895519d4528e2f88",
    "<HOME>/Projects/slotstream/Tools/vq_pilot_admission.py": "4f04ec13a1a5b807ae23bf00ef86b80786e9614ef4877b43b8462545d5980f68",
    "<HOME>/Projects/slotstream/Tools/serve_bench.py": "95fdf6cfb2791aa71cad527bd6dd46557b9d4fd7874f098509e9b8e02943c5c7",
    "<HOME>/Projects/slotstream/Tools/vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
    "<HOME>/Projects/slotstream/Tools/vq_dense_overlay.py": "34d3ed2bf55371cbc3472c48e54cd3c5b0006ba9dbfe6289b6506511b5477684"
  },
  "admission": {
    "required_stable_seconds": 30,
    "maximum_wait_seconds_per_cell": 600,
    "scope": "Sampled idle precondition before every validation and measurement; no change to native or in-request checks"
  },
  "maximum_runs": 8,
  "campaign_timeout_seconds": 14400,
  "run_timeout_seconds": 1800,
  "maximum_process_bytes": 10000000000,
  "minimum_reclaimable_bytes": 13000000000,
  "retry_policy": "No automatic retry; retain failure",
  "paid_compute": false,
  "runs": [
    {
      "name": "validation-split",
      "arm": "split",
      "measurement": false,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7815420096,
        "samples": 1134,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24596217856,
          "swapins": 40,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   473433.\nPages active:                                 848939.\nPages inactive:                               798763.\nPages speculative:                             75918.\nPages throttled:                                   0.\nPages wired down:                             182385.\nPages purgeable:                                3746.\n\"Translation faults\":                     1967318943.\nPages copy-on-write:                        99042329.\nPages zero filled:                        3234237468.\nPages reactivated:                         173812468.\nPages purged:                               12732835.\nFile-backed pages:                           1024055.\nAnonymous pages:                              699565.\nPages stored in compressor:                  1312499.\nPages occupied by compressor:                 704070.\nDecompressions:                            102752578.\nCompressions:                              116448612.\nPageins:                                  2283811311.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128745.\nPages tagged resident:                         85712.\nPages tagged compressed:                       43033.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                         1872.\nPages tag-storage non-tag pageable:            91174.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6682112.\nTagged compressions:                          738117.\nTagged decompressions:                        607902.\n"
        },
        "seconds": 65.76100329199107
      },
      "receipt_sha256": "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90",
      "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 5.24757069301845,
      "ttft_seconds": 3.115125292009907,
      "request_seconds": 5.973610583023401,
      "peak_process_bytes": 7815420096,
      "observed_timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens"
      ],
      "stop": "length"
    },
    {
      "name": "validation-contiguous",
      "arm": "contiguous",
      "measurement": false,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7837800616,
        "samples": 1425,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24627478528,
          "swapins": 40,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475638.\nPages active:                                 840514.\nPages inactive:                               791012.\nPages speculative:                             78431.\nPages throttled:                                   0.\nPages wired down:                             179141.\nPages purgeable:                                4837.\n\"Translation faults\":                     1968868474.\nPages copy-on-write:                        99079680.\nPages zero filled:                        3236758315.\nPages reactivated:                         173888256.\nPages purged:                               12740500.\nFile-backed pages:                           1022667.\nAnonymous pages:                              687290.\nPages stored in compressor:                  1326143.\nPages occupied by compressor:                 719409.\nDecompressions:                            103103560.\nCompressions:                              116844219.\nPageins:                                  2297232491.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128316.\nPages tagged resident:                         87277.\nPages tagged compressed:                       41039.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5243.\nPages tag-storage free:                         1609.\nPages tag-storage non-tag pageable:            91444.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6216896.\nTagged compressions:                          739929.\nTagged decompressions:                        611694.\n"
        },
        "seconds": 82.9089260409819
      },
      "receipt_sha256": "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66",
      "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 6.152442975376083,
      "ttft_seconds": 2.976860416994896,
      "request_seconds": 5.414939291978953,
      "peak_process_bytes": 7837800616,
      "observed_timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens"
      ],
      "stop": "length"
    },
    {
      "name": "round-1-split",
      "arm": "split",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7728683056,
        "samples": 1462,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24741789696,
          "swapins": 40,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470101.\nPages active:                                 862876.\nPages inactive:                               797074.\nPages speculative:                             83711.\nPages throttled:                                   0.\nPages wired down:                             182955.\nPages purgeable:                                 972.\n\"Translation faults\":                     1969890587.\nPages copy-on-write:                        99135825.\nPages zero filled:                        3238844697.\nPages reactivated:                         173941622.\nPages purged:                               12746332.\nFile-backed pages:                           1039046.\nAnonymous pages:                              704615.\nPages stored in compressor:                  1305686.\nPages occupied by compressor:                 688182.\nDecompressions:                            103417747.\nCompressions:                              117181520.\nPageins:                                  2307726077.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 130551.\nPages tagged resident:                         86345.\nPages tagged compressed:                       44206.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          745.\nPages tag-storage non-tag pageable:            92314.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6704512.\nTagged compressions:                          744852.\nTagged decompressions:                        613447.\n"
        },
        "seconds": 84.70533079199959
      },
      "receipt_sha256": "cc1a75fb939035a6aac4a79ccd818333654442ab5f46b6020ab759a8c080ee7e",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.781810497022112,
      "ttft_seconds": 2.9906116250203922,
      "request_seconds": 24.956068917002995,
      "peak_process_bytes": 7728683056,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-1-contiguous",
      "arm": "contiguous",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7756028000,
        "samples": 1695,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24766545920,
          "swapins": 40,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   473352.\nPages active:                                 864395.\nPages inactive:                               851694.\nPages speculative:                             25698.\nPages throttled:                                   0.\nPages wired down:                             181481.\nPages purgeable:                                4753.\n\"Translation faults\":                     1972938147.\nPages copy-on-write:                        99174582.\nPages zero filled:                        3240130578.\nPages reactivated:                         174004929.\nPages purged:                               12757981.\nFile-backed pages:                           1033525.\nAnonymous pages:                              708262.\nPages stored in compressor:                  1300529.\nPages occupied by compressor:                 688333.\nDecompressions:                            103675131.\nCompressions:                              117485633.\nPageins:                                  2321644195.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128072.\nPages tagged resident:                         84226.\nPages tagged compressed:                       43846.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          593.\nPages tag-storage non-tag pageable:            92473.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6706240.\nTagged compressions:                          746391.\nTagged decompressions:                        614272.\n"
        },
        "seconds": 98.53081729100086
      },
      "receipt_sha256": "34cfe4358dc32fed8b9dbdd1937eb937cfb72db63d7f06eec1f242307bb80f67",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 6.875748834833812,
      "ttft_seconds": 2.9330649170151446,
      "request_seconds": 21.403800750005757,
      "peak_process_bytes": 7756028000,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-2-contiguous",
      "arm": "contiguous",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7782275240,
        "samples": 1707,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24693145600,
          "swapins": 40,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   474860.\nPages active:                                 866106.\nPages inactive:                               849676.\nPages speculative:                             29055.\nPages throttled:                                   0.\nPages wired down:                             182502.\nPages purgeable:                                4107.\n\"Translation faults\":                     1976135263.\nPages copy-on-write:                        99227840.\nPages zero filled:                        3242629867.\nPages reactivated:                         174057390.\nPages purged:                               12769728.\nFile-backed pages:                           1028183.\nAnonymous pages:                              716654.\nPages stored in compressor:                  1290212.\nPages occupied by compressor:                 682152.\nDecompressions:                            103975300.\nCompressions:                              117825899.\nPageins:                                  2335878051.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127918.\nPages tagged resident:                         83078.\nPages tagged compressed:                       44840.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                         1231.\nPages tag-storage non-tag pageable:            91863.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6861568.\nTagged compressions:                          747671.\nTagged decompressions:                        614555.\n"
        },
        "seconds": 99.01064729201607
      },
      "receipt_sha256": "73b64259ae8ad428e97cc02e830117b2a139df8776334fc45614957520bea7df",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 6.872380896608456,
      "ttft_seconds": 3.1019891249889042,
      "request_seconds": 21.581774708989542,
      "peak_process_bytes": 7782275240,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-2-split",
      "arm": "split",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7750785096,
        "samples": 1462,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24626249728,
          "swapins": 40,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470828.\nPages active:                                 857557.\nPages inactive:                               786502.\nPages speculative:                             87424.\nPages throttled:                                   0.\nPages wired down:                             195356.\nPages purgeable:                                 615.\n\"Translation faults\":                     1976871621.\nPages copy-on-write:                        99264642.\nPages zero filled:                        3245221450.\nPages reactivated:                         174110855.\nPages purged:                               12777246.\nFile-backed pages:                           1031624.\nAnonymous pages:                              699859.\nPages stored in compressor:                  1293888.\nPages occupied by compressor:                 686310.\nDecompressions:                            104201163.\nCompressions:                              118103034.\nPageins:                                  2346366784.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127969.\nPages tagged resident:                         83506.\nPages tagged compressed:                       44463.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1778.\nPages tag-storage non-tag pageable:            91318.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6786240.\nTagged compressions:                          748681.\nTagged decompressions:                        615453.\n"
        },
        "seconds": 84.63221937499475
      },
      "receipt_sha256": "9f5c31e531fcb97b61a68ca59928433a57a3164440fc8fa57ea3ad55d2369df1",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.776163947978307,
      "ttft_seconds": 3.0060759580228478,
      "request_seconds": 24.993009916011943,
      "peak_process_bytes": 7750785096,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-3-split",
      "arm": "split",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7742904368,
        "samples": 1471,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 22694936576,
          "swapins": 40,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   354891.\nPages active:                                 868552.\nPages inactive:                               796032.\nPages speculative:                             82870.\nPages throttled:                                   0.\nPages wired down:                             298914.\nPages purgeable:                                5136.\n\"Translation faults\":                     1977699499.\nPages copy-on-write:                        99308626.\nPages zero filled:                        3247779112.\nPages reactivated:                         174170951.\nPages purged:                               12783102.\nFile-backed pages:                           1025162.\nAnonymous pages:                              722292.\nPages stored in compressor:                  1286421.\nPages occupied by compressor:                 683181.\nDecompressions:                            104442584.\nCompressions:                              118384982.\nPageins:                                  2356535012.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128022.\nPages tagged resident:                         83785.\nPages tagged compressed:                       44237.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                         1066.\nPages tag-storage non-tag pageable:            92031.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740480.\nTagged compressions:                          748715.\nTagged decompressions:                        615709.\n"
        },
        "seconds": 85.08001970799523
      },
      "receipt_sha256": "e6d8458ca128ab9e0f019846e5730fdbde3cc3bdd49e90f48d00d2203d8e7db7",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.653798811626359,
      "ttft_seconds": 3.0384665000019595,
      "request_seconds": 25.501258916017832,
      "peak_process_bytes": 7742904368,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-3-contiguous",
      "arm": "contiguous",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7760713800,
        "samples": 1724,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 22346629120,
          "swapins": 44,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   366986.\nPages active:                                 848632.\nPages inactive:                               829264.\nPages speculative:                             30443.\nPages throttled:                                   0.\nPages wired down:                             311615.\nPages purgeable:                                 796.\n\"Translation faults\":                     1981531104.\nPages copy-on-write:                        99498867.\nPages zero filled:                        3250733369.\nPages reactivated:                         174253840.\nPages purged:                               12793374.\nFile-backed pages:                            996148.\nAnonymous pages:                              712191.\nPages stored in compressor:                  1309595.\nPages occupied by compressor:                 697605.\nDecompressions:                            104711311.\nCompressions:                              118722359.\nPageins:                                  2370475832.\nPageouts:                                     489440.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 131383.\nPages tagged resident:                         87512.\nPages tagged compressed:                       43871.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5198.\nPages tag-storage free:                          858.\nPages tag-storage non-tag pageable:            92240.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6661952.\nTagged compressions:                          748804.\nTagged decompressions:                        616154.\n"
        },
        "seconds": 99.78733949997695
      },
      "receipt_sha256": "6425427b617f283debff3cb25d74358e64e02b2accefbf55fcb8bbeca96cb519",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 6.767174753158532,
      "ttft_seconds": 3.007833749987185,
      "request_seconds": 21.77492270898074,
      "peak_process_bytes": 7760713800,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    }
  ],
  "all_observed_timings_eligible": true,
  "medians": {
    "split": {
      "committed_decode_tokens_per_second": 5.776163947978307,
      "ttft_seconds": 3.0060759580228478,
      "request_seconds": 24.993009916011943
    },
    "contiguous": {
      "committed_decode_tokens_per_second": 6.872380896608456,
      "ttft_seconds": 3.007833749987185,
      "request_seconds": 21.581774708989542
    }
  },
  "paired_ratios": {
    "committed_decode_tokens_per_second": [
      1.1892034231103088,
      1.1897828660167846,
      1.196925284862038
    ],
    "ttft_seconds": [
      0.9807575455389146,
      1.0319064349355764,
      0.98991835190062
    ],
    "request_seconds": [
      0.8576591458049302,
      0.8635124293358132,
      0.853876382365715
    ]
  },
  "median_paired_ratios": {
    "committed_decode_tokens_per_second": 1.1897828660167846,
    "ttft_seconds": 0.98991835190062,
    "request_seconds": 0.8576591458049302
  },
  "finished_at": "2026-10-03T15:09:34.408628+00:00"
}
````

### vq-contiguous-cost-v1/split-profile.json

Original bytes: 9228. SHA-256: `87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8`.

Normalized bytes: 9228. SHA-256: `87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8`.

````text
{
  "checkpoint": "Qwen/Qwen3.8-Flash-Next",
  "checkpoint_revision": "de4b8e4d43b917e7706784d8bb445c9af86a3540",
  "tokenizer_sha256": "0997f410c57a1f4e53b09e4be8f4a172d90edd9564368fb0847030937229b9f3",
  "text": "<|im_start|>user\nExplain in two short paragraphs how a local mixture-of-experts model can use SSD streaming when its weights exceed RAM. Distinguish a saved memory ceiling from current allocation.<|im_end|>\n<|im_start|>assistant\n<think>\n",
  "text_sha256": "2423950dce73c0bee4a35e59a45904858ccc85bce5d661610e74b6905a2f828a",
  "prompt": [
    248045,
    846,
    198,
    814,
    20139,
    303,
    1330,
    2716,
    41228,
    1204,
    264,
    2136,
    20340,
    8404,
    17830,
    15089,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    13,
    414,
    85596,
    264,
    6568,
    4779,
    21482,
    494,
    1428,
    23014,
    13,
    248046,
    198,
    248045,
    74455,
    198,
    248068,
    198
  ],
  "sampling": "argmax-first-index",
  "eos_token_id": 248044,
  "schema": 1,
  "profile": "vq32-dense-reinvestment-cost-pilot-v1",
  "scope": "Same-artifact fixed-cache reinvestment at an unchanged process ceiling; require identical generated sequences across all arms",
  "max_new_tokens": 128,
  "minimum_committed_tokens": 64,
  "validation_steps": 16,
  "configuration": {
    "resident_text": true,
    "main_bank_records": 1536,
    "secondary_bank_records": 288,
    "mtp": false,
    "vision": false,
    "context_limit": 2054,
    "process_bound_bytes": 10000000000,
    "parallel_read_lanes": 12,
    "maximum_read_staging_bytes": 128000000,
    "reinvest_dense_savings": true
  },
  "resources": {
    "validation_runs": 2,
    "timing_runs": 6,
    "run_timeout_seconds": 1800,
    "minimum_reclaimable_bytes": 13000000000,
    "minimum_remaining_headroom_bytes": 3000000000,
    "additional_weights_bytes": 0,
    "paid_compute_usd": 0
  },
  "rounds": [
    [
      "control",
      "reinvest"
    ],
    [
      "reinvest",
      "control"
    ],
    [
      "control",
      "reinvest"
    ]
  ],
  "protocol": {
    "validation": "Separate process verifies all sixteen complete Float32 vocabulary arrays and autoregressive samples against the pinned independent greedy reference with state observation disabled. Required before measurement for this exact binary, metallib, profile and inventory.",
    "cache_state": "All 138 main payloads are fully authenticated through owned descriptors before the request. New model state and empty expert banks per process; resident text loaded before request. OS page cache is uncontrolled after these reads and is not described as cold SSD. No warmup generation.",
    "timer": "Monotonic request start immediately before first forward; emission after forward returns and sample is ready. TTFT is first committed emission minus request start. Committed decode rate is (emitted non-EOS tokens minus one) / (last committed emission minus first committed emission). Report total request and load durations separately; EOS and setup are excluded from decode numerator.",
    "observation": "Full state/logit hashing and trace callbacks disabled in measurement. Existing finite checks, headroom checks, cache arithmetic and synchronization retained. Operating conditions observed between emissions and included in inter-emission time. Demanded cache-miss reads use at most twelve CPU lanes, complete within the fixed staging reservation and join before serialized cache publication. Large immutable prefill is unchanged.",
    "eligibility": "No paging increase during request, nominal observed thermal state, low-power mode off, at least 64 committed tokens, no development overrides, independent supervision completed and preflight excludes competing model/compiler jobs; operator reviews the task list and runs no storage study during the pilot. Preserve ineligible runs, no replacement runs or best-of selection.",
    "comparison": "Same composite, prompt, binary, process ceiling and reference for both arms. Require identical complete generated sequences across all six timings. Report every run and paired medians only if all six are eligible. No product or 20 tokens/s qualification."
  },
  "references": {
    "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645": {
      "pack": "3.2-dense-affine4",
      "generated": [
        760,
        1156,
        369,
        9859,
        883,
        1204,
        264,
        2136,
        380,
        12370,
        8404,
        12,
        83167,
        318,
        24797,
        36
      ],
      "logits": [
        {
          "shape": [
            1,
            44,
            248320
          ],
          "dtype": "F32",
          "bytes": 43704320,
          "sha256": "b9b6d6b68a127c9332acd50b6775b9139ba38781e87fa2f20abc0ddcc2311213"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "f595a7c1f7e431bb42f76a81b05d9d0b39147775cd7cbde24b6a34687289a135"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "1980728aacdaab38f9ad707dc9bd00da8efe4e754a0ecae5c325dc263ca75b2e"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "b2c1a66f36cdbb37f562f19f78647d149f6d446ff4a09fe5a10593851dd57244"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "1836cab6617d6e1514aeee53c411a3a383128b51ecf953310c6977df1ac6c6d3"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "ddf90e28ce313f5cb87bfa15e1f863d197b134053dced7208214a7e6b151672d"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "07b910ef6f36a24bbf9f73de8df0530c3ceea51aef574ada3ff48c31d7bc8913"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "bff4ded7b410f4ee57dab02296ba32b7b557eed95531ca5cafbfa02e8f58e28c"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "3a217d5ac63612addd51ec04490d94b3736cded603f196f4a463fdba9e876f74"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "79c3ba8397db461129f32e86cbe613afb3fdcd6f9c981ef1627649a2dac3fc8c"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5abce2984079fa5ae52337b69e8f36d1160fcd515b52c8c71ce0252a65526f64"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "c6cd56cad6c7ec11114d55a2a5870c81fe64e919d934db7c5c66cd1a348f434e"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5edff1c86257005485a4ed84f26a5d7ade358fd2a2abe22f1100ebeaa5ed23b9"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5a87cddfcab3c7e13235b0b4fe2addcc8fce91e7fb06e8f852ec9b38f19590db"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "80e7d09b6eb40985515d49faeb968c30df11220570e32f7bf935780e7522eafe"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "702a8118a41efe6d74eed9d029570eef782ef4f47d720b1d82f1ac8934cd1bfe"
        }
      ]
    }
  },
  "reference_provenance": {
    "parent_profile_sha256": "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
    "composite_fixture_sha256": "10003d625b179bdddfb6bd03d7544f1becf27f5beec2551cb71467af7639b68d",
    "composite_sha256": "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645"
  },
  "adoption": {
    "complete_configuration_qualification": false,
    "purpose": "Measure the fixed 1536/288 bank hypothesis only after full greedy and sparse boundary parity plus physical slot coverage at this same ten-GB bound."
  },
  "control_profile_sha256": "a1b2edc29e0b1a5a3a668d9b8c26ff8533523f0045e98970e5e5efc54badaa88"
}
````

### vq-contiguous-cost-v1/contiguous-profile.json

Original bytes: 9684. SHA-256: `99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c`.

Normalized bytes: 9684. SHA-256: `99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c`.

````text
{
  "checkpoint": "Qwen/Qwen3.8-Flash-Next",
  "checkpoint_revision": "de4b8e4d43b917e7706784d8bb445c9af86a3540",
  "tokenizer_sha256": "0997f410c57a1f4e53b09e4be8f4a172d90edd9564368fb0847030937229b9f3",
  "text": "<|im_start|>user\nExplain in two short paragraphs how a local mixture-of-experts model can use SSD streaming when its weights exceed RAM. Distinguish a saved memory ceiling from current allocation.<|im_end|>\n<|im_start|>assistant\n<think>\n",
  "text_sha256": "2423950dce73c0bee4a35e59a45904858ccc85bce5d661610e74b6905a2f828a",
  "prompt": [
    248045,
    846,
    198,
    814,
    20139,
    303,
    1330,
    2716,
    41228,
    1204,
    264,
    2136,
    20340,
    8404,
    17830,
    15089,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    13,
    414,
    85596,
    264,
    6568,
    4779,
    21482,
    494,
    1428,
    23014,
    13,
    248046,
    198,
    248045,
    74455,
    198,
    248068,
    198
  ],
  "sampling": "argmax-first-index",
  "eos_token_id": 248044,
  "schema": 1,
  "profile": "vq32-contiguous-record-cost-pilot-v1",
  "scope": "Same-composite split tensor ranges versus lossless aligned contiguous expert records at unchanged banks and process ceiling",
  "max_new_tokens": 128,
  "minimum_committed_tokens": 64,
  "validation_steps": 16,
  "configuration": {
    "resident_text": true,
    "main_bank_records": 1536,
    "secondary_bank_records": 288,
    "mtp": false,
    "vision": false,
    "context_limit": 2054,
    "process_bound_bytes": 10000000000,
    "parallel_read_lanes": 12,
    "maximum_read_staging_bytes": 128000000,
    "reinvest_dense_savings": true,
    "packed_records": true,
    "uncached_expert_reads": false
  },
  "resources": {
    "validation_runs": 2,
    "timing_runs": 6,
    "run_timeout_seconds": 1800,
    "minimum_reclaimable_bytes": 13000000000,
    "minimum_remaining_headroom_bytes": 3000000000,
    "additional_weights_bytes": 47866183680,
    "paid_compute_usd": 0
  },
  "rounds": [
    [
      "split",
      "contiguous"
    ],
    [
      "contiguous",
      "split"
    ],
    [
      "split",
      "contiguous"
    ]
  ],
  "protocol": {
    "validation": "Separate process verifies all sixteen complete Float32 vocabulary arrays and autoregressive samples against the pinned independent greedy reference with state observation disabled. Required before measurement for this exact binary, metallib, profile and inventory.",
    "cache_state": "All 138 main payloads are fully authenticated through owned descriptors before the request. New model state and empty expert banks per process; resident text loaded before request. OS page cache is uncontrolled after these reads and is not described as cold SSD. No warmup generation. The contiguous arm also authenticates all 48 derived record files before request. Both arms retain buffered reads; original sweep prefill remains unchanged. Additional authentication is included in load time, not decode time.",
    "timer": "Monotonic request start immediately before first forward; emission after forward returns and sample is ready. TTFT is first committed emission minus request start. Committed decode rate is (emitted non-EOS tokens minus one) / (last committed emission minus first committed emission). Report total request and load durations separately; EOS and setup are excluded from decode numerator.",
    "observation": "Full state/logit hashing and trace callbacks disabled in measurement. Existing finite checks, headroom checks, cache arithmetic and synchronization retained. Operating conditions observed between emissions and included in inter-emission time. Demanded cache-miss reads use at most twelve CPU lanes, complete within the fixed staging reservation and join before serialized cache publication. Large immutable prefill is unchanged.",
    "eligibility": "No paging increase during request, nominal observed thermal state, low-power mode off, at least 64 committed tokens, no development overrides, independent supervision completed and preflight excludes competing model/compiler jobs; operator reviews the task list and runs no storage study during the pilot. Preserve ineligible runs, no replacement runs or best-of selection.",
    "comparison": "Same composite values, prompt, binary, process ceiling, buffered OS policy, 1536/288 banks and reference for both arms. Require identical complete generated sequences across all six timings. Report all runs and paired medians only if all six are eligible. No product or 20 tokens/s qualification."
  },
  "references": {
    "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645": {
      "pack": "3.2-dense-affine4",
      "generated": [
        760,
        1156,
        369,
        9859,
        883,
        1204,
        264,
        2136,
        380,
        12370,
        8404,
        12,
        83167,
        318,
        24797,
        36
      ],
      "logits": [
        {
          "shape": [
            1,
            44,
            248320
          ],
          "dtype": "F32",
          "bytes": 43704320,
          "sha256": "b9b6d6b68a127c9332acd50b6775b9139ba38781e87fa2f20abc0ddcc2311213"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "f595a7c1f7e431bb42f76a81b05d9d0b39147775cd7cbde24b6a34687289a135"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "1980728aacdaab38f9ad707dc9bd00da8efe4e754a0ecae5c325dc263ca75b2e"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "b2c1a66f36cdbb37f562f19f78647d149f6d446ff4a09fe5a10593851dd57244"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "1836cab6617d6e1514aeee53c411a3a383128b51ecf953310c6977df1ac6c6d3"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "ddf90e28ce313f5cb87bfa15e1f863d197b134053dced7208214a7e6b151672d"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "07b910ef6f36a24bbf9f73de8df0530c3ceea51aef574ada3ff48c31d7bc8913"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "bff4ded7b410f4ee57dab02296ba32b7b557eed95531ca5cafbfa02e8f58e28c"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "3a217d5ac63612addd51ec04490d94b3736cded603f196f4a463fdba9e876f74"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "79c3ba8397db461129f32e86cbe613afb3fdcd6f9c981ef1627649a2dac3fc8c"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5abce2984079fa5ae52337b69e8f36d1160fcd515b52c8c71ce0252a65526f64"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "c6cd56cad6c7ec11114d55a2a5870c81fe64e919d934db7c5c66cd1a348f434e"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5edff1c86257005485a4ed84f26a5d7ade358fd2a2abe22f1100ebeaa5ed23b9"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "5a87cddfcab3c7e13235b0b4fe2addcc8fce91e7fb06e8f852ec9b38f19590db"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "80e7d09b6eb40985515d49faeb968c30df11220570e32f7bf935780e7522eafe"
        },
        {
          "shape": [
            1,
            1,
            248320
          ],
          "dtype": "F32",
          "bytes": 993280,
          "sha256": "702a8118a41efe6d74eed9d029570eef782ef4f47d720b1d82f1ac8934cd1bfe"
        }
      ]
    }
  },
  "reference_provenance": {
    "parent_profile_sha256": "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
    "composite_fixture_sha256": "10003d625b179bdddfb6bd03d7544f1becf27f5beec2551cb71467af7639b68d",
    "composite_sha256": "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645"
  },
  "adoption": {
    "complete_configuration_qualification": false,
    "purpose": "Measure record layout only after reconstruction of all 288 source tensors and native greedy/sparse parity. A read-layout win does not qualify the model or distribution."
  },
  "control_profile_sha256": "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "packed_manifest_sha256": "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834"
}
````

### vq_contiguous_expert_pilot.py

Original bytes: 14256. SHA-256: `7c1d397a863db72b3e4b3bb6d7aaa703d4f3f6b7aaeaad54194dffac882dd5d6`.

Normalized bytes: 14256. SHA-256: `7c1d397a863db72b3e4b3bb6d7aaa703d4f3f6b7aaeaad54194dffac882dd5d6`.

````text
#!/usr/bin/env python3
"""Same-composite lossless contiguous expert storage at a fixed ten-GB process bound.

Require separately passed greedy/sparse geometry gates and exact sequences
across both arms. This record-layout experiment never promotes a product pack.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import statistics
import sys
import time

from quantization_logit_run import digest, supervise
from vq_pilot_admission import admit, STABLE_SECONDS, MAXIMUM_WAIT_SECONDS
from serve_bench import verified_build
from vq_dense_overlay import IDENTITY_SHA, VQ_INVENTORY

PROFILE_SHAS = {
    'split': '87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8',
    'contiguous': '99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c',
}
ARMS = ('split', 'contiguous')
PACKED_MANIFEST_SHA = '230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834'


def validate_storage(receipt, arm):
    if arm not in ARMS:
        raise ValueError('unknown record-layout arm')
    packed = arm == 'contiguous'
    if (receipt.get('record_storage') != ('contiguous-records-16k-v1' if packed else 'split-tensor-ranges-v1')
            or receipt.get('packed_manifest_sha256') != (PACKED_MANIFEST_SHA if packed else None)
            or receipt.get('packed_verified_files') != (48 if packed else 0)
            or receipt.get('packed_verified_bytes') != (47_866_183_680 if packed else 0)
            or receipt.get('expert_file_read_policy') != 'buffered-v1'
            or receipt.get('uncached_expert_files') != 0):
        raise ValueError('record-layout receipt changed its pinned storage identity or read policy')



def validate_receipt(receipt, arm, profile, producer, *, measurement):
    if arm not in ARMS:
        raise ValueError('unknown record-layout arm')
    validate_storage(receipt, arm)
    factor = 3
    reference = profile['references'][IDENTITY_SHA]
    cache = receipt.get('cache_after', {})
    if (receipt.get('passed') is not True
            or receipt.get('mode') != ('measurement' if measurement else 'validation')
            or receipt.get('profile_sha256') != PROFILE_SHAS[arm]
            or receipt.get('producer') != producer or receipt.get('pack') != '3.2-dense-affine4'
            or receipt.get('inventory_sha256') != VQ_INVENTORY
            or receipt.get('composite_sha256') != IDENTITY_SHA
            or receipt.get('verified_files') != 138 or receipt.get('overlay_verified_files') != 9
            or receipt.get('resident_text', {}).get('payload_bytes') != 2_893_477_400
            or cache.get('parallel_read_lanes') != 12
            or cache.get('total_capacity') != 608 * factor
            or cache.get('reserved_bank_bytes') != 1_194_393_600 * factor
            or cache.get('maximum_bank_capacity') != 512 * factor
            or cache.get('minimum_bank_capacity') != 96 * factor
            or cache.get('occupied_records') != 608 * factor
            or cache.get('dense_savings_reinvested') != 1
            or cache.get('maximum_executed_slot') != 512 * factor - 1
            or cache.get('minimum_class_maximum_executed_slot') != 96 * factor - 1
            or cache.get('pinned_records') != 0
            or type(receipt.get('peak_process_bytes')) is not int
            or not 0 < receipt['peak_process_bytes'] <= 10_000_000_000):
        raise ValueError('record-layout receipt changed its artifact, producer, physical range or envelope')
    generated = receipt.get('generated')
    if (not isinstance(generated, list) or generated[:16] != reference['generated']
            or any(type(t) is not int or not 0 <= t < 248_320 for t in generated)):
        raise ValueError('record-layout receipt changed the independent generated prefix')
    if not measurement and (len(generated) != 16 or receipt.get('observed_logit_hashes') != [x['sha256'] for x in reference['logits']]):
        raise ValueError('record-layout validation omitted full-logit references')
    if measurement and not 16 <= len(generated) <= 128:
        raise ValueError('record-layout measurement changed its bounded sequence length')


def validate_gate(receipt, sparse, arm):
    validate_storage(receipt, arm)
    cache = receipt.get('resident_record_cache', {})
    if (receipt.get('composite_sha256') != IDENTITY_SHA
            or receipt.get('inventory_sha256') != VQ_INVENTORY
            or receipt.get('report', {}).get('passed') is not True
            or receipt.get('process_bound_bytes') != 10_000_000_000
            or type(receipt.get('peak_process_bytes')) is not int
            or not 0 < receipt['peak_process_bytes'] <= 10_000_000_000
            or cache.get('dense_savings_reinvested') != 1
            or cache.get('total_capacity') != 1824
            or cache.get('reserved_bank_bytes') != 3_583_180_800
            or cache.get('pinned_records') != 0
            or len(receipt.get('observed', {})) != (984 if sparse else 2560)):
        raise ValueError('missing independent record-layout parity/memory gate')
    # Supervisor identity binds the producing binary separately; numerical
    # gate receipts predate executable fields in the performance schema.
    if not sparse and (cache.get('maximum_executed_slot') != 1535
                       or cache.get('minimum_class_maximum_executed_slot') != 287):
        raise ValueError('greedy gate did not execute the enlarged physical range')


def run(options):
    root = Path(__file__).resolve().parent.parent
    research, out, binary = options.research_root.resolve(), options.out.resolve(), options.binary.resolve()
    build = verified_build(str(binary))
    identity = json.loads((binary.parent / 'build-identity.json').read_text())
    producer = {k: identity[k] for k in ('binary_sha256', 'metallib_sha256')}
    profile_paths = {'split': root / 'bench/quantization/dense-reinvestment-cost-v1.json',
                     'contiguous': root / 'bench/quantization/contiguous-record-cost-v1.json'}
    if any(digest(path) != PROFILE_SHAS[arm] for arm, path in profile_paths.items()):
        raise ValueError('record-layout protocol differs from frozen identity')
    profiles = {arm: json.loads(path.read_text()) for arm, path in profile_paths.items()}
    profile = profiles['contiguous']
    gate_run = options.gates.resolve() / 'run.json'
    gate_record = json.loads(gate_run.read_text())
    if (gate_record.get('complete') is not True
            or gate_record.get('producer_sha256') != producer['binary_sha256']):
        raise ValueError('parity campaign did not complete on the timed producer')
    gate_paths = [gate_run]
    for name, sparse, arm in [('greedy-control', False, 'split'), ('greedy', False, 'contiguous'),
                              ('sparse-control', True, 'split'), ('sparse', True, 'contiguous')]:
        path = options.gates.resolve() / name / 'receipt.json'
        supervisor = options.gates.resolve() / (name + '-supervision') / 'identity.json'
        validate_gate(json.loads(path.read_text()), sparse, arm)
        bound_identity = json.loads(supervisor.read_text())
        if bound_identity.get('command', [None])[0] != str(binary):
            raise ValueError('parity gate did not use the timed frozen binary')
        finished = options.gates.resolve() / (name + '-supervision') / 'receipt.json'
        result = json.loads(finished.read_text())
        if result.get('exit_code') != 0 or result.get('failure') is not None:
            raise ValueError('parity supervision failed')
        gate_paths += [path, supervisor, finished]

    manifest = options.manifest.resolve()
    if digest(manifest) != '4cdae0e9c26b9a0dd07659cd9d71dd025ed110b49161c152df09d5a7f75ac28b':
        raise ValueError('composite tensor map changed')
    packed_directory = options.packed_record_directory.resolve()
    packed_manifest = packed_directory / 'manifest.json'
    if digest(packed_manifest) != PACKED_MANIFEST_SHA:
        raise ValueError('packed record derivation changed')
    observer = options.admission_observer.resolve()
    observer_files = [observer / name for name in ('observer', 'observer.swift', 'build.json')]
    observer_receipt = json.loads((observer / 'build.json').read_text())
    if observer_receipt.get('engine_source_sha256') != identity['source']['Sources/Slotstream/ProcessMemory.swift']:
        raise ValueError('idle admission observer differs from the timed engine memory implementation')
    inputs = [Path(__file__).resolve(), manifest, packed_manifest] + list(profile_paths.values()) + gate_paths + observer_files
    inputs += [Path(module.__file__).resolve() for module in list(sys.modules.values())
               if getattr(module, '__file__', None) and Path(module.__file__).resolve().parent == root / 'Tools']
    bound = {str(p): digest(p) for p in inputs}
    out.mkdir(exist_ok=False)
    for arm, path in profile_paths.items(): shutil.copy2(path, out / (arm + '-profile.json'))
    record = {'schema': 1, 'scope': profile['scope'], 'qualification': 'unproven', 'complete': False,
        'started_at': datetime.now(timezone.utc).isoformat(), 'producer': producer, 'build': build,
        'source_archive_sha256': identity['source_archive_sha256'], 'bound_files': bound,
        'admission': {'required_stable_seconds': STABLE_SECONDS, 'maximum_wait_seconds_per_cell': MAXIMUM_WAIT_SECONDS,
                      'scope': 'Sampled idle precondition before every validation and measurement; no change to native or in-request checks'},
        'maximum_runs': 8, 'campaign_timeout_seconds': 14400, 'run_timeout_seconds': 1800,
        'maximum_process_bytes': 10000000000, 'minimum_reclaimable_bytes': 13000000000,
        'retry_policy': 'No automatic retry; retain failure', 'paid_compute': False, 'runs': []}
    started = time.monotonic(); sequences = {}

    def save():
        (out / 'run.json').write_text(json.dumps(record, indent=2) + '\n')

    def verify():
        if any(digest(Path(p)) != sha for p, sha in bound.items()) or any(digest(out / (arm + '-profile.json')) != PROFILE_SHAS[arm] for arm in ARMS):
            raise ValueError('cost experiment inputs changed')
        for name, key in [('slotstream', 'binary_sha256'), ('mlx.metallib', 'metallib_sha256'), ('build-source.tar.gz', 'source_archive_sha256')]:
            if digest(binary.parent / name) != identity[key]:
                raise ValueError('cost producer changed')

    def invoke(arm, name, *, measurement=False):
        verify()
        remaining = int(14400 - (time.monotonic() - started))
        if remaining <= 0: raise ValueError('cost experiment exhausted its campaign bound')
        command = [str(binary), 'quantization-performance-pilot', '--source-directory', str(research / 'candidate-3.2'),
            '--source-inventory', str(research / 'inventory-3.2/inventory.json'),
            '--profile', str(out / (arm + '-profile.json')), '--output', str(out / name),
            '--dense-overlay-baseline', str(options.baseline.resolve()), '--dense-overlay-manifest', str(manifest)]
        if arm == 'contiguous':
            command += ['--packed-record-directory', str(packed_directory)]
        if measurement:
            command += ['--measure', '--validation-receipt', str(out / ('validation-' + arm) / 'receipt.json')]
        admit(observer, out / (name + '-admission.json'), maximum_wait=min(MAXIMUM_WAIT_SECONDS, remaining))
        verify()
        remaining = int(14400 - (time.monotonic() - started))
        if remaining <= 0: raise ValueError('campaign exhausted after idle admission')
        supervision = supervise(command, out / (name + '-supervision'), min(1800, remaining))
        path = out / name / 'receipt.json'; receipt = json.loads(path.read_text())
        validate_receipt(receipt, arm, profiles[arm], producer, measurement=measurement)
        if measurement:
            if any(sequence != receipt['generated'] for sequence in sequences.values()):
                raise ValueError('same composite changed its complete sequence across record-layout arms')
            sequences[arm] = receipt['generated']
        row = {'name': name, 'arm': arm, 'measurement': measurement, 'supervision': supervision,
            'receipt_sha256': digest(path), 'generated_sha256': hashlib.sha256(json.dumps(receipt['generated']).encode()).hexdigest()}
        for key in ('committed_tokens', 'committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds',
                    'peak_process_bytes', 'observed_timing_eligible', 'timing_exclusions', 'stop'):
            row[key] = receipt.get(key)
        record['runs'].append(row); save(); verify()
        print(json.dumps({k:v for k,v in row.items() if k != 'supervision'}), flush=True)

    save()
    try:
        for arm in ARMS: invoke(arm, 'validation-' + arm)
        for index, order in enumerate(profile['rounds'], 1):
            for arm in order: invoke(arm, f'round-{index}-{arm}', measurement=True)
        timing = [r for r in record['runs'] if r['measurement']]
        record['all_observed_timings_eligible'] = all(r['observed_timing_eligible'] for r in timing)
        if record['all_observed_timings_eligible']:
            metrics = ('committed_decode_tokens_per_second', 'ttft_seconds', 'request_seconds')
            record['medians'] = {arm:{k:statistics.median(r[k] for r in timing if r['arm']==arm) for k in metrics} for arm in ARMS}
            by_name = {r['name']:r for r in timing}
            record['paired_ratios'] = {k:[by_name[f'round-{i}-{ARMS[1]}'][k]/by_name[f'round-{i}-{ARMS[0]}'][k] for i in range(1,4)] for k in metrics}
            record['median_paired_ratios'] = {k:statistics.median(v) for k,v in record['paired_ratios'].items()}
        record['complete'] = True; record['finished_at'] = datetime.now(timezone.utc).isoformat(); save()
    except BaseException as error:
        record['failure'] = repr(error); save(); raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('binary', 'research-root', 'baseline', 'manifest', 'gates', 'out', 'admission-observer', 'packed-record-directory'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
````

### vq_contiguous_expert_test.py

Original bytes: 4582. SHA-256: `b42e25f7a7f2a08b278066a8db8ca8aa869dd738ab28fa8ca25db9a8c73d4754`.

Normalized bytes: 4582. SHA-256: `b42e25f7a7f2a08b278066a8db8ca8aa869dd738ab28fa8ca25db9a8c73d4754`.

````text
"""Refuse evidence that swaps cache profiles, producer or numerical gates."""
import copy
import hashlib
import json
from pathlib import Path
import unittest
from vq_contiguous_expert_pilot import ARMS, PROFILE_SHAS, IDENTITY_SHA, VQ_INVENTORY, validate_receipt, validate_gate, PACKED_MANIFEST_SHA

class RecordLayoutChecks(unittest.TestCase):
    def test_receipt_cannot_swap_cache_geometry_or_producer(self):
        root=Path(__file__).resolve().parent.parent
        producer={'binary_sha256':'binary','metallib_sha256':'metal'}
        for arm,file in [('split','dense-reinvestment-cost-v1.json'),('contiguous','contiguous-record-cost-v1.json')]:
            raw=(root/'bench/quantization'/file).read_bytes()
            self.assertEqual(hashlib.sha256(raw).hexdigest(),PROFILE_SHAS[arm])
            profile=json.loads(raw);reference=profile['references'][IDENTITY_SHA];factor=3
            cache={'parallel_read_lanes':12,'total_capacity':608*factor,'reserved_bank_bytes':1194393600*factor,
                   'maximum_bank_capacity':512*factor,'minimum_bank_capacity':96*factor,'occupied_records':608*factor,
                   'dense_savings_reinvested':1,'maximum_executed_slot':512*factor-1,
                   'minimum_class_maximum_executed_slot':96*factor-1,'pinned_records':0}
            receipt={'passed':True,'mode':'validation','profile_sha256':PROFILE_SHAS[arm],'producer':producer,
                     'pack':'3.2-dense-affine4','inventory_sha256':VQ_INVENTORY,'composite_sha256':IDENTITY_SHA,
                     'verified_files':138,'overlay_verified_files':9,'resident_text':{'payload_bytes':2893477400},
                     'cache_after':cache,'peak_process_bytes':9_000_000_000,'generated':reference['generated'],
                     'observed_logit_hashes':[x['sha256'] for x in reference['logits']],
                     'record_storage':'contiguous-records-16k-v1' if arm=='contiguous' else 'split-tensor-ranges-v1',
                     'packed_manifest_sha256':PACKED_MANIFEST_SHA if arm=='contiguous' else None,
                     'packed_verified_files':48 if arm=='contiguous' else 0,
                     'packed_verified_bytes':47866183680 if arm=='contiguous' else 0,
                     'expert_file_read_policy':'buffered-v1', 'uncached_expert_files':0}
            validate_receipt(receipt,arm,profile,producer,measurement=False)
            for field,value in [('producer',{}),('profile_sha256','wrong'),('peak_process_bytes',10_000_000_001),('observed_logit_hashes',[]),('expert_file_read_policy','other'),('uncached_expert_files',8),('packed_manifest_sha256','other'),('packed_verified_bytes',1),('packed_verified_files',47),('record_storage','other')]:
                bad=copy.deepcopy(receipt);bad[field]=value
                with self.assertRaises(ValueError):validate_receipt(bad,arm,profile,producer,measurement=False)
            for field in ('reserved_bank_bytes','maximum_executed_slot','occupied_records','pinned_records'):
                bad=copy.deepcopy(receipt);bad['cache_after'][field]+=1
                with self.assertRaises(ValueError):validate_receipt(bad,arm,profile,producer,measurement=False)
            other=ARMS[1] if arm==ARMS[0] else ARMS[0]
            with self.assertRaises(ValueError):validate_receipt(receipt,other,profile,producer,measurement=False)

    def test_sparse_gate_does_not_pretend_it_filled_the_whole_cache(self):
        r={'composite_sha256':IDENTITY_SHA,'inventory_sha256':VQ_INVENTORY,'report':{'passed':True},
           'process_bound_bytes':10_000_000_000,'peak_process_bytes':9_000_000_000,
           'expert_file_read_policy':'buffered-v1','uncached_expert_files':0,
           'record_storage':'contiguous-records-16k-v1','packed_manifest_sha256':PACKED_MANIFEST_SHA,
           'packed_verified_files':48,'packed_verified_bytes':47866183680,
           'observed':{str(i):'hash' for i in range(984)},
           'resident_record_cache':{'dense_savings_reinvested':1,'total_capacity':1824,
                                   'reserved_bank_bytes':3583180800,'pinned_records':0}}
        validate_gate(r,True,'contiguous')
        with self.assertRaises(ValueError):validate_gate(r,False,'contiguous')
        r['resident_record_cache'].update(maximum_executed_slot=1535,minimum_class_maximum_executed_slot=287)
        r['observed']={str(i):'hash' for i in range(2560)}
        validate_gate(r,False,'contiguous')
        r['report']['passed']=False
        with self.assertRaises(ValueError):validate_gate(r,False,'contiguous')

if __name__=='__main__':unittest.main()
````

### vq-pilot-admission-observer-v1/build.json

Original bytes: 2641. SHA-256: `3636a4917670c357536cdfd2c5869620b7db56751fa0b702e6b7f6c77634a78c`.

Normalized bytes: 2627. SHA-256: `a9bbc8c06d498f9c305e5b25d808798b5132037d280c4e24e04a17137da1cd2f`.

````text
{
  "schema": 1,
  "command": [
    "swiftc",
    "-O",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-pilot-admission-observer-v1/observer.swift",
    "-o",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-pilot-admission-observer-v1/observer"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23020765184,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     7999.\nPages active:                                1114453.\nPages inactive:                              1104398.\nPages speculative:                             11626.\nPages throttled:                                   0.\nPages wired down:                             182703.\nPages purgeable:                                8696.\n\"Translation faults\":                     1926488065.\nPages copy-on-write:                        96180726.\nPages zero filled:                        3155107531.\nPages reactivated:                         172445714.\nPages purged:                               12531461.\nFile-backed pages:                           1388381.\nAnonymous pages:                              842096.\nPages stored in compressor:                  1206719.\nPages occupied by compressor:                 663827.\nDecompressions:                             97231907.\nCompressions:                              110343132.\nPageins:                                  2137515158.\nPageouts:                                     472757.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 134932.\nPages tagged resident:                         95293.\nPages tagged compressed:                       39639.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6325.\nPages tag-storage free:                          360.\nPages tag-storage non-tag pageable:            91611.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5873472.\nTagged compressions:                          713269.\nTagged decompressions:                        589124.\n"
  },
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5",
  "observer_source_sha256": "1370c1be3803c5a36a2f5a3a2aab86dad29cbcf752bb397220246662c8186944",
  "returncode": 0,
  "stdout": "",
  "stderr": "",
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79"
}
````

### vq-pilot-admission-observer-v1/observer.swift

Original bytes: 6468. SHA-256: `1370c1be3803c5a36a2f5a3a2aab86dad29cbcf752bb397220246662c8186944`.

Normalized bytes: 6468. SHA-256: `1370c1be3803c5a36a2f5a3a2aab86dad29cbcf752bb397220246662c8186944`.

````text
// Process-wide safety helpers: physical footprint, RSS and a single model-bearing
// Slotstream process per user. MLX allocator counters are useful diagnostics,
// but they do not include Swift heaps, mmap residency, or raw I/O buffers.

import Darwin
import Foundation

public enum ProcessMemory {
    public struct OperatingConditions: Codable, Equatable, Sendable {
        public let thermalState: String
        public let lowPowerModeEnabled: Bool
    }
    /// Instantaneous OS policy state, distinct from pmset warning history.
    /// Neither value is a temperature sensor or an energy measurement.
    public static func operatingConditions() -> OperatingConditions {
        let process = ProcessInfo.processInfo
        let thermal: String
        switch process.thermalState {
        case .nominal: thermal = "nominal"
        case .fair: thermal = "fair"
        case .serious: thermal = "serious"
        case .critical: thermal = "critical"
        @unknown default: thermal = "unknown"
        }
        return OperatingConditions(thermalState: thermal, lowPowerModeEnabled: process.isLowPowerModeEnabled)
    }

    public struct VMActivity: Codable, Equatable, Sendable {
        public let swapins: UInt64
        public let swapouts: UInt64
        public let reclaimableBytes: UInt64
    }
    private static let hostPort = mach_host_self()

    /// Global VM counters at a named request boundary. Paging is diagnostic:
    /// these host-wide counters cannot attribute activity to this process and
    /// must not decide functional correctness or process-budget acceptance.
    public static func vmActivity() -> VMActivity? {
        var info = vm_statistics64_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.stride / MemoryLayout<integer_t>.stride)
        let result = withUnsafeMutablePointer(to: &info) { p in
            p.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &count)
            }
        }
        guard result == KERN_SUCCESS else { return nil }
        let pages = UInt64(info.free_count) + UInt64(info.purgeable_count) + UInt64(info.external_page_count)
        return VMActivity(swapins: UInt64(info.swapins), swapouts: UInt64(info.swapouts),
            reclaimableBytes: pages * UInt64(vm_page_size))
    }

    private static func vmInfo() -> (task_vm_info_data_t, mach_msg_type_number_t)? {
        var info = task_vm_info_data_t()
        var count = mach_msg_type_number_t(
            MemoryLayout<task_vm_info_data_t>.stride / MemoryLayout<natural_t>.stride)
        let kr = withUnsafeMutablePointer(to: &info) { p in
            p.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        return kr == KERN_SUCCESS ? (info, count) : nil
    }

    /// Current physical footprint as reported by Mach. `phys_footprint` is the
    /// number Activity Monitor uses and includes non-MLX allocations.
    public static func residentBytes() -> UInt64 {
        vmInfo().map { UInt64($0.0.phys_footprint) } ?? 0
    }

    // task_info may return an older revision than the SDK's structure. Check
    // the returned byte count before using the rev3 ledger field. Swift cannot
    // import TASK_VM_INFO_REV3_COUNT, so derive this field's extent from its ABI.
    static func footprintPeak(info: task_vm_info_data_t, count: mach_msg_type_number_t) -> UInt64 {
        guard let offset = MemoryLayout<task_vm_info_data_t>.offset(of: \.ledger_phys_footprint_peak),
              Int(count) * MemoryLayout<integer_t>.stride >= offset + MemoryLayout<Int64>.size,
              info.ledger_phys_footprint_peak > 0 else { return 0 }
        return UInt64(info.ledger_phys_footprint_peak)
    }

    /// Kernel-recorded lifetime physical-footprint high-water, including GPU
    /// allocations that have since been freed. Zero means unavailable. This is
    /// process-wide, not resettable or attributable to an individual request.
    public static func lifetimePhysicalFootprintPeakBytes() -> UInt64 {
        guard let (info, count) = vmInfo() else { return 0 }
        return footprintPeak(info: info, count: count)
    }

    /// Lifetime high-water RSS alone. It is not physical footprint and cannot
    /// be reset between requests. On Darwin, ru_maxrss is reported in bytes.
    public static func lifetimeRSSPeakBytes() -> UInt64 {
        var usage = rusage()
        guard getrusage(RUSAGE_SELF, &usage) == 0 else { return 0 }
        return UInt64(max(0, usage.ru_maxrss))
    }

    /// Compatibility high-water: maximum of lifetime physical footprint,
    /// lifetime RSS and current footprint. RSS alone misses released GPU
    /// buffers. Keep per-request sampled observations separate from this
    /// process-lifetime value. If Mach is unavailable, retain the RSS fallback.
    public static func peakResidentBytes() -> UInt64 {
        let rss = lifetimeRSSPeakBytes()
        guard let (info, count) = vmInfo() else { return rss }
        return max(rss, UInt64(info.phys_footprint), footprintPeak(info: info, count: count))
    }

    /// Process-attributed page-ins from the kernel's resource-usage ledger
    /// (`proc_pid_rusage`, `ri_pageins`): file-backed faults included, at the
    /// machine's page size. Nil when the ledger is unavailable. Used by the
    /// benchmark's timing-eligibility rule; never a functional gate.
    public static func pageIns() -> UInt64? {
        var info = rusage_info_v4()
        let rc = withUnsafeMutablePointer(to: &info) { ptr -> Int32 in
            proc_pid_rusage(getpid(), RUSAGE_INFO_V4, UnsafeMutableRawPointer(ptr).assumingMemoryBound(to: rusage_info_t?.self))
        }
        return rc == 0 ? info.ri_pageins : nil
    }

    public static var residentGB: Double { Double(residentBytes()) / 1e9 }
    public static var peakResidentGB: Double { Double(peakResidentBytes()) / 1e9 }
}


let enc = JSONEncoder(); enc.outputFormatting = [.sortedKeys]
var output: [String: Any] = ["conditions": try JSONSerialization.jsonObject(with: enc.encode(ProcessMemory.operatingConditions()))]
output["vm"] = try ProcessMemory.vmActivity().map { try JSONSerialization.jsonObject(with: enc.encode($0)) }
print(String(decoding: try JSONSerialization.data(withJSONObject: output, options: [.sortedKeys]), as: UTF8.self))
````

### vq-contiguous-cost-v1/validation-split-admission.json

Original bytes: 17280. SHA-256: `e15ba6d47f04d08cf4db70755233a990b4495044a5f207743cd38f09e4941197`.

Normalized bytes: 17280. SHA-256: `e15ba6d47f04d08cf4db70755233a990b4495044a5f207743cd38f09e4941197`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.01608166698133573,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 22403039232,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 22302916608,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   419153.\nPages active:                                 891123.\nPages inactive:                               913900.\nPages speculative:                              6448.\nPages throttled:                                   0.\nPages wired down:                             202376.\nPages purgeable:                                8626.\n\"Translation faults\":                     1966524354.\nPages copy-on-write:                        98998953.\nPages zero filled:                        3232525142.\nPages reactivated:                         173664341.\nPages purged:                               12716756.\nFile-backed pages:                            933483.\nAnonymous pages:                              877988.\nPages stored in compressor:                  1195970.\nPages occupied by compressor:                 651679.\nDecompressions:                            102441240.\nCompressions:                              115994976.\nPageins:                                  2273530778.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 135756.\nPages tagged resident:                         95361.\nPages tagged compressed:                       40395.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                          948.\nPages tag-storage non-tag pageable:            92081.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6120192.\nTagged compressions:                          734572.\nTagged decompressions:                        606996.\n"
      }
    },
    {
      "elapsed_seconds": 5.048450041998876,
      "stable_seconds": 5.0323683750175405,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 22437445632,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 22332129280,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   421511.\nPages active:                                 891122.\nPages inactive:                               910375.\nPages speculative:                              6492.\nPages throttled:                                   0.\nPages wired down:                             203630.\nPages purgeable:                                8034.\n\"Translation faults\":                     1966537872.\nPages copy-on-write:                        99000506.\nPages zero filled:                        3232591421.\nPages reactivated:                         173664345.\nPages purged:                               12716758.\nFile-backed pages:                            933500.\nAnonymous pages:                              874489.\nPages stored in compressor:                  1195964.\nPages occupied by compressor:                 651677.\nDecompressions:                            102441246.\nCompressions:                              115994976.\nPageins:                                  2273530781.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 135742.\nPages tagged resident:                         95347.\nPages tagged compressed:                       40395.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                         1001.\nPages tag-storage non-tag pageable:            92028.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6120192.\nTagged compressions:                          734572.\nTagged decompressions:                        606996.\n"
      }
    },
    {
      "elapsed_seconds": 10.08123133398476,
      "stable_seconds": 10.065149667003425,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 22484140032,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 22366437376,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   422429.\nPages active:                                 894343.\nPages inactive:                               910503.\nPages speculative:                              7251.\nPages throttled:                                   0.\nPages wired down:                             198821.\nPages purgeable:                                8147.\n\"Translation faults\":                     1966547786.\nPages copy-on-write:                        99001203.\nPages zero filled:                        3232630171.\nPages reactivated:                         173664351.\nPages purged:                               12716758.\nFile-backed pages:                            934563.\nAnonymous pages:                              877534.\nPages stored in compressor:                  1193884.\nPages occupied by compressor:                 651025.\nDecompressions:                            102443326.\nCompressions:                              115994976.\nPageins:                                  2273531394.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 135787.\nPages tagged resident:                         95678.\nPages tagged compressed:                       40109.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                         1024.\nPages tag-storage non-tag pageable:            92005.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6065600.\nTagged compressions:                          734572.\nTagged decompressions:                        607282.\n"
      }
    },
    {
      "elapsed_seconds": 15.104091333982069,
      "stable_seconds": 15.088009667000733,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 22548922368,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 22409330688,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   412981.\nPages active:                                 916536.\nPages inactive:                               910661.\nPages speculative:                              8713.\nPages throttled:                                   0.\nPages wired down:                             184891.\nPages purgeable:                               17293.\n\"Translation faults\":                     1966560024.\nPages copy-on-write:                        99002239.\nPages zero filled:                        3232674201.\nPages reactivated:                         173664351.\nPages purged:                               12716758.\nFile-backed pages:                            937483.\nAnonymous pages:                              898427.\nPages stored in compressor:                  1193166.\nPages occupied by compressor:                 650915.\nDecompressions:                            102444044.\nCompressions:                              115994976.\nPageins:                                  2273533835.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 135796.\nPages tagged resident:                         95819.\nPages tagged compressed:                       39977.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                         1022.\nPages tag-storage non-tag pageable:            92007.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6040000.\nTagged compressions:                          734572.\nTagged decompressions:                        607414.\n"
      }
    },
    {
      "elapsed_seconds": 20.136312708986225,
      "stable_seconds": 20.12023104200489,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 22573875200,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 22431072256,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   417763.\nPages active:                                 911529.\nPages inactive:                               910733.\nPages speculative:                              8781.\nPages throttled:                                   0.\nPages wired down:                             184888.\nPages purgeable:                               13755.\n\"Translation faults\":                     1966564786.\nPages copy-on-write:                        99002942.\nPages zero filled:                        3232712307.\nPages reactivated:                         173664351.\nPages purged:                               12716758.\nFile-backed pages:                            937566.\nAnonymous pages:                              893477.\nPages stored in compressor:                  1193105.\nPages occupied by compressor:                 650903.\nDecompressions:                            102444105.\nCompressions:                              115994976.\nPageins:                                  2273533895.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 135810.\nPages tagged resident:                         95833.\nPages tagged compressed:                       39977.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                         1031.\nPages tag-storage non-tag pageable:            91998.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6040000.\nTagged compressions:                          734572.\nTagged decompressions:                        607414.\n"
      }
    },
    {
      "elapsed_seconds": 25.168656750000082,
      "stable_seconds": 25.152575083018746,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 22430842880,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 22287974400,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   414632.\nPages active:                                 893948.\nPages inactive:                               910695.\nPages speculative:                              8787.\nPages throttled:                                   0.\nPages wired down:                             205659.\nPages purgeable:                                8173.\n\"Translation faults\":                     1966569489.\nPages copy-on-write:                        99003608.\nPages zero filled:                        3232776627.\nPages reactivated:                         173664363.\nPages purged:                               12717014.\nFile-backed pages:                            937545.\nAnonymous pages:                              875885.\nPages stored in compressor:                  1193047.\nPages occupied by compressor:                 650891.\nDecompressions:                            102444163.\nCompressions:                              115994976.\nPageins:                                  2273533897.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 134619.\nPages tagged resident:                         94642.\nPages tagged compressed:                       39977.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                         1034.\nPages tag-storage non-tag pageable:            91995.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6040000.\nTagged compressions:                          734572.\nTagged decompressions:                        607414.\n"
      }
    },
    {
      "elapsed_seconds": 30.20064008398913,
      "stable_seconds": 30.184558417007793,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 22553067520,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 22408691712,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   421529.\nPages active:                                 894267.\nPages inactive:                               910971.\nPages speculative:                              8816.\nPages throttled:                                   0.\nPages wired down:                             198349.\nPages purgeable:                                8610.\n\"Translation faults\":                     1966579350.\nPages copy-on-write:                        99004361.\nPages zero filled:                        3232824514.\nPages reactivated:                         173664495.\nPages purged:                               12717014.\nFile-backed pages:                            937579.\nAnonymous pages:                              876475.\nPages stored in compressor:                  1193028.\nPages occupied by compressor:                 650883.\nDecompressions:                            102444180.\nCompressions:                              115994976.\nPageins:                                  2273533914.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 134638.\nPages tagged resident:                         94662.\nPages tagged compressed:                       39976.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                         1021.\nPages tag-storage non-tag pageable:            92008.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6039936.\nTagged compressions:                          734572.\nTagged decompressions:                        607415.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/validation-split/receipt.json

Original bytes: 7478. SHA-256: `2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90`.

Normalized bytes: 7478. SHA-256: `2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 8484,
    "hits" : 3902,
    "loads" : 10308,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.2475706930184502,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.1151252920099068,
    3.5497664580179844,
    3.7443029580172151,
    3.9277880000008736,
    4.1024834999989253,
    4.2799493750208057,
    4.4552411670156289,
    4.6447939170175232,
    4.8205517080205027,
    5.002314417011803,
    5.1711588330217637,
    5.3239383330219425,
    5.4863345420162659,
    5.6360121250036173,
    5.8239401669998188,
    5.9735908330185339
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36
  ],
  "initial_vm" : {
    "reclaimableBytes" : 22301114368,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.43464116600807756,
    0.19453649999923073,
    0.18348504198365845,
    0.17469549999805167,
    0.17746587502188049,
    0.17529179199482314,
    0.18955275000189431,
    0.1757577910029795,
    0.18176270899130031,
    0.1688444160099607,
    0.15277950000017881,
    0.16239620899432339,
    0.14967758298735134,
    0.1879280419962015,
    0.14965066601871513
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.508792291017016,
  "metadata_seconds" : 0.12863137500244193,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "b9b6d6b68a127c9332acd50b6775b9139ba38781e87fa2f20abc0ddcc2311213",
    "f595a7c1f7e431bb42f76a81b05d9d0b39147775cd7cbde24b6a34687289a135",
    "1980728aacdaab38f9ad707dc9bd00da8efe4e754a0ecae5c325dc263ca75b2e",
    "b2c1a66f36cdbb37f562f19f78647d149f6d446ff4a09fe5a10593851dd57244",
    "1836cab6617d6e1514aeee53c411a3a383128b51ecf953310c6977df1ac6c6d3",
    "ddf90e28ce313f5cb87bfa15e1f863d197b134053dced7208214a7e6b151672d",
    "07b910ef6f36a24bbf9f73de8df0530c3ceea51aef574ada3ff48c31d7bc8913",
    "bff4ded7b410f4ee57dab02296ba32b7b557eed95531ca5cafbfa02e8f58e28c",
    "3a217d5ac63612addd51ec04490d94b3736cded603f196f4a463fdba9e876f74",
    "79c3ba8397db461129f32e86cbe613afb3fdcd6f9c981ef1627649a2dac3fc8c",
    "5abce2984079fa5ae52337b69e8f36d1160fcd515b52c8c71ce0252a65526f64",
    "c6cd56cad6c7ec11114d55a2a5870c81fe64e919d934db7c5c66cd1a348f434e",
    "5edff1c86257005485a4ed84f26a5d7ade358fd2a2abe22f1100ebeaa5ed23b9",
    "5a87cddfcab3c7e13235b0b4fe2addcc8fce91e7fb06e8f852ec9b38f19590db",
    "80e7d09b6eb40985515d49faeb968c30df11220570e32f7bf935780e7522eafe",
    "702a8118a41efe6d74eed9d029570eef782ef4f47d720b1d82f1ac8934cd1bfe"
  ],
  "observed_timing_eligible" : false,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7815420096,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 5.973610583023401,
  "request_vm_after" : {
    "reclaimableBytes" : 18195677184,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17284513792,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 3.1151252920099068,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/validation-split-supervision/identity.json

Original bytes: 3019. SHA-256: `4791e1fc26485def0bfd370e5784f67ae4aba3ccdc545e3cc90418631dffac39`.

Normalized bytes: 2970. SHA-256: `c4574d77714391c83885526308610a4e91b38c9f66b3b3c12ca4036aac265739`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/split-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-split",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22406774784,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   421405.\nPages active:                                 894371.\nPages inactive:                               911000.\nPages speculative:                              8796.\nPages throttled:                                   0.\nPages wired down:                             198349.\nPages purgeable:                                8610.\n\"Translation faults\":                     1966585019.\nPages copy-on-write:                        99005159.\nPages zero filled:                        3232826876.\nPages reactivated:                         173664496.\nPages purged:                               12717014.\nFile-backed pages:                            937586.\nAnonymous pages:                              876581.\nPages stored in compressor:                  1193011.\nPages occupied by compressor:                 650876.\nDecompressions:                            102444197.\nCompressions:                              115994976.\nPageins:                                  2273533921.\nPageouts:                                     484784.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 134638.\nPages tagged resident:                         94662.\nPages tagged compressed:                       39976.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5267.\nPages tag-storage free:                         1013.\nPages tag-storage non-tag pageable:            92016.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6039936.\nTagged compressions:                          734572.\nTagged decompressions:                        607415.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/validation-split-supervision/receipt.json

Original bytes: 2140. SHA-256: `b2efab46091bd6f94778e91d038825c22950b38bb531ffc0fadfc7575b4acc68`.

Normalized bytes: 2140. SHA-256: `b2efab46091bd6f94778e91d038825c22950b38bb531ffc0fadfc7575b4acc68`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7815420096,
  "samples": 1134,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24596217856,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   473433.\nPages active:                                 848939.\nPages inactive:                               798763.\nPages speculative:                             75918.\nPages throttled:                                   0.\nPages wired down:                             182385.\nPages purgeable:                                3746.\n\"Translation faults\":                     1967318943.\nPages copy-on-write:                        99042329.\nPages zero filled:                        3234237468.\nPages reactivated:                         173812468.\nPages purged:                               12732835.\nFile-backed pages:                           1024055.\nAnonymous pages:                              699565.\nPages stored in compressor:                  1312499.\nPages occupied by compressor:                 704070.\nDecompressions:                            102752578.\nCompressions:                              116448612.\nPageins:                                  2283811311.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128745.\nPages tagged resident:                         85712.\nPages tagged compressed:                       43033.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                         1872.\nPages tag-storage non-tag pageable:            91174.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6682112.\nTagged compressions:                          738117.\nTagged decompressions:                        607902.\n"
  },
  "seconds": 65.76100329199107
}
````

### vq-contiguous-cost-v1/validation-split-supervision/stdout.txt

Original bytes: 7479. SHA-256: `0788240038ac1e3781c33f45c3f1f6def546ca9941f1d4f5038f26b5c7b59fd4`.

Normalized bytes: 7479. SHA-256: `0788240038ac1e3781c33f45c3f1f6def546ca9941f1d4f5038f26b5c7b59fd4`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 8484,
    "hits" : 3902,
    "loads" : 10308,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.2475706930184502,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.1151252920099068,
    3.5497664580179844,
    3.7443029580172151,
    3.9277880000008736,
    4.1024834999989253,
    4.2799493750208057,
    4.4552411670156289,
    4.6447939170175232,
    4.8205517080205027,
    5.002314417011803,
    5.1711588330217637,
    5.3239383330219425,
    5.4863345420162659,
    5.6360121250036173,
    5.8239401669998188,
    5.9735908330185339
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36
  ],
  "initial_vm" : {
    "reclaimableBytes" : 22301114368,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.43464116600807756,
    0.19453649999923073,
    0.18348504198365845,
    0.17469549999805167,
    0.17746587502188049,
    0.17529179199482314,
    0.18955275000189431,
    0.1757577910029795,
    0.18176270899130031,
    0.1688444160099607,
    0.15277950000017881,
    0.16239620899432339,
    0.14967758298735134,
    0.1879280419962015,
    0.14965066601871513
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.508792291017016,
  "metadata_seconds" : 0.12863137500244193,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "b9b6d6b68a127c9332acd50b6775b9139ba38781e87fa2f20abc0ddcc2311213",
    "f595a7c1f7e431bb42f76a81b05d9d0b39147775cd7cbde24b6a34687289a135",
    "1980728aacdaab38f9ad707dc9bd00da8efe4e754a0ecae5c325dc263ca75b2e",
    "b2c1a66f36cdbb37f562f19f78647d149f6d446ff4a09fe5a10593851dd57244",
    "1836cab6617d6e1514aeee53c411a3a383128b51ecf953310c6977df1ac6c6d3",
    "ddf90e28ce313f5cb87bfa15e1f863d197b134053dced7208214a7e6b151672d",
    "07b910ef6f36a24bbf9f73de8df0530c3ceea51aef574ada3ff48c31d7bc8913",
    "bff4ded7b410f4ee57dab02296ba32b7b557eed95531ca5cafbfa02e8f58e28c",
    "3a217d5ac63612addd51ec04490d94b3736cded603f196f4a463fdba9e876f74",
    "79c3ba8397db461129f32e86cbe613afb3fdcd6f9c981ef1627649a2dac3fc8c",
    "5abce2984079fa5ae52337b69e8f36d1160fcd515b52c8c71ce0252a65526f64",
    "c6cd56cad6c7ec11114d55a2a5870c81fe64e919d934db7c5c66cd1a348f434e",
    "5edff1c86257005485a4ed84f26a5d7ade358fd2a2abe22f1100ebeaa5ed23b9",
    "5a87cddfcab3c7e13235b0b4fe2addcc8fce91e7fb06e8f852ec9b38f19590db",
    "80e7d09b6eb40985515d49faeb968c30df11220570e32f7bf935780e7522eafe",
    "702a8118a41efe6d74eed9d029570eef782ef4f47d720b1d82f1ac8934cd1bfe"
  ],
  "observed_timing_eligible" : false,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7815420096,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 5.973610583023401,
  "request_vm_after" : {
    "reclaimableBytes" : 18195677184,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17284513792,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 3.1151252920099068,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/validation-split-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-v1/validation-contiguous-admission.json

Original bytes: 17279. SHA-256: `551787b1f7a7a0531bc129df3ad821385bc70f8b2403524ebbde5cea464966e6`.

Normalized bytes: 17279. SHA-256: `551787b1f7a7a0531bc129df3ad821385bc70f8b2403524ebbde5cea464966e6`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.012204875005409122,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25835945984,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24593285120,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   472809.\nPages active:                                 836036.\nPages inactive:                               813433.\nPages speculative:                             75967.\nPages throttled:                                   0.\nPages wired down:                             182385.\nPages purgeable:                                3746.\n\"Translation faults\":                     1967322163.\nPages copy-on-write:                        99042626.\nPages zero filled:                        3234237643.\nPages reactivated:                         173812468.\nPages purged:                               12732835.\nFile-backed pages:                           1024500.\nAnonymous pages:                              700936.\nPages stored in compressor:                  1311143.\nPages occupied by compressor:                 703416.\nDecompressions:                            102753938.\nCompressions:                              116448612.\nPageins:                                  2283811562.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128738.\nPages tagged resident:                         85712.\nPages tagged compressed:                       43026.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                         1324.\nPages tag-storage non-tag pageable:            91722.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6680512.\nTagged compressions:                          738117.\nTagged decompressions:                        607909.\n"
      }
    },
    {
      "elapsed_seconds": 5.0408214580093045,
      "stable_seconds": 5.028616583003895,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25694158848,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24444731392,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   463785.\nPages active:                                 859527.\nPages inactive:                               806357.\nPages speculative:                             76247.\nPages throttled:                                   0.\nPages wired down:                             183560.\nPages purgeable:                                3324.\n\"Translation faults\":                     1967357202.\nPages copy-on-write:                        99043481.\nPages zero filled:                        3234310062.\nPages reactivated:                         173812468.\nPages purged:                               12732835.\nFile-backed pages:                           1024879.\nAnonymous pages:                              717252.\nPages stored in compressor:                  1293162.\nPages occupied by compressor:                 695499.\nDecompressions:                            102770587.\nCompressions:                              116448612.\nPageins:                                  2283811811.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128654.\nPages tagged resident:                         85903.\nPages tagged compressed:                       42751.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                          691.\nPages tag-storage non-tag pageable:            92355.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6616576.\nTagged compressions:                          738117.\nTagged decompressions:                        608184.\n"
      }
    },
    {
      "elapsed_seconds": 10.072739791998174,
      "stable_seconds": 10.060534916992765,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25475317760,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24225513472,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   453621.\nPages active:                                 850967.\nPages inactive:                               806066.\nPages speculative:                             76297.\nPages throttled:                                   0.\nPages wired down:                             203337.\nPages purgeable:                                  53.\n\"Translation faults\":                     1967367737.\nPages copy-on-write:                        99044305.\nPages zero filled:                        3234430973.\nPages reactivated:                         173812470.\nPages purged:                               12732835.\nFile-backed pages:                           1024934.\nAnonymous pages:                              708396.\nPages stored in compressor:                  1290191.\nPages occupied by compressor:                 694552.\nDecompressions:                            102773186.\nCompressions:                              116448612.\nPageins:                                  2283811839.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128647.\nPages tagged resident:                         85957.\nPages tagged compressed:                       42690.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                          747.\nPages tag-storage non-tag pageable:            92299.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6604736.\nTagged compressions:                          738117.\nTagged decompressions:                        608245.\n"
      }
    },
    {
      "elapsed_seconds": 15.104229624994332,
      "stable_seconds": 15.092024749988923,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25564479488,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24315805696,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   458983.\nPages active:                                 853048.\nPages inactive:                               806459.\nPages speculative:                             76388.\nPages throttled:                                   0.\nPages wired down:                             196093.\nPages purgeable:                                 115.\n\"Translation faults\":                     1967376299.\nPages copy-on-write:                        99045054.\nPages zero filled:                        3234510029.\nPages reactivated:                         173812470.\nPages purged:                               12732835.\nFile-backed pages:                           1025021.\nAnonymous pages:                              710874.\nPages stored in compressor:                  1287374.\nPages occupied by compressor:                 693693.\nDecompressions:                            102775084.\nCompressions:                              116448612.\nPageins:                                  2283811858.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128749.\nPages tagged resident:                         86188.\nPages tagged compressed:                       42561.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                          713.\nPages tag-storage non-tag pageable:            92333.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6572096.\nTagged compressions:                          738117.\nTagged decompressions:                        608374.\n"
      }
    },
    {
      "elapsed_seconds": 20.1258338750049,
      "stable_seconds": 20.11362899999949,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25644171264,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24391106560,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   459589.\nPages active:                                 866888.\nPages inactive:                               806787.\nPages speculative:                             76543.\nPages throttled:                                   0.\nPages wired down:                             182046.\nPages purgeable:                                3934.\n\"Translation faults\":                     1967383972.\nPages copy-on-write:                        99045762.\nPages zero filled:                        3234581526.\nPages reactivated:                         173812470.\nPages purged:                               12732835.\nFile-backed pages:                           1025192.\nAnonymous pages:                              725026.\nPages stored in compressor:                  1285637.\nPages occupied by compressor:                 693047.\nDecompressions:                            102776417.\nCompressions:                              116448612.\nPageins:                                  2283811872.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128733.\nPages tagged resident:                         86203.\nPages tagged compressed:                       42530.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                          753.\nPages tag-storage non-tag pageable:            92293.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6567936.\nTagged compressions:                          738117.\nTagged decompressions:                        608405.\n"
      }
    },
    {
      "elapsed_seconds": 25.15725787502015,
      "stable_seconds": 25.14505300001474,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25632145408,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24367349760,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   457453.\nPages active:                                 867507.\nPages inactive:                               807137.\nPages speculative:                             77265.\nPages throttled:                                   0.\nPages wired down:                             183052.\nPages purgeable:                                3794.\n\"Translation faults\":                     1967393591.\nPages copy-on-write:                        99046512.\nPages zero filled:                        3234651527.\nPages reactivated:                         173812477.\nPages purged:                               12732835.\nFile-backed pages:                           1026018.\nAnonymous pages:                              725891.\nPages stored in compressor:                  1283590.\nPages occupied by compressor:                 692309.\nDecompressions:                            102778466.\nCompressions:                              116448612.\nPageins:                                  2283811945.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128739.\nPages tagged resident:                         86394.\nPages tagged compressed:                       42345.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                          753.\nPages tag-storage non-tag pageable:            92293.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6532224.\nTagged compressions:                          738117.\nTagged decompressions:                        608588.\n"
      }
    },
    {
      "elapsed_seconds": 30.189503625006182,
      "stable_seconds": 30.177298750000773,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25389989888,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24119394304,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   445585.\nPages active:                                 860985.\nPages inactive:                               807181.\nPages speculative:                             77491.\nPages throttled:                                   0.\nPages wired down:                             204170.\nPages purgeable:                                 269.\n\"Translation faults\":                     1967414884.\nPages copy-on-write:                        99048152.\nPages zero filled:                        3234786566.\nPages reactivated:                         173812481.\nPages purged:                               12732835.\nFile-backed pages:                           1026277.\nAnonymous pages:                              719380.\nPages stored in compressor:                  1277860.\nPages occupied by compressor:                 689552.\nDecompressions:                            102782747.\nCompressions:                              116448612.\nPageins:                                  2283812053.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128788.\nPages tagged resident:                         86525.\nPages tagged compressed:                       42263.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                          779.\nPages tag-storage non-tag pageable:            92267.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6514048.\nTagged compressions:                          738117.\nTagged decompressions:                        608670.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/validation-contiguous/receipt.json

Original bytes: 7591. SHA-256: `99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66`.

Normalized bytes: 7591. SHA-256: `99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 8484,
    "hits" : 3902,
    "loads" : 10308,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.1524429753760828,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9768604169948958,
    3.3714843339985237,
    3.5430587089795154,
    3.6980717499973252,
    3.8451641249994282,
    3.989129541994771,
    4.1332134999975096,
    4.2950250419962686,
    4.4451792920008302,
    4.6002367499750108,
    4.7404619169828948,
    4.8703774589812383,
    5.005570708977757,
    5.1303909169801045,
    5.2858127089857589,
    5.4149163339752704
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25134628864,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.39462391700362787,
    0.17157437498099171,
    0.15501304101780988,
    0.14709237500210293,
    0.14396541699534282,
    0.14408395800273865,
    0.16181154199875891,
    0.15015425000456162,
    0.15505745797418058,
    0.14022516700788401,
    0.12991554199834354,
    0.13519324999651872,
    0.1248202080023475,
    0.15542179200565442,
    0.12910362498951145
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 77.18407395799295,
  "metadata_seconds" : 0.13237945901346393,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "b9b6d6b68a127c9332acd50b6775b9139ba38781e87fa2f20abc0ddcc2311213",
    "f595a7c1f7e431bb42f76a81b05d9d0b39147775cd7cbde24b6a34687289a135",
    "1980728aacdaab38f9ad707dc9bd00da8efe4e754a0ecae5c325dc263ca75b2e",
    "b2c1a66f36cdbb37f562f19f78647d149f6d446ff4a09fe5a10593851dd57244",
    "1836cab6617d6e1514aeee53c411a3a383128b51ecf953310c6977df1ac6c6d3",
    "ddf90e28ce313f5cb87bfa15e1f863d197b134053dced7208214a7e6b151672d",
    "07b910ef6f36a24bbf9f73de8df0530c3ceea51aef574ada3ff48c31d7bc8913",
    "bff4ded7b410f4ee57dab02296ba32b7b557eed95531ca5cafbfa02e8f58e28c",
    "3a217d5ac63612addd51ec04490d94b3736cded603f196f4a463fdba9e876f74",
    "79c3ba8397db461129f32e86cbe613afb3fdcd6f9c981ef1627649a2dac3fc8c",
    "5abce2984079fa5ae52337b69e8f36d1160fcd515b52c8c71ce0252a65526f64",
    "c6cd56cad6c7ec11114d55a2a5870c81fe64e919d934db7c5c66cd1a348f434e",
    "5edff1c86257005485a4ed84f26a5d7ade358fd2a2abe22f1100ebeaa5ed23b9",
    "5a87cddfcab3c7e13235b0b4fe2addcc8fce91e7fb06e8f852ec9b38f19590db",
    "80e7d09b6eb40985515d49faeb968c30df11220570e32f7bf935780e7522eafe",
    "702a8118a41efe6d74eed9d029570eef782ef4f47d720b1d82f1ac8934cd1bfe"
  ],
  "observed_timing_eligible" : false,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7837800616,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 5.4149392919789534,
  "request_vm_after" : {
    "reclaimableBytes" : 18083479552,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17489854464,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 2.9768604169948958,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/validation-contiguous-supervision/identity.json

Original bytes: 3157. SHA-256: `13638c2920c3da19ff83eb7b812b9de8412b1cfa84f7a35244ccfd3bb9e5df3a`.

Normalized bytes: 3101. SHA-256: `5a074ef2a4b25aac8c5cf6cd534198e5dfb682e51ace716dba3c9000c5f4c034`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/contiguous-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-contiguous",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--packed-record-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24120770560,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   445668.\nPages active:                                 861504.\nPages inactive:                               807182.\nPages speculative:                             77491.\nPages throttled:                                   0.\nPages wired down:                             203737.\nPages purgeable:                                 269.\n\"Translation faults\":                     1967420173.\nPages copy-on-write:                        99048941.\nPages zero filled:                        3234795220.\nPages reactivated:                         173812481.\nPages purged:                               12732835.\nFile-backed pages:                           1026278.\nAnonymous pages:                              719899.\nPages stored in compressor:                  1277775.\nPages occupied by compressor:                 689519.\nDecompressions:                            102782844.\nCompressions:                              116448612.\nPageins:                                  2283812059.\nPageouts:                                     485250.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128770.\nPages tagged resident:                         86507.\nPages tagged compressed:                       42263.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5250.\nPages tag-storage free:                          779.\nPages tag-storage non-tag pageable:            92267.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6514048.\nTagged compressions:                          738117.\nTagged decompressions:                        608670.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/validation-contiguous-supervision/receipt.json

Original bytes: 2139. SHA-256: `8a1459ed676f383e270730b23251080db94c78cfb4f6b47dfd4252f36ec3a58b`.

Normalized bytes: 2139. SHA-256: `8a1459ed676f383e270730b23251080db94c78cfb4f6b47dfd4252f36ec3a58b`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7837800616,
  "samples": 1425,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24627478528,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475638.\nPages active:                                 840514.\nPages inactive:                               791012.\nPages speculative:                             78431.\nPages throttled:                                   0.\nPages wired down:                             179141.\nPages purgeable:                                4837.\n\"Translation faults\":                     1968868474.\nPages copy-on-write:                        99079680.\nPages zero filled:                        3236758315.\nPages reactivated:                         173888256.\nPages purged:                               12740500.\nFile-backed pages:                           1022667.\nAnonymous pages:                              687290.\nPages stored in compressor:                  1326143.\nPages occupied by compressor:                 719409.\nDecompressions:                            103103560.\nCompressions:                              116844219.\nPageins:                                  2297232491.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128316.\nPages tagged resident:                         87277.\nPages tagged compressed:                       41039.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5243.\nPages tag-storage free:                         1609.\nPages tag-storage non-tag pageable:            91444.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6216896.\nTagged compressions:                          739929.\nTagged decompressions:                        611694.\n"
  },
  "seconds": 82.9089260409819
}
````

### vq-contiguous-cost-v1/validation-contiguous-supervision/stdout.txt

Original bytes: 7592. SHA-256: `9cb873dbe53a0097989e05fa1ade06068b351675e3a2268efc9a47f1a1ec0123`.

Normalized bytes: 7592. SHA-256: `9cb873dbe53a0097989e05fa1ade06068b351675e3a2268efc9a47f1a1ec0123`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 8484,
    "hits" : 3902,
    "loads" : 10308,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.1524429753760828,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9768604169948958,
    3.3714843339985237,
    3.5430587089795154,
    3.6980717499973252,
    3.8451641249994282,
    3.989129541994771,
    4.1332134999975096,
    4.2950250419962686,
    4.4451792920008302,
    4.6002367499750108,
    4.7404619169828948,
    4.8703774589812383,
    5.005570708977757,
    5.1303909169801045,
    5.2858127089857589,
    5.4149163339752704
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25134628864,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.39462391700362787,
    0.17157437498099171,
    0.15501304101780988,
    0.14709237500210293,
    0.14396541699534282,
    0.14408395800273865,
    0.16181154199875891,
    0.15015425000456162,
    0.15505745797418058,
    0.14022516700788401,
    0.12991554199834354,
    0.13519324999651872,
    0.1248202080023475,
    0.15542179200565442,
    0.12910362498951145
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 77.18407395799295,
  "metadata_seconds" : 0.13237945901346393,
  "mode" : "validation",
  "observed_logit_hashes" : [
    "b9b6d6b68a127c9332acd50b6775b9139ba38781e87fa2f20abc0ddcc2311213",
    "f595a7c1f7e431bb42f76a81b05d9d0b39147775cd7cbde24b6a34687289a135",
    "1980728aacdaab38f9ad707dc9bd00da8efe4e754a0ecae5c325dc263ca75b2e",
    "b2c1a66f36cdbb37f562f19f78647d149f6d446ff4a09fe5a10593851dd57244",
    "1836cab6617d6e1514aeee53c411a3a383128b51ecf953310c6977df1ac6c6d3",
    "ddf90e28ce313f5cb87bfa15e1f863d197b134053dced7208214a7e6b151672d",
    "07b910ef6f36a24bbf9f73de8df0530c3ceea51aef574ada3ff48c31d7bc8913",
    "bff4ded7b410f4ee57dab02296ba32b7b557eed95531ca5cafbfa02e8f58e28c",
    "3a217d5ac63612addd51ec04490d94b3736cded603f196f4a463fdba9e876f74",
    "79c3ba8397db461129f32e86cbe613afb3fdcd6f9c981ef1627649a2dac3fc8c",
    "5abce2984079fa5ae52337b69e8f36d1160fcd515b52c8c71ce0252a65526f64",
    "c6cd56cad6c7ec11114d55a2a5870c81fe64e919d934db7c5c66cd1a348f434e",
    "5edff1c86257005485a4ed84f26a5d7ade358fd2a2abe22f1100ebeaa5ed23b9",
    "5a87cddfcab3c7e13235b0b4fe2addcc8fce91e7fb06e8f852ec9b38f19590db",
    "80e7d09b6eb40985515d49faeb968c30df11220570e32f7bf935780e7522eafe",
    "702a8118a41efe6d74eed9d029570eef782ef4f47d720b1d82f1ac8934cd1bfe"
  ],
  "observed_timing_eligible" : false,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7837800616,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 5.4149392919789534,
  "request_vm_after" : {
    "reclaimableBytes" : 18083479552,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17489854464,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 784,
    "embedding_hits" : 16,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [
    "validation mode hashes logits",
    "too few committed tokens"
  ],
  "ttft_seconds" : 2.9768604169948958,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/validation-contiguous-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-v1/round-1-split-admission.json

Original bytes: 17281. SHA-256: `ea700d43b3fbca69af4832d049dab2c6289acba9ace5283d91e7c09582a00753`.

Normalized bytes: 17281. SHA-256: `ea700d43b3fbca69af4832d049dab2c6289acba9ace5283d91e7c09582a00753`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.00911816698499024,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 18083479552,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24630853632,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   475422.\nPages active:                                 826004.\nPages inactive:                               805678.\nPages speculative:                             78454.\nPages throttled:                                   0.\nPages wired down:                             179141.\nPages purgeable:                                4837.\n\"Translation faults\":                     1968870261.\nPages copy-on-write:                        99079975.\nPages zero filled:                        3236758492.\nPages reactivated:                         173888256.\nPages purged:                               12740500.\nFile-backed pages:                           1023089.\nAnonymous pages:                              687047.\nPages stored in compressor:                  1325864.\nPages occupied by compressor:                 719402.\nDecompressions:                            103103588.\nCompressions:                              116844219.\nPageins:                                  2297232724.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128314.\nPages tagged resident:                         87277.\nPages tagged compressed:                       41037.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5243.\nPages tag-storage free:                         1577.\nPages tag-storage non-tag pageable:            91476.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6216768.\nTagged compressions:                          739929.\nTagged decompressions:                        611696.\n"
      }
    },
    {
      "elapsed_seconds": 5.040266208990943,
      "stable_seconds": 5.0311480420059524,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25656098816,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24368955392,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   459652.\nPages active:                                 862631.\nPages inactive:                               800361.\nPages speculative:                             78624.\nPages throttled:                                   0.\nPages wired down:                             182647.\nPages purgeable:                                4349.\n\"Translation faults\":                     1968942839.\nPages copy-on-write:                        99080848.\nPages zero filled:                        3236825822.\nPages reactivated:                         173888259.\nPages purged:                               12740500.\nFile-backed pages:                           1023362.\nAnonymous pages:                              718254.\nPages stored in compressor:                  1290046.\nPages occupied by compressor:                 700834.\nDecompressions:                            103137210.\nCompressions:                              116844219.\nPageins:                                  2297232929.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128173.\nPages tagged resident:                         87214.\nPages tagged compressed:                       40959.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5242.\nPages tag-storage free:                          742.\nPages tag-storage non-tag pageable:            92312.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6196352.\nTagged compressions:                          739929.\nTagged decompressions:                        611774.\n"
      }
    },
    {
      "elapsed_seconds": 10.073974500002805,
      "stable_seconds": 10.064856333017815,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25418055680,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24129945600,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   449238.\nPages active:                                 852138.\nPages inactive:                               801339.\nPages speculative:                             78693.\nPages throttled:                                   0.\nPages wired down:                             203806.\nPages purgeable:                                  52.\n\"Translation faults\":                     1968959327.\nPages copy-on-write:                        99082004.\nPages zero filled:                        3236952524.\nPages reactivated:                         173888259.\nPages purged:                               12740500.\nFile-backed pages:                           1023485.\nAnonymous pages:                              708685.\nPages stored in compressor:                  1287092.\nPages occupied by compressor:                 699785.\nDecompressions:                            103139886.\nCompressions:                              116844219.\nPageins:                                  2297233016.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128204.\nPages tagged resident:                         87302.\nPages tagged compressed:                       40902.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5242.\nPages tag-storage free:                          778.\nPages tag-storage non-tag pageable:            92276.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6183680.\nTagged compressions:                          739929.\nTagged decompressions:                        611831.\n"
      }
    },
    {
      "elapsed_seconds": 15.104771249985788,
      "stable_seconds": 15.095653083000798,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25341329408,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24052432896,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   443995.\nPages active:                                 877209.\nPages inactive:                               803174.\nPages speculative:                             78738.\nPages throttled:                                   0.\nPages wired down:                             195479.\nPages purgeable:                                 493.\n\"Translation faults\":                     1968997722.\nPages copy-on-write:                        99082741.\nPages zero filled:                        3237024910.\nPages reactivated:                         173888259.\nPages purged:                               12740500.\nFile-backed pages:                           1023556.\nAnonymous pages:                              735565.\nPages stored in compressor:                  1261637.\nPages occupied by compressor:                 685828.\nDecompressions:                            103164891.\nCompressions:                              116844219.\nPageins:                                  2297233047.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128209.\nPages tagged resident:                         87408.\nPages tagged compressed:                       40801.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5242.\nPages tag-storage free:                         1030.\nPages tag-storage non-tag pageable:            92024.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6163392.\nTagged compressions:                          739929.\nTagged decompressions:                        611932.\n"
      }
    },
    {
      "elapsed_seconds": 20.137096541991923,
      "stable_seconds": 20.127978375006933,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25385779200,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24094556160,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   442454.\nPages active:                                 889668.\nPages inactive:                               809147.\nPages speculative:                             79006.\nPages throttled:                                   0.\nPages wired down:                             181461.\nPages purgeable:                                4284.\n\"Translation faults\":                     1969019684.\nPages copy-on-write:                        99084441.\nPages zero filled:                        3237090063.\nPages reactivated:                         173888266.\nPages purged:                               12740500.\nFile-backed pages:                           1023877.\nAnonymous pages:                              753944.\nPages stored in compressor:                  1256070.\nPages occupied by compressor:                 682639.\nDecompressions:                            103169167.\nCompressions:                              116844219.\nPageins:                                  2297233279.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128170.\nPages tagged resident:                         87389.\nPages tagged compressed:                       40781.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5242.\nPages tag-storage free:                         1128.\nPages tag-storage non-tag pageable:            91926.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6160128.\nTagged compressions:                          739929.\nTagged decompressions:                        611952.\n"
      }
    },
    {
      "elapsed_seconds": 25.16716837498825,
      "stable_seconds": 25.15805020800326,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25163677696,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23826333696,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   417217.\nPages active:                                 892301.\nPages inactive:                               810570.\nPages speculative:                             81693.\nPages throttled:                                   0.\nPages wired down:                             202217.\nPages purgeable:                                8906.\n\"Translation faults\":                     1969065539.\nPages copy-on-write:                        99091276.\nPages zero filled:                        3237175557.\nPages reactivated:                         173888269.\nPages purged:                               12740500.\nFile-backed pages:                           1028121.\nAnonymous pages:                              756443.\nPages stored in compressor:                  1251224.\nPages occupied by compressor:                 680470.\nDecompressions:                            103173614.\nCompressions:                              116844219.\nPageins:                                  2297235434.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128082.\nPages tagged resident:                         87343.\nPages tagged compressed:                       40739.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5242.\nPages tag-storage free:                         1291.\nPages tag-storage non-tag pageable:            91763.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6150656.\nTagged compressions:                          739929.\nTagged decompressions:                        611994.\n"
      }
    },
    {
      "elapsed_seconds": 30.197081958991475,
      "stable_seconds": 30.187963792006485,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25032933376,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23695753216,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   414323.\nPages active:                                 889796.\nPages inactive:                               810017.\nPages speculative:                             81815.\nPages throttled:                                   0.\nPages wired down:                             208807.\nPages purgeable:                                3651.\n\"Translation faults\":                     1969074336.\nPages copy-on-write:                        99092069.\nPages zero filled:                        3237300569.\nPages reactivated:                         173888377.\nPages purged:                               12740501.\nFile-backed pages:                           1028300.\nAnonymous pages:                              753328.\nPages stored in compressor:                  1249539.\nPages occupied by compressor:                 679545.\nDecompressions:                            103175196.\nCompressions:                              116844219.\nPageins:                                  2297235489.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128252.\nPages tagged resident:                         87551.\nPages tagged compressed:                       40701.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5242.\nPages tag-storage free:                         1316.\nPages tag-storage non-tag pageable:            91738.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6141376.\nTagged compressions:                          739929.\nTagged decompressions:                        612032.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/round-1-split/receipt.json

Original bytes: 22212. SHA-256: `cc1a75fb939035a6aac4a79ccd818333654442ab5f46b6020ab759a8c080ee7e`.

Normalized bytes: 22212. SHA-256: `cc1a75fb939035a6aac4a79ccd818333654442ab5f46b6020ab759a8c080ee7e`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.7818104970221116,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9906116250203922,
    3.3145292920235079,
    3.5089746250014286,
    3.6931997500068974,
    3.8690545420104172,
    4.044334667007206,
    4.2155826250091195,
    4.4062195419974159,
    4.580036375002237,
    4.7559296670078766,
    4.9247066670213826,
    5.0731227080104873,
    5.2355644170020241,
    5.3871822500077542,
    5.5700210420181975,
    5.724690458009718,
    5.8621149170212448,
    6.0320850000134669,
    6.1956241670122836,
    6.3864352920209058,
    6.562803333014017,
    6.7293818330217618,
    6.901360250019934,
    7.0797422500036191,
    7.2683030420157593,
    7.4455229169980157,
    7.6120441670063883,
    7.7863298330048565,
    7.9998065420077182,
    8.1897871670080349,
    8.3735207499994431,
    8.5393062500224914,
    8.7298157080076635,
    8.9026432920072693,
    9.0716639170132112,
    9.2482632080209441,
    9.4367670000065118,
    9.6222743750258815,
    9.8010913330072071,
    9.9728431670228019,
    10.139886458026012,
    10.332087500020862,
    10.526351667009294,
    10.705522917007329,
    10.868698875012342,
    11.071420749998651,
    11.272446667018812,
    11.459698208025657,
    11.633195417001843,
    11.796557082998333,
    11.964537917025154,
    12.134603917016648,
    12.304205082997214,
    12.469053417007672,
    12.634962708019884,
    12.839458917005686,
    13.01759154201136,
    13.202083333017072,
    13.363345582998591,
    13.533456542005297,
    13.729041958024027,
    13.906986167014111,
    14.089022375002969,
    14.25889537500916,
    14.461399125022581,
    14.620359417021973,
    14.811855250009103,
    15.002588750008726,
    15.169849666999653,
    15.335629583016271,
    15.519212542014429,
    15.68936124999891,
    15.852899417019216,
    16.011599333025515,
    16.172338625008706,
    16.326609125011601,
    16.470368333015358,
    16.642476875014836,
    16.798994250013493,
    16.943569791998016,
    17.133035792008741,
    17.305509208003059,
    17.488934958004393,
    17.662213750008959,
    17.837439916998846,
    18.004040708008688,
    18.15442216701922,
    18.307949792011641,
    18.495203250000486,
    18.677469208021648,
    18.831907375017181,
    18.991026500007138,
    19.140688917017542,
    19.293308167019859,
    19.447869625000749,
    19.612981417012634,
    19.770565833023284,
    19.925211958005093,
    20.102648542000679,
    20.302379375003511,
    20.477807458024472,
    20.632690250000451,
    20.797198083018884,
    20.957338875014102,
    21.111757667007623,
    21.254379958001664,
    21.426257667015307,
    21.574000082997372,
    21.732557458017254,
    21.882229208014905,
    22.032503499998711,
    22.230679750005947,
    22.419219208008144,
    22.590315417008242,
    22.788496792025398,
    22.956209833006142,
    23.115897792013129,
    23.28564312501112,
    23.43925979200867,
    23.606981625023764,
    23.798866375000216,
    23.983918500016443,
    24.13848758302629,
    24.284930833004182,
    24.444075375009561,
    24.607782958017197,
    24.793971375009278,
    24.956049625005107
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 24888999936,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.32391766700311564,
    0.19444533297792077,
    0.18422512500546873,
    0.17585479200351983,
    0.1752801249967888,
    0.1712479580019135,
    0.19063691698829643,
    0.17381683300482109,
    0.17589329200563952,
    0.16877700001350604,
    0.14841604098910466,
    0.16244170899153687,
    0.15161783300573006,
    0.18283879201044329,
    0.15466941599152051,
    0.13742445901152678,
    0.16997008299222216,
    0.16353916699881665,
    0.19081112500862218,
    0.17636804099311121,
    0.16657850000774488,
    0.17197841699817218,
    0.17838199998368509,
    0.18856079201214015,
    0.17721987498225644,
    0.16652125000837259,
    0.17428566599846818,
    0.21347670900286175,
    0.18998062500031665,
    0.18373358299140818,
    0.16578550002304837,
    0.19050945798517205,
    0.17282758399960585,
    0.16902062500594184,
    0.17659929100773297,
    0.18850379198556766,
    0.18550737501936965,
    0.17881695798132569,
    0.1717518340155948,
    0.16704329100321047,
    0.19220104199484922,
    0.19426416698843241,
    0.17917124999803491,
    0.16317595800501294,
    0.20272187498630956,
    0.2010259170201607,
    0.18725154100684449,
    0.17349720897618681,
    0.16336166599649005,
    0.16798083402682096,
    0.1700659999914933,
    0.16960116598056629,
    0.16484833401045762,
    0.16590929101221263,
    0.20449620898580179,
    0.17813262500567362,
    0.184491791005712,
    0.16126224998151883,
    0.17011095900670625,
    0.19558541601873003,
    0.17794420899008401,
    0.18203620798885822,
    0.16987300000619143,
    0.20250375001342036,
    0.15896029199939221,
    0.19149583298712969,
    0.19073349999962375,
    0.16726091699092649,
    0.16577991601661779,
    0.18358295899815857,
    0.17014870798448101,
    0.16353816702030599,
    0.15869991600629874,
    0.16073929198319092,
    0.15427050000289455,
    0.14375920800375752,
    0.17210854199947789,
    0.15651737499865703,
    0.14457554198452272,
    0.18946600001072511,
    0.1724734159943182,
    0.18342575000133365,
    0.17327879200456664,
    0.17522616698988713,
    0.16660079100984149,
    0.15038145901053213,
    0.1535276249924209,
    0.18725345798884518,
    0.18226595802116208,
    0.15443816699553281,
    0.15911912498995662,
    0.14966241701040417,
    0.15261925000231713,
    0.15456145798088983,
    0.16511179201188497,
    0.15758441601064987,
    0.15464612498180941,
    0.17743658399558626,
    0.19973083300283179,
    0.17542808302096091,
    0.15488279197597876,
    0.1645078330184333,
    0.16014079199521802,
    0.15441879199352115,
    0.14262229099404067,
    0.17187770901364274,
    0.14774241598206572,
    0.15855737501988187,
    0.1496717499976512,
    0.1502742919838056,
    0.19817625000723638,
    0.18853945800219662,
    0.17109620900009759,
    0.19818137501715682,
    0.16771304098074324,
    0.15968795900698751,
    0.16974533299799077,
    0.15361666699755006,
    0.16772183301509358,
    0.19188474997645244,
    0.18505212501622736,
    0.15456908300984651,
    0.14644324997789226,
    0.15914454200537875,
    0.16370758300763555,
    0.18618841699208133,
    0.16207824999582954
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.492683999997098,
  "metadata_seconds" : 0.13444395799888298,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7728683056,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 24.956068917002995,
  "request_vm_after" : {
    "reclaimableBytes" : 18478694400,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17153556480,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 2.9906116250203922,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-1-split-supervision/identity.json

Original bytes: 3183. SHA-256: `d454c6a5bd37bf69960efb8e62478e5b8270acf46ac1072dcad70e722adc0db7`.

Normalized bytes: 3127. SHA-256: `9c161b564a9c0f288a969f54dd5a5f8e9c6787e298f0adef727a9c8f64c64e36`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/split-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/round-1-split",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-split/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23797579776,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   420537.\nPages active:                                 889905.\nPages inactive:                               810016.\nPages speculative:                             81815.\nPages throttled:                                   0.\nPages wired down:                             202366.\nPages purgeable:                                3651.\n\"Translation faults\":                     1969079648.\nPages copy-on-write:                        99092859.\nPages zero filled:                        3237302869.\nPages reactivated:                         173888377.\nPages purged:                               12740503.\nFile-backed pages:                           1028301.\nAnonymous pages:                              753435.\nPages stored in compressor:                  1249484.\nPages occupied by compressor:                 679511.\nDecompressions:                            103175233.\nCompressions:                              116844219.\nPageins:                                  2297235495.\nPageouts:                                     485843.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128249.\nPages tagged resident:                         87551.\nPages tagged compressed:                       40698.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5242.\nPages tag-storage free:                         1315.\nPages tag-storage non-tag pageable:            91739.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6140672.\nTagged compressions:                          739929.\nTagged decompressions:                        612035.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/round-1-split-supervision/receipt.json

Original bytes: 2140. SHA-256: `f7e59d37b05b9d1eb6d73297eb442201bdd871561d7dad12793b627fa27bb80b`.

Normalized bytes: 2140. SHA-256: `f7e59d37b05b9d1eb6d73297eb442201bdd871561d7dad12793b627fa27bb80b`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7728683056,
  "samples": 1462,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24741789696,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470101.\nPages active:                                 862876.\nPages inactive:                               797074.\nPages speculative:                             83711.\nPages throttled:                                   0.\nPages wired down:                             182955.\nPages purgeable:                                 972.\n\"Translation faults\":                     1969890587.\nPages copy-on-write:                        99135825.\nPages zero filled:                        3238844697.\nPages reactivated:                         173941622.\nPages purged:                               12746332.\nFile-backed pages:                           1039046.\nAnonymous pages:                              704615.\nPages stored in compressor:                  1305686.\nPages occupied by compressor:                 688182.\nDecompressions:                            103417747.\nCompressions:                              117181520.\nPageins:                                  2307726077.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 130551.\nPages tagged resident:                         86345.\nPages tagged compressed:                       44206.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          745.\nPages tag-storage non-tag pageable:            92314.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6704512.\nTagged compressions:                          744852.\nTagged decompressions:                        613447.\n"
  },
  "seconds": 84.70533079199959
}
````

### vq-contiguous-cost-v1/round-1-split-supervision/stdout.txt

Original bytes: 22213. SHA-256: `31b1f9b8d94ab924cb1eb8f6f09fc2d608992c1c689502c806c6848f18da43b1`.

Normalized bytes: 22213. SHA-256: `31b1f9b8d94ab924cb1eb8f6f09fc2d608992c1c689502c806c6848f18da43b1`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.7818104970221116,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9906116250203922,
    3.3145292920235079,
    3.5089746250014286,
    3.6931997500068974,
    3.8690545420104172,
    4.044334667007206,
    4.2155826250091195,
    4.4062195419974159,
    4.580036375002237,
    4.7559296670078766,
    4.9247066670213826,
    5.0731227080104873,
    5.2355644170020241,
    5.3871822500077542,
    5.5700210420181975,
    5.724690458009718,
    5.8621149170212448,
    6.0320850000134669,
    6.1956241670122836,
    6.3864352920209058,
    6.562803333014017,
    6.7293818330217618,
    6.901360250019934,
    7.0797422500036191,
    7.2683030420157593,
    7.4455229169980157,
    7.6120441670063883,
    7.7863298330048565,
    7.9998065420077182,
    8.1897871670080349,
    8.3735207499994431,
    8.5393062500224914,
    8.7298157080076635,
    8.9026432920072693,
    9.0716639170132112,
    9.2482632080209441,
    9.4367670000065118,
    9.6222743750258815,
    9.8010913330072071,
    9.9728431670228019,
    10.139886458026012,
    10.332087500020862,
    10.526351667009294,
    10.705522917007329,
    10.868698875012342,
    11.071420749998651,
    11.272446667018812,
    11.459698208025657,
    11.633195417001843,
    11.796557082998333,
    11.964537917025154,
    12.134603917016648,
    12.304205082997214,
    12.469053417007672,
    12.634962708019884,
    12.839458917005686,
    13.01759154201136,
    13.202083333017072,
    13.363345582998591,
    13.533456542005297,
    13.729041958024027,
    13.906986167014111,
    14.089022375002969,
    14.25889537500916,
    14.461399125022581,
    14.620359417021973,
    14.811855250009103,
    15.002588750008726,
    15.169849666999653,
    15.335629583016271,
    15.519212542014429,
    15.68936124999891,
    15.852899417019216,
    16.011599333025515,
    16.172338625008706,
    16.326609125011601,
    16.470368333015358,
    16.642476875014836,
    16.798994250013493,
    16.943569791998016,
    17.133035792008741,
    17.305509208003059,
    17.488934958004393,
    17.662213750008959,
    17.837439916998846,
    18.004040708008688,
    18.15442216701922,
    18.307949792011641,
    18.495203250000486,
    18.677469208021648,
    18.831907375017181,
    18.991026500007138,
    19.140688917017542,
    19.293308167019859,
    19.447869625000749,
    19.612981417012634,
    19.770565833023284,
    19.925211958005093,
    20.102648542000679,
    20.302379375003511,
    20.477807458024472,
    20.632690250000451,
    20.797198083018884,
    20.957338875014102,
    21.111757667007623,
    21.254379958001664,
    21.426257667015307,
    21.574000082997372,
    21.732557458017254,
    21.882229208014905,
    22.032503499998711,
    22.230679750005947,
    22.419219208008144,
    22.590315417008242,
    22.788496792025398,
    22.956209833006142,
    23.115897792013129,
    23.28564312501112,
    23.43925979200867,
    23.606981625023764,
    23.798866375000216,
    23.983918500016443,
    24.13848758302629,
    24.284930833004182,
    24.444075375009561,
    24.607782958017197,
    24.793971375009278,
    24.956049625005107
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 24888999936,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.32391766700311564,
    0.19444533297792077,
    0.18422512500546873,
    0.17585479200351983,
    0.1752801249967888,
    0.1712479580019135,
    0.19063691698829643,
    0.17381683300482109,
    0.17589329200563952,
    0.16877700001350604,
    0.14841604098910466,
    0.16244170899153687,
    0.15161783300573006,
    0.18283879201044329,
    0.15466941599152051,
    0.13742445901152678,
    0.16997008299222216,
    0.16353916699881665,
    0.19081112500862218,
    0.17636804099311121,
    0.16657850000774488,
    0.17197841699817218,
    0.17838199998368509,
    0.18856079201214015,
    0.17721987498225644,
    0.16652125000837259,
    0.17428566599846818,
    0.21347670900286175,
    0.18998062500031665,
    0.18373358299140818,
    0.16578550002304837,
    0.19050945798517205,
    0.17282758399960585,
    0.16902062500594184,
    0.17659929100773297,
    0.18850379198556766,
    0.18550737501936965,
    0.17881695798132569,
    0.1717518340155948,
    0.16704329100321047,
    0.19220104199484922,
    0.19426416698843241,
    0.17917124999803491,
    0.16317595800501294,
    0.20272187498630956,
    0.2010259170201607,
    0.18725154100684449,
    0.17349720897618681,
    0.16336166599649005,
    0.16798083402682096,
    0.1700659999914933,
    0.16960116598056629,
    0.16484833401045762,
    0.16590929101221263,
    0.20449620898580179,
    0.17813262500567362,
    0.184491791005712,
    0.16126224998151883,
    0.17011095900670625,
    0.19558541601873003,
    0.17794420899008401,
    0.18203620798885822,
    0.16987300000619143,
    0.20250375001342036,
    0.15896029199939221,
    0.19149583298712969,
    0.19073349999962375,
    0.16726091699092649,
    0.16577991601661779,
    0.18358295899815857,
    0.17014870798448101,
    0.16353816702030599,
    0.15869991600629874,
    0.16073929198319092,
    0.15427050000289455,
    0.14375920800375752,
    0.17210854199947789,
    0.15651737499865703,
    0.14457554198452272,
    0.18946600001072511,
    0.1724734159943182,
    0.18342575000133365,
    0.17327879200456664,
    0.17522616698988713,
    0.16660079100984149,
    0.15038145901053213,
    0.1535276249924209,
    0.18725345798884518,
    0.18226595802116208,
    0.15443816699553281,
    0.15911912498995662,
    0.14966241701040417,
    0.15261925000231713,
    0.15456145798088983,
    0.16511179201188497,
    0.15758441601064987,
    0.15464612498180941,
    0.17743658399558626,
    0.19973083300283179,
    0.17542808302096091,
    0.15488279197597876,
    0.1645078330184333,
    0.16014079199521802,
    0.15441879199352115,
    0.14262229099404067,
    0.17187770901364274,
    0.14774241598206572,
    0.15855737501988187,
    0.1496717499976512,
    0.1502742919838056,
    0.19817625000723638,
    0.18853945800219662,
    0.17109620900009759,
    0.19818137501715682,
    0.16771304098074324,
    0.15968795900698751,
    0.16974533299799077,
    0.15361666699755006,
    0.16772183301509358,
    0.19188474997645244,
    0.18505212501622736,
    0.15456908300984651,
    0.14644324997789226,
    0.15914454200537875,
    0.16370758300763555,
    0.18618841699208133,
    0.16207824999582954
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.492683999997098,
  "metadata_seconds" : 0.13444395799888298,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7728683056,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 24.956068917002995,
  "request_vm_after" : {
    "reclaimableBytes" : 18478694400,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17153556480,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 2.9906116250203922,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-1-split-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-v1/round-1-contiguous-admission.json

Original bytes: 17280. SHA-256: `d206725995519e8e7276def02bd3364a6edfa86a9c6bba29194f4be5a5929d9c`.

Normalized bytes: 17280. SHA-256: `d206725995519e8e7276def02bd3364a6edfa86a9c6bba29194f4be5a5929d9c`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.009635624999646097,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26115522560,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24743837696,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469806.\nPages active:                                 848608.\nPages inactive:                               811745.\nPages speculative:                             83731.\nPages throttled:                                   0.\nPages wired down:                             182955.\nPages purgeable:                                 972.\n\"Translation faults\":                     1969892358.\nPages copy-on-write:                        99136126.\nPages zero filled:                        3238844860.\nPages reactivated:                         173941622.\nPages purged:                               12746332.\nFile-backed pages:                           1039466.\nAnonymous pages:                              704618.\nPages stored in compressor:                  1305680.\nPages occupied by compressor:                 688179.\nDecompressions:                            103417757.\nCompressions:                              117181520.\nPageins:                                  2307726306.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 130551.\nPages tagged resident:                         86345.\nPages tagged compressed:                       44206.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          781.\nPages tag-storage non-tag pageable:            92278.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6704512.\nTagged compressions:                          744852.\nTagged decompressions:                        613447.\n"
      }
    },
    {
      "elapsed_seconds": 5.041465749993222,
      "stable_seconds": 5.031830124993576,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26116554752,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24744034304,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469774.\nPages active:                                 849968.\nPages inactive:                               811681.\nPages speculative:                             83786.\nPages throttled:                                   0.\nPages wired down:                             181752.\nPages purgeable:                                 956.\n\"Translation faults\":                     1969896883.\nPages copy-on-write:                        99136802.\nPages zero filled:                        3238846053.\nPages reactivated:                         173941624.\nPages purged:                               12746332.\nFile-backed pages:                           1039526.\nAnonymous pages:                              705909.\nPages stored in compressor:                  1305111.\nPages occupied by compressor:                 688054.\nDecompressions:                            103417972.\nCompressions:                              117181520.\nPageins:                                  2307726357.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 130373.\nPages tagged resident:                         86252.\nPages tagged compressed:                       44121.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          702.\nPages tag-storage non-tag pageable:            92357.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6691648.\nTagged compressions:                          744852.\nTagged decompressions:                        613532.\n"
      }
    },
    {
      "elapsed_seconds": 10.071064749994548,
      "stable_seconds": 10.061429124994902,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26117570560,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24742838272,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469622.\nPages active:                                 851667.\nPages inactive:                               813070.\nPages speculative:                             83849.\nPages throttled:                                   0.\nPages wired down:                             179207.\nPages purgeable:                                 962.\n\"Translation faults\":                     1969903686.\nPages copy-on-write:                        99137504.\nPages zero filled:                        3238848017.\nPages reactivated:                         173941630.\nPages purged:                               12746332.\nFile-backed pages:                           1039599.\nAnonymous pages:                              708987.\nPages stored in compressor:                  1304368.\nPages occupied by compressor:                 687790.\nDecompressions:                            103418302.\nCompressions:                              117181520.\nPageins:                                  2307726412.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 130427.\nPages tagged resident:                         86316.\nPages tagged compressed:                       44111.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          534.\nPages tag-storage non-tag pageable:            92525.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6690368.\nTagged compressions:                          744852.\nTagged decompressions:                        613541.\n"
      }
    },
    {
      "elapsed_seconds": 15.093725542013999,
      "stable_seconds": 15.084089917014353,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26106167296,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24730599424,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   468723.\nPages active:                                 849364.\nPages inactive:                               814028.\nPages speculative:                             83981.\nPages throttled:                                   0.\nPages wired down:                             181718.\nPages purgeable:                                 974.\n\"Translation faults\":                     1969913992.\nPages copy-on-write:                        99138180.\nPages zero filled:                        3238851725.\nPages reactivated:                         173941630.\nPages purged:                               12746332.\nFile-backed pages:                           1039739.\nAnonymous pages:                              707634.\nPages stored in compressor:                  1303761.\nPages occupied by compressor:                 687531.\nDecompressions:                            103418849.\nCompressions:                              117181520.\nPageins:                                  2307726509.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 130426.\nPages tagged resident:                         86316.\nPages tagged compressed:                       44110.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          461.\nPages tag-storage non-tag pageable:            92598.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6690304.\nTagged compressions:                          744852.\nTagged decompressions:                        613542.\n"
      }
    },
    {
      "elapsed_seconds": 20.125339374993928,
      "stable_seconds": 20.11570374999428,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26087292928,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24706072576,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   467073.\nPages active:                                 852385.\nPages inactive:                               815190.\nPages speculative:                             84111.\nPages throttled:                                   0.\nPages wired down:                             182563.\nPages purgeable:                                 974.\n\"Translation faults\":                     1969932058.\nPages copy-on-write:                        99138901.\nPages zero filled:                        3238854113.\nPages reactivated:                         173941630.\nPages purged:                               12746332.\nFile-backed pages:                           1039892.\nAnonymous pages:                              711794.\nPages stored in compressor:                  1296272.\nPages occupied by compressor:                 683672.\nDecompressions:                            103424809.\nCompressions:                              117181520.\nPageins:                                  2307726620.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 129298.\nPages tagged resident:                         86005.\nPages tagged compressed:                       43293.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          428.\nPages tag-storage non-tag pageable:            92631.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6537728.\nTagged compressions:                          744852.\nTagged decompressions:                        613813.\n"
      }
    },
    {
      "elapsed_seconds": 25.157287250010995,
      "stable_seconds": 25.14765162501135,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26085720064,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24708448256,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   467201.\nPages active:                                 854615.\nPages inactive:                               817093.\nPages speculative:                             84139.\nPages throttled:                                   0.\nPages wired down:                             178985.\nPages purgeable:                                 958.\n\"Translation faults\":                     1969939606.\nPages copy-on-write:                        99139625.\nPages zero filled:                        3238856430.\nPages reactivated:                         173941630.\nPages purged:                               12746332.\nFile-backed pages:                           1039925.\nAnonymous pages:                              715922.\nPages stored in compressor:                  1295812.\nPages occupied by compressor:                 683400.\nDecompressions:                            103425211.\nCompressions:                              117181520.\nPageins:                                  2307726634.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 129321.\nPages tagged resident:                         86029.\nPages tagged compressed:                       43292.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          369.\nPages tag-storage non-tag pageable:            92690.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6537664.\nTagged compressions:                          744852.\nTagged decompressions:                        613814.\n"
      }
    },
    {
      "elapsed_seconds": 30.189762916998006,
      "stable_seconds": 30.18012729199836,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26075643904,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24692785152,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   465903.\nPages active:                                 856735.\nPages inactive:                               815730.\nPages speculative:                             84349.\nPages throttled:                                   0.\nPages wired down:                             178978.\nPages purgeable:                                1062.\n\"Translation faults\":                     1969954643.\nPages copy-on-write:                        99141178.\nPages zero filled:                        3238860251.\nPages reactivated:                         173941639.\nPages purged:                               12746338.\nFile-backed pages:                           1040163.\nAnonymous pages:                              716651.\nPages stored in compressor:                  1295542.\nPages occupied by compressor:                 683316.\nDecompressions:                            103425485.\nCompressions:                              117181520.\nPageins:                                  2307726659.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 129281.\nPages tagged resident:                         85994.\nPages tagged compressed:                       43287.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          336.\nPages tag-storage non-tag pageable:            92723.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6537344.\nTagged compressions:                          744852.\nTagged decompressions:                        613818.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/round-1-contiguous/receipt.json

Original bytes: 22319. SHA-256: `34cfe4358dc32fed8b9dbdd1937eb937cfb72db63d7f06eec1f242307bb80f67`.

Normalized bytes: 22319. SHA-256: `34cfe4358dc32fed8b9dbdd1937eb937cfb72db63d7f06eec1f242307bb80f67`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.8757488348338116,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9330649170151446,
    3.2364486249862239,
    3.4050837919930927,
    3.5593237080029212,
    3.704942749987822,
    3.8501403330010362,
    3.9960687079874333,
    4.155954624991864,
    4.3071612080093473,
    4.4616126249893568,
    4.600436417007586,
    4.72704079200048,
    4.864021249988582,
    4.9890382919984404,
    5.1449113750131801,
    5.2710532500059344,
    5.388499166991096,
    5.5267158749920782,
    5.6621362080040853,
    5.8170780419895891,
    5.9613515000091866,
    6.0936167920008302,
    6.234599082992645,
    6.3843473749875557,
    6.5438926249917131,
    6.6864676249970216,
    6.8304335830034688,
    6.9741373750148341,
    7.1579436250030994,
    7.3187651250045747,
    7.4707984999986365,
    7.6068287499947473,
    7.7689158330031205,
    7.9185479170118924,
    8.063770333013963,
    8.217316333000781,
    8.3773330000112765,
    8.5319187499990221,
    8.6794114999938756,
    8.8223147079988848,
    8.9593591669981834,
    9.1156412920099683,
    9.279038083011983,
    9.431412583013298,
    9.5653449580131564,
    9.7459898329980206,
    9.9153654169931542,
    10.063779874995816,
    10.207044125010725,
    10.342497042001924,
    10.477563041989924,
    10.616715375013882,
    10.758977958001196,
    10.903023541992297,
    11.041804000007687,
    11.215616083005443,
    11.361357832996873,
    11.51757720799651,
    11.651760042004753,
    11.788669750007102,
    11.947224250005092,
    12.093359082995448,
    12.24588554201182,
    12.381122916995082,
    12.549535958009074,
    12.677477124991128,
    12.833133125008317,
    12.988184332993114,
    13.121744375006529,
    13.253084416995989,
    13.403639875003137,
    13.546559083013562,
    13.687192542012781,
    13.823072583007161,
    13.954824791988358,
    14.083684042008827,
    14.207756749994587,
    14.387176041986095,
    14.635078833001899,
    14.773273083003005,
    14.931578249990707,
    15.072574207995785,
    15.225319666991709,
    15.373508874996332,
    15.522441167006036,
    15.660044082993409,
    15.781669249990955,
    15.916637582995463,
    16.072879457991803,
    16.221055542002432,
    16.352666791994125,
    16.481385749997571,
    16.605718875012826,
    16.726622749993112,
    16.857252957997844,
    16.998238166997908,
    17.124453291995451,
    17.252935833006632,
    17.402214041998377,
    17.565882875001989,
    17.704692416999023,
    17.834346791991265,
    17.98235270800069,
    18.118481792014791,
    18.246484125003917,
    18.364275667001493,
    18.505779875005828,
    18.628262082987931,
    18.758316708001075,
    18.880818875011755,
    19.001266458013561,
    19.167446500010556,
    19.329086792015005,
    19.468197208014317,
    19.608028416987509,
    19.745796917006373,
    19.876951624988578,
    20.023595042002853,
    20.157190416997764,
    20.295705541997449,
    20.451970249996521,
    20.602745417010738,
    20.735902332991827,
    20.856370291992789,
    20.991464082995662,
    21.12333858301281,
    21.271499374997802,
    21.403780332999304
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25610485760,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.30338370797107928,
    0.16863516700686887,
    0.15423991600982845,
    0.14561904198490083,
    0.14519758301321417,
    0.1459283749863971,
    0.15988591700443067,
    0.15120658301748335,
    0.15445141698000953,
    0.13882379201822914,
    0.12660437499289401,
    0.13698045798810199,
    0.12501704200985841,
    0.15587308301473968,
    0.12614187499275431,
    0.1174459169851616,
    0.13821670800098218,
    0.13542033301200718,
    0.15494183398550376,
    0.14427345801959746,
    0.13226529199164361,
    0.14098229099181481,
    0.14974829199491069,
    0.15954525000415742,
    0.14257500000530854,
    0.14396595800644718,
    0.14370379201136529,
    0.18380624998826534,
    0.16082150000147521,
    0.15203337499406189,
    0.1360302499961108,
    0.16208708300837316,
    0.14963208400877193,
    0.14522241600207053,
    0.15354599998681806,
    0.16001666701049544,
    0.15458574998774566,
    0.14749274999485351,
    0.14290320800500922,
    0.13704445899929851,
    0.15628212501178496,
    0.16339679100201465,
    0.15237450000131503,
    0.13393237499985844,
    0.18064487498486415,
    0.16937558399513364,
    0.14841445800266229,
    0.14326425001490861,
    0.13545291699119844,
    0.13506599998800084,
    0.13915233302395791,
    0.14226258298731409,
    0.14404558399110101,
    0.13878045801538974,
    0.17381208299775608,
    0.14574174999142997,
    0.15621937499963678,
    0.13418283400824293,
    0.13690970800234936,
    0.15855449999799021,
    0.14613483299035579,
    0.15252645901637152,
    0.13523737498326227,
    0.16841304101399146,
    0.12794116698205471,
    0.15565600001718849,
    0.15505120798479766,
    0.1335600420134142,
    0.13134004198946059,
    0.15055545800714754,
    0.14291920801042579,
    0.14063345899921842,
    0.13588004099437967,
    0.13175220898119733,
    0.12885925002046861,
    0.12407270798576064,
    0.17941929199150763,
    0.24790279101580381,
    0.13819425000110641,
    0.15830516698770225,
    0.14099595800507814,
    0.1527454589959234,
    0.14818920800462365,
    0.14893229200970381,
    0.1376029159873724,
    0.12162516699754633,
    0.13496833300450817,
    0.1562418749963399,
    0.14817608401062898,
    0.1316112499916926,
    0.12871895800344646,
    0.12433312501525506,
    0.12090387498028576,
    0.13063020800473168,
    0.14098520900006406,
    0.12621512499754317,
    0.12848254101118073,
    0.14927820899174549,
    0.16366883300361224,
    0.1388095419970341,
    0.12965437499224208,
    0.14800591600942425,
    0.13612908401410095,
    0.12800233298912644,
    0.11779154199757613,
    0.14150420800433494,
    0.12248220798210241,
    0.13005462501314469,
    0.12250216701067984,
    0.12044758300180547,
    0.16618004199699499,
    0.16164029200444929,
    0.13911041599931195,
    0.13983120897319168,
    0.13776850001886487,
    0.13115470798220485,
    0.14664341701427475,
    0.13359537499491125,
    0.13851512499968521,
    0.15626470799907111,
    0.150775167014217,
    0.1331569159810897,
    0.12046795900096186,
    0.13509379100287333,
    0.13187450001714751,
    0.1481607919849921,
    0.13228095800150186
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 76.819655290979426,
  "metadata_seconds" : 0.13385720900259912,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7756028000,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 21.403800750005757,
  "request_vm_after" : {
    "reclaimableBytes" : 17440473088,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17636212736,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 2.9330649170151446,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-1-contiguous-supervision/identity.json

Original bytes: 3326. SHA-256: `b2273e8d40dd9ab80593a088af65710d9756891a2e18135820ca0e381b03ad4b`.

Normalized bytes: 3263. SHA-256: `8c5cd6482df133f6d603298db47c2b80f345c758e948d72dbf11aed49ac1993c`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/contiguous-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/round-1-contiguous",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--packed-record-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-contiguous/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24697847808,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   466211.\nPages active:                                 856738.\nPages inactive:                               815779.\nPages speculative:                             84349.\nPages throttled:                                   0.\nPages wired down:                             178978.\nPages purgeable:                                1062.\n\"Translation faults\":                     1969960308.\nPages copy-on-write:                        99141974.\nPages zero filled:                        3238862514.\nPages reactivated:                         173941639.\nPages purged:                               12746338.\nFile-backed pages:                           1040164.\nAnonymous pages:                              716702.\nPages stored in compressor:                  1295515.\nPages occupied by compressor:                 683294.\nDecompressions:                            103425524.\nCompressions:                              117181520.\nPageins:                                  2307726665.\nPageouts:                                     486467.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 129281.\nPages tagged resident:                         85994.\nPages tagged compressed:                       43287.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5237.\nPages tag-storage free:                          346.\nPages tag-storage non-tag pageable:            92713.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6537344.\nTagged compressions:                          744852.\nTagged decompressions:                        613818.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/round-1-contiguous-supervision/receipt.json

Original bytes: 2140. SHA-256: `9ca242b3428532d9d0eaea098edcb8f2b4b2e1fcf6419b9a68ad8414d61d78a3`.

Normalized bytes: 2140. SHA-256: `9ca242b3428532d9d0eaea098edcb8f2b4b2e1fcf6419b9a68ad8414d61d78a3`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7756028000,
  "samples": 1695,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24766545920,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   473352.\nPages active:                                 864395.\nPages inactive:                               851694.\nPages speculative:                             25698.\nPages throttled:                                   0.\nPages wired down:                             181481.\nPages purgeable:                                4753.\n\"Translation faults\":                     1972938147.\nPages copy-on-write:                        99174582.\nPages zero filled:                        3240130578.\nPages reactivated:                         174004929.\nPages purged:                               12757981.\nFile-backed pages:                           1033525.\nAnonymous pages:                              708262.\nPages stored in compressor:                  1300529.\nPages occupied by compressor:                 688333.\nDecompressions:                            103675131.\nCompressions:                              117485633.\nPageins:                                  2321644195.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128072.\nPages tagged resident:                         84226.\nPages tagged compressed:                       43846.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          593.\nPages tag-storage non-tag pageable:            92473.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6706240.\nTagged compressions:                          746391.\nTagged decompressions:                        614272.\n"
  },
  "seconds": 98.53081729100086
}
````

### vq-contiguous-cost-v1/round-1-contiguous-supervision/stdout.txt

Original bytes: 22320. SHA-256: `b23879382ecea5b2bed336e7a623d578a06e2c6bd0e5fb317a6eff58473d9776`.

Normalized bytes: 22320. SHA-256: `b23879382ecea5b2bed336e7a623d578a06e2c6bd0e5fb317a6eff58473d9776`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.8757488348338116,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9330649170151446,
    3.2364486249862239,
    3.4050837919930927,
    3.5593237080029212,
    3.704942749987822,
    3.8501403330010362,
    3.9960687079874333,
    4.155954624991864,
    4.3071612080093473,
    4.4616126249893568,
    4.600436417007586,
    4.72704079200048,
    4.864021249988582,
    4.9890382919984404,
    5.1449113750131801,
    5.2710532500059344,
    5.388499166991096,
    5.5267158749920782,
    5.6621362080040853,
    5.8170780419895891,
    5.9613515000091866,
    6.0936167920008302,
    6.234599082992645,
    6.3843473749875557,
    6.5438926249917131,
    6.6864676249970216,
    6.8304335830034688,
    6.9741373750148341,
    7.1579436250030994,
    7.3187651250045747,
    7.4707984999986365,
    7.6068287499947473,
    7.7689158330031205,
    7.9185479170118924,
    8.063770333013963,
    8.217316333000781,
    8.3773330000112765,
    8.5319187499990221,
    8.6794114999938756,
    8.8223147079988848,
    8.9593591669981834,
    9.1156412920099683,
    9.279038083011983,
    9.431412583013298,
    9.5653449580131564,
    9.7459898329980206,
    9.9153654169931542,
    10.063779874995816,
    10.207044125010725,
    10.342497042001924,
    10.477563041989924,
    10.616715375013882,
    10.758977958001196,
    10.903023541992297,
    11.041804000007687,
    11.215616083005443,
    11.361357832996873,
    11.51757720799651,
    11.651760042004753,
    11.788669750007102,
    11.947224250005092,
    12.093359082995448,
    12.24588554201182,
    12.381122916995082,
    12.549535958009074,
    12.677477124991128,
    12.833133125008317,
    12.988184332993114,
    13.121744375006529,
    13.253084416995989,
    13.403639875003137,
    13.546559083013562,
    13.687192542012781,
    13.823072583007161,
    13.954824791988358,
    14.083684042008827,
    14.207756749994587,
    14.387176041986095,
    14.635078833001899,
    14.773273083003005,
    14.931578249990707,
    15.072574207995785,
    15.225319666991709,
    15.373508874996332,
    15.522441167006036,
    15.660044082993409,
    15.781669249990955,
    15.916637582995463,
    16.072879457991803,
    16.221055542002432,
    16.352666791994125,
    16.481385749997571,
    16.605718875012826,
    16.726622749993112,
    16.857252957997844,
    16.998238166997908,
    17.124453291995451,
    17.252935833006632,
    17.402214041998377,
    17.565882875001989,
    17.704692416999023,
    17.834346791991265,
    17.98235270800069,
    18.118481792014791,
    18.246484125003917,
    18.364275667001493,
    18.505779875005828,
    18.628262082987931,
    18.758316708001075,
    18.880818875011755,
    19.001266458013561,
    19.167446500010556,
    19.329086792015005,
    19.468197208014317,
    19.608028416987509,
    19.745796917006373,
    19.876951624988578,
    20.023595042002853,
    20.157190416997764,
    20.295705541997449,
    20.451970249996521,
    20.602745417010738,
    20.735902332991827,
    20.856370291992789,
    20.991464082995662,
    21.12333858301281,
    21.271499374997802,
    21.403780332999304
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25610485760,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.30338370797107928,
    0.16863516700686887,
    0.15423991600982845,
    0.14561904198490083,
    0.14519758301321417,
    0.1459283749863971,
    0.15988591700443067,
    0.15120658301748335,
    0.15445141698000953,
    0.13882379201822914,
    0.12660437499289401,
    0.13698045798810199,
    0.12501704200985841,
    0.15587308301473968,
    0.12614187499275431,
    0.1174459169851616,
    0.13821670800098218,
    0.13542033301200718,
    0.15494183398550376,
    0.14427345801959746,
    0.13226529199164361,
    0.14098229099181481,
    0.14974829199491069,
    0.15954525000415742,
    0.14257500000530854,
    0.14396595800644718,
    0.14370379201136529,
    0.18380624998826534,
    0.16082150000147521,
    0.15203337499406189,
    0.1360302499961108,
    0.16208708300837316,
    0.14963208400877193,
    0.14522241600207053,
    0.15354599998681806,
    0.16001666701049544,
    0.15458574998774566,
    0.14749274999485351,
    0.14290320800500922,
    0.13704445899929851,
    0.15628212501178496,
    0.16339679100201465,
    0.15237450000131503,
    0.13393237499985844,
    0.18064487498486415,
    0.16937558399513364,
    0.14841445800266229,
    0.14326425001490861,
    0.13545291699119844,
    0.13506599998800084,
    0.13915233302395791,
    0.14226258298731409,
    0.14404558399110101,
    0.13878045801538974,
    0.17381208299775608,
    0.14574174999142997,
    0.15621937499963678,
    0.13418283400824293,
    0.13690970800234936,
    0.15855449999799021,
    0.14613483299035579,
    0.15252645901637152,
    0.13523737498326227,
    0.16841304101399146,
    0.12794116698205471,
    0.15565600001718849,
    0.15505120798479766,
    0.1335600420134142,
    0.13134004198946059,
    0.15055545800714754,
    0.14291920801042579,
    0.14063345899921842,
    0.13588004099437967,
    0.13175220898119733,
    0.12885925002046861,
    0.12407270798576064,
    0.17941929199150763,
    0.24790279101580381,
    0.13819425000110641,
    0.15830516698770225,
    0.14099595800507814,
    0.1527454589959234,
    0.14818920800462365,
    0.14893229200970381,
    0.1376029159873724,
    0.12162516699754633,
    0.13496833300450817,
    0.1562418749963399,
    0.14817608401062898,
    0.1316112499916926,
    0.12871895800344646,
    0.12433312501525506,
    0.12090387498028576,
    0.13063020800473168,
    0.14098520900006406,
    0.12621512499754317,
    0.12848254101118073,
    0.14927820899174549,
    0.16366883300361224,
    0.1388095419970341,
    0.12965437499224208,
    0.14800591600942425,
    0.13612908401410095,
    0.12800233298912644,
    0.11779154199757613,
    0.14150420800433494,
    0.12248220798210241,
    0.13005462501314469,
    0.12250216701067984,
    0.12044758300180547,
    0.16618004199699499,
    0.16164029200444929,
    0.13911041599931195,
    0.13983120897319168,
    0.13776850001886487,
    0.13115470798220485,
    0.14664341701427475,
    0.13359537499491125,
    0.13851512499968521,
    0.15626470799907111,
    0.150775167014217,
    0.1331569159810897,
    0.12046795900096186,
    0.13509379100287333,
    0.13187450001714751,
    0.1481607919849921,
    0.13228095800150186
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 76.819655290979426,
  "metadata_seconds" : 0.13385720900259912,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7756028000,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 21.403800750005757,
  "request_vm_after" : {
    "reclaimableBytes" : 17440473088,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17636212736,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 2.9330649170151446,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-1-contiguous-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-v1/round-2-contiguous-admission.json

Original bytes: 17280. SHA-256: `77ee33ca40e7938091cd969b777c07be4a1836655fa19177e8111e144b7ea89d`.

Normalized bytes: 17280. SHA-256: `77ee33ca40e7938091cd969b777c07be4a1836655fa19177e8111e144b7ea89d`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.01058566602296196,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 17440473088,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24766332928,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   472887.\nPages active:                                 852650.\nPages inactive:                               866367.\nPages speculative:                             25750.\nPages throttled:                                   0.\nPages wired down:                             178969.\nPages purgeable:                                4753.\n\"Translation faults\":                     1972939936.\nPages copy-on-write:                        99174880.\nPages zero filled:                        3240130755.\nPages reactivated:                         174004929.\nPages purged:                               12757981.\nFile-backed pages:                           1033977.\nAnonymous pages:                              710790.\nPages stored in compressor:                  1300518.\nPages occupied by compressor:                 688331.\nDecompressions:                            103675146.\nCompressions:                              117485633.\nPageins:                                  2321644450.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128072.\nPages tagged resident:                         84226.\nPages tagged compressed:                       43846.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          549.\nPages tag-storage non-tag pageable:            92517.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6706240.\nTagged compressions:                          746391.\nTagged decompressions:                        614272.\n"
      }
    },
    {
      "elapsed_seconds": 5.042251500010025,
      "stable_seconds": 5.031665833987063,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25179504640,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24755109888,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   472261.\nPages active:                                 855847.\nPages inactive:                               862328.\nPages speculative:                             25946.\nPages throttled:                                   0.\nPages wired down:                             181438.\nPages purgeable:                                4391.\n\"Translation faults\":                     1972954755.\nPages copy-on-write:                        99175729.\nPages zero filled:                        3240204307.\nPages reactivated:                         174004929.\nPages purged:                               12757981.\nFile-backed pages:                           1034280.\nAnonymous pages:                              709841.\nPages stored in compressor:                  1298261.\nPages occupied by compressor:                 687114.\nDecompressions:                            103676487.\nCompressions:                              117485633.\nPageins:                                  2321644686.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128129.\nPages tagged resident:                         84284.\nPages tagged compressed:                       43845.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          446.\nPages tag-storage non-tag pageable:            92620.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6705728.\nTagged compressions:                          746391.\nTagged decompressions:                        614273.\n"
      }
    },
    {
      "elapsed_seconds": 10.076189790997887,
      "stable_seconds": 10.065604124974925,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24980226048,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24557502464,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   464416.\nPages active:                                 843051.\nPages inactive:                               862456.\nPages speculative:                             25996.\nPages throttled:                                   0.\nPages wired down:                             202520.\nPages purgeable:                                  90.\n\"Translation faults\":                     1972960844.\nPages copy-on-write:                        99176423.\nPages zero filled:                        3240314241.\nPages reactivated:                         174004931.\nPages purged:                               12757981.\nFile-backed pages:                           1034365.\nAnonymous pages:                              697138.\nPages stored in compressor:                  1297705.\nPages occupied by compressor:                 686875.\nDecompressions:                            103676957.\nCompressions:                              117485633.\nPageins:                                  2321644738.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127969.\nPages tagged resident:                         84132.\nPages tagged compressed:                       43837.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          370.\nPages tag-storage non-tag pageable:            92696.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6704256.\nTagged compressions:                          746391.\nTagged decompressions:                        614281.\n"
      }
    },
    {
      "elapsed_seconds": 15.109523332997924,
      "stable_seconds": 15.098937666974962,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25092833280,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24664850432,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470904.\nPages active:                                 844762.\nPages inactive:                               863551.\nPages speculative:                             26063.\nPages throttled:                                   0.\nPages wired down:                             193364.\nPages purgeable:                                  96.\n\"Translation faults\":                     1972968204.\nPages copy-on-write:                        99177232.\nPages zero filled:                        3240402139.\nPages reactivated:                         174004932.\nPages purged:                               12757981.\nFile-backed pages:                           1034423.\nAnonymous pages:                              699953.\nPages stored in compressor:                  1296755.\nPages occupied by compressor:                 686604.\nDecompressions:                            103677354.\nCompressions:                              117485633.\nPageins:                                  2321644748.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128003.\nPages tagged resident:                         84171.\nPages tagged compressed:                       43832.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          366.\nPages tag-storage non-tag pageable:            92700.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6703040.\nTagged compressions:                          746391.\nTagged decompressions:                        614286.\n"
      }
    },
    {
      "elapsed_seconds": 20.14210962501238,
      "stable_seconds": 20.13152395898942,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25152634880,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24722309120,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469479.\nPages active:                                 861285.\nPages inactive:                               863633.\nPages speculative:                             26330.\nPages throttled:                                   0.\nPages wired down:                             178800.\nPages purgeable:                                4715.\n\"Translation faults\":                     1972985643.\nPages copy-on-write:                        99178790.\nPages zero filled:                        3240472168.\nPages reactivated:                         174004939.\nPages purged:                               12757981.\nFile-backed pages:                           1034736.\nAnonymous pages:                              716512.\nPages stored in compressor:                  1294522.\nPages occupied by compressor:                 685646.\nDecompressions:                            103679581.\nCompressions:                              117485633.\nPageins:                                  2321644815.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127930.\nPages tagged resident:                         84101.\nPages tagged compressed:                       43829.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          358.\nPages tag-storage non-tag pageable:            92708.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6702592.\nTagged compressions:                          746391.\nTagged decompressions:                        614289.\n"
      }
    },
    {
      "elapsed_seconds": 25.177490291011054,
      "stable_seconds": 25.166904624988092,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24996380672,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24560402432,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   463567.\nPages active:                                 849628.\nPages inactive:                               868099.\nPages speculative:                             26537.\nPages throttled:                                   0.\nPages wired down:                             196703.\nPages purgeable:                                 409.\n\"Translation faults\":                     1973040045.\nPages copy-on-write:                        99185348.\nPages zero filled:                        3240595218.\nPages reactivated:                         174005039.\nPages purged:                               12757981.\nFile-backed pages:                           1035072.\nAnonymous pages:                              709192.\nPages stored in compressor:                  1284718.\nPages occupied by compressor:                 680590.\nDecompressions:                            103688734.\nCompressions:                              117485633.\nPageins:                                  2321644974.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127877.\nPages tagged resident:                         84058.\nPages tagged compressed:                       43819.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          489.\nPages tag-storage non-tag pageable:            92577.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6700672.\nTagged compressions:                          746391.\nTagged decompressions:                        614299.\n"
      }
    },
    {
      "elapsed_seconds": 30.217469958006404,
      "stable_seconds": 30.206884291983442,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25069846528,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24635162624,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   464662.\nPages active:                                 863099.\nPages inactive:                               868155.\nPages speculative:                             26606.\nPages throttled:                                   0.\nPages wired down:                             182354.\nPages purgeable:                                3783.\n\"Translation faults\":                     1973049076.\nPages copy-on-write:                        99186111.\nPages zero filled:                        3240670499.\nPages reactivated:                         174005042.\nPages purged:                               12757983.\nFile-backed pages:                           1035166.\nAnonymous pages:                              722694.\nPages stored in compressor:                  1284061.\nPages occupied by compressor:                 680425.\nDecompressions:                            103689390.\nCompressions:                              117485633.\nPageins:                                  2321645008.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127903.\nPages tagged resident:                         84171.\nPages tagged compressed:                       43732.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          491.\nPages tag-storage non-tag pageable:            92575.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6678656.\nTagged compressions:                          746391.\nTagged decompressions:                        614386.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/round-2-contiguous/receipt.json

Original bytes: 22311. SHA-256: `73b64259ae8ad428e97cc02e830117b2a139df8776334fc45614957520bea7df`.

Normalized bytes: 22311. SHA-256: `73b64259ae8ad428e97cc02e830117b2a139df8776334fc45614957520bea7df`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.8723808966084556,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.1019891249889042,
    3.482028749975143,
    3.6509280419850256,
    3.8034557919891085,
    3.9484429589938372,
    4.0923994999902789,
    4.2376528339809738,
    4.3926426249963697,
    4.5381849169789348,
    4.6926130419888068,
    4.8335039169760421,
    4.9599721249833237,
    5.0965106669755187,
    5.2208129589853343,
    5.3775797089911066,
    5.5074461669719312,
    5.6226439999882132,
    5.7621587920002639,
    5.8973949169740081,
    6.0555450839747209,
    6.1993026669952087,
    6.3336730839801021,
    6.4731992919987533,
    6.6232563749945257,
    6.8279170419846196,
    7.01578558399342,
    7.158795666997321,
    7.3033147499954794,
    7.489234916982241,
    7.6486761249834672,
    7.8009359169809613,
    7.9346670839877333,
    8.0934823339921422,
    8.2420856249809731,
    8.3864448749809526,
    8.5401858749974053,
    8.7023435839801095,
    8.8593725839746185,
    9.0083084999932908,
    9.1484070839942433,
    9.2850482919893693,
    9.4403525839734357,
    9.6042493339919019,
    9.7566657089919318,
    9.8903530419920571,
    10.067428666981868,
    10.239727374981157,
    10.388942708988907,
    10.534459749993403,
    10.669206874998054,
    10.804922666982748,
    10.944890208978904,
    11.086877958994592,
    11.229839333973359,
    11.36440816699178,
    11.537266667000949,
    11.685750791977625,
    11.839673999988008,
    11.970977374992799,
    12.109278791991528,
    12.26916062500095,
    12.416389749996597,
    12.568054584000492,
    12.704935458983527,
    12.87117012499948,
    12.999991458986187,
    13.152738333999878,
    13.30986154198763,
    13.444174541975372,
    13.576750166976126,
    13.72918304198538,
    13.869562374980887,
    14.010163291997742,
    14.144776374974754,
    14.277085916983197,
    14.406657416984672,
    14.530876999982866,
    14.672730874997796,
    14.808251166978152,
    14.929327291989466,
    15.082712708972394,
    15.226238708972232,
    15.378627166996012,
    15.524205249996157,
    15.674211416975595,
    15.81117716699373,
    15.937321541976416,
    16.067406041984214,
    16.224912374978885,
    16.373845499998424,
    16.50641429197276,
    16.634874333976768,
    16.760249666986056,
    16.883583708986407,
    17.011981583986199,
    17.153332333982689,
    17.283842083998024,
    17.41238812499796,
    17.5591975839925,
    17.724627874995349,
    17.86249429199961,
    17.99140591698233,
    18.140807458985364,
    18.275252624996938,
    18.406510333996266,
    18.527675041987095,
    18.668361999996705,
    18.788128333981149,
    18.919249499973375,
    19.046869749989128,
    19.1694567919767,
    19.335170124977594,
    19.496543249988463,
    19.639225874998374,
    19.776689374994021,
    19.917782833974343,
    20.050735166994855,
    20.194165749999229,
    20.328553166997153,
    20.465879666997353,
    20.622641583991935,
    20.774099124973873,
    20.909293291973881,
    21.032173416984733,
    21.166551333997631,
    21.299807874980615,
    21.448064666998107,
    21.581756458996097
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 24817025024,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.38003962498623878,
    0.16889929200988263,
    0.15252775000408292,
    0.14498716700472869,
    0.14395654099644162,
    0.14525333399069495,
    0.15498979101539589,
    0.14554229198256508,
    0.15442812500987202,
    0.14089087498723529,
    0.12646820800728165,
    0.13653854199219495,
    0.12430229200981557,
    0.15676675000577234,
    0.12986645798082463,
    0.11519783301628195,
    0.13951479201205075,
    0.13523612497374415,
    0.15815016700071283,
    0.1437575830204878,
    0.13437041698489338,
    0.13952620801865123,
    0.15005708299577236,
    0.20466066699009389,
    0.18786854200880043,
    0.14301008300390095,
    0.14451908299815841,
    0.18592016698676161,
    0.15944120800122619,
    0.15225979199749418,
    0.13373116700677201,
    0.15881525000440888,
    0.14860329098883085,
    0.14435924999997951,
    0.15374100001645274,
    0.16215770898270421,
    0.15702899999450892,
    0.14893591601867229,
    0.14009858400095254,
    0.13664120799512602,
    0.15530429198406637,
    0.16389675001846626,
    0.1524163750000298,
    0.13368733300012536,
    0.17707562498981133,
    0.17229870799928904,
    0.14921533400774933,
    0.1455170410044957,
    0.13474712500465102,
    0.13571579198469408,
    0.1399675419961568,
    0.1419877500156872,
    0.14296137497876771,
    0.13456883301842026,
    0.1728585000091698,
    0.14848412497667596,
    0.15392320801038295,
    0.13130337500479072,
    0.13830141699872911,
    0.15988183300942183,
    0.147229124995647,
    0.15166483400389552,
    0.13688087498303503,
    0.16623466601595283,
    0.12882133398670703,
    0.15274687501369044,
    0.15712320798775181,
    0.13431299998774193,
    0.13257562500075437,
    0.15243287500925362,
    0.14037933299550787,
    0.14060091701685451,
    0.1346130829770118,
    0.1323095420084428,
    0.12957150000147521,
    0.1242195829981938,
    0.14185387501493096,
    0.13552029198035598,
    0.12107612501131371,
    0.15338541698292829,
    0.14352599999983795,
    0.15238845802377909,
    0.14557808300014585,
    0.15000616697943769,
    0.13696575001813471,
    0.12614437498268671,
    0.13008450000779703,
    0.15750633299467154,
    0.14893312501953915,
    0.13256879197433591,
    0.12846004200400785,
    0.12537533300928771,
    0.12333404200035147,
    0.12839787499979138,
    0.14135074999649078,
    0.13050975001533516,
    0.12854604099993594,
    0.14680945899453945,
    0.16543029100284912,
    0.13786641700426117,
    0.12891162498272024,
    0.14940154200303368,
    0.13444516601157375,
    0.13125770899932832,
    0.1211647079908289,
    0.14068695800960995,
    0.11976633398444392,
    0.13112116599222645,
    0.12762025001575239,
    0.12258704198757187,
    0.16571333300089464,
    0.16137312501086853,
    0.14268262500991113,
    0.137463499995647,
    0.14109345898032188,
    0.13295233302051201,
    0.14343058300437406,
    0.13438741699792445,
    0.1373265000001993,
    0.15676191699458286,
    0.1514575409819372,
    0.13519416700000875,
    0.12288012501085177,
    0.13437791701289825,
    0.13325654098298401,
    0.14825679201749153,
    0.13369179199798964
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 77.1266143329849,
  "metadata_seconds" : 0.13566050000372343,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7782275240,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 21.581774708989542,
  "request_vm_after" : {
    "reclaimableBytes" : 17400070144,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17728274432,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.1019891249889042,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-2-contiguous-supervision/identity.json

Original bytes: 3326. SHA-256: `e0e948066854c0a835b00db99d2b3ddbe73397d5d2c5dcd25a007b9fd040a7ef`.

Normalized bytes: 3263. SHA-256: `7167b0481f0d4f2d53568e1bb8d68c9155a05cf4cea83035222ffc627737486c`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/contiguous-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/round-2-contiguous",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--packed-record-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-contiguous/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24634392576,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   464614.\nPages active:                                 863105.\nPages inactive:                               868156.\nPages speculative:                             26606.\nPages throttled:                                   0.\nPages wired down:                             182354.\nPages purgeable:                                3783.\n\"Translation faults\":                     1973054290.\nPages copy-on-write:                        99186889.\nPages zero filled:                        3240672711.\nPages reactivated:                         174005042.\nPages purged:                               12757983.\nFile-backed pages:                           1035167.\nAnonymous pages:                              722700.\nPages stored in compressor:                  1284059.\nPages occupied by compressor:                 680424.\nDecompressions:                            103689404.\nCompressions:                              117485633.\nPageins:                                  2321645014.\nPageouts:                                     486828.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127903.\nPages tagged resident:                         84171.\nPages tagged compressed:                       43732.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          491.\nPages tag-storage non-tag pageable:            92575.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6678656.\nTagged compressions:                          746391.\nTagged decompressions:                        614386.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/round-2-contiguous-supervision/receipt.json

Original bytes: 2140. SHA-256: `7140b317100fec35760c9f84ea5a91956bd9521498d4ed30f61fd7420b079375`.

Normalized bytes: 2140. SHA-256: `7140b317100fec35760c9f84ea5a91956bd9521498d4ed30f61fd7420b079375`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7782275240,
  "samples": 1707,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24693145600,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   474860.\nPages active:                                 866106.\nPages inactive:                               849676.\nPages speculative:                             29055.\nPages throttled:                                   0.\nPages wired down:                             182502.\nPages purgeable:                                4107.\n\"Translation faults\":                     1976135263.\nPages copy-on-write:                        99227840.\nPages zero filled:                        3242629867.\nPages reactivated:                         174057390.\nPages purged:                               12769728.\nFile-backed pages:                           1028183.\nAnonymous pages:                              716654.\nPages stored in compressor:                  1290212.\nPages occupied by compressor:                 682152.\nDecompressions:                            103975300.\nCompressions:                              117825899.\nPageins:                                  2335878051.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127918.\nPages tagged resident:                         83078.\nPages tagged compressed:                       44840.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                         1231.\nPages tag-storage non-tag pageable:            91863.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6861568.\nTagged compressions:                          747671.\nTagged decompressions:                        614555.\n"
  },
  "seconds": 99.01064729201607
}
````

### vq-contiguous-cost-v1/round-2-contiguous-supervision/stdout.txt

Original bytes: 22312. SHA-256: `52399193c805ab04f2957cd3cad347d11e4bd14ddd324cd8271738af03e3638d`.

Normalized bytes: 22312. SHA-256: `52399193c805ab04f2957cd3cad347d11e4bd14ddd324cd8271738af03e3638d`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.8723808966084556,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.1019891249889042,
    3.482028749975143,
    3.6509280419850256,
    3.8034557919891085,
    3.9484429589938372,
    4.0923994999902789,
    4.2376528339809738,
    4.3926426249963697,
    4.5381849169789348,
    4.6926130419888068,
    4.8335039169760421,
    4.9599721249833237,
    5.0965106669755187,
    5.2208129589853343,
    5.3775797089911066,
    5.5074461669719312,
    5.6226439999882132,
    5.7621587920002639,
    5.8973949169740081,
    6.0555450839747209,
    6.1993026669952087,
    6.3336730839801021,
    6.4731992919987533,
    6.6232563749945257,
    6.8279170419846196,
    7.01578558399342,
    7.158795666997321,
    7.3033147499954794,
    7.489234916982241,
    7.6486761249834672,
    7.8009359169809613,
    7.9346670839877333,
    8.0934823339921422,
    8.2420856249809731,
    8.3864448749809526,
    8.5401858749974053,
    8.7023435839801095,
    8.8593725839746185,
    9.0083084999932908,
    9.1484070839942433,
    9.2850482919893693,
    9.4403525839734357,
    9.6042493339919019,
    9.7566657089919318,
    9.8903530419920571,
    10.067428666981868,
    10.239727374981157,
    10.388942708988907,
    10.534459749993403,
    10.669206874998054,
    10.804922666982748,
    10.944890208978904,
    11.086877958994592,
    11.229839333973359,
    11.36440816699178,
    11.537266667000949,
    11.685750791977625,
    11.839673999988008,
    11.970977374992799,
    12.109278791991528,
    12.26916062500095,
    12.416389749996597,
    12.568054584000492,
    12.704935458983527,
    12.87117012499948,
    12.999991458986187,
    13.152738333999878,
    13.30986154198763,
    13.444174541975372,
    13.576750166976126,
    13.72918304198538,
    13.869562374980887,
    14.010163291997742,
    14.144776374974754,
    14.277085916983197,
    14.406657416984672,
    14.530876999982866,
    14.672730874997796,
    14.808251166978152,
    14.929327291989466,
    15.082712708972394,
    15.226238708972232,
    15.378627166996012,
    15.524205249996157,
    15.674211416975595,
    15.81117716699373,
    15.937321541976416,
    16.067406041984214,
    16.224912374978885,
    16.373845499998424,
    16.50641429197276,
    16.634874333976768,
    16.760249666986056,
    16.883583708986407,
    17.011981583986199,
    17.153332333982689,
    17.283842083998024,
    17.41238812499796,
    17.5591975839925,
    17.724627874995349,
    17.86249429199961,
    17.99140591698233,
    18.140807458985364,
    18.275252624996938,
    18.406510333996266,
    18.527675041987095,
    18.668361999996705,
    18.788128333981149,
    18.919249499973375,
    19.046869749989128,
    19.1694567919767,
    19.335170124977594,
    19.496543249988463,
    19.639225874998374,
    19.776689374994021,
    19.917782833974343,
    20.050735166994855,
    20.194165749999229,
    20.328553166997153,
    20.465879666997353,
    20.622641583991935,
    20.774099124973873,
    20.909293291973881,
    21.032173416984733,
    21.166551333997631,
    21.299807874980615,
    21.448064666998107,
    21.581756458996097
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 24817025024,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.38003962498623878,
    0.16889929200988263,
    0.15252775000408292,
    0.14498716700472869,
    0.14395654099644162,
    0.14525333399069495,
    0.15498979101539589,
    0.14554229198256508,
    0.15442812500987202,
    0.14089087498723529,
    0.12646820800728165,
    0.13653854199219495,
    0.12430229200981557,
    0.15676675000577234,
    0.12986645798082463,
    0.11519783301628195,
    0.13951479201205075,
    0.13523612497374415,
    0.15815016700071283,
    0.1437575830204878,
    0.13437041698489338,
    0.13952620801865123,
    0.15005708299577236,
    0.20466066699009389,
    0.18786854200880043,
    0.14301008300390095,
    0.14451908299815841,
    0.18592016698676161,
    0.15944120800122619,
    0.15225979199749418,
    0.13373116700677201,
    0.15881525000440888,
    0.14860329098883085,
    0.14435924999997951,
    0.15374100001645274,
    0.16215770898270421,
    0.15702899999450892,
    0.14893591601867229,
    0.14009858400095254,
    0.13664120799512602,
    0.15530429198406637,
    0.16389675001846626,
    0.1524163750000298,
    0.13368733300012536,
    0.17707562498981133,
    0.17229870799928904,
    0.14921533400774933,
    0.1455170410044957,
    0.13474712500465102,
    0.13571579198469408,
    0.1399675419961568,
    0.1419877500156872,
    0.14296137497876771,
    0.13456883301842026,
    0.1728585000091698,
    0.14848412497667596,
    0.15392320801038295,
    0.13130337500479072,
    0.13830141699872911,
    0.15988183300942183,
    0.147229124995647,
    0.15166483400389552,
    0.13688087498303503,
    0.16623466601595283,
    0.12882133398670703,
    0.15274687501369044,
    0.15712320798775181,
    0.13431299998774193,
    0.13257562500075437,
    0.15243287500925362,
    0.14037933299550787,
    0.14060091701685451,
    0.1346130829770118,
    0.1323095420084428,
    0.12957150000147521,
    0.1242195829981938,
    0.14185387501493096,
    0.13552029198035598,
    0.12107612501131371,
    0.15338541698292829,
    0.14352599999983795,
    0.15238845802377909,
    0.14557808300014585,
    0.15000616697943769,
    0.13696575001813471,
    0.12614437498268671,
    0.13008450000779703,
    0.15750633299467154,
    0.14893312501953915,
    0.13256879197433591,
    0.12846004200400785,
    0.12537533300928771,
    0.12333404200035147,
    0.12839787499979138,
    0.14135074999649078,
    0.13050975001533516,
    0.12854604099993594,
    0.14680945899453945,
    0.16543029100284912,
    0.13786641700426117,
    0.12891162498272024,
    0.14940154200303368,
    0.13444516601157375,
    0.13125770899932832,
    0.1211647079908289,
    0.14068695800960995,
    0.11976633398444392,
    0.13112116599222645,
    0.12762025001575239,
    0.12258704198757187,
    0.16571333300089464,
    0.16137312501086853,
    0.14268262500991113,
    0.137463499995647,
    0.14109345898032188,
    0.13295233302051201,
    0.14343058300437406,
    0.13438741699792445,
    0.1373265000001993,
    0.15676191699458286,
    0.1514575409819372,
    0.13519416700000875,
    0.12288012501085177,
    0.13437791701289825,
    0.13325654098298401,
    0.14825679201749153,
    0.13369179199798964
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 77.1266143329849,
  "metadata_seconds" : 0.13566050000372343,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7782275240,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 21.581774708989542,
  "request_vm_after" : {
    "reclaimableBytes" : 17400070144,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17728274432,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.1019891249889042,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-2-contiguous-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-v1/round-2-split-admission.json

Original bytes: 17280. SHA-256: `832fda7b16951afc4737af53c55dc0d6275f4d9131f8d02431efa08ec1bfbd5f`.

Normalized bytes: 17280. SHA-256: `832fda7b16951afc4737af53c55dc0d6275f4d9131f8d02431efa08ec1bfbd5f`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.009723209019284695,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 17400070144,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24685887488,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   473566.\nPages active:                                 853603.\nPages inactive:                               864365.\nPages speculative:                             29165.\nPages throttled:                                   0.\nPages wired down:                             182501.\nPages purgeable:                                4399.\n\"Translation faults\":                     1976146326.\nPages copy-on-write:                        99229054.\nPages zero filled:                        3242631223.\nPages reactivated:                         174057390.\nPages purged:                               12769728.\nFile-backed pages:                           1028742.\nAnonymous pages:                              718391.\nPages stored in compressor:                  1288640.\nPages occupied by compressor:                 681605.\nDecompressions:                            103975585.\nCompressions:                              117825899.\nPageins:                                  2335878377.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127918.\nPages tagged resident:                         83078.\nPages tagged compressed:                       44840.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          704.\nPages tag-storage non-tag pageable:            92390.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6861568.\nTagged compressions:                          747671.\nTagged decompressions:                        614555.\n"
      }
    },
    {
      "elapsed_seconds": 5.040687917004107,
      "stable_seconds": 5.030964707984822,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25171099648,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24693604352,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   474768.\nPages active:                                 858424.\nPages inactive:                               859601.\nPages speculative:                             29193.\nPages throttled:                                   0.\nPages wired down:                             181425.\nPages purgeable:                                3635.\n\"Translation faults\":                     1976151685.\nPages copy-on-write:                        99229798.\nPages zero filled:                        3242702199.\nPages reactivated:                         174057390.\nPages purged:                               12769728.\nFile-backed pages:                           1028775.\nAnonymous pages:                              718443.\nPages stored in compressor:                  1288398.\nPages occupied by compressor:                 681516.\nDecompressions:                            103975817.\nCompressions:                              117825899.\nPageins:                                  2335878389.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127835.\nPages tagged resident:                         82996.\nPages tagged compressed:                       44839.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          582.\nPages tag-storage non-tag pageable:            92512.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6861568.\nTagged compressions:                          747671.\nTagged decompressions:                        614556.\n"
      }
    },
    {
      "elapsed_seconds": 10.07215212500887,
      "stable_seconds": 10.062428915989585,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24964988928,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24478957568,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   464082.\nPages active:                                 847440.\nPages inactive:                               860396.\nPages speculative:                             29857.\nPages throttled:                                   0.\nPages wired down:                             202048.\nPages purgeable:                                 242.\n\"Translation faults\":                     1976160114.\nPages copy-on-write:                        99230499.\nPages zero filled:                        3242815272.\nPages reactivated:                         174057390.\nPages purged:                               12769728.\nFile-backed pages:                           1029753.\nAnonymous pages:                              707940.\nPages stored in compressor:                  1287703.\nPages occupied by compressor:                 681351.\nDecompressions:                            103976515.\nCompressions:                              117825899.\nPageins:                                  2335878859.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128041.\nPages tagged resident:                         83308.\nPages tagged compressed:                       44733.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          530.\nPages tag-storage non-tag pageable:            92564.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6843904.\nTagged compressions:                          747671.\nTagged decompressions:                        614661.\n"
      }
    },
    {
      "elapsed_seconds": 15.103907542012166,
      "stable_seconds": 15.094184332992882,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25083314176,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24592220160,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470495.\nPages active:                                 847432.\nPages inactive:                               860705.\nPages speculative:                             29915.\nPages throttled:                                   0.\nPages wired down:                             195281.\nPages purgeable:                                 677.\n\"Translation faults\":                     1976166404.\nPages copy-on-write:                        99231269.\nPages zero filled:                        3242915396.\nPages reactivated:                         174057390.\nPages purged:                               12769728.\nFile-backed pages:                           1029818.\nAnonymous pages:                              708234.\nPages stored in compressor:                  1287005.\nPages occupied by compressor:                 681201.\nDecompressions:                            103976641.\nCompressions:                              117825899.\nPageins:                                  2335878888.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127952.\nPages tagged resident:                         83242.\nPages tagged compressed:                       44710.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          532.\nPages tag-storage non-tag pageable:            92562.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6838336.\nTagged compressions:                          747671.\nTagged decompressions:                        614684.\n"
      }
    },
    {
      "elapsed_seconds": 20.136043417005567,
      "stable_seconds": 20.126320207986282,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25153044480,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24659869696,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470580.\nPages active:                                 859917.\nPages inactive:                               862049.\nPages speculative:                             30035.\nPages throttled:                                   0.\nPages wired down:                             181270.\nPages purgeable:                                4561.\n\"Translation faults\":                     1976172417.\nPages copy-on-write:                        99231924.\nPages zero filled:                        3242980540.\nPages reactivated:                         174057396.\nPages purged:                               12769730.\nFile-backed pages:                           1029978.\nAnonymous pages:                              722023.\nPages stored in compressor:                  1286421.\nPages occupied by compressor:                 681027.\nDecompressions:                            103977204.\nCompressions:                              117825899.\nPageins:                                  2335879009.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128072.\nPages tagged resident:                         83424.\nPages tagged compressed:                       44648.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          533.\nPages tag-storage non-tag pageable:            92561.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6824256.\nTagged compressions:                          747671.\nTagged decompressions:                        614746.\n"
      }
    },
    {
      "elapsed_seconds": 25.167961084021954,
      "stable_seconds": 25.15823787500267,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25094914048,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24599363584,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   467421.\nPages active:                                 862982.\nPages inactive:                               862073.\nPages speculative:                             30170.\nPages throttled:                                   0.\nPages wired down:                             181466.\nPages purgeable:                                3811.\n\"Translation faults\":                     1976189805.\nPages copy-on-write:                        99233923.\nPages zero filled:                        3243056042.\nPages reactivated:                         174057396.\nPages purged:                               12769730.\nFile-backed pages:                           1030194.\nAnonymous pages:                              725031.\nPages stored in compressor:                  1286362.\nPages occupied by compressor:                 681012.\nDecompressions:                            103977267.\nCompressions:                              117825899.\nPageins:                                  2335879155.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 129569.\nPages tagged resident:                         84939.\nPages tagged compressed:                       44630.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          530.\nPages tag-storage non-tag pageable:            92564.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6821696.\nTagged compressions:                          747671.\nTagged decompressions:                        614764.\n"
      }
    },
    {
      "elapsed_seconds": 30.193586959008826,
      "stable_seconds": 30.18386374998954,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24875958272,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24383537152,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   451868.\nPages active:                                 857243.\nPages inactive:                               862216.\nPages speculative:                             30252.\nPages throttled:                                   0.\nPages wired down:                             202598.\nPages purgeable:                                6094.\n\"Translation faults\":                     1976205150.\nPages copy-on-write:                        99235542.\nPages zero filled:                        3243180873.\nPages reactivated:                         174057404.\nPages purged:                               12769730.\nFile-backed pages:                           1030291.\nAnonymous pages:                              719420.\nPages stored in compressor:                  1285975.\nPages occupied by compressor:                 680861.\nDecompressions:                            103977624.\nCompressions:                              117825899.\nPageins:                                  2335879159.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 129456.\nPages tagged resident:                         84828.\nPages tagged compressed:                       44628.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          632.\nPages tag-storage non-tag pageable:            92462.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6821568.\nTagged compressions:                          747671.\nTagged decompressions:                        614766.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/round-2-split/receipt.json

Original bytes: 22205. SHA-256: `9f5c31e531fcb97b61a68ca59928433a57a3164440fc8fa57ea3ad55d2369df1`.

Normalized bytes: 22205. SHA-256: `9f5c31e531fcb97b61a68ca59928433a57a3164440fc8fa57ea3ad55d2369df1`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.7761639479783069,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0060759580228478,
    3.3298500410164706,
    3.5221490830008406,
    3.7070070830231998,
    3.8807044160203077,
    4.0541457910148893,
    4.2289981250069104,
    4.4172716250177473,
    4.5950329580227844,
    4.776574708026601,
    4.9479745830176398,
    5.0984555410104804,
    5.2617003330087755,
    5.4143249160260893,
    5.5948596660164185,
    5.7450382910028566,
    5.8854101250180975,
    6.0533997910097241,
    6.2134633750247303,
    6.4026594580209348,
    6.5797525410016533,
    6.7432300000218675,
    6.9138850000163075,
    7.0878510410257149,
    7.2739420410071034,
    7.4505249580251984,
    7.6194314160093199,
    7.7935295000206679,
    8.0007852500129957,
    8.1897465000220109,
    8.3708140410017222,
    8.5348788330156822,
    8.7251672080019489,
    8.897038416005671,
    9.0684959160280414,
    9.2489366250229068,
    9.4379996250208933,
    9.6247240830271039,
    9.8023529160127509,
    9.977117125003133,
    10.143225208012154,
    10.335147875011899,
    10.526209083007416,
    10.711807125015184,
    10.877329833019758,
    11.080734500021208,
    11.281711041025119,
    11.465532875008648,
    11.637680541025475,
    11.799835375015391,
    11.968727708008373,
    12.1390332080191,
    12.315089500014437,
    12.544811083003879,
    12.710752875020262,
    12.909618833014974,
    13.086264833022142,
    13.268323458003579,
    13.424824458023068,
    13.590445333014941,
    13.784096708026482,
    13.965325833007228,
    14.146333250013413,
    14.311111540999264,
    14.514926125004422,
    14.675204166007461,
    14.866372375021456,
    15.055294166028034,
    15.221463791007409,
    15.383300333021907,
    15.568780916015385,
    15.741059250023682,
    15.905445000011241,
    16.062142375012627,
    16.22501987501164,
    16.376725291018374,
    16.523232333012857,
    16.695571791002294,
    16.851014416024555,
    16.994142958021257,
    17.181754290999379,
    17.353866707999259,
    17.537774125026772,
    17.712412291002693,
    17.889229333028197,
    18.052330541017,
    18.202134833001764,
    18.359092041006079,
    18.544074416015064,
    18.723599125019973,
    18.881507541023893,
    19.040084166015731,
    19.187458958011121,
    19.336703208013205,
    19.488616791000823,
    19.655215500009945,
    19.807385750027606,
    19.965614833025029,
    20.145556125004077,
    20.344446125003742,
    20.516236416005995,
    20.672903583006701,
    20.842519583005924,
    21.00458920802339,
    21.160380666027777,
    21.303637458011508,
    21.473141958005726,
    21.623335041018436,
    21.783233750000363,
    21.937821875006193,
    22.089298750011949,
    22.290089291025652,
    22.480632291000802,
    22.646428708016174,
    22.808950500009814,
    22.978890791011509,
    23.137575083004776,
    23.310278291028226,
    23.466900583007373,
    23.634968291007681,
    23.828793833003147,
    24.012773125024978,
    24.169527208025102,
    24.317780750017846,
    24.481478291010717,
    24.643567625025753,
    24.827758708008332,
    24.99298650000128
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 24666914816,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.32377408299362287,
    0.19229904198436998,
    0.18485800002235919,
    0.17369733299710788,
    0.17344137499458157,
    0.17485233399202116,
    0.18827350001083687,
    0.17776133300503716,
    0.18154175000381656,
    0.17139987499103881,
    0.15048095799284056,
    0.16324479199829511,
    0.15262458301731385,
    0.18053474999032915,
    0.15017862498643808,
    0.14037183401524089,
    0.16798966599162668,
    0.1600635840150062,
    0.1891960829962045,
    0.17709308298071846,
    0.16347745902021416,
    0.17065499999444,
    0.17396604100940749,
    0.18609099998138845,
    0.17658291701809503,
    0.16890645798412152,
    0.17409808401134796,
    0.20725574999232776,
    0.1889612500090152,
    0.18106754097971134,
    0.16406479201395996,
    0.19028837498626672,
    0.17187120800372213,
    0.17145750002237037,
    0.18044070899486542,
    0.18906299999798648,
    0.18672445800621063,
    0.17762883298564702,
    0.17476420899038203,
    0.16610808300902136,
    0.19192266699974425,
    0.19106120799551718,
    0.18559804200776853,
    0.16552270800457336,
    0.20340466700145043,
    0.20097654100391082,
    0.18382183398352936,
    0.17214766601682641,
    0.16215483398991637,
    0.16889233299298212,
    0.17030550001072697,
    0.17605629199533723,
    0.22972158298944123,
    0.16594179201638326,
    0.19886595799471252,
    0.17664600000716746,
    0.18205862498143688,
    0.15650100001948886,
    0.16562087499187328,
    0.19365137501154095,
    0.18122912498074584,
    0.18100741700618528,
    0.16477829098585062,
    0.20381458400515839,
    0.16027804100303911,
    0.19116820901399478,
    0.18892179100657813,
    0.16616962497937493,
    0.16183654201449826,
    0.18548058299347758,
    0.17227833400829695,
    0.16438574998755939,
    0.15669737500138581,
    0.1628774999990128,
    0.15170541600673459,
    0.14650704199448228,
    0.17233945798943751,
    0.15544262502226047,
    0.14312854199670255,
    0.18761133297812194,
    0.17211241699988022,
    0.18390741702751257,
    0.17463816597592086,
    0.17681704202550463,
    0.16310120798880234,
    0.14980429198476486,
    0.15695720800431445,
    0.1849823750089854,
    0.1795247090049088,
    0.15790841600392014,
    0.15857662499183789,
    0.14737479199538939,
    0.1492442500020843,
    0.1519135829876177,
    0.1665987090091221,
    0.1521702500176616,
    0.15822908299742267,
    0.1799412919790484,
    0.19888999999966472,
    0.17179029100225307,
    0.15666716700070538,
    0.16961599999922328,
    0.16206962501746602,
    0.1557914580043871,
    0.14325679198373109,
    0.16950449999421835,
    0.15019308301270939,
    0.15989870898192748,
    0.15458812500583008,
    0.15147687500575557,
    0.20079054101370275,
    0.19054299997515045,
    0.16579641701537184,
    0.16252179199364036,
    0.16994029100169428,
    0.15868429199326783,
    0.17270320802344941,
    0.15662229197914712,
    0.1680677080003079,
    0.19382554199546576,
    0.1839792920218315,
    0.1567540830001235,
    0.14825354199274443,
    0.16369754099287093,
    0.162089334015036,
    0.18419108298257925,
    0.16522779199294746
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.351332542020828,
  "metadata_seconds" : 0.13757120800437406,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7750785096,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 24.993009916011943,
  "request_vm_after" : {
    "reclaimableBytes" : 18218582016,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17732059136,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.0060759580228478,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-2-split-supervision/identity.json

Original bytes: 3183. SHA-256: `d0b54c972d78361fc5a8b7fdfd1bebac0090d69168683ecbe323c6d0d5f0aa2d`.

Normalized bytes: 3127. SHA-256: `10c24acdca8002954fd0ca2adcc91f8529d6466569008c07a6baa69923f21a89`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/split-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/round-2-split",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-split/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24380424192,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   451669.\nPages active:                                 857245.\nPages inactive:                               862219.\nPages speculative:                             30258.\nPages throttled:                                   0.\nPages wired down:                             202598.\nPages purgeable:                                6094.\n\"Translation faults\":                     1976210445.\nPages copy-on-write:                        99236352.\nPages zero filled:                        3243194106.\nPages reactivated:                         174057404.\nPages purged:                               12769730.\nFile-backed pages:                           1030300.\nAnonymous pages:                              719422.\nPages stored in compressor:                  1285975.\nPages occupied by compressor:                 680861.\nDecompressions:                            103977636.\nCompressions:                              117825899.\nPageins:                                  2335879166.\nPageouts:                                     487309.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 129426.\nPages tagged resident:                         84798.\nPages tagged compressed:                       44628.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5202.\nPages tag-storage free:                          633.\nPages tag-storage non-tag pageable:            92461.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6821568.\nTagged compressions:                          747671.\nTagged decompressions:                        614766.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/round-2-split-supervision/receipt.json

Original bytes: 2140. SHA-256: `47967917a544d33e5c54de082342eeee183506d18f7b4d87bf1e64a2bd5100d6`.

Normalized bytes: 2140. SHA-256: `47967917a544d33e5c54de082342eeee183506d18f7b4d87bf1e64a2bd5100d6`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7750785096,
  "samples": 1462,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24626249728,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470828.\nPages active:                                 857557.\nPages inactive:                               786502.\nPages speculative:                             87424.\nPages throttled:                                   0.\nPages wired down:                             195356.\nPages purgeable:                                 615.\n\"Translation faults\":                     1976871621.\nPages copy-on-write:                        99264642.\nPages zero filled:                        3245221450.\nPages reactivated:                         174110855.\nPages purged:                               12777246.\nFile-backed pages:                           1031624.\nAnonymous pages:                              699859.\nPages stored in compressor:                  1293888.\nPages occupied by compressor:                 686310.\nDecompressions:                            104201163.\nCompressions:                              118103034.\nPageins:                                  2346366784.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127969.\nPages tagged resident:                         83506.\nPages tagged compressed:                       44463.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1778.\nPages tag-storage non-tag pageable:            91318.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6786240.\nTagged compressions:                          748681.\nTagged decompressions:                        615453.\n"
  },
  "seconds": 84.63221937499475
}
````

### vq-contiguous-cost-v1/round-2-split-supervision/stdout.txt

Original bytes: 22206. SHA-256: `7f93aebbf0c71473700af008eade30f2752cd1623ed69de26ad1c7b35667aa94`.

Normalized bytes: 22206. SHA-256: `7f93aebbf0c71473700af008eade30f2752cd1623ed69de26ad1c7b35667aa94`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.7761639479783069,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0060759580228478,
    3.3298500410164706,
    3.5221490830008406,
    3.7070070830231998,
    3.8807044160203077,
    4.0541457910148893,
    4.2289981250069104,
    4.4172716250177473,
    4.5950329580227844,
    4.776574708026601,
    4.9479745830176398,
    5.0984555410104804,
    5.2617003330087755,
    5.4143249160260893,
    5.5948596660164185,
    5.7450382910028566,
    5.8854101250180975,
    6.0533997910097241,
    6.2134633750247303,
    6.4026594580209348,
    6.5797525410016533,
    6.7432300000218675,
    6.9138850000163075,
    7.0878510410257149,
    7.2739420410071034,
    7.4505249580251984,
    7.6194314160093199,
    7.7935295000206679,
    8.0007852500129957,
    8.1897465000220109,
    8.3708140410017222,
    8.5348788330156822,
    8.7251672080019489,
    8.897038416005671,
    9.0684959160280414,
    9.2489366250229068,
    9.4379996250208933,
    9.6247240830271039,
    9.8023529160127509,
    9.977117125003133,
    10.143225208012154,
    10.335147875011899,
    10.526209083007416,
    10.711807125015184,
    10.877329833019758,
    11.080734500021208,
    11.281711041025119,
    11.465532875008648,
    11.637680541025475,
    11.799835375015391,
    11.968727708008373,
    12.1390332080191,
    12.315089500014437,
    12.544811083003879,
    12.710752875020262,
    12.909618833014974,
    13.086264833022142,
    13.268323458003579,
    13.424824458023068,
    13.590445333014941,
    13.784096708026482,
    13.965325833007228,
    14.146333250013413,
    14.311111540999264,
    14.514926125004422,
    14.675204166007461,
    14.866372375021456,
    15.055294166028034,
    15.221463791007409,
    15.383300333021907,
    15.568780916015385,
    15.741059250023682,
    15.905445000011241,
    16.062142375012627,
    16.22501987501164,
    16.376725291018374,
    16.523232333012857,
    16.695571791002294,
    16.851014416024555,
    16.994142958021257,
    17.181754290999379,
    17.353866707999259,
    17.537774125026772,
    17.712412291002693,
    17.889229333028197,
    18.052330541017,
    18.202134833001764,
    18.359092041006079,
    18.544074416015064,
    18.723599125019973,
    18.881507541023893,
    19.040084166015731,
    19.187458958011121,
    19.336703208013205,
    19.488616791000823,
    19.655215500009945,
    19.807385750027606,
    19.965614833025029,
    20.145556125004077,
    20.344446125003742,
    20.516236416005995,
    20.672903583006701,
    20.842519583005924,
    21.00458920802339,
    21.160380666027777,
    21.303637458011508,
    21.473141958005726,
    21.623335041018436,
    21.783233750000363,
    21.937821875006193,
    22.089298750011949,
    22.290089291025652,
    22.480632291000802,
    22.646428708016174,
    22.808950500009814,
    22.978890791011509,
    23.137575083004776,
    23.310278291028226,
    23.466900583007373,
    23.634968291007681,
    23.828793833003147,
    24.012773125024978,
    24.169527208025102,
    24.317780750017846,
    24.481478291010717,
    24.643567625025753,
    24.827758708008332,
    24.99298650000128
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 24666914816,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.32377408299362287,
    0.19229904198436998,
    0.18485800002235919,
    0.17369733299710788,
    0.17344137499458157,
    0.17485233399202116,
    0.18827350001083687,
    0.17776133300503716,
    0.18154175000381656,
    0.17139987499103881,
    0.15048095799284056,
    0.16324479199829511,
    0.15262458301731385,
    0.18053474999032915,
    0.15017862498643808,
    0.14037183401524089,
    0.16798966599162668,
    0.1600635840150062,
    0.1891960829962045,
    0.17709308298071846,
    0.16347745902021416,
    0.17065499999444,
    0.17396604100940749,
    0.18609099998138845,
    0.17658291701809503,
    0.16890645798412152,
    0.17409808401134796,
    0.20725574999232776,
    0.1889612500090152,
    0.18106754097971134,
    0.16406479201395996,
    0.19028837498626672,
    0.17187120800372213,
    0.17145750002237037,
    0.18044070899486542,
    0.18906299999798648,
    0.18672445800621063,
    0.17762883298564702,
    0.17476420899038203,
    0.16610808300902136,
    0.19192266699974425,
    0.19106120799551718,
    0.18559804200776853,
    0.16552270800457336,
    0.20340466700145043,
    0.20097654100391082,
    0.18382183398352936,
    0.17214766601682641,
    0.16215483398991637,
    0.16889233299298212,
    0.17030550001072697,
    0.17605629199533723,
    0.22972158298944123,
    0.16594179201638326,
    0.19886595799471252,
    0.17664600000716746,
    0.18205862498143688,
    0.15650100001948886,
    0.16562087499187328,
    0.19365137501154095,
    0.18122912498074584,
    0.18100741700618528,
    0.16477829098585062,
    0.20381458400515839,
    0.16027804100303911,
    0.19116820901399478,
    0.18892179100657813,
    0.16616962497937493,
    0.16183654201449826,
    0.18548058299347758,
    0.17227833400829695,
    0.16438574998755939,
    0.15669737500138581,
    0.1628774999990128,
    0.15170541600673459,
    0.14650704199448228,
    0.17233945798943751,
    0.15544262502226047,
    0.14312854199670255,
    0.18761133297812194,
    0.17211241699988022,
    0.18390741702751257,
    0.17463816597592086,
    0.17681704202550463,
    0.16310120798880234,
    0.14980429198476486,
    0.15695720800431445,
    0.1849823750089854,
    0.1795247090049088,
    0.15790841600392014,
    0.15857662499183789,
    0.14737479199538939,
    0.1492442500020843,
    0.1519135829876177,
    0.1665987090091221,
    0.1521702500176616,
    0.15822908299742267,
    0.1799412919790484,
    0.19888999999966472,
    0.17179029100225307,
    0.15666716700070538,
    0.16961599999922328,
    0.16206962501746602,
    0.1557914580043871,
    0.14325679198373109,
    0.16950449999421835,
    0.15019308301270939,
    0.15989870898192748,
    0.15458812500583008,
    0.15147687500575557,
    0.20079054101370275,
    0.19054299997515045,
    0.16579641701537184,
    0.16252179199364036,
    0.16994029100169428,
    0.15868429199326783,
    0.17270320802344941,
    0.15662229197914712,
    0.1680677080003079,
    0.19382554199546576,
    0.1839792920218315,
    0.1567540830001235,
    0.14825354199274443,
    0.16369754099287093,
    0.162089334015036,
    0.18419108298257925,
    0.16522779199294746
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.351332542020828,
  "metadata_seconds" : 0.13757120800437406,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7750785096,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 24.993009916011943,
  "request_vm_after" : {
    "reclaimableBytes" : 18218582016,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17732059136,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.0060759580228478,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-2-split-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-v1/round-3-split-admission.json

Original bytes: 17281. SHA-256: `2870a04994f14d75b03a772417c409a5dbf1aa3d2b5ee7ce3129b817ba7dd43c`.

Normalized bytes: 17281. SHA-256: `2870a04994f14d75b03a772417c409a5dbf1aa3d2b5ee7ce3129b817ba7dd43c`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.011015666008461267,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26060849152,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24627118080,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470458.\nPages active:                                 845257.\nPages inactive:                               801170.\nPages speculative:                             87447.\nPages throttled:                                   0.\nPages wired down:                             193404.\nPages purgeable:                                 615.\n\"Translation faults\":                     1976873414.\nPages copy-on-write:                        99264941.\nPages zero filled:                        3245221631.\nPages reactivated:                         174110855.\nPages purged:                               12777246.\nFile-backed pages:                           1032047.\nAnonymous pages:                              701827.\nPages stored in compressor:                  1293887.\nPages occupied by compressor:                 686310.\nDecompressions:                            104201168.\nCompressions:                              118103034.\nPageins:                                  2346367017.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127969.\nPages tagged resident:                         83506.\nPages tagged compressed:                       44463.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                         1636.\nPages tag-storage non-tag pageable:            91460.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6786240.\nTagged compressions:                          748681.\nTagged decompressions:                        615453.\n"
      }
    },
    {
      "elapsed_seconds": 5.036108250002144,
      "stable_seconds": 5.025092583993683,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26123927552,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24687951872,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470080.\nPages active:                                 858773.\nPages inactive:                               801789.\nPages speculative:                             87615.\nPages throttled:                                   0.\nPages wired down:                             181227.\nPages purgeable:                                4491.\n\"Translation faults\":                     1976889887.\nPages copy-on-write:                        99266504.\nPages zero filled:                        3245295170.\nPages reactivated:                         174110859.\nPages purged:                               12777246.\nFile-backed pages:                           1032262.\nAnonymous pages:                              715915.\nPages stored in compressor:                  1291597.\nPages occupied by compressor:                 685477.\nDecompressions:                            104202185.\nCompressions:                              118103034.\nPageins:                                  2346367085.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127963.\nPages tagged resident:                         83500.\nPages tagged compressed:                       44463.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                          696.\nPages tag-storage non-tag pageable:            92400.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6786240.\nTagged compressions:                          748681.\nTagged decompressions:                        615453.\n"
      }
    },
    {
      "elapsed_seconds": 10.067899665998993,
      "stable_seconds": 10.056883999990532,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26121388032,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24686051328,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470697.\nPages active:                                 857449.\nPages inactive:                               802455.\nPages speculative:                             87639.\nPages throttled:                                   0.\nPages wired down:                             181226.\nPages purgeable:                                3723.\n\"Translation faults\":                     1976896891.\nPages copy-on-write:                        99267299.\nPages zero filled:                        3245363710.\nPages reactivated:                         174110859.\nPages purged:                               12777246.\nFile-backed pages:                           1032297.\nAnonymous pages:                              715246.\nPages stored in compressor:                  1291490.\nPages occupied by compressor:                 685427.\nDecompressions:                            104202296.\nCompressions:                              118103034.\nPageins:                                  2346367098.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128045.\nPages tagged resident:                         83582.\nPages tagged compressed:                       44463.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                          657.\nPages tag-storage non-tag pageable:            92439.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6786240.\nTagged compressions:                          748681.\nTagged decompressions:                        615453.\n"
      }
    },
    {
      "elapsed_seconds": 15.100237082981039,
      "stable_seconds": 15.089221416972578,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25914081280,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24478023680,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   461213.\nPages active:                                 847916.\nPages inactive:                               802991.\nPages speculative:                             87849.\nPages throttled:                                   0.\nPages wired down:                             200444.\nPages purgeable:                                 270.\n\"Translation faults\":                     1976904734.\nPages copy-on-write:                        99268020.\nPages zero filled:                        3245498190.\nPages reactivated:                         174110870.\nPages purged:                               12777246.\nFile-backed pages:                           1032537.\nAnonymous pages:                              706219.\nPages stored in compressor:                  1289950.\nPages occupied by compressor:                 684781.\nDecompressions:                            104203840.\nCompressions:                              118103034.\nPageins:                                  2346367138.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127917.\nPages tagged resident:                         83454.\nPages tagged compressed:                       44463.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                          640.\nPages tag-storage non-tag pageable:            92456.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6786240.\nTagged compressions:                          748681.\nTagged decompressions:                        615453.\n"
      }
    },
    {
      "elapsed_seconds": 20.13184779099538,
      "stable_seconds": 20.12083212498692,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26028195840,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24588926976,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   467467.\nPages active:                                 848930.\nPages inactive:                               803083.\nPages speculative:                             87900.\nPages throttled:                                   0.\nPages wired down:                             193229.\nPages purgeable:                                 727.\n\"Translation faults\":                     1976915299.\nPages copy-on-write:                        99268813.\nPages zero filled:                        3245580138.\nPages reactivated:                         174110977.\nPages purged:                               12777246.\nFile-backed pages:                           1032595.\nAnonymous pages:                              707318.\nPages stored in compressor:                  1289531.\nPages occupied by compressor:                 684612.\nDecompressions:                            104204030.\nCompressions:                              118103034.\nPageins:                                  2346367157.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127821.\nPages tagged resident:                         83369.\nPages tagged compressed:                       44452.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                          671.\nPages tag-storage non-tag pageable:            92425.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6785152.\nTagged compressions:                          748681.\nTagged decompressions:                        615464.\n"
      }
    },
    {
      "elapsed_seconds": 25.163784832984675,
      "stable_seconds": 25.152769166976213,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25880756224,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24438571008,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   454490.\nPages active:                                 859608.\nPages inactive:                               803780.\nPages speculative:                             87944.\nPages throttled:                                   0.\nPages wired down:                             194836.\nPages purgeable:                                4456.\n\"Translation faults\":                     1976924390.\nPages copy-on-write:                        99269698.\nPages zero filled:                        3245654761.\nPages reactivated:                         174110986.\nPages purged:                               12777246.\nFile-backed pages:                           1032666.\nAnonymous pages:                              718666.\nPages stored in compressor:                  1288197.\nPages occupied by compressor:                 684320.\nDecompressions:                            104205367.\nCompressions:                              118103034.\nPageins:                                  2346367183.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127958.\nPages tagged resident:                         83509.\nPages tagged compressed:                       44449.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                          655.\nPages tag-storage non-tag pageable:            92441.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6784960.\nTagged compressions:                          748681.\nTagged decompressions:                        615467.\n"
      }
    },
    {
      "elapsed_seconds": 30.194105208007386,
      "stable_seconds": 30.183089541998925,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25821921280,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24358207488,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   447738.\nPages active:                                 857214.\nPages inactive:                               804053.\nPages speculative:                             89415.\nPages throttled:                                   0.\nPages wired down:                             202934.\nPages purgeable:                                4404.\n\"Translation faults\":                     1976941705.\nPages copy-on-write:                        99270446.\nPages zero filled:                        3245740005.\nPages reactivated:                         174110986.\nPages purged:                               12777246.\nFile-backed pages:                           1034565.\nAnonymous pages:                              716117.\nPages stored in compressor:                  1285915.\nPages occupied by compressor:                 683726.\nDecompressions:                            104207556.\nCompressions:                              118103034.\nPageins:                                  2346368071.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128427.\nPages tagged resident:                         84165.\nPages tagged compressed:                       44262.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                          569.\nPages tag-storage non-tag pageable:            92527.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6746048.\nTagged compressions:                          748681.\nTagged decompressions:                        615654.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/round-3-split/receipt.json

Original bytes: 22215. SHA-256: `e6d8458ca128ab9e0f019846e5730fdbde3cc3bdd49e90f48d00d2203d8e7db7`.

Normalized bytes: 22215. SHA-256: `e6d8458ca128ab9e0f019846e5730fdbde3cc3bdd49e90f48d00d2203d8e7db7`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.6537988116263591,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0384665000019595,
    3.3744465410127304,
    3.5694848330167588,
    3.753435749997152,
    3.9309763750061393,
    4.1029036249965429,
    4.2717930000217166,
    4.4619202500034589,
    4.6361700000124983,
    4.8186875410028733,
    4.9902856660191901,
    5.1469937910151202,
    5.3095858330198098,
    5.4624470410053618,
    5.6481618749967311,
    5.8012438750010915,
    5.9402689580165315,
    6.1088485000072978,
    6.2694986660208087,
    6.4574142080091406,
    6.6330362910230178,
    6.7955326250230428,
    6.9654802080185618,
    7.1437505409994628,
    7.3811594160215463,
    7.6285162080021109,
    7.7998869160073809,
    7.9768577080103569,
    8.1894426660146564,
    8.3796405830071308,
    8.5637717909994535,
    8.7272919579991139,
    8.9203054580138996,
    9.0970297500025481,
    9.2675842500175349,
    9.4467430410149973,
    9.6378891250060406,
    9.8277436250064056,
    10.013382416014792,
    10.184565791016212,
    10.350216416001786,
    10.543078875023639,
    10.738648208003724,
    10.920940333016915,
    11.085298582998803,
    11.293947833008133,
    11.497605958022177,
    11.684925958019448,
    11.854729250015225,
    12.018611666018842,
    12.224439791025361,
    12.44126354099717,
    12.609241583006224,
    12.774985625001136,
    12.938440583006013,
    13.140748750010971,
    13.319582875003107,
    13.503945666016079,
    13.661948624998331,
    13.832434791023843,
    14.024773250013823,
    14.204991000005975,
    14.402833375002956,
    14.573593250010163,
    14.7776363750163,
    14.936345082998741,
    15.127284458023496,
    15.318606500019087,
    15.487188041006448,
    15.650402750005014,
    15.831485500006238,
    16.005409625009634,
    16.167333958001109,
    16.323620083014248,
    16.484534791001352,
    16.638321000005817,
    16.783974707999732,
    16.952710458019283,
    17.112351875024615,
    17.2578923330002,
    17.442822833021637,
    17.617839250015095,
    17.799435833003372,
    17.966758166003274,
    18.145093208004255,
    18.312111416016705,
    18.458697458001552,
    18.63099395800964,
    18.875769625010435,
    19.162166374997469,
    19.329839583020657,
    19.487992166017648,
    19.642430333013181,
    19.792495375004364,
    19.943345833016792,
    20.113584708014969,
    20.265663833008148,
    20.421066375012742,
    20.600404708005954,
    20.797779708023882,
    20.970769125007791,
    21.126710791024379,
    21.291267416003393,
    21.459356166014913,
    21.686105125001632,
    21.834942041023169,
    22.005351750005502,
    22.151235249999445,
    22.313179457996739,
    22.466182458010735,
    22.617883291008184,
    22.815399833023548,
    23.002297625003848,
    23.163500958005898,
    23.326178916002391,
    23.494618166005239,
    23.655462041002465,
    23.83265462500276,
    23.990544291009428,
    24.154655582999112,
    24.344176625018008,
    24.527837083005579,
    24.685292166017462,
    24.830842625000514,
    24.993909541022731,
    25.154901666013757,
    25.338403750007274,
    25.501239625009475
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25562660864,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.33598004101077095,
    0.19503829200402834,
    0.18395091698039323,
    0.17754062500898726,
    0.17192724999040365,
    0.16888937502517365,
    0.19012724998174235,
    0.17424975000903942,
    0.18251754099037498,
    0.17159812501631677,
    0.15670812499593012,
    0.16259204200468957,
    0.15286120798555203,
    0.18571483399136923,
    0.15308200000436045,
    0.13902508301544003,
    0.1685795419907663,
    0.1606501660135109,
    0.18791554198833182,
    0.17562208301387727,
    0.16249633400002494,
    0.16994758299551904,
    0.178270332980901,
    0.23740887502208352,
    0.24735679198056459,
    0.17137070800526999,
    0.17697079200297594,
    0.21258495800429955,
    0.19019791699247435,
    0.18413120799232274,
    0.16352016699966043,
    0.19301350001478568,
    0.17672429198864847,
    0.17055450001498684,
    0.17915879099746235,
    0.19114608399104327,
    0.18985450000036508,
    0.18563879100838676,
    0.17118337500141934,
    0.16565062498557381,
    0.19286245902185328,
    0.19556933298008516,
    0.18229212501319125,
    0.16435824998188764,
    0.20864925000932999,
    0.20365812501404434,
    0.18731999999727122,
    0.16980329199577682,
    0.16388241600361653,
    0.20582812500651926,
    0.21682374997180887,
    0.16797804200905375,
    0.16574404199491255,
    0.16345495800487697,
    0.2023081670049578,
    0.17883412499213591,
    0.18436279101297259,
    0.15800295898225158,
    0.17048616602551192,
    0.1923384589899797,
    0.18021774999215268,
    0.19784237499698065,
    0.17075987500720657,
    0.20404312500613742,
    0.15870870798244141,
    0.19093937502475455,
    0.19132204199559055,
    0.16858154098736122,
    0.16321470899856649,
    0.18108275000122376,
    0.1739241250033956,
    0.16192433299147524,
    0.1562861250131391,
    0.16091470798710361,
    0.15378620900446549,
    0.1456537079939153,
    0.16873575001955032,
    0.15964141700533219,
    0.14554045797558501,
    0.18493050002143718,
    0.17501641699345782,
    0.18159658298827708,
    0.16732233299990185,
    0.17833504200098105,
    0.16701820801245049,
    0.14658604198484682,
    0.17229650000808761,
    0.24477566700079478,
    0.28639674998703413,
    0.16767320802318864,
    0.15815258299699053,
    0.15443816699553281,
    0.15006504199118353,
    0.15085045801242813,
    0.17023887499817647,
    0.15207912499317899,
    0.15540254200459458,
    0.17933833299321122,
    0.19737500001792796,
    0.1729894169839099,
    0.15594166601658799,
    0.16455662497901358,
    0.16808875001152046,
    0.22674895898671821,
    0.14883691602153704,
    0.17040970898233354,
    0.14588349999394268,
    0.16194420799729414,
    0.15300300001399592,
    0.15170083299744874,
    0.19751654201536439,
    0.1868977919803001,
    0.16120333300204948,
    0.16267795799649321,
    0.16843925000284798,
    0.16084387499722652,
    0.17719258400029503,
    0.15788966600666754,
    0.1641112919896841,
    0.18952104201889597,
    0.18366045798757114,
    0.15745508301188238,
    0.14555045898305252,
    0.1630669160222169,
    0.16099212499102578,
    0.18350208399351686,
    0.16283587500220165
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.330461208010092,
  "metadata_seconds" : 0.13483354198979214,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7742904368,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 25.501258916017832,
  "request_vm_after" : {
    "reclaimableBytes" : 18280497152,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17671274496,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.0384665000019595,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-3-split-supervision/identity.json

Original bytes: 3183. SHA-256: `761106bb6dabfda07f893ef611fbc30e5355a60557b9d2a05602fa087b811a48`.

Normalized bytes: 3127. SHA-256: `52c8f806885a715ddf3f5c99d5d01258212c8eec7befc3620a1769fb75f6fb61`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/split-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/round-3-split",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-split/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24356585472,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   447632.\nPages active:                                 857793.\nPages inactive:                               804066.\nPages speculative:                             89418.\nPages throttled:                                   0.\nPages wired down:                             202654.\nPages purgeable:                                4404.\n\"Translation faults\":                     1976949318.\nPages copy-on-write:                        99271243.\nPages zero filled:                        3245754892.\nPages reactivated:                         174110986.\nPages purged:                               12777246.\nFile-backed pages:                           1034572.\nAnonymous pages:                              716705.\nPages stored in compressor:                  1285911.\nPages occupied by compressor:                 683726.\nDecompressions:                            104207572.\nCompressions:                              118103034.\nPageins:                                  2346368080.\nPageouts:                                     487804.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128460.\nPages tagged resident:                         84199.\nPages tagged compressed:                       44261.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5200.\nPages tag-storage free:                          571.\nPages tag-storage non-tag pageable:            92525.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6745536.\nTagged compressions:                          748681.\nTagged decompressions:                        615655.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/round-3-split-supervision/receipt.json

Original bytes: 2140. SHA-256: `c76a5c209d307de16eada528d37d7bdaf5a85fa97d0dfe3d01c2b56271603665`.

Normalized bytes: 2140. SHA-256: `c76a5c209d307de16eada528d37d7bdaf5a85fa97d0dfe3d01c2b56271603665`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7742904368,
  "samples": 1471,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22694936576,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   354891.\nPages active:                                 868552.\nPages inactive:                               796032.\nPages speculative:                             82870.\nPages throttled:                                   0.\nPages wired down:                             298914.\nPages purgeable:                                5136.\n\"Translation faults\":                     1977699499.\nPages copy-on-write:                        99308626.\nPages zero filled:                        3247779112.\nPages reactivated:                         174170951.\nPages purged:                               12783102.\nFile-backed pages:                           1025162.\nAnonymous pages:                              722292.\nPages stored in compressor:                  1286421.\nPages occupied by compressor:                 683181.\nDecompressions:                            104442584.\nCompressions:                              118384982.\nPageins:                                  2356535012.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128022.\nPages tagged resident:                         83785.\nPages tagged compressed:                       44237.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                         1066.\nPages tag-storage non-tag pageable:            92031.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740480.\nTagged compressions:                          748715.\nTagged decompressions:                        615709.\n"
  },
  "seconds": 85.08001970799523
}
````

### vq-contiguous-cost-v1/round-3-split-supervision/stdout.txt

Original bytes: 22216. SHA-256: `160e7d37feda0f7957f6cf9720231cd10f2185fa1fa4d03a52bce9d63f1ee4d8`.

Normalized bytes: 22216. SHA-256: `160e7d37feda0f7957f6cf9720231cd10f2185fa1fa4d03a52bce9d63f1ee4d8`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 95558400,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 5.6537988116263591,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0384665000019595,
    3.3744465410127304,
    3.5694848330167588,
    3.753435749997152,
    3.9309763750061393,
    4.1029036249965429,
    4.2717930000217166,
    4.4619202500034589,
    4.6361700000124983,
    4.8186875410028733,
    4.9902856660191901,
    5.1469937910151202,
    5.3095858330198098,
    5.4624470410053618,
    5.6481618749967311,
    5.8012438750010915,
    5.9402689580165315,
    6.1088485000072978,
    6.2694986660208087,
    6.4574142080091406,
    6.6330362910230178,
    6.7955326250230428,
    6.9654802080185618,
    7.1437505409994628,
    7.3811594160215463,
    7.6285162080021109,
    7.7998869160073809,
    7.9768577080103569,
    8.1894426660146564,
    8.3796405830071308,
    8.5637717909994535,
    8.7272919579991139,
    8.9203054580138996,
    9.0970297500025481,
    9.2675842500175349,
    9.4467430410149973,
    9.6378891250060406,
    9.8277436250064056,
    10.013382416014792,
    10.184565791016212,
    10.350216416001786,
    10.543078875023639,
    10.738648208003724,
    10.920940333016915,
    11.085298582998803,
    11.293947833008133,
    11.497605958022177,
    11.684925958019448,
    11.854729250015225,
    12.018611666018842,
    12.224439791025361,
    12.44126354099717,
    12.609241583006224,
    12.774985625001136,
    12.938440583006013,
    13.140748750010971,
    13.319582875003107,
    13.503945666016079,
    13.661948624998331,
    13.832434791023843,
    14.024773250013823,
    14.204991000005975,
    14.402833375002956,
    14.573593250010163,
    14.7776363750163,
    14.936345082998741,
    15.127284458023496,
    15.318606500019087,
    15.487188041006448,
    15.650402750005014,
    15.831485500006238,
    16.005409625009634,
    16.167333958001109,
    16.323620083014248,
    16.484534791001352,
    16.638321000005817,
    16.783974707999732,
    16.952710458019283,
    17.112351875024615,
    17.2578923330002,
    17.442822833021637,
    17.617839250015095,
    17.799435833003372,
    17.966758166003274,
    18.145093208004255,
    18.312111416016705,
    18.458697458001552,
    18.63099395800964,
    18.875769625010435,
    19.162166374997469,
    19.329839583020657,
    19.487992166017648,
    19.642430333013181,
    19.792495375004364,
    19.943345833016792,
    20.113584708014969,
    20.265663833008148,
    20.421066375012742,
    20.600404708005954,
    20.797779708023882,
    20.970769125007791,
    21.126710791024379,
    21.291267416003393,
    21.459356166014913,
    21.686105125001632,
    21.834942041023169,
    22.005351750005502,
    22.151235249999445,
    22.313179457996739,
    22.466182458010735,
    22.617883291008184,
    22.815399833023548,
    23.002297625003848,
    23.163500958005898,
    23.326178916002391,
    23.494618166005239,
    23.655462041002465,
    23.83265462500276,
    23.990544291009428,
    24.154655582999112,
    24.344176625018008,
    24.527837083005579,
    24.685292166017462,
    24.830842625000514,
    24.993909541022731,
    25.154901666013757,
    25.338403750007274,
    25.501239625009475
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25562660864,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.33598004101077095,
    0.19503829200402834,
    0.18395091698039323,
    0.17754062500898726,
    0.17192724999040365,
    0.16888937502517365,
    0.19012724998174235,
    0.17424975000903942,
    0.18251754099037498,
    0.17159812501631677,
    0.15670812499593012,
    0.16259204200468957,
    0.15286120798555203,
    0.18571483399136923,
    0.15308200000436045,
    0.13902508301544003,
    0.1685795419907663,
    0.1606501660135109,
    0.18791554198833182,
    0.17562208301387727,
    0.16249633400002494,
    0.16994758299551904,
    0.178270332980901,
    0.23740887502208352,
    0.24735679198056459,
    0.17137070800526999,
    0.17697079200297594,
    0.21258495800429955,
    0.19019791699247435,
    0.18413120799232274,
    0.16352016699966043,
    0.19301350001478568,
    0.17672429198864847,
    0.17055450001498684,
    0.17915879099746235,
    0.19114608399104327,
    0.18985450000036508,
    0.18563879100838676,
    0.17118337500141934,
    0.16565062498557381,
    0.19286245902185328,
    0.19556933298008516,
    0.18229212501319125,
    0.16435824998188764,
    0.20864925000932999,
    0.20365812501404434,
    0.18731999999727122,
    0.16980329199577682,
    0.16388241600361653,
    0.20582812500651926,
    0.21682374997180887,
    0.16797804200905375,
    0.16574404199491255,
    0.16345495800487697,
    0.2023081670049578,
    0.17883412499213591,
    0.18436279101297259,
    0.15800295898225158,
    0.17048616602551192,
    0.1923384589899797,
    0.18021774999215268,
    0.19784237499698065,
    0.17075987500720657,
    0.20404312500613742,
    0.15870870798244141,
    0.19093937502475455,
    0.19132204199559055,
    0.16858154098736122,
    0.16321470899856649,
    0.18108275000122376,
    0.1739241250033956,
    0.16192433299147524,
    0.1562861250131391,
    0.16091470798710361,
    0.15378620900446549,
    0.1456537079939153,
    0.16873575001955032,
    0.15964141700533219,
    0.14554045797558501,
    0.18493050002143718,
    0.17501641699345782,
    0.18159658298827708,
    0.16732233299990185,
    0.17833504200098105,
    0.16701820801245049,
    0.14658604198484682,
    0.17229650000808761,
    0.24477566700079478,
    0.28639674998703413,
    0.16767320802318864,
    0.15815258299699053,
    0.15443816699553281,
    0.15006504199118353,
    0.15085045801242813,
    0.17023887499817647,
    0.15207912499317899,
    0.15540254200459458,
    0.17933833299321122,
    0.19737500001792796,
    0.1729894169839099,
    0.15594166601658799,
    0.16455662497901358,
    0.16808875001152046,
    0.22674895898671821,
    0.14883691602153704,
    0.17040970898233354,
    0.14588349999394268,
    0.16194420799729414,
    0.15300300001399592,
    0.15170083299744874,
    0.19751654201536439,
    0.1868977919803001,
    0.16120333300204948,
    0.16267795799649321,
    0.16843925000284798,
    0.16084387499722652,
    0.17719258400029503,
    0.15788966600666754,
    0.1641112919896841,
    0.18952104201889597,
    0.18366045798757114,
    0.15745508301188238,
    0.14555045898305252,
    0.1630669160222169,
    0.16099212499102578,
    0.18350208399351686,
    0.16283587500220165
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.330461208010092,
  "metadata_seconds" : 0.13483354198979214,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_verified_bytes" : 0,
  "packed_verified_files" : 0,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7742904368,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "record_storage" : "split-tensor-ranges-v1",
  "request_seconds" : 25.501258916017832,
  "request_vm_after" : {
    "reclaimableBytes" : 18280497152,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17671274496,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.0384665000019595,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "2a494b350cae95ca15feb14f150502e676d47108502b3400142887a8b1ba4d90",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-3-split-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-v1/round-3-contiguous-admission.json

Original bytes: 17281. SHA-256: `5d48d69104a042ef46923253f663a9fba7091a4ce8287e1e0f86931d66d08f75`.

Normalized bytes: 17281. SHA-256: `5d48d69104a042ef46923253f663a9fba7091a4ce8287e1e0f86931d66d08f75`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.010173749993555248,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 18280497152,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24601935872,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470878.\nPages active:                                 854284.\nPages inactive:                               810704.\nPages speculative:                             82875.\nPages throttled:                                   0.\nPages wired down:                             182472.\nPages purgeable:                                5136.\n\"Translation faults\":                     1977701298.\nPages copy-on-write:                        99308927.\nPages zero filled:                        3247779297.\nPages reactivated:                         174170951.\nPages purged:                               12783102.\nFile-backed pages:                           1025569.\nAnonymous pages:                              722294.\nPages stored in compressor:                  1286419.\nPages occupied by compressor:                 683181.\nDecompressions:                            104442590.\nCompressions:                              118384982.\nPageins:                                  2356535230.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128002.\nPages tagged resident:                         83765.\nPages tagged compressed:                       44237.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          897.\nPages tag-storage non-tag pageable:            92200.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740480.\nTagged compressions:                          748715.\nTagged decompressions:                        615709.\n"
      }
    },
    {
      "elapsed_seconds": 5.041411416983465,
      "stable_seconds": 5.0312376669899095,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25873088512,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24508301312,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   468452.\nPages active:                                 842400.\nPages inactive:                               812362.\nPages speculative:                             83194.\nPages throttled:                                   0.\nPages wired down:                             195423.\nPages purgeable:                                1504.\n\"Translation faults\":                     1977735556.\nPages copy-on-write:                        99315787.\nPages zero filled:                        3247901367.\nPages reactivated:                         174170953.\nPages purged:                               12783102.\nFile-backed pages:                           1025912.\nAnonymous pages:                              712044.\nPages stored in compressor:                  1285794.\nPages occupied by compressor:                 683029.\nDecompressions:                            104442940.\nCompressions:                              118384982.\nPageins:                                  2356535403.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 128021.\nPages tagged resident:                         83784.\nPages tagged compressed:                       44237.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          555.\nPages tag-storage non-tag pageable:            92542.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740480.\nTagged compressions:                          748715.\nTagged decompressions:                        615709.\n"
      }
    },
    {
      "elapsed_seconds": 10.071162499982165,
      "stable_seconds": 10.06098874998861,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25752158208,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24421498880,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   463261.\nPages active:                                 844866.\nPages inactive:                               813614.\nPages speculative:                             83411.\nPages throttled:                                   0.\nPages wired down:                             197761.\nPages purgeable:                                1077.\n\"Translation faults\":                     1977747098.\nPages copy-on-write:                        99316462.\nPages zero filled:                        3247993688.\nPages reactivated:                         174170961.\nPages purged:                               12783102.\nFile-backed pages:                           1026232.\nAnonymous pages:                              715659.\nPages stored in compressor:                  1283785.\nPages occupied by compressor:                 682070.\nDecompressions:                            104443756.\nCompressions:                              118384982.\nPageins:                                  2356535612.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127925.\nPages tagged resident:                         83688.\nPages tagged compressed:                       44237.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          383.\nPages tag-storage non-tag pageable:            92714.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740480.\nTagged compressions:                          748715.\nTagged decompressions:                        615709.\n"
      }
    },
    {
      "elapsed_seconds": 15.102653208974516,
      "stable_seconds": 15.09247945898096,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25839648768,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24473944064,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   466430.\nPages active:                                 843937.\nPages inactive:                               813979.\nPages speculative:                             83427.\nPages throttled:                                   0.\nPages wired down:                             195494.\nPages purgeable:                                1087.\n\"Translation faults\":                     1977760324.\nPages copy-on-write:                        99317713.\nPages zero filled:                        3248120904.\nPages reactivated:                         174170961.\nPages purged:                               12783102.\nFile-backed pages:                           1026254.\nAnonymous pages:                              715089.\nPages stored in compressor:                  1283312.\nPages occupied by compressor:                 681942.\nDecompressions:                            104443877.\nCompressions:                              118384982.\nPageins:                                  2356535648.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127891.\nPages tagged resident:                         83654.\nPages tagged compressed:                       44237.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          423.\nPages tag-storage non-tag pageable:            92674.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6740480.\nTagged compressions:                          748715.\nTagged decompressions:                        615709.\n"
      }
    },
    {
      "elapsed_seconds": 20.13308162498288,
      "stable_seconds": 20.122907874989323,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25915441152,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24546312192,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   465989.\nPages active:                                 857143.\nPages inactive:                               815464.\nPages speculative:                             83625.\nPages throttled:                                   0.\nPages wired down:                             181224.\nPages purgeable:                                5728.\n\"Translation faults\":                     1977765474.\nPages copy-on-write:                        99318370.\nPages zero filled:                        3248189680.\nPages reactivated:                         174170961.\nPages purged:                               12783102.\nFile-backed pages:                           1026471.\nAnonymous pages:                              729761.\nPages stored in compressor:                  1282707.\nPages occupied by compressor:                 681617.\nDecompressions:                            104444382.\nCompressions:                              118384982.\nPageins:                                  2356535669.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127929.\nPages tagged resident:                         83706.\nPages tagged compressed:                       44223.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          395.\nPages tag-storage non-tag pageable:            92702.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6738560.\nTagged compressions:                          748715.\nTagged decompressions:                        615718.\n"
      }
    },
    {
      "elapsed_seconds": 25.163761167001212,
      "stable_seconds": 25.153587417007657,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25924878336,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24555831296,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   467054.\nPages active:                                 857426.\nPages inactive:                               816666.\nPages speculative:                             83629.\nPages throttled:                                   0.\nPages wired down:                             178681.\nPages purgeable:                                5236.\n\"Translation faults\":                     1977770821.\nPages copy-on-write:                        99319115.\nPages zero filled:                        3248259278.\nPages reactivated:                         174171073.\nPages purged:                               12783102.\nFile-backed pages:                           1026479.\nAnonymous pages:                              731242.\nPages stored in compressor:                  1282509.\nPages occupied by compressor:                 681511.\nDecompressions:                            104444516.\nCompressions:                              118384982.\nPageins:                                  2356535677.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127936.\nPages tagged resident:                         83720.\nPages tagged compressed:                       44216.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          402.\nPages tag-storage non-tag pageable:            92695.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6736320.\nTagged compressions:                          748715.\nTagged decompressions:                        615725.\n"
      }
    },
    {
      "elapsed_seconds": 30.196501166996313,
      "stable_seconds": 30.186327417002758,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25728991232,
          "swapins": 40,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24361811968,
        "swapins": 40,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   459229.\nPages active:                                 843018.\nPages inactive:                               818022.\nPages speculative:                             83644.\nPages throttled:                                   0.\nPages wired down:                             199867.\nPages purgeable:                                1181.\n\"Translation faults\":                     1977784962.\nPages copy-on-write:                        99320705.\nPages zero filled:                        3248352258.\nPages reactivated:                         174171088.\nPages purged:                               12783102.\nFile-backed pages:                           1026517.\nAnonymous pages:                              718167.\nPages stored in compressor:                  1282206.\nPages occupied by compressor:                 681348.\nDecompressions:                            104444742.\nCompressions:                              118384982.\nPageins:                                  2356535714.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127844.\nPages tagged resident:                         83639.\nPages tagged compressed:                       44205.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          399.\nPages tag-storage non-tag pageable:            92698.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6733440.\nTagged compressions:                          748715.\nTagged decompressions:                        615736.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-contiguous-cost-v1/round-3-contiguous/receipt.json

Original bytes: 22319. SHA-256: `6425427b617f283debff3cb25d74358e64e02b2accefbf55fcb8bbeca96cb519`.

Normalized bytes: 22319. SHA-256: `6425427b617f283debff3cb25d74358e64e02b2accefbf55fcb8bbeca96cb519`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.7671747531585318,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.007833749987185,
    3.3160677499836311,
    3.4850310839829035,
    3.6409293339820579,
    3.7884260839782655,
    3.9317647919815499,
    4.0746288749796804,
    4.2340944169845898,
    4.382714749983279,
    4.5396457089809701,
    4.6792159589822404,
    4.8079717920045368,
    4.9438136249955278,
    5.0679441249812953,
    5.2245654169819318,
    5.355433874996379,
    5.4723671669780742,
    5.6128450419928413,
    5.750336333992891,
    5.9084984590008389,
    6.0556231249938719,
    6.191603541985387,
    6.334425334003754,
    6.4835198749788105,
    6.6421787499857601,
    6.7883394589880481,
    6.9349534589855466,
    7.0766257499926724,
    7.2625469169870485,
    7.422991874977015,
    7.5743623749876861,
    7.7089164170029107,
    7.866813667002134,
    8.0147369169862941,
    8.1563988749985583,
    8.3091709169966634,
    8.4689910419983789,
    8.6273882499954198,
    8.7751338339876384,
    8.9191640419885516,
    9.0558364999887999,
    9.217249291978078,
    9.3831158749817405,
    9.5350424170028418,
    9.6745511670014821,
    9.8538789169979282,
    10.022446416987805,
    10.174257584003499,
    10.317245874990476,
    10.452940791990841,
    10.588420458982,
    10.72686049999902,
    10.873223874979885,
    11.018382999987807,
    11.154333874990698,
    11.326705999992555,
    11.467347750003682,
    11.617594416980864,
    11.746412209002301,
    11.880290792003507,
    12.040659749996848,
    12.185471042001154,
    12.337646416999632,
    12.472954333992675,
    12.640005708992248,
    12.768201166996732,
    12.924975542002358,
    13.086254624999128,
    13.231644916988444,
    13.366548208985478,
    13.520944958989276,
    13.664903416996822,
    13.811499208997702,
    13.949356833996717,
    14.084688417002326,
    14.215682958980324,
    14.339132708992111,
    14.486252417002106,
    14.621140749979531,
    14.743020458990941,
    14.906485916988458,
    15.048581874987576,
    15.204920499993023,
    15.347223708988167,
    15.491493833978893,
    15.626352499995846,
    15.747540124983061,
    15.877943708997918,
    16.033005749981385,
    16.181144583999412,
    16.312936125003034,
    16.465241166995838,
    16.69945733397617,
    16.832622374990024,
    16.962815584003692,
    17.102346125000622,
    17.232714916986879,
    17.364753749978263,
    17.513956708979094,
    17.682774416985922,
    17.823940959002357,
    17.956135458982317,
    18.105227541993372,
    18.240759084001184,
    18.372544041980291,
    18.489979459001916,
    18.631536959001096,
    18.753547000000253,
    18.884014999988722,
    19.007363708980847,
    19.129322166991187,
    19.305721249984344,
    19.462901874998352,
    19.602009291993454,
    19.736635749984998,
    19.874455291981576,
    20.034420666983351,
    20.197282374982024,
    20.327365499979351,
    20.472038416977739,
    20.626717833976727,
    20.780094333982561,
    20.914484749984695,
    21.036757333989954,
    21.171796249982435,
    21.310780208994402,
    21.535756666999077,
    21.774897499999497
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25485148160,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.30823399999644607,
    0.16896333399927244,
    0.15589824999915436,
    0.14749674999620765,
    0.14333870800328441,
    0.14286408299813047,
    0.15946554200490937,
    0.14862033299868926,
    0.15693095899769105,
    0.13957025000127032,
    0.12875583302229643,
    0.13584183299099095,
    0.12413049998576753,
    0.15662129200063646,
    0.13086845801444724,
    0.11693329198169522,
    0.14047787501476705,
    0.13749129200004973,
    0.15816212500794791,
    0.14712466599303298,
    0.13598041699151509,
    0.14282179201836698,
    0.14909454097505659,
    0.15865887500694953,
    0.14616070900228806,
    0.14661399999749847,
    0.14167229100712575,
    0.18592116699437611,
    0.1604449579899665,
    0.15137050001067109,
    0.1345540420152247,
    0.15789724999922328,
    0.14792324998416007,
    0.14166195801226422,
    0.15277204199810512,
    0.1598201250017155,
    0.15839720799704082,
    0.1477455839922186,
    0.14403020800091326,
    0.1366724580002483,
    0.16141279198927805,
    0.16586658300366253,
    0.15192654202110134,
    0.13950874999864027,
    0.17932774999644607,
    0.16856749998987652,
    0.15181116701569408,
    0.14298829098697752,
    0.13569491700036451,
    0.13547966699115932,
    0.13844004101702012,
    0.14636337498086505,
    0.14515912500792183,
    0.13595087500289083,
    0.17237212500185706,
    0.14064175001112744,
    0.15024666697718203,
    0.12881779202143662,
    0.1338785830012057,
    0.16036895799334161,
    0.14481129200430587,
    0.15217537499847822,
    0.13530791699304245,
    0.16705137499957345,
    0.12819545800448395,
    0.15677437500562519,
    0.16127908299677074,
    0.1453902919893153,
    0.1349032919970341,
    0.15439675000379793,
    0.14395845800754614,
    0.14659579200088046,
    0.13785762499901466,
    0.13533158300560899,
    0.13099454197799787,
    0.12344975001178682,
    0.14711970800999552,
    0.13488833297742531,
    0.12187970901140943,
    0.16346545799751766,
    0.14209595799911767,
    0.15633862500544637,
    0.14230320899514481,
    0.14427012499072589,
    0.13485866601695307,
    0.1211876249872148,
    0.13040358401485719,
    0.15506204098346643,
    0.14813883401802741,
    0.13179154100362211,
    0.15230504199280404,
    0.23421616698033176,
    0.13316504101385362,
    0.13019320901366882,
    0.13953054099692963,
    0.13036879198625684,
    0.13203883299138397,
    0.14920295900083147,
    0.16881770800682716,
    0.14116654201643541,
    0.1321944999799598,
    0.14909208301105537,
    0.13553154200781137,
    0.13178495797910728,
    0.11743541702162474,
    0.14155749999918044,
    0.12201004099915735,
    0.13046799998846836,
    0.12334870899212547,
    0.12195845801034011,
    0.17639908299315721,
    0.15718062501400709,
    0.13910741699510254,
    0.13462645799154416,
    0.13781954199657775,
    0.1599653750017751,
    0.1628617079986725,
    0.1300831249973271,
    0.14467291699838825,
    0.15467941699898802,
    0.1533765000058338,
    0.13439041600213386,
    0.12227258400525898,
    0.13503891599248163,
    0.13898395901196636,
    0.22497645800467581,
    0.23914083300041966
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 77.762044209026499,
  "metadata_seconds" : 0.13465320799150504,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7760713800,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 21.774922708980739,
  "request_vm_after" : {
    "reclaimableBytes" : 16858972160,
    "swapins" : 44,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 22787670016,
    "swapins" : 44,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.007833749987185,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-3-contiguous-supervision/identity.json

Original bytes: 3326. SHA-256: `c5a93c04e15a154d1816aac88a623761bdc9d672086449b274834eace7a96ae3`.

Normalized bytes: 3263. SHA-256: `b3ed621c76bf5a2ea09c9128acda87f2c13b0e65b7f224c1a9a4149abe08e6a0`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/contiguous-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/round-3-contiguous",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--packed-record-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-records-v1",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-cost-v1/validation-contiguous/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24364302336,
    "swapins": 40,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   459380.\nPages active:                                 843022.\nPages inactive:                               818023.\nPages speculative:                             83644.\nPages throttled:                                   0.\nPages wired down:                             199867.\nPages purgeable:                                1181.\n\"Translation faults\":                     1977790289.\nPages copy-on-write:                        99321518.\nPages zero filled:                        3248365492.\nPages reactivated:                         174171088.\nPages purged:                               12783102.\nFile-backed pages:                           1026518.\nAnonymous pages:                              718171.\nPages stored in compressor:                  1282205.\nPages occupied by compressor:                 681348.\nDecompressions:                            104444755.\nCompressions:                              118384982.\nPageins:                                  2356535720.\nPageouts:                                     488477.\nSwapins:                                          40.\nSwapouts:                                       2908.\nPages tagged:                                 127814.\nPages tagged resident:                         83609.\nPages tagged compressed:                       44205.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5199.\nPages tag-storage free:                          399.\nPages tag-storage non-tag pageable:            92698.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6733440.\nTagged compressions:                          748715.\nTagged decompressions:                        615736.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-contiguous-cost-v1/round-3-contiguous-supervision/receipt.json

Original bytes: 2140. SHA-256: `385c4b659cb8e3c5a85ec38391dd437b7a739346c4cb31e32663612b84349d43`.

Normalized bytes: 2140. SHA-256: `385c4b659cb8e3c5a85ec38391dd437b7a739346c4cb31e32663612b84349d43`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7760713800,
  "samples": 1724,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22346629120,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   366986.\nPages active:                                 848632.\nPages inactive:                               829264.\nPages speculative:                             30443.\nPages throttled:                                   0.\nPages wired down:                             311615.\nPages purgeable:                                 796.\n\"Translation faults\":                     1981531104.\nPages copy-on-write:                        99498867.\nPages zero filled:                        3250733369.\nPages reactivated:                         174253840.\nPages purged:                               12793374.\nFile-backed pages:                            996148.\nAnonymous pages:                              712191.\nPages stored in compressor:                  1309595.\nPages occupied by compressor:                 697605.\nDecompressions:                            104711311.\nCompressions:                              118722359.\nPageins:                                  2370475832.\nPageouts:                                     489440.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 131383.\nPages tagged resident:                         87512.\nPages tagged compressed:                       43871.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5198.\nPages tag-storage free:                          858.\nPages tag-storage non-tag pageable:            92240.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6661952.\nTagged compressions:                          748804.\nTagged decompressions:                        616154.\n"
  },
  "seconds": 99.78733949997695
}
````

### vq-contiguous-cost-v1/round-3-contiguous-supervision/stdout.txt

Original bytes: 22320. SHA-256: `643197244f6df39df374ea356e61c048b9007978c5b48364b0da16bd0f25ae47`.

Normalized bytes: 22320. SHA-256: `643197244f6df39df374ea356e61c048b9007978c5b48364b0da16bd0f25ae47`.

````text
{
  "cache_after" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 32958,
    "hits" : 33188,
    "loads" : 34782,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_after_prefill" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 5186,
    "hits" : 0,
    "loads" : 7010,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : 1535,
    "maximum_read_staging_bytes" : 115015680,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : 287,
    "occupied_records" : 1824,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 2082816,
    "total_capacity" : 1824
  },
  "cache_before" : {
    "allocation_classes" : 2,
    "dense_savings_reinvested" : 1,
    "evictions" : 0,
    "hits" : 0,
    "loads" : 0,
    "maximum_bank_capacity" : 1536,
    "maximum_book_bytes" : 2082816,
    "maximum_executed_slot" : -1,
    "maximum_read_staging_bytes" : 0,
    "minimum_bank_capacity" : 288,
    "minimum_class_maximum_executed_slot" : -1,
    "occupied_records" : 0,
    "parallel_read_lanes" : 12,
    "pinned_records" : 0,
    "reserved_bank_bytes" : 3583180800,
    "resident_book_bytes" : 0,
    "total_capacity" : 1824
  },
  "committed_decode_tokens_per_second" : 6.7671747531585318,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.007833749987185,
    3.3160677499836311,
    3.4850310839829035,
    3.6409293339820579,
    3.7884260839782655,
    3.9317647919815499,
    4.0746288749796804,
    4.2340944169845898,
    4.382714749983279,
    4.5396457089809701,
    4.6792159589822404,
    4.8079717920045368,
    4.9438136249955278,
    5.0679441249812953,
    5.2245654169819318,
    5.355433874996379,
    5.4723671669780742,
    5.6128450419928413,
    5.750336333992891,
    5.9084984590008389,
    6.0556231249938719,
    6.191603541985387,
    6.334425334003754,
    6.4835198749788105,
    6.6421787499857601,
    6.7883394589880481,
    6.9349534589855466,
    7.0766257499926724,
    7.2625469169870485,
    7.422991874977015,
    7.5743623749876861,
    7.7089164170029107,
    7.866813667002134,
    8.0147369169862941,
    8.1563988749985583,
    8.3091709169966634,
    8.4689910419983789,
    8.6273882499954198,
    8.7751338339876384,
    8.9191640419885516,
    9.0558364999887999,
    9.217249291978078,
    9.3831158749817405,
    9.5350424170028418,
    9.6745511670014821,
    9.8538789169979282,
    10.022446416987805,
    10.174257584003499,
    10.317245874990476,
    10.452940791990841,
    10.588420458982,
    10.72686049999902,
    10.873223874979885,
    11.018382999987807,
    11.154333874990698,
    11.326705999992555,
    11.467347750003682,
    11.617594416980864,
    11.746412209002301,
    11.880290792003507,
    12.040659749996848,
    12.185471042001154,
    12.337646416999632,
    12.472954333992675,
    12.640005708992248,
    12.768201166996732,
    12.924975542002358,
    13.086254624999128,
    13.231644916988444,
    13.366548208985478,
    13.520944958989276,
    13.664903416996822,
    13.811499208997702,
    13.949356833996717,
    14.084688417002326,
    14.215682958980324,
    14.339132708992111,
    14.486252417002106,
    14.621140749979531,
    14.743020458990941,
    14.906485916988458,
    15.048581874987576,
    15.204920499993023,
    15.347223708988167,
    15.491493833978893,
    15.626352499995846,
    15.747540124983061,
    15.877943708997918,
    16.033005749981385,
    16.181144583999412,
    16.312936125003034,
    16.465241166995838,
    16.69945733397617,
    16.832622374990024,
    16.962815584003692,
    17.102346125000622,
    17.232714916986879,
    17.364753749978263,
    17.513956708979094,
    17.682774416985922,
    17.823940959002357,
    17.956135458982317,
    18.105227541993372,
    18.240759084001184,
    18.372544041980291,
    18.489979459001916,
    18.631536959001096,
    18.753547000000253,
    18.884014999988722,
    19.007363708980847,
    19.129322166991187,
    19.305721249984344,
    19.462901874998352,
    19.602009291993454,
    19.736635749984998,
    19.874455291981576,
    20.034420666983351,
    20.197282374982024,
    20.327365499979351,
    20.472038416977739,
    20.626717833976727,
    20.780094333982561,
    20.914484749984695,
    21.036757333989954,
    21.171796249982435,
    21.310780208994402,
    21.535756666999077,
    21.774897499999497
  ],
  "expert_file_read_policy" : "buffered-v1",
  "generated" : [
    760,
    1156,
    369,
    9859,
    883,
    1204,
    264,
    2136,
    380,
    12370,
    8404,
    12,
    83167,
    318,
    24797,
    36,
    8,
    1558,
    628,
    958,
    35160,
    16350,
    948,
    1141,
    13914,
    12131,
    21360,
    11,
    321,
    6587,
    728,
    310,
    30982,
    1881,
    264,
    328,
    31617,
    4779,
    21482,
    1,
    321,
    328,
    3127,
    23014,
    1149,
    6558,
    728,
    1683,
    15060,
    883,
    411,
    13,
    271,
    332,
    24797,
    36,
    478,
    35160,
    16350,
    948,
    13914,
    12131,
    21360,
    64700,
    271,
    32,
    5861,
    36,
    1558,
    318,
    4650,
    18639,
    175762,
    11,
    17642,
    38049,
    19025,
    17,
    11,
    4831,
    5946,
    682,
    1599,
    6009,
    28964,
    45,
    9714,
    13,
    8020,
    264,
    25162,
    314,
    11312,
    513,
    21307,
    791,
    3817,
    318,
    68,
    1257,
    2487,
    220,
    17,
    680,
    314,
    220,
    23,
    11312,
    791,
    6000,
    553,
    3095,
    279,
    2702,
    1558,
    13914,
    12131,
    2420,
    21360,
    11,
    488,
    628,
    914,
    2426,
    660,
    6009,
    13914,
    303
  ],
  "initial_vm" : {
    "reclaimableBytes" : 25485148160,
    "swapins" : 40,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.30823399999644607,
    0.16896333399927244,
    0.15589824999915436,
    0.14749674999620765,
    0.14333870800328441,
    0.14286408299813047,
    0.15946554200490937,
    0.14862033299868926,
    0.15693095899769105,
    0.13957025000127032,
    0.12875583302229643,
    0.13584183299099095,
    0.12413049998576753,
    0.15662129200063646,
    0.13086845801444724,
    0.11693329198169522,
    0.14047787501476705,
    0.13749129200004973,
    0.15816212500794791,
    0.14712466599303298,
    0.13598041699151509,
    0.14282179201836698,
    0.14909454097505659,
    0.15865887500694953,
    0.14616070900228806,
    0.14661399999749847,
    0.14167229100712575,
    0.18592116699437611,
    0.1604449579899665,
    0.15137050001067109,
    0.1345540420152247,
    0.15789724999922328,
    0.14792324998416007,
    0.14166195801226422,
    0.15277204199810512,
    0.1598201250017155,
    0.15839720799704082,
    0.1477455839922186,
    0.14403020800091326,
    0.1366724580002483,
    0.16141279198927805,
    0.16586658300366253,
    0.15192654202110134,
    0.13950874999864027,
    0.17932774999644607,
    0.16856749998987652,
    0.15181116701569408,
    0.14298829098697752,
    0.13569491700036451,
    0.13547966699115932,
    0.13844004101702012,
    0.14636337498086505,
    0.14515912500792183,
    0.13595087500289083,
    0.17237212500185706,
    0.14064175001112744,
    0.15024666697718203,
    0.12881779202143662,
    0.1338785830012057,
    0.16036895799334161,
    0.14481129200430587,
    0.15217537499847822,
    0.13530791699304245,
    0.16705137499957345,
    0.12819545800448395,
    0.15677437500562519,
    0.16127908299677074,
    0.1453902919893153,
    0.1349032919970341,
    0.15439675000379793,
    0.14395845800754614,
    0.14659579200088046,
    0.13785762499901466,
    0.13533158300560899,
    0.13099454197799787,
    0.12344975001178682,
    0.14711970800999552,
    0.13488833297742531,
    0.12187970901140943,
    0.16346545799751766,
    0.14209595799911767,
    0.15633862500544637,
    0.14230320899514481,
    0.14427012499072589,
    0.13485866601695307,
    0.1211876249872148,
    0.13040358401485719,
    0.15506204098346643,
    0.14813883401802741,
    0.13179154100362211,
    0.15230504199280404,
    0.23421616698033176,
    0.13316504101385362,
    0.13019320901366882,
    0.13953054099692963,
    0.13036879198625684,
    0.13203883299138397,
    0.14920295900083147,
    0.16881770800682716,
    0.14116654201643541,
    0.1321944999799598,
    0.14909208301105537,
    0.13553154200781137,
    0.13178495797910728,
    0.11743541702162474,
    0.14155749999918044,
    0.12201004099915735,
    0.13046799998846836,
    0.12334870899212547,
    0.12195845801034011,
    0.17639908299315721,
    0.15718062501400709,
    0.13910741699510254,
    0.13462645799154416,
    0.13781954199657775,
    0.1599653750017751,
    0.1628617079986725,
    0.1300831249973271,
    0.14467291699838825,
    0.15467941699898802,
    0.1533765000058338,
    0.13439041600213386,
    0.12227258400525898,
    0.13503891599248163,
    0.13898395901196636,
    0.22497645800467581,
    0.23914083300041966
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 77.762044209026499,
  "metadata_seconds" : 0.13465320799150504,
  "mode" : "measurement",
  "observed_logit_hashes" : [

  ],
  "observed_timing_eligible" : true,
  "operating_conditions" : [
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "nominal"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "packed_manifest_sha256" : "230c53d8bea76e245c8c47863db3fc0f93c549865e7393b5a493c07b0f52b834",
  "packed_verified_bytes" : 47866183680,
  "packed_verified_files" : 48,
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7760713800,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-contiguous-record-cost-pilot-v1",
  "profile_sha256" : "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c",
  "qualification" : "unproven",
  "record_storage" : "contiguous-records-16k-v1",
  "request_seconds" : 21.774922708980739,
  "request_vm_after" : {
    "reclaimableBytes" : 16858972160,
    "swapins" : 44,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 22787670016,
    "swapins" : 44,
    "swapouts" : 2908
  },
  "resident_text" : {
    "dense_hits" : 6272,
    "embedding_hits" : 128,
    "largest_load_copy_bytes" : 317849600,
    "payload_bytes" : 2893477400,
    "resident_families" : 50
  },
  "schema" : 1,
  "scope" : "single-context non-speculative engineering pilot, not complete-configuration qualification",
  "stop" : "length",
  "timing_exclusions" : [

  ],
  "ttft_seconds" : 3.007833749987185,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "99263051aceb16de87eaed363a98b4f85f3979eddc65ee07b102effb59f44f66",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-contiguous-cost-v1/round-3-contiguous-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-contiguous-cost-derived-v1.json

Original bytes: 551. SHA-256: `7232fb2c0d485ea3f46e1a56925241fa8258a9c4e5f150490b9c6607ded55b39`.

Normalized bytes: 551. SHA-256: `7232fb2c0d485ea3f46e1a56925241fa8258a9c4e5f150490b9c6607ded55b39`.

````text
{
  "split": {
    "median_load_seconds": 59.35133254202083,
    "median_metadata_seconds": 0.13483354198979214,
    "peak_process_bytes": 7750785096,
    "loads": [
      34782,
      34782,
      34782
    ],
    "hits": [
      33188,
      33188,
      33188
    ]
  },
  "contiguous": {
    "median_load_seconds": 77.1266143329849,
    "median_metadata_seconds": 0.13465320799150504,
    "peak_process_bytes": 7782275240,
    "loads": [
      34782,
      34782,
      34782
    ],
    "hits": [
      33188,
      33188,
      33188
    ]
  }
}
````

### vq-contiguous-build-v1/candidate/build-identity.json

Original bytes: 31831. SHA-256: `ca75d766da67c3f6636bafc7989ff541c56e60243d2a2270ecc4df01604c21e3`.

Normalized bytes: 31831. SHA-256: `ca75d766da67c3f6636bafc7989ff541c56e60243d2a2270ecc4df01604c21e3`.

````text
{
  "source": {
    "Licenses/VQLab-Apache-2.0.txt": "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30",
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
    "Sources/Slotstream/Checkpoint.swift": "361b54ab482ab1b08debf846148d16fb811ee3550cb8ca1ae7526dc9b825e04b",
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
    "Sources/Slotstream/Layers.swift": "a1e16af9d664959605f2e135f08c6a8c9c8188cbe08044317e0d5ca023d51031",
    "Sources/Slotstream/MTP.swift": "973fded18e26361262bb635a3e9dbfa1b8e3f8281dfda8682904638096c8fca2",
    "Sources/Slotstream/MTPExpertStream.swift": "391b13fed457ba61a7cb4e107472a699ba87adc9a57cfd14580faa2dfbe50fd7",
    "Sources/Slotstream/Machine.swift": "34bffbaad9bd1a80f8d8aacc6b1abbbfa2d616690546a2a709363c4fb44033f6",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "1048ad7bcd1c9f93f5316465ed38d7bd93046fe4bfbd0fc138d972e646ee12ab",
    "Sources/Slotstream/NgramHash.swift": "62427b29d24b3638799197cbc45cf46b708e67bdc93b0bc30677a67d6bea8f6e",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "361e9668f5e18558aae83045dccdad7a6db6a14a1fa269e22761c6ec4b41f791",
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
    "Sources/Slotstream/VQArithmetic.swift": "082e36a7c98a0b5ac7bf88a416f62c28622f73726daebc0fdb3097026530385d",
    "Sources/Slotstream/VQBankAdmission.swift": "9d075656ac572e5e721e8a22e5f898d4f766af844362bd590114138cf155c592",
    "Sources/Slotstream/VQCheckpoint.swift": "932755373957740dd6209140206504d7d307c5eb65f29f2ee33715acae552cae",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQDenseOverlay.swift": "0102f31346cb84048b551265696cd4bcf4dd7f2a73c60be6840d654f9c4a2978",
    "Sources/Slotstream/VQExpert.swift": "b62435a1dec9cde5dd294db83909ea2b559554fed284f028df50cd0c92d682cb",
    "Sources/Slotstream/VQExpertKernels.swift": "3d0a9c22935d8984583ea59cf94a923f31ac03f8944ae570abb0b6b9749ded86",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "4425a383cfce125065b3ba829272e640837596de3c0bc2e7f6940866c9de55e8",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPackedExperts.swift": "0952098135ade973559d16d131267eb27dd081f70814aa1b36b6e25992214e37",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "3688d7bdaf9730e0cfd13635ac550706539585c91edaae9a13336e6e63db2616",
    "Sources/Slotstream/VQRecordBank.swift": "61d399967fa738ff864c544972adc0c57e07de60516a0afa49091adc2c231ce9",
    "Sources/Slotstream/VQRecordCache.swift": "c455334e4817587d1070dc13a6bc9172404db6d28eae5e205a2a4493356b44b8",
    "Sources/Slotstream/VQRecordReadBatch.swift": "6fdd78eaccd27b125d690782b7920a00226e60917f4dcfa05ada19e4bc57fc4e",
    "Sources/Slotstream/VQRecordReadPlan.swift": "588c8e0df5e917421252a2adb7352b1fb7f1fdf367b7e98247d8a8d497371ecb",
    "Sources/Slotstream/VQResidentText.swift": "4ac08a39de539afef273d7925779a9ce175319d21bf6c44b3205ef20393c9592",
    "Sources/Slotstream/VQRotaryTable.swift": "effaca0017e9bf7047f181e4e63de212aa64e6e3531278902b7d6353bcd619c1",
    "Sources/Slotstream/VQRouteStream.swift": "b4bf62f52ffe7cc3a8a6daece599f2fb077b65da2e5911f5f273f8d414e487ab",
    "Sources/Slotstream/VQTensorFile.swift": "34f45b06649d2c1ca11df11d887f7b48b51ae828cd03a074c9ed69e933fae52f",
    "Sources/Slotstream/VQTrunkProbe.swift": "43f7ec7848b35b30b8164bfcad44469dc79c249a318a4b36d33699584bac614f",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "1e0edf00c535c1aa605b996f83bd4f3f39d14a628f0f8a2d21667f069d823175",
    "Sources/Slotstream/VerifyPassSelfCheck.swift": "4355a74e73b967e6331dc2d780aa506ccccc6655df253a593cd24a3276325ded",
    "Sources/Slotstream/Version.swift": "d68b6b9f343402041c33452b885eebce140773cc26379b4adaae996640427b40",
    "Sources/Slotstream/Vision.swift": "639b5c4bbe05654db411d587f31e7962d3db857aa4be38a2b54f982199d51eb5",
    "Sources/Slotstream/VisionAttention.swift": "e8564b8cd946a6b049b3702a91f4441f18a7c3c51f19fae7f31c3cfa92522d25",
    "Sources/Slotstream/VisionPrompt.swift": "561ecd55588533a21571eea4deaa820b7e906b9d228ee002d6bfa9918dfd45a9",
    "Sources/Slotstream/WeightDownload.swift": "869b1ff398417f5aeebd57cb938feaf6829196f67a4ef1d254bb7bf138675673",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "01fb2c61390e6b7585eb80a34bf53a8c460fb6258908d57a3c1ed1fa77ec3ce8",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+MixedDense.swift": "49be3469ae5e4ebdab68d313e338bdf094006530727cb030f56caef0dc3edf41",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "3ddc642d68968ec4b3338ca9c2798e7e102dadbd18978382ddf402eeefd5a2d6",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationBench.swift": "7037fa0693746e35b91d146180e74883ccdbfabcbe54df8e970948c177f54ad1",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationFixtures.swift": "54a402b5a76d4abf8901c25e7428124d84eeee488acf4d9a65335d7858da733f",
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationLogits.swift": "a4dd86379bb4053fb1b8cee917a0cd88b3942de7805c1cf528a8d6924b84b915",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "defd0b98fc8730c9c146000036bf9436c06c5480d356a4f8ce9722091b1e1408",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQBank.swift": "01911150249e70d8dddb155884f105b7bcf8fa4902c97b3f7bc14064900e1f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "92b4ccad53dae57a23db4fb996db7e7a6e08b395c3c3102ebaeebe8e7c17f059",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "1d8139be68d72fbd6eacdbb22de07421abece787fe75e63b2e6623dbc11b66ba",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "0669a24eee258eee4c9dc00fbc88350a62d8654ee5ff89093614a2f96ad79e31",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "11da19085bd0f874b4741a542a298f286bf51091b9170fb8a2cabd4b7e399d4f",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "00b1b87ed24324e89bfee5ad88e3f8f3273ffe8f6e6b3c2e69576ffed65173fe",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQTrunk.swift": "6cd5fbd5d13d1c1f5a59545d1616abd67073bcac096b77da8d03d9a6c9f1d10b",
    "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "7779c1339db28cce006d300d6bdd41e3e9a27c55314153aa12659c3e11d575b3",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamDiagnostics/VQReferenceExecution.swift": "f0675a955662708dc0e0618169baf112f9a6cf9db82a6cf20d41b8bbf613d35e",
    "Sources/SlotstreamTestKit/AnthropicChecks.swift": "a15f7854d8f2da41184d30fac17f94f1e6e1cb68fd4236eb3c63f60e12714648",
    "Sources/SlotstreamTestKit/AnthropicTurnChecks.swift": "4d585e3ddb8692c1668d065a99c6ff1a56109f6da33328600f646bdc16f43aa5",
    "Sources/SlotstreamTestKit/Catalogue.swift": "08d6e6caedbcba413a576bf3ae01cc3447ca3cd4f701a11bca77b7692e6db714",
    "Sources/SlotstreamTestKit/CodexFixture.swift": "23839d1d776252c1c5cec6a3acaf6c08c1e89bc7def714f7b5f3180fae57aac0",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "a9e798d056582f4d97554b9131b3f8c7220a37a314312bb3c0e590883c7c8ad4",
    "Sources/SlotstreamTestKit/LaunchChecks.swift": "8fd6f5920b219d68f0ea69295810a0a6b34effdee69ac855b04212399379e54d",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "cb813af4c908567161db660aa8c6b78710be6a2b80a97a6e6d90e995ecd8806f",
    "Sources/SlotstreamTestKit/PersistentPrefixChecks.swift": "2a5cc8ffaf4befb90a732f350f84c34f162ad7ca67b0fb50eae3060fdeb0b0b3",
    "Sources/SlotstreamTestKit/PersistentPrefixIOChecks.swift": "c16d39aaf50f66ffa0f4f5fef02937dd141d5ba2ad7f42bcc9f387416d503f2c",
    "Sources/SlotstreamTestKit/PersistentPrefixMetadataChecks.swift": "65b5a45b3954c98517b777039373030f309e0271a6343037c6a452b4e03a82e8",
    "Sources/SlotstreamTestKit/PersistentPrefixRemovalChecks.swift": "a910392fe22933480cba14e3c604933066ba9178b670db4442e8c53b1c79a459",
    "Sources/SlotstreamTestKit/ResponsesChecks.swift": "6f692f86a68f6bbd1f62b6bdc544fdebaba1196e902b58a59313755af68be130",
    "Sources/SlotstreamTestKit/T0Checks.swift": "25bcf4ef6daeb29a31ebfacd2217bf12afb7788672f72c21d13ae7ac41aded97",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "d692da0260c0f0afbec0494cf60b8470ad8b5354f2419f33c64c12afca9a10d6",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "0f932f8bd1837ed149fccf89c33336ffc82480e25c93935817aca5e9af19fa8e",
  "binary_sha256": "0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
