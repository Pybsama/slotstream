---
type: run
created: 2026-10-02T21:04:17.076270+00:00
updated: 2026-10-02T21:04:34.478460+00:00
summary: Raw pinned-row checks and bounded synthetic kernel timing samples; no full-model parity or candidate qualification.
binary: 014e8b64dca500745cb00032dcc8fee13fdcbf1715f016d0cf467743f1535043
captured_at: 2026-10-02
command: slotstream quantization-check --kernels --fixture-directory FIXTURES; slotstream quantization-bench
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Bounded native quantization decoding and kernel screen
tool: slotstream quantization-check and quantization-bench
---

Experimental screening only. No candidate model was loaded, and no pack is qualified.
The decoder checks compare selected pinned rows with an independent scalar CPU oracle.
The timing screen compares synthetic affine operations and a materialized VQ fallback;
it does not compare equivalent weights or the upstream fused-dot arithmetic. The earlier
3.2 and 4.4 fixture checks used the previous build in this same working change; their
fixture hashes are preserved below. The final check and timings use this build identity.
System pressure/power observations are internal to the timing command; competing-job
checks were endpoint observations in the development session, not continuous isolation.

## Final build identity

```json
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
  "source_archive_sha256": "fbc31aa51fe9cae947e6ba68d61fff903ca22131b3c2445be24c4baff6741c59",
  "binary_sha256": "014e8b64dca500745cb00032dcc8fee13fdcbf1715f016d0cf467743f1535043",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
```

## final-native-checks.json

SHA-256: `337e528c9c7b0276e55baa7cd438ae7d7fa101389a86c74d306f2153180d2a99`

```json
[
  {
    "items" : [
      {
        "name" : "legacy expert bytes",
        "passed" : true
      },
      {
        "name" : "3-bit rows do not truncate fractional packing",
        "passed" : true
      },
      {
        "name" : "VQ wide codes are 140 words",
        "passed" : true
      },
      {
        "name" : "VQ mixed record includes scales, excludes shared codebooks",
        "passed" : true
      },
      {
        "name" : "PLE uses byte packing without expert padding",
        "passed" : true
      },
      {
        "name" : "expert packing retains the padded tail",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-geometry",
    "passed" : true
  },
  {
    "items" : [
      {
        "name" : "legacy affine defaults preserved",
        "passed" : true
      },
      {
        "name" : "per-module PLE descriptor resolved",
        "passed" : true
      },
      {
        "name" : "per-module projection descriptor resolved",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 0 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 1 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 2 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 3 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 4 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 5 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 6 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 7 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 8 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 9 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 10 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 11 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 12 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 13 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 14 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 15 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 16 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 17 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 18 refused",
        "passed" : true
      },
      {
        "name" : "corrupt descriptor 19 refused",
        "passed" : true
      },
      {
        "name" : "unqualified vq_modules refused",
        "passed" : true
      },
      {
        "name" : "unqualified vq_ple refused",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-metadata",
    "passed" : true
  },
  {
    "items" : [
      {
        "name" : "unpacked8 D2 K256 C2560 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "words32 D8 K16384 C2560 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "words32 D4 K256 C640 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "words32 D4 K2048 C2560 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "words32 D2 K1024 C2560 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "bytes D8 K256 C160 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "bytes D4 K2048 C160 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "bytes D2 K256 C160 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "words32 D4 K2048 C160 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "unpacked16 D2 K1024 C160 exact half bits",
        "passed" : true
      },
      {
        "name" : "wrong scale dtype refused",
        "passed" : true
      },
      {
        "name" : "affine 4-bit packed geometry",
        "passed" : true
      },
      {
        "name" : "affine 4-bit gathered matmul finite",
        "passed" : true
      },
      {
        "name" : "affine 3-bit packed geometry",
        "passed" : true
      },
      {
        "name" : "affine 3-bit gathered matmul finite",
        "passed" : true
      },
      {
        "name" : "affine 2-bit packed geometry",
        "passed" : true
      },
      {
        "name" : "affine 2-bit gathered matmul finite",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-kernels",
    "passed" : true
  },
  {
    "items" : [
      {
        "name" : "fixture-0.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-1.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-2.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-3.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-5.safetensors exact native decoded row bits",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-fixtures",
    "passed" : true
  }
]
```

## fixture-check-3.2.json

SHA-256: `9e78d06830f65ce6601d3e41775fb01d9bafd8e69d4f7b7af2b09f7525f3cb14`

```json
[
  {
    "items" : [
      {
        "name" : "legacy expert bytes",
        "passed" : true
      },
      {
        "name" : "3-bit rows do not truncate fractional packing",
        "passed" : true
      },
      {
        "name" : "VQ wide codes are 140 words",
        "passed" : true
      },
      {
        "name" : "VQ mixed record includes scales, excludes shared codebooks",
        "passed" : true
      },
      {
        "name" : "PLE uses byte packing without expert padding",
        "passed" : true
      },
      {
        "name" : "expert packing retains the padded tail",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-geometry",
    "passed" : true
  },
  {
    "items" : [
      {
        "name" : "fixture-0.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-1.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-2.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-3.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors exact native decoded row bits",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-fixtures",
    "passed" : true
  }
]
```

## fixture-check-4.4.json

SHA-256: `9e78d06830f65ce6601d3e41775fb01d9bafd8e69d4f7b7af2b09f7525f3cb14`

```json
[
  {
    "items" : [
      {
        "name" : "legacy expert bytes",
        "passed" : true
      },
      {
        "name" : "3-bit rows do not truncate fractional packing",
        "passed" : true
      },
      {
        "name" : "VQ wide codes are 140 words",
        "passed" : true
      },
      {
        "name" : "VQ mixed record includes scales, excludes shared codebooks",
        "passed" : true
      },
      {
        "name" : "PLE uses byte packing without expert padding",
        "passed" : true
      },
      {
        "name" : "expert packing retains the padded tail",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      },
      {
        "name" : "invalid geometry refused",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-geometry",
    "passed" : true
  },
  {
    "items" : [
      {
        "name" : "fixture-0.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-1.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-2.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-3.safetensors exact native decoded row bits",
        "passed" : true
      },
      {
        "name" : "fixture-4.safetensors exact native decoded row bits",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-fixtures",
    "passed" : true
  }
]
```

## kernel-screen.json

SHA-256: `b48ee59f51cdae3b418f0e054a073b052f9f7973e2f77a374e100319c048ea01`

