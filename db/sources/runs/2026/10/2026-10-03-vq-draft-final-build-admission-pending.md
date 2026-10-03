---
type: run
created: 2026-10-03T16:09:11.983729+00:00
updated: 2026-10-03T16:09:11.983729+00:00
summary: Final draft build succeeds but broader local acceptance remains unlaunched under external inference contention
binary: 823aad82d9ce417e96b6d7e2b8fe821b5d6405af382f762406ddef0ee66b70ea
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Final draft build succeeds but broader local acceptance remains unlaunched under external inference contention
tool: bounded VQ research diagnostics
---

The final source-bound native build succeeds. The head implementation and authenticated weight loader have identical source hashes to the already exact component producer. The final native delta adds a new-output refusal and weights-free configuration/budget checks; its model-loaded acceptance is not claimed from the earlier binary.

The first broader acceptance campaign fails its thirteen-GB real-memory preflight before any child launches. A separately frozen campaign requires both original native and external memory observations to exceed each cell's original bound for thirty seconds, within a ten-minute admission deadline. No cell launches. Inspection then finds a separate llama-server workload; only this task's idle waiter is interrupted, with the original campaign retaining KeyboardInterrupt and zero runs. The unrelated model is left untouched. These are unlaunched acceptance campaigns, not numerical failures or throughput measurements.

The shared quiet preflight now also refuses known llama.cpp model-bearing entrypoints because they do not take Slotstream's private lock. Names are not a complete detector for arbitrary Python inference. Twelve context-qualification tests pass, including refusal before the memory path, ordinary unrelated processes and observation failure. A real read-only preflight reproduces explicit llama-server refusal without launching a model. Thirty-two static-entrypoint tests pass, including forwarding the chosen binary into the new process-lock gate and failing when that gate fails or is missing. Brain validation reports zero errors/warnings and all 349 public claim checks pass at the recorded checkpoint.

Earlier committed exact draft component parity and twelve real input refusals remain their own evidence. The full local static/catalogue and existing affine draft/vision/row regressions remain pending for the final build. Because the preflight helper contributes to reference producer identity, new independent reference campaigns must bind the changed instrument and establish their required traversal proof anew; prior source-bound evidence is preserved, not rewritten. The whole quantization/Auto plan remains incomplete and no twenty-token profile is qualified.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### capture-vq-draft-admission-pending-v1.py

Original bytes: 3831. SHA-256: `3ea0192218f4dc51f1807f2981e3a1dbb19716fbcd7d7f4172ba9d3c02656c76`.

Normalized bytes: 3831. SHA-256: `3ea0192218f4dc51f1807f2981e3a1dbb19716fbcd7d7f4172ba9d3c02656c76`.

````text
from pathlib import Path
import json,runpy,shutil
r=Path('.build/quantization-research');a=json.loads((r/'vq-draft-acceptance-v1/run.json').read_text());b=json.loads((r/'vq-draft-acceptance-v2/run.json').read_text())
assert not a['complete'] and not b['complete'] and not a['runs'] and not b['runs']
assert 'KeyboardInterrupt' in b['failure']
for name in ('context_qualification.py','context_qualification_checks.py','mtp_process_guard_gate.py','static_gates.sh','static_gates_binary_test.py'):
 shutil.copy2(Path('Tools')/name,r/('draft-admission-final-'+name))
files=['capture-vq-draft-admission-pending-v1.py','vq-draft-build-preflight-v2.json','vq-draft-build-v2/manifest.json','vq-draft-build-v2/build.txt','run-vq-draft-acceptance-v1.py','vq-draft-acceptance-v1/run.json','vq-draft-acceptance-v1.log','run-vq-draft-acceptance-v2.py','vq-draft-acceptance-v2/run.json','vq-draft-acceptance-v2.log','vq-draft-acceptance-v2/catalogue-admission.json','vq-draft-acceptance-contention-v1.json','vq-draft-static-entrypoint-v2.log','vq-draft-external-process-tests-v1.log','vq-draft-external-process-preflight-v1.json','vq-draft-brain-v1.log']
files += ['draft-admission-final-'+name for name in ('context_qualification.py','context_qualification_checks.py','mtp_process_guard_gate.py','static_gates.sh','static_gates_binary_test.py')]
h=runpy.run_path(str(r/'capture-vq-kernel-cache-v1.py'))
h['capture']('vq-draft-final-build-admission-pending','Final draft build succeeds but broader local acceptance remains unlaunched under external inference contention', '''The final source-bound native build succeeds. The head implementation and authenticated weight loader have identical source hashes to the already exact component producer. The final native delta adds a new-output refusal and weights-free configuration/budget checks; its model-loaded acceptance is not claimed from the earlier binary.

The first broader acceptance campaign fails its thirteen-GB real-memory preflight before any child launches. A separately frozen campaign requires both original native and external memory observations to exceed each cell's original bound for thirty seconds, within a ten-minute admission deadline. No cell launches. Inspection then finds a separate llama-server workload; only this task's idle waiter is interrupted, with the original campaign retaining KeyboardInterrupt and zero runs. The unrelated model is left untouched. These are unlaunched acceptance campaigns, not numerical failures or throughput measurements.

The shared quiet preflight now also refuses known llama.cpp model-bearing entrypoints because they do not take Slotstream's private lock. Names are not a complete detector for arbitrary Python inference. Twelve context-qualification tests pass, including refusal before the memory path, ordinary unrelated processes and observation failure. A real read-only preflight reproduces explicit llama-server refusal without launching a model. Thirty-two static-entrypoint tests pass, including forwarding the chosen binary into the new process-lock gate and failing when that gate fails or is missing. Brain validation reports zero errors/warnings and all 349 public claim checks pass at the recorded checkpoint.

Earlier committed exact draft component parity and twelve real input refusals remain their own evidence. The full local static/catalogue and existing affine draft/vision/row regressions remain pending for the final build. Because the preflight helper contributes to reference producer identity, new independent reference campaigns must bind the changed instrument and establish their required traversal proof anew; prior source-bound evidence is preserved, not rewritten. The whole quantization/Auto plan remains incomplete and no twenty-token profile is qualified.''',files,'vq-draft-build-v2/candidate')
````

### vq-draft-build-preflight-v2.json

Original bytes: 1975. SHA-256: `0da1bd1430a5560e932defffa1f112aae9f2aff91c8ae8422211e758ab0cea5d`.

Normalized bytes: 1975. SHA-256: `0da1bd1430a5560e932defffa1f112aae9f2aff91c8ae8422211e758ab0cea5d`.

````text
{'page_bytes': 16384, 'reclaimable_bytes': 13856489472, 'swapins': 44, 'swapouts': 2908, 'raw': 'Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   101836.\nPages active:                                1083166.\nPages inactive:                              1075975.\nPages speculative:                              9442.\nPages throttled:                                   0.\nPages wired down:                             235560.\nPages purgeable:                               14889.\n"Translation faults":                     2001534790.\nPages copy-on-write:                       100505263.\nPages zero filled:                        3297234043.\nPages reactivated:                         174785891.\nPages purged:                               12887983.\nFile-backed pages:                            729008.\nAnonymous pages:                             1439575.\nPages stored in compressor:                  1048908.\nPages occupied by compressor:                 579237.\nDecompressions:                            105564049.\nCompressions:                              119538632.\nPageins:                                  2384036834.\nPageouts:                                     492540.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 143496.\nPages tagged resident:                        109528.\nPages tagged compressed:                       33968.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5629.\nPages tag-storage free:                          218.\nPages tag-storage non-tag pageable:            92449.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5209152.\nTagged compressions:                          761425.\nTagged decompressions:                        638097.\n'}
````

### vq-draft-build-v2/manifest.json

Original bytes: 37898. SHA-256: `c3758af990313378373df9f940155805bb4b0059971594e40bda8ec4ecde5bfa`.

Normalized bytes: 37884. SHA-256: `fdd7693682d2fb59e2d09dde43d0f94e49e13167b47e0edd72afce813f8ca289`.

````text
{
  "classification": "build only; no runtime performance evidence",
  "required_reclaimable_gb": 13,
  "model_lock_held_during_build": true,
  "passed": true,
  "command": [
    "make",
    "build",
    "SLOTSTREAM_BUILD_JOBS=4"
  ],
  "working_directory": "<HOME>/Projects/slotstream",
  "reservation_wait_limit_seconds": 0,
  "build_jobs": 4,
  "reservation_wait": {
    "seconds": 2.541986759752035e-06,
    "attempts": 1
  },
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 13858521088,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   101953.\nPages active:                                1083137.\nPages inactive:                              1076014.\nPages speculative:                              9413.\nPages throttled:                                   0.\nPages wired down:                             235545.\nPages purgeable:                               14889.\n\"Translation faults\":                     2001537890.\nPages copy-on-write:                       100505600.\nPages zero filled:                        3297234974.\nPages reactivated:                         174785891.\nPages purged:                               12887983.\nFile-backed pages:                            729015.\nAnonymous pages:                             1439549.\nPages stored in compressor:                  1048908.\nPages occupied by compressor:                 579237.\nDecompressions:                            105564049.\nCompressions:                              119538632.\nPageins:                                  2384036835.\nPageouts:                                     492540.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 143496.\nPages tagged resident:                        109528.\nPages tagged compressed:                       33968.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5629.\nPages tag-storage free:                          218.\nPages tag-storage non-tag pageable:            92449.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5209152.\nTagged compressions:                          761425.\nTagged decompressions:                        638097.\n"
  },
  "exit_code": 0,
  "frozen": {
    "binary": "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
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
        "Sources/Slotstream/MTP.swift": "5319a480bd7b12ebad6223b6b0a6a4de32791ed1d1b8a4a3b41c9b4db04ae740",
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
        "Sources/Slotstream/VQDraftWeights.swift": "232799bd52934647ea792473111ab1b671f1c6b563c7980c16036f2eeff10e72",
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
        "Sources/SlotstreamDiagnostics/Diagnostics+VQDraft.swift": "38e87802b41df47be62bfc8ae33b7e8992a28c97c97eed2606803498b475cb41",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "92b4ccad53dae57a23db4fb996db7e7a6e08b395c3c3102ebaeebe8e7c17f059",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "1d8139be68d72fbd6eacdbb22de07421abece787fe75e63b2e6623dbc11b66ba",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "0669a24eee258eee4c9dc00fbc88350a62d8654ee5ff89093614a2f96ad79e31",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "11da19085bd0f874b4741a542a298f286bf51091b9170fb8a2cabd4b7e399d4f",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
        "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "31de09d8efc8951692f60fc9f5c4ec4d14dbef5b67656da18bca519ab4bcbcee",
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
        "Sources/slotstream-cli/QuantizationCommands.swift": "50ea6769debcb32efa23b89ae9230a0d756a521347af177f189adf9592922c2b",
        "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
        "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
        "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
        "Sources/slotstream-cli/main.swift": "f03d81008110268bba7c5a8146dbf37db33ee3fbfde3ca3b2e49be1531a7b167",
        "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
        "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
        "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
      },
      "source_archive_sha256": "8e5d4dfae78d4c40a7eae9be7231a992862a123127655677554f8d4b0106293a",
      "binary_sha256": "823aad82d9ce417e96b6d7e2b8fe821b5d6405af382f762406ddef0ee66b70ea",
      "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
    }
  },
  "checks_sha256": "91ce2a4457dcc94fd60f2a009da372e9f7c68b3b12135f389ff0c2ae6cf64d25",
  "elapsed_seconds": 92.01832337499945,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 13423804416,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    86233.\nPages active:                                1077992.\nPages inactive:                              1078207.\nPages speculative:                             29875.\nPages throttled:                                   0.\nPages wired down:                             234971.\nPages purgeable:                                6152.\n\"Translation faults\":                     2002953673.\nPages copy-on-write:                       100625941.\nPages zero filled:                        3300734522.\nPages reactivated:                         174786498.\nPages purged:                               12888798.\nFile-backed pages:                            726939.\nAnonymous pages:                             1459135.\nPages stored in compressor:                  1046841.\nPages occupied by compressor:                 578216.\nDecompressions:                            105566079.\nCompressions:                              119538632.\nPageins:                                  2384075372.\nPageouts:                                     492729.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 143568.\nPages tagged resident:                        109619.\nPages tagged compressed:                       33949.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5629.\nPages tag-storage free:                          148.\nPages tag-storage non-tag pageable:            92519.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5205824.\nTagged compressions:                          761425.\nTagged decompressions:                        638116.\n"
  }
}
````

### vq-draft-build-v2/build.txt

Original bytes: 10431. SHA-256: `202b00f50282f02eb12fe24f6b7359037a0d123e11214ce3cfd0324128fd2a2a`.

Normalized bytes: 10312. SHA-256: `ba26a05fdcdc4af1a7df31fb015265c492cd50789657d707dd5f376f70223a2a`.

````text
python3 Tools/build_identity.py before "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
swift build -c release -j 4
[1/1] Compiling plugin GenerateManual
[2/2] Compiling plugin GenerateDoccReference
Building for production...
[2/6] Write sources
[3/6] Write swift-version--1AB21518FC5DEDBE.txt
[5/7] Compiling SlotstreamDiagnostics CheckReport.swift
<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift:277:20: warning: instance method 'wait' is unavailable from asynchronous contexts; Await a Task handle instead; this is an error in the Swift 6 language mode
275 |         }
276 |         defer { release.signal() }
277 |         guard held.wait(timeout: .now() + 5) == .success else { throw ModelError("queue holder did not start") }
    |                    `- warning: instance method 'wait' is unavailable from asynchronous contexts; Await a Task handle instead; this is an error in the Swift 6 language mode
278 |         var queueChecks: UInt64 = 0
279 |         let queueConfig = try ContextConfiguration(maxContextTokens: 65536, maxPrefillWaitMinutes: 1)

Dispatch.DispatchSemaphore.wait:2:13: note: 'wait(timeout:)' declared here
1 | class DispatchSemaphore {
2 | public func wait(timeout: DispatchTime) -> DispatchTimeoutResult}
  |             `- note: 'wait(timeout:)' declared here
