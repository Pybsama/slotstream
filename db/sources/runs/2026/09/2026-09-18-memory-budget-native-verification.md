---
type: run
id: 01m2tq3ras1qh5sgcb2x033pzk
created: 2026-09-18T16:55:34.489276+00:00
updated: 2026-09-18T16:55:35.097643+00:00
summary: 'Memory budget fix: native verification and unchanged image reuse failure'
binary: da884ad015138463c13aa91a9cbeba4dbe157eab843e00ca1b27f195119146d2; baseline identity embedded below
captured_at: 2026-09-18
command: Exact verification and baseline image commands are embedded below
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Memory budget fix: native verification and unchanged image reuse failure'
tool: Tools/verify.sh; Tools/vision_serving.py
---
# Native verification and pre-change comparison

The full native suite used the frozen allocation-fix binary below on the development 48 GB Mac. Ordinary model checks used small explicit budgets; the governor and image checks used the repository's separately authorized test profiles. No native 48 GB target or 64 GB machine was qualified. Global paging is diagnostic here; no clean performance claim is made.

Command: `SLOTSTREAM_TEST_BINARY=BINARY SLOTSTREAM_VERIFY_OUT=OUTPUT Tools/verify.sh`.

The suite completed with 26 top-level gates passed and one failed. The failure is image follow-up state reuse, not the answer: the image suite passes 24 checks and fails one reuse assertion. The identical image suite on the frozen pre-change checkout also passes 24 and fails the same assertion. Both source snapshots already include the separate conversation-resume changes that were present before this task. The memory fix does not modify that reuse code or weaken its checks.

Baseline command: `SLOTSTREAM_PREFILL_CHUNK=3072 SLOTSTREAM_BENCH_DETAILS=1 BASELINE serve --memory-gb 14.5 --mtp off --vision on --max-context 32768 --max-prefill-wait 0 --no-elastic --port 11468`, followed by `python3 Tools/vision_serving.py 11468`. The process was stopped immediately after the test.

These runs precede the final presentation-only headroom correction: small budgets can consume part of the nominal planning margin, and the report must show the actual remaining budget. That correction has separate final-build checks.

## Allocation-fix build

