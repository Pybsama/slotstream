---
type: run
created: 2026-10-03T13:51:45.036489+00:00
updated: 2026-10-03T13:52:37.450464+00:00
summary: VQ shard-policy timing stopped before the first measured request
binary: dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: VQ shard-policy timing stopped before the first measured request
tool: bounded VQ research diagnostics
---

Both lean full-vocabulary validation processes pass numerical and memory checks. Their observed thermal state is fair, outside the frozen timing protocol; validation timings are discarded in every case. The first measurement process refuses the native initial VM/headroom check before model allocation or output-directory creation. The external preflight reported 19504234496 reclaimable bytes and the post-exit snapshot 19508166656 bytes; the exact failing native sample was not persisted, so the cause of the discrepancy remains unestablished. No throughput comparison, paired median or policy winner exists from this campaign. No replacement runs occurred.

A small independent observer compiled from the unchanged ProcessMemory implementation still reports fair thermal state after the stop, with more than twenty-two GB reclaimable. The original source, observations and failed supervision remain here. A later experiment would need a new prospective admission protocol and stable actual conditions; it must preserve this failure and all eligibility rules. The separate contiguous-record byte estimate is a proposal only, with no new payload, speed or memory qualification.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### vq-uncached-expert-cost-v1.log

Original bytes: 2193. SHA-256: `be353e1b7e1245fb692d5455d8a3c17513bac94b3d9fd03893b07aa6f27c956a`.

Normalized bytes: 2165. SHA-256: `557f40846b51b452573b75c6901d03e6632e58eba7c1d1bb785b4f9ddd3ef190`.

````text
{"name": "validation-buffered", "arm": "buffered", "measurement": false, "receipt_sha256": "0269cdd7a4862bf75f686740ed6b8e9e28dd33d04cd372c8103c606bd653a71a", "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63", "committed_tokens": 16, "committed_decode_tokens_per_second": 4.668972689063825, "ttft_seconds": 3.2028664159879554, "request_seconds": 6.415585374983493, "peak_process_bytes": 7812110456, "observed_timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens", "thermal or low-power observation outside profile"], "stop": "length"}
{"name": "validation-uncached", "arm": "uncached", "measurement": false, "receipt_sha256": "b3bd95dc7bdffe76ea155a3f708fda8148ba720718cb7058af85eeae9ec443f7", "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63", "committed_tokens": 16, "committed_decode_tokens_per_second": 4.285003281243301, "ttft_seconds": 2.9552473750081845, "request_seconds": 6.455853624996962, "peak_process_bytes": 7776049200, "observed_timing_eligible": false, "timing_exclusions": ["validation mode hashes logits", "too few committed tokens", "thermal or low-power observation outside profile"], "stop": "length"}
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/vq_uncached_expert_pilot.py", line 195, in <module>
    run(parser.parse_args())
  File "<HOME>/Projects/slotstream/Tools/vq_uncached_expert_pilot.py", line 177, in run
    for arm in order: invoke(arm, f'round-{index}-{arm}', measurement=True)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/vq_uncached_expert_pilot.py", line 158, in invoke
    supervision = supervise(command, out / (name + '-supervision'), min(1800, remaining))
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/quantization_logit_run.py", line 97, in supervise
    raise RuntimeError('pilot producer failed; preserved output must be inspected')
RuntimeError: pilot producer failed; preserved output must be inspected
````

### vq-uncached-expert-cost-v1/run.json

Original bytes: 43269. SHA-256: `7332cf93efa3d48860289fd244045a35f9c02dfda94affa7efdb66ce653df3d5`.

Normalized bytes: 43108. SHA-256: `5659cc309dc89e468ced300fe9b9ca4ae7621722afbb9af6cc930377ee14e799`.