```json
{
  "ineligible_reasons" : [

  ],
  "os" : "Version 26.6.2 (Build 25G83)",
  "peak_mlx_bytes" : 107569970,
  "peak_process_bytes" : 578290816,
  "protocol" : "screen-v1",
  "qualification" : "unproven",
  "ram_gb" : 51.539607552,
  "repetitions" : 20,
  "results" : [
    {
      "format" : "affine-4",
      "input_tokens" : 1,
      "median_seconds" : 0.00019824999617412686,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00021420832490548491,
        0.00021604166249744594,
        0.00019116667681373656,
        0.00021316666970960796,
        0.00018508333596400917,
        0.00018512498354539275,
        0.00018316664500162005,
        0.00020433333702385426,
        0.00018291667220182717,
        0.00017470831517130136,
        0.00019020831678062677,
        0.00017195832333527505,
        0.00033283335505984724,
        0.00019824999617412686,
        0.00021079168072901666,
        0.00019920835620723665,
        0.00019708331092260778,
        0.00019824999617412686,
        0.00020224999752826989,
        0.00020166664035059512
      ],
      "weight_bytes" : 9216000
    },
    {
      "format" : "affine-3",
      "input_tokens" : 1,
      "median_seconds" : 0.00019412499386817217,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00018266667029820383,
        0.00019929168047383428,
        0.00020979164401069283,
        0.00019962497754022479,
        0.00019362499006092548,
        0.00021045832545496523,
        0.00018941666348837316,
        0.00019320833962410688,
        0.00020949999452568591,
        0.00017087499145418406,
        0.00017041666433215141,
        0.0001771666866261512,
        0.00024154168204404414,
        0.00019666666048578918,
        0.00020441666129045188,
        0.00018691667355597019,
        0.00020979167311452329,
        0.00019462499767541885,
        0.00018941666348837316,
        0.00018312499742023647
      ],
      "weight_bytes" : 7168000
    },
    {
      "format" : "affine-2",
      "input_tokens" : 1,
      "median_seconds" : 0.00018745833949651569,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00021787500008940697,
        0.00019704166334122419,
        0.00022208332666195929,
        0.00022608332801610231,
        0.00020354168373160064,
        0.00017233332619071007,
        0.00016508332919329405,
        0.00020212499657645822,
        0.00017658332944847643,
        0.00019291669013909996,
        0.0001698333362583071,
        0.00016583333490416408,
        0.00017570832278579473,
        0.00016200001118704677,
        0.00020320835756137967,
        0.00017383333761245012,
        0.00017420834046788514,
        0.00018199998885393143,
        0.00020704165217466652,
        0.00021387499873526394
      ],
      "weight_bytes" : 5120000
    },
    {
      "format" : "affine-4",
      "input_tokens" : 4,
      "median_seconds" : 0.00025324999296572059,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0002453333290759474,
        0.00026895833434537053,
        0.00023083333508111537,
        0.00025091666611842811,
        0.00024287501582875848,
        0.00023708332446403801,
        0.00025629167794249952,
        0.00024199998006224632,
        0.00024833335191942751,
        0.00025516666937619448,
        0.00027137500001117587,
        0.00025133331655524671,
        0.00024591665714979172,
        0.00026395832537673414,
        0.00026479168445803225,
        0.0002177499991375953,
        0.00027904164744541049,
        0.0002628333168104291,
        0.00028966667014174163,
        0.0002567499759607017
      ],
      "weight_bytes" : 9216000
    },
    {
      "format" : "affine-3",
      "input_tokens" : 4,
      "median_seconds" : 0.00025743749574758112,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00023700000019744039,
        0.00024712498998269439,
        0.00026124998112209141,
        0.00025466666556894779,
        0.00023645831970497966,
        0.00024454167578369379,
        0.00023354167933575809,
        0.00025920831831172109,
        0.00027291665901429951,
        0.00025954167358577251,
        0.00025270835612900555,
        0.00027220832998864353,
        0.00024379167007282376,
        0.00025566667318344116,
        0.00028229167219251394,
        0.00026466665440239012,
        0.00028424998163245618,
        0.00027070834767073393,
        0.00026495833299122751,
        0.0002520416455809027
      ],
      "weight_bytes" : 7168000
    },
    {
      "format" : "affine-2",
      "input_tokens" : 4,
      "median_seconds" : 0.00024389581813011318,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00025179167278110981,
        0.00026687499484978616,
        0.00022604168043471873,
        0.00024145832867361605,
        0.00021762499818578362,
        0.00025650000316090882,
        0.0002561250003054738,
        0.00022950000129640102,
        0.00025929164257831872,
        0.00022083334624767303,
        0.00025991664733737707,
        0.00024358331575058401,
        0.00026345832156948745,
        0.00025899999309331179,
        0.00022412498947232962,
        0.00024420832050964236,
        0.00023358335602097213,
        0.00023370832786895335,
        0.00023233334650285542,
        0.00026570830959826708
      ],
      "weight_bytes" : 5120000
    },
    {
      "format" : "affine-4",
      "input_tokens" : 32,
      "median_seconds" : 0.00081616667739581317,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0008769583364482969,
        0.00083916666335426271,
        0.00081379167386330664,
        0.0008681250037625432,
        0.00077479166793636978,
        0.00084108332521282136,
        0.00076095832628197968,
        0.00077829169458709657,
        0.00083849998190999031,
        0.00083849998190999031,
        0.0008012500184122473,
        0.00083524998626671731,
        0.00081941665848717093,
        0.000832499994430691,
        0.00077391666127368808,
        0.00080979164340533316,
        0.00076470832573249936,
        0.00081837500329129398,
        0.00075920831295661628,
        0.00081395835150033236
      ],
      "weight_bytes" : 9216000
    },
    {
      "format" : "affine-3",
      "input_tokens" : 32,
      "median_seconds" : 0.00081047916319221258,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00085916667012497783,
        0.00086820832802914083,
        0.00079900000127963722,
        0.00082483334699645638,
        0.00083949998952448368,
        0.00087375001749023795,
        0.00082395834033377469,
        0.00074745833990164101,
        0.00080374997924081981,
        0.00073475000681355596,
        0.00086775000090710819,
        0.00080795833491720259,
        0.00074508332181721926,
        0.00076458332478068769,
        0.00082625000504776835,
        0.00076920833089388907,
        0.00079208333045244217,
        0.00083225002163089812,
        0.00081299999146722257,
        0.00079566668136976659
      ],
      "weight_bytes" : 7168000
    },
    {
      "format" : "affine-2",
      "input_tokens" : 32,
      "median_seconds" : 0.00071654167550150305,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00067770833265967667,
        0.0007144999981392175,
        0.00072716665454208851,
        0.00081987498560920358,
        0.00067816665978170931,
        0.00070550001692026854,
        0.00080116666504181921,
        0.0006698333309032023,
        0.0007185833528637886,
        0.00073070832877419889,
        0.00077641665120609105,
        0.00066479167435318232,
        0.00078395832679234445,
        0.0006769166502635926,
        0.00073179166065528989,
        0.00068629166344180703,
        0.00067329168086871505,
        0.00071908332756720483,
        0.0007543749816250056,
        0.00070704167592339218
      ],
      "weight_bytes" : 5120000
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d8-k16384-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00088456251251045614,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0019271250057499856,
        0.0011859583319164813,
        0.0011902083351742476,
        0.0010686666646506637,
        0.0011002916726283729,
        0.0010546249977778643,
        0.0014567083271685988,
        0.0012315000058151782,
        0.001131458324380219,
        0.00089049999951384962,
        0.00086204166291281581,
        0.0007986249984242022,
        0.00080495834117755294,
        0.00080112501746043563,
        0.00079137500142678618,
        0.00087862502550706267,
        0.00084687498747371137,
        0.00085004165885038674,
        0.00084620833513326943,
        0.0008724583312869072
      ],
      "weight_bytes" : 4358144
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d8-k16384-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00090829165128525347,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00089816664694808424,
        0.00097570833167992532,
        0.00087524999980814755,
        0.00089779167319647968,
        0.0009184166556224227,
        0.0009682500094641,
        0.00084074999904260039,
        0.00094474997604265809,
        0.00085541667067445815,
        0.00093449998530559242,
        0.00085737500921823084,
        0.00093241667491383851,
        0.000833583326311782,
        0.00096283332095481455,
        0.00089262498659081757,
        0.00097404164262115955,
        0.00084595833322964609,
        0.00092716666404157877,
        0.00085937499534338713,
        0.0009486250055488199
      ],
      "weight_bytes" : 4358144
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d8-k16384-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0016982916713459417,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0016904583317227662,
        0.0016807083156891167,
        0.0016862083284649998,
        0.0017921249964274466,
        0.0016826666542328894,
        0.0017018333310261369,
        0.0016926250245887786,
        0.0017148333427030593,
        0.0017114166694227606,
        0.0016962916706688702,
        0.0017074583156500012,
        0.001783000014256686,
        0.0017502499977126718,
        0.0016575416666455567,
        0.0017154166707769036,
        0.0016819166776258498,
        0.0017002916720230132,
        0.0016937916807364672,
        0.0017098333337344229,
        0.0016924166702665389
      ],
      "weight_bytes" : 4358144
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k2048-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00082245832891203463,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00080320835695602,
        0.00082424998981878161,
        0.00077237497316673398,
        0.00077462499029934406,
        0.00088599999435245991,
        0.00081016667536459863,
        0.00082608332741074264,
        0.00079254165757447481,
        0.00077004166087135673,
        0.00088516669347882271,
        0.00079641668708063662,
        0.00088079166016541421,
        0.00082975000259466469,
        0.00082066666800528765,
        0.00082487499457783997,
        0.00088854166097007692,
        0.00077308333129622042,
        0.00080254164640791714,
        0.00087887499830685556,
        0.00087487499695271254
      ],
      "weight_bytes" : 6160384
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k2048-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00090358333545736969,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00087312498362734914,
        0.00094170833472162485,
        0.00088983331806957722,
        0.00095258335932157934,
        0.00088524998864158988,
        0.00088379165390506387,
        0.00087079167133197188,
        0.0009471250232309103,
        0.00091920833801850677,
        0.00097212500986643136,
        0.00089483335614204407,
        0.00092729166499339044,
        0.0008830416772980243,
        0.00089291666517965496,
        0.00088133334065787494,
        0.00097125000320374966,
        0.00089237501379102468,
        0.00097445832216180861,
        0.0009123333147726953,
        0.00094637498841620982
      ],
      "weight_bytes" : 6160384
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k2048-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0017175208340631798,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.001720708329230547,
        0.0016884166689123958,
        0.0017133333312813193,
        0.0017032499890774488,
        0.0017168750055134296,
        0.0017114583170041442,
        0.0017492499900981784,
        0.0016971250006463379,
        0.0016828333609737456,
        0.0017414583417121321,
        0.00173200000426732,
        0.0017360416532028466,
        0.0017111249908339232,
        0.0017325833323411644,
        0.0016857083246577531,
        0.0017426666745450348,
        0.0017445000121369958,
        0.0016703333531040698,
        0.0017181666626129299,
        0.0017224166658706963
      ],
      "weight_bytes" : 6160384
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k256-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00081985416181851178,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00076341666863299906,
        0.00084354166756384075,
        0.00082220832700841129,
        0.00078429165296256542,
        0.00076554165570996702,
        0.00087004166562110186,
        0.00084412499563768506,
        0.00077391666127368808,
        0.00082333333557471633,
        0.00081749999662861228,
        0.00084691666415892541,
        0.00078595834202133119,
        0.00085174999549053609,
        0.00079891667701303959,
        0.00085016668890602887,
        0.00077266668085940182,
        0.0008713749994058162,
        0.00074675001087598503,
        0.00087704166071489453,
        0.00080987499677576125
      ],
      "weight_bytes" : 4610048
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k256-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00087635417003184557,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00084074999904260039,
        0.00093545831623487175,
        0.00083900001482106745,
        0.00086987498798407614,
        0.00085133331594988704,
        0.00091887498274445534,
        0.00087300001177936792,
        0.00086545833619311452,
        0.00086570833809673786,
        0.00091066665481775999,
        0.00087970832828432322,
        0.00090029166312888265,
        0.00086658334475941956,
        0.00093304167967289686,
        0.00086837500566616654,
        0.0010305416653864086,
        0.00084129167953506112,
        0.00088754168245941401,
        0.00090033333981409669,
        0.00094500000705011189
      ],
      "weight_bytes" : 4610048
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k256-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0017029791633831337,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0017011666495818645,
        0.0017465833516325802,
        0.0017041666433215141,
        0.0017339583428110927,
        0.0016730416682548821,
        0.0017552500066813082,
        0.0016584166733082384,
        0.0017135416564997286,
        0.0016791666566859931,
        0.0017017916834447533,
        0.0017491666658315808,
        0.0016883749922271818,
        0.0016630833561066538,
        0.0016875833098310977,
        0.0017082499980460852,
        0.0016979583306238055,
        0.0017568750190548599,
        0.0016881666670087725,
        0.0017223333416040987,
        0.0017476250068284571
      ],
      "weight_bytes" : 4610048
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k1024-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00081704166950657964,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00089633333845995367,
        0.00078391667921096087,
        0.00090708333300426602,
        0.00081479165237396955,
        0.00078133333590812981,
        0.00079462502617388964,
        0.00080520834308117628,
        0.00080345832975581288,
        0.00080529166734777391,
        0.00089904168271459639,
        0.0007889166590757668,
        0.00089262501569464803,
        0.0007755416736472398,
        0.00081741667236201465,
        0.00081666666665114462,
        0.00091312499716877937,
        0.00082841666880995035,
        0.00090412501594983041,
        0.0008340416825376451,
        0.000900916667887941
      ],
      "weight_bytes" : 10756096
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k1024-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00091095833340659738,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00091479168622754514,
        0.00097441667458042502,
        0.00091462500859051943,
        0.00086337499669753015,
        0.00089679166558198631,
        0.00096808333182707429,
        0.00093487498816102743,
        0.00090258332784287632,
        0.00088208331726491451,
        0.00090466666733846068,
        0.00089654166367836297,
        0.00090450001880526543,
        0.0008771666616667062,
        0.000969333341345191,
        0.00093304167967289686,
        0.00097362502128817141,
        0.00092183332890272141,
        0.00086629166617058218,
        0.00090729165822267532,
        0.0009520833264105022
      ],
      "weight_bytes" : 10756096
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k1024-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0017367500113323331,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.001804041676223278,
        0.0017576666723471135,
        0.0017377083422616124,
        0.0017502499977126718,
        0.0017112916684709489,
        0.0017509583267383277,
        0.0018387916497886181,
        0.0017111666675191373,
        0.001716791681246832,
        0.0017177916597574949,
        0.0017407916602678597,
        0.0017357916804030538,
        0.0017575833480805159,
        0.0017490416648797691,
        0.0017017083300743252,
        0.0016899583279155195,
        0.001722583343507722,
        0.00170808334951289,
        0.0017266666691284627,
        0.0017502499977126718
      ],
      "weight_bytes" : 10756096
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k256-unpacked8-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00098924999474547803,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0023603749868925661,
        0.0022869999811518937,
        0.0023617083497811109,
        0.0010657916718628258,
        0.00095391666400246322,
        0.0010647916642483324,
        0.00090070831356570125,
        0.0010685000161174685,
        0.00093345833010971546,
        0.0010023750073742121,
        0.0010097500053234398,
        0.00090475002070888877,
        0.0010369583324063569,
        0.00094229166279546916,
        0.00097054167417809367,
        0.00093679165001958609,
        0.0010516250040382147,
        0.00097612498211674392,
        0.0009706249984446913,
        0.00093845833907835186
      ],
      "weight_bytes" : 8705024
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k256-unpacked8-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.0010316250118194148,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00099904168746434152,
        0.0010336666891817003,
        0.0010753333335742354,
        0.00097333334269933403,
        0.0010599583329167217,
        0.0010482916841283441,
        0.0010139999794773757,
        0.0010340833105146885,
        0.00096545834094285965,
        0.0010419166646897793,
        0.0010779583535622805,
        0.00099000000045634806,
        0.0010295833344571292,
        0.001046041666995734,
        0.0010900833294726908,
        0.0010069166892208159,
        0.00099600001703947783,
        0.0010708750050980598,
        0.00098495831480249763,
        0.0010018750035669655
      ],
      "weight_bytes" : 8705024
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k256-unpacked8-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0018720833322731778,
      "projection_shape" : [
        640,
        2560
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0019063749932684004,
        0.0018830000190064311,
        0.0018944166658911854,
        0.0018224166706204414,
        0.0018400416593067348,
        0.0018426666501909494,
        0.0018717499915510416,
        0.0019324583117850125,
        0.0018569583480712026,
        0.0018465416796971112,
        0.001893749984446913,
        0.0018362499831710011,
        0.0018621666822582483,
        0.001794583338778466,
        0.0018782916595228016,
        0.0019425416830927134,
        0.001872416672995314,
        0.0019011249823961407,
        0.001873833331046626,
        0.0018611249979585409
      ],
      "weight_bytes" : 8705024
    },
    {
      "format" : "affine-4",
      "input_tokens" : 1,
      "median_seconds" : 0.000229479162953794,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00033999999868683517,
        0.0003355416702106595,
        0.00034120833151973784,
        0.00034729167236946523,
        0.00032166665187105536,
        0.00036999999429099262,
        0.00032787499367259443,
        0.00020574999507516623,
        0.00021229166304692626,
        0.00022366666235029697,
        0.00020300000323913991,
        0.00021812500199303031,
        0.00022366666235029697,
        0.00022587500279769301,
        0.00023308332310989499,
        0.00023624999448657036,
        0.00023895833874121308,
        0.00022133335005491972,
        0.00021116665448062122,
        0.000203083356609568
      ],
      "weight_bytes" : 9216000
    },
    {
      "format" : "affine-3",
      "input_tokens" : 1,
      "median_seconds" : 0.00022839584562461823,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00033762500970624387,
        0.00032016666955314577,
        0.00032379166805185378,
        0.00036775000626221299,
        0.00032950000604614615,
        0.00033183331834152341,
        0.00020920834504067898,
        0.00021908333292230964,
        0.00022337498376145959,
        0.00022808334324508905,
        0.00019758334383368492,
        0.00022183332475833595,
        0.00034333334770053625,
        0.00020895834313705564,
        0.00023441665689460933,
        0.00026087500737048686,
        0.00020966667216271162,
        0.00022870834800414741,
        0.00022737498511560261,
        0.00020879169460386038
      ],
      "weight_bytes" : 7168000
    },
    {
      "format" : "affine-2",
      "input_tokens" : 1,
      "median_seconds" : 0.0002620625018607825,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0005315000016707927,
        0.00042062500142492354,
        0.00045433331979438663,
        0.0004780000017490238,
        0.00052362499991431832,
        0.0005539583507925272,
        0.00023037500795908272,
        0.00025833334075286984,
        0.00024950000806711614,
        0.00028800001018680632,
        0.0002296250022482127,
        0.00027879164554178715,
        0.00027825002325698733,
        0.00023595831589773297,
        0.00024495832622051239,
        0.00024820832186378539,
        0.00025354165700264275,
        0.00024204165674746037,
        0.00026579166296869516,
        0.00021987498621456325
      ],
      "weight_bytes" : 5120000
    },
    {
      "format" : "affine-4",
      "input_tokens" : 4,
      "median_seconds" : 0.00033510416687931865,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00031695835059508681,
        0.00035074999323114753,
        0.00034249998861923814,
        0.00036025000736117363,
        0.00031825000769458711,
        0.00033691668068058789,
        0.00034316667006351054,
        0.00031887501245364547,
        0.0003405416791792959,
        0.00031887501245364547,
        0.00038166667218320072,
        0.00033912499202415347,
        0.00030183332273736596,
        0.00033329165307804942,
        0.00032079164520837367,
        0.00031566666439175606,
        0.00034675002098083496,
        0.00031662502442486584,
        0.00031437500729225576,
        0.00035137499799020588
      ],
      "weight_bytes" : 9216000
    },
    {
      "format" : "affine-3",
      "input_tokens" : 4,
      "median_seconds" : 0.00032460415968671441,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00033695832826197147,
        0.00034712499473243952,
        0.00032733334228396416,
        0.00032916665077209473,
        0.0003251666494179517,
        0.00032537500374019146,
        0.00033820833778008819,
        0.00030312497983686626,
        0.00032125000143423676,
        0.00032250001095235348,
        0.00030750001315027475,
        0.00031879168818704784,
        0.0003189583367202431,
        0.00034387499908916652,
        0.00030812498880550265,
        0.00032854167511686683,
        0.00032204165472649038,
        0.00033199999597854912,
        0.00032404166995547712,
        0.00030733333551324904
      ],
      "weight_bytes" : 7168000
    },
    {
      "format" : "affine-2",
      "input_tokens" : 4,
      "median_seconds" : 0.00040752085624262691,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00042075000237673521,
        0.00039791667950339615,
        0.00039400000241585076,
        0.00042070835479535162,
        0.00038991664769127965,
        0.00042200001189485192,
        0.00051933334907516837,
        0.00041658332338556647,
        0.00052787500317208469,
        0.00039737499901093543,
        0.00040220835944637656,
        0.00042104165186174214,
        0.00037866667844355106,
        0.00041283335303887725,
        0.00039333332097157836,
        0.00040204165270552039,
        0.00043587500113062561,
        0.00042362502426840365,
        0.00039083333103917539,
        0.00039191666292026639
      ],
      "weight_bytes" : 5120000
    },
    {
      "format" : "affine-4",
      "input_tokens" : 32,
      "median_seconds" : 0.0014406041736947373,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0014542499848175794,
        0.0014379583299160004,
        0.001494875003118068,
        0.0014260833559092134,
        0.0014308750105556101,
        0.0014383333327714354,
        0.0014033750048838556,
        0.001437999977497384,
        0.001490583352278918,
        0.0014342500071506947,
        0.0014550833438988775,
        0.0014622083399444818,
        0.0014100833213888109,
        0.0014763750077690929,
        0.0014110833581071347,
        0.0014524166472256184,
        0.0014428750146180391,
        0.0014642083260696381,
        0.0014236666611395776,
        0.0014481666730716825
      ],
      "weight_bytes" : 9216000
    },
    {
      "format" : "affine-3",
      "input_tokens" : 32,
      "median_seconds" : 0.0014044374984223396,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0014100416738074273,
        0.0013719166745431721,
        0.0013912916765548289,
        0.0013635833456646651,
        0.0014069583266973495,
        0.0014362916699610651,
        0.0013946666731499135,
        0.0014069166500121355,
        0.001409458345733583,
        0.0013812500110361725,
        0.0014610000071115792,
        0.0014099999971222132,
        0.0014019583468325436,
        0.0014154583332128823,
        0.0014277083391789347,
        0.0013704583398066461,
        0.0013754999963566661,
        0.0014219166478142142,
        0.0013836250000167638,
        0.0013813750119879842
      ],
      "weight_bytes" : 7168000
    },
    {
      "format" : "affine-2",
      "input_tokens" : 32,
      "median_seconds" : 0.0020513541676336899,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0020763333304785192,
        0.0020437083439901471,
        0.0020376666798256338,
        0.0020413750025909394,
        0.0020460833329707384,
        0.0020566250022966415,
        0.002075458352919668,
        0.0020922500116284937,
        0.0020428750140126795,
        0.0020627916674129665,
        0.0020675833511631936,
        0.0020648333302233368,
        0.002088541688863188,
        0.0020428333373274654,
        0.0020412500016391277,
        0.0020694999839179218,
        0.002020416664890945,
        0.0020427916606422514,
        0.0020439583458937705,
        0.0020612083317246288
      ],
      "weight_bytes" : 5120000
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d8-k16384-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00085341666999738663,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0017088333261199296,
        0.00091612499090842903,
        0.00081445832620374858,
        0.00076299998909235001,
        0.00074833334656432271,
        0.00085991667583584785,
        0.00077920834883116186,
        0.00087304165936075151,
        0.00086533333524130285,
        0.0007995000050868839,
        0.00087354166316799819,
        0.00076212498242966831,
        0.00087699998402968049,
        0.00079291668953374028,
        0.00087170832557603717,
        0.00077924999641254544,
        0.00087612500647082925,
        0.0008128749905154109,
        0.00087091667228378356,
        0.00084691666415892541
      ],
      "weight_bytes" : 5074944
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d8-k16384-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00083637500938493758,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00082595832645893097,
        0.00085679168114438653,
        0.00082858334644697607,
        0.00089399999706074595,
        0.0008555833192076534,
        0.00083258334780111909,
        0.00083570834249258041,
        0.00081629166379570961,
        0.00084412499563768506,
        0.00089150000712834299,
        0.00079833334893919528,
        0.00081212498480454087,
        0.00087270833319053054,
        0.00083137501496821642,
        0.00084133332711644471,
        0.00077866666833870113,
        0.00087229168275371194,
        0.00082962500164285302,
        0.00086370835197158158,
        0.00083704167627729475
      ],
      "weight_bytes" : 5074944
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d8-k16384-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0014580208226107061,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0014389166608452797,
        0.0014523333229590207,
        0.0014641250018030405,
        0.0014762916835024953,
        0.0014801666548009962,
        0.0015716249763499945,
        0.0014254166453611106,
        0.0015132083208300173,
        0.0015097916766535491,
        0.0014173333474900573,
        0.0014657083374913782,
        0.0014637083222623914,
        0.0013973749883007258,
        0.0014207916683517396,
        0.0015295833291020244,
        0.0014403749955818057,
        0.0014367499970830977,
        0.0014393333112820983,
        0.0014747083478141576,
        0.0014500416873488575
      ],
      "weight_bytes" : 5074944
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k2048-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00083497917512431741,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00090908331912942231,
        0.0007941249932628125,
        0.00082899999688379467,
        0.00084095835336484015,
        0.00087945832638069987,
        0.00078816665336489677,
        0.00082637500599958003,
        0.00078924998524598777,
        0.00091158333816565573,
        0.00075541666592471302,
        0.00076362499385140836,
        0.00075362500501796603,
        0.00079737501800991595,
        0.00086729167378507555,
        0.0008472083427477628,
        0.00085637500160373747,
        0.0008236666617449373,
        0.00086545833619311452,
        0.00085366668645292521,
        0.00089191665756516159
      ],
      "weight_bytes" : 6160384
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k2048-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00088118750136345625,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00088304164819419384,
        0.00085962499724701047,
        0.00090916667249985039,
        0.00083175001782365143,
        0.0009017916745506227,
        0.00089500000467523932,
        0.00090987500152550638,
        0.00086845832993276417,
        0.00091645831707865,
        0.00086995834135450423,
        0.00088287499966099858,
        0.00091466665617190301,
        0.00092883335310034454,
        0.00087950000306591392,
        0.00085458334069699049,
        0.000814416678622365,
        0.00084583333227783442,
        0.0008003750117495656,
        0.00088845833670347929,
        0.00078520833631046116
      ],
      "weight_bytes" : 6160384
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k2048-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.001494166674092412,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0015135000285226852,
        0.0014881666575092822,
        0.0015030416834633797,
        0.0014207500207703561,
        0.001563666679430753,
        0.0014700833417009562,
        0.0014845000114291906,
        0.0015190000121947378,
        0.0014429583388846368,
        0.0015001666906755418,
        0.0014507916930597275,
        0.0014861249946989119,
        0.0014879583322908729,
        0.0015420833369717002,
        0.0015040416619740427,
        0.0014616250118706375,
        0.0015682916564401239,
        0.0015059583529364318,
        0.0015360416437033564,
        0.0014311250124592334
      ],
      "weight_bytes" : 6160384
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k256-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00079045833263080567,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00078770832624286413,
        0.00085491666686721146,
        0.0007775000121910125,
        0.00081183333531953394,
        0.00085945831960998476,
        0.00078124998253770173,
        0.00077949999831616879,
        0.00073633334250189364,
        0.0008366249967366457,
        0.00079320833901874721,
        0.00083616666961461306,
        0.0007565416453871876,
        0.00085683332872577012,
        0.00074691665940918028,
        0.00080512501881457865,
        0.00080479166354052722,
        0.00075387500692158937,
        0.00077379166032187641,
        0.00078629166819155216,
        0.00080004165647551417
      ],
      "weight_bytes" : 4610048
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k256-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00082450000627432019,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00087925000116229057,
        0.00079787499271333218,
        0.00087970832828432322,
        0.00083583334344439209,
        0.00086629166617058218,
        0.00075366668170318007,
        0.00077429166412912309,
        0.00082187500083819032,
        0.00082712501171045005,
        0.00082787498831748962,
        0.00092404164024628699,
        0.0007897916657384485,
        0.00085345833213068545,
        0.00076337502105161548,
        0.00082845834549516439,
        0.00080420833546668291,
        0.00079587500658817589,
        0.0008599166467320174,
        0.00079983333125710487,
        0.00078524998389184475
      ],
      "weight_bytes" : 4610048
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d4-k256-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0014549166662618518,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0014455833297688514,
        0.0014230833330657333,
        0.0014792916481383145,
        0.0014888333389535546,
        0.0014681666798423976,
        0.0014502916601486504,
        0.0014462916587945074,
        0.0015192083083093166,
        0.0013932916626799852,
        0.0014520000258926302,
        0.0014867916761431843,
        0.001515874988399446,
        0.0014789583219680935,
        0.0014343333314172924,
        0.0014416250050999224,
        0.0014578333066310734,
        0.0014961666602175683,
        0.0014841250085737556,
        0.0014379583299160004,
        0.001443458313588053
      ],
      "weight_bytes" : 4610048
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k1024-words32-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00082181250036228448,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00093487498816102743,
        0.00091825000708922744,
        0.00079424999421462417,
        0.00077645832789130509,
        0.00086520833428949118,
        0.00077754165977239609,
        0.00089812499936670065,
        0.00082187500083819032,
        0.00088599999435245991,
        0.00080841666203923523,
        0.00082937499973922968,
        0.00086124998051673174,
        0.000816583342384547,
        0.00081754167331382632,
        0.00090758333681151271,
        0.0007984166732057929,
        0.00080745833110995591,
        0.00082174999988637865,
        0.00079983333125710487,
        0.00088529166532680392
      ],
      "weight_bytes" : 10756096
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k1024-words32-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.00085489582852460444,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.00082287500845268369,
        0.00086437500431202352,
        0.00080758333206176758,
        0.0009235833422280848,
        0.00078908333671279252,
        0.00085849998868070543,
        0.00093495834153145552,
        0.00091520833666436374,
        0.0008258333255071193,
        0.00082187500083819032,
        0.0009266250126529485,
        0.0007874166767578572,
        0.00083449998055584729,
        0.00086112500866875052,
        0.00092308333842083812,
        0.00085979164578020573,
        0.00082054166705347598,
        0.000832499994430691,
        0.00088279167539440095,
        0.00085129166836850345
      ],
      "weight_bytes" : 10756096
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k1024-words32-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0014744375075679272,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0014422916574403644,
        0.0014642916503362358,
        0.0015298750076908618,
        0.0014671249955426902,
        0.0014670000236947089,
        0.0015569999814033508,
        0.0014424583350773901,
        0.0014718333259224892,
        0.0014770416892133653,
        0.0014677083527203649,
        0.0015493333339691162,
        0.0014915833307895809,
        0.0015004583401605487,
        0.001427541661541909,
        0.0015522916510235518,
        0.0014350416604429483,
        0.0015202916692942381,
        0.0015040416619740427,
        0.0014296250010374933,
        0.0015535833372268826
      ],
      "weight_bytes" : 10756096
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k256-unpacked8-materialized",
      "input_tokens" : 1,
      "median_seconds" : 0.00097787499544210732,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.002116374991601333,
        0.0009372083586640656,
        0.0010363750043325126,
        0.00095120834885165095,
        0.0010158333170693368,
        0.00092799999401904643,
        0.0010148750152438879,
        0.00098904166952706873,
        0.00096879168995656073,
        0.00097699998877942562,
        0.00098708333098329604,
        0.0009330833563581109,
        0.00094808332505635917,
        0.00094674999127164483,
        0.0010095833276864141,
        0.00095537499873898923,
        0.00099170833709649742,
        0.0010299999848939478,
        0.00097662501502782106,
        0.00097875000210478902
      ],
      "weight_bytes" : 8705024
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k256-unpacked8-materialized",
      "input_tokens" : 4,
      "median_seconds" : 0.0010060208296636119,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0010205833241343498,
        0.0010294166568201035,
        0.0009598333272151649,
        0.0010143333347514272,
        0.0009615833405405283,
        0.0010061249777209014,
        0.0010644583380781114,
        0.0010175000061281025,
        0.00095437502022832632,
        0.0010542083473410457,
        0.0009466666670050472,
        0.0010059166816063225,
        0.00096370832761749625,
        0.00097187500796280801,
        0.00094566668849438429,
        0.00095595832681283355,
        0.0010772916430141777,
        0.0010128750000149012,
        0.0010302916634827852,
        0.00099820832838304341
      ],
      "weight_bytes" : 8705024
    },
    {
      "expanded_weight_bytes" : 32768000,
      "format" : "vq-d2-k256-unpacked8-materialized",
      "input_tokens" : 32,
      "median_seconds" : 0.0016441249899799004,
      "projection_shape" : [
        2560,
        640
      ],
      "routed_experts" : 10,
      "seconds" : [
        0.0016639166860841215,
        0.0016493749863002449,
        0.0015909166831988841,
        0.0016641666588839144,
        0.0016647499869577587,
        0.0015717499773018062,
        0.0016216666845139116,
        0.0015980833268258721,
        0.0016457083111163229,
        0.0016860416799318045,
        0.0016600416565779597,
        0.001652291655773297,
        0.0016218333330471069,
        0.0015852083161007613,
        0.0016885833465494215,
        0.0016138333594426513,
        0.0015659166674595326,
        0.001642541668843478,
        0.0016658749955240637,
        0.001580666663357988
      ],
      "weight_bytes" : 8705024
    }
  ],
  "schema" : 1,
  "scope" : "warm synthetic kernel screen, not full-model parity, quality or speed qualification",
  "timing_eligible" : true,
  "vq_arithmetic" : "F16 row materialization then BF16 gathered matmul; not upstream fused-dot parity",
  "warmups" : 3
}
```