```json
{
  "source": {
    "Makefile": "1de4b2db83678e0705ebd955698b6d5fe053e0e3dc86a9326523ac23d219c567",
    "Package.resolved": "6fc23da3ddc636949e84042cb70da34bc93c4355feef14857880caa6c3c7fceb",
    "Package.swift": "8e2faec45c5aa764014d61b5cc04dee63640660322ad3e943084d5cb6dee4f87",
    "Sources/CSlotpack/include/slotpack.h": "07301354bebebac253975abbd5981006be411fed444abab0b6bbc857e28bdd1b",
    "Sources/CSlotpack/slotpack.c": "be45d2daf3e7e95d66cb9178f40dab292b85b1998086d71c53e41f59596d57a2",
    "Sources/Slotstream/AdaptiveSpeculation.swift": "da8062ff16c1d72ccd28852ba18e43cd434a8165483d045759cd29a499f5fff6",
    "Sources/Slotstream/BlockSelection.swift": "16e5fb4a4ea82728e3caaf3d6f4cdbf7d91614b757b0624913ae14c052d6f27d",
    "Sources/Slotstream/BoundedOutput.swift": "70c21c3583edecdd856af06c2fae567bccaf0ea2005ddb932a7dd99642e7780f",
    "Sources/Slotstream/CPUSlotWrite.swift": "da137aec8944dab6590cbea17afff28f094aef876688d20782b5791028d83349",
    "Sources/Slotstream/CacheBookkeeping.swift": "0c3726c431b41a2c84fa2ea21ce49eb209f2c36955925754508a51cb54ae0779",
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/CompiledArithmetic.swift": "98611b31035459d237d901be7fff175072c30b32b992c7534d770b1bc6d117f2",
    "Sources/Slotstream/Context.swift": "4430f6b1c76d06626ca144ff0cc488c015ea80eb56fd1a159aedf74075eab876",
    "Sources/Slotstream/ContextFeasibility.swift": "582f40326eea4d969834eefa13425dec345b5630206235640b4b9536ddb044d2",
    "Sources/Slotstream/ContextMemory.swift": "848df7f507cd1cc0d978ea29866f4c5c9635f5091ff236e551cde652cc668d9b",
    "Sources/Slotstream/ContextWindowPolicy.swift": "e08af95f21e83eb27b44b498d5f6a3e67260d9645578df5ac1f25ca91ffcb0cd",
    "Sources/Slotstream/DecodeLookahead+Configuration.swift": "82f8ebe02a37b882ea00c7b625008597bcfddf5df819df2592451d600ee0a9bd",
    "Sources/Slotstream/DecodeLookahead.swift": "9cf0cb2d1ac342c85279764e39fe12dc169c24ffb5e85c42a66828271dbad2e0",
    "Sources/Slotstream/DownloadConcurrency.swift": "cf872e6e99b9e1df121a9feba4c0c8420719fe62a5f5a50e58b26bf11cb8126e",
    "Sources/Slotstream/DownloadHTTP.swift": "341a7a7157c575658ee7d7bc6c77ed593bf30f79d8c262906d7672e2e40c6cbc",
    "Sources/Slotstream/EmbeddingRows.swift": "10c722abb55b03bd6ae0f8188ec156f97e2a7603a516bd91919e060d8fc5a645",
    "Sources/Slotstream/Engine.swift": "400f0cc79ba8c2fa404bca4cf449a92fa50dcb96c4ee56f8bff33621f1307deb",
    "Sources/Slotstream/Errors.swift": "0f65317656d38709f071fb58cb4c11f11f68f0949be02a781c675f37f76f5b57",
    "Sources/Slotstream/ExactRead.swift": "bd90fbeb1d400cb7dda746d434a5c4f1fbb4d767506013e4398de9ba1253a47e",
    "Sources/Slotstream/ExpertLookaheadTrace.swift": "c5fe8736e143fa0922dde772301497e007e51095b78b358434a61442831a4304",
    "Sources/Slotstream/ExpertPredictor.swift": "2f25044ff7258ac53973c3e5de7138ad078b0b90a1ab13cc332cab8bcfa0740e",
    "Sources/Slotstream/ExpertPrefetch.swift": "46fb601813d05b788a3648139cbde2b88c94714a5e15f99456e4b2e7072f4b6a",
    "Sources/Slotstream/ExpertStore.swift": "f69c680e9c130a178a84db8b6df6e63aabe64a5da2b9963c7e724114e8715ce6",
    "Sources/Slotstream/ExpertTransferProfile.swift": "17fe476f01b03d3a151506d324d9ad0d83d8dcf152489c9e88805ddea2b302ad",
    "Sources/Slotstream/GDNPhaseProfile.swift": "f74d843773b549530cebe9e5df79a02b0104068e05c39ff6adfcbae3effaef66",
    "Sources/Slotstream/GatewayDialect.swift": "93561b74b171c78d107dca5985a1c0601f7ca0ce4388f0a3aa03e9bd0c6bd0c8",
    "Sources/Slotstream/Generate.swift": "5adbf1b0f1be3c77657395be2e4afa4a80e26ea987a6dc8ba5267a0ecdb84f39",
    "Sources/Slotstream/Governor.swift": "ddac4e5d20f3a771cd81767d7734f7b2206b93ea1b2981388b78d6ac5abe1406",
    "Sources/Slotstream/LayerLocalVictim.swift": "9615385e6c2ac18573f4d2089a75a70d356d803c0c4a603b4db3397fafa6275c",
    "Sources/Slotstream/Layers.swift": "62a616ce6b356cb2a25fad893de89721babab0e6b623ec7fdc39336b0cc027ad",
    "Sources/Slotstream/MTP.swift": "10b63deee430c1e1d5792221f128bea0a6158161911676679665a168116cf743",
    "Sources/Slotstream/Machine.swift": "ffed1d45e029e21e42e1eb956d1b3f2647aae2bca689f532b5dc2dba897c89ee",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "2e0c13957d6cfba9b35544e0bd62a8dca9abc339980cf0b40baa56f66bbfa291",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/OpenAIDialect.swift": "714263f4382c83835c4e617ffcb72e231c270a0f0d8be497881cdfc663d52f58",
    "Sources/Slotstream/OpenAIOutput.swift": "d13c9a29f3dbcf9fb9933e5a378f3ba8160d7eb4f96d3c7a61f3faed5a563b76",
    "Sources/Slotstream/OptimizationPlatform.swift": "e4c17aeb1ab294ac9d9e9c60095cc5360382c0809a4f579672b4d0b66a0ed3cf",
    "Sources/Slotstream/Optimizations.swift": "87a994c3a89945b20985576de1d1619375aa779a6617dbe45af4d6ea3cb0d0a6",
    "Sources/Slotstream/PackedExpertLayout.swift": "c74e9867e2c37ba92d84bf7ce90253eea6db6f8531a6d6b8792874d4810cc6ee",
    "Sources/Slotstream/PackedProjectionPair.swift": "84fa87130270092c16a538f7d50cfee55e71b52ecd8250a1bce7e0547c8b1d96",
    "Sources/Slotstream/PartialRotation.swift": "57177495e6ba630c66744b2b9e2bde23acf9349fca52b97a4ea406c5839c7f8f",
    "Sources/Slotstream/PersistentPrefixCache.swift": "37d3fd0b1b6442a510632e5dc299ba6394f7b5ef9024573e66f4a31dd896ee25",
    "Sources/Slotstream/PersistentPrefixFormat.swift": "eec16cb611bf9a5c617ea73f465f05db1f4fdae503b1b3655b59d6cbe7290702",
    "Sources/Slotstream/PersistentPrefixGenerator.swift": "bae78e31b820287cfe1aca148c2976fc0c6a6fef694e364559e827f06e018326",
    "Sources/Slotstream/PersistentPrefixPolicy.swift": "ba927481648ab94e2f5882ca4d8f7b8e084e45311efb012efc03df93e9bab197",
    "Sources/Slotstream/PersistentPrefixRestore.swift": "ee3bc4123ac885375ac2be349454f92dcfecd28478eb905427d5f33e6925e8c4",
    "Sources/Slotstream/PersistentPrefixSave.swift": "3605a27cacf1c7b94bb228785d7be1b1e4bbb4a64f455c4b93ea6b2f292d811f",
    "Sources/Slotstream/PinnedModel.swift": "0c7c16539bcb54924ff7306b03b470e2915b5bb41c4ecff9e60dc7912e7afdd2",
    "Sources/Slotstream/PinnedTransport.swift": "f30c4c4bfeaf49c5e2dfcbfa728d6eab44d02a1f77d40217e84723fd03761d87",
    "Sources/Slotstream/PinnedTransportManifest.swift": "6b0de220938fc91dd4dc24cd0fc9dffa086f09f04cd83823dc3de3a13de8ac11",
    "Sources/Slotstream/Plan.swift": "9bbc3c9eb28d772ed0d5914a7176d5daeacfd5f1b464e79dbd4111873d2014e7",
    "Sources/Slotstream/PlannerCostModel.swift": "a95e2781a7448418ec78480be356bac9eb80bb36cc64c63f6cb3e378043d29c0",
    "Sources/Slotstream/PlannerDevice.swift": "528cdf93cf0fe600b8c53a3eb828b9b1922ee4817fa100393a11d4e2714784f8",
    "Sources/Slotstream/PrefixCache.swift": "3164672f8375dc31c9220ef03bf3acc1e5b418a3e09f3a9225675159894cab2b",
    "Sources/Slotstream/PressureBoundary.swift": "ed22537fccc321589eb3d33b3538984630daae951d00e4ac829412897b181a3d",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Sources/Slotstream/RequestControl.swift": "a8bea5078dbd26458331af41fba986f9de05d386637b69768e2035c95345bdea",
    "Sources/Slotstream/ResidentExpertOverlap.swift": "4ddb3a027d92697dcc1e7373e66fc139abdc12063448d864ef635e5202f57dde",
    "Sources/Slotstream/ResponsesDialect.swift": "efaafe08d7cf67097cf0769a7a5d3b7443e6a403ead6fe45450b8aee032d73e5",
    "Sources/Slotstream/RouterProjection.swift": "880d9ee9a46eeb2cdae2560c5d4def671f3fe98e56f04cc036cb3e775d20baed",
    "Sources/Slotstream/RouterSelection.swift": "35b122748ab05c00122bfb5b4c78416ee28b55abaa4d4e1379fd163aaf47b4a6",
    "Sources/Slotstream/RouterTapCorrection.swift": "ea460d1e96eb4bd00796d027f4d03ecbd1c636acf3a10114b2e8e75a7b0db69d",
    "Sources/Slotstream/RouterTrace.swift": "b34c1974f60015c913649a285023e57b15d92f37c2f7aa282b821eb2043652c1",
    "Sources/Slotstream/RoutingReadbackQueue.swift": "477ad597e6e741cb939c9ade983934814e2a7c6b8e7c59fc659a1dc02eb4b4ab",
    "Sources/Slotstream/SelectedAttention.swift": "70e61a089444f74cc74494d7f05005b0ff4dfe67043782befbbef80d96b911db",
    "Sources/Slotstream/Server.swift": "bc8f1f4f5ee19e2c7e0436a87ca283234580a6d69d3228cc4a5c4bef7e889b46",
    "Sources/Slotstream/SlotWritePlan.swift": "9abde1de815522ff835d3c685a2e342293f3c9c7019cfc742265193ea2e286c1",
    "Sources/Slotstream/SlotpackDownload.swift": "fb6f47ce70f30713cf1679ebda619c980e9d783dd6ae4cd1cc4e0a68b14705b7",
    "Sources/Slotstream/SlotpackManifest.swift": "8664440e22653e64b85c0100345169dd93b3836d1bbd125ac2add4f621b9876d",
    "Sources/Slotstream/StatePrefixFork.swift": "35ed6954bc927e37c117d53eb25e007b83b3385099bc9b18e01607f30abb7df7",
    "Sources/Slotstream/StateRecovery.swift": "078521e0e08233c06706408bb6dbc53f902285fc4c891af2e164386bd41bf98b",
    "Sources/Slotstream/TapCorrectionSidecar.swift": "581d7438fd01ce576691f5b322464337e85f03cca2911a6c8631f32484e72d82",
    "Sources/Slotstream/ToolCallSplitter.swift": "2c2e1d722188d633508c871d73f011fa4053b666d10b7585b304c151c53925a8",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
    "Sources/Slotstream/VerifyPassSelfCheck.swift": "26ca8436fe35256c807130421e83a6427f7dc3aae677a01d67132e197748680a",
    "Sources/Slotstream/Version.swift": "aaa50adc8f50b06a2abada53add0fc54bb52562612dcca093eb1b7d22b860346",
    "Sources/Slotstream/Vision.swift": "38565f564bf8ba73d2dc87e2f1874fa6fda2652e094a324048bfa8cb1278a79e",
    "Sources/Slotstream/VisionAttention.swift": "83b1012cb0b3a2c22098f71515e3e853cf1ca3affb01cb667a8248e3c34c63a5",
    "Sources/Slotstream/VisionPrompt.swift": "61b90891a5ec9944406287fa73b4c0e5bdd29b4e3903dff345cbeb80638c6435",
    "Sources/Slotstream/WeightDownload.swift": "2758b2eea2631635cd3da5c18a87e724c57aab5c78ad816b7e18d7ff48c8c98d",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "2b49a238aba23e34eab51b2d21d4d93550dc23b69c2d10f3fbcac3ef182e93fc",
    "Sources/Slotstream/WordSlotWrite.swift": "1c19def2346669acc1afa811a7244233c6f593de91c02bfc4ff145465b95187e",
    "Sources/SlotstreamDiagnostics/CheckReport.swift": "9bbe2106b5b55331cc3fbc093edd803eff6f9f00ebd5f30ce587754fe0bc7e47",
    "Sources/SlotstreamDiagnostics/Diagnostics+AdaptiveSpeculation.swift": "e53d32c4f5a3fc7039a258db5c5b3c530416d07828c5d424a8f35e67d80dc256",
    "Sources/SlotstreamDiagnostics/Diagnostics+AlignedResume.swift": "ba79196d9689422b7b46d1819bda711557b4770d5954c981b1e094bfe722cd48",
    "Sources/SlotstreamDiagnostics/Diagnostics+AllHitReplay.swift": "187a98c70c2e66008622db3727f0bf58126928862bc102782574fa0ba5f57513",
    "Sources/SlotstreamDiagnostics/Diagnostics+BlockSelection.swift": "08d3f1fc29b6353443b795198295bacb85f57d0a2bdbac67450cf66d505f852c",
    "Sources/SlotstreamDiagnostics/Diagnostics+CacheBookkeeping.swift": "6db1e4743b6adce39f32c2c5c0ff9c38bb86d7e9548c41e6c0e7d64299dd9cae",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompactIndexer.swift": "3dd65c8fac32f2804cce942845946debe74ca83b9cf6485a441ed15331711a5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompiledNorm.swift": "9f1beb774172bc33a27020261532e06723f0794adba9ab5dbca7807d01a0748f",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompletePrompt.swift": "75cdd2137b2856407d2fb297504039b174b3ae116b40608d5f42fabf0237a66d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ComputeIslands.swift": "ac7f3b5ed140a566348e9be06274cf757144d2db099fe5af097c4a3807dc6801",
    "Sources/SlotstreamDiagnostics/Diagnostics+Context.swift": "76ea9c95cd2d20614533458ffe32c8e8fd6d29dee3b1bece7476e27d3f589ce0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift": "51e505bd3279983263ad731133b2f1e20606387cf03ba360ffcb2fba34dd33a3",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift": "90b83306d1966da794daf28cc84f426a42cd853075f5e236cf1bacae10787d8f",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeLookahead.swift": "21010a5472f074f99c06bfba5966359be29dafed3c89cd3abffa8f5d19224a76",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRows.swift": "a0f0532a43c1329b3a69f8a3bd8607df9f27793c0994ad23203936896b44e81f",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRuntime.swift": "c5c37fafb45b2ac2434a36cd7c8b8804fac0e271e9e3f0fb10ef97481db77e24",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExactRead.swift": "77a357f55c3f5aced5ba0d74012e35f73e678e0840024f24a5ab86909d335c59",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift": "e503268e9d228214bf4ff7fa8851bf551372c20de338a2c6164ba9140d175b0e",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProfile.swift": "6d982a575d6c6282941a9f9f3ac063b75d31996fcde387a63ca3ce44fea93242",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProjection.swift": "983a071e562451dbc22cfe09b005d9c68af687c10e7d94802d7d3cb28af1c7cd",
    "Sources/SlotstreamDiagnostics/Diagnostics+Governor.swift": "8ec85ff3609cd5657eae1a8434189e9474460aad0c850f6b88240457c8f0f1fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+HTTP.swift": "9526e51122c9e463ea9a3201da6e4628f3794f329bd4ca05f1496daf3c66c1e5",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageFailure.swift": "766742295107f924177f7f724a7be61f8ccb29b3e044a7de345523598c31cead",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageReuse.swift": "5d0e619769c0f7d4ea8c73439ac44bc499db6184c4954b417f4cb7804aec20e8",
    "Sources/SlotstreamDiagnostics/Diagnostics+Integrated.swift": "5eb2132959b1db779caa520a3eefe5d6c5ffdd9ed317750c8cee48f02bd05941",
    "Sources/SlotstreamDiagnostics/Diagnostics+LayerLocalVictim.swift": "d512d93741a6675412cc9e6c739b940132ca3f20ebecd709884b00b1ebbc49b7",
    "Sources/SlotstreamDiagnostics/Diagnostics+MTPIndexer.swift": "7784a18a1eddafa25ecaee9eeacfbcddf8bcabac8d53919f80367a4f4e5be476",
    "Sources/SlotstreamDiagnostics/Diagnostics+Machine.swift": "20f6edb816fc3a794143042e59847adbfc1fe06514fc990e8a3d81eb87abe50c",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramCache.swift": "9bee4eb6c6cf09df5673e177d4b7f006681794bf680366b4549e4fa3d38b7368",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramLookahead.swift": "3b0bc7ea21a57d2ce65e58773879f5f86ba7f0f37c47d8f1d08d51e61c486370",
    "Sources/SlotstreamDiagnostics/Diagnostics+Optimization.swift": "35d99deb614da4ffdfef075eabdc5a1c8b3518bf9accf265796e09f2c7c281ee",
    "Sources/SlotstreamDiagnostics/Diagnostics+Output.swift": "e39951dc83e8410abdc840d0a739e1e1b2fbbdf1e2d06b3cb2d28c39ee9329cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+OutputServing.swift": "50bb807143f1e5134f52a6f3d48b8da297f4186dd91895e016d191ca13ccf66a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PackedLayout.swift": "14c31f94ebdd8bbbbb1479c77d0649b4c0632d978e4d8a60a8048214a1e08e65",
    "Sources/SlotstreamDiagnostics/Diagnostics+PartialRotation.swift": "de75d07feedc163834fe8e716683af8b2d373c51b0588ccc2cac922f775367ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefix.swift": "46a5bc33ee3fd389694f22c9e7ff5cdd995539663b3141688414351f50ac3189",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixModel.swift": "3e06c67777ce3572d9bd7cce5d220be5f41af90e31b6f5da349ba6f3ec667798",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixPolicy.swift": "82dcadab2ac079d3662da6dd012d8a031c4bdea9ee8c022ac34d5faf66277f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+PoolRequests.swift": "e383c494263afa029a9ef107c90d6ba59f44cda5da7ca1035eae68cbda3562d2",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillQualification.swift": "f40d8e711121f12cbcd95f8880d483ac36995faeab06af714d201fa1671348f1",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixCapacity.swift": "b76e9185930a90d2509f9d7dfc247afee3ff2a083a1bc6bb3da6d090653d290f",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixFork.swift": "e7a7094b3930cef8e380d711f20e8f82e2821c070579549692a6120e9ba3afc4",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixRetention.swift": "5de9452266e8e59da03b078990689554fc7a419a5cd8e5879cc68e2e277ea8cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixVision.swift": "5e4737dbe5344492fc2f9c6881f8d56e997668f674c91b28b9349c9420465f72",
    "Sources/SlotstreamDiagnostics/Diagnostics+PressureBoundary.swift": "f84979a3da94bc5ac0cfeb5cc84b61af43716c5664cc71853085ffa1b116d325",
    "Sources/SlotstreamDiagnostics/Diagnostics+Pull.swift": "224e4bf5210afbddd992894860343add73d1f52b12b2d9a00abf78fdc492ada0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift": "1532f45714ceb98a5adcfa31abd31f065493164f49d2ee3aac868d5d4080b04c",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift": "9e98b6e0fd6c30f36d1d3ec8d556216f351a2f09ee5d15dbb4f5580858fad4b4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadRecovery.swift": "5d51636a62b376e74dfefab207fdd42da61436210973f714819c7cc11488a04d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ResidentOverlap.swift": "c1e7b847cffa51939b0ae20027b289efcae5585a94ae5c1c751a66f110a25522",
    "Sources/SlotstreamDiagnostics/Diagnostics+RopePerformance.swift": "19d040f21391a1ea87831b73a8adf055a78aeafe9d902bd11ce22fd6a492d892",
    "Sources/SlotstreamDiagnostics/Diagnostics+RouterProjection.swift": "3981e415003e6258d41690216a7ab668652a0ce436bf644d99d88dbc2799db9e",
    "Sources/SlotstreamDiagnostics/Diagnostics+RoutingReadback.swift": "f29aad2cde3bbb526f83dcec4565f3c382d071734acc47a0e31d7223312713cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+Runtime.swift": "69cc7879d26e9e51807d825f29203f00490ce5a77bf7db66d03d3d99e0074e30",
    "Sources/SlotstreamDiagnostics/Diagnostics+RuntimeBudget.swift": "b5ce492456b9e27b19765a0bd4f23cbd81ccff034be5af3142737cdae7944d6e",
    "Sources/SlotstreamDiagnostics/Diagnostics+SamplerPerformance.swift": "4e6dd7e85d7ac0f2b2af291343ab4cdc52fa94fe6edb588c1d517008a0c35cb3",
    "Sources/SlotstreamDiagnostics/Diagnostics+SelectedAttention.swift": "8dd385da9b79c3625d1cc9ccc6c8821978f88437fcded918f049328b7a969e7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Selection.swift": "b737794c5a57cd224f36a93b960fa9834cabb51ef810945bab64fd71e59c91d0",
    "Sources/SlotstreamDiagnostics/Diagnostics+SlotSlices.swift": "32c10a839423b13a4dceff67a5b2a617f90d145376a70b19bd27f2e62452e288",
    "Sources/SlotstreamDiagnostics/Diagnostics+StateRecovery.swift": "a53db99ff0f97a26e87586e35bf05daa26b9281fe7d686a1670c14984da2dd77",
    "Sources/SlotstreamDiagnostics/Diagnostics+TerminalPrefill.swift": "7ef27bec8489f52ccdd3ea51c125d21eb94512924b163e854b7aaf25ef39f57a",
    "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "be63108d11318a9469d26587ade08c79bf34274c61b847d752663d8ce007f9af",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/CodexFixture.swift": "23839d1d776252c1c5cec6a3acaf6c08c1e89bc7def714f7b5f3180fae57aac0",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "da4b4a89d9b11d26a64cd244aae2887acfbca16a6d3aceefa8f40f90c8e39634",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "fe3aaf4ad816c02fc0b28771d6c3c7f9cf7b2a9f102ea4fce660c1dd8541a650",
    "Sources/SlotstreamTestKit/ResponsesChecks.swift": "1dc4ab33a448eaf27ffd06b0dde845d19f79128fd6a8676b807e693378cae6fc",
    "Sources/SlotstreamTestKit/T0Checks.swift": "b18ad5ccdef3da20a1268865bfc59f09936f9b37455eebc30c77f37f5e456d02",
    "Sources/SlotstreamTestKit/ToolCallChecks.swift": "f1b263239f4e82707c77a5887367fb5302e96d369f2f278e0e45a87d3006dad8",
    "Sources/SlotstreamTestKit/WeightStoreChecks.swift": "d26e43367ba2d61d7afd9f5b175e95b714409b1717b86b9fe71f1306e36b6a81",
    "Sources/slotstream-checks/main.swift": "02ebabaf058afa95622ccd29fb65d80b7eac41c9e6232f0167ef288c2126e0d9",
    "Sources/slotstream-cli/CheckRendering.swift": "0905dcbae17a5b3d66e13a760c4054fb29d930331d32942a528510ecfe9769a1",
    "Sources/slotstream-cli/ContextCommands.swift": "3ba24ae3e24dd10214e3288f007952d9e2b06241c081e29313b42ac7aa7a31bb",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift": "249274657b4f4f4c3e694a2b0db671b3af8b92a2148495647f3be9092f48f6b2",
    "Sources/slotstream-cli/MTPCommands.swift": "d84c026f8d56ea8d30608d7e7795611d769fd57bf58a1b799608bd5e866c3b96",
    "Sources/slotstream-cli/OptimizationCommands.swift": "9a0013222a0accfb268bb860f94e8939b2b99f8fb31bd949be9d5e9ace83e8d5",
    "Sources/slotstream-cli/PackedExpertCommands.swift": "ea7f4485d60a985a0a1f759f077d28dc42f36512dc1dd07a7644a22e31346b12",
    "Sources/slotstream-cli/PrefixCacheCommand.swift": "266b9571726fe280c11d5dededa565375af1749b76c7e70def4fe9530729914f",
    "Sources/slotstream-cli/PrefixExactCommands.swift": "f609a0b89376cf02b277dc00804c35d39883de179c2733c8baa3c3eaf565779b",
    "Sources/slotstream-cli/Pull.swift": "d60a4ea7cebd27aa7995b4ae3ea74718e5b5eaf9d473f5cf85dcef83c9dbefaf",
    "Sources/slotstream-cli/SweepCommands.swift": "37455d724a63b1689208dce9d55cd3d249bcab6d45bdf40d5c5e4f6992aa0d20",
    "Sources/slotstream-cli/VisionCommands.swift": "df80e089ea9cdbc6fc51ec7dc895b0dbf0eec5d4db80eb73b0ca9720a3ce8cc0",
    "Sources/slotstream-cli/main.swift": "07011f1f32aac526bfc2728b3fb3b0172acdc04a2109bd3dc9b4abe15a402ee6",
    "Tools/build_identity.py": "d70a97380b1244727674861ae64ab166d034c941878e6e2c18f3ffd77bbf2e86",
    "Tools/fetch_metallib.sh": "c47f5531c4195bfe1f827ba1049b76cb81687401b9e25e2a3cc4c9d7feb64860"
  },
  "source_archive_sha256": "3638cb1df3ef6a65926889639372247991b315692ead3f69c94ce02ee645c78c",
  "binary_sha256": "da884ad015138463c13aa91a9cbeba4dbe157eab843e00ca1b27f195119146d2",
  "metallib_sha256": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597"
}

```

