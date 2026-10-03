---
type: run
created: 2026-10-03T06:22:31.753334+00:00
updated: 2026-10-03T06:22:31.753334+00:00
summary: Correction to VQ component allocation-class coverage
binary: a383a3d37336b390a67e6ad1b75830aa168c8aa90d6149e72592fc73bacb7b47
captured_at: 2026-10-03
command: Exact sequential producer and diagnostic commands are preserved in the driver and supervision identity transcripts below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Correction to VQ component allocation-class coverage
tool: bounded VQ research diagnostics
---

The earlier component fixtures selected layers 0 and 2 in both packs. Those layers span both complete-record allocation classes in VQ 3.2, but only one class in VQ 4.4. Its second representative is layer 3. The claim that the resident-bank component exercised both actual families in both packs is withdrawn. The same limitation applies to the old 4.4 complete-record and segmented-prefill component fixtures. Their measured bit-equality results remain valid for the recorded layers. This audit does not retract the independently measured complete-model checks, which execute all 48 layers.

The attached audit reads the exact pinned configuration bytes, groups complete gate/up/down descriptor triples, records every layer in each class and derives record byte sizes from actual packing, dimensions and scales. It shows six versus forty-two layers for VQ 3.2 and seven versus forty-one for VQ 4.4. New producer mode allocation-classes-v1 chooses the first representative of every distinct triple and the native consumer binds that marker to the exact artifact. The outcome of those new component runs is recorded separately; this source itself is a coverage correction and geometry audit, not model, performance or memory-floor qualification.

Local home prefixes are replaced with <HOME>. Original byte counts and SHA-256 values identify unmodified local transcripts. Tensor fixture payloads, frozen executables and source archives remain in the bounded research directory; manifests bind their hashes. These functional runs do not qualify timing, task quality or an alternative production pack. No model is installed or activated.

### vq-allocation-class-audit-v1.py

Original bytes: 1675. SHA-256: `7639679791d35c999632e9e59a03372f1cc365c5afece9d95514bffcc1336802`.