````text
{
  "schema": 1,
  "scope": "Same composite and fixed reinvested cache; compare buffered versus checked uncached random shard reads with exact complete generated sequences",
  "qualification": "unproven",
  "complete": false,
  "started_at": "2026-10-03T13:44:01.355155+00:00",
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
    "<HOME>/Projects/slotstream/Tools/vq_uncached_expert_pilot.py": "ca765057cf268af00e99c93bff8f32a57b9459eb977427723b116d1172074775",
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
    "<HOME>/Projects/slotstream/Tools/prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
    "<HOME>/Projects/slotstream/Tools/memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc",
    "<HOME>/Projects/slotstream/Tools/context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34",
    "<HOME>/Projects/slotstream/Tools/quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb",
    "<HOME>/Projects/slotstream/Tools/vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
    "<HOME>/Projects/slotstream/Tools/vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
    "<HOME>/Projects/slotstream/Tools/vq_execution_profile.py": "0e298b9a73df41d55e1191ffdcbf5cc778112e7dae309e6a3b647080c1f4ce91",
    "<HOME>/Projects/slotstream/Tools/quantization_logit_run.py": "2caeb49d8b008a31ca981db7eedcd1eaa374c0b7cd106139895519d4528e2f88",
    "<HOME>/Projects/slotstream/Tools/serve_bench.py": "95fdf6cfb2791aa71cad527bd6dd46557b9d4fd7874f098509e9b8e02943c5c7",
    "<HOME>/Projects/slotstream/Tools/vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
    "<HOME>/Projects/slotstream/Tools/vq_dense_overlay.py": "34d3ed2bf55371cbc3472c48e54cd3c5b0006ba9dbfe6289b6506511b5477684"
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
        "sampled_peak_bytes": 7812110456,
        "samples": 1316,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 20982087680,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   472793.\nPages active:                                 670989.\nPages inactive:                               638680.\nPages speculative:                             66062.\nPages throttled:                                   0.\nPages wired down:                             450958.\nPages purgeable:                                3215.\n\"Translation faults\":                     1919894680.\nPages copy-on-write:                        95709062.\nPages zero filled:                        3150601080.\nPages reactivated:                         172373702.\nPages purged:                               12474035.\nFile-backed pages:                            804637.\nAnonymous pages:                              571094.\nPages stored in compressor:                  1447743.\nPages occupied by compressor:                 784045.\nDecompressions:                             96741025.\nCompressions:                              109942197.\nPageins:                                  2126770936.\nPageouts:                                     471595.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128310.\nPages tagged resident:                         82226.\nPages tagged compressed:                       46084.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                         1838.\nPages tag-storage non-tag pageable:            91199.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7158720.\nTagged compressions:                          712544.\nTagged decompressions:                        582105.\n"
        },
        "seconds": 71.7928439170064
      },
      "receipt_sha256": "0269cdd7a4862bf75f686740ed6b8e9e28dd33d04cd372c8103c606bd653a71a",
      "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 4.668972689063825,
      "ttft_seconds": 3.2028664159879554,
      "request_seconds": 6.415585374983493,
      "peak_process_bytes": 7812110456,
      "observed_timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens",
        "thermal or low-power observation outside profile"
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
        "sampled_peak_bytes": 7776049200,
        "samples": 1293,
        "after": {
          "page_bytes": 16384,
          "reclaimable_bytes": 19506118656,
          "swapins": 28,
          "swapouts": 2908,
          "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   477475.\nPages active:                                 665735.\nPages inactive:                               628953.\nPages speculative:                             53877.\nPages throttled:                                   0.\nPages wired down:                             401848.\nPages purgeable:                                9518.\n\"Translation faults\":                     1921556830.\nPages copy-on-write:                        95792539.\nPages zero filled:                        3151923421.\nPages reactivated:                         172442392.\nPages purged:                               12521005.\nFile-backed pages:                            703566.\nAnonymous pages:                              644999.\nPages stored in compressor:                  1484908.\nPages occupied by compressor:                 856079.\nDecompressions:                             97066569.\nCompressions:                              110343132.\nPageins:                                  2136585902.\nPageouts:                                     472189.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128212.\nPages tagged resident:                         83739.\nPages tagged compressed:                       44473.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                         1778.\nPages tag-storage non-tag pageable:            91259.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6804032.\nTagged compressions:                          713269.\nTagged decompressions:                        584402.\n"
        },
        "seconds": 70.59801824999158
      },
      "receipt_sha256": "b3bd95dc7bdffe76ea155a3f708fda8148ba720718cb7058af85eeae9ec443f7",
      "generated_sha256": "3e396b9bc2af0f2005e0244352fe7670d5fc9d9a88d840b4c7d9ff2df5344f63",
      "committed_tokens": 16,
      "committed_decode_tokens_per_second": 4.285003281243301,
      "ttft_seconds": 2.9552473750081845,
      "request_seconds": 6.455853624996962,
      "peak_process_bytes": 7776049200,
      "observed_timing_eligible": false,
      "timing_exclusions": [
        "validation mode hashes logits",
        "too few committed tokens",
        "thermal or low-power observation outside profile"
      ],
      "stop": "length"
    }
  ],
  "failure": "RuntimeError('pilot producer failed; preserved output must be inspected')"
}
````