## Pre-change build

```json
{
  "source": {
    "Makefile": "1de4b2db83678e0705ebd955698b6d5fe053e0e3dc86a9326523ac23d219c567",
    "Package.resolved": "6fc23da3ddc636949e84042cb70da34bc93c4355feef14857880caa6c3c7fceb",
    "Package.swift": "8e2faec45c5aa764014d61b5cc04dee63640660322ad3e943084d5cb6dee4f87",
    "Sources/CSlotpack/include/slotpack.h": "07301354bebebac253975abbd5981006be411fed444abab0b6bbc857e28bdd1b",
    "Sources/CSlotpack/slotpack.c": "be45d2daf3e7e95d66cb9178f40dab292b85b1998086d71c53e41f59596d57a2",
    "Sources/Slotstream/AdaptiveSpeculation.swift": "da8062ff16c1d72ccd28852ba18e43cd434a8165483d045759cd29a499f5fff6",
    "Sources/Slotstream/BlockSelection.swift": "16e5fb4a4ea82728e3caaf3d6f4cdbf7d91614b757b0624913ae14c052d6f27d",
    "Sources/Slotstream/BoundedOutput.swift": "70c21c3583edecdd856af06c2fae567bccaf0ea2005ddb932a7dd99642e7780f",
    "Sources/Slotstream/CPUSlotWrite.swift": "da137aec8944dab6590cbea17afff28f094aef876688d20782b5791028d83349",
    "Sources/Slotstream/CacheBookkeeping.swift": "0c3726c431b41a2c84fa2ea21ce49eb209f2c36955925754508a51cb54ae0779",
    "Sources/Slotstream/Checkpoint.swift": "c12d46bb51943700c05f7de0269574de2077a15d347a542f7bb229f47b0d4353",
    "Sources/Slotstream/CompiledArithmetic.swift": "98611b31035459d237d901be7fff175072c30b32b992c7534d770b1bc6d117f2",
    "Sources/Slotstream/Context.swift": "4430f6b1c76d06626ca144ff0cc488c015ea80eb56fd1a159aedf74075eab876",
    "Sources/Slotstream/ContextFeasibility.swift": "582f40326eea4d969834eefa13425dec345b5630206235640b4b9536ddb044d2",
    "Sources/Slotstream/ContextMemory.swift": "848df7f507cd1cc0d978ea29866f4c5c9635f5091ff236e551cde652cc668d9b",
    "Sources/Slotstream/ContextWindowPolicy.swift": "6da4b93a1a01b1d1b9be13b14d7c4d3b3751f1c38575672d4489f3545a913ab6",
    "Sources/Slotstream/DecodeLookahead+Configuration.swift": "82f8ebe02a37b882ea00c7b625008597bcfddf5df819df2592451d600ee0a9bd",
    "Sources/Slotstream/DecodeLookahead.swift": "9cf0cb2d1ac342c85279764e39fe12dc169c24ffb5e85c42a66828271dbad2e0",
    "Sources/Slotstream/DownloadConcurrency.swift": "cf872e6e99b9e1df121a9feba4c0c8420719fe62a5f5a50e58b26bf11cb8126e",
    "Sources/Slotstream/DownloadHTTP.swift": "341a7a7157c575658ee7d7bc6c77ed593bf30f79d8c262906d7672e2e40c6cbc",
    "Sources/Slotstream/EmbeddingRows.swift": "10c722abb55b03bd6ae0f8188ec156f97e2a7603a516bd91919e060d8fc5a645",
    "Sources/Slotstream/Engine.swift": "400f0cc79ba8c2fa404bca4cf449a92fa50dcb96c4ee56f8bff33621f1307deb",
    "Sources/Slotstream/Errors.swift": "0f65317656d38709f071fb58cb4c11f11f68f0949be02a781c675f37f76f5b57",
    "Sources/Slotstream/ExactRead.swift": "bd90fbeb1d400cb7dda746d434a5c4f1fbb4d767506013e4398de9ba1253a47e",
    "Sources/Slotstream/ExpertLookaheadTrace.swift": "c5fe8736e143fa0922dde772301497e007e51095b78b358434a61442831a4304",
    "Sources/Slotstream/ExpertPredictor.swift": "2f25044ff7258ac53973c3e5de7138ad078b0b90a1ab13cc332cab8bcfa0740e",
    "Sources/Slotstream/ExpertPrefetch.swift": "46fb601813d05b788a3648139cbde2b88c94714a5e15f99456e4b2e7072f4b6a",
    "Sources/Slotstream/ExpertStore.swift": "f69c680e9c130a178a84db8b6df6e63aabe64a5da2b9963c7e724114e8715ce6",
    "Sources/Slotstream/ExpertTransferProfile.swift": "17fe476f01b03d3a151506d324d9ad0d83d8dcf152489c9e88805ddea2b302ad",
    "Sources/Slotstream/GDNPhaseProfile.swift": "f74d843773b549530cebe9e5df79a02b0104068e05c39ff6adfcbae3effaef66",
    "Sources/Slotstream/GatewayDialect.swift": "93561b74b171c78d107dca5985a1c0601f7ca0ce4388f0a3aa03e9bd0c6bd0c8",
    "Sources/Slotstream/Generate.swift": "5adbf1b0f1be3c77657395be2e4afa4a80e26ea987a6dc8ba5267a0ecdb84f39",
    "Sources/Slotstream/Governor.swift": "ddac4e5d20f3a771cd81767d7734f7b2206b93ea1b2981388b78d6ac5abe1406",
    "Sources/Slotstream/LayerLocalVictim.swift": "9615385e6c2ac18573f4d2089a75a70d356d803c0c4a603b4db3397fafa6275c",
    "Sources/Slotstream/Layers.swift": "62a616ce6b356cb2a25fad893de89721babab0e6b623ec7fdc39336b0cc027ad",
    "Sources/Slotstream/MTP.swift": "10b63deee430c1e1d5792221f128bea0a6158161911676679665a168116cf743",
    "Sources/Slotstream/Machine.swift": "ffed1d45e029e21e42e1eb956d1b3f2647aae2bca689f532b5dc2dba897c89ee",
    "Sources/Slotstream/MemTrace.swift": "756d8032ad7558c84eb571c69e3d4773ff105eb0ab78790662aa637e4d0e19d6",
    "Sources/Slotstream/Model.swift": "2e0c13957d6cfba9b35544e0bd62a8dca9abc339980cf0b40baa56f66bbfa291",
    "Sources/Slotstream/NgramPrefetch.swift": "7342c07a6b475ea8d8568b08e041b0ffb0d35456892e79aaac6197db08b2e03c",
    "Sources/Slotstream/NgramStore.swift": "f9f0cf609ac1bec2c7abb645b365fcb174dd4b5ec812b602985bacab847cdfbf",
    "Sources/Slotstream/Observation.swift": "fcb7557541a5a0ce885737449d6b2b88009a8521a7c743cded5d120867529e10",
    "Sources/Slotstream/OpenAIDialect.swift": "714263f4382c83835c4e617ffcb72e231c270a0f0d8be497881cdfc663d52f58",
    "Sources/Slotstream/OpenAIOutput.swift": "d13c9a29f3dbcf9fb9933e5a378f3ba8160d7eb4f96d3c7a61f3faed5a563b76",
    "Sources/Slotstream/OptimizationPlatform.swift": "e4c17aeb1ab294ac9d9e9c60095cc5360382c0809a4f579672b4d0b66a0ed3cf",
    "Sources/Slotstream/Optimizations.swift": "87a994c3a89945b20985576de1d1619375aa779a6617dbe45af4d6ea3cb0d0a6",
    "Sources/Slotstream/PackedExpertLayout.swift": "c74e9867e2c37ba92d84bf7ce90253eea6db6f8531a6d6b8792874d4810cc6ee",
    "Sources/Slotstream/PackedProjectionPair.swift": "84fa87130270092c16a538f7d50cfee55e71b52ecd8250a1bce7e0547c8b1d96",
    "Sources/Slotstream/PartialRotation.swift": "57177495e6ba630c66744b2b9e2bde23acf9349fca52b97a4ea406c5839c7f8f",
    "Sources/Slotstream/PersistentPrefixCache.swift": "37d3fd0b1b6442a510632e5dc299ba6394f7b5ef9024573e66f4a31dd896ee25",
    "Sources/Slotstream/PersistentPrefixFormat.swift": "eec16cb611bf9a5c617ea73f465f05db1f4fdae503b1b3655b59d6cbe7290702",
    "Sources/Slotstream/PersistentPrefixGenerator.swift": "bae78e31b820287cfe1aca148c2976fc0c6a6fef694e364559e827f06e018326",
    "Sources/Slotstream/PersistentPrefixPolicy.swift": "ba927481648ab94e2f5882ca4d8f7b8e084e45311efb012efc03df93e9bab197",
    "Sources/Slotstream/PersistentPrefixRestore.swift": "ee3bc4123ac885375ac2be349454f92dcfecd28478eb905427d5f33e6925e8c4",
    "Sources/Slotstream/PersistentPrefixSave.swift": "3605a27cacf1c7b94bb228785d7be1b1e4bbb4a64f455c4b93ea6b2f292d811f",
    "Sources/Slotstream/PinnedModel.swift": "0c7c16539bcb54924ff7306b03b470e2915b5bb41c4ecff9e60dc7912e7afdd2",
    "Sources/Slotstream/PinnedTransport.swift": "f30c4c4bfeaf49c5e2dfcbfa728d6eab44d02a1f77d40217e84723fd03761d87",
    "Sources/Slotstream/PinnedTransportManifest.swift": "6b0de220938fc91dd4dc24cd0fc9dffa086f09f04cd83823dc3de3a13de8ac11",
    "Sources/Slotstream/Plan.swift": "348910480511b75eff33e84cb14d677514c0a47cf860fdc3984d27d96de8dbfe",
    "Sources/Slotstream/PlannerCostModel.swift": "a95e2781a7448418ec78480be356bac9eb80bb36cc64c63f6cb3e378043d29c0",
    "Sources/Slotstream/PlannerDevice.swift": "528cdf93cf0fe600b8c53a3eb828b9b1922ee4817fa100393a11d4e2714784f8",
    "Sources/Slotstream/PrefixCache.swift": "3164672f8375dc31c9220ef03bf3acc1e5b418a3e09f3a9225675159894cab2b",
    "Sources/Slotstream/PressureBoundary.swift": "ed22537fccc321589eb3d33b3538984630daae951d00e4ac829412897b181a3d",
    "Sources/Slotstream/ProcessMemory.swift": "0a227d642f1f6fca916531f3601f17f5eaadd56c9b8b0c57892719792362fa66",
    "Sources/Slotstream/RequestControl.swift": "a8bea5078dbd26458331af41fba986f9de05d386637b69768e2035c95345bdea",
    "Sources/Slotstream/ResidentExpertOverlap.swift": "4ddb3a027d92697dcc1e7373e66fc139abdc12063448d864ef635e5202f57dde",
    "Sources/Slotstream/ResponsesDialect.swift": "efaafe08d7cf67097cf0769a7a5d3b7443e6a403ead6fe45450b8aee032d73e5",
    "Sources/Slotstream/RouterProjection.swift": "880d9ee9a46eeb2cdae2560c5d4def671f3fe98e56f04cc036cb3e775d20baed",
    "Sources/Slotstream/RouterSelection.swift": "35b122748ab05c00122bfb5b4c78416ee28b55abaa4d4e1379fd163aaf47b4a6",
    "Sources/Slotstream/RouterTapCorrection.swift": "ea460d1e96eb4bd00796d027f4d03ecbd1c636acf3a10114b2e8e75a7b0db69d",
    "Sources/Slotstream/RouterTrace.swift": "b34c1974f60015c913649a285023e57b15d92f37c2f7aa282b821eb2043652c1",
    "Sources/Slotstream/RoutingReadbackQueue.swift": "477ad597e6e741cb939c9ade983934814e2a7c6b8e7c59fc659a1dc02eb4b4ab",
    "Sources/Slotstream/SelectedAttention.swift": "70e61a089444f74cc74494d7f05005b0ff4dfe67043782befbbef80d96b911db",
    "Sources/Slotstream/Server.swift": "bc8f1f4f5ee19e2c7e0436a87ca283234580a6d69d3228cc4a5c4bef7e889b46",
    "Sources/Slotstream/SlotWritePlan.swift": "9abde1de815522ff835d3c685a2e342293f3c9c7019cfc742265193ea2e286c1",
    "Sources/Slotstream/SlotpackDownload.swift": "fb6f47ce70f30713cf1679ebda619c980e9d783dd6ae4cd1cc4e0a68b14705b7",
    "Sources/Slotstream/SlotpackManifest.swift": "8664440e22653e64b85c0100345169dd93b3836d1bbd125ac2add4f621b9876d",
    "Sources/Slotstream/StatePrefixFork.swift": "35ed6954bc927e37c117d53eb25e007b83b3385099bc9b18e01607f30abb7df7",
    "Sources/Slotstream/StateRecovery.swift": "078521e0e08233c06706408bb6dbc53f902285fc4c891af2e164386bd41bf98b",
    "Sources/Slotstream/TapCorrectionSidecar.swift": "581d7438fd01ce576691f5b322464337e85f03cca2911a6c8631f32484e72d82",
    "Sources/Slotstream/ToolCallSplitter.swift": "2c2e1d722188d633508c871d73f011fa4053b666d10b7585b304c151c53925a8",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "ac0a81ccd99ebb59a52ad0728221f34c59d2402d255b4e6a9cbb583b7d42dd6f",
    "Sources/Slotstream/VerifyPassSelfCheck.swift": "26ca8436fe35256c807130421e83a6427f7dc3aae677a01d67132e197748680a",
    "Sources/Slotstream/Version.swift": "aaa50adc8f50b06a2abada53add0fc54bb52562612dcca093eb1b7d22b860346",
    "Sources/Slotstream/Vision.swift": "38565f564bf8ba73d2dc87e2f1874fa6fda2652e094a324048bfa8cb1278a79e",
    "Sources/Slotstream/VisionAttention.swift": "83b1012cb0b3a2c22098f71515e3e853cf1ca3affb01cb667a8248e3c34c63a5",
    "Sources/Slotstream/VisionPrompt.swift": "61b90891a5ec9944406287fa73b4c0e5bdd29b4e3903dff345cbeb80638c6435",
    "Sources/Slotstream/WeightDownload.swift": "2758b2eea2631635cd3da5c18a87e724c57aab5c78ad816b7e18d7ff48c8c98d",
    "Sources/Slotstream/WeightStore.swift": "b7b9c43d6aaee926a6c13701e65cded306e9eb8483477b61ff81dcf212f39999",
    "Sources/Slotstream/Weights.swift": "2b49a238aba23e34eab51b2d21d4d93550dc23b69c2d10f3fbcac3ef182e93fc",
    "Sources/Slotstream/WordSlotWrite.swift": "1c19def2346669acc1afa811a7244233c6f593de91c02bfc4ff145465b95187e",
    "Sources/SlotstreamDiagnostics/CheckReport.swift": "9bbe2106b5b55331cc3fbc093edd803eff6f9f00ebd5f30ce587754fe0bc7e47",
    "Sources/SlotstreamDiagnostics/Diagnostics+AdaptiveSpeculation.swift": "e53d32c4f5a3fc7039a258db5c5b3c530416d07828c5d424a8f35e67d80dc256",
    "Sources/SlotstreamDiagnostics/Diagnostics+AlignedResume.swift": "ba79196d9689422b7b46d1819bda711557b4770d5954c981b1e094bfe722cd48",
    "Sources/SlotstreamDiagnostics/Diagnostics+AllHitReplay.swift": "187a98c70c2e66008622db3727f0bf58126928862bc102782574fa0ba5f57513",
    "Sources/SlotstreamDiagnostics/Diagnostics+BlockSelection.swift": "08d3f1fc29b6353443b795198295bacb85f57d0a2bdbac67450cf66d505f852c",
    "Sources/SlotstreamDiagnostics/Diagnostics+CacheBookkeeping.swift": "6db1e4743b6adce39f32c2c5c0ff9c38bb86d7e9548c41e6c0e7d64299dd9cae",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompactIndexer.swift": "3dd65c8fac32f2804cce942845946debe74ca83b9cf6485a441ed15331711a5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompiledNorm.swift": "9f1beb774172bc33a27020261532e06723f0794adba9ab5dbca7807d01a0748f",
    "Sources/SlotstreamDiagnostics/Diagnostics+CompletePrompt.swift": "75cdd2137b2856407d2fb297504039b174b3ae116b40608d5f42fabf0237a66d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ComputeIslands.swift": "ac7f3b5ed140a566348e9be06274cf757144d2db099fe5af097c4a3807dc6801",
    "Sources/SlotstreamDiagnostics/Diagnostics+Context.swift": "76ea9c95cd2d20614533458ffe32c8e8fd6d29dee3b1bece7476e27d3f589ce0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextServing.swift": "51e505bd3279983263ad731133b2f1e20606387cf03ba360ffcb2fba34dd33a3",
    "Sources/SlotstreamDiagnostics/Diagnostics+ContextSmallPass.swift": "90b83306d1966da794daf28cc84f426a42cd853075f5e236cf1bacae10787d8f",
    "Sources/SlotstreamDiagnostics/Diagnostics+DecodeLookahead.swift": "21010a5472f074f99c06bfba5966359be29dafed3c89cd3abffa8f5d19224a76",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRows.swift": "a0f0532a43c1329b3a69f8a3bd8607df9f27793c0994ad23203936896b44e81f",
    "Sources/SlotstreamDiagnostics/Diagnostics+EmbeddingRuntime.swift": "c5c37fafb45b2ac2434a36cd7c8b8804fac0e271e9e3f0fb10ef97481db77e24",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExactRead.swift": "77a357f55c3f5aced5ba0d74012e35f73e678e0840024f24a5ab86909d335c59",
    "Sources/SlotstreamDiagnostics/Diagnostics+ExpertLookahead.swift": "e503268e9d228214bf4ff7fa8851bf551372c20de338a2c6164ba9140d175b0e",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProfile.swift": "6d982a575d6c6282941a9f9f3ac063b75d31996fcde387a63ca3ce44fea93242",
    "Sources/SlotstreamDiagnostics/Diagnostics+GDNProjection.swift": "983a071e562451dbc22cfe09b005d9c68af687c10e7d94802d7d3cb28af1c7cd",
    "Sources/SlotstreamDiagnostics/Diagnostics+Governor.swift": "8ec85ff3609cd5657eae1a8434189e9474460aad0c850f6b88240457c8f0f1fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+HTTP.swift": "9526e51122c9e463ea9a3201da6e4628f3794f329bd4ca05f1496daf3c66c1e5",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageFailure.swift": "766742295107f924177f7f724a7be61f8ccb29b3e044a7de345523598c31cead",
    "Sources/SlotstreamDiagnostics/Diagnostics+ImageReuse.swift": "5d0e619769c0f7d4ea8c73439ac44bc499db6184c4954b417f4cb7804aec20e8",
    "Sources/SlotstreamDiagnostics/Diagnostics+Integrated.swift": "5eb2132959b1db779caa520a3eefe5d6c5ffdd9ed317750c8cee48f02bd05941",
    "Sources/SlotstreamDiagnostics/Diagnostics+LayerLocalVictim.swift": "d512d93741a6675412cc9e6c739b940132ca3f20ebecd709884b00b1ebbc49b7",
    "Sources/SlotstreamDiagnostics/Diagnostics+MTPIndexer.swift": "7784a18a1eddafa25ecaee9eeacfbcddf8bcabac8d53919f80367a4f4e5be476",
    "Sources/SlotstreamDiagnostics/Diagnostics+Machine.swift": "20f6edb816fc3a794143042e59847adbfc1fe06514fc990e8a3d81eb87abe50c",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramCache.swift": "9bee4eb6c6cf09df5673e177d4b7f006681794bf680366b4549e4fa3d38b7368",
    "Sources/SlotstreamDiagnostics/Diagnostics+NgramLookahead.swift": "3b0bc7ea21a57d2ce65e58773879f5f86ba7f0f37c47d8f1d08d51e61c486370",
    "Sources/SlotstreamDiagnostics/Diagnostics+Optimization.swift": "35d99deb614da4ffdfef075eabdc5a1c8b3518bf9accf265796e09f2c7c281ee",
    "Sources/SlotstreamDiagnostics/Diagnostics+Output.swift": "e39951dc83e8410abdc840d0a739e1e1b2fbbdf1e2d06b3cb2d28c39ee9329cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+OutputServing.swift": "50bb807143f1e5134f52a6f3d48b8da297f4186dd91895e016d191ca13ccf66a",
    "Sources/SlotstreamDiagnostics/Diagnostics+PackedLayout.swift": "14c31f94ebdd8bbbbb1479c77d0649b4c0632d978e4d8a60a8048214a1e08e65",
    "Sources/SlotstreamDiagnostics/Diagnostics+PartialRotation.swift": "de75d07feedc163834fe8e716683af8b2d373c51b0588ccc2cac922f775367ef",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefix.swift": "46a5bc33ee3fd389694f22c9e7ff5cdd995539663b3141688414351f50ac3189",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixModel.swift": "3e06c67777ce3572d9bd7cce5d220be5f41af90e31b6f5da349ba6f3ec667798",
    "Sources/SlotstreamDiagnostics/Diagnostics+PersistentPrefixPolicy.swift": "82dcadab2ac079d3662da6dd012d8a031c4bdea9ee8c022ac34d5faf66277f5b",
    "Sources/SlotstreamDiagnostics/Diagnostics+PoolRequests.swift": "e383c494263afa029a9ef107c90d6ba59f44cda5da7ca1035eae68cbda3562d2",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefillQualification.swift": "f40d8e711121f12cbcd95f8880d483ac36995faeab06af714d201fa1671348f1",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixCapacity.swift": "b76e9185930a90d2509f9d7dfc247afee3ff2a083a1bc6bb3da6d090653d290f",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixFork.swift": "e7a7094b3930cef8e380d711f20e8f82e2821c070579549692a6120e9ba3afc4",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixRetention.swift": "5de9452266e8e59da03b078990689554fc7a419a5cd8e5879cc68e2e277ea8cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+PrefixVision.swift": "5e4737dbe5344492fc2f9c6881f8d56e997668f674c91b28b9349c9420465f72",
    "Sources/SlotstreamDiagnostics/Diagnostics+PressureBoundary.swift": "f84979a3da94bc5ac0cfeb5cc84b61af43716c5664cc71853085ffa1b116d325",
    "Sources/SlotstreamDiagnostics/Diagnostics+Pull.swift": "224e4bf5210afbddd992894860343add73d1f52b12b2d9a00abf78fdc492ada0",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadFailureServing.swift": "1532f45714ceb98a5adcfa31abd31f065493164f49d2ee3aac868d5d4080b04c",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadHandles.swift": "9e98b6e0fd6c30f36d1d3ec8d556216f351a2f09ee5d15dbb4f5580858fad4b4",
    "Sources/SlotstreamDiagnostics/Diagnostics+ReadRecovery.swift": "5d51636a62b376e74dfefab207fdd42da61436210973f714819c7cc11488a04d",
    "Sources/SlotstreamDiagnostics/Diagnostics+ResidentOverlap.swift": "c1e7b847cffa51939b0ae20027b289efcae5585a94ae5c1c751a66f110a25522",
    "Sources/SlotstreamDiagnostics/Diagnostics+RopePerformance.swift": "19d040f21391a1ea87831b73a8adf055a78aeafe9d902bd11ce22fd6a492d892",
    "Sources/SlotstreamDiagnostics/Diagnostics+RouterProjection.swift": "3981e415003e6258d41690216a7ab668652a0ce436bf644d99d88dbc2799db9e",
    "Sources/SlotstreamDiagnostics/Diagnostics+RoutingReadback.swift": "f29aad2cde3bbb526f83dcec4565f3c382d071734acc47a0e31d7223312713cb",
    "Sources/SlotstreamDiagnostics/Diagnostics+Runtime.swift": "69cc7879d26e9e51807d825f29203f00490ce5a77bf7db66d03d3d99e0074e30",
    "Sources/SlotstreamDiagnostics/Diagnostics+RuntimeBudget.swift": "b5ce492456b9e27b19765a0bd4f23cbd81ccff034be5af3142737cdae7944d6e",
    "Sources/SlotstreamDiagnostics/Diagnostics+SamplerPerformance.swift": "4e6dd7e85d7ac0f2b2af291343ab4cdc52fa94fe6edb588c1d517008a0c35cb3",
    "Sources/SlotstreamDiagnostics/Diagnostics+SelectedAttention.swift": "8dd385da9b79c3625d1cc9ccc6c8821978f88437fcded918f049328b7a969e7a",
    "Sources/SlotstreamDiagnostics/Diagnostics+Selection.swift": "b737794c5a57cd224f36a93b960fa9834cabb51ef810945bab64fd71e59c91d0",
    "Sources/SlotstreamDiagnostics/Diagnostics+SlotSlices.swift": "32c10a839423b13a4dceff67a5b2a617f90d145376a70b19bd27f2e62452e288",
    "Sources/SlotstreamDiagnostics/Diagnostics+StateRecovery.swift": "a53db99ff0f97a26e87586e35bf05daa26b9281fe7d686a1670c14984da2dd77",
    "Sources/SlotstreamDiagnostics/Diagnostics+TerminalPrefill.swift": "7ef27bec8489f52ccdd3ea51c125d21eb94512924b163e854b7aaf25ef39f57a",
    "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "be63108d11318a9469d26587ade08c79bf34274c61b847d752663d8ce007f9af",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
    "Sources/SlotstreamTestKit/Catalogue.swift": "bdfef7fffc2bbd801fc1880f9d9134783134a0e36e2424c3eb419b2767fe62a7",
    "Sources/SlotstreamTestKit/CodexFixture.swift": "23839d1d776252c1c5cec6a3acaf6c08c1e89bc7def714f7b5f3180fae57aac0",
    "Sources/SlotstreamTestKit/GatewayChecks.swift": "da4b4a89d9b11d26a64cd244aae2887acfbca16a6d3aceefa8f40f90c8e39634",
    "Sources/SlotstreamTestKit/OpenAIChecks.swift": "fe3aaf4ad816c02fc0b28771d6c3c7f9cf7b2a9f102ea4fce660c1dd8541a650",
    "Sources/SlotstreamTestKit/ResponsesChecks.swift": "1dc4ab33a448eaf27ffd06b0dde845d19f79128fd6a8676b807e693378cae6fc",
    "Sources/SlotstreamTestKit/T0Checks.swift": "4033fc0678a95e202eb34ce8630cab49f224b0f175852082a0d2abb8901d7064",
    "Sources/SlotstreamTestKit/ToolCallChecks.swift": "f1b263239f4e82707c77a5887367fb5302e96d369f2f278e0e45a87d3006dad8",
    "Sources/SlotstreamTestKit/WeightStoreChecks.swift": "d26e43367ba2d61d7afd9f5b175e95b714409b1717b86b9fe71f1306e36b6a81",
    "Sources/slotstream-checks/main.swift": "02ebabaf058afa95622ccd29fb65d80b7eac41c9e6232f0167ef288c2126e0d9",
    "Sources/slotstream-cli/CheckRendering.swift": "0905dcbae17a5b3d66e13a760c4054fb29d930331d32942a528510ecfe9769a1",
    "Sources/slotstream-cli/ContextCommands.swift": "3ba24ae3e24dd10214e3288f007952d9e2b06241c081e29313b42ac7aa7a31bb",
    "Sources/slotstream-cli/ExpertLookaheadCommands.swift": "249274657b4f4f4c3e694a2b0db671b3af8b92a2148495647f3be9092f48f6b2",
    "Sources/slotstream-cli/MTPCommands.swift": "d84c026f8d56ea8d30608d7e7795611d769fd57bf58a1b799608bd5e866c3b96",
    "Sources/slotstream-cli/OptimizationCommands.swift": "9a0013222a0accfb268bb860f94e8939b2b99f8fb31bd949be9d5e9ace83e8d5",
    "Sources/slotstream-cli/PackedExpertCommands.swift": "ea7f4485d60a985a0a1f759f077d28dc42f36512dc1dd07a7644a22e31346b12",
    "Sources/slotstream-cli/PrefixCacheCommand.swift": "266b9571726fe280c11d5dededa565375af1749b76c7e70def4fe9530729914f",
    "Sources/slotstream-cli/PrefixExactCommands.swift": "f609a0b89376cf02b277dc00804c35d39883de179c2733c8baa3c3eaf565779b",
    "Sources/slotstream-cli/Pull.swift": "d60a4ea7cebd27aa7995b4ae3ea74718e5b5eaf9d473f5cf85dcef83c9dbefaf",
    "Sources/slotstream-cli/SweepCommands.swift": "37455d724a63b1689208dce9d55cd3d249bcab6d45bdf40d5c5e4f6992aa0d20",
    "Sources/slotstream-cli/VisionCommands.swift": "df80e089ea9cdbc6fc51ec7dc895b0dbf0eec5d4db80eb73b0ca9720a3ce8cc0",
    "Sources/slotstream-cli/main.swift": "2c0fc7969d1509af6b6870449b7b7892cd1b2fb3a8a2daf9306c3f26e8b588fa",
    "Tools/build_identity.py": "d70a97380b1244727674861ae64ab166d034c941878e6e2c18f3ffd77bbf2e86",
    "Tools/fetch_metallib.sh": "c47f5531c4195bfe1f827ba1049b76cb81687401b9e25e2a3cc4c9d7feb64860"
  },
  "source_archive_sha256": "d0d0ed7b9d2a09b1fcdb392872a2b0a625a5e15f9b65e965f22257e0604bcae8",
  "binary_sha256": "5a4866d66d9101d958387057316f08c5b7ebb728ed39779c124bc6e3c270fc5a",
  "metallib_sha256": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597"
}

```