## fixtures-2.1/fixtures.json

SHA-256: `c2c63045886e44074d975144eb29683a5608694ff13399d401fbca3deaea5825`

```json
{
  "schema": 1,
  "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw",
  "revision": "8684640a3956b01c47f5d47f9b999e2ab8b985f1",
  "inventory_sha256": "4f63194dec2e4c3bec31289d6503cc7c886685e16e7c4aac58116d4cf0c7f037",
  "fixtures": [
    {
      "path": "fixture-0.safetensors",
      "sha256": "7a5bb4d4a7c956d237f9b00912d832d23b59e5fbbc4b46aef2f51c6975a483e4",
      "bytes": 12652,
      "module": "model.layers.0.mlp.switch_mlp.down_proj",
      "columns": 640,
      "dimensions": 2,
      "entries": 256,
      "group_size": 64,
      "packing": "unpacked8",
      "ranges": [
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.codes",
          "offset": 2104042814,
          "bytes": 2240,
          "sha256": "f27f4e07a57f10035614ece2c5029ce7c4202edf806cc9ccf42e4ca484dde341"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.codebook",
          "offset": 2527678094,
          "bytes": 1024,
          "sha256": "8bad2e576c350b08a0a4b968bd67ba05171b04bc7d302c98f85faaca653a8c1e"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.vq_scales",
          "offset": 3053224446,
          "bytes": 140,
          "sha256": "3116504c9b798afe2d3ce056ac6a98a42eee0f385530ca8b6add32697dfceaa7"
        }
      ]
    },
    {
      "path": "fixture-1.safetensors",
      "sha256": "ee5dacf09e789cd2499602f3e6a92e5223d987009a15aaab24d6ae68892d24f1",
      "bytes": 46672,
      "module": "model.layers.0.mlp.switch_mlp.gate_proj",
      "columns": 2560,
      "dimensions": 2,
      "entries": 256,
      "group_size": 64,
      "packing": "unpacked8",
      "ranges": [
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.codes",
          "offset": 26228366,
          "bytes": 8960,
          "sha256": "9f7a223465f994ae314ea141bf16e704f4758f4671b2fe30446da35461aab2c6"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.codebook",
          "offset": 1628315534,
          "bytes": 1024,
          "sha256": "1a74f42a682449d3f6a45428f8d85f4259f2429337f03fdab776e2e362073475"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.vq_scales",
          "offset": 2050966158,
          "bytes": 560,
          "sha256": "303aa280503990f270ac938414c3ef1d3eadadd560b9884b18c922664b11ba85"
        }
      ]
    },
    {
      "path": "fixture-2.safetensors",
      "sha256": "12d8d71199466f930dbba8f21d6a375900f6965090e2e24a732cb8c954b58055",
      "bytes": 12556,
      "module": "model.layers.10.mlp.switch_mlp.down_proj",
      "columns": 640,
      "dimensions": 4,
      "entries": 256,
      "group_size": 64,
      "packing": "words32",
      "ranges": [
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.codes",
          "offset": 2330803958,
          "bytes": 1120,
          "sha256": "22d3960a7915366e85a1b20f14d462c249201454ccdf10701d18939fcaa6e51c"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.codebook",
          "offset": 1703551558,
          "bytes": 2048,
          "sha256": "f3e36dbee1478183b340ed2ca8d84d6cd3dbe487642eb859bd45ce0774e5507a"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.vq_scales",
          "offset": 26585910,
          "bytes": 140,
          "sha256": "fe4ce9da62b57ed1d0102a0167373b4b788ab6fe256ab9e390c49fc47c42f426"
        }
      ]
    },
    {
      "path": "fixture-3.safetensors",
      "sha256": "fa9c9175c9caa72405fc64c0b3bc24c901caf1b6bea603f1f5d591e094ca6146",
      "bytes": 302760,
      "module": "model.layers.10.mlp.switch_mlp.gate_proj",
      "columns": 2560,
      "dimensions": 8,
      "entries": 16384,
      "group_size": 64,
      "packing": "words32",
      "ranges": [
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.codes",
          "offset": 1233309158,
          "bytes": 3920,
          "sha256": "542920077c00b87c48ef4dc44af8983895be998b2ac2431fa854d761d2a0ae6a"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.codebook",
          "offset": 26261046,
          "bytes": 262144,
          "sha256": "7402016f842ec85240baa495744e0cf1a2c74d7def029436be7a163ce820b8b6"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.vq_scales",
          "offset": 1205299430,
          "bytes": 560,
          "sha256": "dda71f32107ffbfb8d8bf706e1274dee8c646f336068bc83fa30153bcf8a3142"
        }
      ]
    },
    {
      "path": "fixture-4.safetensors",
      "sha256": "15c74ef00049bfe76a82342acfb3098da43d4e8ef2610a37b6e130c1fb823526",
      "bytes": 43216,
      "module": "model.layers.27.mlp.switch_mlp.gate_proj",
      "columns": 2560,
      "dimensions": 4,
      "entries": 256,
      "group_size": 64,
      "packing": "words32",
      "ranges": [
        {
          "shard": "model-00016.safetensors",
          "tensor": "model.layers.27.mlp.switch_mlp.gate_proj.codes",
          "offset": 2325477493,
          "bytes": 4480,
          "sha256": "6216ac1b469541aad4d4747ba79856e8a0e398c13de6cf68b87132b7f3ab4c5b"
        },
        {
          "shard": "model-00016.safetensors",
          "tensor": "model.layers.27.mlp.switch_mlp.gate_proj.codebook",
          "offset": 2818566869,
          "bytes": 2048,
          "sha256": "81ba6a97d33cd9aff499fde5a5c61cc966356d88ca0aa5a2a9be7838daca7fd0"
        },
        {
          "shard": "model-00016.safetensors",
          "tensor": "model.layers.27.mlp.switch_mlp.gate_proj.vq_scales",
          "offset": 2820947157,
          "bytes": 560,
          "sha256": "f08436eadeb4264721b2db0e98fc06b7e43f5fe2559d75ec0bf28cd57cfcab9a"
        }
      ]
    },
    {
      "path": "fixture-5.safetensors",
      "sha256": "aa4dc90d40710180a5f5ba041a11d33acbf846212a60e598214d7c4f52ee01d0",
      "bytes": 6826,
      "module": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0",
      "columns": 160,
      "dimensions": 8,
      "entries": 256,
      "group_size": 32,
      "packing": "bytes",
      "ranges": [
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.codes",
          "offset": 4533,
          "bytes": 140,
          "sha256": "f6851d433fbf12895fc4335dd21557fedeee5250f30d68ceb8f703cd39559a3a"
        },
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.codebook",
          "offset": 437,
          "bytes": 4096,
          "sha256": "f34d1a856bb7a1a1605ec5f330b8ba9853581d8d6653ec697611cf4ef7c7465a"
        },
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.vq_scales",
          "offset": 50004773,
          "bytes": 70,
          "sha256": "8579b18302f2a1f32ae4254915f53811754a3a70ccbff9974d34b66762761c02"
        }
      ]
    }
  ],
  "network_bytes": 402120,
  "scope": "selected real rows, not full artifact parity"
}
```