````text
from pathlib import Path
import json,hashlib,math
r=Path('.build/quantization-research');records=[]
for pack in ('3.2','4.4'):
 raw=(r/f'candidate-{pack}/config.json').read_bytes();config=json.loads(raw)
 classes={}
 for layer in range(48):
  descriptors=[config['vq_modules'][f'model.layers.{layer}.mlp.switch_mlp.{name}'] for name in ('gate_proj','up_proj','down_proj')]
  signature=json.dumps(descriptors,sort_keys=True,separators=(',',':'))
  if signature not in classes:
   size=0
   for item in descriptors:
    bits=item.get('pack_bits',0)
    code_row=((item['in']//item['dim']*bits+31)//32*4) if bits else item['in']//item['dim']
    size += item['out']*(code_row+item['in']//64*2)
   classes[signature]={'layers':[],'descriptors':descriptors,'record_bytes':size}
  classes[signature]['layers'].append(layer)
 entries=list(classes.values());old=[next(i for i,c in enumerate(entries) if layer in c['layers']) for layer in (0,2)]
 records.append({'pack':pack,'config_sha256':hashlib.sha256(raw).hexdigest(),'classes':entries,'legacy_fixture_layers':[0,2],
  'legacy_fixture_classes':old,'legacy_distinct_classes':len(set(old)),
  'representative_layers':[entry['layers'][0] for entry in entries],
  'bank_bytes_at_96_per_class':96*sum(entry['record_bytes'] for entry in entries)})
(r/'vq-allocation-class-audit-v1.json').write_text(json.dumps({'schema':1,'scope':'authenticated artifact geometry audit; no speed estimate','artifacts':records},indent=2)+'\n')
print(json.dumps([{'pack':x['pack'],'legacy_classes':x['legacy_distinct_classes'],'representatives':x['representative_layers'],'bank_bytes_at_96_per_class':x['bank_bytes_at_96_per_class']} for x in records]))
````

### vq-allocation-class-audit-v1.json

Original bytes: 5398. SHA-256: `d5f2c96070cc1e46e4f40f69d70a641e2688c473600f6cdcc529c6427a27d109`.

````text
{
  "schema": 1,
  "scope": "authenticated artifact geometry audit; no speed estimate",
  "artifacts": [
    {
      "pack": "3.2",
      "config_sha256": "75d7d9b1bfa7762e46ef7c512f6779b43fbd1a1a7f9715684a79f6b01f07cfe5",
      "classes": [
        {
          "layers": [
            0,
            1,
            5,
            31,
            39,
            47
          ],
          "descriptors": [
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 256,
              "dim": 2,
              "group": 64
            },
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 256,
              "dim": 2,
              "group": 64
            },
            {
              "experts": 512,
              "out": 2560,
              "in": 640,
              "k": 256,
              "dim": 2,
              "group": 64
            }
          ],
          "record_bytes": 2611200
        },
        {
          "layers": [
            2,
            3,
            4,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20,
            21,
            22,
            23,
            24,
            25,
            26,
            27,
            28,
            29,
            30,
            32,
            33,
            34,
            35,
            36,
            37,
            38,
            40,
            41,
            42,
            43,
            44,
            45,
            46
          ],
          "descriptors": [
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 2048,
              "dim": 4,
              "group": 64,
              "pack_bits": 11
            },
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 2048,
              "dim": 4,
              "group": 64,
              "pack_bits": 11
            },
            {
              "experts": 512,
              "out": 2560,
              "in": 640,
              "k": 2048,
              "dim": 4,
              "group": 64,
              "pack_bits": 11
            }
          ],
          "record_bytes": 1843200
        }
      ],
      "legacy_fixture_layers": [
        0,
        2
      ],
      "legacy_fixture_classes": [
        0,
        1
      ],
      "legacy_distinct_classes": 2,
      "representative_layers": [
        0,
        2
      ],
      "bank_bytes_at_96_per_class": 427622400
    },
    {
      "pack": "4.4",
      "config_sha256": "9ca97027fc253eb6ad14a2db0d0df5aec729403c8af8b4d59194c9e6a3dff458",
      "classes": [
        {
          "layers": [
            0,
            1,
            2,
            16,
            24,
            31,
            39
          ],
          "descriptors": [
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 1024,
              "dim": 2,
              "group": 64,
              "pack_bits": 10
            },
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 1024,
              "dim": 2,
              "group": 64,
              "pack_bits": 10
            },
            {
              "experts": 512,
              "out": 2560,
              "in": 640,
              "k": 1024,
              "dim": 2,
              "group": 64,
              "pack_bits": 10
            }
          ],
          "record_bytes": 3225600
        },
        {
          "layers": [
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            17,
            18,
            19,
            20,
            21,
            22,
            23,
            25,
            26,
            27,
            28,
            29,
            30,
            32,
            33,
            34,
            35,
            36,
            37,
            38,
            40,
            41,
            42,
            43,
            44,
            45,
            46,
            47
          ],
          "descriptors": [
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 256,
              "dim": 2,
              "group": 64
            },
            {
              "experts": 512,
              "out": 640,
              "in": 2560,
              "k": 256,
              "dim": 2,
              "group": 64
            },
            {
              "experts": 512,
              "out": 2560,
              "in": 640,
              "k": 256,
              "dim": 2,
              "group": 64
            }
          ],
          "record_bytes": 2611200
        }
      ],
      "legacy_fixture_layers": [
        0,
        2
      ],
      "legacy_fixture_classes": [
        0,
        0
      ],
      "legacy_distinct_classes": 1,
      "representative_layers": [
        0,
        3
      ],
      "bank_bytes_at_96_per_class": 560332800
    }
  ]
}
````

### frozen-cache-native-v2/build-identity.json

