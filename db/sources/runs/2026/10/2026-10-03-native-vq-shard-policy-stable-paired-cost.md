---
type: run
created: 2026-10-03T14:13:22.973772+00:00
updated: 2026-10-03T14:13:22.973772+00:00
summary: Stable admitted paired VQ shard-policy comparison retains buffered reads
binary: dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Stable admitted paired VQ shard-policy comparison retains buffered reads
tool: bounded VQ research diagnostics
---

This is a separately frozen campaign after the original failed admission, which remains preserved in its own source. Each of two validations and six timings first passes a sampled thirty-second interval with nominal native thermal state, low-power mode off, and at least thirteen GB reported by both native and external VM observers. Each wait is bounded to ten minutes and the campaign to four hours. No native guard, memory limit, timing exclusion or exact-reference check is relaxed. There are no retries or substituted cells.

The observer is compiled from the exact ProcessMemory source in the timed model binary. All eight processes complete; both independent full-vocabulary validations pass; all six timing cells are eligible and produce the same 128-token sequence. Buffered versus uncached medians are 5.808090834876722 versus 5.309354301127858 committed decode tokens/s, 2.984464291977929 versus 2.852987291989848 seconds to first token, and 24.927240332996007 versus 26.76245429200935 seconds per request. Median paired uncached/control ratios are 0.9161417563907788 for decode, 0.9523939966858103 for TTFT and 1.0772851791310383 for request duration.

Uncached hints reduce TTFT on this fixed profile but slow committed decode and total request time. Keep buffered reads as the default. This does not reject uncached I/O for every layout or Mac, qualify a candidate pack, or meet the twenty-token target. It also does not label file-cache state as cold. A separate lossless contiguous-record hypothesis remains prospective.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### capture-vq-uncached-stable-v2.py

Original bytes: 3189. SHA-256: `ebf5db0c735761ec3689dd85031e879da2e07dd012b28e97e7ad0b8517ef2d91`.

Normalized bytes: 3189. SHA-256: `ebf5db0c735761ec3689dd85031e879da2e07dd012b28e97e7ad0b8517ef2d91`.

````text
from pathlib import Path
import json,runpy,shutil,subprocess
r=Path('.build/quantization-research');h=runpy.run_path(str(r/'capture-vq-kernel-cache-v1.py'));a='vq-uncached-expert-cost-v2';d=json.loads((r/a/'run.json').read_text());assert d['complete'] and d['all_observed_timings_eligible'] and len(d['runs'])==8
files=['capture-vq-uncached-stable-v2.py','vq-uncached-stable-hypothesis-v2.json',a+'.log',a+'/run.json',a+'/buffered-profile.json',a+'/uncached-profile.json','vq-pilot-admission-observer-v1/build.json','vq-pilot-admission-observer-v1/observer.swift','vq-uncached-static-entry-v2.log','vq-uncached-unit-v1.log']
for name in ['vq_uncached_expert_pilot.py','vq_uncached_expert_test.py','vq_pilot_admission.py','vq_pilot_admission_test.py']:
 target='stable-admission-'+name;shutil.copy2(Path('Tools')/name,r/target);files.append(target)
checks=subprocess.run(['.venv/bin/python','Tools/vq_pilot_admission_test.py'],capture_output=True,text=True,check=True)
(r/'vq-pilot-admission-unit-v1.log').write_text(checks.stdout+checks.stderr);files+=['vq-pilot-admission-unit-v1.log']
for row in d['runs']:
 name=row['name'];files += [a+'/'+name+'-admission.json',a+'/'+name+'/receipt.json']+h['supervision'](a+'/'+name+'-supervision')
b=json.loads((r/'frozen-uncached-expert-v1/build-identity.json').read_text());o=json.loads((r/'vq-pilot-admission-observer-v1/build.json').read_text());assert o['engine_source_sha256']==b['source']['Sources/Slotstream/ProcessMemory.swift']
h['capture']('native-vq-shard-policy-stable-paired-cost','Stable admitted paired VQ shard-policy comparison retains buffered reads', '''This is a separately frozen campaign after the original failed admission, which remains preserved in its own source. Each of two validations and six timings first passes a sampled thirty-second interval with nominal native thermal state, low-power mode off, and at least thirteen GB reported by both native and external VM observers. Each wait is bounded to ten minutes and the campaign to four hours. No native guard, memory limit, timing exclusion or exact-reference check is relaxed. There are no retries or substituted cells.

The observer is compiled from the exact ProcessMemory source in the timed model binary. All eight processes complete; both independent full-vocabulary validations pass; all six timing cells are eligible and produce the same 128-token sequence. Buffered versus uncached medians are 5.808090834876722 versus 5.309354301127858 committed decode tokens/s, 2.984464291977929 versus 2.852987291989848 seconds to first token, and 24.927240332996007 versus 26.76245429200935 seconds per request. Median paired uncached/control ratios are 0.9161417563907788 for decode, 0.9523939966858103 for TTFT and 1.0772851791310383 for request duration.

Uncached hints reduce TTFT on this fixed profile but slow committed decode and total request time. Keep buffered reads as the default. This does not reject uncached I/O for every layout or Mac, qualify a candidate pack, or meet the twenty-token target. It also does not label file-cache state as cold. A separate lossless contiguous-record hypothesis remains prospective.''',files,'frozen-uncached-expert-v1')
````

### vq-uncached-stable-hypothesis-v2.json

Original bytes: 1213. SHA-256: `f858071535d5590c37b216a7cd8fe049c4f49d44438601196b95ff3e0845330e`.

Normalized bytes: 1213. SHA-256: `f858071535d5590c37b216a7cd8fe049c4f49d44438601196b95ff3e0845330e`.

````text
{
  "schema": 1,
  "status": "prospective revised idle admission before any new timing data",
  "predecessor": "vq-uncached-expert-cost-v1",
  "reason": "Both original validations passed but were thermally ineligible; first measurement failed native initial admission before model allocation. No complete timing cell exists. Preserve the entire original attempt.",
  "change": "Before each validation or measurement, require native ProcessMemory and external VM snapshots at or above 13 GB, native nominal thermal state, and low-power mode off for a sampled 30-second interval. Poll every five seconds; any bad observation resets stability. Bound each idle wait to 600 seconds and stop the campaign on failure. Existing native memory guards and timing exclusions remain unchanged.",
  "maximum_additional_model_runs": 8,
  "maximum_campaign_seconds": 14400,
  "maximum_process_bytes": 10000000000,
  "minimum_headroom_bytes": 3000000000,
  "new_payload_bytes": 0,
  "new_raw_logit_bytes": 0,
  "paid_compute": false,
  "retry_policy": "One newly frozen campaign. No retry of a failed or ineligible cell, no replacing observations, no winner unless all six paired timings qualify and generated sequences match."
}
````

### vq-uncached-expert-cost-v2.log

Original bytes: 4205. SHA-256: `60f887d732701d89fe87b9ff753c127f6d03715547988869c48eb1de44dc1d48`.

Normalized bytes: 4205. SHA-256: `60f887d732701d89fe87b9ff753c127f6d03715547988869c48eb1de44dc1d48`.

````text
{"name": "validation-buffered", "arm": "buffered", "measurement": false, "receipt_sha256": "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889", "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63", "committed_tokens": 16, "committed_decode_tokens_per_second": 5.603676783331077, "ttft_seconds": 2.9365755830076523, "request_seconds": 5.613408666016767, "peak_process_bytes": 7786682488, "observed_timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens"], "stop": "length"}
{"name": "validation-uncached", "arm": "uncached", "measurement": false, "receipt_sha256": "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612", "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63", "committed_tokens": 16, "committed_decode_tokens_per_second": 5.2399347961005756, "ttft_seconds": 2.809241542010568, "request_seconds": 5.671891999983927, "peak_process_bytes": 7783471272, "observed_timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens"], "stop": "length"}
{"name": "round-1-buffered", "arm": "buffered", "measurement": true, "receipt_sha256": "d1a1c3a1bdca37b1532f417b9b5b227094b3dba2ba51141d395697159bc71b5d", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.808090834876722, "ttft_seconds": 3.0611714999831747, "request_seconds": 24.927240332996007, "peak_process_bytes": 7740872752, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-1-uncached", "arm": "uncached", "measurement": true, "receipt_sha256": "1d72c4e391ca08b85ad10edf3d5773324461e44ef6f08c1aaf9ce32e8aa1b72b", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.293940597898864, "ttft_seconds": 2.864332500001183, "request_seconds": 26.85404079197906, "peak_process_bytes": 7723374616, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-2-uncached", "arm": "uncached", "measurement": true, "receipt_sha256": "779c395f9ef96ebe98bbec9e9763a32f69eccc0007030d1187c54ee0a3b0c26f", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.309354301127858, "ttft_seconds": 2.8423858750029467, "request_seconds": 26.76245429200935, "peak_process_bytes": 7722309656, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-2-buffered", "arm": "buffered", "measurement": true, "receipt_sha256": "6aa972114c7e5b2e7cc1aae04b84d7d96ad3c00109b0915e12ae73ce8f692b31", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.776144058850659, "ttft_seconds": 2.984464291977929, "request_seconds": 24.97147162500187, "peak_process_bytes": 7731222600, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-3-buffered", "arm": "buffered", "measurement": true, "receipt_sha256": "9793e312929d7fea64b03ba5a52d3812bf73e0f2fe43ebafd33ac5eb2925dcd9", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.814790398133884, "ttft_seconds": 2.9371932079957332, "request_seconds": 24.778069541003788, "peak_process_bytes": 7731943448, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
{"name": "round-3-uncached", "arm": "uncached", "measurement": true, "receipt_sha256": "857ba841907db8582a2551066a9e00faa4f620fc250cd9166b125558d1f1b335", "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f", "committed_tokens": 128, "committed_decode_tokens_per_second": 5.327172288390613, "ttft_seconds": 2.852987291989848, "request_seconds": 26.69304708400159, "peak_process_bytes": 7725750272, "observed_timing_eligible": true, "timing_exclusions": [], "stop": "length"}
````

### vq-uncached-expert-cost-v2/run.json

Original bytes: 61995. SHA-256: `026ab90e375c7404c252c4dc02d1821f5cf90f51b40776edf6a9dff09c8c8cc6`.

Normalized bytes: 61806. SHA-256: `764aa2bdf8ba78c6f4a1e525eb85020126d297398f25bca342567929338d9e11`.

````text
{
  "schema": 1,
  "scope": "Same composite and fixed reinvested cache; compare buffered versus checked uncached random shard reads with exact complete generated sequences",
  "qualification": "unproven",
  "complete": true,
  "started_at": "2026-10-03T13:57:42.188128+00:00",
  "producer": {
    "binary_sha256": "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "build": {
    "binary": "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
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
        "Sources/Slotstream/VQCheckpoint.swift": "4eb5fe513cf78f78bde2e7b8de9a0a28b4356af5f3e18b5a4fce70975ff44886",
        "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
        "Sources/Slotstream/VQDenseOverlay.swift": "0102f31346cb84048b551265696cd4bcf4dd7f2a73c60be6840d654f9c4a2978",
        "Sources/Slotstream/VQExpert.swift": "b62435a1dec9cde5dd294db83909ea2b559554fed284f028df50cd0c92d682cb",
        "Sources/Slotstream/VQExpertKernels.swift": "3d0a9c22935d8984583ea59cf94a923f31ac03f8944ae570abb0b6b9749ded86",
        "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
        "Sources/Slotstream/VQModelProbe.swift": "4425a383cfce125065b3ba829272e640837596de3c0bc2e7f6940866c9de55e8",
        "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
        "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
        "Sources/Slotstream/VQRecord.swift": "3688d7bdaf9730e0cfd13635ac550706539585c91edaae9a13336e6e63db2616",
        "Sources/Slotstream/VQRecordBank.swift": "61d399967fa738ff864c544972adc0c57e07de60516a0afa49091adc2c231ce9",
        "Sources/Slotstream/VQRecordCache.swift": "2fe427a6a60f464100cf2ffc407bf869290ab9d0cc81b9ae38bde65b9dc52d5b",
        "Sources/Slotstream/VQRecordReadBatch.swift": "1eae4e09e69bf0a16cfb55721f004b36aa038c6745ec4f3b05e3a41b21f678fc",
        "Sources/Slotstream/VQRecordReadPlan.swift": "2cc1f093b52aaac1bf19fb75ba76ca347da08a026a8cadc673b2ccf3d2f5ff7e",
        "Sources/Slotstream/VQResidentText.swift": "4ac08a39de539afef273d7925779a9ce175319d21bf6c44b3205ef20393c9592",
        "Sources/Slotstream/VQRotaryTable.swift": "effaca0017e9bf7047f181e4e63de212aa64e6e3531278902b7d6353bcd619c1",
        "Sources/Slotstream/VQRouteStream.swift": "b4bf62f52ffe7cc3a8a6daece599f2fb077b65da2e5911f5f273f8d414e487ab",
        "Sources/Slotstream/VQTensorFile.swift": "7ef2321dd987d6a00278caf7e1db46dbb95f83c7a0748a3d61560aff4e7af4b4",
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
        "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "757a043ff42418a5f086d8da28f6a4341a0ac0a3eb8a8798f98a4e7c314e4bae",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "d8b13e8f392d9acb60ea5f025b030efae0172327e4661bb4aaf8b4b79d4ff6a6",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "dd76f433694eb5102341459c6a5c7840dc2993caa93782b03ef6dbbd0f354f45",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "676209813620c2aaf7992bf03bd1fa6f108a9898ebd0e9cb4ab863afbf7fedc1",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "56fa55727208beb6761655968a07b3eb2dcd8f86b87c432eb760cf594608c73f",
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
        "Sources/slotstream-cli/QuantizationCommands.swift": "e45368026379cfc92c7a0da4cf444ee15da3a18c5771e40d004e1e3c294ef998",
        "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
        "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
        "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
        "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
        "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
        "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
        "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
      },
      "source_archive_sha256": "09dba0de0a4748a5b9e1200be727980978954206ed9b53847b6e0a5bafd37f91",
      "binary_sha256": "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
      "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
    }
  },
  "source_archive_sha256": "09dba0de0a4748a5b9e1200be727980978954206ed9b53847b6e0a5bafd37f91",
  "bound_files": {
    "<HOME>/Projects/slotstream/Tools/vq_uncached_expert_pilot.py": "1089babf8aa6ece27268b154bbbf5e234a44ce8e742f173c0e41729a1c77c9fd",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json": "4cdae0e9c26b9a0dd07659cd9d71dd025ed110b49161c152df09d5a7f75ac28b",
    "<HOME>/Projects/slotstream/bench/quantization/dense-reinvestment-cost-v1.json": "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
    "<HOME>/Projects/slotstream/bench/quantization/uncached-expert-cost-v1.json": "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-v1/run.json": "3669077472ecea4fb8233d29ab3e1854b0f1da13690b2b16578b6b50be068ecf",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-v1/greedy/receipt.json": "d5f351a91a54abaaf40bfb9c675befd12ba904fea3f52a7c4bb0499f6b4de721",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-v1/greedy-supervision/identity.json": "552282fa99944602007a1dde3e529242e80937a8ca4804bfbfb450093a232764",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-v1/greedy-supervision/receipt.json": "821310cfb5193025f888f2788bc812ccb1d9a849a32e209e24165b6df24b2ecb",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-v1/sparse/receipt.json": "50bd347d41d539264252a73bdd4ae0a6f898575c2864120a399c0447c6ab038b",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-v1/sparse-supervision/identity.json": "dc37dd06f1e5880aee48f1b0a02867193c2b609ba15d203f8c245eb8ed5d42ae",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-v1/sparse-supervision/receipt.json": "092547434f71abd0d57d13e4e4e9a3254f402ae91deaa12005272e7d66030b68",
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
    "<HOME>/Projects/slotstream/Tools/vq_pilot_admission.py": "1f09e1808906bbfe7838c9b3907afb54c75456e5462b61f3325e97cfab16d894",
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
      "name": "validation-buffered",
      "arm": "buffered",
      "measurement": false,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7786682488,
        "samples": 1102,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 23753129984,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470926.\nPages active:                                 830494.\nPages inactive:                               783478.\nPages speculative:                             74380.\nPages throttled:                                   0.\nPages wired down:                             182647.\nPages purgeable:                                 101.\n\"Translation faults\":                     1929491549.\nPages copy-on-write:                        96423130.\nPages zero filled:                        3156690349.\nPages reactivated:                         172692550.\nPages purged:                               12556101.\nFile-backed pages:                            978749.\nAnonymous pages:                              709603.\nPages stored in compressor:                  1360577.\nPages occupied by compressor:                 741981.\nDecompressions:                             97494615.\nCompressions:                              110783613.\nPageins:                                  2147829116.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129253.\nPages tagged resident:                         88209.\nPages tagged compressed:                       41044.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                         1661.\nPages tag-storage non-tag pageable:            90641.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6120320.\nTagged compressions:                          715268.\nTagged decompressions:                        589682.\n"
        },
        "seconds": 64.40924562499276
      },
      "receipt_sha256": "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889",
      "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 5.603676783331077,
      "ttft_seconds": 2.9365755830076523,
      "request_seconds": 5.613408666016767,
      "peak_process_bytes": 7786682488,
      "observed_timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens"
      ],
      "stop": "length"
    },
    {
      "name": "validation-uncached",
      "arm": "uncached",
      "measurement": false,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7783471272,
        "samples": 1102,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 23276830720,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   429609.\nPages active:                                 877594.\nPages inactive:                               809659.\nPages speculative:                             53190.\nPages throttled:                                   0.\nPages wired down:                             212026.\nPages purgeable:                                3395.\n\"Translation faults\":                     1930361366.\nPages copy-on-write:                        96444851.\nPages zero filled:                        3157404069.\nPages reactivated:                         172732738.\nPages purged:                               12575921.\nFile-backed pages:                            987701.\nAnonymous pages:                              752734.\nPages stored in compressor:                  1288245.\nPages occupied by compressor:                 703186.\nDecompressions:                             97634674.\nCompressions:                              110901599.\nPageins:                                  2157465112.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130909.\nPages tagged resident:                         90415.\nPages tagged compressed:                       40494.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5982.\nPages tag-storage free:                          822.\nPages tag-storage non-tag pageable:            91492.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6027200.\nTagged compressions:                          715280.\nTagged decompressions:                        590183.\n"
        },
        "seconds": 64.79290883400245
      },
      "receipt_sha256": "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612",
      "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 5.2399347961005756,
      "ttft_seconds": 2.809241542010568,
      "request_seconds": 5.671891999983927,
      "peak_process_bytes": 7783471272,
      "observed_timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens"
      ],
      "stop": "length"
    },
    {
      "name": "round-1-buffered",
      "arm": "buffered",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7740872752,
        "samples": 1461,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 23750164480,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   442273.\nPages active:                                 863017.\nPages inactive:                               788563.\nPages speculative:                             82712.\nPages throttled:                                   0.\nPages wired down:                             205314.\nPages purgeable:                                 234.\n\"Translation faults\":                     1931688024.\nPages copy-on-write:                        96491421.\nPages zero filled:                        3158415667.\nPages reactivated:                         172777114.\nPages purged:                               12589836.\nFile-backed pages:                           1007088.\nAnonymous pages:                              727204.\nPages stored in compressor:                  1285790.\nPages occupied by compressor:                 702057.\nDecompressions:                             97953797.\nCompressions:                              111263939.\nPageins:                                  2167983803.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129020.\nPages tagged resident:                         88206.\nPages tagged compressed:                       40814.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                         1518.\nPages tag-storage non-tag pageable:            90827.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6075328.\nTagged compressions:                          716574.\nTagged decompressions:                        591110.\n"
        },
        "seconds": 85.08532520799781
      },
      "receipt_sha256": "d1a1c3a1bdca37b1532f417b9b5b227094b3dba2ba51141d395697159bc71b5d",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.808090834876722,
      "ttft_seconds": 3.0611714999831747,
      "request_seconds": 24.927240332996007,
      "peak_process_bytes": 7740872752,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-1-uncached",
      "arm": "uncached",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7723374616,
        "samples": 1467,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 23970775040,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470081.\nPages active:                                 884629.\nPages inactive:                               822268.\nPages speculative:                             61129.\nPages throttled:                                   0.\nPages wired down:                             170686.\nPages purgeable:                                6590.\n\"Translation faults\":                     1932518976.\nPages copy-on-write:                        96531111.\nPages zero filled:                        3159052081.\nPages reactivated:                         172817416.\nPages purged:                               12594414.\nFile-backed pages:                            986389.\nAnonymous pages:                              781637.\nPages stored in compressor:                  1242527.\nPages occupied by compressor:                 675694.\nDecompressions:                             98129324.\nCompressions:                              111434465.\nPageins:                                  2177539588.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129059.\nPages tagged resident:                         88420.\nPages tagged compressed:                       40639.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                         1118.\nPages tag-storage non-tag pageable:            91236.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6036672.\nTagged compressions:                          716612.\nTagged decompressions:                        591317.\n"
        },
        "seconds": 85.62563904200215
      },
      "receipt_sha256": "1d72c4e391ca08b85ad10edf3d5773324461e44ef6f08c1aaf9ce32e8aa1b72b",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.293940597898864,
      "ttft_seconds": 2.864332500001183,
      "request_seconds": 26.85404079197906,
      "peak_process_bytes": 7723374616,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-2-uncached",
      "arm": "uncached",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7722309656,
        "samples": 1458,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 22933045248,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   424453.\nPages active:                                 884681.\nPages inactive:                               848312.\nPages speculative:                             31045.\nPages throttled:                                   0.\nPages wired down:                             211808.\nPages purgeable:                                1509.\n\"Translation faults\":                     1933335159.\nPages copy-on-write:                        96571761.\nPages zero filled:                        3159764714.\nPages reactivated:                         172901573.\nPages purged:                               12602915.\nFile-backed pages:                            973760.\nAnonymous pages:                              790278.\nPages stored in compressor:                  1253648.\nPages occupied by compressor:                 683994.\nDecompressions:                             98289451.\nCompressions:                              111645377.\nPageins:                                  2187288017.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131894.\nPages tagged resident:                         90861.\nPages tagged compressed:                       41033.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5953.\nPages tag-storage free:                         1075.\nPages tag-storage non-tag pageable:            91268.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6081472.\nTagged compressions:                          717579.\nTagged decompressions:                        591887.\n"
        },
        "seconds": 85.30573395799729
      },
      "receipt_sha256": "779c395f9ef96ebe98bbec9e9763a32f69eccc0007030d1187c54ee0a3b0c26f",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.309354301127858,
      "ttft_seconds": 2.8423858750029467,
      "request_seconds": 26.76245429200935,
      "peak_process_bytes": 7722309656,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-2-buffered",
      "arm": "buffered",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7731222600,
        "samples": 1434,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24177278976,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   468891.\nPages active:                                 870085.\nPages inactive:                               795484.\nPages speculative:                             83520.\nPages throttled:                                   0.\nPages wired down:                             179866.\nPages purgeable:                                 102.\n\"Translation faults\":                     1934144311.\nPages copy-on-write:                        96601978.\nPages zero filled:                        3160363946.\nPages reactivated:                         173028389.\nPages purged:                               12609121.\nFile-backed pages:                           1006671.\nAnonymous pages:                              742418.\nPages stored in compressor:                  1262834.\nPages occupied by compressor:                 686070.\nDecompressions:                             98630003.\nCompressions:                              112038748.\nPageins:                                  2197729622.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128302.\nPages tagged resident:                         86011.\nPages tagged compressed:                       42291.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1774.\nPages tag-storage non-tag pageable:            90602.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6312128.\nTagged compressions:                          720628.\nTagged decompressions:                        593676.\n"
        },
        "seconds": 83.47636595799122
      },
      "receipt_sha256": "6aa972114c7e5b2e7cc1aae04b84d7d96ad3c00109b0915e12ae73ce8f692b31",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.776144058850659,
      "ttft_seconds": 2.984464291977929,
      "request_seconds": 24.97147162500187,
      "peak_process_bytes": 7731222600,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-3-buffered",
      "arm": "buffered",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7731943448,
        "samples": 1436,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24715001856,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469941.\nPages active:                                 864583.\nPages inactive:                               798110.\nPages speculative:                             84891.\nPages throttled:                                   0.\nPages wired down:                             170255.\nPages purgeable:                                5055.\n\"Translation faults\":                     1934904808.\nPages copy-on-write:                        96628571.\nPages zero filled:                        3160986545.\nPages reactivated:                         173134097.\nPages purged:                               12616750.\nFile-backed pages:                           1033488.\nAnonymous pages:                              714096.\nPages stored in compressor:                  1298106.\nPages occupied by compressor:                 696585.\nDecompressions:                             98881103.\nCompressions:                              112351020.\nPageins:                                  2207888700.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128214.\nPages tagged resident:                         85369.\nPages tagged compressed:                       42845.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1245.\nPages tag-storage non-tag pageable:            91131.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6431168.\nTagged compressions:                          722272.\nTagged decompressions:                        594764.\n"
        },
        "seconds": 83.71577370900195
      },
      "receipt_sha256": "9793e312929d7fea64b03ba5a52d3812bf73e0f2fe43ebafd33ac5eb2925dcd9",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.814790398133884,
      "ttft_seconds": 2.9371932079957332,
      "request_seconds": 24.778069541003788,
      "peak_process_bytes": 7731943448,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    },
    {
      "name": "round-3-uncached",
      "arm": "uncached",
      "measurement": true,
      "supervision": {
        "exit_code": 0,
        "failure": null,
        "sampled_peak_bytes": 7725750272,
        "samples": 1464,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 24126865408,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470814.\nPages active:                                 881035.\nPages inactive:                               820179.\nPages speculative:                             59601.\nPages throttled:                                   0.\nPages wired down:                             181434.\nPages purgeable:                                1253.\n\"Translation faults\":                     1935727207.\nPages copy-on-write:                        96664437.\nPages zero filled:                        3161626444.\nPages reactivated:                         173191507.\nPages purged:                               12621231.\nFile-backed pages:                           1000520.\nAnonymous pages:                              760295.\nPages stored in compressor:                  1257017.\nPages occupied by compressor:                 671532.\nDecompressions:                             99061515.\nCompressions:                              112520830.\nPageins:                                  2217422088.\nPageouts:                                     480268.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130604.\nPages tagged resident:                         87746.\nPages tagged compressed:                       42858.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1010.\nPages tag-storage non-tag pageable:            91366.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6431168.\nTagged compressions:                          723735.\nTagged decompressions:                        596203.\n"
        },
        "seconds": 85.59439129100065
      },
      "receipt_sha256": "857ba841907db8582a2551066a9e00faa4f620fc250cd9166b125558d1f1b335",
      "generated_sha256": "042b5f992a0bd99755d7f4cb0cff322ad8dd0adbbaeef0005fcd31c9ebd0899f",
      "committed_tokens": 128,
      "committed_decode_tokens_per_second": 5.327172288390613,
      "ttft_seconds": 2.852987291989848,
      "request_seconds": 26.69304708400159,
      "peak_process_bytes": 7725750272,
      "observed_timing_eligible": true,
      "timing_exclusions": [],
      "stop": "length"
    }
  ],
  "all_observed_timings_eligible": true,
  "medians": {
    "buffered": {
      "committed_decode_tokens_per_second": 5.808090834876722,
      "ttft_seconds": 2.984464291977929,
      "request_seconds": 24.927240332996007
    },
    "uncached": {
      "committed_decode_tokens_per_second": 5.309354301127858,
      "ttft_seconds": 2.852987291989848,
      "request_seconds": 26.76245429200935
    }
  },
  "paired_ratios": {
    "committed_decode_tokens_per_second": [
      0.9114768946293913,
      0.9191866142937433,
      0.9161417563907788
    ],
    "ttft_seconds": [
      0.9356981469404527,
      0.9523939966858103,
      0.9713311620847219
    ],
    "request_seconds": [
      1.077296982467512,
      1.0717211501950217,
      1.0772851791310383
    ]
  },
  "median_paired_ratios": {
    "committed_decode_tokens_per_second": 0.9161417563907788,
    "ttft_seconds": 0.9523939966858103,
    "request_seconds": 1.0772851791310383
  },
  "finished_at": "2026-10-03T14:12:24.654193+00:00"
}
````

### vq-uncached-expert-cost-v2/buffered-profile.json

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

### vq-uncached-expert-cost-v2/uncached-profile.json