## Full native suite

```text
== frozen build: /Users/carlos/Projects/slotstream-memory-budget-fix/.build/memory-final/slotstream ==
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
PASS  a continued conversation equals a cold one (prefix-exact-check)
== prefill sweep: matches the pool path, deterministic, blind to the pool ==
PASS  sweep within the prefill-rechunk control, identical cold and warm (sweep-check)
== MTP draft head: parity with the Python reference + speculative gates ==
PASS  mtp head bit-parity vs Python reference (mtp-parity)
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
      -> 'Dog nose close-up' in 8.0s, 725 prompt tokens
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
FAIL  and reuses the state instead of re-running the tower
        encoded first=1, follow-up=1, reused=0; requires SLOTSTREAM_BENCH_DETAILS=1
      -> first 6.4s, follow-up 6.7s
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

24 passed, 1 failed
  FAILED: and reuses the state instead of re-running the tower
FAIL  vision serving suite

passed 26, failed 1

```

## Baseline image suite

```text
PASS  ollama /api/chat answers an image request
PASS  and it recognises the dog
      -> 'Dog nose close-up' in 8.1s, 725 prompt tokens
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
FAIL  and reuses the state instead of re-running the tower
        encoded first=1, follow-up=1, reused=0; requires SLOTSTREAM_BENCH_DETAILS=1
      -> first 6.3s, follow-up 6.6s
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

24 passed, 1 failed
  FAILED: and reuses the state instead of re-running the tower

```