### vq-uncached-expert-cost-v1/buffered-profile.json

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

### vq-uncached-expert-cost-v1/uncached-profile.json

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

### vq-uncached-expert-host-after-stop-v1.json

Original bytes: 3608. SHA-256: `1bf2308b948fc22b349571b1aef6ff2ef68b9fc8152208ff02ac95a54942b116`.

Normalized bytes: 3608. SHA-256: `1bf2308b948fc22b349571b1aef6ff2ef68b9fc8152208ff02ac95a54942b116`.

````text
{
  "vm": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21558607872,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   580127.\nPages active:                                 731449.\nPages inactive:                               687702.\nPages speculative:                             59047.\nPages throttled:                                   0.\nPages wired down:                             322559.\nPages purgeable:                                8714.\n\"Translation faults\":                     1922551188.\nPages copy-on-write:                        95879747.\nPages zero filled:                        3152414510.\nPages reactivated:                         172442846.\nPages purged:                               12522097.\nFile-backed pages:                            726992.\nAnonymous pages:                              751206.\nPages stored in compressor:                  1278731.\nPages occupied by compressor:                 702433.\nDecompressions:                             97163966.\nCompressions:                              110343132.\nPageins:                                  2136699597.\nPageouts:                                     472189.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128690.\nPages tagged resident:                         85355.\nPages tagged compressed:                       43335.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5258.\nPages tag-storage free:                         2567.\nPages tag-storage non-tag pageable:            90471.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6609856.\nTagged compressions:                          713269.\nTagged decompressions:                        585513.\n"
  },
  "host_conditions": {
    "load_average_1_5_15_minutes": [
      5.46826171875,
      5.173828125,
      4.5703125
    ],
    "observed_at_unix_seconds": 1791035267.7414038,
    "thermal_limit": "pmset warning/status history, not continuous temperature",
    "energy_joules": null,
    "power_source": {
      "exit_code": 0,
      "stdout": "Now drawing from 'AC Power'\n -InternalBattery-0 (id=23199843)\t100%; charged; 0:00 remaining present: true\n",
      "stderr": ""
    },
    "power_configuration": {
      "exit_code": 0,
      "stdout": "Battery Power:\n Sleep On Power Button 1\n powermode            0\n standby              1\n ttyskeepawake        1\n hibernatemode        3\n powernap             1\n hibernatefile        /var/vm/sleepimage\n displaysleep         2\n womp                 0\n networkoversleep     0\n sleep                1\n lessbright           1\n tcpkeepalive         1\n disksleep            10\nAC Power:\n Sleep On Power Button 1\n powermode            0\n standby              1\n ttyskeepawake        1\n hibernatemode        3\n powernap             1\n hibernatefile        /var/vm/sleepimage\n displaysleep         10\n womp                 1\n networkoversleep     0\n sleep                0\n tcpkeepalive         1\n disksleep            10\n",
      "stderr": ""
    },
    "thermal_status": {
      "exit_code": 0,
      "stdout": "Note: No thermal warning level has been recorded\nNote: No performance warning level has been recorded\nNote: No CPU power status has been recorded\n",
      "stderr": ""
    }
  },
  "known_competing_jobs": []
}
````

### vq-host-observer-v1.swift

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

### vq-host-observer-build-preflight-v1.json

Original bytes: 1989. SHA-256: `169d9a87198a502f64178a5df23b5a3b63e0c706839cf30b4b02ba9e4d9805e9`.

Normalized bytes: 1989. SHA-256: `169d9a87198a502f64178a5df23b5a3b63e0c706839cf30b4b02ba9e4d9805e9`.