Original bytes: 9531. SHA-256: `f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285`.

Normalized bytes: 9531. SHA-256: `f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285`.

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
  "profile": "vq32-uncached-expert-shards-cost-pilot-v1",
  "scope": "Same composite and fixed reinvested cache; compare buffered versus checked uncached random shard reads with exact complete generated sequences",
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
    "uncached_expert_reads": true
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
      "buffered",
      "uncached"
    ],
    [
      "uncached",
      "buffered"
    ],
    [
      "buffered",
      "uncached"
    ]
  ],
  "protocol": {
    "validation": "Separate process verifies all sixteen complete Float32 vocabulary arrays and autoregressive samples against the pinned independent greedy reference with state observation disabled. Required before measurement for this exact binary, metallib, profile and inventory.",
    "cache_state": "All 138 main payloads are fully authenticated through owned descriptors before the request. New model state and empty expert banks per process; resident text loaded before request. OS page cache is uncontrolled after these reads and is not described as cold SSD. No warmup generation. The uncached arm applies checked F_NOCACHE=1 and F_RDAHEAD=0 after full authentication to the nine entire descriptors containing routed experts, including their dense members. Existing cached pages are not purged; this is an OS hint comparison, not a cold-storage study.",
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
    "purpose": "Measure shard read policy at unchanged 1536/288 bank geometry after greedy and sparse parity. No product default change."
  },
  "control_profile_sha256": "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8"
}
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

### vq-uncached-static-entry-v2.log

Original bytes: 130. SHA-256: `5df84b3f882ea97573b20f9cd9d6175d878fdae40aff0ceca368ffbb94c4ef34`.

Normalized bytes: 130. SHA-256: `5df84b3f882ea97573b20f9cd9d6175d878fdae40aff0ceca368ffbb94c4ef34`.

````text
..............................
----------------------------------------------------------------------
Ran 30 tests in 24.636s

OK
````

### vq-uncached-unit-v1.log

Original bytes: 100. SHA-256: `fe008aab760eb03ccac7578e2b84665b1b50b0d7f855b17a0c7a8d039435b658`.

Normalized bytes: 100. SHA-256: `fe008aab760eb03ccac7578e2b84665b1b50b0d7f855b17a0c7a8d039435b658`.

````text
..
----------------------------------------------------------------------
Ran 2 tests in 0.001s

OK
````

### stable-admission-vq_uncached_expert_pilot.py

Original bytes: 12867. SHA-256: `1089babf8aa6ece27268b154bbbf5e234a44ce8e742f173c0e41729a1c77c9fd`.

Normalized bytes: 12867. SHA-256: `1089babf8aa6ece27268b154bbbf5e234a44ce8e742f173c0e41729a1c77c9fd`.

````text
#!/usr/bin/env python3
"""Same-composite expert shard read policy at a fixed ten-GB process bound.

Require separately passed greedy/sparse geometry gates and exact sequences
across both arms. This read-policy experiment never promotes a product pack.
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
    'buffered': '87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8',
    'uncached': 'f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285',
}
ARMS = ('buffered', 'uncached')


def validate_receipt(receipt, arm, profile, producer, *, measurement):
    if arm not in ARMS:
        raise ValueError('unknown shard-read-policy arm')
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
            or receipt.get('expert_file_read_policy') != ('uncached-random-shards-v1' if arm == 'uncached' else 'buffered-v1')
            or receipt.get('uncached_expert_files') != (9 if arm == 'uncached' else 0)
            or cache.get('maximum_executed_slot') != 512 * factor - 1
            or cache.get('minimum_class_maximum_executed_slot') != 96 * factor - 1
            or cache.get('pinned_records') != 0
            or type(receipt.get('peak_process_bytes')) is not int
            or not 0 < receipt['peak_process_bytes'] <= 10_000_000_000):
        raise ValueError('shard-read-policy receipt changed its artifact, producer, physical range or envelope')
    generated = receipt.get('generated')
    if (not isinstance(generated, list) or generated[:16] != reference['generated']
            or any(type(t) is not int or not 0 <= t < 248_320 for t in generated)):
        raise ValueError('shard-read-policy receipt changed the independent generated prefix')
    if not measurement and (len(generated) != 16 or receipt.get('observed_logit_hashes') != [x['sha256'] for x in reference['logits']]):
        raise ValueError('shard-read-policy validation omitted full-logit references')
    if measurement and not 16 <= len(generated) <= 128:
        raise ValueError('shard-read-policy measurement changed its bounded sequence length')


def validate_gate(receipt, sparse):
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
            or receipt.get('expert_file_read_policy') != 'uncached-random-shards-v1'
            or receipt.get('uncached_expert_files') != 9
            or len(receipt.get('observed', {})) != (984 if sparse else 2560)):
        raise ValueError('missing independent shard-read-policy parity/memory gate')
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
    profile_paths = {'buffered': root / 'bench/quantization/dense-reinvestment-cost-v1.json',
                     'uncached': root / 'bench/quantization/uncached-expert-cost-v1.json'}
    if any(digest(path) != PROFILE_SHAS[arm] for arm, path in profile_paths.items()):
        raise ValueError('shard-read-policy protocol differs from frozen identity')
    profiles = {arm: json.loads(path.read_text()) for arm, path in profile_paths.items()}
    profile = profiles['uncached']
    gate_run = options.gates.resolve() / 'run.json'
    gate_record = json.loads(gate_run.read_text())
    if (gate_record.get('complete') is not True
            or gate_record.get('producer_sha256') != producer['binary_sha256']):
        raise ValueError('parity campaign did not complete on the timed producer')
    gate_paths = [gate_run]
    for name in ('greedy', 'sparse'):
        path = options.gates.resolve() / name / 'receipt.json'
        supervisor = options.gates.resolve() / (name + '-supervision') / 'identity.json'
        validate_gate(json.loads(path.read_text()), name == 'sparse')
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
    observer = options.admission_observer.resolve()
    observer_files = [observer / name for name in ('observer', 'observer.swift', 'build.json')]
    inputs = [Path(__file__).resolve(), manifest] + list(profile_paths.values()) + gate_paths + observer_files
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
                raise ValueError('same composite changed its complete sequence across read-policy arms')
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
    for name in ('binary', 'research-root', 'baseline', 'manifest', 'gates', 'out', 'admission-observer'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args())
````

### stable-admission-vq_uncached_expert_test.py

Original bytes: 3942. SHA-256: `f6f660f66cab2c0e6fcbae15df76418802df8a3bf84092ee7ac6794cea9780d9`.

Normalized bytes: 3942. SHA-256: `f6f660f66cab2c0e6fcbae15df76418802df8a3bf84092ee7ac6794cea9780d9`.

````text
"""Refuse evidence that swaps cache profiles, producer or numerical gates."""
import copy
import hashlib
import json
from pathlib import Path
import unittest
from vq_uncached_expert_pilot import ARMS, PROFILE_SHAS, IDENTITY_SHA, VQ_INVENTORY, validate_receipt, validate_gate

class ReadPolicyChecks(unittest.TestCase):
    def test_receipt_cannot_swap_cache_geometry_or_producer(self):
        root=Path(__file__).resolve().parent.parent
        producer={'binary_sha256':'binary','metallib_sha256':'metal'}
        for arm,file in [('buffered','dense-reinvestment-cost-v1.json'),('uncached','uncached-expert-cost-v1.json')]:
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
                     'expert_file_read_policy':'uncached-random-shards-v1' if arm=='uncached' else 'buffered-v1',
                     'uncached_expert_files':9 if arm=='uncached' else 0}
            validate_receipt(receipt,arm,profile,producer,measurement=False)
            for field,value in [('producer',{}),('profile_sha256','wrong'),('peak_process_bytes',10_000_000_001),('observed_logit_hashes',[]),('expert_file_read_policy','other'),('uncached_expert_files',8)]:
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
           'expert_file_read_policy':'uncached-random-shards-v1','uncached_expert_files':9,
           'observed':{str(i):'hash' for i in range(984)},
           'resident_record_cache':{'dense_savings_reinvested':1,'total_capacity':1824,
                                   'reserved_bank_bytes':3583180800,'pinned_records':0}}
        validate_gate(r,True)
        with self.assertRaises(ValueError):validate_gate(r,False)
        r['resident_record_cache'].update(maximum_executed_slot=1535,minimum_class_maximum_executed_slot=287)
        r['observed']={str(i):'hash' for i in range(2560)}
        validate_gate(r,False)
        r['report']['passed']=False
        with self.assertRaises(ValueError):validate_gate(r,False)

if __name__=='__main__':unittest.main()
````

### stable-admission-vq_pilot_admission.py

Original bytes: 5425. SHA-256: `1f09e1808906bbfe7838c9b3907afb54c75456e5462b61f3325e97cfab16d894`.

Normalized bytes: 5425. SHA-256: `1f09e1808906bbfe7838c9b3907afb54c75456e5462b61f3325e97cfab16d894`.

````text
"""Bounded idle admission for a new VQ timing campaign, never a retry loop.