## Baseline server

```text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (27.5 GB reclaimable now), 40.2 GB Metal working set
  target: 14.5 GB total for this process
  cache:  ~23 of 512 experts per layer  (1101 global slots = 3.0 GB pool)
  expect: ~13.5 GB peak, ~5 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 3072 tokens per pass (~205 tok/s here; costs ~4.0 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~3.5 min before its first token here, follow-up turns read only what is new
  reuse:  up to 29658 tokens across 4 conversations (~1.2 GB), so a follow-up turn re-prefills only what is new
  note:   prefill and prefix retention reservations match the explicit runtime controls
engine ready in 0.8s: expert cache ~23/512 per layer (1101 global slots = 3.0 GB), eos [248044, 248046]
slotstream listening on http://127.0.0.1:11468
try it:
  curl localhost:11468/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
or point any Ollama or OpenAI client at http://localhost:11468
[11:52:25 AM] prefill: reading 2602 prompt tokens, ~13 s to the first token at this plan (follow-up turns read only what is new)
[11:52:35 AM] prefill: done, 2602 tokens in 10 s (261 tok/s)

```

## check-1.txt

```text
ngram row ids == python reference
diff /tmp/ssv_ngram.txt bench/parity31/ngram_ids.txt

```

## check-10.txt

```text
verify pass rows equal plain decode bit for bit (mtp-rowcheck)
run_binary mtp-rowcheck --memory-gb 10
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (30.3 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  plan:   ~9.6 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 1.8 GB expert cache allocated; 7.8 GB allowed for runtime, context and workspace, plus 1.0 GB safety margin. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 7595 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
engine ready in 0.9s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), mtp draft head on, eos [248044, 248046]
prompt: 973-token prompt, below the indexer budget, rows across 1024 keys (2048); positions from 1019 every 1 tokens; context window 32768
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: exact verify attention engaged (180 layer passes)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: row-invariant projections engaged (11040 matmuls)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0148, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0152, 0 flips)
PASS  973-token prompt, below the indexer budget, rows across 1024 keys: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0131, 0 flips)
prompt: 2826-token prompt, above the indexer budget (2048); positions from 2826 every 4 tokens; context window 32768
PASS  2826-token prompt, above the indexer budget: exact verify attention engaged (180 layer passes)
PASS  2826-token prompt, above the indexer budget: row-invariant projections engaged (11040 matmuls)
PASS  2826-token prompt, above the indexer budget: k=2, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0268, 0 flips)
PASS  2826-token prompt, above the indexer budget: k=3, every row equals the one-row pass at its position over 4 positions (max deviation 0 of the logit spread, 0 top-1 flips; stock 0.0194, 0 flips)
PASS  2826-token prompt, above the indexer budget: the state after a 3-row pass equals the state after 3 one-row passes, through the next token's logits (max deviation 0, 0 flips; stock 0.0283, 0 flips)
MTP ROWCHECK PASS

```