## fixtures-3.2/fixtures.json

SHA-256: `2bd28f49f31d95342e09ebebf9644803478742b2a93f31eff138f4faa0d9a231`

```json
{
  "schema": 1,
  "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-3.2bpw",
  "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
  "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "fixtures": [
    {
      "path": "fixture-0.safetensors",
      "sha256": "7a5bb4d4a7c956d237f9b00912d832d23b59e5fbbc4b46aef2f51c6975a483e4",
      "bytes": 12652,
      "module": "model.layers.0.mlp.switch_mlp.down_proj",
      "columns": 640,
      "dimensions": 2,
      "entries": 256,
      "group_size": 64,
      "packing": "unpacked8",
      "ranges": [
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.codes",
          "offset": 2497258826,
          "bytes": 2240,
          "sha256": "f27f4e07a57f10035614ece2c5029ce7c4202edf806cc9ccf42e4ca484dde341"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.codebook",
          "offset": 2920894106,
          "bytes": 1024,
          "sha256": "8bad2e576c350b08a0a4b968bd67ba05171b04bc7d302c98f85faaca653a8c1e"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.vq_scales",
          "offset": 3472654858,
          "bytes": 140,
          "sha256": "3116504c9b798afe2d3ce056ac6a98a42eee0f385530ca8b6add32697dfceaa7"
        }
      ]
    },
    {
      "path": "fixture-1.safetensors",
      "sha256": "ee5dacf09e789cd2499602f3e6a92e5223d987009a15aaab24d6ae68892d24f1",
      "bytes": 46672,
      "module": "model.layers.0.mlp.switch_mlp.gate_proj",
      "columns": 2560,
      "dimensions": 2,
      "entries": 256,
      "group_size": 64,
      "packing": "unpacked8",
      "ranges": [
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.codes",
          "offset": 2964443914,
          "bytes": 8960,
          "sha256": "9f7a223465f994ae314ea141bf16e704f4758f4671b2fe30446da35461aab2c6"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.codebook",
          "offset": 2048241306,
          "bytes": 1024,
          "sha256": "1a74f42a682449d3f6a45428f8d85f4259f2429337f03fdab776e2e362073475"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.vq_scales",
          "offset": 2470396570,
          "bytes": 560,
          "sha256": "303aa280503990f270ac938414c3ef1d3eadadd560b9884b18c922664b11ba85"
        }
      ]
    },
    {
      "path": "fixture-2.safetensors",
      "sha256": "21c177eb350bca7cc1f557938f865cdbb24e1777e7cdc28fa62b4da86cc732aa",
      "bytes": 27312,
      "module": "model.layers.10.mlp.switch_mlp.down_proj",
      "columns": 640,
      "dimensions": 4,
      "entries": 2048,
      "group_size": 64,
      "packing": "words32",
      "ranges": [
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.codes",
          "offset": 3193970513,
          "bytes": 1540,
          "sha256": "ad05aeb907e879ac0265b8ad2b03b7d74f4c39f15a5ba7716844fcb8abc360af"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.codebook",
          "offset": 2383680161,
          "bytes": 16384,
          "sha256": "e029e0a946f71085fd69f5b8c9d4997e2e31de8e39bd59ff4528c89d92521c89"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.vq_scales",
          "offset": 26340241,
          "bytes": 140,
          "sha256": "0f6e58dd9187fccf097058c73a8f2fd9691aa30f31cf59f3021cb6c8f9724235"
        }
      ]
    },
    {
      "path": "fixture-3.safetensors",
      "sha256": "cae837fbd61efc04101cf1b117025ccd0fad35a44d42eb022d1b23633efb6e7f",
      "bytes": 59240,
      "module": "model.layers.10.mlp.switch_mlp.gate_proj",
      "columns": 2560,
      "dimensions": 4,
      "entries": 2048,
      "group_size": 64,
      "packing": "words32",
      "ranges": [
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.codes",
          "offset": 1730168385,
          "bytes": 6160,
          "sha256": "655b22510a5637518020fb26c2d0dd9a43160080f7933a34b21c30a4440cf569"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.codebook",
          "offset": 26261137,
          "bytes": 16384,
          "sha256": "87782ef1ff95b5bac10b27654ce2f534dc5024a7e6f0a6ea2bb1c7315a0757ab"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.vq_scales",
          "offset": 1702144321,
          "bytes": 560,
          "sha256": "f192589e8e75a224f5c78c25cf3e7027d71c03ee5e64dc9ca633a32c85a17cab"
        }
      ]
    },
    {
      "path": "fixture-4.safetensors",
      "sha256": "497780bf485a2c6f10087038b9e0aa421d0d7c3c28369070882b27fbce0dfb1e",
      "bytes": 19367,
      "module": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0",
      "columns": 160,
      "dimensions": 4,
      "entries": 2048,
      "group_size": 32,
      "packing": "bytes",
      "ranges": [
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.codes",
          "offset": 16827,
          "bytes": 385,
          "sha256": "9b8dcbdc936288f5de0c8a4fc279397e876d79c9809f0cdde66e22ec0a20c96f"
        },
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.codebook",
          "offset": 443,
          "bytes": 16384,
          "sha256": "3067121c6cf571c5e6fcee83cad104f3f9d9d3ceac6636fb9fadc746469c0586"
        },
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.vq_scales",
          "offset": 137517487,
          "bytes": 70,
          "sha256": "8579b18302f2a1f32ae4254915f53811754a3a70ccbff9974d34b66762761c02"
        }
      ]
    }
  ],
  "network_bytes": 132089,
  "scope": "selected real rows, not full artifact parity"
}
```