3 | 

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift:293:21: warning: instance method 'wait' is unavailable from asynchronous contexts; Await a Task handle instead; this is an error in the Swift 6 language mode
291 |         }
292 |         release.signal()
293 |         guard ended.wait(timeout: .now() + 5) == .success else { throw ModelError("queue holder did not finish") }
    |                     `- warning: instance method 'wait' is unavailable from asynchronous contexts; Await a Task handle instead; this is an error in the Swift 6 language mode
294 |         // Checked legacy mutation cannot enlarge an already allocated engine.
295 |         engine.maxContextTokens = ContextPolicy.modelLimit

Dispatch.DispatchSemaphore.wait:2:13: note: 'wait(timeout:)' declared here
1 | class DispatchSemaphore {
2 | public func wait(timeout: DispatchTime) -> DispatchTimeoutResult}
  |             `- note: 'wait(timeout:)' declared here
3 | 

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift:35:38: warning: capture of 'server' with non-Sendable type 'Server' in a '@Sendable' closure [#SendableClosureCaptures]
 33 |             }
 34 |             let finished = DispatchSemaphore(value: 0)
 35 |             Thread.detachNewThread { server.handle(peer); finished.signal() }
    |                                      `- warning: capture of 'server' with non-Sendable type 'Server' in a '@Sendable' closure [#SendableClosureCaptures]
 36 |             defer { shutdown(client,SHUT_RDWR); close(client) }
 37 |             let method = object == nil ? "GET" : "POST"

<HOME>/Projects/slotstream/Sources/Slotstream/Server.swift:14:20: note: class 'Server' does not conform to the 'Sendable' protocol
  12 | }
  13 | 
  14 | public final class Server {
     |                    `- note: class 'Server' does not conform to the 'Sendable' protocol
  15 |     /// Explicit opt-in for local benchmark processes. Ordinary wire responses
  16 |     /// retain their existing schema and do not run the footprint sampler.

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift:4:1: warning: add '@preconcurrency' to suppress 'Sendable'-related warnings from module 'Slotstream'
  2 | import Foundation
  3 | import MLX
  4 | import Slotstream
    | `- warning: add '@preconcurrency' to suppress 'Sendable'-related warnings from module 'Slotstream'
  5 | 
  6 | extension Diagnostics {

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift:273:13: warning: capture of 'engine' with non-Sendable type 'Engine' in a '@Sendable' closure [#SendableClosureCaptures]
271 |         let held = DispatchSemaphore(value: 0), release = DispatchSemaphore(value: 0), ended = DispatchSemaphore(value: 0)
272 |         Thread.detachNewThread {
273 |             engine.withExclusive { held.signal(); release.wait() }
    |             `- warning: capture of 'engine' with non-Sendable type 'Engine' in a '@Sendable' closure [#SendableClosureCaptures]
274 |             ended.signal()
275 |         }