## check-11.txt

```text
--memory-gb 10 process footprint and RSS stay under target
python3 Tools/memory_gate.py /tmp/ssv_mem.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 6216027448, "sampled_footprint_bytes": 6216027448, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 3224322048, "physical_footprint_end_bytes": 6216027448, "lifetime_footprint_peak_bytes": 6216027448, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}

```

## check-12.txt

```text
--memory-gb 10 output is stable
diff /tmp/ssv_mem.txt /tmp/ssv_big.txt

```

## check-13.txt

```text
--memory-gb 10 process footprint and RSS under target on the long prompt
python3 Tools/memory_gate.py /tmp/ssv_longmem.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 8093994392, "sampled_footprint_bytes": 8052395416, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 3144908800, "physical_footprint_end_bytes": 7081840288, "lifetime_footprint_peak_bytes": 8093994392, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}

```

## check-14.txt

```text
long-context answer still correct (sparse indexer active)
python3 Tools/long_context_gate.py /tmp/ssv_longmem.json /tmp/ssv_longmem.txt --expected SEVENTEEN --minimum-prompt-tokens 7000 --maximum-output-tokens 16
{"passed": true, "prompt_tokens": 7972, "output_tokens": 4, "completed": true}

```

## check-15.txt

```text
context-check: 2k rung reads inside the plan and reports it
[ "$CONTEXT_STATUS" -eq 0 ] && python3 -c 'import json; d=json.loads(open("/tmp/ssv_ctx.json").read().strip().splitlines()[-1]); assert d["fits"] and d["aborted"] is None and d["prefill_tokens"]==2048, d'

```

## check-16.txt

```text
context-check: process memory remains under target
python3 Tools/memory_gate.py /tmp/ssv_ctx.json --limit-gb 10
{"passed": true, "maximum_observed_bytes": 8537673040, "sampled_footprint_bytes": 8507755856, "image_preparation_peak_bytes": 0, "lifetime_rss_bytes": 2952445952, "physical_footprint_end_bytes": 7516032504, "lifetime_footprint_peak_bytes": 8537673040, "sampling_interval_ms": 20, "global_swap_deltas": {"generator": {"swapins": 0, "swapouts": 0}}}

```

## check-17.txt

```text
run through a symlinked model dir
run_binary run --model "$SYM" --memory-gb 8.1 --max-tokens 1 --greedy --prompt hi
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (27.5 GB reclaimable now), 40.2 GB Metal working set
  target: 8.1 GB total process budget, not a RAM usage goal
  cache:  ~13 of 512 experts per layer  (640 global slots = 1.8 GB pool)
  plan:   ~7.9 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 1.8 GB expert cache allocated; 6.2 GB allowed for runtime, context and workspace, plus 1.0 GB safety margin. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 6510 tokens across 4 conversations (~0.5 GB), so a follow-up turn re-prefills only what is new
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to the estimated request time without an unmeasured cache tradeoff; --max-context N chooses another window up to 262144
engine ready in 0.7s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
prompt tokens: 13 (~0 s to the first token at this plan)
Hello
-- prefill 13 tok in 0.96s (13.6 tok/s)
-- prefill split: io 0.48s + scatter 0.00s | 2189 records (6.1 GB, 12.6 GB/s)
-- decode 1 tok in 0.00s (1772.92 tok/s)
-- decode split: io 0.00s + scatter 0.00s | 0 records
-- expert cache ~13/512 experts per layer, hit rate 0.000 | ngram rows 0h/0m | lifetime footprint peak 5.042 GB, current footprint 5.042 GB | total 1.0s


```

## check-18.txt

```text
vision tower dumps its pixels and embeddings
run_binary vision-parity --out "$VP"
loading the vision tower (0.898 GB resident)
wrote 2808 patches -> 702 tokens (832x864, grid 52x54) to .build/memory-native-verification/vision-parity

```

## check-2.txt

```text
chat template == transformers
[ "$(run_binary template-check 2>/dev/null)" = '248045,8678,198,2523,513,10631,13,248046,198,248045,846,198,12675,1017,248046,198,248045,74455,198,248068,271,248069,271' ]

```

## check-3.txt

```text
layer parity (0-1 bit-exact gate)
run_binary parity --tokens '9707,11,1246,525,498,30' --layers 2 --compare bench/parity31
layer  0: max abs 0.00000, rel 0.00000  OK
layer  1: max abs 0.00000, rel 0.00000  OK
PARITY PASS

```

## check-4.txt

```text
8.1 GB cache output == 10 GB cache output
diff /tmp/ssv_big.txt /tmp/ssv_small.txt

```

## check-5.txt

```text
grow/shrink/regrow byte-identical (elastic-check)
run_binary elastic-check --big-slots 960
engine ready in 0.6s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  baseline     (640 slots): 5.1s
  after grow   (960 slots): 3.7s
  after shrink (640 slots): 4.0s
  after regrow (800 slots): 3.7s
ELASTIC CHECK PASS: 4 generations byte-identical across 13→20→13→16 experts/layer

```

## check-6.txt

```text
prefix reuse within the prefill-rechunk control (prefix-check)
run_binary prefix-check
engine ready in 0.6s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  equivalence at 28 tokens: reuse 1.992% vs prefill-rechunk control 3.416% of logit spread, top-1 same
  equivalence at 100 tokens: reuse 4.374% vs prefill-rechunk control 4.478% of logit spread, top-1 same
  equivalence at 196 tokens: reuse 3.628% vs prefill-rechunk control 5.896% of logit spread, top-1 differs
  shed: retained 1411 tokens, dropped, next turn rebuilt 1436
  turn 1: 1409 prompt tok, 0 reused, prefill 15.97s -> Mars
  turn 2: 1436 prompt tok, 1280 reused, prefill 3.95s -> No
  turn 3: 1457 prompt tok, 1280 reused, prefill 4.15s -> Mars has a smaller diameter and mass than Ea
PREFIX CHECK PASS: reuse moves logits 4.37% vs 5.90% for the prefill-rechunk control, flat with depth, top-1 2/3; 2 of 2 turns reused a prefix; cached and edited-history runs deterministic; follow-up prefill 28.02s -> 8.10s (0 of 3 replies differ from a cold rebuild)

```

## check-7.txt

```text
a continued conversation equals a cold one (prefix-exact-check)
run_binary prefix-exact-check
engine ready in 1.1s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  pass size 256 tokens, aligned resume on
  long turn 1: 1521 prompt tok, reused 0, logit delta 0.000000%
  long turn 2: 1548 prompt tok, reused 1280, logit delta 0.000000%
  long turn 3: 1576 prompt tok, reused 1536, logit delta 0.000000%
  long turn 1 prefill: 17.88s cold, 16.49s continued (1521 of 1521 tokens read)
  long turn 2 prefill: 14.07s cold, 4.40s continued (268 of 1548 tokens read)
  long turn 3 prefill: 14.29s cold, 1.82s continued (40 of 1576 tokens read)
  repeat turn 1: 1521 prompt tok, reused 1521, logit delta 0.000000%
  short turn 1: 22 prompt tok, reused 0, logit delta 0.000000%
  short turn 2: 49 prompt tok, reused 0, logit delta 0.000000%
  short turn 3: 70 prompt tok, reused 0, logit delta 0.000000%
  shared prefix turn 1: 1520 prompt tok, reused 1280, logit delta 0.000000%
PREFIX EXACT CHECK PASS: every continued turn produced the same tokens and the same prompt logits as a cold read, 2 of 2 follow-up turns resumed a boundary state, an identical prompt reused its complete state, an edited history rebuilt, and a second conversation resumed the shared prefix

```

## check-8.txt

```text
sweep within the prefill-rechunk control, identical cold and warm (sweep-check)
run_binary sweep-check
engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
  sweep on a cold pool, run twice: identical
  sweep vs pool path: 3.320% of logit spread (prefill-rechunk control 5.089%, bound 15.268%), top-1 same
  sweep whole vs sweep in 256-token passes: 3.145% of spread
  sweep on the warm pool (638 experts copied out of it): identical to the cold sweep
  after a generate that admitted the prompt's hot experts (prefill 549 tokens): pool path identical, sweep identical
SWEEP CHECK PASS: deterministic; 3.320% of spread vs the pool path inside the 15.268% prefill-rechunk bound; identical on a cold and a warm pool; admission leaves the pool consistent

```

## check-9.txt

```text
mtp head bit-parity vs Python reference (mtp-parity)
run_binary mtp-parity
prefill sample: max abs 0.00000  rel 0.00000  OK
prefill multi: max abs 0.00000  rel 0.00000  OK
decode sample: max abs 0.00000  rel 0.00000  OK
decode multi: max abs 0.00000  rel 0.00000  OK
MTP PARITY PASS

```

## ssv_ctx.json