````text
{
  "page_bytes": 16384,
  "reclaimable_bytes": 21671034880,
  "swapins": 28,
  "swapouts": 2908,
  "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   219757.\nPages active:                                 855621.\nPages inactive:                               914357.\nPages speculative:                             88972.\nPages throttled:                                   0.\nPages wired down:                             313603.\nPages purgeable:                               10024.\n\"Translation faults\":                     1924173278.\nPages copy-on-write:                        95975087.\nPages zero filled:                        3153681800.\nPages reactivated:                         172443384.\nPages purged:                               12523161.\nFile-backed pages:                           1092914.\nAnonymous pages:                              766036.\nPages stored in compressor:                  1265887.\nPages occupied by compressor:                 692987.\nDecompressions:                             97176036.\nCompressions:                              110343132.\nPageins:                                  2137079535.\nPageouts:                                     472190.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128672.\nPages tagged resident:                         85437.\nPages tagged compressed:                       43235.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5258.\nPages tag-storage free:                          271.\nPages tag-storage non-tag pageable:            92767.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6590912.\nTagged compressions:                          713269.\nTagged decompressions:                        585590.\n"
}
````

### vq-host-observer-first-v1.json

Original bytes: 134. SHA-256: `286261d6f2c14c73cd4d1759b97682989d3d45c3285d845f4413933dd8d29f92`.

Normalized bytes: 134. SHA-256: `286261d6f2c14c73cd4d1759b97682989d3d45c3285d845f4413933dd8d29f92`.

````text
{"conditions":{"lowPowerModeEnabled":false,"thermalState":"fair"},"vm":{"reclaimableBytes":22955819008,"swapins":28,"swapouts":2908}}
````

### vq-host-observer-second-v1.json

Original bytes: 179. SHA-256: `ee1dbadc3e00de55f69070765706adf8efcec9e9934baed6f86676f24e3d5e3c`.

Normalized bytes: 179. SHA-256: `ee1dbadc3e00de55f69070765706adf8efcec9e9934baed6f86676f24e3d5e3c`.

````text
{
  "conditions": {
    "lowPowerModeEnabled": false,
    "thermalState": "fair"
  },
  "vm": {
    "reclaimableBytes": 22872670208,
    "swapins": 28,
    "swapouts": 2908
  }
}
````

### vq-contiguous-record-resource-estimate-v1.json

Original bytes: 594. SHA-256: `b4a56db04c4834ff435535e63e7ed3222166d75f217f9238be502a5d18ea01f4`.

Normalized bytes: 594. SHA-256: `b4a56db04c4834ff435535e63e7ed3222166d75f217f9238be502a5d18ea01f4`.

````text
{
  "schema": 1,
  "status": "calculated proposal only, no payload generated",
  "parent_inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "exact_record_payload_bytes": 47657779200,
  "aligned_record_payload_bytes": 47865397248,
  "alignment_bytes": 16384,
  "padding_bytes": 207618048,
  "header_reservation_bytes": 786432,
  "complete_output_file_bytes": 47866183680,
  "filesystem_free_bytes_observed": 487576563712,
  "qualification": "unproven",
  "scope": "Byte arithmetic from verified parent layout. No storage throughput or quality inference."
}
````

### vq-uncached-expert-cost-v1/validation-buffered/receipt.json

Original bytes: 7374. SHA-256: `0269cdd7a4862bf75f686740ed6b8e9e28dd33d04cd372c8103c606bd653a71a`.

Normalized bytes: 7374. SHA-256: `0269cdd7a4862bf75f686740ed6b8e9e28dd33d04cd372c8103c606bd653a71a`.

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
  "committed_decode_tokens_per_second" : 4.6689726890638248,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.2028664159879554,
    3.6431508749956265,
    3.8687809580005705,
    4.0803371660003904,
    4.2640538330015261,
    4.4850541659980081,
    4.7140420830110088,
    4.9065292910090648,
    5.0897677080065478,
    5.266915499989409,
    5.4741863329836633,
    5.6504878329869825,
    5.8183745830028784,
    6.0056302910088561,
    6.2400691249931697,
    6.4155645830032881
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
    "reclaimableBytes" : 23322869760,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.4402844590076711,
    0.22563008300494403,
    0.21155620799981989,
    0.18371666700113565,
    0.22100033299648203,
    0.2289879170130007,
    0.19248720799805596,
    0.183238416997483,
    0.17714779198286124,
    0.20727083299425431,
    0.17630150000331923,
    0.16788675001589581,
    0.18725570800597779,
    0.23443883398431353,
    0.17549545801011845
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 65.088179584010504,
  "metadata_seconds" : 0.14337179099675268,
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
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "passed" : true,
  "peak_mlx_bytes" : 6746263760,
  "peak_process_bytes" : 7812110456,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 6.4155853749834932,
  "request_vm_after" : {
    "reclaimableBytes" : 14316453888,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 14180401152,
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
    "too few committed tokens",
    "thermal or low-power observation outside profile"
  ],
  "ttft_seconds" : 3.2028664159879554,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v1/validation-buffered-supervision/identity.json