Original bytes: 30228. SHA-256: `dcaa4658325b699d344e4187c115a8044bbea1b6dc8553ca61cd79496d5022b8`.

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
    "Sources/Slotstream/Checkpoint.swift": "1c4fa73fffa9a27258454a5e2ce435d6babb4e15956350dc2d5fb865c081d632",
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
    "Sources/Slotstream/Layers.swift": "692f0eea4d8d97f227edb248680122cdce676cf05107f2b70dce29f646c8c57f",
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
    "Sources/Slotstream/VQCheckpoint.swift": "64aabe3d074d467551df647a1118dd543c90d7823379a40400ce69943afb64ac",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "1ded1ecb9f15504e384be8b860a554ace03521b09b81b8e064fd08dd6fb46afc",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "376e5048a89d3c23ca5dfa46c6c9ffef996fd6eb88c8be2491e766d200f5e2e2",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "89e406c26ffbed48a85cb8098f8f57e71cc895f944168917ea852bf3dcbfddaa",
    "Sources/Slotstream/VQRecordBank.swift": "ccfa44e1d61f56a3faaa6392a09c10724793fcec35d29428bbb75989926b13f8",
    "Sources/Slotstream/VQRecordCache.swift": "461eeab5f97b966fdada724d0e962137fed099bc19da79619c51d57d66bcf16d",
    "Sources/Slotstream/VQRouteStream.swift": "77f7b2803d7f0bb054c7c696071591c2183bbbf3f636905f4f00b57511ef5811",
    "Sources/Slotstream/VQTensorFile.swift": "52e165b8a00501abb59faa1b5b2ff22d1f9f3e2fe0fda8a1bf4bd721439c38ed",
    "Sources/Slotstream/VQTrunkProbe.swift": "43f7ec7848b35b30b8164bfcad44469dc79c249a318a4b36d33699584bac614f",
    "Sources/Slotstream/Vendored/GatedDelta.swift": "1e0edf00c535c1aa605b996f83bd4f3f39d14a628f0f8a2d21667f069d823175",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "b1831205aec8d49c9d81a7425eb3bbdc4e9324414ff4dde5645859936ac65f6a",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "6816a7f1ef6dcaebe68c6477bd9bb6fd3791372e425176a3dc760b13a6cfb89d",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQBank.swift": "dcfb93979b70afa10b7c03f5b9707b758d6b569035523f0a529c21250d48ca5c",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "3aedcbdbd1423cf0b718339965d0ad92cdd82878dbf2776dcfedf699bd3f5077",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "8376a3a59bf56e3c71b550beedf5b5d6cc54141b5353ca5ace1449079c3f01c6",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "f029ef815983cec642a36dfea44bb73e7c57a1428d3c36e43ab8a840b8179fea",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "dde614e3757164722dc6ea3686135e54ededde004e7429e4429ec05d6c3f4556",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "af0d99556cbc8591034905c3883bf07628a0773f232122a0ee5e3ea0295453a1",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQTrunk.swift": "6cd5fbd5d13d1c1f5a59545d1616abd67073bcac096b77da8d03d9a6c9f1d10b",
    "Sources/SlotstreamDiagnostics/Diagnostics+VerifyPass.swift": "37baddc192c0f9083bef740f897d16cda315b82017349b122807bfbfcc77400e",
    "Sources/SlotstreamDiagnostics/Diagnostics+Vision.swift": "7779c1339db28cce006d300d6bdd41e3e9a27c55314153aa12659c3e11d575b3",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionAttention.swift": "66ddb233e4e1754d9b499e3bde590c073d32e47512ca7db79269aa9d25d40718",
    "Sources/SlotstreamDiagnostics/Diagnostics+VisionCapacity.swift": "0610214d34b5f763aa65c17013082914f176ca176483a77a422c5a87d592b591",
    "Sources/SlotstreamDiagnostics/Diagnostics.swift": "98ff2ba72838b5346d45ff18b87e43c2598a4ecf09a54b50c050150108a9fa03",
    "Sources/SlotstreamDiagnostics/ExpertLookaheadCollector.swift": "4f8d1a402334a149eef2f7470ce96b7fad48f0fdcf2370143d25f3bc8ba0f423",
    "Sources/SlotstreamDiagnostics/Goldens.swift": "aeb98c73b02c2e4f27baefee935fa4e7e67254da686e79ed96ffbdc26ca3c958",
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
    "Sources/SlotstreamTestKit/T0Checks.swift": "ef514f9bbc80ea537cfe518b0af2c2edf85d042e780e88f40faa38cd64bfdde4",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "ccd516c808092b66c0eedede2a4c9c995e610cc469de34d3b1926cfcac26a01a",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "e25d9405271d6be0d57b22d0970c3677a962038d786a418f418a3047b5cbf9c7",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "cc05b5a23e4add8061c254ecb4373d91df88de3d3678f2788199ebea59ca65c0",
  "binary_sha256": "a383a3d37336b390a67e6ad1b75830aa168c8aa90d6149e72592fc73bacb7b47",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