```json
{"aborted":null,"compute_key_extents":[256,512,768,1024,1280,1536,1792,2048],"compute_passes":[256,256,256,256,256,256,256,256],"compute_query_rows":[256,256,256,256,256,256,256,256],"configured_context":2064,"fits":true,"memory_ledger":{"active_capacity_bytes":84934656,"additional_active_bytes":0,"expected_peak_bytes":8997561600,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":0,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":3364761600,"prefill_bytes":332800000,"retained_capacity_bytes":0,"retained_recurrent_bytes":0,"version":1,"vision_resident_bytes":0},"model_revision":"aa7c790e804bbf9d491ddb109c3d61bc4a555f7c","optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":false,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[20,12364,5020,220,23,13,271,248068,271,248069,271,27775,383,279,795,3766],"pass_timings":[{"from":0,"seconds":13.704363708000001,"tokens":1792},{"from":1792,"seconds":4.6827564999999982,"tokens":256}],"passes":[1792,256],"peak_rss_gb":2.9524459520000002,"plan_expected_peak_gb":8.9975615999999992,"prefill_chunk":256,"prefill_seconds":18.387461999999999,"prefill_tok_s":111.38024377698238,"prefill_tokens":2048,"process_peak_bound_gb":8.5376730399999996,"prompt_ids":[1905,1716,13,13190,220,15,25,279,11661,383,1500,220,15,4800,220,18,22,7896,506,220,15,25,15,15,11,321,51715,220,15,12364,5020,220,15,13,13190,220,16,25,279,11661,383,1500,220,16,4800,220,21,23,7896,506,220,16,25,15,22,11,321,51715,220,16,18,12364,5020,220,16,13,13190,220,17,25,279,11661,383,1500,220,17,4800,220,24,24,7896,506,220,17,25,16,19,11,321,51715,220,17,21,12364,5020,220,17,13,13190,220,18,25,279,11661,383,1500,220,18,4800,220,16,18,15,7896,506,220,18,25,17,16,11,321,51715,220,18,24,12364,5020,220,18,13,13190,220,19,25,279,11661,383,1500,220,19,4800,220,16,21,16,7896,506,220,19,25,17,23,11,321,51715,220,20,17,12364,5020,220,19,13,13190,220,20,25,279,11661,383,1500,220,20,4800,220,16,24,17,7896,506,220,20,25,18,20,11,321,51715,220,21,20,12364,5020,220,20,13,13190,220,21,25,279,11661,383,1500,220,21,4800,220,17,17,18,7896,506,220,21,25,19,17,11,321,51715,220,22,23,12364,5020,220,21,13,13190,220,22,25,279,11661,383,1500,220,22,4800,220,17,20,19,7896,506,220,22,25,19,24,11,321,51715,220,24,16,12364,5020,220,22,13,13190,220,23,25,279,11661,383,1500,220,23,4800,220,17,23,20,7896,506,220,23,25,20,21,11,321,51715,220,16,15,19,12364,5020,220,23,13,13190,220,24,25,279,11661,383,1500,220,24,4800,220,18,16,21,7896,506,220,24,25,15,18,11,321,51715,220,16,16,22,12364,5020,220,24,13,13190,220,16,15,25,279,11661,383,1500,220,16,15,4800,220,18,19,22,7896,506,220,16,15,25,16,15,11,321,51715,220,16,18,15,12364,5020,220,16,15,13,13190,220,16,16,25,279,11661,383,1500,220,16,16,4800,220,18,22,23,7896,506,220,16,16,25,16,22,11,321,51715,220,16,19,18,12364,5020,220,16,16,13,13190,220,16,17,25,279,11661,383,1500,220,16,17,4800,220,19,15,24,7896,506,220,16,17,25,17,19,11,321,51715,220,16,20,21,12364,5020,220,16,17,13,13190,220,16,18,25,279,11661,383,1500,220,16,18,4800,220,19,19,15,7896,506,220,16,18,25,18,16,11,321,51715,220,16,21,24,12364,5020,220,16,18,13,13190,220,16,19,25,279,11661,383,1500,220,16,19,4800,220,19,22,16,7896,506,220,16,19,25,18,23,11,321,51715,220,16,23,17,12364,5020,220,16,19,13,13190,220,16,20,25,279,11661,383,1500,220,16,20,4800,220,20,15,17,7896,506,220,16,20,25,19,20,11,321,51715,220,16,24,20,12364,5020,220,16,20,13,13190,220,16,21,25,279,11661,383,1500,220,16,21,4800,220,20,18,18,7896,506,220,16,21,25,20,17,11,321,51715,220,17,15,23,12364,5020,220,16,21,13,13190,220,16,22,25,279,11661,383,1500,220,16,22,4800,220,21,19,7896,506,220,16,22,25,20,24,11,321,51715,220,17,17,16,12364,5020,220,16,22,13,13190,220,16,23,25,279,11661,383,1500,220,16,23,4800,220,24,20,7896,506,220,16,23,25,15,21,11,321,51715,220,17,18,19,12364,5020,220,16,23,13,13190,220,16,24,25,279,11661,383,1500,220,16,24,4800,220,16,17,21,7896,506,220,16,24,25,16,18,11,321,51715,220,17,19,22,12364,5020,220,16,24,13,13190,220,17,15,25,279,11661,383,1500,220,17,15,4800,220,16,20,22,7896,506,220,17,15,25,17,15,11,321,51715,220,17,21,15,12364,5020,220,17,15,13,13190,220,17,16,25,279,11661,383,1500,220,17,16,4800,220,16,23,23,7896,506,220,17,16,25,17,22,11,321,51715,220,17,22,18,12364,5020,220,17,16,13,13190,220,17,17,25,279,11661,383,1500,220,17,17,4800,220,17,16,24,7896,506,220,17,17,25,18,19,11,321,51715,220,17,23,21,12364,5020,220,17,17,13,13190,220,17,18,25,279,11661,383,1500,220,17,18,4800,220,17,20,15,7896,506,220,17,18,25,19,16,11,321,51715,220,17,24,24,12364,5020,220,17,18,13,13190,220,17,19,25,279,11661,383,1500,220,17,19,4800,220,17,23,16,7896,506,220,15,25,19,23,11,321,51715,220,18,16,17,12364,5020,220,17,19,13,13190,220,17,20,25,279,11661,383,1500,220,17,20,4800,220,18,16,17,7896,506,220,16,25,20,20,11,321,51715,220,18,17,20,12364,5020,220,17,20,13,13190,220,17,21,25,279,11661,383,1500,220,17,21,4800,220,18,19,18,7896,506,220,17,25,15,17,11,321,51715,220,18,18,23,12364,5020,220,17,21,13,13190,220,17,22,25,279,11661,383,1500,220,17,22,4800,220,18,22,19,7896,506,220,18,25,15,24,11,321,51715,220,18,20,16,12364,5020,220,17,22,13,13190,220,17,23,25,279,11661,383,1500,220,17,23,4800,220,19,15,20,7896,506,220,19,25,16,21,11,321,51715,220,18,21,19,12364,5020,220,17,23,13,13190,220,17,24,25,279,11661,383,1500,220,17,24,4800,220,19,18,21,7896,506,220,20,25,17,18,11,321,51715,220,18,22,22,12364,5020,220,17,24,13,13190,220,18,15,25,279,11661,383,1500,220,18,15,4800,220,19,21,22,7896,506,220,21,25,18,15,11,321,51715,220,18,24,15,12364,5020,220,18,15,13,13190,220,18,16,25,279,11661,383,1500,220,18,16,4800,220,19,24,23,7896,506,220,22,25,18,22,11,321,51715,220,19,15,18,12364,5020,220,18,16,13,13190,220,18,17,25,279,11661,383,1500,220,18,17,4800,220,20,17,24,7896,506,220,23,25,19,19,11,321,51715,220,19,16,21,12364,5020,220,18,17,13,13190,220,18,18,25,279,11661,383,1500,220,18,18,4800,220,21,15,7896,506,220,24,25,20,16,11,321,51715,220,19,17,24,12364,5020,220,18,18,13,13190,220,18,19,25,279,11661,383,1500,220,18,19,4800,220,24,16,7896,506,220,16,15,25,20,23,11,321,51715,220,19,19,17,12364,5020,220,18,19,13,13190,220,18,20,25,279,11661,383,1500,220,18,20,4800,220,16,17,17,7896,506,220,16,16,25,15,20,11,321,51715,220,19,20,20,12364,5020,220,18,20,13,13190,220,18,21,25,279,11661,383,1500,220,18,21,4800,220,16,20,18,7896,506,220,16,17,25,16,17,11,321,51715,220,19,21,23,12364,5020,220,18,21,13,13190,220,18,22,25,279,11661,383,1500,220,18,22,4800,220,16,23,19,7896,506,220,16,18,25,16,24,11,321,51715,220,19,23,16,12364,5020,220,18,22,13,13190,220,18,23,25,279,11661,383,1500,220,18,23,4800,220,17,16,20,7896,506,220,16,19,25,17,21,11,321,51715,220,19,24,19,12364,5020,220,18,23,13,13190,220,18,24,25,279,11661,383,1500,220,18,24,4800,220,17,19,21,7896,506,220,16,20,25,18,18,11,321,51715,220,20,15,22,12364,5020,220,18,24,13,13190,220,19,15,25,279,11661,383,1500,220,19,15,4800,220,17,22,22,7896,506,220,16,21,25,19,15,11,321,51715,220,20,17,15,12364,5020,220,19,15,13,13190,220,19,16,25,279,11661,383,1500,220,19,16,4800,220,18,15,23,7896,506,220,16,22,25,19,22,11,321,51715,220,20,18,18,12364,5020,220,19,16,13,13190,220,19,17,25,279,11661,383,1500,220,19,17,4800,220,18,18,24,7896,506,220,16,23,25,20,19,11,321,51715,220,20,19,21,12364,5020,220,19,17,13,13190,220,19,18,25,279,11661,383,1500,220,19,18,4800,220,18,22,15,7896,506,220,16,24,25,15,16,11,321,51715,220,20,20,24,12364,5020,220,19,18,13,13190,220,19,19,25,279,11661,383,1500,220,19,19,4800,220,19,15,16,7896,506,220,17,15,25,15,23,11,321,51715,220,20,22,17,12364,5020,220,19,19,13,13190,220,19,20,25,279,11661,383,1500,220,19,20,4800,220,19,18,17,7896,506,220,17,16,25,16,20,11,321,51715,220,20,23,20,12364,5020,220,19,20,13,13190,220,19,21,25,279,11661,383,1500,220,19,21,4800,220,19,21,18,7896,506,220,17,17,25,17,17,11,321,51715,220,20,24,23,12364,5020,220,19,21,13,13190,220,19,22,25,279,11661,383,1500,220,19,22,4800,220,19,24,19,7896,506,220,17,18,25,17,24,11,321,51715,220,21,16,16,12364,5020,220,19,22,13,13190,220,19,23,25,279,11661,383,1500,220,19,23,4800,220,20,17,20,7896,506,220,15,25,18,21,11,321,51715,220,21,17,19,12364,5020,220,19,23,13,13190,220,19,24,25,279,11661,383,1500,220,19,24,4800,220,20,21,7896,506,220,16,25,19,18,11,321,51715,220,21,18,22,12364,5020,220,19,24,13,13190,220,20,15,25,279,11661,383,1500,220,20,15,4800,220,23,22,7896,506,220,17,25,20,15,11,321,51715,220,21,20,15,12364,5020,220,20,15,13,13190,220,20,16,25,279,11661,383,1500,220,20,16,4800,220,16,16,23,7896,506,220,18,25,20,22,11,321,51715,220,21,21,18,12364,5020,220,20,16,13,13190,220,20,17,25,279,11661,383,1500,220,20,17,4800,220,16,19,24,7896,506,220,19,25,15,19,11,321,51715,220,21,22,21,12364,5020,220,20,17,13,13190,220,20,18,25,279,11661,383,1500,220,20,18,4800,220,16,23,15,7896,506,220,20,25,16,16,11,321,51715,220,21,23,24,12364,5020,220,20,18,13,13190,220,20,19,25,279,11661,383,1500,220,20,19,4800,220,17,16,16,7896,506,220,21,25,16,23,11,321,51715,220,22,15,17,12364,5020,220,20,19,13,13190,220,20,20,25,279,11661,383,1500,220,20,20,4800,220,17,19,17,7896,506,220,22,25,17,20,11,321,51715,220,22,16],"reply_tokens":16,"retained_after":{"allocated_sequence_bytes":0,"charged_token_capacity":0,"checkpoint_fork_failures":0,"checkpoint_hits":0,"checkpoint_stores":0,"conversations":0,"enabled":false,"evictions":0,"held_gb":0,"held_images":0,"held_tokens":0,"hits":0,"max_conversations":4,"max_tokens":0,"misses":0,"persistent_hits":0,"reusable_checkpoints":0},"retained_before":{"allocated_sequence_bytes":0,"charged_token_capacity":0,"checkpoint_fork_failures":0,"checkpoint_hits":0,"checkpoint_stores":0,"conversations":0,"enabled":false,"evictions":0,"held_gb":0,"held_images":0,"held_tokens":0,"hits":0,"max_conversations":4,"max_tokens":0,"misses":0,"persistent_hits":0,"reusable_checkpoints":0},"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":84934656,"cachedRouterBytes":0,"completePromptHits":0,"completePromptStores":0,"contextArithmetic":"standard","decodeForwardPasses":15,"decodeIOSeconds":0.9679239729999991,"decodeLocalVictims":0,"decodeModelTokens":15,"decodeReadBytes":10625126400,"decodeRecords":3843,"decodeScatterSeconds":0.017166288000000016,"decodeSeconds":2.7165099170000002,"decodeSlotCPUBatches":0,"decodeSlotScatterBatches":703,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":16,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":47520,"embeddingCachedRows":33,"embeddingRowHits":36,"embeddingRowMisses":33,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.46625,"finishReason":"length","firstTokenSeconds":18.396651334000001,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":912,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":24059166720,"swapins":1411056,"swapouts":1923638},"generatorVMBefore":{"reclaimableBytes":23317954560,"swapins":1411056,"swapouts":1923638},"imageEncodeSeconds":4.1999999999999999e-08,"interTokenSeconds":[0.37595233300000003,0.17821245799999999,0.16490650000000001,0.21815699999999999,0.19766729099999999,0.155081416,0.18132316700000001,0.22548420799999999,0.127697,0.13353016600000001,0.11492029199999999,0.18634862499999999,0.15806483399999999,0.14313816700000001,0.15485637499999999],"lifetimePhysicalFootprintPeakBytes":8537673040,"lifetimeRSSPeakBytes":2952445952,"memoryPressureCancelled":false,"mlxActiveEndBytes":6143986536,"mlxCacheEndBytes":716301497,"mlxPeakMemoryGB":8.1189603320000003,"ngramCachedRows":7424,"ngramCachePayloadBytes":2375680,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.14160433099999994,"ngramRowHits":80,"ngramRowMisses":160,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":8.5376730399999996,"physicalFootprintEndBytes":7516032504,"prefillComputeKeyExtents":[256,512,768,1024,1280,1536,1792,2048],"prefillComputePasses":[256,256,256,256,256,256,256,256],"prefillComputeQueryRows":[256,256,256,256,256,256,256,256],"prefillGPUWaitSeconds":2.8626057410000021,"prefillIOSeconds":6.6047238849999914,"prefillLocalVictims":0,"prefillMLXActiveBytes":6234573000,"prefillMLXCacheBytes":539162406,"prefillPasses":[1792,256],"prefillPhysicalFootprintBytes":7412534776,"prefillReadBytes":72888422400,"prefillRecords":26363,"prefillRowSortSeconds":0.0071132030000000002,"prefillScatterSeconds":1.7532967939999986,"prefillSeconds":18.387461999999999,"prefillSlotCPUBatches":0,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":2048,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":2,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":1.1584e-05,"promptTokens":2048,"queueSeconds":1.1416e-05,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":21.112382416999999,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":104,"ropeTableHits":532,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":8507755856,"samples":1056},"sampleSeconds":0.0048627929999999998,"sharedExpertPrelaunches":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":6.1670000000000013e-06,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"swap_clean":true,"text":"5 filed note 8.\n\n<think>\n\n<\/think>\n\nBased on the data provided","tokens":2048,"verdict":"OK","warmup":[]}

```