Original bytes: 3028. SHA-256: `d1a82a5c9f94ad18bd21e3de47c4fa2f1ec70dc724bf633e9464b47e0d0dc87e`.

Normalized bytes: 2979. SHA-256: `98bb6fc1c10d7db593e09d7978ee1030eda27235e755be000ea3092d6a3a7998`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v1/buffered-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v1/validation-buffered",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23164272640,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   482583.\nPages active:                                 816038.\nPages inactive:                               810521.\nPages speculative:                             13544.\nPages throttled:                                   0.\nPages wired down:                             256031.\nPages purgeable:                               12769.\n\"Translation faults\":                     1918082671.\nPages copy-on-write:                        95589499.\nPages zero filled:                        3149442461.\nPages reactivated:                         172282444.\nPages purged:                               12419257.\nFile-backed pages:                            918483.\nAnonymous pages:                              721620.\nPages stored in compressor:                  1321752.\nPages occupied by compressor:                 706060.\nDecompressions:                             96377781.\nCompressions:                              109421723.\nPageins:                                  2116289188.\nPageouts:                                     470728.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 129355.\nPages tagged resident:                         83869.\nPages tagged compressed:                       45486.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                          810.\nPages tag-storage non-tag pageable:            92227.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7003520.\nTagged compressions:                          709855.\nTagged decompressions:                        580040.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v1/validation-buffered-supervision/receipt.json

Original bytes: 2139. SHA-256: `f7ea18e4e7653be68076f438593b920350be97f8a89748c9b92aa3f0d27f1c0b`.

Normalized bytes: 2139. SHA-256: `f7ea18e4e7653be68076f438593b920350be97f8a89748c9b92aa3f0d27f1c0b`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7812110456,
  "samples": 1316,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 20982087680,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   472793.\nPages active:                                 670989.\nPages inactive:                               638680.\nPages speculative:                             66062.\nPages throttled:                                   0.\nPages wired down:                             450958.\nPages purgeable:                                3215.\n\"Translation faults\":                     1919894680.\nPages copy-on-write:                        95709062.\nPages zero filled:                        3150601080.\nPages reactivated:                         172373702.\nPages purged:                               12474035.\nFile-backed pages:                            804637.\nAnonymous pages:                              571094.\nPages stored in compressor:                  1447743.\nPages occupied by compressor:                 784045.\nDecompressions:                             96741025.\nCompressions:                              109942197.\nPageins:                                  2126770936.\nPageouts:                                     471595.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128310.\nPages tagged resident:                         82226.\nPages tagged compressed:                       46084.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                         1838.\nPages tag-storage non-tag pageable:            91199.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7158720.\nTagged compressions:                          712544.\nTagged decompressions:                        582105.\n"
  },
  "seconds": 71.7928439170064
}
````

### vq-uncached-expert-cost-v1/validation-buffered-supervision/stdout.txt

Original bytes: 7375. SHA-256: `48f17ece90346bca58e2ce9f554f2dadab6a877c0a1422ce90be425e348311a4`.