Use the exact native ProcessMemory implementation in a small separate observer.
No model is loaded while waiting. Successful admission is only a precondition;
the native allocator and every in-request eligibility check remain authoritative.
"""
import hashlib
import json
from pathlib import Path
import subprocess
import time

from context_qualification import quiet_preflight
from prefill_bench import vm_snapshot

STABLE_SECONDS = 30
MAXIMUM_WAIT_SECONDS = 600
MINIMUM_BYTES = 13_000_000_000


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def build_observer(root, out):
    before = quiet_preflight(13)
    out.mkdir(exist_ok=False)
    original = root / 'Sources/Slotstream/ProcessMemory.swift'
    source = original.read_text()
    marker = '/// Loading two copies'
    if source.count(marker) != 1:
        raise ValueError('native ProcessMemory extraction boundary changed')
    text = source.split(marker)[0] + '''
let enc = JSONEncoder(); enc.outputFormatting = [.sortedKeys]
var output: [String: Any] = ["conditions": try JSONSerialization.jsonObject(with: enc.encode(ProcessMemory.operatingConditions()))]
output["vm"] = try ProcessMemory.vmActivity().map { try JSONSerialization.jsonObject(with: enc.encode($0)) }
print(String(decoding: try JSONSerialization.data(withJSONObject: output, options: [.sortedKeys]), as: UTF8.self))
'''
    swift = out / 'observer.swift'; binary = out / 'observer'
    swift.write_text(text)
    command = ['swiftc', '-O', str(swift), '-o', str(binary)]
    result = subprocess.run(command, capture_output=True, text=True, timeout=120)
    receipt = {'schema': 1, 'command': command, 'before': before,
               'engine_source_sha256': digest(original), 'observer_source_sha256': digest(swift),
               'returncode': result.returncode, 'stdout': result.stdout, 'stderr': result.stderr}
    if result.returncode == 0: receipt['observer_sha256'] = digest(binary)
    (out / 'build.json').write_text(json.dumps(receipt, indent=2) + '\n')
    if result.returncode: raise RuntimeError('native admission observer build failed')
    return binary


def eligible(sample):
    native = sample.get('native', {})
    conditions = native.get('conditions', {})
    vm = native.get('vm') or {}
    external = sample.get('external', {})
    values = (vm.get('reclaimableBytes'), external.get('reclaimable_bytes'))
    return (conditions.get('thermalState') == 'nominal'
            and conditions.get('lowPowerModeEnabled') is False
            and all(type(v) is int and v >= MINIMUM_BYTES for v in values))


def wait_until_stable(sample, *, now=time.monotonic, sleep=time.sleep, publish=lambda _: None,
                      maximum_wait=MAXIMUM_WAIT_SECONDS, stable_seconds=STABLE_SECONDS):
    if not 0 < stable_seconds <= maximum_wait <= MAXIMUM_WAIT_SECONDS:
        raise ValueError('invalid admission interval')
    start = now(); stable_since = None; snapshots = []
    while True:
        value = sample(); current = now(); good = eligible(value)
        if not good: stable_since = None
        elif stable_since is None: stable_since = current
        stable = 0 if stable_since is None else current - stable_since
        row = {'elapsed_seconds': current - start, 'stable_seconds': stable, 'eligible': good, **value}
        snapshots.append(row)
        report = {'schema': 1, 'passed': False, 'maximum_wait_seconds': maximum_wait,
                  'required_stable_seconds': stable_seconds, 'samples': snapshots}
        # Sampling or tool overhead counts toward the deadline. A final sample
        # after the deadline cannot confer admission.
        if current - start > maximum_wait:
            report['failure'] = 'admission deadline exceeded'; publish(report)
            raise TimeoutError(report['failure'])
        if good and stable >= stable_seconds:
            report['passed'] = True; publish(report); return report
        if current - start >= maximum_wait:
            report['failure'] = 'conditions never remained eligible for the required interval'; publish(report)
            raise TimeoutError(report['failure'])
        publish(report)
        sleep(min(5, maximum_wait - (current - start)))


def admit(directory, output, *, maximum_wait=MAXIMUM_WAIT_SECONDS):
    receipt = json.loads((directory / 'build.json').read_text())
    binary = directory / 'observer'
    if (receipt.get('returncode') != 0 or digest(binary) != receipt.get('observer_sha256')
            or digest(directory / 'observer.swift') != receipt.get('observer_source_sha256')):
        raise ValueError('admission observer differs from its source-bound producer')
    if output.exists(): raise ValueError('admission receipt must be new')
    def sample():
        observed = subprocess.run([str(binary)], capture_output=True, text=True, check=True, timeout=10)
        return {'native': json.loads(observed.stdout), 'external': vm_snapshot()}
    def publish(value):
        value['observer_sha256'] = receipt['observer_sha256']
        value['engine_source_sha256'] = receipt['engine_source_sha256']
        output.write_text(json.dumps(value, indent=2) + '\n')
    result = wait_until_stable(sample, maximum_wait=maximum_wait, publish=publish)
    # No model/compiler may have appeared while conditions were observed.
    quiet_preflight(13)
    return result
````

### stable-admission-vq_pilot_admission_test.py

Original bytes: 2464. SHA-256: `22055d673bed6ec59fdfd9112d41e719aafe91623160dfa385e433ab433d8e14`.

Normalized bytes: 2464. SHA-256: `22055d673bed6ec59fdfd9112d41e719aafe91623160dfa385e433ab433d8e14`.

````text
import copy
import unittest
from vq_pilot_admission import eligible, wait_until_stable

GOOD = {'native': {'conditions': {'thermalState': 'nominal', 'lowPowerModeEnabled': False},
                   'vm': {'reclaimableBytes': 13_000_000_000}},
        'external': {'reclaimable_bytes': 13_000_000_000}}

class AdmissionChecks(unittest.TestCase):
    def test_both_observers_and_power_policy_are_required(self):
        self.assertTrue(eligible(GOOD))
        bads=[]
        for path,value in [(('native','vm','reclaimableBytes'),12_999_999_999),
                           (('external','reclaimable_bytes'),12_999_999_999),
                           (('native','conditions','thermalState'),'fair'),
                           (('native','conditions','lowPowerModeEnabled'),True),
                           (('native','vm'),None),
                           (('external','reclaimable_bytes'),True)]:
            bad=copy.deepcopy(GOOD);target=bad
            for key in path[:-1]:target=target[key]
            target[path[-1]]=value;bads.append(bad)
        for bad in bads:self.assertFalse(eligible(bad))

    def test_one_bad_observation_resets_the_whole_interval(self):
        clock=[0];events=[];bad=copy.deepcopy(GOOD);bad['native']['conditions']['thermalState']='fair'
        def sample():return bad if clock[0]==10 else GOOD
        def sleep(n):clock[0]+=n
        result=wait_until_stable(sample,now=lambda:clock[0],sleep=sleep,publish=lambda r:events.append(r),stable_seconds=15,maximum_wait=40)
        self.assertTrue(result['passed']);self.assertEqual(clock[0],30)
        self.assertEqual(result['samples'][2]['stable_seconds'],0)

    def test_missing_conditions_times_out_without_admission(self):
        clock=[0];events=[]
        with self.assertRaises(TimeoutError):
            wait_until_stable(lambda:{},now=lambda:clock[0],sleep=lambda n:clock.__setitem__(0,clock[0]+n),publish=events.append,stable_seconds=10,maximum_wait=20)
        self.assertEqual(clock[0],20);self.assertFalse(events[-1]['passed'])

    def test_slow_observer_cannot_admit_after_deadline(self):
        clock=[0];events=[]
        def sample():clock[0]+=11;return GOOD
        with self.assertRaises(TimeoutError):
            wait_until_stable(sample,now=lambda:clock[0],sleep=lambda n:clock.__setitem__(0,clock[0]+n),publish=events.append,stable_seconds=1,maximum_wait=10)
        self.assertFalse(events[-1]['passed'])

if __name__=='__main__':unittest.main()
````

### vq-pilot-admission-unit-v1.log

Original bytes: 102. SHA-256: `e6ec182765cd965f2837d8eeaef5a64af48a104f245cd1a0b7281559194c57c1`.

Normalized bytes: 102. SHA-256: `e6ec182765cd965f2837d8eeaef5a64af48a104f245cd1a0b7281559194c57c1`.

````text
....
----------------------------------------------------------------------
Ran 4 tests in 0.000s

OK
````

### vq-uncached-expert-cost-v2/validation-buffered-admission.json

Original bytes: 17276. SHA-256: `242ee39c0a3074c98b6e8ed21442407201c1bbc649ad4fe1cb1ba159e29f09c9`.

Normalized bytes: 17276. SHA-256: `242ee39c0a3074c98b6e8ed21442407201c1bbc649ad4fe1cb1ba159e29f09c9`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.2552327089942992,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 21649440768,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21568749568,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    23329.\nPages active:                                1110274.\nPages inactive:                              1103224.\nPages speculative:                              5132.\nPages throttled:                                   0.\nPages wired down:                             182240.\nPages purgeable:                               16040.\n\"Translation faults\":                     1928685123.\nPages copy-on-write:                        96396160.\nPages zero filled:                        3155957332.\nPages reactivated:                         172445954.\nPages purged:                               12532337.\nFile-backed pages:                           1277083.\nAnonymous pages:                              941547.\nPages stored in compressor:                  1202456.\nPages occupied by compressor:                 661316.\nDecompressions:                             97236100.\nCompressions:                              110343132.\nPageins:                                  2137539989.\nPageouts:                                     472996.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 132270.\nPages tagged resident:                         92728.\nPages tagged compressed:                       39542.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6174.\nPages tag-storage free:                          260.\nPages tag-storage non-tag pageable:            91862.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5855936.\nTagged compressions:                          713269.\nTagged decompressions:                        589214.\n"
      }
    },
    {
      "elapsed_seconds": 5.287221917009447,
      "stable_seconds": 5.031989208015148,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 21672329216,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21584756736,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    28492.\nPages active:                                1108053.\nPages inactive:                              1100661.\nPages speculative:                              5283.\nPages throttled:                                   0.\nPages wired down:                             181689.\nPages purgeable:                               11703.\n\"Translation faults\":                     1928703500.\nPages copy-on-write:                        96397226.\nPages zero filled:                        3155966757.\nPages reactivated:                         172446088.\nPages purged:                               12532337.\nFile-backed pages:                           1277234.\nAnonymous pages:                              936763.\nPages stored in compressor:                  1202257.\nPages occupied by compressor:                 661190.\nDecompressions:                             97236296.\nCompressions:                              110343132.\nPageins:                                  2137540135.\nPageouts:                                     472996.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 132333.\nPages tagged resident:                         92792.\nPages tagged compressed:                       39541.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6174.\nPages tag-storage free:                          165.\nPages tag-storage non-tag pageable:            91957.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5855872.\nTagged compressions:                          713269.\nTagged decompressions:                        589215.\n"
      }
    },
    {
      "elapsed_seconds": 10.318965667014709,
      "stable_seconds": 10.06373295802041,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 21645721600,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21558886400,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    29026.\nPages active:                                1107652.\nPages inactive:                              1100150.\nPages speculative:                              5423.\nPages throttled:                                   0.\nPages wired down:                             182264.\nPages purgeable:                                9407.\n\"Translation faults\":                     1928713830.\nPages copy-on-write:                        96397936.\nPages zero filled:                        3155972033.\nPages reactivated:                         172446088.\nPages purged:                               12532593.\nFile-backed pages:                           1277417.\nAnonymous pages:                              935808.\nPages stored in compressor:                  1202017.\nPages occupied by compressor:                 661125.\nDecompressions:                             97236535.\nCompressions:                              110343132.\nPageins:                                  2137540211.\nPageouts:                                     472996.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 132352.\nPages tagged resident:                         92891.\nPages tagged compressed:                       39461.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6172.\nPages tag-storage free:                          171.\nPages tag-storage non-tag pageable:            91953.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5844160.\nTagged compressions:                          713269.\nTagged decompressions:                        589294.\n"
      }
    },
    {
      "elapsed_seconds": 15.350256125006126,
      "stable_seconds": 15.095023416011827,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 21667545088,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21526773760,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    19275.\nPages active:                                1110100.\nPages inactive:                              1103189.\nPages speculative:                              8537.\nPages throttled:                                   0.\nPages wired down:                             183368.\nPages purgeable:                               10569.\n\"Translation faults\":                     1928738931.\nPages copy-on-write:                        96402140.\nPages zero filled:                        3155982786.\nPages reactivated:                         172446088.\nPages purged:                               12532593.\nFile-backed pages:                           1284046.\nAnonymous pages:                              937780.\nPages stored in compressor:                  1201706.\nPages occupied by compressor:                 661035.\nDecompressions:                             97236845.\nCompressions:                              110343132.\nPageins:                                  2137540849.\nPageouts:                                     472996.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 132316.\nPages tagged resident:                         92861.\nPages tagged compressed:                       39455.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6172.\nPages tag-storage free:                          191.\nPages tag-storage non-tag pageable:            91933.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5843264.\nTagged compressions:                          713269.\nTagged decompressions:                        589300.\n"
      }
    },
    {
      "elapsed_seconds": 20.38158337501227,
      "stable_seconds": 20.12635066601797,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 21525463040,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21386641408,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    12734.\nPages active:                                1107458.\nPages inactive:                              1102974.\nPages speculative:                              8537.\nPages throttled:                                   0.\nPages wired down:                             192641.\nPages purgeable:                                8558.\n\"Translation faults\":                     1928741789.\nPages copy-on-write:                        96402514.\nPages zero filled:                        3155991490.\nPages reactivated:                         172446088.\nPages purged:                               12532593.\nFile-backed pages:                           1284045.\nAnonymous pages:                              934924.\nPages stored in compressor:                  1201701.\nPages occupied by compressor:                 661032.\nDecompressions:                             97236850.\nCompressions:                              110343132.\nPageins:                                  2137540853.\nPageouts:                                     472996.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 132305.\nPages tagged resident:                         92850.\nPages tagged compressed:                       39455.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6172.\nPages tag-storage free:                          191.\nPages tag-storage non-tag pageable:            91933.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5843264.\nTagged compressions:                          713269.\nTagged decompressions:                        589300.\n"
      }
    },
    {
      "elapsed_seconds": 25.41386462500668,
      "stable_seconds": 25.158631916012382,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 21628829696,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21488451584,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    15006.\nPages active:                                1114286.\nPages inactive:                              1104773.\nPages speculative:                              8633.\nPages throttled:                                   0.\nPages wired down:                             181799.\nPages purgeable:                               12373.\n\"Translation faults\":                     1928751888.\nPages copy-on-write:                        96403185.\nPages zero filled:                        3155997487.\nPages reactivated:                         172446107.\nPages purged:                               12532593.\nFile-backed pages:                           1284172.\nAnonymous pages:                              943520.\nPages stored in compressor:                  1201686.\nPages occupied by compressor:                 661025.\nDecompressions:                             97236865.\nCompressions:                              110343132.\nPageins:                                  2137540877.\nPageouts:                                     472996.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 132252.\nPages tagged resident:                         92797.\nPages tagged compressed:                       39455.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6172.\nPages tag-storage free:                          185.\nPages tag-storage non-tag pageable:            91939.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5843264.\nTagged compressions:                          713269.\nTagged decompressions:                        589300.\n"
      }
    },
    {
      "elapsed_seconds": 30.44696008399478,
      "stable_seconds": 30.191727375000482,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 21298954240,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21170487296,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     3896.\nPages active:                                1114601.\nPages inactive:                              1104487.\nPages speculative:                              8038.\nPages throttled:                                   0.\nPages wired down:                             193323.\nPages purgeable:                               10559.\n\"Translation faults\":                     1928795017.\nPages copy-on-write:                        96404810.\nPages zero filled:                        3156033807.\nPages reactivated:                         172446116.\nPages purged:                               12533377.\nFile-backed pages:                           1277689.\nAnonymous pages:                              949437.\nPages stored in compressor:                  1200832.\nPages occupied by compressor:                 660766.\nDecompressions:                             97237718.\nCompressions:                              110343132.\nPageins:                                  2137550650.\nPageouts:                                     473060.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 133031.\nPages tagged resident:                         93578.\nPages tagged compressed:                       39453.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6172.\nPages tag-storage free:                          192.\nPages tag-storage non-tag pageable:            91932.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5843136.\nTagged compressions:                          713269.\nTagged decompressions:                        589301.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/validation-buffered/receipt.json

Original bytes: 7373. SHA-256: `85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889`.

Normalized bytes: 7373. SHA-256: `85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889`.

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
  "committed_decode_tokens_per_second" : 5.6036767833310774,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9365755830076523,
    3.3002909580245614,
    3.4862076250137761,
    3.6622292910178658,
    3.8277814580069389,
    3.9938793330220506,
    4.1605281250085682,
    4.3407452910032589,
    4.5108763330208603,
    4.6837060830148403,
    4.8410625830001663,
    4.985982458019862,
    5.1413214580097701,
    5.2922048330074176,
    5.4678936250275001,
    5.6133895000093617
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
    "reclaimableBytes" : 21024980992,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.36371537501690909,
    0.18591666698921472,
    0.17602166600408964,
    0.16555216698907316,
    0.16609787501511164,
    0.16664879198651761,
    0.18021716599469073,
    0.17013104201760143,
    0.17282974999397993,
    0.15735649998532608,
    0.14491987501969561,
    0.15533899998990819,
    0.15088337499764748,
    0.17568879202008247,
    0.14549587498186156
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.517445791978389,
  "metadata_seconds" : 0.13453545799711719,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7786682488,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 5.6134086660167668,
  "request_vm_after" : {
    "reclaimableBytes" : 17398218752,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 16981311488,
    "swapins" : 28,
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
  "ttft_seconds" : 2.9365755830076523,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/validation-buffered-supervision/identity.json

Original bytes: 3028. SHA-256: `0abc8eac93401de9790efecc05a60df077536b6bfa5acf1847fab3fc0db058d5`.

Normalized bytes: 2979. SHA-256: `7462d92def1033b541519da9ef21179c12dfa8889a9647d13212b1d12607e707`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/buffered-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-buffered",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21172813824,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     4512.\nPages active:                                1113517.\nPages inactive:                              1104043.\nPages speculative:                              8037.\nPages throttled:                                   0.\nPages wired down:                             194507.\nPages purgeable:                               10559.\n\"Translation faults\":                     1928801968.\nPages copy-on-write:                        96405592.\nPages zero filled:                        3156038514.\nPages reactivated:                         172446116.\nPages purged:                               12533379.\nFile-backed pages:                           1277215.\nAnonymous pages:                              948382.\nPages stored in compressor:                  1200831.\nPages occupied by compressor:                 660765.\nDecompressions:                             97237719.\nCompressions:                              110343132.\nPageins:                                  2137550683.\nPageouts:                                     473060.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 133031.\nPages tagged resident:                         93578.\nPages tagged compressed:                       39453.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6172.\nPages tag-storage free:                          191.\nPages tag-storage non-tag pageable:            91933.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5843136.\nTagged compressions:                          713269.\nTagged decompressions:                        589301.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/validation-buffered-supervision/receipt.json

Original bytes: 2140. SHA-256: `5b09f7cdf6a7970291355fe2d476790dc5ab61f254442aa09ec9a92bd936d610`.

Normalized bytes: 2140. SHA-256: `5b09f7cdf6a7970291355fe2d476790dc5ab61f254442aa09ec9a92bd936d610`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7786682488,
  "samples": 1102,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23753129984,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470926.\nPages active:                                 830494.\nPages inactive:                               783478.\nPages speculative:                             74380.\nPages throttled:                                   0.\nPages wired down:                             182647.\nPages purgeable:                                 101.\n\"Translation faults\":                     1929491549.\nPages copy-on-write:                        96423130.\nPages zero filled:                        3156690349.\nPages reactivated:                         172692550.\nPages purged:                               12556101.\nFile-backed pages:                            978749.\nAnonymous pages:                              709603.\nPages stored in compressor:                  1360577.\nPages occupied by compressor:                 741981.\nDecompressions:                             97494615.\nCompressions:                              110783613.\nPageins:                                  2147829116.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129253.\nPages tagged resident:                         88209.\nPages tagged compressed:                       41044.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                         1661.\nPages tag-storage non-tag pageable:            90641.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6120320.\nTagged compressions:                          715268.\nTagged decompressions:                        589682.\n"
  },
  "seconds": 64.40924562499276
}
````

### vq-uncached-expert-cost-v2/validation-buffered-supervision/stdout.txt

Original bytes: 7374. SHA-256: `7951cc34320e488fe1528b84c080ea1da2b399a24ee2944a14242cca20528c2f`.

Normalized bytes: 7374. SHA-256: `7951cc34320e488fe1528b84c080ea1da2b399a24ee2944a14242cca20528c2f`.

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
  "committed_decode_tokens_per_second" : 5.6036767833310774,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9365755830076523,
    3.3002909580245614,
    3.4862076250137761,
    3.6622292910178658,
    3.8277814580069389,
    3.9938793330220506,
    4.1605281250085682,
    4.3407452910032589,
    4.5108763330208603,
    4.6837060830148403,
    4.8410625830001663,
    4.985982458019862,
    5.1413214580097701,
    5.2922048330074176,
    5.4678936250275001,
    5.6133895000093617
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
    "reclaimableBytes" : 21024980992,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.36371537501690909,
    0.18591666698921472,
    0.17602166600408964,
    0.16555216698907316,
    0.16609787501511164,
    0.16664879198651761,
    0.18021716599469073,
    0.17013104201760143,
    0.17282974999397993,
    0.15735649998532608,
    0.14491987501969561,
    0.15533899998990819,
    0.15088337499764748,
    0.17568879202008247,
    0.14549587498186156
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.517445791978389,
  "metadata_seconds" : 0.13453545799711719,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7786682488,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 5.6134086660167668,
  "request_vm_after" : {
    "reclaimableBytes" : 17398218752,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 16981311488,
    "swapins" : 28,
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
  "ttft_seconds" : 2.9365755830076523,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/validation-buffered-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v2/validation-uncached-admission.json

Original bytes: 17282. SHA-256: `22e6d36d599d46ac2b4c2851fb4dfe67e717e61f9faab984b92e108ed46920bc`.

Normalized bytes: 17282. SHA-256: `22e6d36d599d46ac2b4c2851fb4dfe67e717e61f9faab984b92e108ed46920bc`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.010226999991573393,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 17398218752,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23750967296,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   455908.\nPages active:                                 829457.\nPages inactive:                               798063.\nPages speculative:                             75777.\nPages throttled:                                   0.\nPages wired down:                             182590.\nPages purgeable:                                  91.\n\"Translation faults\":                     1929493305.\nPages copy-on-write:                        96423410.\nPages zero filled:                        3156690528.\nPages reactivated:                         172692550.\nPages purged:                               12556101.\nFile-backed pages:                            993645.\nAnonymous pages:                              709652.\nPages stored in compressor:                  1360544.\nPages occupied by compressor:                 741970.\nDecompressions:                             97494656.\nCompressions:                              110783613.\nPageins:                                  2147842470.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129196.\nPages tagged resident:                         88152.\nPages tagged compressed:                       41044.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                         1636.\nPages tag-storage non-tag pageable:            90666.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6120320.\nTagged compressions:                          715268.\nTagged decompressions:                        589682.\n"
      }
    },
    {
      "elapsed_seconds": 5.039776666992111,
      "stable_seconds": 5.029549667000538,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25312493568,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23716724736,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   428175.\nPages active:                                 834633.\nPages inactive:                               802971.\nPages speculative:                             97546.\nPages throttled:                                   0.\nPages wired down:                             182050.\nPages purgeable:                                 222.\n\"Translation faults\":                     1929507629.\nPages copy-on-write:                        96423823.\nPages zero filled:                        3156698396.\nPages reactivated:                         172692556.\nPages purged:                               12556101.\nFile-backed pages:                           1019157.\nAnonymous pages:                              715993.\nPages stored in compressor:                  1356064.\nPages occupied by compressor:                 739817.\nDecompressions:                             97498943.\nCompressions:                              110783613.\nPageins:                                  2147842577.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129274.\nPages tagged resident:                         88304.\nPages tagged compressed:                       40970.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                          672.\nPages tag-storage non-tag pageable:            91630.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6102144.\nTagged compressions:                          715268.\nTagged decompressions:                        589756.\n"
      }
    },
    {
      "elapsed_seconds": 10.070482999988599,
      "stable_seconds": 10.060255999997025,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25327534080,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23667949568,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   413220.\nPages active:                                 837572.\nPages inactive:                               810812.\nPages speculative:                            101353.\nPages throttled:                                   0.\nPages wired down:                             181986.\nPages purgeable:                                 679.\n\"Translation faults\":                     1929516855.\nPages copy-on-write:                        96424149.\nPages zero filled:                        3156706013.\nPages reactivated:                         172692556.\nPages purged:                               12556101.\nFile-backed pages:                           1030678.\nAnonymous pages:                              719059.\nPages stored in compressor:                  1355590.\nPages occupied by compressor:                 739697.\nDecompressions:                             97499421.\nCompressions:                              110783613.\nPageins:                                  2147842601.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129247.\nPages tagged resident:                         88282.\nPages tagged compressed:                       40965.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                          667.\nPages tag-storage non-tag pageable:            91635.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6101312.\nTagged compressions:                          715268.\nTagged decompressions:                        589761.\n"
      }
    },
    {
      "elapsed_seconds": 15.102283459011232,
      "stable_seconds": 15.092056459019659,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25267798016,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23606575104,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   406119.\nPages active:                                 844353.\nPages inactive:                               813077.\nPages speculative:                            101331.\nPages throttled:                                   0.\nPages wired down:                             181523.\nPages purgeable:                                 741.\n\"Translation faults\":                     1929542358.\nPages copy-on-write:                        96425774.\nPages zero filled:                        3156715366.\nPages reactivated:                         172692556.\nPages purged:                               12556101.\nFile-backed pages:                           1033971.\nAnonymous pages:                              724790.\nPages stored in compressor:                  1352796.\nPages occupied by compressor:                 738606.\nDecompressions:                             97502200.\nCompressions:                              110783613.\nPageins:                                  2147845136.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129291.\nPages tagged resident:                         88364.\nPages tagged compressed:                       40927.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                          524.\nPages tag-storage non-tag pageable:            91778.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6093376.\nTagged compressions:                          715268.\nTagged decompressions:                        589799.\n"
      }
    },
    {
      "elapsed_seconds": 20.133663374988828,
      "stable_seconds": 20.123436374997254,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25261637632,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23607296000,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   406051.\nPages active:                                 844582.\nPages inactive:                               813621.\nPages speculative:                            101165.\nPages throttled:                                   0.\nPages wired down:                             181464.\nPages purgeable:                                 754.\n\"Translation faults\":                     1929556607.\nPages copy-on-write:                        96426505.\nPages zero filled:                        3156725450.\nPages reactivated:                         172692558.\nPages purged:                               12556101.\nFile-backed pages:                           1034070.\nAnonymous pages:                              725298.\nPages stored in compressor:                  1352272.\nPages occupied by compressor:                 738497.\nDecompressions:                             97502718.\nCompressions:                              110783613.\nPageins:                                  2147845193.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129211.\nPages tagged resident:                         88293.\nPages tagged compressed:                       40918.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                          558.\nPages tag-storage non-tag pageable:            91744.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6091776.\nTagged compressions:                          715268.\nTagged decompressions:                        589805.\n"
      }
    },
    {
      "elapsed_seconds": 25.16607037500944,
      "stable_seconds": 25.155843375017866,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25217466368,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23541645312,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   395379.\nPages active:                                 848431.\nPages inactive:                               819449.\nPages speculative:                            102255.\nPages throttled:                                   0.\nPages wired down:                             181480.\nPages purgeable:                                 842.\n\"Translation faults\":                     1929574336.\nPages copy-on-write:                        96427788.\nPages zero filled:                        3156734323.\nPages reactivated:                         172692560.\nPages purged:                               12556101.\nFile-backed pages:                           1040647.\nAnonymous pages:                              729488.\nPages stored in compressor:                  1349826.\nPages occupied by compressor:                 737710.\nDecompressions:                             97503882.\nCompressions:                              110783613.\nPageins:                                  2147845250.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129272.\nPages tagged resident:                         88357.\nPages tagged compressed:                       40915.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                          536.\nPages tag-storage non-tag pageable:            91766.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6091136.\nTagged compressions:                          715268.\nTagged decompressions:                        589808.\n"
      }
    },
    {
      "elapsed_seconds": 30.198832249996485,
      "stable_seconds": 30.188605250004912,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25002950656,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23323869184,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   373708.\nPages active:                                 875789.\nPages inactive:                               820324.\nPages speculative:                            102543.\nPages throttled:                                   0.\nPages wired down:                             181481.\nPages purgeable:                                8521.\n\"Translation faults\":                     1929618342.\nPages copy-on-write:                        96428111.\nPages zero filled:                        3156760218.\nPages reactivated:                         172692675.\nPages purged:                               12556101.\nFile-backed pages:                           1041347.\nAnonymous pages:                              757309.\nPages stored in compressor:                  1333584.\nPages occupied by compressor:                 730929.\nDecompressions:                             97519337.\nCompressions:                              110783613.\nPageins:                                  2147845341.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129794.\nPages tagged resident:                         88933.\nPages tagged compressed:                       40861.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                          717.\nPages tag-storage non-tag pageable:            91585.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6079232.\nTagged compressions:                          715268.\nTagged decompressions:                        589862.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/validation-uncached/receipt.json

Original bytes: 7388. SHA-256: `20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612`.

Normalized bytes: 7388. SHA-256: `20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612`.

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
  "committed_decode_tokens_per_second" : 5.2399347961005756,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.8092415420105681,
    3.0982686670031399,
    3.3064796249964274,
    3.504520666989265,
    3.6887875829997938,
    3.8787001669988967,
    4.065937582985498,
    4.2700722920126282,
    4.4583499169966672,
    4.654894500010414,
    4.8387333329883404,
    5.0073536669951864,
    5.1792975419957656,
    5.3322744999895804,
    5.5206915829912759,
    5.6718725829850882
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 24754438144,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.28902712499257177,
    0.20821095799328759,
    0.19804104199283756,
    0.1842669160105288,
    0.18991258399910294,
    0.18723741598660126,
    0.20413470902713016,
    0.18827762498403899,
    0.19654458301374689,
    0.18383883297792636,
    0.16862033400684595,
    0.17194387500057928,
    0.15297695799381472,
    0.18841708300169557,
    0.15118099999381229
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.875026041001547,
  "metadata_seconds" : 0.13377554199541919,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7783471272,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 5.6718919999839272,
  "request_vm_after" : {
    "reclaimableBytes" : 17166106624,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17514053632,
    "swapins" : 28,
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
  "ttft_seconds" : 2.8092415420105681,
  "uncached_expert_files" : 9,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/validation-uncached-supervision/identity.json

Original bytes: 3028. SHA-256: `f73acda628ea62adaceb3c094f8048bf62a17392851064af85ab658a12f44c5b`.

Normalized bytes: 2979. SHA-256: `7f7a6a47eec1acb5a2394ff5e88f2e99f1124301e6727e0049c55103d898c9f4`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/uncached-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-uncached",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23323443200,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   373665.\nPages active:                                 875806.\nPages inactive:                               820325.\nPages speculative:                            102543.\nPages throttled:                                   0.\nPages wired down:                             181482.\nPages purgeable:                                8537.\n\"Translation faults\":                     1929623505.\nPages copy-on-write:                        96428871.\nPages zero filled:                        3156762417.\nPages reactivated:                         172692675.\nPages purged:                               12556101.\nFile-backed pages:                           1041348.\nAnonymous pages:                              757326.\nPages stored in compressor:                  1333564.\nPages occupied by compressor:                 730923.\nDecompressions:                             97519381.\nCompressions:                              110783613.\nPageins:                                  2147845347.\nPageouts:                                     474619.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129794.\nPages tagged resident:                         88933.\nPages tagged compressed:                       40861.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5994.\nPages tag-storage free:                          717.\nPages tag-storage non-tag pageable:            91585.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6079232.\nTagged compressions:                          715268.\nTagged decompressions:                        589862.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/validation-uncached-supervision/receipt.json

Original bytes: 2140. SHA-256: `22241f44fa6766b19d787a56230a5efa22bbd535b6ea56abce19abaf9acac795`.

Normalized bytes: 2140. SHA-256: `22241f44fa6766b19d787a56230a5efa22bbd535b6ea56abce19abaf9acac795`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7783471272,
  "samples": 1102,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23276830720,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   429609.\nPages active:                                 877594.\nPages inactive:                               809659.\nPages speculative:                             53190.\nPages throttled:                                   0.\nPages wired down:                             212026.\nPages purgeable:                                3395.\n\"Translation faults\":                     1930361366.\nPages copy-on-write:                        96444851.\nPages zero filled:                        3157404069.\nPages reactivated:                         172732738.\nPages purged:                               12575921.\nFile-backed pages:                            987701.\nAnonymous pages:                              752734.\nPages stored in compressor:                  1288245.\nPages occupied by compressor:                 703186.\nDecompressions:                             97634674.\nCompressions:                              110901599.\nPageins:                                  2157465112.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130909.\nPages tagged resident:                         90415.\nPages tagged compressed:                       40494.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5982.\nPages tag-storage free:                          822.\nPages tag-storage non-tag pageable:            91492.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6027200.\nTagged compressions:                          715280.\nTagged decompressions:                        590183.\n"
  },
  "seconds": 64.79290883400245
}
````

### vq-uncached-expert-cost-v2/validation-uncached-supervision/stdout.txt

Original bytes: 7389. SHA-256: `3c10db802f0b0881e5c0cbe79be70185080b2b7f3b4a4a2a5aeca21643467474`.

Normalized bytes: 7389. SHA-256: `3c10db802f0b0881e5c0cbe79be70185080b2b7f3b4a4a2a5aeca21643467474`.

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
  "committed_decode_tokens_per_second" : 5.2399347961005756,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.8092415420105681,
    3.0982686670031399,
    3.3064796249964274,
    3.504520666989265,
    3.6887875829997938,
    3.8787001669988967,
    4.065937582985498,
    4.2700722920126282,
    4.4583499169966672,
    4.654894500010414,
    4.8387333329883404,
    5.0073536669951864,
    5.1792975419957656,
    5.3322744999895804,
    5.5206915829912759,
    5.6718725829850882
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 24754438144,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.28902712499257177,
    0.20821095799328759,
    0.19804104199283756,
    0.1842669160105288,
    0.18991258399910294,
    0.18723741598660126,
    0.20413470902713016,
    0.18827762498403899,
    0.19654458301374689,
    0.18383883297792636,
    0.16862033400684595,
    0.17194387500057928,
    0.15297695799381472,
    0.18841708300169557,
    0.15118099999381229
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.875026041001547,
  "metadata_seconds" : 0.13377554199541919,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7783471272,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 5.6718919999839272,
  "request_vm_after" : {
    "reclaimableBytes" : 17166106624,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17514053632,
    "swapins" : 28,
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
  "ttft_seconds" : 2.8092415420105681,
  "uncached_expert_files" : 9,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/validation-uncached-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v2/round-1-buffered-admission.json

Original bytes: 17280. SHA-256: `847fca8bf7bade616baae463bd5104408b4a39a98c668a82d6b68a057a167b1d`.

Normalized bytes: 17280. SHA-256: `847fca8bf7bade616baae463bd5104408b4a39a98c668a82d6b68a057a167b1d`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.010214500012807548,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 17166106624,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23996399616,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   459754.\nPages active:                                 863618.\nPages inactive:                               824483.\nPages speculative:                             53244.\nPages throttled:                                   0.\nPages wired down:                             180984.\nPages purgeable:                                3347.\n\"Translation faults\":                     1930363380.\nPages copy-on-write:                        96445129.\nPages zero filled:                        3157404465.\nPages reactivated:                         172732738.\nPages purged:                               12575921.\nFile-backed pages:                           1001523.\nAnonymous pages:                              739822.\nPages stored in compressor:                  1288244.\nPages occupied by compressor:                 703185.\nDecompressions:                             97634683.\nCompressions:                              110901599.\nPageins:                                  2157478447.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130823.\nPages tagged resident:                         90329.\nPages tagged compressed:                       40494.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5982.\nPages tag-storage free:                          802.\nPages tag-storage non-tag pageable:            91512.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6027200.\nTagged compressions:                          715280.\nTagged decompressions:                        590183.\n"
      }
    },
    {
      "elapsed_seconds": 5.0416948340134695,
      "stable_seconds": 5.031480334000662,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24962383872,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23994023936,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   448606.\nPages active:                                 866614.\nPages inactive:                               825943.\nPages speculative:                             59344.\nPages throttled:                                   0.\nPages wired down:                             181511.\nPages purgeable:                                4819.\n\"Translation faults\":                     1930379336.\nPages copy-on-write:                        96445409.\nPages zero filled:                        3157416700.\nPages reactivated:                         172732792.\nPages purged:                               12575921.\nFile-backed pages:                           1011054.\nAnonymous pages:                              740847.\nPages stored in compressor:                  1288036.\nPages occupied by compressor:                 703173.\nDecompressions:                             97634891.\nCompressions:                              110901599.\nPageins:                                  2157480392.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130867.\nPages tagged resident:                         90393.\nPages tagged compressed:                       40474.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5982.\nPages tag-storage free:                          581.\nPages tag-storage non-tag pageable:            91733.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6025856.\nTagged compressions:                          715280.\nTagged decompressions:                        590195.\n"
      }
    },
    {
      "elapsed_seconds": 10.07106279200525,
      "stable_seconds": 10.060848291992443,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24931008512,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23851368448,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   429908.\nPages active:                                 866353.\nPages inactive:                               826786.\nPages speculative:                             65983.\nPages throttled:                                   0.\nPages wired down:                             192905.\nPages purgeable:                                4377.\n\"Translation faults\":                     1930393300.\nPages copy-on-write:                        96445776.\nPages zero filled:                        3157438039.\nPages reactivated:                         172732829.\nPages purged:                               12575921.\nFile-backed pages:                           1021487.\nAnonymous pages:                              737635.\nPages stored in compressor:                  1287767.\nPages occupied by compressor:                 703103.\nDecompressions:                             97635163.\nCompressions:                              110901599.\nPageins:                                  2157481585.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130898.\nPages tagged resident:                         90443.\nPages tagged compressed:                       40455.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5982.\nPages tag-storage free:                          431.\nPages tag-storage non-tag pageable:            91883.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6024000.\nTagged compressions:                          715280.\nTagged decompressions:                        590209.\n"
      }
    },
    {
      "elapsed_seconds": 15.101149083988275,
      "stable_seconds": 15.090934583975468,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25135349760,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23967596544,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   423321.\nPages active:                                 873492.\nPages inactive:                               832282.\nPages speculative:                             71417.\nPages throttled:                                   0.\nPages wired down:                             181484.\nPages purgeable:                                8751.\n\"Translation faults\":                     1930412192.\nPages copy-on-write:                        96446188.\nPages zero filled:                        3157450477.\nPages reactivated:                         172732876.\nPages purged:                               12575923.\nFile-backed pages:                           1030794.\nAnonymous pages:                              746397.\nPages stored in compressor:                  1287207.\nPages occupied by compressor:                 702941.\nDecompressions:                             97635707.\nCompressions:                              110901599.\nPageins:                                  2157483493.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130969.\nPages tagged resident:                         90527.\nPages tagged compressed:                       40442.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5982.\nPages tag-storage free:                          435.\nPages tag-storage non-tag pageable:            91879.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6022400.\nTagged compressions:                          715280.\nTagged decompressions:                        590215.\n"
      }
    },
    {
      "elapsed_seconds": 20.133038083993597,
      "stable_seconds": 20.12282358398079,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25208520704,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23979638784,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   419736.\nPages active:                                 874313.\nPages inactive:                               832558.\nPages speculative:                             75212.\nPages throttled:                                   0.\nPages wired down:                             180947.\nPages purgeable:                                6695.\n\"Translation faults\":                     1930435693.\nPages copy-on-write:                        96447463.\nPages zero filled:                        3157461586.\nPages reactivated:                         172732896.\nPages purged:                               12576691.\nFile-backed pages:                           1037170.\nAnonymous pages:                              744913.\nPages stored in compressor:                  1286501.\nPages occupied by compressor:                 702715.\nDecompressions:                             97636380.\nCompressions:                              110901599.\nPageins:                                  2157484694.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130958.\nPages tagged resident:                         90527.\nPages tagged compressed:                       40431.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5982.\nPages tag-storage free:                          365.\nPages tag-storage non-tag pageable:            91949.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6021632.\nTagged compressions:                          715280.\nTagged decompressions:                        590220.\n"
      }
    },
    {
      "elapsed_seconds": 25.16889358399203,
      "stable_seconds": 25.158679083979223,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24740773888,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23415422976,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   354646.\nPages active:                                 926753.\nPages inactive:                               844684.\nPages speculative:                             80652.\nPages throttled:                                   0.\nPages wired down:                             183043.\nPages purgeable:                               24708.\n\"Translation faults\":                     1930529049.\nPages copy-on-write:                        96450232.\nPages zero filled:                        3157523975.\nPages reactivated:                         172733033.\nPages purged:                               12576691.\nFile-backed pages:                           1049810.\nAnonymous pages:                              802279.\nPages stored in compressor:                  1263307.\nPages occupied by compressor:                 694836.\nDecompressions:                             97656512.\nCompressions:                              110901599.\nPageins:                                  2157490619.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 133837.\nPages tagged resident:                         94058.\nPages tagged compressed:                       39779.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5981.\nPages tag-storage free:                          729.\nPages tag-storage non-tag pageable:            91586.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5893888.\nTagged compressions:                          715280.\nTagged decompressions:                        590861.\n"
      }
    },
    {
      "elapsed_seconds": 30.18105258399737,
      "stable_seconds": 30.170838083984563,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24676352000,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23250501632,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   344925.\nPages active:                                 930200.\nPages inactive:                               848327.\nPages speculative:                             86917.\nPages throttled:                                   0.\nPages wired down:                             184506.\nPages purgeable:                               13141.\n\"Translation faults\":                     1930608534.\nPages copy-on-write:                        96456996.\nPages zero filled:                        3157558686.\nPages reactivated:                         172733035.\nPages purged:                               12576691.\nFile-backed pages:                           1061032.\nAnonymous pages:                              804412.\nPages stored in compressor:                  1257487.\nPages occupied by compressor:                 690113.\nDecompressions:                             97658085.\nCompressions:                              110901599.\nPageins:                                  2157494962.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 134269.\nPages tagged resident:                         94576.\nPages tagged compressed:                       39693.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5981.\nPages tag-storage free:                          727.\nPages tag-storage non-tag pageable:            91588.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5877696.\nTagged compressions:                          715280.\nTagged decompressions:                        590942.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/round-1-buffered/receipt.json

Original bytes: 22098. SHA-256: `d1a1c3a1bdca37b1532f417b9b5b227094b3dba2ba51141d395697159bc71b5d`.

Normalized bytes: 22098. SHA-256: `d1a1c3a1bdca37b1532f417b9b5b227094b3dba2ba51141d395697159bc71b5d`.

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
  "committed_decode_tokens_per_second" : 5.8080908348767224,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0611714999831747,
    3.4254296669969335,
    3.6195841669978108,
    3.8027044170012232,
    3.9731285419838969,
    4.1438649579940829,
    4.3178294169774745,
    4.5046385829919018,
    4.6767873749777209,
    4.8557337919774,
    5.0213012079766486,
    5.1730573749809992,
    5.3352043329796288,
    5.4836435419856571,
    5.6662654579849914,
    5.816443874995457,
    5.9529111250012647,
    6.1165063329972327,
    6.2770432079851162,
    6.4653067079780158,
    6.6373706669837702,
    6.7972616250044666,
    6.9636717499815859,
    7.1407221249828581,
    7.3280299579782877,
    7.500681249977788,
    7.6683894169982523,
    7.8459359999978915,
    8.0580614999926183,
    8.2463057499844581,
    8.429210417001741,
    8.5952002499834634,
    8.7840185419772752,
    8.9582804999954533,
    9.1257458329782821,
    9.3061029999807943,
    9.4943930419976823,
    9.680856541992398,
    9.8622002079791855,
    10.035799417004455,
    10.201693999988493,
    10.394772041996475,
    10.588002999982564,
    10.770164541987469,
    10.934846541989828,
    11.139695874997415,
    11.343452375003835,
    11.527043499983847,
    11.69803916697856,
    11.857352833001642,
    12.022444125002949,
    12.18969008300337,
    12.357863541983534,
    12.52348995799548,
    12.686024791997625,
    12.887988832982956,
    13.064799541985849,
    13.246940249984618,
    13.403283583000302,
    13.565606624993961,
    13.758293708000565,
    13.935008291999111,
    14.118111916992348,
    14.282857624988537,
    14.48501158299041,
    14.64391883299686,
    14.834102166991215,
    15.032248707982944,
    15.198564207996242,
    15.360834582999814,
    15.543750749988249,
    15.713541000004625,
    15.878069999977015,
    16.035540666984161,
    16.193883208004991,
    16.343449749983847,
    16.486587708001025,
    16.656114249984967,
    16.812483082991093,
    16.957510957989143,
    17.143347666977206,
    17.32271308300551,
    17.535804166982416,
    17.704071749991272,
    17.880604749982012,
    18.051506124989828,
    18.195778082998004,
    18.349093208002159,
    18.534262417000718,
    18.714450542000122,
    18.871403375000227,
    19.02563824999379,
    19.177305166987935,
    19.325214582990156,
    19.477452207996976,
    19.643285666999873,
    19.793452124984469,
    19.948540041979868,
    20.13196987498668,
    20.335898874996928,
    20.506423541984987,
    20.662374207982793,
    20.830685916997027,
    20.988942875002977,
    21.144070166978054,
    21.287455582991242,
    21.458557374979137,
    21.605643124989001,
    21.761830374976853,
    21.912375499989139,
    22.060118249995867,
    22.258628999989014,
    22.448245999985375,
    22.609973416983848,
    22.770777917001396,
    22.941526791983051,
    23.099606874980964,
    23.270368375000544,
    23.423292541992851,
    23.595559999987017,
    23.782002207997721,
    23.967137457977515,
    24.121354000002611,
    24.266263291996438,
    24.42740225000307,
    24.5874608749873,
    24.76742291697883,
    24.927220707992092
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
    "reclaimableBytes" : 24441978880,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.36425816701375879,
    0.19415450000087731,
    0.18312025000341237,
    0.17042412498267367,
    0.17073641601018608,
    0.17396445898339152,
    0.18680916601442732,
    0.17214879198581912,
    0.17894641699967906,
    0.16556741599924862,
    0.15175616700435057,
    0.16214695799862966,
    0.14843920900602825,
    0.18262191599933431,
    0.15017841701046564,
    0.13646725000580773,
    0.16359520799596794,
    0.16053687498788349,
    0.1882634999928996,
    0.17206395900575444,
    0.15989095802069642,
    0.16641012497711927,
    0.17705037500127219,
    0.18730783299542964,
    0.17265129199950024,
    0.16770816702046432,
    0.17754658299963921,
    0.21212549999472685,
    0.18824424999183975,
    0.18290466701728292,
    0.16598983298172243,
    0.18881829199381173,
    0.17426195801817812,
    0.16746533298282884,
    0.18035716700251214,
    0.18829004201688804,
    0.18646349999471568,
    0.18134366598678753,
    0.17359920902526937,
    0.1658945829840377,
    0.19307804200798273,
    0.19323095798608847,
    0.18216154200490564,
    0.16468200000235811,
    0.20484933300758712,
    0.20375650000642054,
    0.18359112498001195,
    0.17099566699471325,
    0.15931366602308117,
    0.16509129200130701,
    0.16724595800042152,
    0.16817345898016356,
    0.16562641601194628,
    0.16253483400214463,
    0.20196404098533094,
    0.17681070900289342,
    0.18214070799876936,
    0.15634333301568404,
    0.16232304199365899,
    0.19268708300660364,
    0.176714583998546,
    0.18310362499323674,
    0.16474570799618959,
    0.20215395800187252,
    0.15890725000645034,
    0.19018333399435505,
    0.19814654099172913,
    0.16631550001329742,
    0.16227037500357255,
    0.18291616698843427,
    0.16979025001637638,
    0.16452899997239001,
    0.1574706670071464,
    0.15834254102082923,
    0.14956654197885655,
    0.14313795801717788,
    0.16952654198394157,
    0.15636883300612681,
    0.14502787499804981,
    0.18583670898806304,
    0.17936541602830403,
    0.21309108397690579,
    0.16826758300885558,
    0.17653299999074079,
    0.17090137500781566,
    0.14427195800817572,
    0.15331512500415556,
    0.18516920899855904,
    0.18018812499940395,
    0.15695283300010487,
    0.1542348749935627,
    0.15166691699414514,
    0.14790941600222141,
    0.15223762500681914,
    0.16583345900289714,
    0.15016645798459649,
    0.1550879169953987,
    0.18342983300681226,
    0.20392900001024827,
    0.17052466698805802,
    0.15595066599780694,
    0.1683117090142332,
    0.15825695800594985,
    0.15512729197507724,
    0.14338541601318866,
    0.1711017919878941,
    0.14708575000986457,
    0.15618724998785183,
    0.15054512501228601,
    0.14774275000672787,
    0.19851074999314733,
    0.18961699999636039,
    0.16172741699847393,
    0.16080450001754798,
    0.17074887498165481,
    0.15808008299791254,
    0.17076150001958013,
    0.15292416699230671,
    0.17226745799416676,
    0.18644220801070333,
    0.18513524997979403,
    0.15421654202509671,
    0.14490929199382663,
    0.16113895800663158,
    0.16005862498423085,
    0.17996204199152999,
    0.1597977910132613
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.880133083002875,
  "metadata_seconds" : 0.14776908297790214,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7740872752,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 24.927240332996007,
  "request_vm_after" : {
    "reclaimableBytes" : 18041749504,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17038557184,
    "swapins" : 28,
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
  "ttft_seconds" : 3.0611714999831747,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-1-buffered-supervision/identity.json

Original bytes: 3200. SHA-256: `62746d25df33a8635d3ef43026efad83649591f43b8370d44d9cab81e72fc61d`.

Normalized bytes: 3144. SHA-256: `cf0cf87a7d1786d8a5577287be05e1560408895048661186f40e4e710b102c87`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/buffered-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/round-1-buffered",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-buffered/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23254581248,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   344685.\nPages active:                                 929213.\nPages inactive:                               849092.\nPages speculative:                             87363.\nPages throttled:                                   0.\nPages wired down:                             184497.\nPages purgeable:                               13141.\n\"Translation faults\":                     1930616577.\nPages copy-on-write:                        96457849.\nPages zero filled:                        3157562221.\nPages reactivated:                         172733035.\nPages purged:                               12576691.\nFile-backed pages:                           1061521.\nAnonymous pages:                              804147.\nPages stored in compressor:                  1257478.\nPages occupied by compressor:                 690108.\nDecompressions:                             97658118.\nCompressions:                              110901599.\nPageins:                                  2157494981.\nPageouts:                                     477738.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 134298.\nPages tagged resident:                         94605.\nPages tagged compressed:                       39693.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5981.\nPages tag-storage free:                          701.\nPages tag-storage non-tag pageable:            91614.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5877696.\nTagged compressions:                          715280.\nTagged decompressions:                        590942.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/round-1-buffered-supervision/receipt.json

Original bytes: 2140. SHA-256: `a19773a594d37ba1741eee62151410fa3dac73ff9fabbb383b7f4e312d8010ef`.

Normalized bytes: 2140. SHA-256: `a19773a594d37ba1741eee62151410fa3dac73ff9fabbb383b7f4e312d8010ef`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7740872752,
  "samples": 1461,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23750164480,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   442273.\nPages active:                                 863017.\nPages inactive:                               788563.\nPages speculative:                             82712.\nPages throttled:                                   0.\nPages wired down:                             205314.\nPages purgeable:                                 234.\n\"Translation faults\":                     1931688024.\nPages copy-on-write:                        96491421.\nPages zero filled:                        3158415667.\nPages reactivated:                         172777114.\nPages purged:                               12589836.\nFile-backed pages:                           1007088.\nAnonymous pages:                              727204.\nPages stored in compressor:                  1285790.\nPages occupied by compressor:                 702057.\nDecompressions:                             97953797.\nCompressions:                              111263939.\nPageins:                                  2167983803.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129020.\nPages tagged resident:                         88206.\nPages tagged compressed:                       40814.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                         1518.\nPages tag-storage non-tag pageable:            90827.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6075328.\nTagged compressions:                          716574.\nTagged decompressions:                        591110.\n"
  },
  "seconds": 85.08532520799781
}
````

### vq-uncached-expert-cost-v2/round-1-buffered-supervision/stdout.txt

Original bytes: 22099. SHA-256: `2a7ed800176f7ecbdeac5d67509b4561f59ac68c8b09f4ce179cedb1e91a3203`.

Normalized bytes: 22099. SHA-256: `2a7ed800176f7ecbdeac5d67509b4561f59ac68c8b09f4ce179cedb1e91a3203`.

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
  "committed_decode_tokens_per_second" : 5.8080908348767224,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.0611714999831747,
    3.4254296669969335,
    3.6195841669978108,
    3.8027044170012232,
    3.9731285419838969,
    4.1438649579940829,
    4.3178294169774745,
    4.5046385829919018,
    4.6767873749777209,
    4.8557337919774,
    5.0213012079766486,
    5.1730573749809992,
    5.3352043329796288,
    5.4836435419856571,
    5.6662654579849914,
    5.816443874995457,
    5.9529111250012647,
    6.1165063329972327,
    6.2770432079851162,
    6.4653067079780158,
    6.6373706669837702,
    6.7972616250044666,
    6.9636717499815859,
    7.1407221249828581,
    7.3280299579782877,
    7.500681249977788,
    7.6683894169982523,
    7.8459359999978915,
    8.0580614999926183,
    8.2463057499844581,
    8.429210417001741,
    8.5952002499834634,
    8.7840185419772752,
    8.9582804999954533,
    9.1257458329782821,
    9.3061029999807943,
    9.4943930419976823,
    9.680856541992398,
    9.8622002079791855,
    10.035799417004455,
    10.201693999988493,
    10.394772041996475,
    10.588002999982564,
    10.770164541987469,
    10.934846541989828,
    11.139695874997415,
    11.343452375003835,
    11.527043499983847,
    11.69803916697856,
    11.857352833001642,
    12.022444125002949,
    12.18969008300337,
    12.357863541983534,
    12.52348995799548,
    12.686024791997625,
    12.887988832982956,
    13.064799541985849,
    13.246940249984618,
    13.403283583000302,
    13.565606624993961,
    13.758293708000565,
    13.935008291999111,
    14.118111916992348,
    14.282857624988537,
    14.48501158299041,
    14.64391883299686,
    14.834102166991215,
    15.032248707982944,
    15.198564207996242,
    15.360834582999814,
    15.543750749988249,
    15.713541000004625,
    15.878069999977015,
    16.035540666984161,
    16.193883208004991,
    16.343449749983847,
    16.486587708001025,
    16.656114249984967,
    16.812483082991093,
    16.957510957989143,
    17.143347666977206,
    17.32271308300551,
    17.535804166982416,
    17.704071749991272,
    17.880604749982012,
    18.051506124989828,
    18.195778082998004,
    18.349093208002159,
    18.534262417000718,
    18.714450542000122,
    18.871403375000227,
    19.02563824999379,
    19.177305166987935,
    19.325214582990156,
    19.477452207996976,
    19.643285666999873,
    19.793452124984469,
    19.948540041979868,
    20.13196987498668,
    20.335898874996928,
    20.506423541984987,
    20.662374207982793,
    20.830685916997027,
    20.988942875002977,
    21.144070166978054,
    21.287455582991242,
    21.458557374979137,
    21.605643124989001,
    21.761830374976853,
    21.912375499989139,
    22.060118249995867,
    22.258628999989014,
    22.448245999985375,
    22.609973416983848,
    22.770777917001396,
    22.941526791983051,
    23.099606874980964,
    23.270368375000544,
    23.423292541992851,
    23.595559999987017,
    23.782002207997721,
    23.967137457977515,
    24.121354000002611,
    24.266263291996438,
    24.42740225000307,
    24.5874608749873,
    24.76742291697883,
    24.927220707992092
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
    "reclaimableBytes" : 24441978880,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.36425816701375879,
    0.19415450000087731,
    0.18312025000341237,
    0.17042412498267367,
    0.17073641601018608,
    0.17396445898339152,
    0.18680916601442732,
    0.17214879198581912,
    0.17894641699967906,
    0.16556741599924862,
    0.15175616700435057,
    0.16214695799862966,
    0.14843920900602825,
    0.18262191599933431,
    0.15017841701046564,
    0.13646725000580773,
    0.16359520799596794,
    0.16053687498788349,
    0.1882634999928996,
    0.17206395900575444,
    0.15989095802069642,
    0.16641012497711927,
    0.17705037500127219,
    0.18730783299542964,
    0.17265129199950024,
    0.16770816702046432,
    0.17754658299963921,
    0.21212549999472685,
    0.18824424999183975,
    0.18290466701728292,
    0.16598983298172243,
    0.18881829199381173,
    0.17426195801817812,
    0.16746533298282884,
    0.18035716700251214,
    0.18829004201688804,
    0.18646349999471568,
    0.18134366598678753,
    0.17359920902526937,
    0.1658945829840377,
    0.19307804200798273,
    0.19323095798608847,
    0.18216154200490564,
    0.16468200000235811,
    0.20484933300758712,
    0.20375650000642054,
    0.18359112498001195,
    0.17099566699471325,
    0.15931366602308117,
    0.16509129200130701,
    0.16724595800042152,
    0.16817345898016356,
    0.16562641601194628,
    0.16253483400214463,
    0.20196404098533094,
    0.17681070900289342,
    0.18214070799876936,
    0.15634333301568404,
    0.16232304199365899,
    0.19268708300660364,
    0.176714583998546,
    0.18310362499323674,
    0.16474570799618959,
    0.20215395800187252,
    0.15890725000645034,
    0.19018333399435505,
    0.19814654099172913,
    0.16631550001329742,
    0.16227037500357255,
    0.18291616698843427,
    0.16979025001637638,
    0.16452899997239001,
    0.1574706670071464,
    0.15834254102082923,
    0.14956654197885655,
    0.14313795801717788,
    0.16952654198394157,
    0.15636883300612681,
    0.14502787499804981,
    0.18583670898806304,
    0.17936541602830403,
    0.21309108397690579,
    0.16826758300885558,
    0.17653299999074079,
    0.17090137500781566,
    0.14427195800817572,
    0.15331512500415556,
    0.18516920899855904,
    0.18018812499940395,
    0.15695283300010487,
    0.1542348749935627,
    0.15166691699414514,
    0.14790941600222141,
    0.15223762500681914,
    0.16583345900289714,
    0.15016645798459649,
    0.1550879169953987,
    0.18342983300681226,
    0.20392900001024827,
    0.17052466698805802,
    0.15595066599780694,
    0.1683117090142332,
    0.15825695800594985,
    0.15512729197507724,
    0.14338541601318866,
    0.1711017919878941,
    0.14708575000986457,
    0.15618724998785183,
    0.15054512501228601,
    0.14774275000672787,
    0.19851074999314733,
    0.18961699999636039,
    0.16172741699847393,
    0.16080450001754798,
    0.17074887498165481,
    0.15808008299791254,
    0.17076150001958013,
    0.15292416699230671,
    0.17226745799416676,
    0.18644220801070333,
    0.18513524997979403,
    0.15421654202509671,
    0.14490929199382663,
    0.16113895800663158,
    0.16005862498423085,
    0.17996204199152999,
    0.1597977910132613
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 59.880133083002875,
  "metadata_seconds" : 0.14776908297790214,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7740872752,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 24.927240332996007,
  "request_vm_after" : {
    "reclaimableBytes" : 18041749504,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17038557184,
    "swapins" : 28,
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
  "ttft_seconds" : 3.0611714999831747,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-1-buffered-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v2/round-1-uncached-admission.json

Original bytes: 17281. SHA-256: `db0ffdf80dcf442c5410a2f1a5a0d100cdfa4acc37803efc3e9a3e146d20f841`.

Normalized bytes: 17281. SHA-256: `db0ffdf80dcf442c5410a2f1a5a0d100cdfa4acc37803efc3e9a3e146d20f841`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.011314541014144197,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25560694784,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24206999552,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   456617.\nPages active:                                 857838.\nPages inactive:                               803136.\nPages speculative:                             82764.\nPages throttled:                                   0.\nPages wired down:                             181662.\nPages purgeable:                                 234.\n\"Translation faults\":                     1931689738.\nPages copy-on-write:                        96491700.\nPages zero filled:                        3158415826.\nPages reactivated:                         172777114.\nPages purged:                               12589836.\nFile-backed pages:                           1020627.\nAnonymous pages:                              723111.\nPages stored in compressor:                  1285785.\nPages occupied by compressor:                 702055.\nDecompressions:                             97953810.\nCompressions:                              111263939.\nPageins:                                  2167997157.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129010.\nPages tagged resident:                         88196.\nPages tagged compressed:                       40814.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                         1374.\nPages tag-storage non-tag pageable:            90971.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6075328.\nTagged compressions:                          716574.\nTagged decompressions:                        591110.\n"
      }
    },
    {
      "elapsed_seconds": 5.042188708001049,
      "stable_seconds": 5.030874166986905,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25569329152,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24209866752,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   456343.\nPages active:                                 859001.\nPages inactive:                               804083.\nPages speculative:                             82975.\nPages throttled:                                   0.\nPages wired down:                             180482.\nPages purgeable:                                 236.\n\"Translation faults\":                     1931711993.\nPages copy-on-write:                        96495958.\nPages zero filled:                        3158421358.\nPages reactivated:                         172777114.\nPages purged:                               12589836.\nFile-backed pages:                           1021074.\nAnonymous pages:                              724985.\nPages stored in compressor:                  1284884.\nPages occupied by compressor:                 701627.\nDecompressions:                             97954421.\nCompressions:                              111263939.\nPageins:                                  2167997516.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128889.\nPages tagged resident:                         88075.\nPages tagged compressed:                       40814.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          911.\nPages tag-storage non-tag pageable:            91434.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6075328.\nTagged compressions:                          716574.\nTagged decompressions:                        591110.\n"
      }
    },
    {
      "elapsed_seconds": 10.072940832993481,
      "stable_seconds": 10.061626291979337,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25663848448,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24301961216,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   456925.\nPages active:                                 867940.\nPages inactive:                               804142.\nPages speculative:                             83174.\nPages throttled:                                   0.\nPages wired down:                             171648.\nPages purgeable:                                4867.\n\"Translation faults\":                     1931719033.\nPages copy-on-write:                        96496236.\nPages zero filled:                        3158425600.\nPages reactivated:                         172777114.\nPages purged:                               12589836.\nFile-backed pages:                           1021482.\nAnonymous pages:                              733774.\nPages stored in compressor:                  1283521.\nPages occupied by compressor:                 701204.\nDecompressions:                             97955298.\nCompressions:                              111263939.\nPageins:                                  2167997834.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128860.\nPages tagged resident:                         88075.\nPages tagged compressed:                       40785.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          502.\nPages tag-storage non-tag pageable:            91843.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6071680.\nTagged compressions:                          716574.\nTagged decompressions:                        591139.\n"
      }
    },
    {
      "elapsed_seconds": 15.105716582998866,
      "stable_seconds": 15.094402041984722,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25321783296,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23958700032,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   434806.\nPages active:                                 893946.\nPages inactive:                               809878.\nPages speculative:                             83259.\nPages throttled:                                   0.\nPages wired down:                             180409.\nPages purgeable:                                5899.\n\"Translation faults\":                     1931810737.\nPages copy-on-write:                        96497625.\nPages zero filled:                        3158453698.\nPages reactivated:                         172777127.\nPages purged:                               12589836.\nFile-backed pages:                           1021618.\nAnonymous pages:                              765465.\nPages stored in compressor:                  1250762.\nPages occupied by compressor:                 682708.\nDecompressions:                             97986298.\nCompressions:                              111263939.\nPageins:                                  2167997907.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128855.\nPages tagged resident:                         88075.\nPages tagged compressed:                       40780.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          787.\nPages tag-storage non-tag pageable:            91558.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6070912.\nTagged compressions:                          716574.\nTagged decompressions:                        591140.\n"
      }
    },
    {
      "elapsed_seconds": 20.13654358300846,
      "stable_seconds": 20.125229041994317,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25316147200,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23954325504,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   437580.\nPages active:                                 889311.\nPages inactive:                               810985.\nPages speculative:                             83188.\nPages throttled:                                   0.\nPages wired down:                             181393.\nPages purgeable:                                2839.\n\"Translation faults\":                     1931831422.\nPages copy-on-write:                        96501673.\nPages zero filled:                        3158460206.\nPages reactivated:                         172777127.\nPages purged:                               12589836.\nFile-backed pages:                           1021637.\nAnonymous pages:                              761847.\nPages stored in compressor:                  1250386.\nPages occupied by compressor:                 682538.\nDecompressions:                             97986515.\nCompressions:                              111263939.\nPageins:                                  2167997981.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128768.\nPages tagged resident:                         87988.\nPages tagged compressed:                       40780.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          761.\nPages tag-storage non-tag pageable:            91584.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6070912.\nTagged compressions:                          716574.\nTagged decompressions:                        591140.\n"
      }
    },
    {
      "elapsed_seconds": 25.172586458007572,
      "stable_seconds": 25.161271916993428,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25315016704,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23953473536,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   439239.\nPages active:                                 888819.\nPages inactive:                               811248.\nPages speculative:                             83297.\nPages throttled:                                   0.\nPages wired down:                             180323.\nPages purgeable:                                 961.\n\"Translation faults\":                     1931837257.\nPages copy-on-write:                        96502089.\nPages zero filled:                        3158463732.\nPages reactivated:                         172777142.\nPages purged:                               12590094.\nFile-backed pages:                           1021804.\nAnonymous pages:                              761560.\nPages stored in compressor:                  1249688.\nPages occupied by compressor:                 682160.\nDecompressions:                             97987106.\nCompressions:                              111263939.\nPageins:                                  2167998107.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128795.\nPages tagged resident:                         88017.\nPages tagged compressed:                       40778.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          742.\nPages tag-storage non-tag pageable:            91603.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6070144.\nTagged compressions:                          716574.\nTagged decompressions:                        591142.\n"
      }
    },
    {
      "elapsed_seconds": 30.203642625012435,
      "stable_seconds": 30.19232808399829,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25444663296,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24078467072,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   442704.\nPages active:                                 895557.\nPages inactive:                               811962.\nPages speculative:                             83335.\nPages throttled:                                   0.\nPages wired down:                             171522.\nPages purgeable:                                5071.\n\"Translation faults\":                     1931839789.\nPages copy-on-write:                        96502368.\nPages zero filled:                        3158467119.\nPages reactivated:                         172777244.\nPages purged:                               12590109.\nFile-backed pages:                           1021858.\nAnonymous pages:                              768996.\nPages stored in compressor:                  1246599.\nPages occupied by compressor:                 679669.\nDecompressions:                             97987247.\nCompressions:                              111263939.\nPageins:                                  2167998141.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128792.\nPages tagged resident:                         88017.\nPages tagged compressed:                       40775.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          767.\nPages tag-storage non-tag pageable:            91578.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6069696.\nTagged compressions:                          716574.\nTagged decompressions:                        591145.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/round-1-uncached/receipt.json

Original bytes: 22117. SHA-256: `1d72c4e391ca08b85ad10edf3d5773324461e44ef6f08c1aaf9ce32e8aa1b72b`.

Normalized bytes: 22117. SHA-256: `1d72c4e391ca08b85ad10edf3d5773324461e44ef6f08c1aaf9ce32e8aa1b72b`.

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
  "committed_decode_tokens_per_second" : 5.2939405978988638,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.8643325000011828,
    3.1337324999913108,
    3.3394339589867741,
    3.5343474999826867,
    3.7226037499785889,
    3.907432499981951,
    4.0966814999992494,
    4.3003981249930803,
    4.4903447089891415,
    4.6879796249850187,
    4.8700193339900579,
    5.0326516249915585,
    5.213148791983258,
    5.3753906669735443,
    5.5692275839974172,
    5.7268738749844488,
    5.8709661249886267,
    6.0507380419876426,
    6.2277445840009023,
    6.4322466249868739,
    6.6216696669871453,
    6.79812099999981,
    6.9832502089848276,
    7.1809004589740653,
    7.4036037089827005,
    7.6002344589796849,
    7.7832049999851733,
    7.9696555839909706,
    8.1968747089849785,
    8.4003934169886634,
    8.6048478339798748,
    8.7847815419954713,
    8.9964656669762917,
    9.1954982919851318,
    9.3871346669911873,
    9.5858130839769728,
    9.7858361669932492,
    9.9897244169842452,
    10.188400208979147,
    10.376785791973816,
    10.560528583999258,
    10.770551791996695,
    10.989178166986676,
    11.190927291987464,
    11.373499791981885,
    11.598645958991256,
    11.819587874982972,
    12.027903291978873,
    12.225581666978542,
    12.396332333999453,
    12.582416083983844,
    12.768532999994932,
    12.959639958979096,
    13.145743083994603,
    13.321999666979536,
    13.548136249999516,
    13.743209958978696,
    13.947828459000448,
    14.131572083977517,
    14.320262541994452,
    14.53224279198912,
    14.733733249973739,
    14.936846416996559,
    15.120797499985201,
    15.343227584002307,
    15.520800124999369,
    15.732512916991254,
    15.947526167001342,
    16.136764999973821,
    16.317163916974096,
    16.519961791986134,
    16.703623749985127,
    16.883255249995273,
    17.048151208990021,
    17.222905458998866,
    17.393072624981869,
    17.545148208999308,
    17.731778999994276,
    17.895055667002453,
    18.053794833977008,
    18.262034666986438,
    18.452045458980137,
    18.652555541979382,
    18.837819209002191,
    19.035942041984526,
    19.218124583974713,
    19.374735374993179,
    19.539791374991182,
    19.75093174999347,
    19.95091266700183,
    20.126775916985935,
    20.29684387499583,
    20.456203708978137,
    20.622442749998299,
    20.784247958974447,
    20.968621916981647,
    21.136663374985801,
    21.310621833981713,
    21.514108541974565,
    21.734247708984185,
    21.927205333980964,
    22.094661958981305,
    22.274348916980671,
    22.450436708983034,
    22.622961583983852,
    22.774924416997237,
    22.968096791999415,
    23.12341749999905,
    23.306477666978026,
    23.477578833990265,
    23.647514999989653,
    23.870474999974249,
    24.082149333989946,
    24.264430624985835,
    24.443752624996705,
    24.630621291988064,
    24.809077208978124,
    25.00039033399662,
    25.170164499984821,
    25.359083124989411,
    25.563995584001532,
    25.763153458974557,
    25.939020333986264,
    26.095737999974517,
    26.277994791977108,
    26.464174875000026,
    26.670355041977018,
    26.854023666994181
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 25194053632,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.26939999999012798,
    0.20570145899546333,
    0.19491354099591263,
    0.18825624999590218,
    0.18482875000336207,
    0.18924900001729839,
    0.20371662499383092,
    0.18994658399606124,
    0.19763491599587724,
    0.18203970900503919,
    0.16263229100150056,
    0.18049716699169949,
    0.16224187499028631,
    0.19383691702387296,
    0.15764629098703153,
    0.14409225000417791,
    0.17977191699901596,
    0.1770065420132596,
    0.20450204098597169,
    0.18942304200027138,
    0.17645133301266469,
    0.18512920898501761,
    0.19765024998923764,
    0.22270325000863522,
    0.19663074999698438,
    0.18297054100548849,
    0.18645058400579728,
    0.22721912499400787,
    0.20351870800368488,
    0.20445441699121147,
    0.17993370801559649,
    0.21168412498082034,
    0.19903262500884011,
    0.19163637500605546,
    0.19867841698578559,
    0.20002308301627636,
    0.20388824999099597,
    0.19867579199490137,
    0.18838558299466968,
    0.1837427920254413,
    0.21002320799743757,
    0.21862637498998083,
    0.2017491250007879,
    0.18257249999442138,
    0.2251461670093704,
    0.22094191599171609,
    0.20831541699590161,
    0.19767837499966845,
    0.17075066702091135,
    0.18608374998439103,
    0.1861169160110876,
    0.19110695898416452,
    0.18610312501550652,
    0.17625658298493363,
    0.2261365830199793,
    0.19507370897918008,
    0.20461850002175197,
    0.18374362497706898,
    0.18869045801693574,
    0.21198024999466725,
    0.20149045798461884,
    0.20311316702282056,
    0.18395108298864216,
    0.2224300840171054,
    0.17757254099706188,
    0.21171279199188575,
    0.21501325001008809,
    0.18923883297247812,
    0.18039891700027511,
    0.20279787501203828,
    0.18366195799899288,
    0.17963150001014583,
    0.16489595899474807,
    0.1747542500088457,
    0.17016716598300263,
    0.15207558401743881,
    0.18663079099496827,
    0.16327666700817645,
    0.1587391669745557,
    0.20823983300942928,
    0.19001079199369997,
    0.20051008299924433,
    0.18526366702280939,
    0.19812283298233524,
    0.18218254199018702,
    0.15661079101846553,
    0.16505599999800324,
    0.21114037500228733,
    0.19998091700836085,
    0.17586324998410419,
    0.17006795800989494,
    0.15935983398230746,
    0.1662390410201624,
    0.1618052089761477,
    0.18437395800719969,
    0.16804145800415426,
    0.17395845899591222,
    0.20348670799285173,
    0.22013916700962,
    0.19295762499677949,
    0.16745662500034086,
    0.1796869579993654,
    0.17608779200236313,
    0.1725248750008177,
    0.15196283301338553,
    0.19317237500217743,
    0.15532070799963549,
    0.18306016697897576,
    0.17110116701223888,
    0.16993616599938832,
    0.22295999998459592,
    0.21167433401569724,
    0.18228129099588841,
    0.1793220000108704,
    0.18686866699135862,
    0.17845591699006036,
    0.19131312501849607,
    0.16977416598820128,
    0.18891862500458956,
    0.20491245901212096,
    0.19915787497302517,
    0.17586687501170672,
    0.15671766598825343,
    0.18225679200259037,
    0.18618008302291855,
    0.20618016697699204,
    0.18366862501716241
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.496278625010746,
  "metadata_seconds" : 0.13437062498996966,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7723374616,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 26.85404079197906,
  "request_vm_after" : {
    "reclaimableBytes" : 17239179264,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17319231488,
    "swapins" : 28,
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
  "ttft_seconds" : 2.8643325000011828,
  "uncached_expert_files" : 9,
  "validation_receipt_sha256" : "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-1-uncached-supervision/identity.json

Original bytes: 3200. SHA-256: `f06c837811f6686be4f2cf97d3a2002f1f434b310d7031825ba86b4f6f0baf0c`.

Normalized bytes: 3144. SHA-256: `67c27fef18e409048c46ceb24d0d4b0fd5090f970fd358ae494b1999c5a3f841`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/uncached-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/round-1-uncached",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-uncached/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24077713408,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   442641.\nPages active:                                 895561.\nPages inactive:                               811963.\nPages speculative:                             83335.\nPages throttled:                                   0.\nPages wired down:                             171522.\nPages purgeable:                                5087.\n\"Translation faults\":                     1931844938.\nPages copy-on-write:                        96503128.\nPages zero filled:                        3158469311.\nPages reactivated:                         172777244.\nPages purged:                               12590109.\nFile-backed pages:                           1021859.\nAnonymous pages:                              769000.\nPages stored in compressor:                  1246598.\nPages occupied by compressor:                 679669.\nDecompressions:                             97987272.\nCompressions:                              111263939.\nPageins:                                  2167998147.\nPageouts:                                     478574.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128792.\nPages tagged resident:                         88017.\nPages tagged compressed:                       40775.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          767.\nPages tag-storage non-tag pageable:            91578.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6069696.\nTagged compressions:                          716574.\nTagged decompressions:                        591145.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/round-1-uncached-supervision/receipt.json

Original bytes: 2140. SHA-256: `befc1afb26b41d1b11dc3e358b589919308b825ab89edc7ecd71058f720e63b2`.

Normalized bytes: 2140. SHA-256: `befc1afb26b41d1b11dc3e358b589919308b825ab89edc7ecd71058f720e63b2`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7723374616,
  "samples": 1467,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23970775040,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470081.\nPages active:                                 884629.\nPages inactive:                               822268.\nPages speculative:                             61129.\nPages throttled:                                   0.\nPages wired down:                             170686.\nPages purgeable:                                6590.\n\"Translation faults\":                     1932518976.\nPages copy-on-write:                        96531111.\nPages zero filled:                        3159052081.\nPages reactivated:                         172817416.\nPages purged:                               12594414.\nFile-backed pages:                            986389.\nAnonymous pages:                              781637.\nPages stored in compressor:                  1242527.\nPages occupied by compressor:                 675694.\nDecompressions:                             98129324.\nCompressions:                              111434465.\nPageins:                                  2177539588.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129059.\nPages tagged resident:                         88420.\nPages tagged compressed:                       40639.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                         1118.\nPages tag-storage non-tag pageable:            91236.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6036672.\nTagged compressions:                          716612.\nTagged decompressions:                        591317.\n"
  },
  "seconds": 85.62563904200215
}
````

### vq-uncached-expert-cost-v2/round-1-uncached-supervision/stdout.txt

Original bytes: 22118. SHA-256: `bbf35494b99c4a24968ff465d9e49b75a1b90052aa0cf831d7eff2bf6cfe585a`.

Normalized bytes: 22118. SHA-256: `bbf35494b99c4a24968ff465d9e49b75a1b90052aa0cf831d7eff2bf6cfe585a`.

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
  "committed_decode_tokens_per_second" : 5.2939405978988638,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.8643325000011828,
    3.1337324999913108,
    3.3394339589867741,
    3.5343474999826867,
    3.7226037499785889,
    3.907432499981951,
    4.0966814999992494,
    4.3003981249930803,
    4.4903447089891415,
    4.6879796249850187,
    4.8700193339900579,
    5.0326516249915585,
    5.213148791983258,
    5.3753906669735443,
    5.5692275839974172,
    5.7268738749844488,
    5.8709661249886267,
    6.0507380419876426,
    6.2277445840009023,
    6.4322466249868739,
    6.6216696669871453,
    6.79812099999981,
    6.9832502089848276,
    7.1809004589740653,
    7.4036037089827005,
    7.6002344589796849,
    7.7832049999851733,
    7.9696555839909706,
    8.1968747089849785,
    8.4003934169886634,
    8.6048478339798748,
    8.7847815419954713,
    8.9964656669762917,
    9.1954982919851318,
    9.3871346669911873,
    9.5858130839769728,
    9.7858361669932492,
    9.9897244169842452,
    10.188400208979147,
    10.376785791973816,
    10.560528583999258,
    10.770551791996695,
    10.989178166986676,
    11.190927291987464,
    11.373499791981885,
    11.598645958991256,
    11.819587874982972,
    12.027903291978873,
    12.225581666978542,
    12.396332333999453,
    12.582416083983844,
    12.768532999994932,
    12.959639958979096,
    13.145743083994603,
    13.321999666979536,
    13.548136249999516,
    13.743209958978696,
    13.947828459000448,
    14.131572083977517,
    14.320262541994452,
    14.53224279198912,
    14.733733249973739,
    14.936846416996559,
    15.120797499985201,
    15.343227584002307,
    15.520800124999369,
    15.732512916991254,
    15.947526167001342,
    16.136764999973821,
    16.317163916974096,
    16.519961791986134,
    16.703623749985127,
    16.883255249995273,
    17.048151208990021,
    17.222905458998866,
    17.393072624981869,
    17.545148208999308,
    17.731778999994276,
    17.895055667002453,
    18.053794833977008,
    18.262034666986438,
    18.452045458980137,
    18.652555541979382,
    18.837819209002191,
    19.035942041984526,
    19.218124583974713,
    19.374735374993179,
    19.539791374991182,
    19.75093174999347,
    19.95091266700183,
    20.126775916985935,
    20.29684387499583,
    20.456203708978137,
    20.622442749998299,
    20.784247958974447,
    20.968621916981647,
    21.136663374985801,
    21.310621833981713,
    21.514108541974565,
    21.734247708984185,
    21.927205333980964,
    22.094661958981305,
    22.274348916980671,
    22.450436708983034,
    22.622961583983852,
    22.774924416997237,
    22.968096791999415,
    23.12341749999905,
    23.306477666978026,
    23.477578833990265,
    23.647514999989653,
    23.870474999974249,
    24.082149333989946,
    24.264430624985835,
    24.443752624996705,
    24.630621291988064,
    24.809077208978124,
    25.00039033399662,
    25.170164499984821,
    25.359083124989411,
    25.563995584001532,
    25.763153458974557,
    25.939020333986264,
    26.095737999974517,
    26.277994791977108,
    26.464174875000026,
    26.670355041977018,
    26.854023666994181
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 25194053632,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.26939999999012798,
    0.20570145899546333,
    0.19491354099591263,
    0.18825624999590218,
    0.18482875000336207,
    0.18924900001729839,
    0.20371662499383092,
    0.18994658399606124,
    0.19763491599587724,
    0.18203970900503919,
    0.16263229100150056,
    0.18049716699169949,
    0.16224187499028631,
    0.19383691702387296,
    0.15764629098703153,
    0.14409225000417791,
    0.17977191699901596,
    0.1770065420132596,
    0.20450204098597169,
    0.18942304200027138,
    0.17645133301266469,
    0.18512920898501761,
    0.19765024998923764,
    0.22270325000863522,
    0.19663074999698438,
    0.18297054100548849,
    0.18645058400579728,
    0.22721912499400787,
    0.20351870800368488,
    0.20445441699121147,
    0.17993370801559649,
    0.21168412498082034,
    0.19903262500884011,
    0.19163637500605546,
    0.19867841698578559,
    0.20002308301627636,
    0.20388824999099597,
    0.19867579199490137,
    0.18838558299466968,
    0.1837427920254413,
    0.21002320799743757,
    0.21862637498998083,
    0.2017491250007879,
    0.18257249999442138,
    0.2251461670093704,
    0.22094191599171609,
    0.20831541699590161,
    0.19767837499966845,
    0.17075066702091135,
    0.18608374998439103,
    0.1861169160110876,
    0.19110695898416452,
    0.18610312501550652,
    0.17625658298493363,
    0.2261365830199793,
    0.19507370897918008,
    0.20461850002175197,
    0.18374362497706898,
    0.18869045801693574,
    0.21198024999466725,
    0.20149045798461884,
    0.20311316702282056,
    0.18395108298864216,
    0.2224300840171054,
    0.17757254099706188,
    0.21171279199188575,
    0.21501325001008809,
    0.18923883297247812,
    0.18039891700027511,
    0.20279787501203828,
    0.18366195799899288,
    0.17963150001014583,
    0.16489595899474807,
    0.1747542500088457,
    0.17016716598300263,
    0.15207558401743881,
    0.18663079099496827,
    0.16327666700817645,
    0.1587391669745557,
    0.20823983300942928,
    0.19001079199369997,
    0.20051008299924433,
    0.18526366702280939,
    0.19812283298233524,
    0.18218254199018702,
    0.15661079101846553,
    0.16505599999800324,
    0.21114037500228733,
    0.19998091700836085,
    0.17586324998410419,
    0.17006795800989494,
    0.15935983398230746,
    0.1662390410201624,
    0.1618052089761477,
    0.18437395800719969,
    0.16804145800415426,
    0.17395845899591222,
    0.20348670799285173,
    0.22013916700962,
    0.19295762499677949,
    0.16745662500034086,
    0.1796869579993654,
    0.17608779200236313,
    0.1725248750008177,
    0.15196283301338553,
    0.19317237500217743,
    0.15532070799963549,
    0.18306016697897576,
    0.17110116701223888,
    0.16993616599938832,
    0.22295999998459592,
    0.21167433401569724,
    0.18228129099588841,
    0.1793220000108704,
    0.18686866699135862,
    0.17845591699006036,
    0.19131312501849607,
    0.16977416598820128,
    0.18891862500458956,
    0.20491245901212096,
    0.19915787497302517,
    0.17586687501170672,
    0.15671766598825343,
    0.18225679200259037,
    0.18618008302291855,
    0.20618016697699204,
    0.18366862501716241
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.496278625010746,
  "metadata_seconds" : 0.13437062498996966,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7723374616,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 26.85404079197906,
  "request_vm_after" : {
    "reclaimableBytes" : 17239179264,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17319231488,
    "swapins" : 28,
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
  "ttft_seconds" : 2.8643325000011828,
  "uncached_expert_files" : 9,
  "validation_receipt_sha256" : "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-1-uncached-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v2/round-2-uncached-admission.json

Original bytes: 17280. SHA-256: `43b560ac1af4351dd3b08cf5ca8925c36341f2478cf56b84ec88db80a7c133e6`.

Normalized bytes: 17280. SHA-256: `43b560ac1af4351dd3b08cf5ca8925c36341f2478cf56b84ec88db80a7c133e6`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.008735665993299335,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24974262272,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23974920192,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   456845.\nPages active:                                 883553.\nPages inactive:                               836840.\nPages speculative:                             61126.\nPages throttled:                                   0.\nPages wired down:                             170686.\nPages purgeable:                                6590.\n\"Translation faults\":                     1932520676.\nPages copy-on-write:                        96531387.\nPages zero filled:                        3159052239.\nPages reactivated:                         172817416.\nPages purged:                               12594414.\nFile-backed pages:                            999878.\nAnonymous pages:                              781641.\nPages stored in compressor:                  1242525.\nPages occupied by compressor:                 675694.\nDecompressions:                             98129334.\nCompressions:                              111434465.\nPageins:                                  2177552901.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129059.\nPages tagged resident:                         88420.\nPages tagged compressed:                       40639.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          898.\nPages tag-storage non-tag pageable:            91456.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6036672.\nTagged compressions:                          716612.\nTagged decompressions:                        591317.\n"
      }
    },
    {
      "elapsed_seconds": 5.039277165982639,
      "stable_seconds": 5.03054149998934,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24823988224,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23821254656,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   447368.\nPages active:                                 891339.\nPages inactive:                               831735.\nPages speculative:                             61243.\nPages throttled:                                   0.\nPages wired down:                             180153.\nPages purgeable:                                6484.\n\"Translation faults\":                     1932550186.\nPages copy-on-write:                        96535584.\nPages zero filled:                        3159072031.\nPages reactivated:                         172817520.\nPages purged:                               12594419.\nFile-backed pages:                           1000082.\nAnonymous pages:                              784235.\nPages stored in compressor:                  1236054.\nPages occupied by compressor:                 673516.\nDecompressions:                             98135007.\nCompressions:                              111434465.\nPageins:                                  2177553071.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129058.\nPages tagged resident:                         88419.\nPages tagged compressed:                       40639.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          442.\nPages tag-storage non-tag pageable:            91912.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6036672.\nTagged compressions:                          716612.\nTagged decompressions:                        591317.\n"
      }
    },
    {
      "elapsed_seconds": 10.070252790988889,
      "stable_seconds": 10.06151712499559,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24829952000,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23827087360,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   451545.\nPages active:                                 884971.\nPages inactive:                               833052.\nPages speculative:                             61269.\nPages throttled:                                   0.\nPages wired down:                             181084.\nPages purgeable:                                2644.\n\"Translation faults\":                     1932553644.\nPages copy-on-write:                        96535947.\nPages zero filled:                        3159074320.\nPages reactivated:                         172817529.\nPages purged:                               12594419.\nFile-backed pages:                           1000101.\nAnonymous pages:                              779191.\nPages stored in compressor:                  1235691.\nPages occupied by compressor:                 673430.\nDecompressions:                             98135089.\nCompressions:                              111434465.\nPageins:                                  2177553075.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128957.\nPages tagged resident:                         88318.\nPages tagged compressed:                       40639.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          401.\nPages tag-storage non-tag pageable:            91953.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6036672.\nTagged compressions:                          716612.\nTagged decompressions:                        591317.\n"
      }
    },
    {
      "elapsed_seconds": 15.101183999999193,
      "stable_seconds": 15.092448334005894,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24864161792,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23862902784,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   450691.\nPages active:                                 893913.\nPages inactive:                               835133.\nPages speculative:                             61452.\nPages throttled:                                   0.\nPages wired down:                             171320.\nPages purgeable:                                5242.\n\"Translation faults\":                     1932582466.\nPages copy-on-write:                        96537849.\nPages zero filled:                        3159085520.\nPages reactivated:                         172817531.\nPages purged:                               12594675.\nFile-backed pages:                           1000543.\nAnonymous pages:                              789955.\nPages stored in compressor:                  1234845.\nPages occupied by compressor:                 672862.\nDecompressions:                             98135585.\nCompressions:                              111434465.\nPageins:                                  2177553426.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128925.\nPages tagged resident:                         88288.\nPages tagged compressed:                       40637.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          433.\nPages tag-storage non-tag pageable:            91921.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6036544.\nTagged compressions:                          716612.\nTagged decompressions:                        591319.\n"
      }
    },
    {
      "elapsed_seconds": 20.127991707995534,
      "stable_seconds": 20.119256042002235,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24846696448,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23832182784,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   443379.\nPages active:                                 898253.\nPages inactive:                               837638.\nPages speculative:                             61837.\nPages throttled:                                   0.\nPages wired down:                             171358.\nPages purgeable:                               10201.\n\"Translation faults\":                     1932589375.\nPages copy-on-write:                        96538476.\nPages zero filled:                        3159098444.\nPages reactivated:                         172817531.\nPages purged:                               12594675.\nFile-backed pages:                           1001021.\nAnonymous pages:                              796707.\nPages stored in compressor:                  1234576.\nPages occupied by compressor:                 672785.\nDecompressions:                             98135834.\nCompressions:                              111434465.\nPageins:                                  2177553765.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128983.\nPages tagged resident:                         88352.\nPages tagged compressed:                       40631.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          450.\nPages tag-storage non-tag pageable:            91904.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6035200.\nTagged compressions:                          716612.\nTagged decompressions:                        591325.\n"
      }
    },
    {
      "elapsed_seconds": 25.158283540979028,
      "stable_seconds": 25.14954787498573,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24774901760,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23762567168,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   446036.\nPages active:                                 889027.\nPages inactive:                               834354.\nPages speculative:                             61846.\nPages throttled:                                   0.\nPages wired down:                             181120.\nPages purgeable:                                3293.\n\"Translation faults\":                     1932594091.\nPages copy-on-write:                        96538801.\nPages zero filled:                        3159102774.\nPages reactivated:                         172817531.\nPages purged:                               12594675.\nFile-backed pages:                           1001023.\nAnonymous pages:                              784204.\nPages stored in compressor:                  1234516.\nPages occupied by compressor:                 672766.\nDecompressions:                             98135903.\nCompressions:                              111434465.\nPageins:                                  2177553775.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129050.\nPages tagged resident:                         88424.\nPages tagged compressed:                       40626.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          444.\nPages tag-storage non-tag pageable:            91910.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6034304.\nTagged compressions:                          716612.\nTagged decompressions:                        591330.\n"
      }
    },
    {
      "elapsed_seconds": 30.189063333004015,
      "stable_seconds": 30.180327667010715,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24779997184,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23765073920,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   447246.\nPages active:                                 888675.\nPages inactive:                               834134.\nPages speculative:                             61878.\nPages throttled:                                   0.\nPages wired down:                             181104.\nPages purgeable:                                1934.\n\"Translation faults\":                     1932621229.\nPages copy-on-write:                        96544828.\nPages zero filled:                        3159111511.\nPages reactivated:                         172817554.\nPages purged:                               12594931.\nFile-backed pages:                           1001325.\nAnonymous pages:                              783362.\nPages stored in compressor:                  1233559.\nPages occupied by compressor:                 672295.\nDecompressions:                             98136722.\nCompressions:                              111434465.\nPageins:                                  2177554052.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129003.\nPages tagged resident:                         88389.\nPages tagged compressed:                       40614.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          434.\nPages tag-storage non-tag pageable:            91920.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6031808.\nTagged compressions:                          716612.\nTagged decompressions:                        591342.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/round-2-uncached/receipt.json

Original bytes: 22109. SHA-256: `779c395f9ef96ebe98bbec9e9763a32f69eccc0007030d1187c54ee0a3b0c26f`.

Normalized bytes: 22109. SHA-256: `779c395f9ef96ebe98bbec9e9763a32f69eccc0007030d1187c54ee0a3b0c26f`.

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
  "committed_decode_tokens_per_second" : 5.3093543011278577,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.8423858750029467,
    3.1170130000100471,
    3.3242851250106469,
    3.528772250021575,
    3.7191007920191623,
    3.9076848750119098,
    4.099447875021724,
    4.305829208024079,
    4.4961842920165509,
    4.6902503330202308,
    4.8738795000244863,
    5.0379093750088941,
    5.217907833022764,
    5.3831884580140468,
    5.5761271250084974,
    5.7330936670186929,
    5.8760174170020036,
    6.0574849170225207,
    6.2387240420212038,
    6.445678542018868,
    6.6373654170020018,
    6.814282125007594,
    7.0007115000043996,
    7.1935995829990134,
    7.4018602500145789,
    7.5943598330195528,
    7.7774256670090836,
    7.95870983300847,
    8.1795484170143027,
    8.3725057080155239,
    8.5705266250006389,
    8.7396692500042263,
    8.9429915000218898,
    9.1315639170061331,
    9.3145264170016162,
    9.5090241670259275,
    9.6995900830079336,
    9.9049262920161709,
    10.104625833017053,
    10.292042500019306,
    10.476658625004347,
    10.689507083006902,
    10.9022859170218,
    11.102097542025149,
    11.286285958020017,
    11.510015125008067,
    11.732313000014983,
    11.938117625017185,
    12.137083875015378,
    12.306717625004239,
    12.500609292008448,
    12.678475583001273,
    12.865325167018455,
    13.053510583005846,
    13.22819975001039,
    13.454891792003764,
    13.654652583005372,
    13.861905375000788,
    14.047363458026666,
    14.235172875021817,
    14.445433333021356,
    14.648462042008759,
    14.850189667020459,
    15.03447020801832,
    15.254096208023839,
    15.430063292005798,
    15.641814833012177,
    15.856205292016966,
    16.046800208016066,
    16.228783042024588,
    16.436678167025093,
    16.631613375007873,
    16.808673083025496,
    16.974763375008479,
    17.151070250023622,
    17.320484083000338,
    17.473271250026301,
    17.659319750004215,
    17.821288750012172,
    17.978871416999027,
    18.186308792006457,
    18.380406042007962,
    18.586028458026703,
    18.767049833026249,
    18.963512167014414,
    19.14732216700213,
    19.30281350002042,
    19.469123542017769,
    19.678743249998661,
    19.877537833002862,
    20.04968141700374,
    20.219291292014532,
    20.38283404201502,
    20.547253374999855,
    20.708437583001796,
    20.889000583003508,
    21.057216583023546,
    21.226503583020531,
    21.427785750012845,
    21.651846708002267,
    21.841433917026734,
    22.007141208014218,
    22.182180792005965,
    22.353493292001076,
    22.520497417019214,
    22.674348166998243,
    22.867276667006081,
    23.027108375012176,
    23.207490708009573,
    23.371068458014634,
    23.536562207998941,
    23.761134083004436,
    23.969888958003139,
    24.152038125001127,
    24.335784333001357,
    24.525377875019331,
    24.706337708019419,
    24.897605542006204,
    25.07014516700292,
    25.258200500014937,
    25.465476500015939,
    25.670342417026404,
    25.845589417003794,
    26.002210292004747,
    26.180447582999477,
    26.37442791700596,
    26.57955758299795,
    26.762432042014552
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 24528388096,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.2746271250071004,
    0.20727212500059977,
    0.20448712501092814,
    0.19032854199758731,
    0.18858408299274743,
    0.19176300000981428,
    0.20638133300235495,
    0.19035508399247192,
    0.19406604100367986,
    0.18362916700425558,
    0.1640298749844078,
    0.17999845801386982,
    0.16528062499128282,
    0.19293866699445061,
    0.15696654201019555,
    0.1429237499833107,
    0.18146750002051704,
    0.18123912499868311,
    0.20695449999766424,
    0.19168687498313375,
    0.17691670800559223,
    0.18642937499680556,
    0.1928880829946138,
    0.20826066701556556,
    0.19249958300497383,
    0.1830658339895308,
    0.18128416599938646,
    0.22083858400583267,
    0.19295729100122117,
    0.19802091698511504,
    0.16914262500358745,
    0.20332225001766346,
    0.18857241698424332,
    0.18296249999548309,
    0.19449775002431124,
    0.19056591598200612,
    0.20533620900823735,
    0.19969954100088216,
    0.18741666700225323,
    0.1846161249850411,
    0.21284845800255425,
    0.21277883401489817,
    0.19981162500334904,
    0.18418841599486768,
    0.22372916698805057,
    0.222297875006916,
    0.20580462500220165,
    0.19896624999819323,
    0.16963374998886138,
    0.19389166700420901,
    0.17786629099282436,
    0.18684958401718177,
    0.18818541598739102,
    0.17468916700454429,
    0.226692041993374,
    0.1997607910016086,
    0.20725279199541546,
    0.1854580830258783,
    0.18780941699515097,
    0.21026045799953863,
    0.20302870898740366,
    0.20172762501169927,
    0.18428054099786095,
    0.21962600000551902,
    0.17596708398195915,
    0.21175154100637883,
    0.21439045900478959,
    0.19059491599909961,
    0.18198283400852233,
    0.20789512500050478,
    0.19493520798278041,
    0.17705970801762305,
    0.16609029198298231,
    0.17630687501514331,
    0.16941383297671564,
    0.15278716702596284,
    0.18604849997791462,
    0.16196900000795722,
    0.15758266698685475,
    0.20743737500743009,
    0.19409725000150502,
    0.20562241601874121,
    0.18102137499954551,
    0.19646233398816548,
    0.18380999998771586,
    0.15549133301828988,
    0.16631004199734889,
    0.20961970798089169,
    0.19879458300420083,
    0.17214358400087804,
    0.16960987501079217,
    0.16354275000048801,
    0.16441933298483491,
    0.16118420800194144,
    0.18056300000171177,
    0.16821600002003834,
    0.16928699999698438,
    0.20128216699231416,
    0.2240609579894226,
    0.18958720902446657,
    0.16570729098748416,
    0.17503958399174735,
    0.17131249999511056,
    0.16700412501813844,
    0.15385074997902848,
    0.19292850000783801,
    0.15983170800609514,
    0.18038233299739659,
    0.16357775000506081,
    0.16549374998430721,
    0.2245718750054948,
    0.2087548749987036,
    0.18214916699798778,
    0.18374620800022967,
    0.18959354201797396,
    0.18095983300008811,
    0.19126783398678526,
    0.17253962499671616,
    0.18805533301201649,
    0.2072760000010021,
    0.20486591701046564,
    0.17524699997738935,
    0.15662087500095367,
    0.17823729099472985,
    0.19398033400648274,
    0.2051296659919899,
    0.18287445901660249
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.292765249992954,
  "metadata_seconds" : 0.13316512500750832,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7722309656,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 26.762454292009352,
  "request_vm_after" : {
    "reclaimableBytes" : 16590438400,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17300275200,
    "swapins" : 28,
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
  "ttft_seconds" : 2.8423858750029467,
  "uncached_expert_files" : 9,
  "validation_receipt_sha256" : "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-2-uncached-supervision/identity.json

Original bytes: 3200. SHA-256: `62dd2b6ab61c7e2e8d55ee4ac1ff71a9d933112d42569def328555c2ea9d919b`.

Normalized bytes: 3144. SHA-256: `f62eb950410492f574857240ee7d6df18407e2b2fea7a19409dbb2094efad2e3`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/uncached-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/round-2-uncached",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-uncached/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23763304448,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   447137.\nPages active:                                 889737.\nPages inactive:                               834135.\nPages speculative:                             61878.\nPages throttled:                                   0.\nPages wired down:                             180037.\nPages purgeable:                                1934.\n\"Translation faults\":                     1932626393.\nPages copy-on-write:                        96545592.\nPages zero filled:                        3159113735.\nPages reactivated:                         172817554.\nPages purged:                               12594931.\nFile-backed pages:                           1001326.\nAnonymous pages:                              784424.\nPages stored in compressor:                  1233559.\nPages occupied by compressor:                 672295.\nDecompressions:                             98136746.\nCompressions:                              111434465.\nPageins:                                  2177554058.\nPageouts:                                     478847.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129003.\nPages tagged resident:                         88389.\nPages tagged compressed:                       40614.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5942.\nPages tag-storage free:                          434.\nPages tag-storage non-tag pageable:            91920.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6031808.\nTagged compressions:                          716612.\nTagged decompressions:                        591342.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/round-2-uncached-supervision/receipt.json

Original bytes: 2140. SHA-256: `b7f97d9fb6518374dcbec3f74c20d6ddff04bb719a4aaf67bc0806d40653b368`.

Normalized bytes: 2140. SHA-256: `b7f97d9fb6518374dcbec3f74c20d6ddff04bb719a4aaf67bc0806d40653b368`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7722309656,
  "samples": 1458,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22933045248,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   424453.\nPages active:                                 884681.\nPages inactive:                               848312.\nPages speculative:                             31045.\nPages throttled:                                   0.\nPages wired down:                             211808.\nPages purgeable:                                1509.\n\"Translation faults\":                     1933335159.\nPages copy-on-write:                        96571761.\nPages zero filled:                        3159764714.\nPages reactivated:                         172901573.\nPages purged:                               12602915.\nFile-backed pages:                            973760.\nAnonymous pages:                              790278.\nPages stored in compressor:                  1253648.\nPages occupied by compressor:                 683994.\nDecompressions:                             98289451.\nCompressions:                              111645377.\nPageins:                                  2187288017.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131894.\nPages tagged resident:                         90861.\nPages tagged compressed:                       41033.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5953.\nPages tag-storage free:                         1075.\nPages tag-storage non-tag pageable:            91268.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6081472.\nTagged compressions:                          717579.\nTagged decompressions:                        591887.\n"
  },
  "seconds": 85.30573395799729
}
````

### vq-uncached-expert-cost-v2/round-2-uncached-supervision/stdout.txt

Original bytes: 22110. SHA-256: `02ad6c822315e55a3b4f311d87779361494e84aa12f0a529c8c086fbab9a83af`.

Normalized bytes: 22110. SHA-256: `02ad6c822315e55a3b4f311d87779361494e84aa12f0a529c8c086fbab9a83af`.

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
  "committed_decode_tokens_per_second" : 5.3093543011278577,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.8423858750029467,
    3.1170130000100471,
    3.3242851250106469,
    3.528772250021575,
    3.7191007920191623,
    3.9076848750119098,
    4.099447875021724,
    4.305829208024079,
    4.4961842920165509,
    4.6902503330202308,
    4.8738795000244863,
    5.0379093750088941,
    5.217907833022764,
    5.3831884580140468,
    5.5761271250084974,
    5.7330936670186929,
    5.8760174170020036,
    6.0574849170225207,
    6.2387240420212038,
    6.445678542018868,
    6.6373654170020018,
    6.814282125007594,
    7.0007115000043996,
    7.1935995829990134,
    7.4018602500145789,
    7.5943598330195528,
    7.7774256670090836,
    7.95870983300847,
    8.1795484170143027,
    8.3725057080155239,
    8.5705266250006389,
    8.7396692500042263,
    8.9429915000218898,
    9.1315639170061331,
    9.3145264170016162,
    9.5090241670259275,
    9.6995900830079336,
    9.9049262920161709,
    10.104625833017053,
    10.292042500019306,
    10.476658625004347,
    10.689507083006902,
    10.9022859170218,
    11.102097542025149,
    11.286285958020017,
    11.510015125008067,
    11.732313000014983,
    11.938117625017185,
    12.137083875015378,
    12.306717625004239,
    12.500609292008448,
    12.678475583001273,
    12.865325167018455,
    13.053510583005846,
    13.22819975001039,
    13.454891792003764,
    13.654652583005372,
    13.861905375000788,
    14.047363458026666,
    14.235172875021817,
    14.445433333021356,
    14.648462042008759,
    14.850189667020459,
    15.03447020801832,
    15.254096208023839,
    15.430063292005798,
    15.641814833012177,
    15.856205292016966,
    16.046800208016066,
    16.228783042024588,
    16.436678167025093,
    16.631613375007873,
    16.808673083025496,
    16.974763375008479,
    17.151070250023622,
    17.320484083000338,
    17.473271250026301,
    17.659319750004215,
    17.821288750012172,
    17.978871416999027,
    18.186308792006457,
    18.380406042007962,
    18.586028458026703,
    18.767049833026249,
    18.963512167014414,
    19.14732216700213,
    19.30281350002042,
    19.469123542017769,
    19.678743249998661,
    19.877537833002862,
    20.04968141700374,
    20.219291292014532,
    20.38283404201502,
    20.547253374999855,
    20.708437583001796,
    20.889000583003508,
    21.057216583023546,
    21.226503583020531,
    21.427785750012845,
    21.651846708002267,
    21.841433917026734,
    22.007141208014218,
    22.182180792005965,
    22.353493292001076,
    22.520497417019214,
    22.674348166998243,
    22.867276667006081,
    23.027108375012176,
    23.207490708009573,
    23.371068458014634,
    23.536562207998941,
    23.761134083004436,
    23.969888958003139,
    24.152038125001127,
    24.335784333001357,
    24.525377875019331,
    24.706337708019419,
    24.897605542006204,
    25.07014516700292,
    25.258200500014937,
    25.465476500015939,
    25.670342417026404,
    25.845589417003794,
    26.002210292004747,
    26.180447582999477,
    26.37442791700596,
    26.57955758299795,
    26.762432042014552
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 24528388096,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.2746271250071004,
    0.20727212500059977,
    0.20448712501092814,
    0.19032854199758731,
    0.18858408299274743,
    0.19176300000981428,
    0.20638133300235495,
    0.19035508399247192,
    0.19406604100367986,
    0.18362916700425558,
    0.1640298749844078,
    0.17999845801386982,
    0.16528062499128282,
    0.19293866699445061,
    0.15696654201019555,
    0.1429237499833107,
    0.18146750002051704,
    0.18123912499868311,
    0.20695449999766424,
    0.19168687498313375,
    0.17691670800559223,
    0.18642937499680556,
    0.1928880829946138,
    0.20826066701556556,
    0.19249958300497383,
    0.1830658339895308,
    0.18128416599938646,
    0.22083858400583267,
    0.19295729100122117,
    0.19802091698511504,
    0.16914262500358745,
    0.20332225001766346,
    0.18857241698424332,
    0.18296249999548309,
    0.19449775002431124,
    0.19056591598200612,
    0.20533620900823735,
    0.19969954100088216,
    0.18741666700225323,
    0.1846161249850411,
    0.21284845800255425,
    0.21277883401489817,
    0.19981162500334904,
    0.18418841599486768,
    0.22372916698805057,
    0.222297875006916,
    0.20580462500220165,
    0.19896624999819323,
    0.16963374998886138,
    0.19389166700420901,
    0.17786629099282436,
    0.18684958401718177,
    0.18818541598739102,
    0.17468916700454429,
    0.226692041993374,
    0.1997607910016086,
    0.20725279199541546,
    0.1854580830258783,
    0.18780941699515097,
    0.21026045799953863,
    0.20302870898740366,
    0.20172762501169927,
    0.18428054099786095,
    0.21962600000551902,
    0.17596708398195915,
    0.21175154100637883,
    0.21439045900478959,
    0.19059491599909961,
    0.18198283400852233,
    0.20789512500050478,
    0.19493520798278041,
    0.17705970801762305,
    0.16609029198298231,
    0.17630687501514331,
    0.16941383297671564,
    0.15278716702596284,
    0.18604849997791462,
    0.16196900000795722,
    0.15758266698685475,
    0.20743737500743009,
    0.19409725000150502,
    0.20562241601874121,
    0.18102137499954551,
    0.19646233398816548,
    0.18380999998771586,
    0.15549133301828988,
    0.16631004199734889,
    0.20961970798089169,
    0.19879458300420083,
    0.17214358400087804,
    0.16960987501079217,
    0.16354275000048801,
    0.16441933298483491,
    0.16118420800194144,
    0.18056300000171177,
    0.16821600002003834,
    0.16928699999698438,
    0.20128216699231416,
    0.2240609579894226,
    0.18958720902446657,
    0.16570729098748416,
    0.17503958399174735,
    0.17131249999511056,
    0.16700412501813844,
    0.15385074997902848,
    0.19292850000783801,
    0.15983170800609514,
    0.18038233299739659,
    0.16357775000506081,
    0.16549374998430721,
    0.2245718750054948,
    0.2087548749987036,
    0.18214916699798778,
    0.18374620800022967,
    0.18959354201797396,
    0.18095983300008811,
    0.19126783398678526,
    0.17253962499671616,
    0.18805533301201649,
    0.2072760000010021,
    0.20486591701046564,
    0.17524699997738935,
    0.15662087500095367,
    0.17823729099472985,
    0.19398033400648274,
    0.2051296659919899,
    0.18287445901660249
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.292765249992954,
  "metadata_seconds" : 0.13316512500750832,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7722309656,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 26.762454292009352,
  "request_vm_after" : {
    "reclaimableBytes" : 16590438400,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17300275200,
    "swapins" : 28,
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
  "ttft_seconds" : 2.8423858750029467,
  "uncached_expert_files" : 9,
  "validation_receipt_sha256" : "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-2-uncached-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v2/round-2-buffered-admission.json

Original bytes: 17281. SHA-256: `3f4627c735932879d44dfc57e4c969b9ca9d26a2a09ba30a3dd6c5f373cc9026`.

Normalized bytes: 17281. SHA-256: `3f4627c735932879d44dfc57e4c969b9ca9d26a2a09ba30a3dd6c5f373cc9026`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.008845458010910079,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 16590438400,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23711858688,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   458502.\nPages active:                                 867164.\nPages inactive:                               862943.\nPages speculative:                             31039.\nPages throttled:                                   0.\nPages wired down:                             180811.\nPages purgeable:                                1509.\n\"Translation faults\":                     1933336862.\nPages copy-on-write:                        96572039.\nPages zero filled:                        3159764869.\nPages reactivated:                         172901573.\nPages purged:                               12602915.\nFile-backed pages:                            987246.\nAnonymous pages:                              773900.\nPages stored in compressor:                  1253646.\nPages occupied by compressor:                 683994.\nDecompressions:                             98289461.\nCompressions:                              111645377.\nPageins:                                  2187301327.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131874.\nPages tagged resident:                         90841.\nPages tagged compressed:                       41033.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5953.\nPages tag-storage free:                         1063.\nPages tag-storage non-tag pageable:            91280.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6081472.\nTagged compressions:                          717579.\nTagged decompressions:                        591887.\n"
      }
    },
    {
      "elapsed_seconds": 5.041226750006899,
      "stable_seconds": 5.032381291995989,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24309727232,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23798677504,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   457869.\nPages active:                                 876454.\nPages inactive:                               863560.\nPages speculative:                             31322.\nPages throttled:                                   0.\nPages wired down:                             172083.\nPages purgeable:                                6967.\n\"Translation faults\":                     1933346568.\nPages copy-on-write:                        96572693.\nPages zero filled:                        3159769691.\nPages reactivated:                         172901579.\nPages purged:                               12602915.\nFile-backed pages:                            987720.\nAnonymous pages:                              783616.\nPages stored in compressor:                  1253187.\nPages occupied by compressor:                 683871.\nDecompressions:                             98289645.\nCompressions:                              111645377.\nPageins:                                  2187301542.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131838.\nPages tagged resident:                         90806.\nPages tagged compressed:                       41032.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          517.\nPages tag-storage non-tag pageable:            91828.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6081088.\nTagged compressions:                          717579.\nTagged decompressions:                        591888.\n"
      }
    },
    {
      "elapsed_seconds": 10.072225917014293,
      "stable_seconds": 10.063380459003383,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24321048576,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23805968384,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   458977.\nPages active:                                 876963.\nPages inactive:                               861976.\nPages speculative:                             31369.\nPages throttled:                                   0.\nPages wired down:                             172033.\nPages purgeable:                                6245.\n\"Translation faults\":                     1933357547.\nPages copy-on-write:                        96573876.\nPages zero filled:                        3159771397.\nPages reactivated:                         172901656.\nPages purged:                               12602930.\nFile-backed pages:                            987779.\nAnonymous pages:                              782529.\nPages stored in compressor:                  1252864.\nPages occupied by compressor:                 683813.\nDecompressions:                             98289733.\nCompressions:                              111645377.\nPageins:                                  2187301586.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131838.\nPages tagged resident:                         90806.\nPages tagged compressed:                       41032.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          354.\nPages tag-storage non-tag pageable:            91991.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6081088.\nTagged compressions:                          717579.\nTagged decompressions:                        591888.\n"
      }
    },
    {
      "elapsed_seconds": 15.106198499997845,
      "stable_seconds": 15.097353041986935,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 24229101568,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23713939456,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   457838.\nPages active:                                 867908.\nPages inactive:                               862307.\nPages speculative:                             31476.\nPages throttled:                                   0.\nPages wired down:                             181786.\nPages purgeable:                                1644.\n\"Translation faults\":                     1933361160.\nPages copy-on-write:                        96574238.\nPages zero filled:                        3159776327.\nPages reactivated:                         172901656.\nPages purged:                               12602930.\nFile-backed pages:                            987902.\nAnonymous pages:                              773789.\nPages stored in compressor:                  1252692.\nPages occupied by compressor:                 683774.\nDecompressions:                             98289844.\nCompressions:                              111645377.\nPageins:                                  2187301605.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131815.\nPages tagged resident:                         90790.\nPages tagged compressed:                       41025.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          350.\nPages tag-storage non-tag pageable:            91995.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6080000.\nTagged compressions:                          717579.\nTagged decompressions:                        591895.\n"
      }
    },
    {
      "elapsed_seconds": 20.13698245800333,
      "stable_seconds": 20.12813699999242,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 23902732288,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23386177536,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   437489.\nPages active:                                 889625.\nPages inactive:                               863962.\nPages speculative:                             31592.\nPages throttled:                                   0.\nPages wired down:                             189697.\nPages purgeable:                                1636.\n\"Translation faults\":                     1933426399.\nPages copy-on-write:                        96574742.\nPages zero filled:                        3159808254.\nPages reactivated:                         172901656.\nPages purged:                               12602930.\nFile-backed pages:                            988254.\nAnonymous pages:                              796925.\nPages stored in compressor:                  1230831.\nPages occupied by compressor:                 672597.\nDecompressions:                             98310013.\nCompressions:                              111645377.\nPageins:                                  2187301923.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131815.\nPages tagged resident:                         90790.\nPages tagged compressed:                       41025.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          613.\nPages tag-storage non-tag pageable:            91732.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6080000.\nTagged compressions:                          717579.\nTagged decompressions:                        591895.\n"
      }
    },
    {
      "elapsed_seconds": 25.163662167004077,
      "stable_seconds": 25.154816708993167,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 23972790272,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23455956992,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   436868.\nPages active:                                 898263.\nPages inactive:                               869114.\nPages speculative:                             31607.\nPages throttled:                                   0.\nPages wired down:                             180684.\nPages purgeable:                                6505.\n\"Translation faults\":                     1933444191.\nPages copy-on-write:                        96575105.\nPages zero filled:                        3159811037.\nPages reactivated:                         172901665.\nPages purged:                               12602930.\nFile-backed pages:                            988265.\nAnonymous pages:                              810719.\nPages stored in compressor:                  1222838.\nPages occupied by compressor:                 668487.\nDecompressions:                             98317844.\nCompressions:                              111645377.\nPageins:                                  2187301932.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131814.\nPages tagged resident:                         90790.\nPages tagged compressed:                       41024.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          732.\nPages tag-storage non-tag pageable:            91613.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6079936.\nTagged compressions:                          717579.\nTagged decompressions:                        591896.\n"
      }
    },
    {
      "elapsed_seconds": 30.194025500008138,
      "stable_seconds": 30.185180041997228,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 23986307072,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 23465771008,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   439960.\nPages active:                                 895785.\nPages inactive:                               868197.\nPages speculative:                             31834.\nPages throttled:                                   0.\nPages wired down:                             180612.\nPages purgeable:                                3705.\n\"Translation faults\":                     1933471080.\nPages copy-on-write:                        96581003.\nPages zero filled:                        3159817698.\nPages reactivated:                         172901671.\nPages purged:                               12602930.\nFile-backed pages:                            988572.\nAnonymous pages:                              807244.\nPages stored in compressor:                  1222801.\nPages occupied by compressor:                 668473.\nDecompressions:                             98317890.\nCompressions:                              111645377.\nPageins:                                  2187302066.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131777.\nPages tagged resident:                         90753.\nPages tagged compressed:                       41024.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          713.\nPages tag-storage non-tag pageable:            91632.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6079936.\nTagged compressions:                          717579.\nTagged decompressions:                        591896.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/round-2-buffered/receipt.json

Original bytes: 22092. SHA-256: `6aa972114c7e5b2e7cc1aae04b84d7d96ad3c00109b0915e12ae73ce8f692b31`.

Normalized bytes: 22092. SHA-256: `6aa972114c7e5b2e7cc1aae04b84d7d96ad3c00109b0915e12ae73ce8f692b31`.

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
  "committed_decode_tokens_per_second" : 5.776144058850659,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.984464291977929,
    3.3590389169985428,
    3.5527771670022048,
    3.7362759169773199,
    3.9105931669764686,
    4.0843091669958085,
    4.2555672499875072,
    4.4470540839829482,
    4.6212837089842651,
    4.8016659589775372,
    4.9685259169782512,
    5.1233529589953832,
    5.2858537919819355,
    5.4375959589960985,
    5.6214480419876054,
    5.7717943339957856,
    5.9113153340003919,
    6.0784827089810278,
    6.2394906249828637,
    6.4304111669771373,
    6.6089536669896916,
    6.7722305420029443,
    6.9425127919821534,
    7.1234532090020366,
    7.3122432499949355,
    7.4899573749862611,
    7.6571216250013094,
    7.8340610839950386,
    8.0469613749883138,
    8.240022333979141,
    8.423790792003274,
    8.587064166989876,
    8.7808284169877879,
    8.9562777089886367,
    9.127372374990955,
    9.3074090419977438,
    9.4939473339763936,
    9.7016897499852348,
    9.8873258749954402,
    10.056351709004957,
    10.223084458993981,
    10.421959375002189,
    10.61494566698093,
    10.799143833981361,
    10.964096041978337,
    11.168095458997414,
    11.372741833998589,
    11.558524083986413,
    11.72978041699389,
    11.892848249990493,
    12.056387624994386,
    12.225120583985699,
    12.394753624976147,
    12.557673834002344,
    12.723263124993537,
    12.928825374983717,
    13.107045249984367,
    13.28824304198497,
    13.450177124992479,
    13.61423645899049,
    13.806947249977384,
    13.983157749986276,
    14.167204375000438,
    14.33543137498782,
    14.540569124976173,
    14.702359291986795,
    14.893586541991681,
    15.085863333981251,
    15.251505166990682,
    15.415558958979091,
    15.599555041990243,
    15.770939541980624,
    15.934133125003427,
    16.094208541995613,
    16.254694333998486,
    16.40607033399283,
    16.549144083983265,
    16.719803208980011,
    16.878492666990496,
    17.023757166985888,
    17.203032333985902,
    17.377614666998852,
    17.562154833984096,
    17.732042291987455,
    17.911080249992665,
    18.075678374996642,
    18.221461416978855,
    18.375405291997595,
    18.562065541977063,
    18.743311166996136,
    18.898849333985709,
    19.054811874986626,
    19.203778708993923,
    19.35314500000095,
    19.50522954200278,
    19.674829083989607,
    19.826766583981225,
    19.984119624976302,
    20.16225654198206,
    20.363888708990999,
    20.536671416979516,
    20.696020292001776,
    20.863634583976818,
    21.025135542004136,
    21.184164541977225,
    21.328515917004552,
    21.496961750002811,
    21.642582999978913,
    21.800093416997697,
    21.954606749990489,
    22.10684120899532,
    22.304992083983961,
    22.494729708996601,
    22.657142374984687,
    22.818299042002764,
    22.984717374987667,
    23.14226924997638,
    23.317090291995555,
    23.474653874989599,
    23.641327791992808,
    23.826228791993344,
    24.004958791978424,
    24.161937166994903,
    24.307932750001783,
    24.469769166986225,
    24.630566916981479,
    24.811638208979275,
    24.971450541983359
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
    "reclaimableBytes" : 23738630144,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.37457462502061389,
    0.19373825000366196,
    0.18349874997511506,
    0.17431724999914877,
    0.17371600001933984,
    0.17125808299169876,
    0.19148683399544097,
    0.17422962500131689,
    0.18038224999327213,
    0.16685995800071396,
    0.15482704201713204,
    0.16250083298655227,
    0.15174216701416299,
    0.1838520829915069,
    0.15034629200818017,
    0.13952100000460632,
    0.16716737498063594,
    0.16100791600183584,
    0.19092054199427366,
    0.17854250001255423,
    0.16327687501325272,
    0.17028224997920915,
    0.18094041701988317,
    0.18879004099289887,
    0.17771412499132566,
    0.16716425001504831,
    0.1769394589937292,
    0.21290029099327512,
    0.1930609589908272,
    0.183768458024133,
    0.16327337498660199,
    0.19376424999791197,
    0.1754492920008488,
    0.17109466600231826,
    0.18003666700678878,
    0.1865382919786498,
    0.20774241600884125,
    0.18563612501020543,
    0.16902583400951698,
    0.16673274998902343,
    0.19887491600820795,
    0.19298629197874106,
    0.18419816700043157,
    0.16495220799697563,
    0.20399941701907665,
    0.20464637500117533,
    0.18578224998782389,
    0.17125633300747722,
    0.1630678329966031,
    0.16353937500389293,
    0.16873295899131335,
    0.16963304099044763,
    0.16292020902619697,
    0.16558929099119268,
    0.20556224999018013,
    0.17821987500065006,
    0.18119779200060293,
    0.16193408300750889,
    0.16405933399801143,
    0.1927107909868937,
    0.17621050000889227,
    0.18404662501416169,
    0.16822699998738244,
    0.20513774998835288,
    0.1617901670106221,
    0.19122725000488572,
    0.19227679198957048,
    0.16564183300943114,
    0.16405379198840819,
    0.18399608301115222,
    0.1713844999903813,
    0.16319358302280307,
    0.16007541699218564,
    0.1604857920028735,
    0.15137599999434315,
    0.14307374999043532,
    0.17065912499674596,
    0.1586894580104854,
    0.14526449999539182,
    0.17927516700001433,
    0.17458233301294968,
    0.18454016698524356,
    0.16988745800335892,
    0.17903795800521038,
    0.16459812500397675,
    0.14578304198221304,
    0.15394387501874007,
    0.18666024997946806,
    0.18124562501907349,
    0.15553816698957235,
    0.15596254100091755,
    0.14896683400729671,
    0.14936629100702703,
    0.15208454200183041,
    0.16959954198682681,
    0.1519374999916181,
    0.1573530409950763,
    0.17813691700575873,
    0.20163216700893827,
    0.17278270798851736,
    0.15934887502226047,
    0.16761429197504185,
    0.16150095802731812,
    0.1590289999730885,
    0.14435137502732687,
    0.16844583299825899,
    0.14562124997610226,
    0.15751041701878421,
    0.15451333299279213,
    0.15223445900483057,
    0.19815087498864159,
    0.18973762501263991,
    0.16241266598808579,
    0.1611566670180764,
    0.16641833298490383,
    0.15755187498871237,
    0.17482104201917537,
    0.15756358299404383,
    0.16667391700320877,
    0.18490100000053644,
    0.17872999998508021,
    0.15697837501647882,
    0.14599558300687931,
    0.16183641698444262,
    0.16079774999525398,
    0.18107129199779592,
    0.15981233300408348
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.219731874996796,
  "metadata_seconds" : 0.13482608401682228,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7731222600,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 24.971471625001868,
  "request_vm_after" : {
    "reclaimableBytes" : 17885413376,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17559420928,
    "swapins" : 28,
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
  "ttft_seconds" : 2.984464291977929,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-2-buffered-supervision/identity.json

Original bytes: 3200. SHA-256: `a32d4c85065f70b2559f528568b4e06ddb6e1ec3e74d6a5d4e07e6280b2370a4`.

Normalized bytes: 3144. SHA-256: `86462f09632302ea8eda264e99dea4d2314467aae2d3163595fddf5c074c0ebf`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/buffered-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/round-2-buffered",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-buffered/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23463673856,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   439847.\nPages active:                                 895785.\nPages inactive:                               868198.\nPages speculative:                             31834.\nPages throttled:                                   0.\nPages wired down:                             180612.\nPages purgeable:                                3689.\n\"Translation faults\":                     1933476264.\nPages copy-on-write:                        96581766.\nPages zero filled:                        3159819945.\nPages reactivated:                         172901671.\nPages purged:                               12602930.\nFile-backed pages:                            988573.\nAnonymous pages:                              807244.\nPages stored in compressor:                  1222801.\nPages occupied by compressor:                 668473.\nDecompressions:                             98317914.\nCompressions:                              111645377.\nPageins:                                  2187302072.\nPageouts:                                     479072.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 131777.\nPages tagged resident:                         90753.\nPages tagged compressed:                       41024.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5951.\nPages tag-storage free:                          716.\nPages tag-storage non-tag pageable:            91629.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6079936.\nTagged compressions:                          717579.\nTagged decompressions:                        591896.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/round-2-buffered-supervision/receipt.json

Original bytes: 2140. SHA-256: `ec6b60961660414154a6ab9db30ac464d5f714f81ffe6527b388e717e7a3037b`.

Normalized bytes: 2140. SHA-256: `ec6b60961660414154a6ab9db30ac464d5f714f81ffe6527b388e717e7a3037b`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7731222600,
  "samples": 1434,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24177278976,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   468891.\nPages active:                                 870085.\nPages inactive:                               795484.\nPages speculative:                             83520.\nPages throttled:                                   0.\nPages wired down:                             179866.\nPages purgeable:                                 102.\n\"Translation faults\":                     1934144311.\nPages copy-on-write:                        96601978.\nPages zero filled:                        3160363946.\nPages reactivated:                         173028389.\nPages purged:                               12609121.\nFile-backed pages:                           1006671.\nAnonymous pages:                              742418.\nPages stored in compressor:                  1262834.\nPages occupied by compressor:                 686070.\nDecompressions:                             98630003.\nCompressions:                              112038748.\nPageins:                                  2197729622.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128302.\nPages tagged resident:                         86011.\nPages tagged compressed:                       42291.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1774.\nPages tag-storage non-tag pageable:            90602.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6312128.\nTagged compressions:                          720628.\nTagged decompressions:                        593676.\n"
  },
  "seconds": 83.47636595799122
}
````

### vq-uncached-expert-cost-v2/round-2-buffered-supervision/stdout.txt

Original bytes: 22093. SHA-256: `a16e62032e9b233b0a83b8ff4af6bc45b307a86123e29676324d5c63d98bc918`.

Normalized bytes: 22093. SHA-256: `a16e62032e9b233b0a83b8ff4af6bc45b307a86123e29676324d5c63d98bc918`.

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
  "committed_decode_tokens_per_second" : 5.776144058850659,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.984464291977929,
    3.3590389169985428,
    3.5527771670022048,
    3.7362759169773199,
    3.9105931669764686,
    4.0843091669958085,
    4.2555672499875072,
    4.4470540839829482,
    4.6212837089842651,
    4.8016659589775372,
    4.9685259169782512,
    5.1233529589953832,
    5.2858537919819355,
    5.4375959589960985,
    5.6214480419876054,
    5.7717943339957856,
    5.9113153340003919,
    6.0784827089810278,
    6.2394906249828637,
    6.4304111669771373,
    6.6089536669896916,
    6.7722305420029443,
    6.9425127919821534,
    7.1234532090020366,
    7.3122432499949355,
    7.4899573749862611,
    7.6571216250013094,
    7.8340610839950386,
    8.0469613749883138,
    8.240022333979141,
    8.423790792003274,
    8.587064166989876,
    8.7808284169877879,
    8.9562777089886367,
    9.127372374990955,
    9.3074090419977438,
    9.4939473339763936,
    9.7016897499852348,
    9.8873258749954402,
    10.056351709004957,
    10.223084458993981,
    10.421959375002189,
    10.61494566698093,
    10.799143833981361,
    10.964096041978337,
    11.168095458997414,
    11.372741833998589,
    11.558524083986413,
    11.72978041699389,
    11.892848249990493,
    12.056387624994386,
    12.225120583985699,
    12.394753624976147,
    12.557673834002344,
    12.723263124993537,
    12.928825374983717,
    13.107045249984367,
    13.28824304198497,
    13.450177124992479,
    13.61423645899049,
    13.806947249977384,
    13.983157749986276,
    14.167204375000438,
    14.33543137498782,
    14.540569124976173,
    14.702359291986795,
    14.893586541991681,
    15.085863333981251,
    15.251505166990682,
    15.415558958979091,
    15.599555041990243,
    15.770939541980624,
    15.934133125003427,
    16.094208541995613,
    16.254694333998486,
    16.40607033399283,
    16.549144083983265,
    16.719803208980011,
    16.878492666990496,
    17.023757166985888,
    17.203032333985902,
    17.377614666998852,
    17.562154833984096,
    17.732042291987455,
    17.911080249992665,
    18.075678374996642,
    18.221461416978855,
    18.375405291997595,
    18.562065541977063,
    18.743311166996136,
    18.898849333985709,
    19.054811874986626,
    19.203778708993923,
    19.35314500000095,
    19.50522954200278,
    19.674829083989607,
    19.826766583981225,
    19.984119624976302,
    20.16225654198206,
    20.363888708990999,
    20.536671416979516,
    20.696020292001776,
    20.863634583976818,
    21.025135542004136,
    21.184164541977225,
    21.328515917004552,
    21.496961750002811,
    21.642582999978913,
    21.800093416997697,
    21.954606749990489,
    22.10684120899532,
    22.304992083983961,
    22.494729708996601,
    22.657142374984687,
    22.818299042002764,
    22.984717374987667,
    23.14226924997638,
    23.317090291995555,
    23.474653874989599,
    23.641327791992808,
    23.826228791993344,
    24.004958791978424,
    24.161937166994903,
    24.307932750001783,
    24.469769166986225,
    24.630566916981479,
    24.811638208979275,
    24.971450541983359
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
    "reclaimableBytes" : 23738630144,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.37457462502061389,
    0.19373825000366196,
    0.18349874997511506,
    0.17431724999914877,
    0.17371600001933984,
    0.17125808299169876,
    0.19148683399544097,
    0.17422962500131689,
    0.18038224999327213,
    0.16685995800071396,
    0.15482704201713204,
    0.16250083298655227,
    0.15174216701416299,
    0.1838520829915069,
    0.15034629200818017,
    0.13952100000460632,
    0.16716737498063594,
    0.16100791600183584,
    0.19092054199427366,
    0.17854250001255423,
    0.16327687501325272,
    0.17028224997920915,
    0.18094041701988317,
    0.18879004099289887,
    0.17771412499132566,
    0.16716425001504831,
    0.1769394589937292,
    0.21290029099327512,
    0.1930609589908272,
    0.183768458024133,
    0.16327337498660199,
    0.19376424999791197,
    0.1754492920008488,
    0.17109466600231826,
    0.18003666700678878,
    0.1865382919786498,
    0.20774241600884125,
    0.18563612501020543,
    0.16902583400951698,
    0.16673274998902343,
    0.19887491600820795,
    0.19298629197874106,
    0.18419816700043157,
    0.16495220799697563,
    0.20399941701907665,
    0.20464637500117533,
    0.18578224998782389,
    0.17125633300747722,
    0.1630678329966031,
    0.16353937500389293,
    0.16873295899131335,
    0.16963304099044763,
    0.16292020902619697,
    0.16558929099119268,
    0.20556224999018013,
    0.17821987500065006,
    0.18119779200060293,
    0.16193408300750889,
    0.16405933399801143,
    0.1927107909868937,
    0.17621050000889227,
    0.18404662501416169,
    0.16822699998738244,
    0.20513774998835288,
    0.1617901670106221,
    0.19122725000488572,
    0.19227679198957048,
    0.16564183300943114,
    0.16405379198840819,
    0.18399608301115222,
    0.1713844999903813,
    0.16319358302280307,
    0.16007541699218564,
    0.1604857920028735,
    0.15137599999434315,
    0.14307374999043532,
    0.17065912499674596,
    0.1586894580104854,
    0.14526449999539182,
    0.17927516700001433,
    0.17458233301294968,
    0.18454016698524356,
    0.16988745800335892,
    0.17903795800521038,
    0.16459812500397675,
    0.14578304198221304,
    0.15394387501874007,
    0.18666024997946806,
    0.18124562501907349,
    0.15553816698957235,
    0.15596254100091755,
    0.14896683400729671,
    0.14936629100702703,
    0.15208454200183041,
    0.16959954198682681,
    0.1519374999916181,
    0.1573530409950763,
    0.17813691700575873,
    0.20163216700893827,
    0.17278270798851736,
    0.15934887502226047,
    0.16761429197504185,
    0.16150095802731812,
    0.1590289999730885,
    0.14435137502732687,
    0.16844583299825899,
    0.14562124997610226,
    0.15751041701878421,
    0.15451333299279213,
    0.15223445900483057,
    0.19815087498864159,
    0.18973762501263991,
    0.16241266598808579,
    0.1611566670180764,
    0.16641833298490383,
    0.15755187498871237,
    0.17482104201917537,
    0.15756358299404383,
    0.16667391700320877,
    0.18490100000053644,
    0.17872999998508021,
    0.15697837501647882,
    0.14599558300687931,
    0.16183641698444262,
    0.16079774999525398,
    0.18107129199779592,
    0.15981233300408348
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.219731874996796,
  "metadata_seconds" : 0.13482608401682228,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7731222600,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 24.971471625001868,
  "request_vm_after" : {
    "reclaimableBytes" : 17885413376,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17559420928,
    "swapins" : 28,
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
  "ttft_seconds" : 2.984464291977929,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-2-buffered-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v2/round-3-buffered-admission.json

Original bytes: 17280. SHA-256: `035d7e500e9254ab77a15fac9032d6ad75ef23280b68d673314e033a21f2f7c7`.

Normalized bytes: 17280. SHA-256: `035d7e500e9254ab77a15fac9032d6ad75ef23280b68d673314e033a21f2f7c7`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.009193166974000633,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25549766656,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24183341056,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   455751.\nPages active:                                 869001.\nPages inactive:                               810057.\nPages speculative:                             83543.\nPages throttled:                                   0.\nPages wired down:                             179866.\nPages purgeable:                                 102.\n\"Translation faults\":                     1934146023.\nPages copy-on-write:                        96602262.\nPages zero filled:                        3160364103.\nPages reactivated:                         173028389.\nPages purged:                               12609121.\nFile-backed pages:                           1020181.\nAnonymous pages:                              742420.\nPages stored in compressor:                  1262829.\nPages occupied by compressor:                 686068.\nDecompressions:                             98630016.\nCompressions:                              112038748.\nPageins:                                  2197742954.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128302.\nPages tagged resident:                         86011.\nPages tagged compressed:                       42291.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1487.\nPages tag-storage non-tag pageable:            90889.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6312128.\nTagged compressions:                          720628.\nTagged decompressions:                        593676.\n"
      }
    },
    {
      "elapsed_seconds": 5.039918041991768,
      "stable_seconds": 5.030724875017768,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25538035712,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24167940096,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   454685.\nPages active:                                 871785.\nPages inactive:                               808917.\nPages speculative:                             83641.\nPages throttled:                                   0.\nPages wired down:                             179785.\nPages purgeable:                                 100.\n\"Translation faults\":                     1934152776.\nPages copy-on-write:                        96602759.\nPages zero filled:                        3160368614.\nPages reactivated:                         173028392.\nPages purged:                               12609121.\nFile-backed pages:                           1020309.\nAnonymous pages:                              744034.\nPages stored in compressor:                  1261950.\nPages occupied by compressor:                 685670.\nDecompressions:                             98630904.\nCompressions:                              112038748.\nPageins:                                  2197743015.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128187.\nPages tagged resident:                         85902.\nPages tagged compressed:                       42285.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          804.\nPages tag-storage non-tag pageable:            91572.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6311552.\nTagged compressions:                          720628.\nTagged decompressions:                        593682.\n"
      }
    },
    {
      "elapsed_seconds": 10.075191749987425,
      "stable_seconds": 10.065998583013425,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25591939072,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24219451392,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   452027.\nPages active:                                 883604.\nPages inactive:                               809021.\nPages speculative:                             83845.\nPages throttled:                                   0.\nPages wired down:                             171073.\nPages purgeable:                                5590.\n\"Translation faults\":                     1934166362.\nPages copy-on-write:                        96603626.\nPages zero filled:                        3160375139.\nPages reactivated:                         173028392.\nPages purged:                               12609121.\nFile-backed pages:                           1020621.\nAnonymous pages:                              755849.\nPages stored in compressor:                  1261065.\nPages occupied by compressor:                 685298.\nDecompressions:                             98631798.\nCompressions:                              112038748.\nPageins:                                  2197743063.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128227.\nPages tagged resident:                         86058.\nPages tagged compressed:                       42169.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          606.\nPages tag-storage non-tag pageable:            91770.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6279616.\nTagged compressions:                          720628.\nTagged decompressions:                        593798.\n"
      }
    },
    {
      "elapsed_seconds": 15.099704583000857,
      "stable_seconds": 15.090511416026857,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25574866944,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24195760128,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   451060.\nPages active:                                 884710.\nPages inactive:                               809305.\nPages speculative:                             83994.\nPages throttled:                                   0.\nPages wired down:                             171109.\nPages purgeable:                                4876.\n\"Translation faults\":                     1934184990.\nPages copy-on-write:                        96605085.\nPages zero filled:                        3160380212.\nPages reactivated:                         173028501.\nPages purged:                               12609121.\nFile-backed pages:                           1020856.\nAnonymous pages:                              757153.\nPages stored in compressor:                  1259871.\nPages occupied by compressor:                 684718.\nDecompressions:                             98632972.\nCompressions:                              112038748.\nPageins:                                  2197743191.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128263.\nPages tagged resident:                         86156.\nPages tagged compressed:                       42107.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          566.\nPages tag-storage non-tag pageable:            91810.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6264960.\nTagged compressions:                          720628.\nTagged decompressions:                        593860.\n"
      }
    },
    {
      "elapsed_seconds": 20.130745166999986,
      "stable_seconds": 20.121552000025986,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25473974272,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24098078720,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   449687.\nPages active:                                 875563.\nPages inactive:                               810489.\nPages speculative:                             84049.\nPages throttled:                                   0.\nPages wired down:                             180970.\nPages purgeable:                                 222.\n\"Translation faults\":                     1934191533.\nPages copy-on-write:                        96605567.\nPages zero filled:                        3160385693.\nPages reactivated:                         173028501.\nPages purged:                               12609121.\nFile-backed pages:                           1020921.\nAnonymous pages:                              749180.\nPages stored in compressor:                  1259544.\nPages occupied by compressor:                 684559.\nDecompressions:                             98633291.\nCompressions:                              112038748.\nPageins:                                  2197743217.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128243.\nPages tagged resident:                         86149.\nPages tagged compressed:                       42094.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          495.\nPages tag-storage non-tag pageable:            91881.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6262208.\nTagged compressions:                          720628.\nTagged decompressions:                        593873.\n"
      }
    },
    {
      "elapsed_seconds": 25.16156854198198,
      "stable_seconds": 25.152375375007978,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25429786624,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24053350400,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   446595.\nPages active:                                 876426.\nPages inactive:                               813721.\nPages speculative:                             84190.\nPages throttled:                                   0.\nPages wired down:                             180983.\nPages purgeable:                                 226.\n\"Translation faults\":                     1934205370.\nPages copy-on-write:                        96605984.\nPages zero filled:                        3160394827.\nPages reactivated:                         173028501.\nPages purged:                               12609121.\nFile-backed pages:                           1021279.\nAnonymous pages:                              753058.\nPages stored in compressor:                  1257155.\nPages occupied by compressor:                 683306.\nDecompressions:                             98635080.\nCompressions:                              112038748.\nPageins:                                  2197743528.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128233.\nPages tagged resident:                         86149.\nPages tagged compressed:                       42084.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          516.\nPages tag-storage non-tag pageable:            91860.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6259584.\nTagged compressions:                          720628.\nTagged decompressions:                        593883.\n"
      }
    },
    {
      "elapsed_seconds": 30.19214204198215,
      "stable_seconds": 30.18294887500815,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25469468672,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24090624000,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   439782.\nPages active:                                 893324.\nPages inactive:                               813733.\nPages speculative:                             84217.\nPages throttled:                                   0.\nPages wired down:                             171192.\nPages purgeable:                                9264.\n\"Translation faults\":                     1934219303.\nPages copy-on-write:                        96607024.\nPages zero filled:                        3160406987.\nPages reactivated:                         173028501.\nPages purged:                               12609128.\nFile-backed pages:                           1021329.\nAnonymous pages:                              769945.\nPages stored in compressor:                  1256408.\nPages occupied by compressor:                 683011.\nDecompressions:                             98635664.\nCompressions:                              112038748.\nPageins:                                  2197743575.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128229.\nPages tagged resident:                         86149.\nPages tagged compressed:                       42080.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          519.\nPages tag-storage non-tag pageable:            91857.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6258240.\nTagged compressions:                          720628.\nTagged decompressions:                        593887.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/round-3-buffered/receipt.json

Original bytes: 22097. SHA-256: `9793e312929d7fea64b03ba5a52d3812bf73e0f2fe43ebafd33ac5eb2925dcd9`.

Normalized bytes: 22097. SHA-256: `9793e312929d7fea64b03ba5a52d3812bf73e0f2fe43ebafd33ac5eb2925dcd9`.

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
  "committed_decode_tokens_per_second" : 5.8147903981338844,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9371932079957332,
    3.2106309579976369,
    3.4072966249950696,
    3.5944715829973575,
    3.7662351249891799,
    3.9371750830032397,
    4.1100038329896051,
    4.2988653329957742,
    4.4725590829912107,
    4.6500789579877164,
    4.8196049160032999,
    4.9724788749881554,
    5.135013582999818,
    5.2871510410041083,
    5.4710544160043355,
    5.6222319579974283,
    5.7609441249805968,
    5.925008499994874,
    6.0839378329983447,
    6.2714414579968434,
    6.4459869579877704,
    6.6048827079939656,
    6.7759069159801584,
    6.9586847079917789,
    7.1457002910028677,
    7.3214377079857513,
    7.4874428329931106,
    7.661637957993662,
    7.8745935829938389,
    8.0638121659867465,
    8.248089250002522,
    8.4105111660028342,
    8.6030346659827046,
    8.7765115829824936,
    8.9425623749848455,
    9.1215318329923321,
    9.3103723749809433,
    9.4970403329934925,
    9.6779647909861524,
    9.8485404159873724,
    10.014962124987505,
    10.207901749992743,
    10.403215957980137,
    10.584545290999813,
    10.751201000006404,
    10.955041040986544,
    11.162457083002664,
    11.348607457999606,
    11.523094165982911,
    11.68602079100674,
    11.851207625004463,
    12.02116920799017,
    12.18953579099616,
    12.355406582995784,
    12.516574040986598,
    12.718085500004236,
    12.894901291001588,
    13.075340540992329,
    13.234296082984656,
    13.40096616599476,
    13.596181750006508,
    13.776453375001438,
    13.962954165996052,
    14.128569916007109,
    14.334731832990656,
    14.492276915989351,
    14.682629082992207,
    14.876735500001814,
    15.04472741598147,
    15.207364000001689,
    15.385808999999426,
    15.559758415998658,
    15.722485125006642,
    15.881162707984913,
    16.047154083003988,
    16.202348582999548,
    16.350341999990633,
    16.519877374987118,
    16.672748165990924,
    16.81570074998308,
    17.003645415999927,
    17.180636624980252,
    17.363764749985421,
    17.529989625007147,
    17.707043250004062,
    17.873087790998397,
    18.017919790989254,
    18.170926416001748,
    18.356431791005889,
    18.538760208000895,
    18.69574900000589,
    18.850958041002741,
    18.999163208005484,
    19.149228750000475,
    19.302610999991884,
    19.472225790988887,
    19.621823207999114,
    19.775881749985274,
    19.955468208005186,
    20.155923040991183,
    20.328306124982191,
    20.483087665983476,
    20.650834583007963,
    20.81179358297959,
    20.966933707997669,
    21.110012249991996,
    21.283184707979672,
    21.430865040980279,
    21.59134970800369,
    21.74287883299985,
    21.890230832999805,
    22.091333124990342,
    22.279766708001262,
    22.444642624992412,
    22.60607404098846,
    22.772483749984531,
    22.9420145409822,
    23.114672583003994,
    23.270244374987669,
    23.437673332984559,
    23.625086499989266,
    23.806948665995151,
    23.964077665994409,
    24.10877883300418,
    24.272309749998385,
    24.431694750004681,
    24.61417195800459,
    24.778049249987816
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
    "reclaimableBytes" : 25127845888,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.27343775000190362,
    0.19666566699743271,
    0.18717495800228789,
    0.17176354199182242,
    0.17093995801405981,
    0.17282874998636544,
    0.18886150000616908,
    0.17369374999543652,
    0.17751987499650568,
    0.16952595801558346,
    0.15287395898485556,
    0.16253470801166259,
    0.15213745800429024,
    0.18390337500022724,
    0.15117754199309275,
    0.13871216698316857,
    0.16406437501427718,
    0.15892933300347067,
    0.18750362499849871,
    0.17454549999092706,
    0.15889575000619516,
    0.17102420798619278,
    0.18277779201162048,
    0.18701558301108889,
    0.17573741698288359,
    0.16600512500735931,
    0.17419512500055134,
    0.21295562500017695,
    0.18921858299290761,
    0.18427708401577547,
    0.16242191600031219,
    0.19252349997987039,
    0.17347691699978895,
    0.16605079200235195,
    0.17896945800748654,
    0.18884054198861122,
    0.18666795801254921,
    0.18092445799265988,
    0.17057562500122003,
    0.16642170900013298,
    0.19293962500523776,
    0.19531420798739418,
    0.18132933301967569,
    0.16665570900659077,
    0.20384004098013975,
    0.20741604201612063,
    0.18615037499694154,
    0.17448670798330568,
    0.16292662502382882,
    0.16518683399772272,
    0.16996158298570663,
    0.16836658300599083,
    0.16587079199962318,
    0.161167457990814,
    0.20151145901763812,
    0.17681579099735245,
    0.18043924999074079,
    0.1589555419923272,
    0.16667008301010355,
    0.19521558401174843,
    0.18027162499492988,
    0.18650079099461436,
    0.16561575001105666,
    0.20616191698354669,
    0.15754508299869485,
    0.19035216700285673,
    0.19410641700960696,
    0.16799191597965546,
    0.16263658402021974,
    0.17844499999773689,
    0.17394941599923186,
    0.16272670900798403,
    0.15867758297827095,
    0.16599137501907535,
    0.15519449999555945,
    0.14799341699108481,
    0.16953537499648519,
    0.15287079100380652,
    0.14295258399215527,
    0.1879446660168469,
    0.17699120898032561,
    0.18312812500516884,
    0.16622487502172589,
    0.17705362499691546,
    0.16604454099433497,
    0.14483199999085627,
    0.15300662501249462,
    0.18550537500414066,
    0.18232841699500568,
    0.15698879200499505,
    0.1552090409968514,
    0.14820516700274311,
    0.15006554199499078,
    0.15338224999140948,
    0.16961479099700227,
    0.14959741701022722,
    0.15405854198615998,
    0.17958645801991224,
    0.2004548329859972,
    0.17238308399100788,
    0.15478154100128449,
    0.16774691702448763,
    0.16095899997162633,
    0.15514012501807883,
    0.14307854199432768,
    0.17317245798767544,
    0.14768033300060779,
    0.16048466702341102,
    0.15152912499615923,
    0.1473519999999553,
    0.2011022919905372,
    0.18843358301091939,
    0.16487591699115001,
    0.1614314159960486,
    0.16640970899607055,
    0.1695307909976691,
    0.17265804202179424,
    0.15557179198367521,
    0.16742895799688995,
    0.18741316700470634,
    0.18186216600588523,
    0.15712899999925867,
    0.14470116700977087,
    0.16353091699420474,
    0.15938500000629574,
    0.1824772079999093,
    0.16387729198322631
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.656422083004145,
  "metadata_seconds" : 0.13233354198746383,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7731943448,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 24.778069541003788,
  "request_vm_after" : {
    "reclaimableBytes" : 18343034880,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17714610176,
    "swapins" : 28,
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
  "ttft_seconds" : 2.9371932079957332,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-3-buffered-supervision/identity.json

Original bytes: 3200. SHA-256: `a126af89f44a29d7d53d7d7ec349c8f14f9405c651e2f55c33d197b8ea51f3b5`.

Normalized bytes: 3144. SHA-256: `ccfb6dc3e83f2e22f866833f10aed70fcc7c7eb7a569dd4e89568a65cb72cc81`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/buffered-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/round-3-buffered",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-buffered/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23996727296,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   438191.\nPages active:                                 886104.\nPages inactive:                               813734.\nPages speculative:                             84217.\nPages throttled:                                   0.\nPages wired down:                             179976.\nPages purgeable:                                5123.\n\"Translation faults\":                     1934224645.\nPages copy-on-write:                        96607792.\nPages zero filled:                        3160410893.\nPages reactivated:                         173028501.\nPages purged:                               12609128.\nFile-backed pages:                           1021330.\nAnonymous pages:                              762725.\nPages stored in compressor:                  1256407.\nPages occupied by compressor:                 683010.\nDecompressions:                             98635689.\nCompressions:                              112038748.\nPageins:                                  2197743581.\nPageouts:                                     479499.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128229.\nPages tagged resident:                         86149.\nPages tagged compressed:                       42080.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          516.\nPages tag-storage non-tag pageable:            91860.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6258240.\nTagged compressions:                          720628.\nTagged decompressions:                        593887.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/round-3-buffered-supervision/receipt.json

Original bytes: 2140. SHA-256: `e715d973f18f7a60394187e5718db4b60c12211244243ca2521c8dd54fc2a0a8`.

Normalized bytes: 2140. SHA-256: `e715d973f18f7a60394187e5718db4b60c12211244243ca2521c8dd54fc2a0a8`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7731943448,
  "samples": 1436,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24715001856,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   469941.\nPages active:                                 864583.\nPages inactive:                               798110.\nPages speculative:                             84891.\nPages throttled:                                   0.\nPages wired down:                             170255.\nPages purgeable:                                5055.\n\"Translation faults\":                     1934904808.\nPages copy-on-write:                        96628571.\nPages zero filled:                        3160986545.\nPages reactivated:                         173134097.\nPages purged:                               12616750.\nFile-backed pages:                           1033488.\nAnonymous pages:                              714096.\nPages stored in compressor:                  1298106.\nPages occupied by compressor:                 696585.\nDecompressions:                             98881103.\nCompressions:                              112351020.\nPageins:                                  2207888700.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128214.\nPages tagged resident:                         85369.\nPages tagged compressed:                       42845.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1245.\nPages tag-storage non-tag pageable:            91131.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6431168.\nTagged compressions:                          722272.\nTagged decompressions:                        594764.\n"
  },
  "seconds": 83.71577370900195
}
````

### vq-uncached-expert-cost-v2/round-3-buffered-supervision/stdout.txt

Original bytes: 22098. SHA-256: `403584532e865ec789324b39dee253a3e4ff5ebb8fdb0e09ac12901216cc3bc5`.

Normalized bytes: 22098. SHA-256: `403584532e865ec789324b39dee253a3e4ff5ebb8fdb0e09ac12901216cc3bc5`.

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
  "committed_decode_tokens_per_second" : 5.8147903981338844,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9371932079957332,
    3.2106309579976369,
    3.4072966249950696,
    3.5944715829973575,
    3.7662351249891799,
    3.9371750830032397,
    4.1100038329896051,
    4.2988653329957742,
    4.4725590829912107,
    4.6500789579877164,
    4.8196049160032999,
    4.9724788749881554,
    5.135013582999818,
    5.2871510410041083,
    5.4710544160043355,
    5.6222319579974283,
    5.7609441249805968,
    5.925008499994874,
    6.0839378329983447,
    6.2714414579968434,
    6.4459869579877704,
    6.6048827079939656,
    6.7759069159801584,
    6.9586847079917789,
    7.1457002910028677,
    7.3214377079857513,
    7.4874428329931106,
    7.661637957993662,
    7.8745935829938389,
    8.0638121659867465,
    8.248089250002522,
    8.4105111660028342,
    8.6030346659827046,
    8.7765115829824936,
    8.9425623749848455,
    9.1215318329923321,
    9.3103723749809433,
    9.4970403329934925,
    9.6779647909861524,
    9.8485404159873724,
    10.014962124987505,
    10.207901749992743,
    10.403215957980137,
    10.584545290999813,
    10.751201000006404,
    10.955041040986544,
    11.162457083002664,
    11.348607457999606,
    11.523094165982911,
    11.68602079100674,
    11.851207625004463,
    12.02116920799017,
    12.18953579099616,
    12.355406582995784,
    12.516574040986598,
    12.718085500004236,
    12.894901291001588,
    13.075340540992329,
    13.234296082984656,
    13.40096616599476,
    13.596181750006508,
    13.776453375001438,
    13.962954165996052,
    14.128569916007109,
    14.334731832990656,
    14.492276915989351,
    14.682629082992207,
    14.876735500001814,
    15.04472741598147,
    15.207364000001689,
    15.385808999999426,
    15.559758415998658,
    15.722485125006642,
    15.881162707984913,
    16.047154083003988,
    16.202348582999548,
    16.350341999990633,
    16.519877374987118,
    16.672748165990924,
    16.81570074998308,
    17.003645415999927,
    17.180636624980252,
    17.363764749985421,
    17.529989625007147,
    17.707043250004062,
    17.873087790998397,
    18.017919790989254,
    18.170926416001748,
    18.356431791005889,
    18.538760208000895,
    18.69574900000589,
    18.850958041002741,
    18.999163208005484,
    19.149228750000475,
    19.302610999991884,
    19.472225790988887,
    19.621823207999114,
    19.775881749985274,
    19.955468208005186,
    20.155923040991183,
    20.328306124982191,
    20.483087665983476,
    20.650834583007963,
    20.81179358297959,
    20.966933707997669,
    21.110012249991996,
    21.283184707979672,
    21.430865040980279,
    21.59134970800369,
    21.74287883299985,
    21.890230832999805,
    22.091333124990342,
    22.279766708001262,
    22.444642624992412,
    22.60607404098846,
    22.772483749984531,
    22.9420145409822,
    23.114672583003994,
    23.270244374987669,
    23.437673332984559,
    23.625086499989266,
    23.806948665995151,
    23.964077665994409,
    24.10877883300418,
    24.272309749998385,
    24.431694750004681,
    24.61417195800459,
    24.778049249987816
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
    "reclaimableBytes" : 25127845888,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.27343775000190362,
    0.19666566699743271,
    0.18717495800228789,
    0.17176354199182242,
    0.17093995801405981,
    0.17282874998636544,
    0.18886150000616908,
    0.17369374999543652,
    0.17751987499650568,
    0.16952595801558346,
    0.15287395898485556,
    0.16253470801166259,
    0.15213745800429024,
    0.18390337500022724,
    0.15117754199309275,
    0.13871216698316857,
    0.16406437501427718,
    0.15892933300347067,
    0.18750362499849871,
    0.17454549999092706,
    0.15889575000619516,
    0.17102420798619278,
    0.18277779201162048,
    0.18701558301108889,
    0.17573741698288359,
    0.16600512500735931,
    0.17419512500055134,
    0.21295562500017695,
    0.18921858299290761,
    0.18427708401577547,
    0.16242191600031219,
    0.19252349997987039,
    0.17347691699978895,
    0.16605079200235195,
    0.17896945800748654,
    0.18884054198861122,
    0.18666795801254921,
    0.18092445799265988,
    0.17057562500122003,
    0.16642170900013298,
    0.19293962500523776,
    0.19531420798739418,
    0.18132933301967569,
    0.16665570900659077,
    0.20384004098013975,
    0.20741604201612063,
    0.18615037499694154,
    0.17448670798330568,
    0.16292662502382882,
    0.16518683399772272,
    0.16996158298570663,
    0.16836658300599083,
    0.16587079199962318,
    0.161167457990814,
    0.20151145901763812,
    0.17681579099735245,
    0.18043924999074079,
    0.1589555419923272,
    0.16667008301010355,
    0.19521558401174843,
    0.18027162499492988,
    0.18650079099461436,
    0.16561575001105666,
    0.20616191698354669,
    0.15754508299869485,
    0.19035216700285673,
    0.19410641700960696,
    0.16799191597965546,
    0.16263658402021974,
    0.17844499999773689,
    0.17394941599923186,
    0.16272670900798403,
    0.15867758297827095,
    0.16599137501907535,
    0.15519449999555945,
    0.14799341699108481,
    0.16953537499648519,
    0.15287079100380652,
    0.14295258399215527,
    0.1879446660168469,
    0.17699120898032561,
    0.18312812500516884,
    0.16622487502172589,
    0.17705362499691546,
    0.16604454099433497,
    0.14483199999085627,
    0.15300662501249462,
    0.18550537500414066,
    0.18232841699500568,
    0.15698879200499505,
    0.1552090409968514,
    0.14820516700274311,
    0.15006554199499078,
    0.15338224999140948,
    0.16961479099700227,
    0.14959741701022722,
    0.15405854198615998,
    0.17958645801991224,
    0.2004548329859972,
    0.17238308399100788,
    0.15478154100128449,
    0.16774691702448763,
    0.16095899997162633,
    0.15514012501807883,
    0.14307854199432768,
    0.17317245798767544,
    0.14768033300060779,
    0.16048466702341102,
    0.15152912499615923,
    0.1473519999999553,
    0.2011022919905372,
    0.18843358301091939,
    0.16487591699115001,
    0.1614314159960486,
    0.16640970899607055,
    0.1695307909976691,
    0.17265804202179424,
    0.15557179198367521,
    0.16742895799688995,
    0.18741316700470634,
    0.18186216600588523,
    0.15712899999925867,
    0.14470116700977087,
    0.16353091699420474,
    0.15938500000629574,
    0.1824772079999093,
    0.16387729198322631
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.656422083004145,
  "metadata_seconds" : 0.13233354198746383,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7731943448,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 24.778069541003788,
  "request_vm_after" : {
    "reclaimableBytes" : 18343034880,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17714610176,
    "swapins" : 28,
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
  "ttft_seconds" : 2.9371932079957332,
  "uncached_expert_files" : 0,
  "validation_receipt_sha256" : "85bb259b00e2522748e34c0c1341e2a576b4721a1503790aa1f14ce7bd776889",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-3-buffered-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v2/round-3-uncached-admission.json

Original bytes: 17276. SHA-256: `dd15a6dea310251f0a895bb77690b6a6430fc67eccdb38e391ed659b299c488b`.

Normalized bytes: 17276. SHA-256: `dd15a6dea310251f0a895bb77690b6a6430fc67eccdb38e391ed659b299c488b`.

````text
{
  "schema": 1,
  "passed": true,
  "maximum_wait_seconds": 600,
  "required_stable_seconds": 30,
  "samples": [
    {
      "elapsed_seconds": 0.010900082997977734,
      "stable_seconds": 0.0,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 26111049728,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24721506304,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   456815.\nPages active:                                 863532.\nPages inactive:                               812683.\nPages speculative:                             84943.\nPages throttled:                                   0.\nPages wired down:                             170255.\nPages purgeable:                                5039.\n\"Translation faults\":                     1934906716.\nPages copy-on-write:                        96628852.\nPages zero filled:                        3160986841.\nPages reactivated:                         173134097.\nPages purged:                               12616750.\nFile-backed pages:                           1047027.\nAnonymous pages:                              714131.\nPages stored in compressor:                  1298087.\nPages occupied by compressor:                 696582.\nDecompressions:                             98881130.\nCompressions:                              112351020.\nPageins:                                  2207902054.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128213.\nPages tagged resident:                         85369.\nPages tagged compressed:                       42844.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1097.\nPages tag-storage non-tag pageable:            91279.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6431104.\nTagged compressions:                          722272.\nTagged decompressions:                        594765.\n"
      }
    },
    {
      "elapsed_seconds": 5.041078542009927,
      "stable_seconds": 5.03017845901195,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25897320448,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24505073664,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   448333.\nPages active:                                 873088.\nPages inactive:                               809337.\nPages speculative:                             85048.\nPages throttled:                                   0.\nPages wired down:                             180891.\nPages purgeable:                                 161.\n\"Translation faults\":                     1934932237.\nPages copy-on-write:                        96629221.\nPages zero filled:                        3160990930.\nPages reactivated:                         173134103.\nPages purged:                               12616750.\nFile-backed pages:                           1047177.\nAnonymous pages:                              720296.\nPages stored in compressor:                  1283208.\nPages occupied by compressor:                 688625.\nDecompressions:                             98895978.\nCompressions:                              112351020.\nPageins:                                  2207902142.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128206.\nPages tagged resident:                         85369.\nPages tagged compressed:                       42837.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          538.\nPages tag-storage non-tag pageable:            91838.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6429952.\nTagged compressions:                          722272.\nTagged decompressions:                        594772.\n"
      }
    },
    {
      "elapsed_seconds": 10.073226750013418,
      "stable_seconds": 10.06232666701544,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25880903680,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24488247296,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   447252.\nPages active:                                 872515.\nPages inactive:                               812056.\nPages speculative:                             85075.\nPages throttled:                                   0.\nPages wired down:                             180872.\nPages purgeable:                                 185.\n\"Translation faults\":                     1934940513.\nPages copy-on-write:                        96629521.\nPages zero filled:                        3160995936.\nPages reactivated:                         173134103.\nPages purged:                               12616750.\nFile-backed pages:                           1047207.\nAnonymous pages:                              722439.\nPages stored in compressor:                  1280815.\nPages occupied by compressor:                 687225.\nDecompressions:                             98897981.\nCompressions:                              112351020.\nPageins:                                  2207902160.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128192.\nPages tagged resident:                         85359.\nPages tagged compressed:                       42833.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          584.\nPages tag-storage non-tag pageable:            91792.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6429312.\nTagged compressions:                          722272.\nTagged decompressions:                        594776.\n"
      }
    },
    {
      "elapsed_seconds": 15.106616000004578,
      "stable_seconds": 15.0957159170066,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25970081792,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24561664000,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   445535.\nPages active:                                 883194.\nPages inactive:                               812552.\nPages speculative:                             85860.\nPages throttled:                                   0.\nPages wired down:                             170909.\nPages purgeable:                                5431.\n\"Translation faults\":                     1934945310.\nPages copy-on-write:                        96629887.\nPages zero filled:                        3160998443.\nPages reactivated:                         173134106.\nPages purged:                               12616755.\nFile-backed pages:                           1048159.\nAnonymous pages:                              733447.\nPages stored in compressor:                  1279590.\nPages occupied by compressor:                 686864.\nDecompressions:                             98899006.\nCompressions:                              112351020.\nPageins:                                  2207902694.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128163.\nPages tagged resident:                         85334.\nPages tagged compressed:                       42829.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          587.\nPages tag-storage non-tag pageable:            91789.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6428352.\nTagged compressions:                          722272.\nTagged decompressions:                        594780.\n"
      }
    },
    {
      "elapsed_seconds": 20.135432667011628,
      "stable_seconds": 20.12453258401365,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25882017792,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24472371200,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   445107.\nPages active:                                 875003.\nPages inactive:                               812711.\nPages speculative:                             85979.\nPages throttled:                                   0.\nPages wired down:                             179695.\nPages purgeable:                                 281.\n\"Translation faults\":                     1934951865.\nPages copy-on-write:                        96630211.\nPages zero filled:                        3161002898.\nPages reactivated:                         173134223.\nPages purged:                               12616755.\nFile-backed pages:                           1048287.\nAnonymous pages:                              725406.\nPages stored in compressor:                  1278887.\nPages occupied by compressor:                 686578.\nDecompressions:                             98899636.\nCompressions:                              112351020.\nPageins:                                  2207902714.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128128.\nPages tagged resident:                         85299.\nPages tagged compressed:                       42829.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          601.\nPages tag-storage non-tag pageable:            91775.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6428352.\nTagged compressions:                          722272.\nTagged decompressions:                        594780.\n"
      }
    },
    {
      "elapsed_seconds": 25.16606841699104,
      "stable_seconds": 25.15516833399306,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25869877248,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24454332416,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   443260.\nPages active:                                 877289.\nPages inactive:                               811671.\nPages speculative:                             86442.\nPages throttled:                                   0.\nPages wired down:                             179687.\nPages purgeable:                                 417.\n\"Translation faults\":                     1934966607.\nPages copy-on-write:                        96631485.\nPages zero filled:                        3161007932.\nPages reactivated:                         173134225.\nPages purged:                               12616755.\nFile-backed pages:                           1048897.\nAnonymous pages:                              726505.\nPages stored in compressor:                  1278015.\nPages occupied by compressor:                 686255.\nDecompressions:                             98900395.\nCompressions:                              112351020.\nPageins:                                  2207903036.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128108.\nPages tagged resident:                         85299.\nPages tagged compressed:                       42809.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          671.\nPages tag-storage non-tag pageable:            91705.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6423360.\nTagged compressions:                          722272.\nTagged decompressions:                        594800.\n"
      }
    },
    {
      "elapsed_seconds": 30.200403333001304,
      "stable_seconds": 30.189503250003327,
      "eligible": true,
      "native": {
        "conditions": {
          "lowPowerModeEnabled": false,
          "thermalState": "nominal"
        },
        "vm": {
          "reclaimableBytes": 25853558784,
          "swapins": 28,
          "swapouts": 2908
        }
      },
      "external": {
        "page_bytes": 16384,
        "reclaimable_bytes": 24436097024,
        "swapins": 28,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   441758.\nPages active:                                 879241.\nPages inactive:                               812089.\nPages speculative:                             86588.\nPages throttled:                                   0.\nPages wired down:                             179643.\nPages purgeable:                                 441.\n\"Translation faults\":                     1934975012.\nPages copy-on-write:                        96631764.\nPages zero filled:                        3161014018.\nPages reactivated:                         173134225.\nPages purged:                               12616755.\nFile-backed pages:                           1049262.\nAnonymous pages:                              728656.\nPages stored in compressor:                  1276298.\nPages occupied by compressor:                 685654.\nDecompressions:                             98902016.\nCompressions:                              112351020.\nPageins:                                  2207903349.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128051.\nPages tagged resident:                         85257.\nPages tagged compressed:                       42794.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          681.\nPages tag-storage non-tag pageable:            91695.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6421440.\nTagged compressions:                          722272.\nTagged decompressions:                        594812.\n"
      }
    }
  ],
  "observer_sha256": "ec4eba05b1665e22e717c351c1d3f29cf04e19c7b6b75802fe3f1fc9b3d54f79",
  "engine_source_sha256": "9e8c02c07af2cc6c13ea2b16aa151aea78bfbe7529ea0e90592e2177d3d4f6e5"
}
````

### vq-uncached-expert-cost-v2/round-3-uncached/receipt.json

Original bytes: 22119. SHA-256: `857ba841907db8582a2551066a9e00faa4f620fc250cd9166b125558d1f1b335`.

Normalized bytes: 22119. SHA-256: `857ba841907db8582a2551066a9e00faa4f620fc250cd9166b125558d1f1b335`.

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
  "committed_decode_tokens_per_second" : 5.3271722883906127,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.852987291989848,
    3.1160479169921018,
    3.3227165839925874,
    3.5225622500001919,
    3.7094449590076692,
    3.8921578750014305,
    4.078546875010943,
    4.2852308750152588,
    4.4765736669942271,
    4.6708800419874024,
    4.8508523750060704,
    5.0136119590024464,
    5.1911487499892246,
    5.3521804590127431,
    5.5416038749972358,
    5.6984449170122389,
    5.8407008340000175,
    6.0213363340008073,
    6.196298916998785,
    6.4007919169962406,
    6.5873050840164069,
    6.7675968339899555,
    6.9471618339885026,
    7.1397722919937223,
    7.3479932089976501,
    7.5381210840132553,
    7.7176725000026636,
    7.9049234169942793,
    8.1314087090140674,
    8.3354027089953888,
    8.5419058339903131,
    8.7177614170068409,
    8.9284316670091357,
    9.128723000001628,
    9.3226319999957923,
    9.5210668749932665,
    9.7205819170048926,
    9.9295782090048306,
    10.129341916996054,
    10.31716858400614,
    10.500507499993546,
    10.713357750006253,
    10.926196042011725,
    11.129800624999916,
    11.31296295899665,
    11.537601541989716,
    11.760148250003112,
    11.96481912501622,
    12.159746999997878,
    12.329703458992299,
    12.517984667007113,
    12.702830708993133,
    12.892413458990632,
    13.081099959003041,
    13.251456666999729,
    13.476535291993059,
    13.671676958998432,
    13.877050292008789,
    14.058667125005741,
    14.244502791989362,
    14.452604708989384,
    14.651536791992839,
    14.852927041996736,
    15.036098959011724,
    15.255879000003915,
    15.431692334008403,
    15.641160958999535,
    15.855102667002939,
    16.041111583996098,
    16.223763459012844,
    16.427830542001175,
    16.611544749990571,
    16.789032333996147,
    16.949856791994534,
    17.124805792002007,
    17.293831374990987,
    17.443249000003561,
    17.626478166988818,
    17.786622874991735,
    17.940064249996794,
    18.149198041995987,
    18.338609875005204,
    18.539860749995569,
    18.722278625005856,
    18.91702933399938,
    19.09996766698896,
    19.253106916992692,
    19.422219875006704,
    19.628921249997802,
    19.827930875006132,
    19.998334959003842,
    20.167936042009387,
    20.329905583988875,
    20.492620250006439,
    20.654443250008626,
    20.834954249992734,
    21.00426874999539,
    21.183319709001807,
    21.386149124999065,
    21.605895374988904,
    21.796148958994308,
    21.962356750009349,
    22.140859625011217,
    22.312580541998614,
    22.48056062500109,
    22.633885916991858,
    22.824541375011904,
    22.981318334001116,
    23.163797666988103,
    23.331346916995244,
    23.499017499998445,
    23.72195725000347,
    23.929663749993779,
    24.112223750009434,
    24.292083042004379,
    24.480880709015764,
    24.661942417005775,
    24.85224737500539,
    25.021514124993701,
    25.207698375015752,
    25.408937000000151,
    25.611764250003034,
    25.785272917011753,
    25.941833791992394,
    26.121580792008899,
    26.305222124996362,
    26.509440208988963,
    26.693027208995773
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 25579569152,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.2630606250022538,
    0.20666866700048558,
    0.19984566600760445,
    0.18688270900747739,
    0.18271291599376127,
    0.18638900000951253,
    0.20668400000431575,
    0.19134279197896831,
    0.19430637499317527,
    0.179972333018668,
    0.16275958399637602,
    0.17753679098677821,
    0.16103170902351849,
    0.18942341598449275,
    0.15684104201500304,
    0.14225591698777862,
    0.18063550000078976,
    0.17496258299797773,
    0.20449299999745563,
    0.18651316702016629,
    0.18029174997354858,
    0.17956499999854714,
    0.1926104580052197,
    0.20822091700392775,
    0.19012787501560524,
    0.17955141598940827,
    0.18725091699161567,
    0.22648529201978818,
    0.20399399998132139,
    0.20650312499492429,
    0.17585558301652782,
    0.21067025000229478,
    0.20029133299249224,
    0.19390899999416433,
    0.19843487499747425,
    0.19951504201162606,
    0.20899629199993797,
    0.19976370799122378,
    0.18782666701008566,
    0.18333891598740593,
    0.21285025001270697,
    0.21283829200547189,
    0.2036045829881914,
    0.18316233399673365,
    0.22463858299306594,
    0.22254670801339671,
    0.20467087501310743,
    0.19492787498165853,
    0.16995645899442025,
    0.18828120801481418,
    0.18484604198602028,
    0.18958274999749847,
    0.18868650001240894,
    0.17035670799668878,
    0.22507862499332987,
    0.19514166700537317,
    0.20537333301035687,
    0.18161683299695142,
    0.18583566698362119,
    0.20810191700002179,
    0.19893208300345577,
    0.20139025000389665,
    0.18317191701498814,
    0.21978004099219106,
    0.17581333400448784,
    0.20946862499113195,
    0.21394170800340362,
    0.1860089169931598,
    0.18265187501674518,
    0.20406708298833109,
    0.18371420798939653,
    0.17748758400557563,
    0.16082445799838752,
    0.17494900000747293,
    0.16902558298897929,
    0.14941762501257472,
    0.1832291669852566,
    0.16014470800291747,
    0.15344137500505894,
    0.20913379199919291,
    0.18941183300921693,
    0.20125087499036454,
    0.18241787501028739,
    0.19475070899352431,
    0.18293833298957907,
    0.15313925000373274,
    0.16911295801401138,
    0.20670137499109842,
    0.19900962500832975,
    0.17040408399770968,
    0.16960108300554566,
    0.16196954197948799,
    0.16271466601756401,
    0.16182300000218675,
    0.18051099998410791,
    0.16931450000265613,
    0.17905095900641754,
    0.20282941599725746,
    0.21974624998983927,
    0.19025358400540426,
    0.16620779101504013,
    0.17850287500186823,
    0.17172091698739678,
    0.16798008300247602,
    0.15332529199076816,
    0.19065545802004635,
    0.15677695898921229,
    0.18247933298698626,
    0.16754925000714138,
    0.16767058300320059,
    0.22293975000502542,
    0.20770649999030866,
    0.18256000001565553,
    0.17985929199494421,
    0.18879766701138578,
    0.1810617079900112,
    0.190304957999615,
    0.16926674998831004,
    0.18618425002205186,
    0.20123862498439848,
    0.20282725000288337,
    0.17350866700871848,
    0.15656087498064153,
    0.1797470000165049,
    0.1836413329874631,
    0.20421808399260044,
    0.18358700000680983
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.591438749979716,
  "metadata_seconds" : 0.13558841700432822,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7725750272,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 26.693047084001591,
  "request_vm_after" : {
    "reclaimableBytes" : 17454497792,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17356554240,
    "swapins" : 28,
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
  "ttft_seconds" : 2.852987291989848,
  "uncached_expert_files" : 9,
  "validation_receipt_sha256" : "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-3-uncached-supervision/identity.json

Original bytes: 3200. SHA-256: `100363e3d455240169e405964361ebd8e8264ebd813a9b33ba10cad366f3ec28`.

Normalized bytes: 3144. SHA-256: `1cf55c10dea57b62ad3e00143400cf72ebe069102dd41ca97e724c3d3b2687dd`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-uncached-expert-v1/slotstream",
    "quantization-performance-pilot",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--profile",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/uncached-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/round-3-uncached",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v2/validation-uncached/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24436637696,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   441787.\nPages active:                                 879245.\nPages inactive:                               812090.\nPages speculative:                             86591.\nPages throttled:                                   0.\nPages wired down:                             179643.\nPages purgeable:                                 441.\n\"Translation faults\":                     1934980141.\nPages copy-on-write:                        96632526.\nPages zero filled:                        3161016193.\nPages reactivated:                         173134225.\nPages purged:                               12616755.\nFile-backed pages:                           1049266.\nAnonymous pages:                              728660.\nPages stored in compressor:                  1276298.\nPages occupied by compressor:                 685654.\nDecompressions:                             98902040.\nCompressions:                              112351020.\nPageins:                                  2207903356.\nPageouts:                                     480003.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128051.\nPages tagged resident:                         85257.\nPages tagged compressed:                       42794.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                          683.\nPages tag-storage non-tag pageable:            91693.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6421440.\nTagged compressions:                          722272.\nTagged decompressions:                        594812.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v2/round-3-uncached-supervision/receipt.json

Original bytes: 2140. SHA-256: `61b78b52c5017fd6fd09c5c246a5eee9410477e3808ce82b175b087448ffaae5`.

Normalized bytes: 2140. SHA-256: `61b78b52c5017fd6fd09c5c246a5eee9410477e3808ce82b175b087448ffaae5`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7725750272,
  "samples": 1464,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 24126865408,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   470814.\nPages active:                                 881035.\nPages inactive:                               820179.\nPages speculative:                             59601.\nPages throttled:                                   0.\nPages wired down:                             181434.\nPages purgeable:                                1253.\n\"Translation faults\":                     1935727207.\nPages copy-on-write:                        96664437.\nPages zero filled:                        3161626444.\nPages reactivated:                         173191507.\nPages purged:                               12621231.\nFile-backed pages:                           1000520.\nAnonymous pages:                              760295.\nPages stored in compressor:                  1257017.\nPages occupied by compressor:                 671532.\nDecompressions:                             99061515.\nCompressions:                              112520830.\nPageins:                                  2217422088.\nPageouts:                                     480268.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 130604.\nPages tagged resident:                         87746.\nPages tagged compressed:                       42858.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5920.\nPages tag-storage free:                         1010.\nPages tag-storage non-tag pageable:            91366.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6431168.\nTagged compressions:                          723735.\nTagged decompressions:                        596203.\n"
  },
  "seconds": 85.59439129100065
}
````

### vq-uncached-expert-cost-v2/round-3-uncached-supervision/stdout.txt

Original bytes: 22120. SHA-256: `c17cf3d3237df1feb7d103a924acbd6a4d73497f959a253d1c3c722f90938988`.

Normalized bytes: 22120. SHA-256: `c17cf3d3237df1feb7d103a924acbd6a4d73497f959a253d1c3c722f90938988`.

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
  "committed_decode_tokens_per_second" : 5.3271722883906127,
  "committed_tokens" : 128,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.852987291989848,
    3.1160479169921018,
    3.3227165839925874,
    3.5225622500001919,
    3.7094449590076692,
    3.8921578750014305,
    4.078546875010943,
    4.2852308750152588,
    4.4765736669942271,
    4.6708800419874024,
    4.8508523750060704,
    5.0136119590024464,
    5.1911487499892246,
    5.3521804590127431,
    5.5416038749972358,
    5.6984449170122389,
    5.8407008340000175,
    6.0213363340008073,
    6.196298916998785,
    6.4007919169962406,
    6.5873050840164069,
    6.7675968339899555,
    6.9471618339885026,
    7.1397722919937223,
    7.3479932089976501,
    7.5381210840132553,
    7.7176725000026636,
    7.9049234169942793,
    8.1314087090140674,
    8.3354027089953888,
    8.5419058339903131,
    8.7177614170068409,
    8.9284316670091357,
    9.128723000001628,
    9.3226319999957923,
    9.5210668749932665,
    9.7205819170048926,
    9.9295782090048306,
    10.129341916996054,
    10.31716858400614,
    10.500507499993546,
    10.713357750006253,
    10.926196042011725,
    11.129800624999916,
    11.31296295899665,
    11.537601541989716,
    11.760148250003112,
    11.96481912501622,
    12.159746999997878,
    12.329703458992299,
    12.517984667007113,
    12.702830708993133,
    12.892413458990632,
    13.081099959003041,
    13.251456666999729,
    13.476535291993059,
    13.671676958998432,
    13.877050292008789,
    14.058667125005741,
    14.244502791989362,
    14.452604708989384,
    14.651536791992839,
    14.852927041996736,
    15.036098959011724,
    15.255879000003915,
    15.431692334008403,
    15.641160958999535,
    15.855102667002939,
    16.041111583996098,
    16.223763459012844,
    16.427830542001175,
    16.611544749990571,
    16.789032333996147,
    16.949856791994534,
    17.124805792002007,
    17.293831374990987,
    17.443249000003561,
    17.626478166988818,
    17.786622874991735,
    17.940064249996794,
    18.149198041995987,
    18.338609875005204,
    18.539860749995569,
    18.722278625005856,
    18.91702933399938,
    19.09996766698896,
    19.253106916992692,
    19.422219875006704,
    19.628921249997802,
    19.827930875006132,
    19.998334959003842,
    20.167936042009387,
    20.329905583988875,
    20.492620250006439,
    20.654443250008626,
    20.834954249992734,
    21.00426874999539,
    21.183319709001807,
    21.386149124999065,
    21.605895374988904,
    21.796148958994308,
    21.962356750009349,
    22.140859625011217,
    22.312580541998614,
    22.48056062500109,
    22.633885916991858,
    22.824541375011904,
    22.981318334001116,
    23.163797666988103,
    23.331346916995244,
    23.499017499998445,
    23.72195725000347,
    23.929663749993779,
    24.112223750009434,
    24.292083042004379,
    24.480880709015764,
    24.661942417005775,
    24.85224737500539,
    25.021514124993701,
    25.207698375015752,
    25.408937000000151,
    25.611764250003034,
    25.785272917011753,
    25.941833791992394,
    26.121580792008899,
    26.305222124996362,
    26.509440208988963,
    26.693027208995773
  ],
  "expert_file_read_policy" : "uncached-random-shards-v1",
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
    "reclaimableBytes" : 25579569152,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.2630606250022538,
    0.20666866700048558,
    0.19984566600760445,
    0.18688270900747739,
    0.18271291599376127,
    0.18638900000951253,
    0.20668400000431575,
    0.19134279197896831,
    0.19430637499317527,
    0.179972333018668,
    0.16275958399637602,
    0.17753679098677821,
    0.16103170902351849,
    0.18942341598449275,
    0.15684104201500304,
    0.14225591698777862,
    0.18063550000078976,
    0.17496258299797773,
    0.20449299999745563,
    0.18651316702016629,
    0.18029174997354858,
    0.17956499999854714,
    0.1926104580052197,
    0.20822091700392775,
    0.19012787501560524,
    0.17955141598940827,
    0.18725091699161567,
    0.22648529201978818,
    0.20399399998132139,
    0.20650312499492429,
    0.17585558301652782,
    0.21067025000229478,
    0.20029133299249224,
    0.19390899999416433,
    0.19843487499747425,
    0.19951504201162606,
    0.20899629199993797,
    0.19976370799122378,
    0.18782666701008566,
    0.18333891598740593,
    0.21285025001270697,
    0.21283829200547189,
    0.2036045829881914,
    0.18316233399673365,
    0.22463858299306594,
    0.22254670801339671,
    0.20467087501310743,
    0.19492787498165853,
    0.16995645899442025,
    0.18828120801481418,
    0.18484604198602028,
    0.18958274999749847,
    0.18868650001240894,
    0.17035670799668878,
    0.22507862499332987,
    0.19514166700537317,
    0.20537333301035687,
    0.18161683299695142,
    0.18583566698362119,
    0.20810191700002179,
    0.19893208300345577,
    0.20139025000389665,
    0.18317191701498814,
    0.21978004099219106,
    0.17581333400448784,
    0.20946862499113195,
    0.21394170800340362,
    0.1860089169931598,
    0.18265187501674518,
    0.20406708298833109,
    0.18371420798939653,
    0.17748758400557563,
    0.16082445799838752,
    0.17494900000747293,
    0.16902558298897929,
    0.14941762501257472,
    0.1832291669852566,
    0.16014470800291747,
    0.15344137500505894,
    0.20913379199919291,
    0.18941183300921693,
    0.20125087499036454,
    0.18241787501028739,
    0.19475070899352431,
    0.18293833298957907,
    0.15313925000373274,
    0.16911295801401138,
    0.20670137499109842,
    0.19900962500832975,
    0.17040408399770968,
    0.16960108300554566,
    0.16196954197948799,
    0.16271466601756401,
    0.16182300000218675,
    0.18051099998410791,
    0.16931450000265613,
    0.17905095900641754,
    0.20282941599725746,
    0.21974624998983927,
    0.19025358400540426,
    0.16620779101504013,
    0.17850287500186823,
    0.17172091698739678,
    0.16798008300247602,
    0.15332529199076816,
    0.19065545802004635,
    0.15677695898921229,
    0.18247933298698626,
    0.16754925000714138,
    0.16767058300320059,
    0.22293975000502542,
    0.20770649999030866,
    0.18256000001565553,
    0.17985929199494421,
    0.18879766701138578,
    0.1810617079900112,
    0.190304957999615,
    0.16926674998831004,
    0.18618425002205186,
    0.20123862498439848,
    0.20282725000288337,
    0.17350866700871848,
    0.15656087498064153,
    0.1797470000165049,
    0.1836413329874631,
    0.20421808399260044,
    0.18358700000680983
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 58.591438749979716,
  "metadata_seconds" : 0.13558841700432822,
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
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7725750272,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 26.693047084001591,
  "request_vm_after" : {
    "reclaimableBytes" : 17454497792,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 17356554240,
    "swapins" : 28,
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
  "ttft_seconds" : 2.852987291989848,
  "uncached_expert_files" : 9,
  "validation_receipt_sha256" : "20d3fd36d5c142c2980b7fb82886e87392afffd45fdac34e97526ae1bde13612",
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v2/round-3-uncached-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### frozen-uncached-expert-v1/build-identity.json

Original bytes: 31715. SHA-256: `15a22df13ae1781e579d9c49ca75233f0f3d2847881618f4ecf2ff34ae47b4e7`.

Normalized bytes: 31715. SHA-256: `15a22df13ae1781e579d9c49ca75233f0f3d2847881618f4ecf2ff34ae47b4e7`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "4eb5fe513cf78f78bde2e7b8de9a0a28b4356af5f3e18b5a4fce70975ff44886",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQDenseOverlay.swift": "0102f31346cb84048b551265696cd4bcf4dd7f2a73c60be6840d654f9c4a2978",
    "Sources/Slotstream/VQExpert.swift": "b62435a1dec9cde5dd294db83909ea2b559554fed284f028df50cd0c92d682cb",
    "Sources/Slotstream/VQExpertKernels.swift": "3d0a9c22935d8984583ea59cf94a923f31ac03f8944ae570abb0b6b9749ded86",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "4425a383cfce125065b3ba829272e640837596de3c0bc2e7f6940866c9de55e8",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "3688d7bdaf9730e0cfd13635ac550706539585c91edaae9a13336e6e63db2616",
    "Sources/Slotstream/VQRecordBank.swift": "61d399967fa738ff864c544972adc0c57e07de60516a0afa49091adc2c231ce9",
    "Sources/Slotstream/VQRecordCache.swift": "2fe427a6a60f464100cf2ffc407bf869290ab9d0cc81b9ae38bde65b9dc52d5b",
    "Sources/Slotstream/VQRecordReadBatch.swift": "1eae4e09e69bf0a16cfb55721f004b36aa038c6745ec4f3b05e3a41b21f678fc",
    "Sources/Slotstream/VQRecordReadPlan.swift": "2cc1f093b52aaac1bf19fb75ba76ca347da08a026a8cadc673b2ccf3d2f5ff7e",
    "Sources/Slotstream/VQResidentText.swift": "4ac08a39de539afef273d7925779a9ce175319d21bf6c44b3205ef20393c9592",
    "Sources/Slotstream/VQRotaryTable.swift": "effaca0017e9bf7047f181e4e63de212aa64e6e3531278902b7d6353bcd619c1",
    "Sources/Slotstream/VQRouteStream.swift": "b4bf62f52ffe7cc3a8a6daece599f2fb077b65da2e5911f5f273f8d414e487ab",
    "Sources/Slotstream/VQTensorFile.swift": "7ef2321dd987d6a00278caf7e1db46dbb95f83c7a0748a3d61560aff4e7af4b4",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "757a043ff42418a5f086d8da28f6a4341a0ac0a3eb8a8798f98a4e7c314e4bae",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "d8b13e8f392d9acb60ea5f025b030efae0172327e4661bb4aaf8b4b79d4ff6a6",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "dd76f433694eb5102341459c6a5c7840dc2993caa93782b03ef6dbbd0f354f45",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "676209813620c2aaf7992bf03bd1fa6f108a9898ebd0e9cb4ab863afbf7fedc1",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "56fa55727208beb6761655968a07b3eb2dcd8f86b87c432eb760cf594608c73f",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "e45368026379cfc92c7a0da4cf444ee15da3a18c5771e40d004e1e3c294ef998",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "09dba0de0a4748a5b9e1200be727980978954206ed9b53847b6e0a5bafd37f91",
  "binary_sha256": "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