## ssv_longmem.json

```json
{"effective_expected_peak_gb":8.9994969600000001,"effective_mtp":false,"effective_pool_slots":961,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.036775250000000002,"experimental_memory_family":false,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0,"launch_seconds":96.129544124999995,"load_seconds":8.9660732920000008,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":false,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[896,6571,36,923],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":false,"device_available_gb":27.800000000000001,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":4.0041666666666664,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":20,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":0,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8999496960,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":0,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2656972800,"prefill_bytes":332800000,"retained_capacity_bytes":369985536,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"non_cache_allowance_bytes":6342524160,"pool_gb":2.7000000000000002,"pool_slots":961,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":13382,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":true,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0.90000000000000002,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,760,17593,7189,421,279,33439,10286,369,4890,6571,36,923,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,27213,14159,998,30411,2112,2272,279,48736,45366,42199,13,561,10663,19403,35863,24296,4800,45191,2663,6600,279,1834,13,68650,13017,557,10345,383,279,9897,44350,17188,1785,13,4558,14162,25,1092,369,279,33439,10286,30,21134,440,799,3299,13,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"16","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":226492416,"cachedRouterBytes":0,"completePromptHits":0,"completePromptStores":0,"contextArithmetic":"standard","decodeForwardPasses":4,"decodeIOSeconds":0.29792495899999993,"decodeLocalVictims":0,"decodeModelTokens":4,"decodeReadBytes":3359232000,"decodeRecords":1215,"decodeScatterSeconds":0.0037166649999999996,"decodeSeconds":0.688932875,"decodeSlotCPUBatches":0,"decodeSlotScatterBatches":192,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":4,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":84960,"embeddingCachedRows":59,"embeddingRowHits":830,"embeddingRowMisses":59,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.3671875,"finishReason":"stop","firstTextSeconds":86.437803375000001,"firstTokenSeconds":86.437656167,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":1536,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":23612637184,"swapins":1411056,"swapouts":1923638},"generatorVMBefore":{"reclaimableBytes":22525034496,"swapins":1411056,"swapouts":1923638},"imageEncodeSeconds":1.2499999999999999e-07,"interTokenSeconds":[0.240146209,0.15981724999999999,0.14121979100000001],"lifetimePhysicalFootprintPeakBytes":8093994392,"lifetimeRSSPeakBytes":3144908800,"memoryPressureCancelled":false,"mlxActiveEndBytes":5578525400,"mlxCacheEndBytes":538928531,"mlxPeakMemoryGB":7.4688698359999997,"ngramCachedRows":1192,"ngramCachePayloadBytes":381440,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.023580372000000006,"ngramRowHits":24,"ngramRowMisses":40,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":8.0939943920000008,"physicalFootprintEndBytes":7081840288,"prefillComputeKeyExtents":[256,512,768,1024,1280,1536,1792,2048,2304,2560,2816,3072,3328,3584,3840,4096,4352,4608,4864,5120,5376,5632,5888,6144,6400,6656,6912,7168,7424,7680,7936,7972],"prefillComputePasses":[256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,36],"prefillComputeQueryRows":[256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,36],"prefillGPUWaitSeconds":7.8854060699999931,"prefillIOSeconds":52.752615259999978,"prefillLocalVictims":0,"prefillMLXActiveBytes":5577927832,"prefillMLXCacheBytes":536401594,"prefillPasses":[256,1024,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,36],"prefillPhysicalFootprintBytes":7078252192,"prefillReadBytes":765105868800,"prefillRecords":276731,"prefillRowSortSeconds":0.04785966699999996,"prefillScatterSeconds":0.92102442499999926,"prefillSeconds":86.433845290999997,"prefillSlotCPUBatches":0,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":7972,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":2,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.036822500000000001,"promptTokens":7972,"queueSeconds":4.5000000000000001e-06,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":87.162970375,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":105,"ropeTableHits":999,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":8052395416,"samples":4358},"sampleSeconds":0.0015894170000000001,"sharedExpertPrelaunches":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.00047487500000000004,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"SEVENTEEN"}
```

## ssv_mem.json

```json
{"effective_expected_peak_gb":8.9994969600000001,"effective_mtp":false,"effective_pool_slots":961,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.012971333999999999,"experimental_memory_family":false,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0,"launch_seconds":13.623917208,"load_seconds":8.9518987079999999,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":false,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[760,12515,7701,6105,15048,4016,310,264,24057,2512,2972,28232,60845,69377,159034,271,13962,14392,13909,12,8046,68868,25,271],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":false,"device_available_gb":28.5,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":4.0041666666666664,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":20,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":0,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8999496960,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":0,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2656972800,"prefill_bytes":332800000,"retained_capacity_bytes":369985536,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"non_cache_allowance_bytes":6342524160,"pool_gb":2.7000000000000002,"pool_slots":961,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":13382,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":true,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0.90000000000000002,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,9930,369,279,12515,6105,30,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"24","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":28311552,"cachedRouterBytes":0,"completePromptHits":0,"completePromptStores":1,"contextArithmetic":"standard","decodeForwardPasses":23,"decodeIOSeconds":1.6221482830000014,"decodeLocalVictims":0,"decodeModelTokens":23,"decodeReadBytes":17285529600,"decodeRecords":6252,"decodeScatterSeconds":0.019879410000000004,"decodeSeconds":3.4207438749999999,"decodeSlotCPUBatches":0,"decodeSlotScatterBatches":1092,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":24,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":48960,"embeddingCachedRows":34,"embeddingRowHits":3,"embeddingRowMisses":34,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.43369565217391304,"finishReason":"length","firstTextSeconds":1.2382130419999999,"firstTokenSeconds":1.237773,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":576,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"fair"},"generatorVMAfter":{"reclaimableBytes":22467428352,"swapins":1411044,"swapouts":1923638},"generatorVMBefore":{"reclaimableBytes":23359537152,"swapins":1411044,"swapouts":1923638},"imageEncodeSeconds":0,"interTokenSeconds":[0.209666834,0.180468666,0.13999862499999999,0.12636083300000001,0.15261783300000001,0.125761708,0.120398083,0.11791787500000001,0.13178087499999999,0.13367079100000001,0.161791667,0.17799029199999999,0.114859208,0.12876595800000001,0.18673683299999999,0.15288554200000001,0.124281458,0.122576083,0.117417208,0.204236792,0.13370224999999999,0.17818120900000001,0.178085084],"lifetimePhysicalFootprintPeakBytes":6216027448,"lifetimeRSSPeakBytes":3224322048,"memoryPressureCancelled":false,"mlxActiveEndBytes":5522447512,"mlxCacheEndBytes":35037876,"mlxPeakMemoryGB":5.6205251140000003,"ngramCachedRows":656,"ngramCachePayloadBytes":209920,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.016008539000000002,"ngramRowHits":0,"ngramRowMisses":368,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":6.2160274480000002,"physicalFootprintEndBytes":6216027448,"prefillComputeKeyExtents":[18],"prefillComputePasses":[18],"prefillComputeQueryRows":[18],"prefillGPUWaitSeconds":0,"prefillIOSeconds":0.71029149800000013,"prefillLocalVictims":0,"prefillMLXActiveBytes":5378829464,"prefillMLXCacheBytes":34874300,"prefillPasses":[18],"prefillPhysicalFootprintBytes":6069062896,"prefillReadBytes":9455616000,"prefillRecords":3420,"prefillRowSortSeconds":0,"prefillScatterSeconds":0.004329949999999998,"prefillSeconds":1.229457875,"prefillSlotCPUBatches":0,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":18,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":0,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.013197583000000001,"promptTokens":18,"queueSeconds":6.5420000000000002e-06,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":4.6714558750000004,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":24,"ropeTableHits":264,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":6216027448,"samples":234},"sampleSeconds":0.0053334200000000002,"sharedExpertPrelaunches":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.0012443349999999998,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"The sky appears blue primarily due to a phenomenon called **Rayleigh scattering**.\n\n### Step-by-Step Explanation:\n\n"}
```

## Live governor drill

```text
engine ready in 0.7s: expert cache ~36/512 per layer (1726 global slots = 4.8 GB), eos [248044, 248046]
  (machine has 26.0 GB reclaimable; drill capped at a 4.8 GB pool)
  start:  1726 slots (~36/layer) -> Nile, Amazon, Yangtze
elastic: availability dropped — cache ~36 → ~17 experts/layer (4.8 → 2.2 GB pool, cold — refills from SSD)
  squeeze: 796 slots (~17/layer) -> Nile, Amazon, Yangtze
  recovery stimulus: 8.5 GB available -> 1726 desired slots (2.6 GB growth)
  cooldown: held at 796 slots, as designed
  waiting out the 60 s grow cooldown...
elastic: memory freed — cache ~17 → ~36 experts/layer (2.2 → 4.8 GB pool, contents kept)
  recover: 1726 slots (~36/layer) -> Nile, Amazon, Yangtze
ELASTIC DRILL MEMORY {"ceiling_gb":13,"complete":true,"lifetime_physical_footprint_peak_bytes":10438053272,"lifetime_rss_peak_bytes":3193815040,"output_ids":[[45,448,11,7919,11,23699,83,2891],[45,448,11,7919,11,23699,83,2891],[45,448,11,7919,11,23699,83,2891]],"physical_footprint_end_bytes":10020785656,"sampled_peak_bytes":10369617304,"samples":3616,"swap_clean":false,"swapins_after":1410916,"swapins_before":1410896,"swapouts_after":1923638,"swapouts_before":1923638,"target_gb":12.554587904}
ELASTIC DRILL PASS: governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical

```

## Speculative decoding and image memory

```text
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (30.4 GB reclaimable now), 40.2 GB Metal working set
  target: 12.0 GB total process budget, not a RAM usage goal
  cache:  ~23 of 512 experts per layer  (1091 global slots = 3.0 GB pool)
  plan:   ~11.0 GB full-workload envelope, ~5 tok/s warm decode (est. from M5 Pro anchors)
  memory: 3.0 GB expert cache allocated; 8.0 GB allowed for runtime, context and workspace, plus 1.0 GB safety margin. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 14829 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
engine ready in 1.0s: expert cache ~23/512 per layer (1091 global slots = 3.0 GB), mtp draft head on, eos [248044, 248046]
PASS  determinism p1 (48 tokens)
PASS  speculation ran p1
  info  p1: plain vs spec shared prefix 23/48
PASS  determinism p2 (48 tokens)
PASS  speculation ran p2
  info  p2: plain vs spec shared prefix 48/48 (identical)
PASS  determinism p3 (48 tokens)
PASS  speculation ran p3
  info  p3: plain vs spec shared prefix 6/48
  info  vision+mtp prompt: 721 tokens, 1 image(s), placeholder id 248056
PASS  vision speculation deterministic (48 tokens)
PASS  vision speculation ran
  info  vision plain vs spec shared prefix 15/48
  info  overall accept rate 76.7%
PASS  accept rate is not degenerate (>5%)
  info  recording pass vs batched: 0.0000% of spread (top-1 same); rollback state vs plain: ssm 6.50e-02, conv 4.31e-02, ple 0.00e+00 relative (re-chunk control: ssm 1.05e-01, conv 7.06e-02, ple 1.11e-02); one more step: 3.416% vs control 3.312% (bound 9.935%, top-1 same)
PASS  recording verify pass matches the batched pass (<= 0.1% of spread)
PASS  rollback state stays inside 3x the re-chunk band (ssm, conv, ple)
PASS  rollback then one step stays inside the prefill-rechunk band
PASS  turn-2 reused the speculative turn-1 state
  info  turn-2 logits from the reused speculative state: 7.763% of spread vs a cold rebuild (prefill-rechunk control 6.164%, bound 18.493%), top-1 differs; reused 64 of 71 tokens after a 48-token turn 1 (20 verify passes)
PASS  reused speculative state stays inside the prefill-rechunk band
PASS  turn-1 speculation ran
PASS  whole MTP check process memory fits the priced target
MTP CHECK PASS
MTP CHECK MEMORY {"lifetime_physical_footprint_peak_bytes":10506933696,"lifetime_rss_peak_bytes":5972000768,"memory_validated":true,"physical_footprint_end_bytes":10411808792,"sampled_peak_bytes":10506933696,"samples":8235,"swap_clean":false,"swapins_after":1411008,"swapins_before":1410952,"swapouts_after":1923638,"swapouts_before":1923638,"target_gb":12}

```