Normalized bytes: 7375. SHA-256: `48f17ece90346bca58e2ce9f554f2dadab6a877c0a1422ce90be425e348311a4`.

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
  "committed_decode_tokens_per_second" : 4.6689726890638248,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    3.2028664159879554,
    3.6431508749956265,
    3.8687809580005705,
    4.0803371660003904,
    4.2640538330015261,
    4.4850541659980081,
    4.7140420830110088,
    4.9065292910090648,
    5.0897677080065478,
    5.266915499989409,
    5.4741863329836633,
    5.6504878329869825,
    5.8183745830028784,
    6.0056302910088561,
    6.2400691249931697,
    6.4155645830032881
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
    "reclaimableBytes" : 23322869760,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.4402844590076711,
    0.22563008300494403,
    0.21155620799981989,
    0.18371666700113565,
    0.22100033299648203,
    0.2289879170130007,
    0.19248720799805596,
    0.183238416997483,
    0.17714779198286124,
    0.20727083299425431,
    0.17630150000331923,
    0.16788675001589581,
    0.18725570800597779,
    0.23443883398431353,
    0.17549545801011845
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 65.088179584010504,
  "metadata_seconds" : 0.14337179099675268,
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
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "passed" : true,
  "peak_mlx_bytes" : 6746263760,
  "peak_process_bytes" : 7812110456,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-dense-reinvestment-cost-pilot-v1",
  "profile_sha256" : "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
  "qualification" : "unproven",
  "request_seconds" : 6.4155853749834932,
  "request_vm_after" : {
    "reclaimableBytes" : 14316453888,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 14180401152,
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
    "too few committed tokens",
    "thermal or low-power observation outside profile"
  ],
  "ttft_seconds" : 3.2028664159879554,
  "uncached_expert_files" : 0,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v1/validation-buffered-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v1/validation-uncached/receipt.json

Original bytes: 7392. SHA-256: `b3bd95dc7bdffe76ea155a3f708fda8148ba720718cb7058af85eeae9ec443f7`.

Normalized bytes: 7392. SHA-256: `b3bd95dc7bdffe76ea155a3f708fda8148ba720718cb7058af85eeae9ec443f7`.

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
  "committed_decode_tokens_per_second" : 4.2850032812433012,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9552473750081845,
    3.2445503330091015,
    3.6863026249920949,
    4.1094718330132309,
    4.3194732500123791,
    4.526900333003141,
    4.7329913749999832,
    4.9538366670021787,
    5.1624915419961326,
    5.3569615000160411,
    5.5471991669910494,
    5.7311660420091357,
    5.9278135420172475,
    6.0876195000018924,
    6.2806443750159815,
    6.4558281250065193
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
    "reclaimableBytes" : 14316453888,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.28930295800091699,
    0.44175229198299348,
    0.423169208021136,
    0.2100014169991482,
    0.20742708299076185,
    0.20609104199684225,
    0.22084529200219549,
    0.20865487499395385,
    0.19446995801990852,
    0.19023766697500832,
    0.18396687501808628,
    0.19664750000811182,
    0.15980595798464492,
    0.19302487501408905,
    0.17518374999053776
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 63.842145541013451,
  "metadata_seconds" : 0.13851879199501127,
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
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7776049200,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 6.455853624996962,
  "request_vm_after" : {
    "reclaimableBytes" : 12726681600,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 13442056192,
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
    "too few committed tokens",
    "thermal or low-power observation outside profile"
  ],
  "ttft_seconds" : 2.9552473750081845,
  "uncached_expert_files" : 9,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v1/validation-uncached-supervision/identity.json

Original bytes: 3028. SHA-256: `00e4dffca6bfd332fea259568dcd9759ba6364702c905f8b106ac7cb3042cf9a`.

Normalized bytes: 2979. SHA-256: `abf4500b41880f2dc730a1b709780d20ef9c7b494ed35c572d98e7d1757ba5eb`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v1/uncached-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v1/validation-uncached",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 20979449856,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   459123.\nPages active:                                 671385.\nPages inactive:                               653244.\nPages speculative:                             66076.\nPages throttled:                                   0.\nPages wired down:                             449852.\nPages purgeable:                                3230.\n\"Translation faults\":                     1919897611.\nPages copy-on-write:                        95709438.\nPages zero filled:                        3150602186.\nPages reactivated:                         172373702.\nPages purged:                               12474035.\nFile-backed pages:                            818131.\nAnonymous pages:                              572574.\nPages stored in compressor:                  1447367.\nPages occupied by compressor:                 783833.\nDecompressions:                             96741413.\nCompressions:                              109942197.\nPageins:                                  2126784256.\nPageouts:                                     471595.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128309.\nPages tagged resident:                         82226.\nPages tagged compressed:                       46083.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                         1635.\nPages tag-storage non-tag pageable:            91402.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    7158656.\nTagged compressions:                          712544.\nTagged decompressions:                        582106.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v1/validation-uncached-supervision/receipt.json