## fixtures-4.4/fixtures.json

SHA-256: `a85085451f949f8f1cd2d060515f424a96fbd3e76a42db7106f07a6392c8ccaf`

```json
{
  "schema": 1,
  "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-4.4bpw",
  "revision": "0f35dc817238bdbabdac208db731470cd30a7c0a",
  "inventory_sha256": "a30ded4e88270d33dfcca8e9b6c414a69cf82f0ad27d20bb3fe71b2b1c14ccac",
  "fixtures": [
    {
      "path": "fixture-0.safetensors",
      "sha256": "61eb7d28970d2992a9d15b79986b3f5d6541f07c3088ea2082fdc5ed99ff7002",
      "bytes": 16284,
      "module": "model.layers.0.mlp.switch_mlp.down_proj",
      "columns": 640,
      "dimensions": 2,
      "entries": 1024,
      "group_size": 64,
      "packing": "words32",
      "ranges": [
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.codes",
          "offset": 2916701534,
          "bytes": 2800,
          "sha256": "3f5670a3616737920a0805bbe8b8da481288f2f1bb3011b688d6fe9dc712bc2b"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.codebook",
          "offset": 3445194414,
          "bytes": 4096,
          "sha256": "aa7aa4aeff8334dbcede798c0d8fd27a7a5bcd9d25f60dbd9215fe78de6c89db"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.down_proj.vq_scales",
          "offset": 4101818910,
          "bytes": 140,
          "sha256": "3116504c9b798afe2d3ce056ac6a98a42eee0f385530ca8b6add32697dfceaa7"
        }
      ]
    },
    {
      "path": "fixture-1.safetensors",
      "sha256": "2f0841df318e78112c20e1f9b665624cffddf624e554f7d4c09079088a36778c",
      "bytes": 51992,
      "module": "model.layers.0.mlp.switch_mlp.gate_proj",
      "columns": 2560,
      "dimensions": 2,
      "entries": 1024,
      "group_size": 64,
      "packing": "words32",
      "ranges": [
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.codes",
          "offset": 3488747294,
          "bytes": 11200,
          "sha256": "a87e9d19a41e3b5749980c2183c05167dbb0d3f31b2b5d9135f056ee30b3e97f"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.codebook",
          "offset": 2362823342,
          "bytes": 4096,
          "sha256": "66bc81b6949d97b075734b27d34e8e6689248341338fd0ec3c36713dfd4e4f7a"
        },
        {
          "shard": "model-00001.safetensors",
          "tensor": "model.layers.0.mlp.switch_mlp.gate_proj.vq_scales",
          "offset": 2889839278,
          "bytes": 560,
          "sha256": "303aa280503990f270ac938414c3ef1d3eadadd560b9884b18c922664b11ba85"
        }
      ]
    },
    {
      "path": "fixture-2.safetensors",
      "sha256": "139686de33470030832185733e3f6486a8ee3bfc7f7883839f28ecdd6ca47038",
      "bytes": 12652,
      "module": "model.layers.10.mlp.switch_mlp.down_proj",
      "columns": 640,
      "dimensions": 2,
      "entries": 256,
      "group_size": 64,
      "packing": "unpacked8",
      "ranges": [
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.codes",
          "offset": 2936419518,
          "bytes": 2240,
          "sha256": "3c5f14c964861225d33ca651afe16c6b59872d51bcca8fc069abe901baed355b"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.codebook",
          "offset": 1892977502,
          "bytes": 1024,
          "sha256": "0575f4822c7deb46124360035a378c045338918a5b89975d92e7727b2ed63235"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.down_proj.vq_scales",
          "offset": 7608563518,
          "bytes": 140,
          "sha256": "0f6e58dd9187fccf097058c73a8f2fd9691aa30f31cf59f3021cb6c8f9724235"
        }
      ]
    },
    {
      "path": "fixture-3.safetensors",
      "sha256": "6f8691f6e1b626f32d66cd651c3a2167704862ecd00a8b5ad2454f15afb7653c",
      "bytes": 46672,
      "module": "model.layers.10.mlp.switch_mlp.gate_proj",
      "columns": 2560,
      "dimensions": 2,
      "entries": 256,
      "group_size": 64,
      "packing": "unpacked8",
      "ranges": [
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.codes",
          "offset": 545084766,
          "bytes": 8960,
          "sha256": "be7d524a4787d503aa3494d1ffd4a638bb1620cfe4fc27733b912edbe1062d0d"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.codebook",
          "offset": 544981342,
          "bytes": 1024,
          "sha256": "1350b361bf453593cd4d2d3bfd8f7fc4836fa5d421d75a76088a88fa884ab0cf"
        },
        {
          "shard": "model-00013.safetensors",
          "tensor": "model.layers.10.mlp.switch_mlp.gate_proj.vq_scales",
          "offset": 3934146686,
          "bytes": 560,
          "sha256": "f192589e8e75a224f5c78c25cf3e7027d71c03ee5e64dc9ca633a32c85a17cab"
        }
      ]
    },
    {
      "path": "fixture-4.safetensors",
      "sha256": "78b7c9d327da0d1bc699a77b5b2834a0f8c86fe69a8df86329caa42bb9d49540",
      "bytes": 4174,
      "module": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0",
      "columns": 160,
      "dimensions": 2,
      "entries": 256,
      "group_size": 32,
      "packing": "bytes",
      "ranges": [
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.codes",
          "offset": 1464,
          "bytes": 560,
          "sha256": "2f12fa4c06fbfee8302812c396066020fbdc11359be80c156cf65e6ff8683cf1"
        },
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.codebook",
          "offset": 440,
          "bytes": 1024,
          "sha256": "a7dc08698f6d527a252d7c3b7b3949bc4da250d52783cb380a70e83cacc8b5e7"
        },
        {
          "shard": "model-ple-0000.safetensors",
          "tensor": "model.layers.1.ple.ple_embedding.ngram_embedding.shard_0.vq_scales",
          "offset": 200002424,
          "bytes": 70,
          "sha256": "8579b18302f2a1f32ae4254915f53811754a3a70ccbff9974d34b66762761c02"
        }
      ]
    }
  ],
  "network_bytes": 98338,
  "scope": "selected real rows, not full artifact parity"
}
```