<HOME>/Projects/slotstream/Sources/Slotstream/Engine.swift:83:20: note: class 'Engine' does not conform to the 'Sendable' protocol
  81 | }
  82 | 
  83 | public final class Engine {
     |                    `- note: class 'Engine' does not conform to the 'Sendable' protocol
  84 |     public let modelDir: URL
  85 |     public let model: Qwen4ExpModel

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift:31:38: warning: capture of 'server' with non-Sendable type 'Server' in a '@Sendable' closure [#SendableClosureCaptures]
 29 |             }
 30 |             let finished = DispatchSemaphore(value: 0)
 31 |             Thread.detachNewThread { server.handle(peer); finished.signal() }
    |                                      `- warning: capture of 'server' with non-Sendable type 'Server' in a '@Sendable' closure [#SendableClosureCaptures]
 32 |             defer { shutdown(client,SHUT_RDWR); close(client) }
 33 |             let method = object == nil ? "GET" : "POST"

<HOME>/Projects/slotstream/Sources/Slotstream/Server.swift:14:20: note: class 'Server' does not conform to the 'Sendable' protocol
  12 | }
  13 | 
  14 | public final class Server {
     |                    `- note: class 'Server' does not conform to the 'Sendable' protocol
  15 |     /// Explicit opt-in for local benchmark processes. Ordinary wire responses
  16 |     /// retain their existing schema and do not run the footprint sampler.

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift:5:1: warning: add '@preconcurrency' to suppress 'Sendable'-related warnings from module 'Slotstream'
  3 | import Foundation
  4 | import MLX
  5 | import Slotstream
    | `- warning: add '@preconcurrency' to suppress 'Sendable'-related warnings from module 'Slotstream'
  6 | 
  7 | extension Diagnostics {

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift:8:18: warning: weak variable 'observedOwner' was never mutated; consider changing to 'let' constant [#WeakMutability]
 6 |         var c = CheckBuilder("optimization-read-handle-lifetime")
 7 |         var owner: CheckpointIndex? = try CheckpointIndex(dir: modelDir)
 8 |         weak var observedOwner = owner
   |                  `- warning: weak variable 'observedOwner' was never mutated; consider changing to 'let' constant [#WeakMutability]
 9 |         let ref = owner!.ref("model.layers.0.mlp.switch_mlp.gate_proj.weight")
10 |         var handle: TensorReadHandle? = owner!.readHandle(for: ref)

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift:110:21: warning: will never be executed
107 |             logits.append(last); traces.append(routes)
108 |         }
109 |         if terminalPrefill {
    |            `- note: condition always evaluates to false
110 |             c.equal("all undemanded terminal queries skipped", model.terminalQueryRowsSkipped,
    |                     `- warning: will never be executed
111 |                 terminalQuery ? tokens - min(64, (tokens - 1) % 256 + 1) : tokens - ((tokens - 1) % 256 + 1))
112 |             c.equal("all unused terminal MoE rows skipped", model.terminalMoERowsSkipped, tokens - 1)

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift:117:22: warning: will never be executed
114 |                 Array((traces[0][model.runLayers - 1] ?? []).suffix(model.cfg.topK)))
115 |         }
116 |         if selectedAttention {
    |            `- note: condition always evaluates to false
117 |             c.expect("selected attention actually executed", model.selectedAttentionTiles > 0)
    |                      `- warning: will never be executed
118 |             c.measure("selected_attention_tiles", Double(model.selectedAttentionTiles))
119 |         }

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift:184:29: warning: will never be executed
182 |         c.measure("routing.control", controlRoutes); c.measure("routing.candidate", candidateRoutes)
183 |         c.expect("route keep sets inside existing rechunk band", candidateRoutes <= max(3 * controlRoutes, 0.01))
184 |         if scoped { c.equal("exact ordered router traces", traces[2], traces[0]) }
    |            |                `- warning: will never be executed
    |            `- note: condition always evaluates to false
185 |         if terminalPrefill {
186 |             c.equal("all state-producing layers retain ordered routes", traces[2].filter { $0.key != model.runLayers - 1 },

<HOME>/Projects/slotstream/Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift:186:21: warning: will never be executed
183 |         c.expect("route keep sets inside existing rechunk band", candidateRoutes <= max(3 * controlRoutes, 0.01))
184 |         if scoped { c.equal("exact ordered router traces", traces[2], traces[0]) }
185 |         if terminalPrefill {
    |            `- note: condition always evaluates to false
186 |             c.equal("all state-producing layers retain ordered routes", traces[2].filter { $0.key != model.runLayers - 1 },
    |                     `- warning: will never be executed
187 |                 traces[0].filter { $0.key != model.runLayers - 1 })
188 |         }

[#SendableClosureCaptures]: <https://docs.swift.org/compiler/documentation/diagnostics/sendable-closure-captures>
[#WeakMutability]: <https://docs.swift.org/compiler/documentation/diagnostics/weak-mutability>
[5/9] Write Objects.LinkFileList
[7/9] Linking slotstream-checks
[8/9] Linking slotstream
Build complete! (90.55s)
cp Tools/lib/mlx-0.32.2.metallib .build/release/mlx.metallib
python3 Tools/build_identity.py after "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
````

### run-vq-draft-acceptance-v1.py

Original bytes: 5714. SHA-256: `fe767224e568be6a82232db9ce214db43b367604caa39dc0393ac3c01c209be2`.

Normalized bytes: 5707. SHA-256: `67ce81b47b8c6831c9b8a9e5b68ff3ae37c19e173d504140bc3182e6016a4699`.

````text
from pathlib import Path
from datetime import datetime,timezone
import ctypes,ctypes.util,json,os,subprocess,sys,time
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight
from prefill_bench import terminate_child_tree,vm_snapshot
from quantization_logit_run import digest
r=Path('.build/quantization-research').resolve();out=r/'vq-draft-acceptance-v1';out.mkdir()
f=r/'vq-draft-build-v2/candidate';identity=json.loads((f/'build-identity.json').read_text())
old=json.loads((r/'vq-draft-build-v1/candidate/build-identity.json').read_text())
for path in ('Sources/Slotstream/MTP.swift','Sources/Slotstream/VQDraftWeights.swift'):
 assert identity['source'][path]==old['source'][path]
fixture=r/'vq-composite-draft-v1/reference/comparison.safetensors'
current=r/'vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors'
cells=[
 ('catalogue',[str(f/'slotstream-checks'),'--tier','t0','--tier','t1','--json'],10,13,900),
 ('research-head',[str(f/'slotstream'),'quantization-draft-check','--baseline','<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit','--fixture',str(fixture),'--output',str(out/'research-head-output'),'--reference-arithmetic'],10,13,300),
 ('current-public-head',[str(f/'slotstream'),'mtp-parity','--fixture',str(current)],10,13,300),
 ('draft-stream',[str(f/'slotstream'),'draft-stream-check'],12,15,1800),
 ('mtp-with-vision',[str(f/'slotstream'),'mtp-check','--memory-gb','12','--mtp','on','--vision','on','--image','Tools/assets/vision_test/secret1.jpg'],12,15,1800),
 ('mtp-rows',[str(f/'slotstream'),'mtp-rowcheck','--memory-gb','10'],10,13,1800)]
record={'schema':1,'complete':False,'started_at':datetime.now(timezone.utc).isoformat(),'scope':'Final-build functional acceptance; no timing qualification. Original and streamed draft paths plus production speculation and image interaction.',
 'maximum_model_runs':len(cells),'maximum_seconds':7200,'maximum_concurrent_model_processes':1,
 'ordinary_process_bound_gb':10,'explicit_existing_draft_and_image_process_bound_gb':12,
 'existing_exception_reason':'draft-stream-check explicitly creates sequential resident/streamed twelve-GB plans; mtp-check with vision has its documented twelve-GB plan and fifteen-GB real preflight. Other cells keep ten/thirteen.',
 'producer':identity,'protocol':[{'name':n,'command':c,'max_process_gb':p,'preflight_gb':v,'timeout_seconds':t} for n,c,p,v,t in cells],
 'bound_inputs':{str(p):digest(p) for p in [Path(__file__),fixture,current,Path('Tools/reference/mtp_ref.py'),Path('Tools/reference/qwen4_exp.py')]},'runs':[]}
def save():(out/'run.json').write_text(json.dumps(record,indent=2)+'\n')
save();started=time.monotonic();env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG','VQ_','VQLAB_'))}
lib=ctypes.CDLL(ctypes.util.find_library('proc'))
def invoke(name,command,limit,preflight,timeout):
 assert digest(f/'slotstream')==identity['binary_sha256'] and all(digest(Path(p))==h for p,h in record['bound_inputs'].items())
 before=quiet_preflight(preflight);cell=out/name;cell.mkdir();row={'name':name,'command':command,'before':before,'removed_override_names':sorted(set(os.environ)-set(env)),'failure':None};record['runs'].append(row);save()
 peak=samples=0;last_pressure=0;child=None;began=time.monotonic()
 try:
  with (cell/'stdout.txt').open('w') as stdout,(cell/'stderr.txt').open('w') as stderr:
   child=subprocess.Popen(command,env=env,stdout=stdout,stderr=stderr,start_new_session=True)
   while child.poll() is None:
    usage=ctypes.create_string_buffer(296)
    if lib.proc_pid_rusage(child.pid,4,usage)==0:
     footprint=max(int.from_bytes(usage.raw[72:80],'little'),int.from_bytes(usage.raw[240:248],'little'));peak=max(peak,footprint);samples+=1
     if footprint>limit*1000000000:raise RuntimeError('cell exceeded explicit process envelope')
    elif child.poll() is None:raise RuntimeError('cannot observe child footprint')
    now=time.monotonic()
    if now-last_pressure>=1:
     if subprocess.check_output(['sysctl','-n','kern.memorystatus_vm_pressure_level'],text=True,timeout=5).strip()!='1':raise RuntimeError('OS memory pressure')
     if vm_snapshot()['reclaimable_bytes']<3000000000:raise RuntimeError('lost three-GB headroom')
     last_pressure=now
    if now-began>timeout or now-started>7200:raise RuntimeError('execution time bound')
    time.sleep(.05)
   if child.returncode!=0 or not samples:raise RuntimeError('functional child failed or has no footprint observation')
  text=(cell/'stdout.txt').read_text()
  if name=='research-head':assert json.loads((out/'research-head-output/receipt.json').read_text())['passed']
  if name=='current-public-head':assert 'MTP PARITY PASS' in text
  if name=='draft-stream':assert 'DRAFT STREAM CHECK PASS' in text and 'FAIL' not in text
  if name=='mtp-with-vision':
   assert 'MTP CHECK PASS' in text and 'SKIP' not in text
   checks=[json.loads(line.removeprefix('MTP CHECK MEMORY ')) for line in text.splitlines() if line.startswith('MTP CHECK MEMORY ')]
   assert checks and all(x['memory_validated'] for x in checks)
 except BaseException as error:row['failure']=repr(error);raise
 finally:
  if child is not None and child.poll() is None:terminate_child_tree(child)
  row.update(exit_code=None if child is None else child.returncode,sampled_peak_bytes=peak,samples=samples,seconds=time.monotonic()-began,after=vm_snapshot());save()
 print(json.dumps({k:row[k] for k in ['name','exit_code','sampled_peak_bytes','seconds']}),flush=True)
try:
 for cell in cells:invoke(*cell)
 record['complete']=True;record['finished_at']=datetime.now(timezone.utc).isoformat();save()
except BaseException as error:record['failure']=repr(error);save();raise
````

### vq-draft-acceptance-v1/run.json

Original bytes: 36826. SHA-256: `50170f60291a7b822ea60193b539f06118fedd7d47c1ba8d5c71208af8903f63`.

Normalized bytes: 36735. SHA-256: `adf0b928ffcae135c08f5a320ad5c1e8e26b42247374af5241368f6901ad0a56`.

````text
{
  "schema": 1,
  "complete": false,
  "started_at": "2026-10-03T15:56:43.347058+00:00",
  "scope": "Final-build functional acceptance; no timing qualification. Original and streamed draft paths plus production speculation and image interaction.",
  "maximum_model_runs": 6,
  "maximum_seconds": 7200,
  "maximum_concurrent_model_processes": 1,
  "ordinary_process_bound_gb": 10,
  "explicit_existing_draft_and_image_process_bound_gb": 12,
  "existing_exception_reason": "draft-stream-check explicitly creates sequential resident/streamed twelve-GB plans; mtp-check with vision has its documented twelve-GB plan and fifteen-GB real preflight. Other cells keep ten/thirteen.",
  "producer": {
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
      "Sources/Slotstream/MTP.swift": "5319a480bd7b12ebad6223b6b0a6a4de32791ed1d1b8a4a3b41c9b4db04ae740",
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
      "Sources/Slotstream/VQDraftWeights.swift": "232799bd52934647ea792473111ab1b671f1c6b563c7980c16036f2eeff10e72",
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
      "Sources/SlotstreamDiagnostics/Diagnostics+VQDraft.swift": "38e87802b41df47be62bfc8ae33b7e8992a28c97c97eed2606803498b475cb41",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "92b4ccad53dae57a23db4fb996db7e7a6e08b395c3c3102ebaeebe8e7c17f059",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "1d8139be68d72fbd6eacdbb22de07421abece787fe75e63b2e6623dbc11b66ba",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "0669a24eee258eee4c9dc00fbc88350a62d8654ee5ff89093614a2f96ad79e31",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "11da19085bd0f874b4741a542a298f286bf51091b9170fb8a2cabd4b7e399d4f",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "31de09d8efc8951692f60fc9f5c4ec4d14dbef5b67656da18bca519ab4bcbcee",
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
      "Sources/slotstream-cli/QuantizationCommands.swift": "50ea6769debcb32efa23b89ae9230a0d756a521347af177f189adf9592922c2b",
      "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
      "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
      "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
      "Sources/slotstream-cli/main.swift": "f03d81008110268bba7c5a8146dbf37db33ee3fbfde3ca3b2e49be1531a7b167",
      "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
      "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
      "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
    },
    "source_archive_sha256": "8e5d4dfae78d4c40a7eae9be7231a992862a123127655677554f8d4b0106293a",
    "binary_sha256": "823aad82d9ce417e96b6d7e2b8fe821b5d6405af382f762406ddef0ee66b70ea",
    "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "protocol": [
    {
      "name": "catalogue",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream-checks",
        "--tier",
        "t0",
        "--tier",
        "t1",
        "--json"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 900
    },
    {
      "name": "research-head",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "quantization-draft-check",
        "--baseline",
        "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
        "--fixture",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference/comparison.safetensors",
        "--output",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-acceptance-v1/research-head-output",
        "--reference-arithmetic"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 300
    },
    {
      "name": "current-public-head",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "mtp-parity",
        "--fixture",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 300
    },
    {
      "name": "draft-stream",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "draft-stream-check"
      ],
      "max_process_gb": 12,
      "preflight_gb": 15,
      "timeout_seconds": 1800
    },
    {
      "name": "mtp-with-vision",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "mtp-check",
        "--memory-gb",
        "12",
        "--mtp",
        "on",
        "--vision",
        "on",
        "--image",
        "Tools/assets/vision_test/secret1.jpg"
      ],
      "max_process_gb": 12,
      "preflight_gb": 15,
      "timeout_seconds": 1800
    },
    {
      "name": "mtp-rows",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "mtp-rowcheck",
        "--memory-gb",
        "10"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 1800
    }
  ],
  "bound_inputs": {
    "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-draft-acceptance-v1.py": "fe767224e568be6a82232db9ce214db43b367604caa39dc0393ac3c01c209be2",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference/comparison.safetensors": "75061cdf20bf1221448ef07e5a07442bd0f26a101bfc788b78717a93feb8c032",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors": "b754211cb78ab072dc8204e375df727df0bbfa4aa606c087c138c2d49f8362c4",
    "Tools/reference/mtp_ref.py": "f28827ac0409fe58b9c255f16add5ecb00b17a2310a3521d75a677f2d4a84f24",
    "Tools/reference/qwen4_exp.py": "6fae4ec0decbf77ca4a4571de683bc5580ec75e84325ecb432dfcd2fc81df75e"
  },
  "runs": [],
  "failure": "InsufficientHeadroom('11.85 GB reclaimable; need 13.00 GB')"
}
````

### vq-draft-acceptance-v1.log

Original bytes: 1055. SHA-256: `2a71e5fbd2d62aee7ae0861329007dbd38fa9c3732778ca4bf14fc384ebbd796`.

Normalized bytes: 1027. SHA-256: `0a94b169bc05921792905dc3ac34a3f1eac535b2b35c98ba85622dbd69d849d8`.

````text
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-draft-acceptance-v1.py", line 66, in <module>
    for cell in cells:invoke(*cell)
                      ^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-draft-acceptance-v1.py", line 33, in invoke
    before=quiet_preflight(preflight);cell=out/name;cell.mkdir();row={'name':name,'command':command,'before':before,'removed_override_names':sorted(set(os.environ)-set(env)),'failure':None};record['runs'].append(row);save()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/context_qualification.py", line 58, in quiet_preflight
    return preflight(needed_gb)
           ^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/prefill_bench.py", line 56, in preflight
    raise InsufficientHeadroom(f"{state['reclaimable_bytes']/1e9:.2f} GB reclaimable; need {needed_gb:.2f} GB")
prefill_bench.InsufficientHeadroom: 11.85 GB reclaimable; need 13.00 GB
````

### run-vq-draft-acceptance-v2.py

Original bytes: 7510. SHA-256: `eaf24b9dbae02bdfa5de585cbb7dc20ebe4f5bab6efafa75e179bb4dbbf20493`.

Normalized bytes: 7503. SHA-256: `558cf0ea8a516ee9108439cc2cfed580064cc5d44551d37a26d3bf8294edadea`.

````text
from pathlib import Path
from datetime import datetime,timezone
import ctypes,ctypes.util,json,os,subprocess,sys,time
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight
from prefill_bench import terminate_child_tree,vm_snapshot
from quantization_logit_run import digest
r=Path('.build/quantization-research').resolve();out=r/'vq-draft-acceptance-v2';out.mkdir()
f=r/'vq-draft-build-v2/candidate';identity=json.loads((f/'build-identity.json').read_text())
old=json.loads((r/'vq-draft-build-v1/candidate/build-identity.json').read_text())
for path in ('Sources/Slotstream/MTP.swift','Sources/Slotstream/VQDraftWeights.swift'):
 assert identity['source'][path]==old['source'][path]
fixture=r/'vq-composite-draft-v1/reference/comparison.safetensors'
current=r/'vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors'
cells=[
 ('catalogue',[str(f/'slotstream-checks'),'--tier','t0','--tier','t1','--json'],10,13,900),
 ('research-head',[str(f/'slotstream'),'quantization-draft-check','--baseline','<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit','--fixture',str(fixture),'--output',str(out/'research-head-output'),'--reference-arithmetic'],10,13,300),
 ('current-public-head',[str(f/'slotstream'),'mtp-parity','--fixture',str(current)],10,13,300),
 ('draft-stream',[str(f/'slotstream'),'draft-stream-check'],12,15,1800),
 ('mtp-with-vision',[str(f/'slotstream'),'mtp-check','--memory-gb','12','--mtp','on','--vision','on','--image','Tools/assets/vision_test/secret1.jpg'],12,15,1800),
 ('mtp-rows',[str(f/'slotstream'),'mtp-rowcheck','--memory-gb','10'],10,13,1800)]
record={'schema':1,'complete':False,'started_at':datetime.now(timezone.utc).isoformat(),'scope':'Final-build functional acceptance; no timing qualification. Original and streamed draft paths plus production speculation and image interaction.',
 'maximum_model_runs':len(cells),'maximum_seconds':7200,'maximum_concurrent_model_processes':1,
 'ordinary_process_bound_gb':10,'explicit_existing_draft_and_image_process_bound_gb':12,
 'existing_exception_reason':'draft-stream-check explicitly creates sequential resident/streamed twelve-GB plans; mtp-check with vision has its documented twelve-GB plan and fifteen-GB real preflight. Other cells keep ten/thirteen.',
 'producer':identity,'protocol':[{'name':n,'command':c,'max_process_gb':p,'preflight_gb':v,'timeout_seconds':t} for n,c,p,v,t in cells],
 'bound_inputs':{str(p):digest(p) for p in [Path(__file__),fixture,current,Path('Tools/reference/mtp_ref.py'),Path('Tools/reference/qwen4_exp.py')]},'runs':[]}
def save():(out/'run.json').write_text(json.dumps(record,indent=2)+'\n')
record['prior_unlaunched_campaign']={'path':'vq-draft-acceptance-v1/run.json','sha256':digest(r/'vq-draft-acceptance-v1/run.json'),'reason':'13 GB preflight refusal before any native launch; preserved unchanged'};record['admission']='Independent native/external observations must both cover each frozen cell threshold for thirty seconds within six hundred seconds; one launch per cell, no automatic retries';save();started=time.monotonic();env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG','VQ_','VQLAB_'))}
lib=ctypes.CDLL(ctypes.util.find_library('proc'))
def stable_admission(name,required):
 observer=r/'vq-pilot-admission-observer-v1';pin=json.loads((observer/'build.json').read_text())
 assert digest(observer/'observer')==pin['observer_sha256']
 assert digest(observer/'observer.swift')==pin['observer_source_sha256']
 assert pin['engine_source_sha256']==identity['source']['Sources/Slotstream/ProcessMemory.swift']
 began=time.monotonic();good_since=None;observations=[]
 while True:
  native=json.loads(subprocess.check_output([str(observer/'observer')],text=True,timeout=10));external=vm_snapshot();now=time.monotonic()
  good=(external['reclaimable_bytes']>=required*1e9 and native['vm']['reclaimableBytes']>=required*1e9)
  if not good:good_since=None
  elif good_since is None:good_since=now
  stable=0 if good_since is None else now-good_since
  observations.append({'seconds':now-began,'stable_seconds':stable,'required_gb':required,'eligible':good,'native':native,'external':external})
  passed=good and stable>=30 and now-began<=600
  (out/(name+'-admission.json')).write_text(json.dumps({'passed':passed,'maximum_wait_seconds':600,'required_stable_seconds':30,'observer':pin,'samples':observations},indent=2)+'\n')
  if passed:return quiet_preflight(required)
  if now-began>=600:raise RuntimeError('real memory never remained sufficient for thirty seconds before admission deadline')
  time.sleep(min(5,600-(now-began)))
def invoke(name,command,limit,preflight,timeout):
 assert digest(f/'slotstream')==identity['binary_sha256'] and all(digest(Path(p))==h for p,h in record['bound_inputs'].items())
 before=stable_admission(name,preflight);cell=out/name;cell.mkdir();row={'name':name,'command':command,'before':before,'removed_override_names':sorted(set(os.environ)-set(env)),'failure':None};record['runs'].append(row);save()
 peak=samples=0;last_pressure=0;child=None;began=time.monotonic()
 try:
  with (cell/'stdout.txt').open('w') as stdout,(cell/'stderr.txt').open('w') as stderr:
   child=subprocess.Popen(command,env=env,stdout=stdout,stderr=stderr,start_new_session=True)
   while child.poll() is None:
    usage=ctypes.create_string_buffer(296)
    if lib.proc_pid_rusage(child.pid,4,usage)==0:
     footprint=max(int.from_bytes(usage.raw[72:80],'little'),int.from_bytes(usage.raw[240:248],'little'));peak=max(peak,footprint);samples+=1
     if footprint>limit*1000000000:raise RuntimeError('cell exceeded explicit process envelope')
    elif child.poll() is None:raise RuntimeError('cannot observe child footprint')
    now=time.monotonic()
    if now-last_pressure>=1:
     if subprocess.check_output(['sysctl','-n','kern.memorystatus_vm_pressure_level'],text=True,timeout=5).strip()!='1':raise RuntimeError('OS memory pressure')
     if vm_snapshot()['reclaimable_bytes']<3000000000:raise RuntimeError('lost three-GB headroom')
     last_pressure=now
    if now-began>timeout or now-started>7200:raise RuntimeError('execution time bound')
    time.sleep(.05)
   if child.returncode!=0 or not samples:raise RuntimeError('functional child failed or has no footprint observation')
  text=(cell/'stdout.txt').read_text()
  if name=='research-head':assert json.loads((out/'research-head-output/receipt.json').read_text())['passed']
  if name=='current-public-head':assert 'MTP PARITY PASS' in text
  if name=='draft-stream':assert 'DRAFT STREAM CHECK PASS' in text and 'FAIL' not in text
  if name=='mtp-with-vision':
   assert 'MTP CHECK PASS' in text and 'SKIP' not in text
   checks=[json.loads(line.removeprefix('MTP CHECK MEMORY ')) for line in text.splitlines() if line.startswith('MTP CHECK MEMORY ')]
   assert checks and all(x['memory_validated'] for x in checks)
 except BaseException as error:row['failure']=repr(error);raise
 finally:
  if child is not None and child.poll() is None:terminate_child_tree(child)
  row.update(exit_code=None if child is None else child.returncode,sampled_peak_bytes=peak,samples=samples,seconds=time.monotonic()-began,after=vm_snapshot());save()
 print(json.dumps({k:row[k] for k in ['name','exit_code','sampled_peak_bytes','seconds']}),flush=True)
try:
 for cell in cells:invoke(*cell)
 record['complete']=True;record['finished_at']=datetime.now(timezone.utc).isoformat();save()
except BaseException as error:record['failure']=repr(error);save();raise
````

### vq-draft-acceptance-v2/run.json

Original bytes: 37230. SHA-256: `f938a0c276da6da22b006bad8af395ef14825c8ff5e255529415b8df2600cd65`.

Normalized bytes: 37139. SHA-256: `e2ef0982ccbd9ff5340479c42c528455be748cc521354ca204cb8f3a36edb1aa`.

````text
{
  "schema": 1,
  "complete": false,
  "started_at": "2026-10-03T15:58:36.534734+00:00",
  "scope": "Final-build functional acceptance; no timing qualification. Original and streamed draft paths plus production speculation and image interaction.",
  "maximum_model_runs": 6,
  "maximum_seconds": 7200,
  "maximum_concurrent_model_processes": 1,
  "ordinary_process_bound_gb": 10,
  "explicit_existing_draft_and_image_process_bound_gb": 12,
  "existing_exception_reason": "draft-stream-check explicitly creates sequential resident/streamed twelve-GB plans; mtp-check with vision has its documented twelve-GB plan and fifteen-GB real preflight. Other cells keep ten/thirteen.",
  "producer": {
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
      "Sources/Slotstream/MTP.swift": "5319a480bd7b12ebad6223b6b0a6a4de32791ed1d1b8a4a3b41c9b4db04ae740",
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
      "Sources/Slotstream/VQDraftWeights.swift": "232799bd52934647ea792473111ab1b671f1c6b563c7980c16036f2eeff10e72",
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
      "Sources/SlotstreamDiagnostics/Diagnostics+VQDraft.swift": "38e87802b41df47be62bfc8ae33b7e8992a28c97c97eed2606803498b475cb41",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "92b4ccad53dae57a23db4fb996db7e7a6e08b395c3c3102ebaeebe8e7c17f059",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "1d8139be68d72fbd6eacdbb22de07421abece787fe75e63b2e6623dbc11b66ba",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "0669a24eee258eee4c9dc00fbc88350a62d8654ee5ff89093614a2f96ad79e31",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "11da19085bd0f874b4741a542a298f286bf51091b9170fb8a2cabd4b7e399d4f",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
      "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "31de09d8efc8951692f60fc9f5c4ec4d14dbef5b67656da18bca519ab4bcbcee",
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
      "Sources/slotstream-cli/QuantizationCommands.swift": "50ea6769debcb32efa23b89ae9230a0d756a521347af177f189adf9592922c2b",
      "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
      "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
      "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
      "Sources/slotstream-cli/main.swift": "f03d81008110268bba7c5a8146dbf37db33ee3fbfde3ca3b2e49be1531a7b167",
      "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
      "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
      "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
    },
    "source_archive_sha256": "8e5d4dfae78d4c40a7eae9be7231a992862a123127655677554f8d4b0106293a",
    "binary_sha256": "823aad82d9ce417e96b6d7e2b8fe821b5d6405af382f762406ddef0ee66b70ea",
    "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "protocol": [
    {
      "name": "catalogue",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream-checks",
        "--tier",
        "t0",
        "--tier",
        "t1",
        "--json"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 900
    },
    {
      "name": "research-head",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "quantization-draft-check",
        "--baseline",
        "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
        "--fixture",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference/comparison.safetensors",
        "--output",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-acceptance-v2/research-head-output",
        "--reference-arithmetic"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 300
    },
    {
      "name": "current-public-head",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "mtp-parity",
        "--fixture",
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 300
    },
    {
      "name": "draft-stream",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "draft-stream-check"
      ],
      "max_process_gb": 12,
      "preflight_gb": 15,
      "timeout_seconds": 1800
    },
    {
      "name": "mtp-with-vision",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "mtp-check",
        "--memory-gb",
        "12",
        "--mtp",
        "on",
        "--vision",
        "on",
        "--image",
        "Tools/assets/vision_test/secret1.jpg"
      ],
      "max_process_gb": 12,
      "preflight_gb": 15,
      "timeout_seconds": 1800
    },
    {
      "name": "mtp-rows",
      "command": [
        "<HOME>/Projects/slotstream/.build/quantization-research/vq-draft-build-v2/candidate/slotstream",
        "mtp-rowcheck",
        "--memory-gb",
        "10"
      ],
      "max_process_gb": 10,
      "preflight_gb": 13,
      "timeout_seconds": 1800
    }
  ],
  "bound_inputs": {
    "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-draft-acceptance-v2.py": "eaf24b9dbae02bdfa5de585cbb7dc20ebe4f5bab6efafa75e179bb4dbbf20493",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference/comparison.safetensors": "75061cdf20bf1221448ef07e5a07442bd0f26a101bfc788b78717a93feb8c032",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-reference-repair-v1/mtp-reference/comparison.safetensors": "b754211cb78ab072dc8204e375df727df0bbfa4aa606c087c138c2d49f8362c4",
    "Tools/reference/mtp_ref.py": "f28827ac0409fe58b9c255f16add5ecb00b17a2310a3521d75a677f2d4a84f24",
    "Tools/reference/qwen4_exp.py": "6fae4ec0decbf77ca4a4571de683bc5580ec75e84325ecb432dfcd2fc81df75e"
  },
  "runs": [],
  "prior_unlaunched_campaign": {
    "path": "vq-draft-acceptance-v1/run.json",
    "sha256": "50170f60291a7b822ea60193b539f06118fedd7d47c1ba8d5c71208af8903f63",
    "reason": "13 GB preflight refusal before any native launch; preserved unchanged"
  },
  "admission": "Independent native/external observations must both cover each frozen cell threshold for thirty seconds within six hundred seconds; one launch per cell, no automatic retries",
  "failure": "KeyboardInterrupt()"
}
````

### vq-draft-acceptance-v2.log

Original bytes: 816. SHA-256: `3bfc42cf8c131f9b559a2dc5d3995310650166a4cf155efd164d703603132ab3`.

Normalized bytes: 795. SHA-256: `6ac153e15fd59c3b39eaab75c2e431de5cce8817ee8510a0fd2d530b5ee19802`.

````text
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-draft-acceptance-v2.py", line 84, in <module>
    for cell in cells:invoke(*cell)
                      ^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-draft-acceptance-v2.py", line 51, in invoke
    before=stable_admission(name,preflight);cell=out/name;cell.mkdir();row={'name':name,'command':command,'before':before,'removed_override_names':sorted(set(os.environ)-set(env)),'failure':None};record['runs'].append(row);save()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-draft-acceptance-v2.py", line 48, in stable_admission
    time.sleep(min(5,600-(now-began)))
KeyboardInterrupt
````

### vq-draft-acceptance-v2/catalogue-admission.json

Original bytes: 218626. SHA-256: `119d29f01e25119e719412572e853387434c96747217bd4325982fae4fca6eac`.

Normalized bytes: 218612. SHA-256: `dcfcb30a409ef15df46a01c5c86c4d91d66850bc31f09d2a9e2c354350eadd20`.

````zlib-base64
eNrtnV2PHFlynu/3VzTmygY0tSe+IxaGAcuW4ZuFBEjwjSUsms3mLG1+jEjOjlaC/rvjZJHNw9mZ
ZZ7wdjqzqjmQdqfJ3CpWVp7znDfeeOPffnVz8833t+/f3z//5jc3L25fvb//q/6j17f/8vL1D69/
9+Ptyw+/e39/9/bN8/f5B7S15bff3f/zDy/f3T//3fsPt89e3Q9/gs5/4O2z9/fv/nD/Ln/yb/nv
+ZP3d7+/f32b/w5/df7B3dvXr2/f9Jf9X8sP+p/58eWLD3ff/NWnf//2bz//9//0P/72t3/zn3/9
d+/e/u/7uw/vf/3+1dsP7z+8u799/evTsx9evnr+63/+4fbNh5f/evvh5ds33767f39/++7u97/+
wz9/+/3L/LPf3j5//fL9+/57n97ct3+AX3/676fltYeXfrvZS3+zvM4/ffxYnt2/ePvu/uFzW27P
d/e/e/bHD/f98wUl54d39u7+7tXty9fLPfj0J5AaNlOB4c+9//H2+5dvlt/1L3749ocPy0+jff75
u9sf80ff/Pb27vc3//Pluw8/3L66+e3967fv/njz9x/yr/j+w8u797+5+Q/9fd28f/mv9zdvX5zf
183yHv7jP775u/yt9zcv3t3f/+ZmzS+LiNOny27vPrz8w9cvBABmoYfLXr5ZdSFAYwp/uOz99/d3
P7y6/fqVAIr6cNmH3797++HDq/vna/6C7eGyH/tTc/P87Y9vvvJijtY+/92+/+Hdd/f9Ln/11Vyj
v8l//OYf3t2+ef9q+Ubmc/3Dqw/v//Gbn78aApXdm8rD6929/f6P3+bX9cd3Lz/88muGgjcbPpR/
vX/39ubFy1d/7mMhEIFmQvBwWT5J/c7dfvhznyYY5u024C8/lK9+/oD5Uqz91f77y1f33z67vfs/
eQv6l/f9n7sWyJ28X/Zf3rx988fXb394//WL+g1gbPH5I3n/4W2/4y/f5Gf6+vtcGt6/ffebn3uX
TQ0+PwNv7+5++P5lXvjsj3/2Qs3HDi0v+2/3n/5Y3vCvvMcwJIjWL/uvqy/qDw4xAeHHN/nyq1f0
XwhkAvnPpyeurzjrFgU2NOlv8u/Pq9e6q86v6h8vW/9qN8si+Pn5vv3uuzUPNxDHw0fy6bL8Rr9/
+fz+zYdfvj4Eg3562adb+MsvTKEU42Xf9i9Y/stX7rhT45+77Ob3b189f/nmu/6zn/mglFB+9rKv
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
X/37r/4vbg62PA==
````

### vq-draft-acceptance-contention-v1.json

Original bytes: 394. SHA-256: `9417e10e6b31a5617be5ddb341d4dd6e3e85dd230d8b9a4c113741e7348dc64f`.

Normalized bytes: 394. SHA-256: `9417e10e6b31a5617be5ddb341d4dd6e3e85dd230d8b9a4c113741e7348dc64f`.

````text
{
  "scope": "Read-only process observation and cancellation of this task own idle admission waiter",
  "reason": "A separate llama-server model process is running. Do not launch a model even if reclaimable memory later rises. Other processes are left untouched.",
  "observed_inference_name": "llama-server",
  "observed_pid": 75477,
  "observed_rss_kib": 6355760,
  "own_waiter_pid": 75389
}
````

### vq-draft-static-entrypoint-v2.log

Original bytes: 132. SHA-256: `ad98bc448cedac3d5239332ce4c7a671038fbbd86d8577fff17b6808d6199032`.

Normalized bytes: 132. SHA-256: `ad98bc448cedac3d5239332ce4c7a671038fbbd86d8577fff17b6808d6199032`.

````text
................................
----------------------------------------------------------------------
Ran 32 tests in 28.074s

OK
````

### vq-draft-external-process-tests-v1.log

Original bytes: 296. SHA-256: `18e645cf297d025e2f30cf6c7a256cba79567830697123b6463685dab9bf99f7`.

Normalized bytes: 296. SHA-256: `18e645cf297d025e2f30cf6c7a256cba79567830697123b6463685dab9bf99f7`.

````text
..{"phase": "starting", "prompt_tokens": 16, "reclaimable_gb": 20.0}
{"prompt_tokens": 16, "passed": false, "error": "ValueError: capacity rung was incomplete, aborted or over its plan"}
..........
----------------------------------------------------------------------
Ran 12 tests in 0.033s

OK
````

### vq-draft-external-process-preflight-v1.json

Original bytes: 266. SHA-256: `21126ddbc18ce79848a5edc854af220da499fc08fa047020bb2ef7b6965ed8df`.

Normalized bytes: 266. SHA-256: `21126ddbc18ce79848a5edc854af220da499fc08fa047020bb2ef7b6965ed8df`.

````text
{
  "scope": "Read-only preflight only; no model or build launch",
  "source_sha256": "ee929fe7433fe6287af2b5591dafc960315f2ed5d31902882cfd7d0c9a9f15e8",
  "refused": true,
  "reason": "competing compiler or model process (llama-server); refusing capacity launch"
}
````

### vq-draft-brain-v1.log

Original bytes: 151. SHA-256: `1d1eaeed96f0bf440d028a8a6647f4a26d0d22ac0eea74a8dbeb3497374dbcd3`.

Normalized bytes: 151. SHA-256: `1d1eaeed96f0bf440d028a8a6647f4a26d0d22ac0eea74a8dbeb3497374dbcd3`.

````text
0 issue(s): 0 error(s), 0 warning(s), 0 info
MEASUREMENTS.md is current
PLAN.md is current
claims gate: 349 needle checks, 0 failures
BRAIN GATES PASS
````

### draft-admission-final-context_qualification.py

Original bytes: 19080. SHA-256: `ee929fe7433fe6287af2b5591dafc960315f2ed5d31902882cfd7d0c9a9f15e8`.

Normalized bytes: 19080. SHA-256: `ee929fe7433fe6287af2b5591dafc960315f2ed5d31902882cfd7d0c9a9f15e8`.

````text
#!/usr/bin/env python3
"""Execute a frozen, incremental capacity protocol; stop on the first failed rung.

This gate is capacity and completion evidence. Numerical parity, real-client
behavior and answer quality remain separate gates. Never loosens a failed
protocol, retries a rung, or refreshes a baseline.
"""
import argparse
from contextlib import contextmanager
import fcntl
import hashlib
import json
import math
import os
from pathlib import Path
import re
import subprocess
import tarfile
import time

from prefill_bench import digest, model_identity, preflight, run_child, vm_snapshot
from memory_gate import check_memory as memory_check

ROOT = Path(__file__).resolve().parent.parent
DRIVERS = ['Tools/context_qualification.py', 'Tools/prefill_bench.py', 'Tools/memory_gate.py']
MODEL_LOCK = Path(f'/tmp/slotstream-model-{os.getuid()}.lock')


@contextmanager
def verification_lock():
    # `pull --verify` reads every payload but does not construct an Engine,
    # so it must hold the same exclusion lock as model-bearing commands.
    # Release before inference: the child Engine acquires its own lock.
    with MODEL_LOCK.open('a') as lock:
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError as error:
            raise RuntimeError('another model or verification process holds the lock') from error
        yield


def observed_model(directory):
    result = model_identity(directory)
    for file in sorted(directory.iterdir()):
        if file.suffix in ('.txt', '.py', '.md') or file.name == 'LICENSE':
            result[file.name] = {'bytes':file.stat().st_size, 'mtime_ns':file.stat().st_mtime_ns,
                                 'sha256':digest(file)}
    return result


def quiet_preflight(needed_gb):
    # Other inference engines do not acquire Slotstream's private lock. Known
    # model-bearing llama.cpp entrypoints must therefore also refuse launch.
    # Names alone cannot identify arbitrary Python model scripts; this remains
    # an extra preflight, not a system-wide lock or a complete process census.
    active = [Path(name.strip()).name for name in subprocess.check_output(
        ['ps','-axo','comm='], text=True, timeout=5).splitlines()
        if Path(name.strip()).name in ('swift-frontend','swift-driver','slotstream','slotstream-checks',
                                      'llama-server','llama-cli')]
    if active:
        raise RuntimeError('competing compiler or model process (' + ', '.join(sorted(set(active)))
                           + '); refusing capacity launch')
    pressure = subprocess.check_output(['sysctl', '-n', 'kern.memorystatus_vm_pressure_level'], text=True, timeout=5).strip()
    if pressure != '1':
        raise RuntimeError('OS pressure is not normal; refusing capacity launch')
    return preflight(needed_gb)


def validate(protocol):
    retained = protocol.get('kind') == 'configurable-context-retained-capacity'
    if protocol.get('schema') != 1 or protocol.get('kind') not in (
            'configurable-context-capacity', 'configurable-context-retained-capacity'):
        raise ValueError('unknown context qualification protocol')
    if protocol.get('mtp') != 'off' or protocol.get('vision') != 'off':
        raise ValueError('this protocol qualifies text only; mode gates are independent')
    if protocol.get('prefix_cache') is not retained or protocol.get('max_prefill_wait_minutes') != 0:
        raise ValueError('capacity protocol requires explicit matching retention and a disabled estimate policy')
    if not isinstance(protocol.get('optimizations'), dict) or not protocol['optimizations']:
        raise ValueError('freeze the exact resolved optimization controls before qualification')
    rungs = protocol['prompt_tokens']
    if not rungs or rungs != sorted(set(rungs)):
        raise ValueError('rungs must be strictly increasing')
    reply = protocol['reply_tokens']
    if type(reply) is not int or not 16 <= reply <= 128:
        raise ValueError('16..128 required reply tokens')
    if any(type(n) is not int or not 16 <= n <= 262144-reply for n in rungs):
        raise ValueError('prompt plus reply must fit the model window')
    if retained:
        if type(protocol.get('warm_conversations')) is not int or protocol['warm_conversations'] != 4 \
                or type(protocol.get('warm_tokens')) is not int \
                or not 16 <= protocol['warm_tokens'] <= min(rungs)+reply-4:
            raise ValueError('retained capacity requires four complete conversations with explicit bounded warm prompts')
    elif protocol.get('warm_conversations', 0) != 0:
        raise ValueError('cold capacity cannot carry warm-up conversations')
    if type(protocol['wall_seconds']) is not int or not 30 <= protocol['wall_seconds'] <= 7200:
        raise ValueError('each rung needs an independent bounded wall ceiling')
    memory = protocol['memory_gb']
    if type(memory) not in (float,int) or not 8.1 <= memory <= 26:
        raise ValueError('explicit 8.1..26 GB capacity target required')
    binary = Path(protocol['binary']).resolve()
    identity = json.loads((binary.parent/'build-identity.json').read_text())
    for file, key in [(binary,'binary_sha256'), (binary.parent/'mlx.metallib','metallib_sha256'),
                      (binary.parent/'build-source.tar.gz','source_archive_sha256')]:
        if digest(file) != protocol[key] or identity[key] != protocol[key]:
            raise ValueError(f'protocol identity mismatch: {key}')
    with tarfile.open(binary.parent/'build-source.tar.gz', 'r:gz') as archive:
        pinned = archive.extractfile('Sources/Slotstream/PinnedModel.swift').read()
    if hashlib.sha256(pinned).hexdigest() != protocol['model_manifest_sha256']:
        raise ValueError('protocol model manifest does not match the frozen binary source')
    revision = re.search(rb'public static let revision = "([a-f0-9]+)"', pinned)
    if not revision or protocol['model_revision'] != revision.group(1).decode():
        raise ValueError('protocol revision is absent from its pinned model source')
    model = Path(protocol['model_dir'])
    known = {name.decode() for name in re.findall(rb'File\(path: "([^"/]+)"', pinned)}
    if {file.name for file in model.glob('*.safetensors')} - known:
        raise ValueError('unpinned weight files are present in the qualification model')
    if observed_model(model) != protocol['model_identity']:
        raise ValueError('model metadata changed since protocol freeze; full verification is still independently required')
    if protocol['driver_sources'] != {name:digest(ROOT/name) for name in DRIVERS}:
        raise ValueError('qualification driver changed since protocol freeze')
    return binary


def validate_delivery(result, protocol, n):
    """Independent completed-work and allocation checks, never a text verdict."""
    stats = result['stats']
    validate_token_observations(result, stats)
    if type(result['configured_context']) is not int:
        raise ValueError('configured context must be an integer observation')
    if result['fits'] is not True or result['aborted'] is not None or stats.get('runtimeError') or stats.get('requestFailure'):
        raise ValueError('capacity rung was incomplete, aborted or over its plan')
    if stats.get('memoryPressureCancelled') or stats.get('reusedPrefixTokens',0) != 0:
        raise ValueError('cold qualification was cancelled or reused state')
    if len(result['prompt_ids']) != n or stats['promptTokens'] != n or stats['prefillTokens'] != n:
        raise ValueError('observed input differs from the frozen prompt count')
    if len(result['output_ids']) != protocol['reply_tokens'] or stats['decodeTokens'] != protocol['reply_tokens']:
        raise ValueError('required reply was not fully delivered')
    if result['configured_context'] != n+protocol['reply_tokens']:
        raise ValueError('candidate window was not priced before load')
    if result['model_revision'] != protocol['model_revision']:
        raise ValueError('delivered model revision differs from protocol')
    if json.dumps(result.get('optimizations'), sort_keys=True) != json.dumps(protocol['optimizations'], sort_keys=True):
        raise ValueError('delivered arithmetic/runtime controls differ from the frozen protocol')
    validate_compute(result['compute_passes'], result['compute_key_extents'], result['compute_query_rows'], n, 0, stats)
    peak = result['memory_ledger']['expected_peak_bytes']
    if type(peak) is not int or peak <= 0 or peak > protocol['memory_gb']*1e9:
        raise ValueError('ledger exceeds the frozen total-memory target')
    retained = protocol.get('kind') == 'configurable-context-retained-capacity'
    warm_memory = validate_retention(result, protocol, peak) if retained else []
    if not retained and result.get('warmup'):
        raise ValueError('cold qualification unexpectedly performed warm-up work')
    return {**memory_check({'stats':stats}, peak/1e9), 'warmup_memory': warm_memory}


def validate_token_observations(result, stats):
    for key in ('prompt_ids', 'output_ids'):
        ids = result[key]
        if not isinstance(ids, list) or any(type(token) is not int or not 0 <= token < 248320 for token in ids):
            raise ValueError('invalid pinned-vocabulary token observation: ' + key)
    for key in ('promptTokens', 'prefillTokens', 'decodeTokens'):
        if type(stats[key]) is not int or stats[key] < 0:
            raise ValueError('invalid integer token count: ' + key)
    mlx = stats.get('mlxPeakMemoryGB')
    if type(mlx) not in (int, float) or not math.isfinite(mlx) or mlx <= 0:
        raise ValueError('missing or invalid MLX peak observation')


def validate_compute(passes, extents, queries, total, reused, stats):
    if len(passes) != len(extents) or len(passes) != len(queries) or not passes:
        raise ValueError('missing actual attention query rows or key extents')
    position = reused
    uses_small_arithmetic = False
    for count, extent, query in zip(passes, extents, queries):
        if type(count) is not int or type(extent) is not int or type(query) is not int or not 0 < count <= query <= 4096:
            raise ValueError('invalid actual compute pass')
        uses_small_arithmetic |= 256 * (position + 256) > 4096 * 8016
        position += count
        if not position <= extent <= 262144 or query*extent > 4096*8016:
            raise ValueError('unbounded actual query-by-key product, including padding')
    if position != total: raise ValueError('compute pass counts do not close prompt')
    expected_arithmetic = 'reference-256-v1' if uses_small_arithmetic else 'standard'
    if stats.get('contextArithmetic') != expected_arithmetic:
        raise ValueError('generation did not report the required qualified context arithmetic')


def validate_retention(result, protocol, peak):
    """Prove four actual completed, interleaved conversations, not synthetic cache entries."""
    def cache(snapshot, require_full=False):
        if snapshot['enabled'] is not True or snapshot['max_conversations'] != 4:
            raise ValueError('retention was disabled or its four-state ceiling changed')
        counts = ['conversations', 'held_tokens', 'charged_token_capacity', 'allocated_sequence_bytes', 'max_tokens']
        if any(type(snapshot[key]) is not int or snapshot[key] < 0 for key in counts):
            raise ValueError('invalid retained ownership observation')
        if not snapshot['held_tokens'] <= snapshot['charged_token_capacity'] <= snapshot['max_tokens'] \
                or snapshot['allocated_sequence_bytes'] > snapshot['charged_token_capacity']*27648 \
                or not 0 <= snapshot['conversations'] <= 4:
            raise ValueError('retained allocation exceeds its bounded budget')
        if require_full and (snapshot['conversations'] != 4 or snapshot['held_tokens'] < 4*protocol['warm_tokens']):
            raise ValueError('capacity request did not start with four filled conversations')

    warmup = result['warmup']
    if len(warmup) != 8: raise ValueError('missing complete interleaved warm-up matrix')
    first_turns, memories = {}, []
    for ordinal, row in enumerate(warmup):
        phase, conversation = divmod(ordinal, 4)
        if row['phase'] != phase or row['conversation'] != conversation or row['fits'] is not True:
            raise ValueError('warm-up order or completed-work verdict changed')
        stats, ids, output, reuse = row['stats'], row['prompt_ids'], row['output_ids'], row['expected_reuse']
        validate_token_observations(row, stats)
        if type(reuse) is not int or reuse < 0 or stats.get('runtimeError') or stats.get('requestFailure') \
                or stats.get('memoryPressureCancelled') or len(output) != 1 or stats['decodeTokens'] != 1 \
                or stats['promptTokens'] != len(ids) or stats['prefillTokens'] != len(ids)-reuse \
                or stats.get('reusedPrefixTokens', 0) != reuse:
            raise ValueError('warm-up delivery or exact prefix reuse failed')
        if phase == 0:
            if len(ids) != protocol['warm_tokens'] or reuse != 0 or any(ids == previous[0] for previous in first_turns.values()):
                raise ValueError('first warm-up turns must be distinct cold prompts of the frozen length')
            first_turns[conversation] = (ids, output)
        else:
            initial, answer = first_turns[conversation]
            if ids != initial+answer+[1000+conversation] or not len(initial) <= reuse <= len(initial)+len(answer):
                raise ValueError('follow-up does not extend the exact prior delivery and retained state')
        cache(row['retained'])
        validate_compute(stats['prefillComputePasses'], stats['prefillComputeKeyExtents'],
                         stats['prefillComputeQueryRows'], len(ids), reuse, stats)
        memories.append(memory_check({'stats': stats}, peak/1e9))
    cache(result['retained_before'], require_full=True)
    cache(result['retained_after'])
    return memories


def run(protocol, out):
    binary = validate(protocol)
    out.mkdir(parents=True, exist_ok=False)
    (out/'protocol.json').write_text(json.dumps(protocol,indent=2)+'\n')
    (out/'protocol.sha256').write_text(digest(out/'protocol.json')+'\n')
    for name in DRIVERS:
        target = out/name; target.parent.mkdir(exist_ok=True)
        target.write_bytes((ROOT/name).read_bytes())
    results = []
    env = {k:v for k,v in os.environ.items() if not k.startswith('SLOTSTREAM_')}
    # These controls change reservations, not any experimental arithmetic.
    retained = protocol.get('kind') == 'configurable-context-retained-capacity'
    env['SLOTSTREAM_PREFIX_CACHE'] = '1' if retained else '0'
    verification = out/'model-verification'; verification.mkdir()
    # Verify every pinned payload, not only header/stat identities. This is
    # read-only but belongs to the exclusive local-storage interval.
    command = [str(binary),'pull','--verify','--dir',str(Path(protocol['model_dir']).resolve())]
    receipt = {'command':command, 'passed':False}
    try:
        receipt['before'] = quiet_preflight(protocol['memory_gb']+3)
        with verification_lock():
            receipt['exit_code'] = run_child(command,env,verification,600)
        if receipt['exit_code']: raise ValueError('full model verification failed')
        receipt['passed'] = True
    except Exception as error:
        receipt['error'] = f'{type(error).__name__}: {error}'
    finally:
        receipt['after'] = vm_snapshot()
        for name in ['stdout.txt','stderr.txt']:
            if (verification/name).exists(): receipt[name+'_sha256'] = digest(verification/name)
        (verification/'manifest.json').write_text(json.dumps(receipt,indent=2)+'\n')
    if not receipt['passed']:
        (out/'manifest.json').write_text(json.dumps({'passed':False,
            'error':receipt.get('error','model verification incomplete'), 'results':[],
            'completed_full_model_window':False})+'\n')
        return 1
    for n in protocol['prompt_tokens']:
        cell = out/str(n); cell.mkdir()
        row = {'prompt_tokens':n, 'passed':False, 'started_unix':time.time()}
        results.append(row)
        try:
            # Recheck frozen driver/model identities before each next rung;
            # no later edit can silently join an already running protocol.
            validate(protocol)
            row['before'] = quiet_preflight(protocol['memory_gb']+3)
            command = [str(binary),'context-check','--tokens',str(n),'--reply-tokens',str(protocol['reply_tokens']),
                       '--memory-gb',str(protocol['memory_gb']),'--mtp','off','--vision','off',
                       '--model',str(Path(protocol['model_dir']).resolve()),
                       '--max-prefill-wait','0','--wall-seconds',str(protocol['wall_seconds']),
                       '--sample-footprint','--json']
            if retained:
                command += ['--warm-conversations','4','--warm-tokens',str(protocol['warm_tokens'])]
            row['command'] = command
            print(json.dumps({'phase':'starting','prompt_tokens':n,'reclaimable_gb':row['before']['reclaimable_bytes']/1e9}),flush=True)
            row['exit_code'] = run_child(command,env,cell,protocol['wall_seconds']+120)
            result = json.loads((cell/'stdout.txt').read_text())
            # Validate the exact completed work independently of the binary's
            # verdict. A normal EOS before required output is a failed capacity
            # delivery, never an excuse to adjust the reply requirement.
            if row['exit_code']: raise ValueError('context-check exited unsuccessfully')
            row['memory'] = validate_delivery(result, protocol, n)
            row['passed'] = True
        except Exception as error:
            row['error'] = f'{type(error).__name__}: {error}'
        finally:
            row['after'] = vm_snapshot(); row['ended_unix'] = time.time()
            if row['after']['swapins'] != row.get('before',row['after'])['swapins'] or row['after']['swapouts'] != row.get('before',row['after'])['swapouts']:
                row['passed'] = False; row['swap_activity'] = True
            (cell/'manifest.json').write_text(json.dumps(row,indent=2)+'\n')
            summary={'passed':all(r['passed'] for r in results),'results':results,
                     'completed_full_model_window':bool(row['passed'] and n+protocol['reply_tokens']==262144)}
            (out/'manifest.json').write_text(json.dumps(summary,indent=2)+'\n')
            print(json.dumps({k:v for k,v in row.items() if k in ('prompt_tokens','passed','error','swap_activity')}),flush=True)
        if not row['passed']: return 1
    return 0


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('protocol',type=Path);parser.add_argument('--out',type=Path,required=True)
    args=parser.parse_args()
    return run(json.loads(args.protocol.read_text()),args.out)

if __name__=='__main__': raise SystemExit(main())
````

### draft-admission-final-context_qualification_checks.py

Original bytes: 13865. SHA-256: `0f2f748260bbc87dd79724339804783a1535b75361fb74b6a1467c0cd02624a8`.

Normalized bytes: 13865. SHA-256: `0f2f748260bbc87dd79724339804783a1535b75361fb74b6a1467c0cd02624a8`.

````text
#!/usr/bin/env python3
"""Weight-free rejection tests for the capacity evidence boundary."""
import copy
import fcntl
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import context_qualification as gate


def delivery():
    vm = {'swapins': 3, 'swapouts': 4}
    return {
        'fits': True, 'aborted': None, 'prompt_ids': list(range(16)),
        'output_ids': list(range(16)), 'configured_context': 32,
        'model_revision': 'frozen', 'compute_passes': [16], 'compute_key_extents': [16], 'compute_query_rows': [16],
        'memory_ledger': {'expected_peak_bytes': 8_000_000_000},
        'optimizations': {'workspaceTokenTile': 256, 'compactStateWindows': False},
        'stats': {'promptTokens': 16, 'prefillTokens': 16, 'decodeTokens': 16,
                  'contextArithmetic': 'standard', 'mlxPeakMemoryGB': 6.0,
                  'sampledFootprint': {'peakBytes': 7_000_000_000, 'samples': 3, 'intervalMilliseconds': 20},
                  'lifetimeRSSPeakBytes': 7_000_000_000, 'physicalFootprintEndBytes': 6_000_000_000,
                  'generatorVMBefore': vm.copy(), 'generatorVMAfter': vm.copy()}}


def retained_delivery():
    result = delivery()
    snapshot = {'enabled': True, 'max_conversations': 4, 'conversations': 4,
                'held_tokens': 80, 'charged_token_capacity': 4096,
                'allocated_sequence_bytes': 4096*27648, 'max_tokens': 8192}
    warmup = []
    for phase in (0, 1):
        for conversation in range(4):
            ids = list(range(conversation*16, (conversation+1)*16))
            reuse = 0
            if phase == 1:
                ids += [123, 1000+conversation]; reuse = 17
            stats = delivery()['stats']
            stats.update(promptTokens=len(ids), prefillTokens=len(ids)-reuse, decodeTokens=1,
                         reusedPrefixTokens=reuse, prefillComputePasses=[len(ids)-reuse],
                         prefillComputeKeyExtents=[len(ids)], prefillComputeQueryRows=[len(ids)-reuse])
            warmup.append({'phase': phase, 'conversation': conversation, 'fits': True,
                           'prompt_ids': ids, 'output_ids': [123], 'expected_reuse': reuse,
                           'stats': stats, 'retained': copy.deepcopy(snapshot)})
    result.update(warmup=warmup, retained_before=copy.deepcopy(snapshot), retained_after=copy.deepcopy(snapshot))
    return result


class CapacityEvidence(unittest.TestCase):
    protocol = {'reply_tokens': 16, 'memory_gb': 8.1, 'model_revision': 'frozen',
                'optimizations': {'workspaceTokenTile': 256, 'compactStateWindows': False}}

    def test_complete_delivery(self):
        self.assertTrue(gate.validate_delivery(delivery(), self.protocol, 16)['passed'])

    def test_incomplete_or_forged_observations_are_rejected(self):
        cases = [
            ('fits', False), ('aborted', 'deadline'), ('prompt_ids', [1]),
            ('output_ids', [1]), ('configured_context', 16), ('model_revision', 'changed'),
            ('compute_passes', [16, 1]), ('compute_key_extents', []),
            ('compute_passes', [True]), ('compute_key_extents', [262145]),
            ('compute_query_rows', [True]), ('compute_query_rows', [15]), ('compute_query_rows', []),
            ('optimizations', {'workspaceTokenTile': 128, 'compactStateWindows': False}),
            ('memory_ledger', {'expected_peak_bytes': 8_100_000_001})]
        for key, value in cases:
            with self.subTest(key=key, value=value):
                result = delivery(); result[key] = value
                with self.assertRaises(ValueError): gate.validate_delivery(result, self.protocol, 16)
        for key, value in [('runtimeError', 'fault'), ('requestFailure', {'code': 'fault'}),
                           ('memoryPressureCancelled', True), ('reusedPrefixTokens', 1),
                           ('promptTokens', 15), ('prefillTokens', 15), ('decodeTokens', 15),
                           ('contextArithmetic', 'reference-256-v1'),
                           ('lifetimeRSSPeakBytes', 8_000_000_001)]:
            with self.subTest(stat=key):
                result = delivery(); result['stats'][key] = value
                with self.assertRaises(ValueError): gate.validate_delivery(result, self.protocol, 16)

    def test_padding_is_inside_product_bound(self):
        result = delivery()
        n = 128256
        result.update(prompt_ids=[0]*n, configured_context=n+16,
                      compute_passes=[256]*(n//256),
                      compute_query_rows=[256]*(n//256),
                      compute_key_extents=list(range(256,n+1,256)))
        result['stats'].update(promptTokens=n, prefillTokens=n)
        self.assertTrue(gate.validate_delivery(result, self.protocol, n)['passed'])
        # Only 256 extra masked columns break the product at this boundary.
        result['compute_key_extents'][-1] += 256
        with self.assertRaises(ValueError): gate.validate_delivery(result, self.protocol, n)
        result['compute_key_extents'][-1] -= 256
        result['compute_query_rows'][-1] += 1
        with self.assertRaises(ValueError): gate.validate_delivery(result, self.protocol, n)

    def test_global_paging_is_diagnostic_but_missing_process_memory_fails(self):
        result = delivery(); result['stats']['generatorVMAfter']['swapins'] += 1
        result['stats']['generatorVMAfter']['swapouts'] += 1
        memory = gate.validate_delivery(result, self.protocol, 16)
        self.assertTrue(memory['passed'])
        self.assertEqual(memory['global_swap_deltas']['generator'], {'swapins': 1, 'swapouts': 1})
        result = delivery(); del result['stats']['sampledFootprint']
        with self.assertRaises(KeyError): gate.validate_delivery(result, self.protocol, 16)

    def test_retained_capacity_requires_complete_interleaved_ownership(self):
        protocol = {**self.protocol, 'kind': 'configurable-context-retained-capacity',
                    'warm_conversations': 4, 'warm_tokens': 16}
        self.assertEqual(len(gate.validate_delivery(retained_delivery(), protocol, 16)['warmup_memory']), 8)
        paging = retained_delivery()
        paging['warmup'][0]['stats']['generatorVMAfter'].update(swapins=999)
        self.assertTrue(gate.validate_delivery(paging, protocol, 16)['passed'])
        mutations = [
            lambda r: r['warmup'].pop(),
            lambda r: r['warmup'][0].update(fits=False),
            lambda r: r['warmup'][1].update(conversation=0),
            lambda r: r['warmup'][1].update(prompt_ids=r['warmup'][0]['prompt_ids']),
            lambda r: r['warmup'][4]['prompt_ids'].__setitem__(0, 999),
            lambda r: r['warmup'][4].update(expected_reuse=0),
            lambda r: r['warmup'][4]['stats'].update(reusedPrefixTokens=0),
            lambda r: r['warmup'][0]['stats'].update(prefillComputeKeyExtents=[262144], prefillComputeQueryRows=[4096]),
            lambda r: r['retained_before'].update(conversations=3),
            lambda r: r['retained_before'].update(enabled=False),
            lambda r: r['retained_before'].update(charged_token_capacity=8193),
            lambda r: r['retained_after'].update(allocated_sequence_bytes=4096*27648+1),
        ]
        for mutate in mutations:
            result = retained_delivery(); mutate(result)
            with self.assertRaises(ValueError): gate.validate_delivery(result, protocol, 16)
        with self.assertRaises(ValueError): gate.validate_delivery(retained_delivery(), self.protocol, 16)

    def test_failed_first_rung_never_launches_the_next(self):
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)/'run'; calls = []
            protocol = {**self.protocol, 'prompt_tokens': [16, 32], 'wall_seconds': 30, 'model_dir': directory}
            def child(command, env, cell, timeout):
                calls.append(command)
                result = delivery(); result['fits'] = False
                (cell/'stdout.txt').write_text(json.dumps(result))
                (cell/'stderr.txt').write_text('')
                return 0
            snapshot = {'reclaimable_bytes': 20_000_000_000, 'swapins': 3, 'swapouts': 4}
            with patch.object(gate, 'validate', return_value=Path('/frozen/slotstream')), \
                 patch.object(gate, 'MODEL_LOCK', Path(directory)/'model.lock'), \
                 patch.object(gate, 'quiet_preflight', return_value=copy.deepcopy(snapshot)), \
                 patch.object(gate, 'vm_snapshot', return_value=copy.deepcopy(snapshot)), \
                 patch.object(gate, 'run_child', side_effect=child):
                self.assertEqual(gate.run(protocol, out), 1)
            self.assertEqual(len(calls), 2)  # full verification, then first rung
            self.assertFalse((out/'32').exists())
            result = json.loads((out/'manifest.json').read_text())
            self.assertFalse(result['passed'])
            self.assertFalse(result['completed_full_model_window'])
            self.assertEqual(result['results'][0]['prompt_tokens'], 16)
            self.assertTrue((out/'16/stdout.txt').is_file())
            self.assertEqual((out/'protocol.sha256').read_text().strip(), gate.digest(out/'protocol.json'))

    def test_failed_verification_preflight_retains_failure_without_launch(self):
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)/'run'
            protocol = {**self.protocol, 'prompt_tokens': [16], 'wall_seconds': 30, 'model_dir': directory}
            with patch.object(gate, 'validate', return_value=Path('/frozen/slotstream')), \
                 patch.object(gate, 'MODEL_LOCK', Path(directory)/'model.lock'), \
                 patch.object(gate, 'quiet_preflight', side_effect=RuntimeError('competing build')), \
                 patch.object(gate, 'vm_snapshot', return_value={}), \
                 patch.object(gate, 'run_child') as child:
                self.assertEqual(gate.run(protocol, out), 1)
                child.assert_not_called()
            result = json.loads((out/'manifest.json').read_text())
            self.assertFalse(result['passed'])
            self.assertFalse(result['completed_full_model_window'])
            self.assertEqual(result['results'], [])
            self.assertIn('competing build', result['error'])
            self.assertTrue((out/'model-verification/manifest.json').exists())

    def test_full_verification_holds_and_releases_the_model_lock(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'model.lock'
            with patch.object(gate, 'MODEL_LOCK', path):
                with gate.verification_lock(), path.open('a') as competitor:
                    with self.assertRaises(BlockingIOError):
                        fcntl.flock(competitor, fcntl.LOCK_EX | fcntl.LOCK_NB)
                with path.open('a') as successor:
                    fcntl.flock(successor, fcntl.LOCK_EX | fcntl.LOCK_NB)

    def test_busy_verification_lock_preserves_failure_without_launch(self):
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)/'run'; path = Path(directory)/'model.lock'
            protocol = {**self.protocol, 'prompt_tokens': [16], 'wall_seconds': 30, 'model_dir': directory}
            with path.open('a') as owner:
                fcntl.flock(owner, fcntl.LOCK_EX | fcntl.LOCK_NB)
                with patch.object(gate, 'validate', return_value=Path('/frozen/slotstream')), \
                     patch.object(gate, 'MODEL_LOCK', path), \
                     patch.object(gate, 'quiet_preflight', return_value={}), \
                     patch.object(gate, 'vm_snapshot', return_value={}), \
                     patch.object(gate, 'run_child') as child:
                    self.assertEqual(gate.run(protocol, out), 1)
                    child.assert_not_called()
            result = json.loads((out/'manifest.json').read_text())
            self.assertFalse(result['passed'])
            self.assertEqual(result['results'], [])
            self.assertIn('holds the lock', result['error'])


class QuietPreflightChecks(unittest.TestCase):
    def test_known_external_inference_refuses_even_with_apparently_free_memory(self):
        for process in ('/opt/bin/llama-server', 'llama-cli', '/build/slotstream', '/toolchain/swift-frontend'):
            with self.subTest(process=process), \
                    patch.object(gate.subprocess, 'check_output', return_value=process+'\n') as observed, \
                    patch.object(gate, 'preflight') as memory:
                with self.assertRaisesRegex(RuntimeError, 'competing compiler or model process'):
                    gate.quiet_preflight(13)
                memory.assert_not_called()
                self.assertEqual(observed.call_args.args[0], ['ps','-axo','comm='])
                self.assertEqual(observed.call_args.kwargs['timeout'], 5)

    def test_unrelated_process_names_continue_to_pressure_and_real_memory_checks(self):
        with patch.object(gate.subprocess, 'check_output', side_effect=['/Applications/Browser\n/usr/bin/sevra\n', '1\n']), \
                patch.object(gate, 'preflight', return_value={'reclaimable_bytes':15_000_000_000}) as memory:
            self.assertEqual(gate.quiet_preflight(13), {'reclaimable_bytes':15_000_000_000})
            memory.assert_called_once_with(13)

    def test_process_observation_failure_never_admits_a_launch(self):
        with patch.object(gate.subprocess, 'check_output', side_effect=RuntimeError('process observation failed')), \
                patch.object(gate, 'preflight') as memory:
            with self.assertRaisesRegex(RuntimeError, 'process observation failed'):
                gate.quiet_preflight(13)
            memory.assert_not_called()


if __name__ == '__main__': unittest.main()
````

### draft-admission-final-mtp_process_guard_gate.py

Original bytes: 2124. SHA-256: `17ebdc823ce2e8a264442b49667644bd45704b88a2cc2abde487ac6b36e814b0`.

Normalized bytes: 2124. SHA-256: `17ebdc823ce2e8a264442b49667644bd45704b88a2cc2abde487ac6b36e814b0`.

````text
#!/usr/bin/env python3
"""Exercise both draft entrypoints under an actual lock with no model weights."""
import argparse
import fcntl
import json
import os
from pathlib import Path
import subprocess
import tempfile


def check(binary):
    root=Path(__file__).resolve().parent.parent
    env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG','VQ_','VQLAB_'))}
    with tempfile.TemporaryDirectory(prefix='slotstream-draft-lock-') as directory:
        folder=Path(directory)
        (folder/'config.json').write_bytes((root/'Tools/reference/config.json').read_bytes())
        # Missing or corrupt payloads must not be reached while another owner
        # holds the reservation. No real model path is passed to either child.
        (folder/'mtp.safetensors').write_bytes(b'not model weights')
        with open(f'/tmp/slotstream-model-{os.getuid()}.lock','a') as lock:
            fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
            for command in [
                ['mtp-parity','--model',str(folder),'--fixture',str(folder/'absent')],
                ['quantization-draft-check','--baseline',str(folder),'--fixture',str(folder/'absent'),
                 '--output',str(folder/'must-not-exist')],
            ]:
                result=subprocess.run([str(binary),*command],env=env,capture_output=True,text=True,timeout=15)
                if result.returncode==0 or 'another Slotstream model process is already running' not in result.stderr:
                    raise RuntimeError(json.dumps({'command':command,'code':result.returncode,
                                                    'stdout':result.stdout,'stderr':result.stderr}))
            if (folder/'must-not-exist').exists():raise RuntimeError('research command published output under contention')
    print('MTP PROCESS GUARD PASS (standalone and research)')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary',type=Path,default=Path(os.environ.get('SLOTSTREAM_TEST_BINARY','.build/release/slotstream')))
    check(parser.parse_args().binary.resolve())
````

### draft-admission-final-static_gates.sh

Original bytes: 2838. SHA-256: `570fb13231f451e315b9d86f0b0186e9da07df6865103a96f0c7329fb0f81d4e`.

Normalized bytes: 2838. SHA-256: `570fb13231f451e315b9d86f0b0186e9da07df6865103a96f0c7329fb0f81d4e`.

````text
#!/bin/bash
# Fast, weights-free checks suitable for every pull request and release.
set -euo pipefail
cd "$(dirname "$0")/.."
BIN=${SLOTSTREAM_TEST_BINARY:-${BIN:-.build/release/slotstream}}
export BIN SLOTSTREAM_TEST_BINARY="$BIN"

for f in install.sh Tools/*.sh .githooks/*; do
  bash -n "$f"
done
sh -n install.sh
python3 -m py_compile Tools/*.py Tools/reference/*.py Tools/slotpack/*.py
python3 Tools/static_gates_binary_test.py
python3 Tools/installer_gates_binary_test.py
python3 Tools/installer_metal_test.py
python3 Tools/verify_binary_test.py
python3 Tools/parity_comparison_test.py
python3 Tools/sampler_gates_test.py
python3 Tools/planner_gates_test.py
python3 Tools/api_generation_test.py
python3 Tools/consumer_smoke_test.py
python3 Tools/e2e_release_test.py
python3 Tools/coverage_ratchet_test.py
python3 Tools/context_qualification_checks.py
python3 Tools/process_cleanup_checks.py
python3 Tools/launch_request_deadline_test.py
python3 Tools/safetensors_empty_test.py
# These use tiny fixtures or mocked processes; none loads MLX, builds Swift,
# reads model weights, or takes the live model lock. Syntax checks alone do
# not exercise their benchmark validity and artifact-identity assertions.
for suite in build_identity optimization_build optimization_serial_build optimization_readiness thermal_readiness prefill_bench expert_layout_probe \
             ngram_cache_probe indexer_score_probe vision_capacity_gate vision_qualification \
             optimization_prerequisites optimization_soak optimization_campaign optimization_results \
             quantization_inventory quantization_baseline quantization_quality quantization_logit_pilot vq_kernel_sources vq_ple_stream vq_model_reference vq_execution_profile vq_draft_inventory vq_dense_overlay vq_dense_reinvestment vq_uncached_expert vq_contiguous_expert vq_record_repack vq_pilot_admission vq_model_fetch vq_rotary_table_source; do
  python3 "Tools/${suite}_test.py"
done
Tools/llms_full.sh --check

# The brain: the store validates, MEASUREMENTS.md and PLAN.md match their
# records, and every public number still has its needle on its surfaces.
Tools/brain_gates.sh

(cd bench/parity31 && shasum -a 256 -c SHA256SUMS)

if grep -En 'File\(path: .*sha256: nil\)' Sources/Slotstream/PinnedModel.swift; then
  echo "pinned manifest contains an unhashed file" >&2
  exit 1
fi

python3 Tools/mtp_process_guard_gate.py --binary "$BIN"
"$BIN" runtime-check
# Native OS accounting regression with at most 192 MiB of live Metal buffers.
# It compiles the production counter directly, without MLX or model weights.
python3 Tools/process_memory_gate.py
"$BIN" pull-check
python3 Tools/pull_interrupt_gate.py
python3 Tools/slotpack/checks.py
Tools/planner_gates.sh
python3 Tools/memory_override_gate.py --binary "$BIN"
Tools/installer_gates.sh

echo "STATIC GATES PASS"
````

### draft-admission-final-static_gates_binary_test.py

Original bytes: 16497. SHA-256: `f0a35158c5253af3956d821c9692185b8782c40528296b8477d8f53bba813b87`.

Normalized bytes: 16497. SHA-256: `f0a35158c5253af3956d821c9692185b8782c40528296b8477d8f53bba813b87`.

````text
"""Execute the real static entry point against tiny, model-free fixture tools."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

SCRIPT = Path(__file__).with_name("static_gates.sh").resolve()
OPTIMIZATION_SUITES = [
    'build_identity', 'optimization_build', 'optimization_serial_build', 'optimization_readiness',
    'thermal_readiness', 'prefill_bench', 'expert_layout_probe',
    'ngram_cache_probe', 'indexer_score_probe', 'vision_capacity_gate', 'vision_qualification',
    'optimization_prerequisites', 'optimization_soak', 'optimization_campaign', 'optimization_results',
    'quantization_inventory', 'quantization_baseline', 'quantization_quality', 'quantization_logit_pilot', 'vq_kernel_sources',
    'vq_ple_stream', 'vq_model_reference', 'vq_execution_profile', 'vq_draft_inventory', 'vq_dense_overlay', 'vq_dense_reinvestment', 'vq_uncached_expert', 'vq_contiguous_expert', 'vq_record_repack', 'vq_pilot_admission', 'vq_model_fetch', 'vq_rotary_table_source',
]


class StaticBinarySelection(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='slotstream-static-selection-')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.trace = self.root/'trace.jsonl'
        self.suite_trace = self.root/'suite-trace.jsonl'
        for directory in ['Tools/reference', 'Tools/slotpack', '.githooks',
                          'bench/parity31', 'Sources/Slotstream', '.build/release',
                          'legacy binary', 'frozen binary']:
            (self.root/directory).mkdir(parents=True, exist_ok=True)
        self.write('Tools/static_gates.sh', SCRIPT.read_text())
        for path in ['install.sh', '.githooks/pre-commit', 'Tools/llms_full.sh',
                     'Tools/brain_gates.sh', 'Tools/installer_gates.sh']:
            self.write(path, '#!/bin/bash\nexit 0\n')
        # Record the forwarded environment at the nested planner boundary.
        # This stub does not certify the real planner's argument handling.
        self.write('Tools/planner_gates.sh', '''#!/bin/bash
set -eu
BIN=${BIN:-.build/release/slotstream}
"$BIN" doctor --json
''')
        for path in ['Tools/static_gates_binary_test.py', 'Tools/coverage_ratchet_test.py',
                     'Tools/process_cleanup_checks.py', 'Tools/context_qualification_checks.py',
                     'Tools/installer_gates_binary_test.py',
                     'Tools/verify_binary_test.py',
                     'Tools/sampler_gates_test.py',
                     'Tools/reference/fixture.py', 'Tools/slotpack/checks.py']:
            self.write(path, '# Model-free dependency fixture.\n')
        self.write('Tools/e2e_release_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_E2E') == '1' else 0)\n")
        self.write('Tools/parity_comparison_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_PARITY') == '1' else 0)\n")
        self.write('Tools/installer_metal_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_METAL_SELECTION') == '1' else 0)\n")
        self.write('Tools/planner_gates_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_PLANNER') == '1' else 0)\n")
        self.write('Tools/api_generation_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_API_GENERATION') == '1' else 0)\n")
        self.write('Tools/consumer_smoke_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_CONSUMER') == '1' else 0)\n")
        self.write('Tools/process_memory_gate.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_NATIVE_MEMORY') == '1' else 0)\n")
        self.write('Tools/launch_request_deadline_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_LAUNCH_DEADLINE') == '1' else 0)\n")
        self.write('Tools/safetensors_empty_test.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_EMPTY_TENSORS') == '1' else 0)\n")
        self.write('Tools/pull_interrupt_gate.py', "import os\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_PULL_INTERRUPT') == '1' else 0)\n")
        self.write('Tools/memory_override_gate.py', "import os,sys\nassert sys.argv[1:] == ['--binary', os.environ['BIN']]\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_MEMORY_OVERRIDES') == '1' else 0)\n")
        self.write('Tools/mtp_process_guard_gate.py', "import os,sys\nassert sys.argv[1:] == ['--binary', os.environ['BIN']]\nraise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_DRAFT_LOCK') == '1' else 0)\n")
        for suite in OPTIMIZATION_SUITES:
            self.write(f'Tools/{suite}_test.py', f'''import json, os
with open(os.environ['SLOTSTREAM_SUITE_TRACE'], 'a') as output:
    output.write(json.dumps({suite!r})+'\\n')
raise SystemExit(23 if os.environ.get('SLOTSTREAM_FAIL_SUITE') == {suite!r} else 0)
''')
        self.write('Sources/Slotstream/PinnedModel.swift', '// pinned manifest fixture\n')
        self.write('bench/parity31/fixture.txt', 'exact fixture\n')
        sha = hashlib.sha256((self.root/'bench/parity31/fixture.txt').read_bytes()).hexdigest()
        self.write('bench/parity31/SHA256SUMS', f'{sha}  fixture.txt\n')
        self.binaries = {}
        for name, path in [('release', '.build/release/slotstream'),
                           ('legacy', 'legacy binary/slotstream'),
                           ('frozen', 'frozen binary/slotstream')]:
            self.binaries[name] = self.root/path
            self.write(path, f'''#!/usr/bin/env python3
import json, os, sys
with open(os.environ['SLOTSTREAM_SELECTION_TRACE'], 'a') as output:
    output.write(json.dumps({{'selected': {name!r}, 'arguments': sys.argv[1:],
        'BIN': os.environ.get('BIN'), 'SLOTSTREAM_TEST_BINARY': os.environ.get('SLOTSTREAM_TEST_BINARY')}})+'\\n')
raise SystemExit(int(os.environ.get('SLOTSTREAM_SELECTION_EXIT', '0')))
''')

    def write(self, relative, text):
        path = self.root/relative
        path.write_text(text)
        path.chmod(0o755)

    def run_entry(self, changes):
        env = {k: v for k, v in os.environ.items()
               if k != 'BIN' and not k.startswith(('SLOTSTREAM_', 'SS_DEBUG'))}
        env.update(SLOTSTREAM_SELECTION_TRACE=str(self.trace))
        env.update(SLOTSTREAM_SUITE_TRACE=str(self.suite_trace))
        env.update(changes)
        p = subprocess.run(['bash', 'Tools/static_gates.sh'], cwd=self.root,
                           env=env, text=True, capture_output=True, timeout=15)
        rows = [json.loads(line) for line in self.trace.read_text().splitlines()] \
            if self.trace.exists() else []
        return p, rows

    def expect_selected(self, changes, name):
        p, rows = self.run_entry(changes)
        self.assertEqual(p.returncode, 0, p.stdout+p.stderr)
        self.assertEqual([row['selected'] for row in rows], [name]*3)
        self.assertEqual([row['arguments'] for row in rows],
                         [['runtime-check'], ['pull-check'], ['doctor', '--json']])
        expected = str(self.binaries[name]) if name != 'release' else '.build/release/slotstream'
        self.assertTrue(all(row['BIN'] == expected and row['SLOTSTREAM_TEST_BINARY'] == expected
                            for row in rows), rows)

    def test_default_release_is_used_and_forwarded(self):
        self.expect_selected({}, 'release')

    def test_failed_planner_fixture_stops_before_native_checks(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_PLANNER': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual(rows, [])

    def test_failed_parity_comparison_stops_before_native_checks(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_PARITY': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual(rows, [])

    def test_failed_draft_lock_stops_before_native_checks(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_DRAFT_LOCK': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual(rows, [])

    def test_missing_draft_lock_gate_stops_acceptance(self):
        (self.root/'Tools/mtp_process_guard_gate.py').unlink()
        result, rows = self.run_entry({})
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(rows, [])

    def test_failed_native_memory_regression_stops_acceptance(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_NATIVE_MEMORY': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual([row['arguments'] for row in rows], [['runtime-check']])

    def test_failed_launch_deadline_regression_stops_acceptance(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_LAUNCH_DEADLINE': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual(rows, [])

    def test_failed_empty_tensor_regression_stops_acceptance(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_EMPTY_TENSORS': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual(rows, [])

    def test_failed_memory_override_matrix_stops_acceptance(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_MEMORY_OVERRIDES': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual(len(rows), 3)

    def test_failed_pull_interrupt_gate_stops_acceptance(self):
        result, rows = self.run_entry({'SLOTSTREAM_FAIL_PULL_INTERRUPT': '1'})
        self.assertEqual(result.returncode, 23, result.stdout + result.stderr)
        self.assertEqual([row['arguments'] for row in rows], [['runtime-check'], ['pull-check']])

    def test_missing_pull_interrupt_gate_stops_acceptance(self):
        (self.root/'Tools/pull_interrupt_gate.py').unlink()
        result, rows = self.run_entry({})
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual([row['arguments'] for row in rows], [['runtime-check'], ['pull-check']])

    def test_legacy_bin_override_is_used_and_forwarded(self):
        self.expect_selected({'BIN': str(self.binaries['legacy'])}, 'legacy')

    def test_frozen_override_with_spaces_is_used_and_forwarded(self):
        self.expect_selected({'SLOTSTREAM_TEST_BINARY': str(self.binaries['frozen'])}, 'frozen')

    def test_frozen_override_takes_precedence_over_legacy_bin(self):
        self.expect_selected({'BIN': str(self.binaries['legacy']),
                              'SLOTSTREAM_TEST_BINARY': str(self.binaries['frozen'])}, 'frozen')

    def test_missing_selected_binary_fails_without_fallback(self):
        p, rows = self.run_entry({'SLOTSTREAM_TEST_BINARY': str(self.root/'missing binary')})
        self.assertNotEqual(p.returncode, 0)
        self.assertEqual(rows, [])

    def test_selected_binary_failure_stops_without_fallback(self):
        p, rows = self.run_entry({'SLOTSTREAM_TEST_BINARY': str(self.binaries['frozen']),
                                  'SLOTSTREAM_SELECTION_EXIT': '23'})
        self.assertEqual(p.returncode, 23)
        self.assertEqual([row['selected'] for row in rows], ['frozen'])

    def test_failed_installed_release_fixture_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_E2E': '1'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_failed_installer_metal_selection_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_METAL_SELECTION': '1'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_missing_installed_release_fixture_is_a_failure(self):
        (self.root/'Tools/e2e_release_test.py').unlink()
        p, rows = self.run_entry({})
        self.assertNotEqual(p.returncode, 0)
        self.assertEqual(rows, [])

    def test_failed_api_generation_fixture_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_API_GENERATION': '1'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_missing_api_generation_fixture_is_a_failure(self):
        (self.root/'Tools/api_generation_test.py').unlink()
        p, rows = self.run_entry({})
        self.assertNotEqual(p.returncode, 0, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_every_optimization_suite_runs_before_native_checks(self):
        p, rows = self.run_entry({})
        self.assertEqual(p.returncode, 0, p.stdout+p.stderr)
        suites = [json.loads(line) for line in self.suite_trace.read_text().splitlines()] \
            if self.suite_trace.exists() else []
        self.assertEqual(suites, OPTIMIZATION_SUITES)
        self.assertEqual(len(rows), 3)

    def test_failed_consumer_fixture_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_CONSUMER': '1'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_missing_consumer_fixture_is_a_failure(self):
        (self.root/'Tools/consumer_smoke_test.py').unlink()
        p, rows = self.run_entry({})
        self.assertNotEqual(p.returncode, 0, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_failed_optimization_suite_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_SUITE': 'optimization_prerequisites'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])
        suites = [json.loads(line) for line in self.suite_trace.read_text().splitlines()]
        self.assertEqual(suites, OPTIMIZATION_SUITES[:OPTIMIZATION_SUITES.index('optimization_prerequisites') + 1])

    def test_campaign_failure_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_SUITE': 'optimization_campaign'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_thermal_suite_failure_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_SUITE': 'thermal_readiness'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])
        suites = [json.loads(line) for line in self.suite_trace.read_text().splitlines()]
        self.assertEqual(suites, OPTIMIZATION_SUITES[:OPTIMIZATION_SUITES.index('thermal_readiness') + 1])

    def test_missing_thermal_suite_is_a_failure(self):
        (self.root/'Tools/thermal_readiness_test.py').unlink()
        p, rows = self.run_entry({})
        self.assertNotEqual(p.returncode, 0, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_vision_qualification_failure_stops_before_native_checks(self):
        p, rows = self.run_entry({'SLOTSTREAM_FAIL_SUITE': 'vision_qualification'})
        self.assertEqual(p.returncode, 23, p.stdout+p.stderr)
        self.assertEqual(rows, [])
        suites = [json.loads(line) for line in self.suite_trace.read_text().splitlines()]
        self.assertEqual(suites, OPTIMIZATION_SUITES[:OPTIMIZATION_SUITES.index('vision_qualification') + 1])

    def test_missing_vision_qualification_suite_is_a_failure(self):
        (self.root/'Tools/vision_qualification_test.py').unlink()
        p, rows = self.run_entry({})
        self.assertNotEqual(p.returncode, 0, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_missing_campaign_is_a_failure(self):
        (self.root/'Tools/optimization_campaign_test.py').unlink()
        p, rows = self.run_entry({})
        self.assertNotEqual(p.returncode, 0, p.stdout+p.stderr)
        self.assertEqual(rows, [])

    def test_missing_optimization_suite_is_a_failure(self):
        (self.root/'Tools/optimization_prerequisites_test.py').unlink()
        p, rows = self.run_entry({})
        self.assertNotEqual(p.returncode, 0, p.stdout+p.stderr)
        self.assertEqual(rows, [])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('--script', type=Path, default=SCRIPT)
    options, remaining = parser.parse_known_args()
    SCRIPT = options.script.resolve()
    unittest.main(argv=[sys.argv[0], *remaining])
````

### vq-draft-build-v2/candidate/build-identity.json

Original bytes: 32077. SHA-256: `7fa0c152f765d1779234f3e92ca04fa659efc2d52861e93c9796a1485157f03c`.

Normalized bytes: 32077. SHA-256: `7fa0c152f765d1779234f3e92ca04fa659efc2d52861e93c9796a1485157f03c`.

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
    "Sources/Slotstream/MTP.swift": "5319a480bd7b12ebad6223b6b0a6a4de32791ed1d1b8a4a3b41c9b4db04ae740",
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
    "Sources/Slotstream/VQDraftWeights.swift": "232799bd52934647ea792473111ab1b671f1c6b563c7980c16036f2eeff10e72",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQDraft.swift": "38e87802b41df47be62bfc8ae33b7e8992a28c97c97eed2606803498b475cb41",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "92b4ccad53dae57a23db4fb996db7e7a6e08b395c3c3102ebaeebe8e7c17f059",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "1d8139be68d72fbd6eacdbb22de07421abece787fe75e63b2e6623dbc11b66ba",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "0669a24eee258eee4c9dc00fbc88350a62d8654ee5ff89093614a2f96ad79e31",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "11da19085bd0f874b4741a542a298f286bf51091b9170fb8a2cabd4b7e399d4f",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "31de09d8efc8951692f60fc9f5c4ec4d14dbef5b67656da18bca519ab4bcbcee",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "50ea6769debcb32efa23b89ae9230a0d756a521347af177f189adf9592922c2b",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "f03d81008110268bba7c5a8146dbf37db33ee3fbfde3ca3b2e49be1531a7b167",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "8e5d4dfae78d4c40a7eae9be7231a992862a123127655677554f8d4b0106293a",
  "binary_sha256": "823aad82d9ce417e96b6d7e2b8fe821b5d6405af382f762406ddef0ee66b70ea",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