Original bytes: 2140. SHA-256: `bf085bbdfde5987ae7279717904b36e3b708635b08d7c7973e7a81cfa5a8e642`.

Normalized bytes: 2140. SHA-256: `bf085bbdfde5987ae7279717904b36e3b708635b08d7c7973e7a81cfa5a8e642`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 7776049200,
  "samples": 1293,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 19506118656,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   477475.\nPages active:                                 665735.\nPages inactive:                               628953.\nPages speculative:                             53877.\nPages throttled:                                   0.\nPages wired down:                             401848.\nPages purgeable:                                9518.\n\"Translation faults\":                     1921556830.\nPages copy-on-write:                        95792539.\nPages zero filled:                        3151923421.\nPages reactivated:                         172442392.\nPages purged:                               12521005.\nFile-backed pages:                            703566.\nAnonymous pages:                              644999.\nPages stored in compressor:                  1484908.\nPages occupied by compressor:                 856079.\nDecompressions:                             97066569.\nCompressions:                              110343132.\nPageins:                                  2136585902.\nPageouts:                                     472189.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128212.\nPages tagged resident:                         83739.\nPages tagged compressed:                       44473.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                         1778.\nPages tag-storage non-tag pageable:            91259.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6804032.\nTagged compressions:                          713269.\nTagged decompressions:                        584402.\n"
  },
  "seconds": 70.59801824999158
}
````

### vq-uncached-expert-cost-v1/validation-uncached-supervision/stdout.txt

Original bytes: 7393. SHA-256: `0f0d0d09822c3e7eabfc4321a9b492fc9be025cfebe3c261e6711dc0695841c3`.

Normalized bytes: 7393. SHA-256: `0f0d0d09822c3e7eabfc4321a9b492fc9be025cfebe3c261e6711dc0695841c3`.

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
  "committed_decode_tokens_per_second" : 4.2850032812433012,
  "committed_tokens" : 16,
  "composite_sha256" : "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "emission_seconds" : [
    2.9552473750081845,
    3.2445503330091015,
    3.6863026249920949,
    4.1094718330132309,
    4.3194732500123791,
    4.526900333003141,
    4.7329913749999832,
    4.9538366670021787,
    5.1624915419961326,
    5.3569615000160411,
    5.5471991669910494,
    5.7311660420091357,
    5.9278135420172475,
    6.0876195000018924,
    6.2806443750159815,
    6.4558281250065193
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
    "reclaimableBytes" : 14316453888,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "inter_token_seconds" : [
    0.28930295800091699,
    0.44175229198299348,
    0.423169208021136,
    0.2100014169991482,
    0.20742708299076185,
    0.20609104199684225,
    0.22084529200219549,
    0.20865487499395385,
    0.19446995801990852,
    0.19023766697500832,
    0.18396687501808628,
    0.19664750000811182,
    0.15980595798464492,
    0.19302487501408905,
    0.17518374999053776
  ],
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "load_seconds" : 63.842145541013451,
  "metadata_seconds" : 0.13851879199501127,
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
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    },
    {
      "lowPowerModeEnabled" : false,
      "thermalState" : "fair"
    }
  ],
  "overlay_verified_files" : 9,
  "overlay_verified_payload_bytes" : 83770065126,
  "pack" : "3.2-dense-affine4",
  "passed" : true,
  "peak_mlx_bytes" : 6746263024,
  "peak_process_bytes" : 7776049200,
  "process_bound_bytes" : 10000000000,
  "producer" : {
    "binary_sha256" : "dfa50e3953cbae41ef028019318177b024958252296b346d984b5c6537d2e127",
    "metallib_sha256" : "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
  },
  "profile" : "vq32-uncached-expert-shards-cost-pilot-v1",
  "profile_sha256" : "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
  "qualification" : "unproven",
  "request_seconds" : 6.455853624996962,
  "request_vm_after" : {
    "reclaimableBytes" : 12726681600,
    "swapins" : 28,
    "swapouts" : 2908
  },
  "request_vm_before" : {
    "reclaimableBytes" : 13442056192,
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
    "too few committed tokens",
    "thermal or low-power observation outside profile"
  ],
  "ttft_seconds" : 2.9552473750081845,
  "uncached_expert_files" : 9,
  "verified_files" : 138,
  "verified_payload_bytes" : 74678698686
}
````

### vq-uncached-expert-cost-v1/validation-uncached-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v1/round-1-buffered-supervision/identity.json

Original bytes: 3200. SHA-256: `22642c9d94e4b3511dcb5b557f3b0c273cbeded1db029f98741d0c728917879e`.

Normalized bytes: 3144. SHA-256: `24aa84eae88717e005f5642373c67d0a138842f916994c7f6b037dbaada35d88`.

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
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v1/buffered-profile.json",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v1/round-1-buffered",
    "--dense-overlay-baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--dense-overlay-manifest",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/composite.json",
    "--measure",
    "--validation-receipt",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-uncached-expert-cost-v1/validation-buffered/receipt.json"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 19504234496,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   463884.\nPages active:                                 665812.\nPages inactive:                               643514.\nPages speculative:                             53868.\nPages throttled:                                   0.\nPages wired down:                             400781.\nPages purgeable:                                9518.\n\"Translation faults\":                     1921561285.\nPages copy-on-write:                        95793306.\nPages zero filled:                        3151924737.\nPages reactivated:                         172442392.\nPages purged:                               12521005.\nFile-backed pages:                            717042.\nAnonymous pages:                              646152.\nPages stored in compressor:                  1484821.\nPages occupied by compressor:                 856061.\nDecompressions:                             97066672.\nCompressions:                              110343132.\nPageins:                                  2136599215.\nPageouts:                                     472189.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128211.\nPages tagged resident:                         83739.\nPages tagged compressed:                       44472.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                         1658.\nPages tag-storage non-tag pageable:            91379.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6803968.\nTagged compressions:                          713269.\nTagged decompressions:                        584403.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-uncached-expert-cost-v1/round-1-buffered-supervision/receipt.json

Original bytes: 2137. SHA-256: `0b78375b41162d42d478afca3338bf3f79ce02183c7b1758f8e6ca25990f4d5d`.

Normalized bytes: 2137. SHA-256: `0b78375b41162d42d478afca3338bf3f79ce02183c7b1758f8e6ca25990f4d5d`.

````text
{
  "exit_code": 1,
  "failure": null,
  "sampled_peak_bytes": 207864576,
  "samples": 3,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 19508166656,
    "swapins": 28,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   464086.\nPages active:                                 665818.\nPages inactive:                               643518.\nPages speculative:                             53914.\nPages throttled:                                   0.\nPages wired down:                             400781.\nPages purgeable:                                9506.\n\"Translation faults\":                     1921579349.\nPages copy-on-write:                        95793758.\nPages zero filled:                        3151940149.\nPages reactivated:                         172442392.\nPages purged:                               12521005.\nFile-backed pages:                            717092.\nAnonymous pages:                              646158.\nPages stored in compressor:                  1484820.\nPages occupied by compressor:                 856061.\nDecompressions:                             97066685.\nCompressions:                              110343132.\nPageins:                                  2136599260.\nPageouts:                                     472189.\nSwapins:                                          28.\nSwapouts:                                       2908.\nPages tagged:                                 128211.\nPages tagged resident:                         83739.\nPages tagged compressed:                       44472.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5259.\nPages tag-storage free:                         1676.\nPages tag-storage non-tag pageable:            91361.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6803968.\nTagged compressions:                          713269.\nTagged decompressions:                        584403.\n"
  },
  "seconds": 0.1694883750169538
}
````

### vq-uncached-expert-cost-v1/round-1-buffered-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-uncached-expert-cost-v1/round-1-buffered-supervision/stderr.txt

Original bytes: 57. SHA-256: `3eb32b90dccbf84b98afd30e031f04351fa8cca3b686acc3e2b65ea097d39756`.

Normalized bytes: 57. SHA-256: `3eb32b90dccbf84b98afd30e031f04351fa8cca3b686acc3e2b65ea097d39756`.

````text
Error: VQ pilot requires 13 GB actual reclaimable memory
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
