---
type: run
created: 2026-10-03T03:47:21.472616+00:00
updated: 2026-10-03T03:47:21.472616+00:00
summary: Candidate BF16 sigmoid rounding and diagnostic failures
binary: 214c2107afe5ee9cc51a60a420fb63f12d618536ae8631f3d6eb0fc2d279a3ff
captured_at: 2026-10-02
command: Exact sequential producer and diagnostic commands are preserved in the driver and supervision identity transcripts below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Candidate BF16 sigmoid rounding and diagnostic failures
tool: bounded VQ research diagnostics
---

The attention microscope places the first mismatch at the hyper-connection sigmoid input -6.84375. Earlier hyper-connection intermediates match exactly. The ordinary native Metal expression disagrees with the pinned Python GPU at one finite BF16 input; precise exp with explicitly rounded BF16 intermediates matches the entire finite BF16 domain. This establishes an observed arithmetic difference, not a complete diagnosis of the compiler implementation. FP32 sigmoid and the deployed arithmetic profile remain unchanged.

The first native exhaustive diagnostic attempts crashed while accessing a scalar. The v4 crash note initially blamed the UInt16 accessor; that hypothesis is superseded. Switching accessors in v5 still crashed. Explicit evaluation plus raw-data inspection in v6 exposed the actual MLX error: its floating literal had inferred FP64, unsupported on the GPU. The final diagnostic uses an explicit Float input. Preserve these failed instruments; they do not invalidate the independently passing complete-stack comparison or prove a native exhaustive pass by themselves. The separate validation source records the repaired native test verdict.

Local home prefixes are replaced with <HOME>. Original byte counts and SHA-256 values identify unmodified local transcripts. Tensor fixture payloads, frozen executables and source archives remain in the bounded research directory; manifests bind their hashes. These functional runs do not qualify timing, task quality or an alternative production pack. No model is installed or activated.

### vq-sigmoid-isolation-v1.json

Original bytes: 2236. SHA-256: `e67a5c14ba8a57d3c5dab1693b2bb4879afce42884e9c966d05c893fc53e896d`.

````text
{
  "fresh_python": {
    "native": 83,
    "reference": 0
  },
  "native": {
    "native": 0,
    "reference": 83
  },
  "reference": {
    "native": 83,
    "reference": 0
  },
  "distinct_bad_inputs": [
    -6.84375
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22624911360,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    14368.\nPages active:                                1104780.\nPages inactive:                              1198116.\nPages speculative:                              4450.\nPages throttled:                                   0.\nPages wired down:                             170830.\nPages purgeable:                                9000.\n\"Translation faults\":                     1062105968.\nPages copy-on-write:                        63837083.\nPages zero filled:                        1904572611.\nPages reactivated:                          93014219.\nPages purged:                               10742209.\nFile-backed pages:                           1357547.\nAnonymous pages:                              949799.\nPages stored in compressor:                  1079756.\nPages occupied by compressor:                 592828.\nDecompressions:                             22876048.\nCompressions:                               32335063.\nPageins:                                   535494650.\nPageouts:                                     328124.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128926.\nPages tagged resident:                         92533.\nPages tagged compressed:                       36393.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          147.\nPages tag-storage non-tag pageable:            92987.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5252544.\nTagged compressions:                          427226.\nTagged decompressions:                        355668.\n"
  }
}
````

### vq-sigmoid-jit-v1.json

Original bytes: 188. SHA-256: `7ef827ea4a7da8a0ad56ff0afee7a83d0712f263dc72bb7c660c0c8d27952512`.

````text
{"finite_values": 65280, "different": 1, "source": "uint i = thread_position_in_grid.x; auto x = input[i]; auto y = 1 / (1 + metal::exp(metal::abs(x))); output[i] = (x < 0) ? y : 1 - y;"}
````

### vq-sigmoid-rounding-v1.json

Original bytes: 1160. SHA-256: `8ce1a56dd66c3646850e18d7642a15b1057a3aaf036492e1d7e35822a2ab155d`.

````text
[
  {
    "variant": "round_exp",
    "different": 776,
    "first_inputs": [
      0.0194091796875,
      0.01953125,
      0.0196533203125,
      0.019775390625,
      0.0198974609375,
      0.02001953125,
      0.0201416015625,
      0.020263671875
    ],
    "source": "float x=float(input[i]); float e=float(bfloat16_t(metal::exp(metal::abs(x)))); float y=1.0f/(1.0f+e); output[i]=bfloat16_t((x<0)?y:1.0f-y);"
  },
  {
    "variant": "round_exp_sum",
    "different": 131,
    "first_inputs": [
      0.1005859375,
      0.10107421875,
      0.1015625,
      0.10205078125,
      0.1025390625,
      0.10302734375,
      0.103515625,
      0.10400390625
    ],
    "source": "float x=float(input[i]); float e=float(bfloat16_t(metal::exp(metal::abs(x)))); float d=float(bfloat16_t(1.0f+e)); float y=1.0f/d; output[i]=bfloat16_t((x<0)?y:1.0f-y);"
  },
  {
    "variant": "round_all",
    "different": 1,
    "first_inputs": [
      -6.84375
    ],
    "source": "float x=float(input[i]); float e=float(bfloat16_t(metal::exp(metal::abs(x)))); float d=float(bfloat16_t(1.0f+e)); float y=float(bfloat16_t(1.0f/d)); output[i]=bfloat16_t((x<0)?y:1.0f-y);"
  }
]
````

### vq-sigmoid-precise-v1.json

Original bytes: 511. SHA-256: `9e4009a85e8df9479126f4437aaa8bcf14ff88e7d9ff3e82383262ae45b36a51`.

````text
[
  {
    "variant": "precise_steps",
    "different": 0,
    "first_inputs": [],
    "source": "float x=float(input[i]); bfloat16_t e=bfloat16_t(metal::precise::exp(metal::abs(x))); bfloat16_t d=bfloat16_t(1.0f+float(e)); bfloat16_t y=bfloat16_t(1.0f/float(d)); output[i]=bfloat16_t((x<0)?float(y):1.0f-float(y));"
  },
  {
    "variant": "precise_auto",
    "different": 0,
    "first_inputs": [],
    "source": "auto x=input[i]; auto y=1/(1+metal::precise::exp(metal::abs(x))); output[i]=(x<0)?y:1-y;"
  }
]
````

### vq-sigmoid-reference-v1/sigmoid.json

Original bytes: 74621. SHA-256: `592242c8e61239746239a30da42a40bddca019752a8976efc93ab41601789d11`.

````text
{
  "schema": 1,
  "producer_sha256": "6e1ce0da8e758d153e3ad0425bd7073d2b3accf719750823a6163e7377125d32",
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c",
      "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb",
      "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8",
      "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34",
      "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
      "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"
    },
    "packages": {
      "mlx": {
        "version": "0.32.2",
        "files": {
          "mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912",
          "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de",
          "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29",
          "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2",
          "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66",
          "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723",
          "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb",
          "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27",
          "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492",
          "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831",
          "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007",
          "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1",
          "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f",
          "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6",
          "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee",
          "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b",
          "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969",
          "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f",
          "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8",
          "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23",
          "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83",
          "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c",
          "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77",
          "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b",
          "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7",
          "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b",
          "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc",
          "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849",
          "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247",
          "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42",
          "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a",
          "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae",
          "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"
        }
      },
      "mlx-metal": {
        "version": "0.32.2",
        "files": {
          "mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a",
          "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084",
          "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8",
          "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
        }
      },
      "mlx-lm": {
        "version": "0.31.3",
        "files": {
          "mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608",
          "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834",
          "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c",
          "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553",
          "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8",
          "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7",
          "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7",
          "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5",
          "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a",
          "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1",
          "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39",
          "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f",
          "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b",
          "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7",
          "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5",
          "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9",
          "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72",
          "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5",
          "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82",
          "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f",
          "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb",
          "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d",
          "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7",
          "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373",
          "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5",
          "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8",
          "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750",
          "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a",
          "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610",
          "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70",
          "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66",
          "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095",
          "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d",
          "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9",
          "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7",
          "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91",
          "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db",
          "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1",
          "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914",
          "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e",
          "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96",
          "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1",
          "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c",
          "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251",
          "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a",
          "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38",
          "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6",
          "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8",
          "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f",
          "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2",
          "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2",
          "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05",
          "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643",
          "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e",
          "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec",
          "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9",
          "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd",
          "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443",
          "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba",
          "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af",
          "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19",
          "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332",
          "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197",
          "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db",
          "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f",
          "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19",
          "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d",
          "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd",
          "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305",
          "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d",
          "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0",
          "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8",
          "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c",
          "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395",
          "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca",
          "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb",
          "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c",
          "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8",
          "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f",
          "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8",
          "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4",
          "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf",
          "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7",
          "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd",
          "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13",
          "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306",
          "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145",
          "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca",
          "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d",
          "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c",
          "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057",
          "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4",
          "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855",
          "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae",
          "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f",
          "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e",
          "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9",
          "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393",
          "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90",
          "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1",
          "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4",
          "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b",
          "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9",
          "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5",
          "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e",
          "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd",
          "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28",
          "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b",
          "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582",
          "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e",
          "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391",
          "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306",
          "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41",
          "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639",
          "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a",
          "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619",
          "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005",
          "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79",
          "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e",
          "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9",
          "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc",
          "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a",
          "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e",
          "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832",
          "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179",
          "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125",
          "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a",
          "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a",
          "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a",
          "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169",
          "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2",
          "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427",
          "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a",
          "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa",
          "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa",
          "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a",
          "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020",
          "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e",
          "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58",
          "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67",
          "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b",
          "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19",
          "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a",
          "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc",
          "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c",
          "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66",
          "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1",
          "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206",
          "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531",
          "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f",
          "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0",
          "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d",
          "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25",
          "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3",
          "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3",
          "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17",
          "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10",
          "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45",
          "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375",
          "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe",
          "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553",
          "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d",
          "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"
        }
      },
      "numpy": {
        "version": "2.5.2",
        "files": {
          "numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b",
          "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11",
          "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972",
          "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a",
          "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2",
          "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6",
          "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb",
          "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2",
          "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926",
          "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881",
          "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a",
          "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0",
          "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476",
          "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee",
          "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af",
          "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627",
          "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b",
          "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c",
          "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78",
          "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950",
          "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d",
          "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5",
          "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66",
          "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2",
          "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2",
          "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395",
          "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf",
          "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605",
          "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5",
          "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106",
          "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c",
          "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49",
          "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417",
          "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8",
          "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca",
          "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807",
          "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b",
          "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e",
          "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332",
          "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3",
          "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957",
          "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2",
          "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0",
          "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81",
          "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a",
          "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea",
          "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d",
          "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159",
          "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582",
          "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af",
          "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c",
          "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2",
          "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d",
          "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224",
          "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec",
          "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a",
          "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489",
          "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67",
          "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a",
          "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143",
          "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a",
          "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31",
          "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d",
          "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847",
          "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f",
          "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f",
          "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b",
          "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0",
          "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf",
          "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477",
          "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2",
          "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650",
          "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1",
          "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd",
          "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a",
          "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4",
          "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc",
          "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41",
          "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111",
          "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008",
          "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d",
          "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a",
          "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19",
          "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068",
          "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72",
          "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01",
          "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c",
          "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c",
          "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099",
          "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0",
          "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a",
          "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761",
          "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca",
          "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e",
          "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6",
          "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc",
          "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8",
          "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446",
          "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe",
          "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc",
          "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9",
          "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca",
          "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288",
          "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76",
          "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0",
          "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4",
          "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76",
          "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669",
          "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808",
          "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987",
          "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a",
          "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f",
          "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36",
          "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2",
          "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b",
          "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b",
          "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605",
          "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002",
          "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b",
          "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33",
          "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8",
          "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1",
          "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7",
          "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1",
          "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284",
          "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c",
          "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24",
          "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5",
          "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e",
          "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310",
          "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf",
          "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9",
          "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9",
          "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c",
          "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a",
          "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27",
          "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c",
          "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275",
          "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436",
          "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5",
          "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714",
          "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550",
          "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df",
          "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822",
          "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93",
          "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92",
          "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b",
          "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2",
          "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930",
          "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca",
          "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c",
          "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf",
          "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07",
          "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306",
          "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf",
          "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5",
          "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142",
          "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406",
          "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a",
          "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795",
          "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab",
          "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c",
          "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c",
          "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8",
          "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537",
          "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e",
          "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74",
          "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec",
          "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0",
          "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7",
          "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a",
          "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0",
          "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d",
          "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822",
          "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8",
          "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137",
          "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37",
          "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3",
          "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576",
          "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681",
          "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b",
          "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529",
          "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491",
          "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6",
          "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873",
          "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4",
          "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4",
          "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281",
          "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547",
          "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0",
          "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09",
          "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f",
          "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d",
          "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4",
          "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7",
          "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc",
          "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3",
          "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9",
          "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e",
          "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e",
          "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82",
          "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f",
          "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7",
          "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e",
          "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36",
          "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6",
          "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d",
          "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026",
          "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777",
          "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386",
          "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb",
          "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599",
          "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07",
          "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa",
          "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b",
          "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f",
          "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0",
          "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72",
          "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b",
          "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f",
          "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d",
          "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b",
          "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d",
          "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e",
          "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131",
          "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4",
          "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0",
          "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460",
          "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771",
          "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116",
          "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd",
          "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e",
          "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48",
          "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb",
          "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5",
          "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545",
          "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc",
          "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec",
          "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862",
          "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb",
          "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939",
          "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea",
          "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195",
          "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435",
          "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0",
          "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292",
          "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b",
          "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074",
          "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6",
          "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4",
          "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874",
          "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792",
          "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202",
          "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292",
          "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c",
          "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc",
          "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f",
          "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b",
          "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c",
          "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79",
          "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4",
          "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a",
          "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af",
          "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324",
          "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46",
          "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780",
          "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed",
          "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab",
          "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c",
          "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5",
          "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e",
          "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74",
          "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4",
          "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f",
          "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98",
          "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004",
          "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3",
          "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c",
          "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca",
          "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2",
          "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f",
          "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d",
          "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c",
          "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781",
          "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953",
          "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e",
          "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5",
          "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828",
          "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417",
          "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425",
          "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11",
          "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2",
          "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642",
          "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6",
          "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5",
          "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718",
          "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16",
          "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782",
          "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c",
          "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5",
          "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9",
          "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53",
          "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709",
          "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4",
          "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47",
          "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca",
          "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917",
          "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8",
          "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f",
          "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2",
          "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824",
          "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d",
          "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3",
          "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396",
          "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25",
          "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af",
          "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d",
          "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6",
          "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033",
          "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418",
          "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84",
          "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352",
          "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99",
          "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228",
          "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca",
          "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82",
          "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78",
          "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b",
          "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9",
          "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0",
          "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5",
          "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801",
          "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c",
          "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc",
          "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b",
          "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b",
          "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3",
          "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639",
          "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e",
          "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0",
          "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5",
          "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945",
          "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b",
          "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f",
          "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45",
          "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931",
          "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3",
          "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c",
          "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213",
          "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5",
          "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9",
          "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2",
          "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4",
          "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13",
          "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e",
          "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37",
          "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557",
          "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc",
          "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9",
          "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363",
          "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a",
          "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5",
          "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32",
          "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498",
          "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049",
          "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7",
          "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4",
          "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0",
          "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc",
          "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166",
          "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682",
          "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482",
          "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a",
          "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e",
          "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196",
          "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed",
          "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a",
          "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723",
          "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14",
          "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5",
          "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2",
          "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392",
          "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759",
          "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee",
          "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe",
          "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd",
          "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe",
          "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0",
          "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c",
          "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4",
          "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94",
          "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147",
          "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1",
          "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c",
          "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665",
          "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b",
          "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02",
          "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff",
          "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67",
          "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94",
          "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0",
          "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0",
          "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509",
          "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda",
          "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0",
          "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1",
          "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796",
          "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3",
          "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5",
          "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14",
          "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297",
          "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54",
          "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"
        }
      }
    },
    "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]",
    "sha256": "0505bcc315797f8fb5772bc6693d82a3315d6365507cddc472073011faf089e2"
  },
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22944612352,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   100140.\nPages active:                                1081075.\nPages inactive:                              1022118.\nPages speculative:                             91045.\nPages throttled:                                   0.\nPages wired down:                             180342.\nPages purgeable:                                1069.\n\"Translation faults\":                     1066877879.\nPages copy-on-write:                        64124784.\nPages zero filled:                        1908450798.\nPages reactivated:                          93186812.\nPages purged:                               10757026.\nFile-backed pages:                           1299219.\nAnonymous pages:                              895019.\nPages stored in compressor:                  1109369.\nPages occupied by compressor:                 610307.\nDecompressions:                             22928902.\nCompressions:                               32431538.\nPageins:                                   544097403.\nPageouts:                                     329110.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 129009.\nPages tagged resident:                         93203.\nPages tagged compressed:                       35806.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          204.\nPages tag-storage non-tag pageable:            92862.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5222272.\nTagged compressions:                          428912.\nTagged decompressions:                        356318.\n"
  },
  "values": 65280,
  "expected_output_sha256": "c487ccb3208e0ad603a280dd5b17a28910f9487929a0ba9bdfb1f782b3722b32",
  "fixture_sha256": "56c4bdf0eded5cd509f5a4516352cbeb6ae8b3f432af2bfcd1beebb89e6b5c69",
  "observations": [
    {
      "variant": "original",
      "source": "auto x=input[i]; auto y=1/(1+metal::exp(metal::abs(x))); output[i]=(x<0)?y:1-y;",
      "different": 1,
      "differing_inputs": [
        -6.84375
      ]
    },
    {
      "variant": "precise",
      "source": "float x=float(input[i]); bfloat16_t e=bfloat16_t(metal::precise::exp(metal::abs(x))); bfloat16_t d=bfloat16_t(1.0f+float(e)); bfloat16_t y=bfloat16_t(1.0f/float(d)); output[i]=bfloat16_t((x<0)?float(y):1.0f-float(y));",
      "different": 0,
      "differing_inputs": []
    }
  ],
  "qualification": "unproven"
}
````

### vq-attention-native-v2-comparison.json

Original bytes: 2319. SHA-256: `214e9eb4e84b45e1515ec2559b17921627d15989945753b2d680201c990ebed3`.

````text
[
  {
    "name": "attnInput",
    "shape": [
      1,
      3,
      2560
    ],
    "geometry_equal": true,
    "differing": 24,
    "elements": 7680,
    "max_abs_error": 7.62939453125e-06
  },
  {
    "name": "attnInject",
    "shape": [
      1,
      3,
      4
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 12,
    "max_abs_error": 0.0
  },
  {
    "name": "qgRaw",
    "shape": [
      1,
      3,
      24,
      512
    ],
    "geometry_equal": true,
    "differing": 29,
    "elements": 36864,
    "max_abs_error": 0.00048828125
  },
  {
    "name": "qNormed",
    "shape": [
      1,
      24,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 17,
    "elements": 18432,
    "max_abs_error": 0.0078125
  },
  {
    "name": "kNormed",
    "shape": [
      1,
      2,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 1,
    "elements": 1536,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "v",
    "shape": [
      1,
      2,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 1,
    "elements": 1536,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "qRoped",
    "shape": [
      1,
      24,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 17,
    "elements": 18432,
    "max_abs_error": 0.0078125
  },
  {
    "name": "kRoped",
    "shape": [
      1,
      2,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 1,
    "elements": 1536,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "sdpaOut",
    "shape": [
      1,
      24,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 24,
    "elements": 18432,
    "max_abs_error": 0.000244140625
  },
  {
    "name": "attnOutput",
    "shape": [
      1,
      3,
      2560
    ],
    "geometry_equal": true,
    "differing": 69,
    "elements": 7680,
    "max_abs_error": 0.0009765625
  },
  {
    "name": "afterAttn",
    "shape": [
      1,
      3,
      10240
    ],
    "geometry_equal": true,
    "differing": 16,
    "elements": 30720,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "mlpInput",
    "shape": [
      1,
      3,
      2560
    ],
    "geometry_equal": true,
    "differing": 99,
    "elements": 7680,
    "max_abs_error": 0.0078125
  }
]
````

### vq-attention-native-v3-comparison.json

Original bytes: 3574. SHA-256: `ccad8ff858da8d559f65fa7eae1d352f869a941e591a3ce3c879f65a390d6703`.

````text
[
  {
    "name": "hcInput",
    "shape": [
      1,
      3,
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 30720,
    "max_abs_error": 0.0
  },
  {
    "name": "hcWeight",
    "shape": [
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 10240,
    "max_abs_error": 0.0
  },
  {
    "name": "hcNormalized",
    "shape": [
      1,
      3,
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 30720,
    "max_abs_error": 0.0
  },
  {
    "name": "hcDown",
    "shape": [
      1,
      3,
      320
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 960,
    "max_abs_error": 0.0
  },
  {
    "name": "hcActivated",
    "shape": [
      1,
      3,
      320
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 960,
    "max_abs_error": 0.0
  },
  {
    "name": "hcUp",
    "shape": [
      1,
      3,
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 30720,
    "max_abs_error": 0.0
  },
  {
    "name": "hcGates",
    "shape": [
      1,
      3,
      10240
    ],
    "geometry_equal": true,
    "differing": 83,
    "elements": 30720,
    "max_abs_error": 7.62939453125e-06
  },
  {
    "name": "attnInput",
    "shape": [
      1,
      3,
      2560
    ],
    "geometry_equal": true,
    "differing": 24,
    "elements": 7680,
    "max_abs_error": 7.62939453125e-06
  },
  {
    "name": "attnInject",
    "shape": [
      1,
      3,
      4
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 12,
    "max_abs_error": 0.0
  },
  {
    "name": "qgRaw",
    "shape": [
      1,
      3,
      24,
      512
    ],
    "geometry_equal": true,
    "differing": 29,
    "elements": 36864,
    "max_abs_error": 0.00048828125
  },
  {
    "name": "qNormed",
    "shape": [
      1,
      24,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 17,
    "elements": 18432,
    "max_abs_error": 0.0078125
  },
  {
    "name": "kNormed",
    "shape": [
      1,
      2,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 1,
    "elements": 1536,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "v",
    "shape": [
      1,
      2,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 1,
    "elements": 1536,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "qRoped",
    "shape": [
      1,
      24,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 17,
    "elements": 18432,
    "max_abs_error": 0.0078125
  },
  {
    "name": "kRoped",
    "shape": [
      1,
      2,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 1,
    "elements": 1536,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "sdpaOut",
    "shape": [
      1,
      24,
      3,
      256
    ],
    "geometry_equal": true,
    "differing": 24,
    "elements": 18432,
    "max_abs_error": 0.000244140625
  },
  {
    "name": "attnOutput",
    "shape": [
      1,
      3,
      2560
    ],
    "geometry_equal": true,
    "differing": 69,
    "elements": 7680,
    "max_abs_error": 0.0009765625
  },
  {
    "name": "afterAttn",
    "shape": [
      1,
      3,
      10240
    ],
    "geometry_equal": true,
    "differing": 16,
    "elements": 30720,
    "max_abs_error": 6.103515625e-05
  },
  {
    "name": "mlpInput",
    "shape": [
      1,
      3,
      2560
    ],
    "geometry_equal": true,
    "differing": 99,
    "elements": 7680,
    "max_abs_error": 0.0078125
  }
]
````

### vq-arithmetic-diagnostic-crash-v4.json

Original bytes: 984. SHA-256: `5deaf23a8a61d1db004cf4a8b6f759f0f7c957fc4a7407b6409b1055b6b553dd`.

````text
{
  "exception": {
    "codes": "0x0000000000000001, 0x0000000103919854",
    "rawCodes": [
      1,
      4354840660
    ],
    "type": "EXC_BREAKPOINT",
    "signal": "SIGTRAP"
  },
  "fault": [
    {
      "imageOffset": 13932628,
      "sourceFile": "/<compiler-generated>",
      "symbol": "Swift runtime failure: precondition failure",
      "imageIndex": 0,
      "symbolLocation": 0,
      "inline": true
    },
    {
      "imageOffset": 13932628,
      "sourceLine": 332,
      "sourceFile": "MLXArray.swift",
      "symbol": "MLXArray.item<A>(_:)",
      "imageIndex": 0,
      "symbolLocation": 836
    },
    {
      "imageOffset": 19163708,
      "sourceLine": 24,
      "sourceFile": "Diagnostics+VQArithmetic.swift",
      "symbol": "closure #1 in static Diagnostics.quantizationCandidateArithmetic()",
      "imageIndex": 0,
      "symbolLocation": 2124
    }
  ],
  "scope": "diagnostic used unsupported UInt16 scalar item accessor; replaced with bounded asArray"
}
````

### vq-arithmetic-diagnostic-crash-v5.json

Original bytes: 13519. SHA-256: `77ee28e883a704661696441dde1ad1f2dc05139113ca88741c6910e2fe0a1ada`.

````text
{
  "exception": {
    "codes": "0x0000000000000002, 0x000000016abb7ff0",
    "message": "Thread stack size exceeded due to excessive recursion",
    "rawCodes": [
      2,
      6085640176
    ],
    "type": "EXC_BAD_ACCESS",
    "signal": "SIGSEGV",
    "subtype": "KERN_PROTECTION_FAILURE at 0x000000016abb7ff0"
  },
  "fault": [
    {
      "frames": [
        {
          "imageOffset": 417048,
          "symbol": "invocation function for block in dyld3::MachOLoaded::getSlide() const",
          "symbolLocation": 4,
          "imageIndex": 2
        },
        {
          "imageOffset": 8596,
          "symbol": "dyld3::MachOFile::forEachLoadCommand(Diagnostics&, void (load_command const*, bool&) block_pointer) const",
          "symbolLocation": 224,
          "imageIndex": 2
        },
        {
          "imageOffset": 416176,
          "symbol": "dyld3::MachOLoaded::getSlide() const",
          "symbolLocation": 144,
          "imageIndex": 2
        },
        {
          "imageOffset": 418788,
          "symbol": "invocation function for block in dyld3::MachOLoaded::findSectionContent(char const*, char const*, unsigned long long&) const",
          "symbolLocation": 172,
          "imageIndex": 2
        },
        {
          "imageOffset": 630700,
          "symbol": "invocation function for block in mach_o::UnsafeHeader::forEachSection(void (mach_o::UnsafeHeader::SectionInfo const&, bool&) block_pointer) const",
          "symbolLocation": 312,
          "imageIndex": 2
        },
        {
          "imageOffset": 616868,
          "symbol": "mach_o::UnsafeHeader::forEachLoadCommand(void (load_command const*, bool&) block_pointer) const",
          "symbolLocation": 208,
          "imageIndex": 2
        },
        {
          "imageOffset": 623180,
          "symbol": "mach_o::UnsafeHeader::forEachSection(void (mach_o::UnsafeHeader::SectionInfo const&, bool&) block_pointer) const",
          "symbolLocation": 124,
          "imageIndex": 2
        },
        {
          "imageOffset": 418576,
          "symbol": "dyld3::MachOLoaded::findSectionContent(char const*, char const*, unsigned long long&) const",
          "symbolLocation": 132,
          "imageIndex": 2
        },
        {
          "imageOffset": 58100,
          "symbol": "dyld4::APIs::_dyld_find_unwind_sections(void*, dyld_unwind_sections*)",
          "symbolLocation": 328,
          "imageIndex": 2
        },
        {
          "imageOffset": 14404,
          "symbol": "libunwind::UnwindCursor<libunwind::LocalAddressSpace, libunwind::Registers_arm64>::setInfoBasedOnIPRegister(bool)",
          "symbolLocation": 364,
          "imageIndex": 3
        },
        {
          "imageOffset": 27256,
          "symbol": "libunwind::UnwindCursor<libunwind::LocalAddressSpace, libunwind::Registers_arm64>::step(bool)",
          "symbolLocation": 2136,
          "imageIndex": 3
        },
        {
          "imageOffset": 11604,
          "symbol": "unwind_phase2",
          "symbolLocation": 308,
          "imageIndex": 3
        },
        {
          "imageOffset": 10012,
          "symbol": "_Unwind_RaiseException",
          "symbolLocation": 740,
          "imageIndex": 3
        },
        {
          "imageOffset": 8340,
          "symbol": "__cxa_throw",
          "symbolLocation": 84,
          "imageIndex": 4
        },
        {
          "symbol": "mlx_array_get_(mlx_array_)",
          "inline": true,
          "imageIndex": 0,
          "imageOffset": 786116,
          "symbolLocation": 48,
          "sourceLine": 44,
          "sourceFile": "array.h"
        },
        {
          "imageOffset": 786116,
          "sourceLine": 454,
          "sourceFile": "ops.cpp",
          "symbol": "mlx_astype",
          "imageIndex": 0,
          "symbolLocation": 284
        },
        {
          "imageOffset": 13929920,
          "sourceLine": 498,
          "sourceFile": "MLXArray.swift",
          "symbol": "MLXArray.asType(_:stream:)",
          "imageIndex": 0,
          "symbolLocation": 148
        },
        {
          "imageOffset": 13817404,
          "sourceLine": 125,
          "sourceFile": "MLXArray+Bytes.swift",
          "symbol": "MLXArray.asArray<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 252
        },
        {
          "imageOffset": 13817432,
          "sourceLine": 125,
          "sourceFile": "MLXArray+Bytes.swift",
          "symbol": "MLXArray.asArray<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 280
        },
        {
          "imageOffset": 13817432,
          "sourceLine": 125,
          "sourceFile": "MLXArray+Bytes.swift",
          "symbol": "MLXArray.asArray<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 280
        },
        {
          "imageOffset": 13817432,
          "sourceLine": 125,
          "sourceFile": "MLXArray+Bytes.swift",
          "symbol": "MLXArray.asArray<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 280
        },
        {
          "imageOffset": 13817432,
          "sourceLine": 125,
          "sourceFile": "MLXArray+Bytes.swift",
          "symbol": "MLXArray.asArray<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 280
        },
        {
          "imageOffset": 13817432,
          "sourceLine": 125,
          "sourceFile": "MLXArray+Bytes.swift",
          "symbol": "MLXArray.asArray<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 280
        },
        {
          "imageOffset": 13817432,
          "sourceLine": 125,
          "sourceFile": "MLXArray+Bytes.swift",
          "symbol": "MLXArray.asArray<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 280
        },
        {
          "imageOffset": 19163312,
          "sourceLine": 24,
          "sourceFile": "Diagnostics+VQArithmetic.swift",
          "symbol": "closure #1 in static Diagnostics.quantizationCandidateArithmetic()",
          "imageIndex": 0,
          "symbolLocation": 2120
        },
        {
          "imageOffset": 19163688,
          "sourceFile": "/<compiler-generated>",
          "symbol": "partial apply for closure #1 in static Diagnostics.quantizationCandidateArithmetic()",
          "symbolLocation": 16,
          "imageIndex": 0
        },
        {
          "symbol": "closure #1 in withError<A>(_:)",
          "inline": true,
          "imageIndex": 0,
          "imageOffset": 13750548,
          "symbolLocation": 4,
          "sourceLine": 150,
          "sourceFile": "ErrorHandler.swift"
        },
        {
          "imageOffset": 13750548,
          "sourceFile": "/<compiler-generated>",
          "symbol": "partial apply for closure #1 in withError<A>(_:)",
          "symbolLocation": 20,
          "imageIndex": 0
        },
        {
          "imageOffset": 13751940,
          "sourceLine": 376,
          "sourceFile": "ErrorHandler.swift",
          "symbol": "closure #1 in ErrorHandler.withError<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 44
        },
        {
          "imageOffset": 13752696,
          "sourceFile": "/<compiler-generated>",
          "symbol": "partial apply for closure #1 in ErrorHandler.withError<A>(_:)",
          "symbolLocation": 20,
          "imageIndex": 0
        },
        {
          "symbol": "closure #1 in ErrorHandler.withErrorHandler<A>(_:_:)",
          "inline": true,
          "imageIndex": 0,
          "imageOffset": 13752876,
          "symbolLocation": 4,
          "sourceLine": 355,
          "sourceFile": "ErrorHandler.swift"
        },
        {
          "imageOffset": 13752876,
          "sourceFile": "/<compiler-generated>",
          "symbol": "partial apply for closure #1 in ErrorHandler.withErrorHandler<A>(_:_:)",
          "symbolLocation": 20,
          "imageIndex": 0
        },
        {
          "imageOffset": 390016,
          "symbol": "TaskLocal.withValue<A>(_:operation:file:line:)",
          "symbolLocation": 232,
          "imageIndex": 5
        },
        {
          "imageOffset": 13747308,
          "sourceLine": 354,
          "sourceFile": "ErrorHandler.swift",
          "symbol": "ErrorHandler.withErrorHandler<A>(_:_:)",
          "imageIndex": 0,
          "symbolLocation": 272
        },
        {
          "imageOffset": 13748460,
          "sourceLine": 375,
          "sourceFile": "ErrorHandler.swift",
          "symbol": "ErrorHandler.withError<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 140
        },
        {
          "imageOffset": 13748576,
          "sourceLine": 150,
          "sourceFile": "ErrorHandler.swift",
          "symbol": "withError<A>(_:)",
          "imageIndex": 0,
          "symbolLocation": 72
        },
        {
          "imageOffset": 19161060,
          "sourceLine": 12,
          "sourceFile": "Diagnostics+VQArithmetic.swift",
          "symbol": "static Diagnostics.quantizationCandidateArithmetic()",
          "imageIndex": 0,
          "symbolLocation": 128
        },
        {
          "imageOffset": 20402180,
          "sourceLine": 41,
          "sourceFile": "QuantizationCommands.swift",
          "symbol": "QuantizationCheck.run()",
          "imageIndex": 0,
          "symbolLocation": 1652
        },
        {
          "imageOffset": 20405232,
          "sourceFile": "/<compiler-generated>",
          "symbol": "protocol witness for ParsableCommand.run() in conformance QuantizationCheck",
          "symbolLocation": 72,
          "imageIndex": 0
        },
        {
          "imageOffset": 19555728,
          "sourceFile": "main.swift",
          "symbol": "specialized static ParsableCommand.main(_:)",
          "imageIndex": 0,
          "symbolLocation": 76,
          "inline": true
        },
        {
          "imageOffset": 19555728,
          "sourceFile": "/<compiler-generated>",
          "symbol": "specialized static ParsableCommand.main()",
          "imageIndex": 0,
          "symbolLocation": 76,
          "inline": true
        },
        {
          "imageOffset": 19555728,
          "sourceLine": 2003,
          "sourceFile": "main.swift",
          "symbol": "main",
          "imageIndex": 0,
          "symbolLocation": 96
        },
        {
          "imageOffset": 132324,
          "symbol": "start",
          "symbolLocation": 6992,
          "imageIndex": 2
        }
      ],
      "id": 4185460,
      "recursionInfoArray": [
        {
          "hottestElided": 20,
          "coldestElided": 58004,
          "depth": 57991,
          "keyFrame": {
            "imageOffset": 13817432,
            "sourceLine": 125,
            "sourceFile": "MLXArray+Bytes.swift",
            "symbol": "MLXArray.asArray<A>(_:)",
            "imageIndex": 0,
            "symbolLocation": 280
          }
        }
      ],
      "originalLength": 58024,
      "triggered": true,
      "threadState": {
        "x": [
          {
            "value": 6085640384
          },
          {
            "value": 6662062112
          },
          {
            "value": 6085640287
          },
          {
            "value": 0
          },
          {
            "value": 84
          },
          {
            "value": 84
          },
          {
            "value": 5
          },
          {
            "value": 5
          },
          {
            "value": 6658759956,
            "symbolLocation": 0,
            "symbol": "invocation function for block in dyld3::MachOLoaded::getSlide() const"
          },
          {
            "value": 792
          },
          {
            "value": 2712
          },
          {
            "value": 6657446632
          },
          {
            "value": 0
          },
          {
            "value": 6928922420,
            "symbolLocation": 0,
            "symbol": "unw_getcontext"
          },
          {
            "value": 6928921656,
            "symbolLocation": 0,
            "symbol": "_Unwind_RaiseException"
          },
          {
            "value": 0
          },
          {
            "value": 6658759956,
            "symbolLocation": 0,
            "symbol": "invocation function for block in dyld3::MachOLoaded::getSlide() const"
          },
          {
            "value": 7701436843865899200
          },
          {
            "value": 0
          },
          {
            "value": 6085640464
          },
          {
            "value": 6662062080
          },
          {
            "value": 6085640384
          },
          {
            "value": 0
          },
          {
            "value": 6662064824
          },
          {
            "value": 6662062112
          },
          {
            "value": 6662064816
          },
          {
            "value": 6085640400
          },
          {
            "value": 6662062904
          },
          {
            "value": 16
          }
        ],
        "flavor": "ARM_THREAD_STATE64",
        "lr": {
          "value": 6658351508
        },
        "cpsr": {
          "value": 536870912
        },
        "fp": {
          "value": 6085640368
        },
        "sp": {
          "value": 6085640224
        },
        "esr": {
          "value": 2449473607,
          "description": "(Data Abort) byte write Translation fault"
        },
        "pc": {
          "value": 6658759960,
          "matchesCrashFrame": 1
        },
        "far": {
          "value": 6085640176
        }
      },
      "queue": "com.apple.main-thread"
    }
  ]
}
````

### vq-sigmoid-reference-v1-supervision/identity.json

Original bytes: 2336. SHA-256: `f435cf2d4355dff32097aae8343181169087cc14a2e27e5cf4a03ae5a2bc07ec`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_sigmoid_reference.py",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-sigmoid-reference-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22974054400,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   117084.\nPages active:                                1079516.\nPages inactive:                              1008884.\nPages speculative:                             89275.\nPages throttled:                                   0.\nPages wired down:                             180321.\nPages purgeable:                                1069.\n\"Translation faults\":                     1066871540.\nPages copy-on-write:                        64124064.\nPages zero filled:                        1908448407.\nPages reactivated:                          93186812.\nPages purged:                               10757026.\nFile-backed pages:                           1284072.\nAnonymous pages:                              893603.\nPages stored in compressor:                  1109413.\nPages occupied by compressor:                 610338.\nDecompressions:                             22928858.\nCompressions:                               32431538.\nPageins:                                   544083906.\nPageouts:                                     329110.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 129009.\nPages tagged resident:                         93203.\nPages tagged compressed:                       35806.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          231.\nPages tag-storage non-tag pageable:            92835.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5222272.\nTagged compressions:                          428912.\nTagged decompressions:                        356318.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-sigmoid-reference-v1-supervision/receipt.json

Original bytes: 2127. SHA-256: `29a0a85cfd844f81725422d0a6e4b500603278fb12b684a23a0f672c6f9f0a1c`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 109920976,
  "samples": 9,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22967418880,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   100711.\nPages active:                                1080022.\nPages inactive:                              1023543.\nPages speculative:                             90169.\nPages throttled:                                   0.\nPages wired down:                             180333.\nPages purgeable:                                1085.\n\"Translation faults\":                     1066885611.\nPages copy-on-write:                        64125263.\nPages zero filled:                        1908458169.\nPages reactivated:                          93186812.\nPages purged:                               10757026.\nFile-backed pages:                           1300024.\nAnonymous pages:                              893710.\nPages stored in compressor:                  1109369.\nPages occupied by compressor:                 610307.\nDecompressions:                             22928902.\nCompressions:                               32431538.\nPageins:                                   544097916.\nPageouts:                                     329110.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128987.\nPages tagged resident:                         93181.\nPages tagged compressed:                       35806.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5229.\nPages tag-storage free:                          205.\nPages tag-storage non-tag pageable:            92862.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5222272.\nTagged compressions:                          428912.\nTagged decompressions:                        356318.\n"
  },
  "seconds": 0.539231459
}
````

### vq-sigmoid-reference-v1-supervision/stdout.txt

Original bytes: 67953. SHA-256: `2ae5114c65d807e1bc3d2f4e811603f838c15c37a8567b8e7eca662f1c0e15a9`.

````text
{"schema": 1, "producer_sha256": "6e1ce0da8e758d153e3ad0425bd7073d2b3accf719750823a6163e7377125d32", "instrument": {"scripts": {"vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec", "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e", "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749", "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c", "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb", "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8", "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34", "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472", "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"}, "packages": {"mlx": {"version": "0.32.2", "files": {"mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912", "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de", "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29", "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2", "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66", "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723", "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb", "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27", "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492", "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831", "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007", "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1", "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f", "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6", "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee", "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b", "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969", "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f", "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8", "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23", "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83", "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c", "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77", "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b", "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7", "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b", "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc", "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849", "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247", "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42", "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a", "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae", "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"}}, "mlx-metal": {"version": "0.32.2", "files": {"mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a", "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084", "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8", "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"}}, "mlx-lm": {"version": "0.31.3", "files": {"mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608", "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834", "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c", "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553", "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8", "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7", "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7", "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5", "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a", "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1", "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39", "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f", "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b", "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7", "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5", "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9", "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72", "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5", "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82", "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f", "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb", "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d", "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7", "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373", "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5", "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8", "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750", "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a", "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610", "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70", "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66", "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095", "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d", "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9", "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7", "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91", "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db", "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1", "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914", "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e", "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96", "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1", "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c", "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251", "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a", "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38", "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6", "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8", "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f", "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2", "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2", "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05", "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643", "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e", "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec", "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9", "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd", "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443", "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba", "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af", "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19", "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332", "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197", "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db", "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f", "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19", "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d", "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd", "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305", "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d", "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0", "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8", "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c", "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395", "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca", "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb", "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c", "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8", "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f", "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8", "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4", "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf", "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7", "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd", "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13", "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306", "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145", "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca", "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d", "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c", "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057", "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4", "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855", "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae", "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f", "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e", "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9", "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393", "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90", "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1", "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4", "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b", "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9", "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5", "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e", "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd", "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28", "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b", "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582", "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e", "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391", "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306", "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41", "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639", "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a", "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619", "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005", "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79", "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e", "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9", "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc", "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a", "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e", "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832", "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179", "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125", "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a", "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a", "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a", "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169", "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2", "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427", "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a", "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa", "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa", "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a", "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020", "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e", "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58", "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67", "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b", "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19", "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a", "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc", "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c", "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66", "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1", "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206", "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531", "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f", "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0", "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d", "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25", "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3", "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3", "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17", "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10", "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45", "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375", "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe", "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553", "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d", "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"}}, "numpy": {"version": "2.5.2", "files": {"numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b", "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11", "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972", "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a", "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2", "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6", "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb", "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2", "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926", "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881", "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a", "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0", "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476", "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee", "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af", "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627", "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b", "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c", "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78", "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950", "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d", "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5", "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66", "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2", "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2", "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395", "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf", "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605", "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5", "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106", "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c", "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49", "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417", "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8", "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca", "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807", "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b", "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e", "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332", "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3", "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957", "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2", "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0", "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81", "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a", "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea", "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d", "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159", "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582", "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af", "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c", "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2", "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d", "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224", "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec", "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a", "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489", "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67", "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a", "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143", "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a", "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31", "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d", "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847", "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f", "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f", "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b", "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0", "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf", "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477", "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2", "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650", "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1", "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd", "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a", "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4", "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc", "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41", "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111", "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008", "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d", "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a", "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19", "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068", "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72", "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01", "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c", "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c", "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099", "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0", "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a", "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761", "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca", "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e", "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6", "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc", "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8", "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446", "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe", "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc", "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9", "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca", "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288", "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76", "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0", "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4", "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76", "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669", "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808", "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987", "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a", "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f", "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36", "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2", "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b", "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605", "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002", "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b", "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33", "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8", "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1", "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7", "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1", "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284", "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c", "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24", "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5", "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e", "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310", "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf", "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9", "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9", "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c", "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a", "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27", "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c", "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275", "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436", "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5", "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714", "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550", "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df", "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822", "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93", "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92", "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b", "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2", "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930", "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca", "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c", "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf", "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07", "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306", "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf", "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5", "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142", "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406", "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a", "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795", "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab", "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c", "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c", "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8", "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537", "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e", "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74", "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec", "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0", "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7", "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a", "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0", "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d", "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822", "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8", "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137", "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37", "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3", "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576", "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681", "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529", "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491", "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6", "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873", "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4", "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4", "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281", "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547", "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0", "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09", "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f", "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d", "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4", "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7", "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc", "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3", "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9", "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e", "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e", "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82", "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f", "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7", "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e", "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36", "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6", "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d", "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026", "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777", "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386", "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb", "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599", "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07", "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa", "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b", "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f", "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0", "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72", "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b", "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f", "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d", "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b", "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d", "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e", "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131", "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4", "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0", "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460", "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771", "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116", "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd", "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e", "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48", "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb", "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5", "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545", "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc", "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec", "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862", "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb", "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939", "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea", "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195", "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435", "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0", "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292", "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b", "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074", "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6", "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4", "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874", "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792", "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202", "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292", "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c", "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc", "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f", "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b", "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c", "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79", "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4", "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a", "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af", "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324", "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46", "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780", "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed", "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab", "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c", "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5", "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e", "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74", "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4", "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f", "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98", "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004", "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3", "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c", "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca", "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2", "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f", "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d", "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c", "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781", "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953", "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e", "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5", "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828", "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417", "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425", "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11", "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2", "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642", "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6", "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5", "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718", "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16", "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782", "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c", "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5", "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9", "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53", "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709", "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4", "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47", "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca", "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917", "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8", "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f", "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2", "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824", "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d", "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3", "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396", "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25", "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af", "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d", "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6", "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033", "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418", "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84", "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352", "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99", "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228", "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca", "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82", "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78", "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b", "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9", "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0", "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5", "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801", "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c", "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc", "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b", "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b", "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3", "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639", "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e", "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0", "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5", "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945", "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b", "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f", "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45", "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931", "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3", "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c", "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213", "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5", "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9", "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2", "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4", "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13", "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e", "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37", "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557", "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc", "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9", "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363", "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a", "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5", "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32", "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498", "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049", "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7", "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4", "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0", "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc", "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166", "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682", "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482", "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a", "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e", "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196", "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed", "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a", "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723", "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14", "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5", "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2", "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392", "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759", "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee", "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe", "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd", "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe", "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0", "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c", "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4", "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94", "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147", "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1", "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c", "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665", "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b", "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02", "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff", "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67", "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94", "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0", "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0", "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509", "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda", "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0", "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1", "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796", "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3", "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5", "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14", "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297", "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54", "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"}}}, "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]", "sha256": "0505bcc315797f8fb5772bc6693d82a3315d6365507cddc472073011faf089e2"}, "before": {"page_bytes": 16384, "reclaimable_bytes": 22944612352, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   100140.\nPages active:                                1081075.\nPages inactive:                              1022118.\nPages speculative:                             91045.\nPages throttled:                                   0.\nPages wired down:                             180342.\nPages purgeable:                                1069.\n\"Translation faults\":                     1066877879.\nPages copy-on-write:                        64124784.\nPages zero filled:                        1908450798.\nPages reactivated:                          93186812.\nPages purged:                               10757026.\nFile-backed pages:                           1299219.\nAnonymous pages:                              895019.\nPages stored in compressor:                  1109369.\nPages occupied by compressor:                 610307.\nDecompressions:                             22928902.\nCompressions:                               32431538.\nPageins:                                   544097403.\nPageouts:                                     329110.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 129009.\nPages tagged resident:                         93203.\nPages tagged compressed:                       35806.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5230.\nPages tag-storage free:                          204.\nPages tag-storage non-tag pageable:            92862.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5222272.\nTagged compressions:                          428912.\nTagged decompressions:                        356318.\n"}, "values": 65280, "expected_output_sha256": "c487ccb3208e0ad603a280dd5b17a28910f9487929a0ba9bdfb1f782b3722b32", "fixture_sha256": "56c4bdf0eded5cd509f5a4516352cbeb6ae8b3f432af2bfcd1beebb89e6b5c69", "observations": [{"variant": "original", "source": "auto x=input[i]; auto y=1/(1+metal::exp(metal::abs(x))); output[i]=(x<0)?y:1-y;", "different": 1, "differing_inputs": [-6.84375]}, {"variant": "precise", "source": "float x=float(input[i]); bfloat16_t e=bfloat16_t(metal::precise::exp(metal::abs(x))); bfloat16_t d=bfloat16_t(1.0f+float(e)); bfloat16_t y=bfloat16_t(1.0f/float(d)); output[i]=bfloat16_t((x<0)?float(y):1.0f-float(y));", "different": 0, "differing_inputs": []}], "qualification": "unproven"}
````

### vq-sigmoid-reference-v1-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-attention-3.2-v1/attention.json

Original bytes: 96905. SHA-256: `a3bf58a025b69419721624b4a90754e4b6eab89bb9f8b4826706d4abb9ed388f`.

````text
{
  "schema": 1,
  "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "normalization": "vq-raw-zero-centered-to-pr1788-folded-bf16-v1",
  "artifact": {
    "verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e",
    "stamps": {
      "model-00001.safetensors": [
        16777232,
        61124837,
        3502305114,
        1790981216969651631,
        1790981216973805883
      ],
      "model-00012.safetensors": [
        16777232,
        61124923,
        6258175824,
        1790981377005612627,
        1790981377009206956
      ],
      "model-00013.safetensors": [
        16777232,
        61125010,
        6471407889,
        1790981545033604036,
        1790981545036494899
      ],
      "model-00014.safetensors": [
        16777232,
        61125132,
        6547978262,
        1790981736942738954,
        1790981736944883976
      ],
      "model-00015.safetensors": [
        16777232,
        61125286,
        6471407935,
        1790981924339816693,
        1790981924342464654
      ],
      "model-00016.safetensors": [
        16777232,
        61125510,
        6857620951,
        1790982119683472302,
        1790982119685710216
      ],
      "model-00017.safetensors": [
        16777232,
        61129776,
        6679034951,
        1790982305666734292,
        1790982305672913817
      ],
      "model-00018.safetensors": [
        16777232,
        61136554,
        6733521211,
        1790982515929442647,
        1790982515931575685
      ],
      "model-00019.safetensors": [
        16777232,
        61136710,
        3457093298,
        1790982619932592777,
        1790982619933742130
      ],
      "model-ple-0000.safetensors": [
        16777232,
        61140250,
        162517607,
        1790982627138573871,
        1790982627139487012
      ],
      "model-ple-0001.safetensors": [
        16777232,
        61140257,
        162517605,
        1790982633555677032,
        1790982633556582756
      ],
      "model-ple-0002.safetensors": [
        16777232,
        61140267,
        162517610,
        1790982639202217456,
        1790982639203120347
      ],
      "model-ple-0003.safetensors": [
        16777232,
        61140272,
        162517613,
        1790982645069140209,
        1790982645069823054
      ],
      "model-ple-0004.safetensors": [
        16777232,
        61140283,
        162517613,
        1790982650945947009,
        1790982650946871359
      ],
      "model-ple-0005.safetensors": [
        16777232,
        61140293,
        162517611,
        1790982657117788365,
        1790982657118728631
      ],
      "model-ple-0006.safetensors": [
        16777232,
        61140299,
        162517611,
        1790982663412388541,
        1790982663413293974
      ],
      "model-ple-0007.safetensors": [
        16777232,
        61140312,
        162517611,
        1790982669152254855,
        1790982669153205538
      ],
      "model-ple-0008.safetensors": [
        16777232,
        61140320,
        162517613,
        1790982674022126144,
        1790982674023049244
      ],
      "model-ple-0009.safetensors": [
        16777232,
        61140331,
        162517613,
        1790982678928236736,
        1790982678929079667
      ],
      "model-ple-0010.safetensors": [
        16777232,
        61140335,
        162517613,
        1790982683656085531,
        1790982683656969339
      ],
      "model-ple-0011.safetensors": [
        16777232,
        61140341,
        162517613,
        1790982688473524025,
        1790982688474332997
      ],
      "model-ple-0012.safetensors": [
        16777232,
        61140355,
        162517613,
        1790982693458602253,
        1790982693459500144
      ],
      "model-ple-0013.safetensors": [
        16777232,
        61140371,
        162517610,
        1790982698170087804,
        1790982698170988778
      ],
      "model-ple-0014.safetensors": [
        16777232,
        61140391,
        162517613,
        1790982703332828567,
        1790982703333775500
      ],
      "model-ple-0015.safetensors": [
        16777232,
        61140399,
        162517613,
        1790982708259744691,
        1790982708261148174
      ],
      "model-ple-0016.safetensors": [
        16777232,
        61140409,
        162517613,
        1790982713943583771,
        1790982713944535246
      ],
      "model-ple-0017.safetensors": [
        16777232,
        61140416,
        162517613,
        1790982719388327528,
        1790982719389255419
      ],
      "model-ple-0018.safetensors": [
        16777232,
        61140420,
        162517611,
        1790982725402636950,
        1790982725403550133
      ],
      "model-ple-0019.safetensors": [
        16777232,
        61140425,
        162517613,
        1790982731256203385,
        1790982731257126901
      ],
      "model-ple-0020.safetensors": [
        16777232,
        61140432,
        162517611,
        1790982738071856793,
        1790982738076684212
      ],
      "model-ple-0021.safetensors": [
        16777232,
        61140437,
        162517611,
        1790982744489047206,
        1790982744489882637
      ],
      "model-ple-0022.safetensors": [
        16777232,
        61140441,
        162517613,
        1790982750186433982,
        1790982750187391749
      ],
      "model-ple-0023.safetensors": [
        16777232,
        61140448,
        162517613,
        1790982756483893209,
        1790982756484835975
      ],
      "model-ple-0024.safetensors": [
        16777232,
        61140462,
        162517610,
        1790982762487478610,
        1790982762488429168
      ],
      "model-ple-0025.safetensors": [
        16777232,
        61140474,
        162517613,
        1790982768446695857,
        1790982768447609374
      ],
      "model-ple-0026.safetensors": [
        16777232,
        61140482,
        162517611,
        1790982774682704006,
        1790982774683668940
      ],
      "model-ple-0027.safetensors": [
        16777232,
        61140487,
        162517613,
        1790982780054403106,
        1790982780055155744
      ],
      "model-ple-0028.safetensors": [
        16777232,
        61140492,
        162517611,
        1790982786131927514,
        1790982786133070409
      ],
      "model-ple-0029.safetensors": [
        16777232,
        61140498,
        162517613,
        1790982791720789884,
        1790982791721679899
      ],
      "model-ple-0030.safetensors": [
        16777232,
        61140507,
        162517613,
        1790982797363790787,
        1790982797364736846
      ],
      "model-ple-0031.safetensors": [
        16777232,
        61140513,
        162517611,
        1790982802855896085,
        1790982802856819934
      ],
      "model-ple-0032.safetensors": [
        16777232,
        61140518,
        162517613,
        1790982807785930346,
        1790982807786920405
      ],
      "model-ple-0033.safetensors": [
        16777232,
        61140523,
        162517610,
        1790982812651563228,
        1790982812652470660
      ],
      "model-ple-0034.safetensors": [
        16777232,
        61140532,
        162517610,
        1790982817300943895,
        1790982817301852203
      ],
      "model-ple-0035.safetensors": [
        16777232,
        61140541,
        162517610,
        1790982821915884168,
        1790982821916815851
      ],
      "model-ple-0036.safetensors": [
        16777232,
        61140548,
        162517610,
        1790982826932480491,
        1790982826933326089
      ],
      "model-ple-0037.safetensors": [
        16777232,
        61140558,
        162517608,
        1790982832539544681,
        1790982832540443571
      ],
      "model-ple-0038.safetensors": [
        16777232,
        61140562,
        162517608,
        1790982838522902935,
        1790982838523814159
      ],
      "model-ple-0039.safetensors": [
        16777232,
        61140567,
        162517610,
        1790982843582402768,
        1790982843583243134
      ],
      "model-ple-0040.safetensors": [
        16777232,
        61140573,
        162517607,
        1790982848339011099,
        1790982848339968272
      ],
      "model-ple-0041.safetensors": [
        16777232,
        61140580,
        162517610,
        1790982853469781697,
        1790982853470684511
      ],
      "model-ple-0042.safetensors": [
        16777232,
        61140585,
        162517610,
        1790982858244013692,
        1790982858244908195
      ],
      "model-ple-0043.safetensors": [
        16777232,
        61140590,
        162517610,
        1790982864003203242,
        1790982864003554394
      ],
      "model-ple-0044.safetensors": [
        16777232,
        61140723,
        162517610,
        1790982869607285689,
        1790982869607623044
      ],
      "model-ple-0045.safetensors": [
        16777232,
        61140727,
        162517610,
        1790982874968029129,
        1790982874968458830
      ],
      "model-ple-0046.safetensors": [
        16777232,
        61140733,
        162517610,
        1790982880349184866,
        1790982880349581326
      ],
      "model-ple-0047.safetensors": [
        16777232,
        61140740,
        162517610,
        1790982885705681830,
        1790982885706026572
      ],
      "model-ple-0048.safetensors": [
        16777232,
        61140754,
        162517610,
        1790982891521923333,
        1790982891522300880
      ],
      "model-ple-0049.safetensors": [
        16777232,
        61140765,
        162517610,
        1790982897650766513,
        1790982897651168488
      ],
      "model-ple-0050.safetensors": [
        16777232,
        61140771,
        162517610,
        1790982902965919941,
        1790982902966278301
      ],
      "model-ple-0051.safetensors": [
        16777232,
        61140786,
        162517607,
        1790982908425811945,
        1790982908426161103
      ],
      "model-ple-0052.safetensors": [
        16777232,
        61140797,
        162517610,
        1790982913785471096,
        1790982913785813799
      ],
      "model-ple-0053.safetensors": [
        16777232,
        61140810,
        162517610,
        1790982919733610844,
        1790982919734091924
      ],
      "model-ple-0054.safetensors": [
        16777232,
        61140815,
        162517610,
        1790982925452621410,
        1790982925452965243
      ],
      "model-ple-0055.safetensors": [
        16777232,
        61140822,
        162517608,
        1790982932055042996,
        1790982932055373372
      ],
      "model-ple-0056.safetensors": [
        16777232,
        61140834,
        162517610,
        1790982936821992693,
        1790982936822328986
      ],
      "model-ple-0057.safetensors": [
        16777232,
        61140853,
        162517610,
        1790982941795208562,
        1790982941795727564
      ],
      "model-ple-0058.safetensors": [
        16777232,
        61140865,
        162517610,
        1790982946659199029,
        1790982946659690490
      ],
      "model-ple-0059.safetensors": [
        16777232,
        61140875,
        162517608,
        1790982951976555530,
        1790982951976913741
      ],
      "model-ple-0060.safetensors": [
        16777232,
        61140902,
        162517610,
        1790982956943755943,
        1790982956944108612
      ],
      "model-ple-0061.safetensors": [
        16777232,
        61140920,
        162517608,
        1790982962665866982,
        1790982962666720072
      ],
      "model-ple-0062.safetensors": [
        16777232,
        61140930,
        162517607,
        1790982967600947912,
        1790982967601780793
      ],
      "model-ple-0063.safetensors": [
        16777232,
        61140936,
        162517610,
        1790982973501324444,
        1790982973502267410
      ],
      "model-ple-0064.safetensors": [
        16777232,
        61140943,
        162517610,
        1790982979530596195,
        1790982979531817747
      ],
      "model-ple-0065.safetensors": [
        16777232,
        61140947,
        162517610,
        1790982985158304116,
        1790982985159197707
      ],
      "model-ple-0066.safetensors": [
        16777232,
        61140953,
        162517610,
        1790982990898086726,
        1790982990899063943
      ],
      "model-ple-0067.safetensors": [
        16777232,
        61140961,
        162517610,
        1790982996401559646,
        1790982996402469196
      ],
      "model-ple-0068.safetensors": [
        16777232,
        61140966,
        162517610,
        1790983001756097601,
        1790983001756707940
      ],
      "model-ple-0069.safetensors": [
        16777232,
        61140971,
        162517610,
        1790983007637603657,
        1790983007638662583
      ],
      "model-ple-0070.safetensors": [
        16777232,
        61140981,
        162517610,
        1790983013286585629,
        1790983013287401512
      ],
      "model-ple-0071.safetensors": [
        16777232,
        61140991,
        162517610,
        1790983018661604180,
        1790983018662524313
      ],
      "model-ple-0072.safetensors": [
        16777232,
        61140996,
        162517608,
        1790983025820209701,
        1790983025820855165
      ],
      "model-ple-0073.safetensors": [
        16777232,
        61141003,
        162517607,
        1790983031268771311,
        1790983031269542818
      ],
      "model-ple-0074.safetensors": [
        16777232,
        61141007,
        162517610,
        1790983036991725465,
        1790983036992614640
      ],
      "model-ple-0075.safetensors": [
        16777232,
        61141012,
        162517608,
        1790983043613793342,
        1790983043614438681
      ],
      "model-ple-0076.safetensors": [
        16777232,
        61141018,
        162517610,
        1790983049313185610,
        1790983049313857116
      ],
      "model-ple-0077.safetensors": [
        16777232,
        61141023,
        162517610,
        1790983055161970608,
        1790983055162864367
      ],
      "model-ple-0078.safetensors": [
        16777232,
        61141032,
        162517610,
        1790983061167775992,
        1790983061168481748
      ],
      "model-ple-0079.safetensors": [
        16777232,
        61141036,
        162517610,
        1790983067037600567,
        1790983067038473950
      ],
      "model-ple-0080.safetensors": [
        16777232,
        61141049,
        162517610,
        1790983072453387751,
        1790983072454284801
      ],
      "model-ple-0081.safetensors": [
        16777232,
        61141056,
        162517610,
        1790983078283342764,
        1790983078284280980
      ],
      "model-ple-0082.safetensors": [
        16777232,
        61141060,
        162517610,
        1790983084482326237,
        1790983084483212704
      ],
      "model-ple-0083.safetensors": [
        16777232,
        61141066,
        162517610,
        1790983089959112142,
        1790983089959804899
      ],
      "model-ple-0084.safetensors": [
        16777232,
        61141082,
        162517607,
        1790983095473290968,
        1790983095474232352
      ],
      "model-ple-0085.safetensors": [
        16777232,
        61141108,
        162517610,
        1790983101378794539,
        1790983101379764131
      ],
      "model-ple-0086.safetensors": [
        16777232,
        61141148,
        162517610,
        1790983107460704078,
        1790983107461626962
      ],
      "model-ple-0087.safetensors": [
        16777232,
        61141156,
        162517610,
        1790983113584810374,
        1790983113585582464
      ],
      "model-ple-0088.safetensors": [
        16777232,
        61141169,
        162517610,
        1790983119099203121,
        1790983119100094587
      ],
      "model-ple-0089.safetensors": [
        16777232,
        61141174,
        162517608,
        1790983124882360253,
        1790983124883316345
      ],
      "model-ple-0090.safetensors": [
        16777232,
        61141184,
        162517610,
        1790983129724665676,
        1790983129728605211
      ],
      "model-ple-0091.safetensors": [
        16777232,
        61141201,
        162517610,
        1790983134421494909,
        1790983134422479168
      ],
      "model-ple-0092.safetensors": [
        16777232,
        61141209,
        162517608,
        1790983140041034022,
        1790983140041975030
      ],
      "model-ple-0093.safetensors": [
        16777232,
        61141216,
        162517610,
        1790983144777734031,
        1790983144778600997
      ],
      "model-ple-0094.safetensors": [
        16777232,
        61141241,
        162517610,
        1790983149994926383,
        1790983149995738224
      ],
      "model-ple-0095.safetensors": [
        16777232,
        61141276,
        162517607,
        1790983154752645124,
        1790983154753430965
      ],
      "model-ple-0096.safetensors": [
        16777232,
        61141310,
        162517610,
        1790983159970819319,
        1790983159971858203
      ],
      "model-ple-0097.safetensors": [
        16777232,
        61141318,
        162517610,
        1790983164974114237,
        1790983164975063121
      ],
      "model-ple-0098.safetensors": [
        16777232,
        61141323,
        162517610,
        1790983170565673096,
        1790983170566609646
      ],
      "model-ple-0099.safetensors": [
        16777232,
        61141341,
        162517610,
        1790983176718977574,
        1790983176719852457
      ],
      "model-ple-0100.safetensors": [
        16777232,
        61141350,
        162517610,
        1790983182892329693,
        1790983182892738405
      ],
      "model-ple-0101.safetensors": [
        16777232,
        61141372,
        162517608,
        1790983190065519468,
        1790983190066574978
      ],
      "model-ple-0102.safetensors": [
        16777232,
        61141385,
        162517610,
        1790983196095511208,
        1790983196096427549
      ],
      "model-ple-0103.safetensors": [
        16777232,
        61141390,
        162517610,
        1790983202080614873,
        1790983202081544381
      ],
      "model-ple-0104.safetensors": [
        16777232,
        61141399,
        162517610,
        1790983208182737513,
        1790983208183661313
      ],
      "model-ple-0105.safetensors": [
        16777232,
        61141403,
        162517608,
        1790983215042826794,
        1790983215043752094
      ],
      "model-ple-0106.safetensors": [
        16777232,
        61141409,
        162517607,
        1790983221162356590,
        1790983221163275015
      ],
      "model-ple-0107.safetensors": [
        16777232,
        61141416,
        162517610,
        1790983227340430125,
        1790983227341199799
      ],
      "model-ple-0108.safetensors": [
        16777232,
        61141423,
        162517610,
        1790983233417963378,
        1790983233418918095
      ],
      "model-ple-0109.safetensors": [
        16777232,
        61141427,
        162517610,
        1790983240053641506,
        1790983240054479847
      ],
      "model-ple-0110.safetensors": [
        16777232,
        61141434,
        162517610,
        1790983246089577132,
        1790983246090531974
      ],
      "model-ple-0111.safetensors": [
        16777232,
        61141445,
        162517608,
        1790983252879031941,
        1790983252879968574
      ],
      "model-ple-0112.safetensors": [
        16777232,
        61141452,
        162517610,
        1790983259339176441,
        1790983259340068949
      ],
      "model-ple-0113.safetensors": [
        16777232,
        61141456,
        162517610,
        1790983265744837490,
        1790983265745586580
      ],
      "model-ple-0114.safetensors": [
        16777232,
        61141462,
        162517608,
        1790983271948410630,
        1790983271949375806
      ],
      "model-ple-0115.safetensors": [
        16777232,
        61141468,
        162517610,
        1790983277072728185,
        1790983277073646361
      ],
      "model-ple-0116.safetensors": [
        16777232,
        61141474,
        162517610,
        1790983281919413398,
        1790983281920340073
      ],
      "model-ple-0117.safetensors": [
        16777232,
        61141479,
        162517607,
        1790983287080135032,
        1790983287081064707
      ],
      "model-ple-0118.safetensors": [
        16777232,
        61141484,
        162517610,
        1790983292260776471,
        1790983292261697105
      ],
      "model-ple-0119.safetensors": [
        16777232,
        61141492,
        162517610,
        1790983298780979640,
        1790983298781872273
      ],
      "model-ple-0120.safetensors": [
        16777232,
        61141500,
        162517610,
        1790983303892181911,
        1790983303893137127
      ],
      "model-ple-0121.safetensors": [
        16777232,
        61141508,
        162517610,
        1790983308606338467,
        1790983308610440713
      ],
      "model-ple-0122.safetensors": [
        16777232,
        61141514,
        162517610,
        1790983313679208182,
        1790983313680128357
      ],
      "model-ple-0123.safetensors": [
        16777232,
        61141521,
        162517610,
        1790983318626470763,
        1790983318627401563
      ],
      "model-ple-0124.safetensors": [
        16777232,
        61141525,
        162517608,
        1790983324394582509,
        1790983324395549101
      ],
      "model-ple-0125.safetensors": [
        16777232,
        61141530,
        162517610,
        1790983329613341251,
        1790983329614258593
      ],
      "model-ple-0126.safetensors": [
        16777232,
        61141535,
        162517610,
        1790983334867535188,
        1790983334868484072
      ],
      "model-ple-0127.safetensors": [
        16777232,
        61141544,
        162517610,
        1790983340019529075,
        1790983340022576061
      ],
      "model-vision-graft.safetensors": [
        16777232,
        61141549,
        897899165,
        1790983365524919672,
        1790983365525846388
      ],
      "mtp-head-q6.safetensors": [
        16777232,
        61141567,
        2297560747,
        1790983429393243759,
        1790983429397524048
      ]
    },
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"
  },
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c",
      "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb",
      "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8",
      "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34",
      "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
      "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"
    },
    "packages": {
      "mlx": {
        "version": "0.32.2",
        "files": {
          "mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912",
          "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de",
          "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29",
          "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2",
          "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66",
          "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723",
          "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb",
          "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27",
          "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492",
          "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831",
          "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007",
          "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1",
          "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f",
          "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6",
          "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee",
          "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b",
          "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969",
          "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f",
          "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8",
          "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23",
          "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83",
          "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c",
          "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77",
          "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b",
          "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7",
          "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b",
          "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc",
          "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849",
          "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247",
          "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42",
          "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a",
          "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae",
          "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"
        }
      },
      "mlx-metal": {
        "version": "0.32.2",
        "files": {
          "mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a",
          "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084",
          "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8",
          "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
        }
      },
      "mlx-lm": {
        "version": "0.31.3",
        "files": {
          "mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608",
          "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834",
          "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c",
          "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553",
          "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8",
          "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7",
          "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7",
          "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5",
          "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a",
          "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1",
          "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39",
          "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f",
          "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b",
          "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7",
          "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5",
          "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9",
          "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72",
          "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5",
          "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82",
          "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f",
          "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb",
          "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d",
          "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7",
          "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373",
          "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5",
          "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8",
          "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750",
          "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a",
          "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610",
          "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70",
          "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66",
          "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095",
          "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d",
          "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9",
          "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7",
          "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91",
          "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db",
          "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1",
          "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914",
          "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e",
          "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96",
          "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1",
          "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c",
          "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251",
          "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a",
          "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38",
          "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6",
          "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8",
          "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f",
          "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2",
          "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2",
          "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05",
          "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643",
          "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e",
          "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec",
          "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9",
          "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd",
          "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443",
          "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba",
          "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af",
          "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19",
          "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332",
          "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197",
          "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db",
          "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f",
          "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19",
          "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d",
          "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd",
          "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305",
          "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d",
          "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0",
          "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8",
          "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c",
          "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395",
          "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca",
          "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb",
          "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c",
          "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8",
          "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f",
          "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8",
          "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4",
          "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf",
          "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7",
          "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd",
          "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13",
          "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306",
          "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145",
          "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca",
          "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d",
          "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c",
          "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057",
          "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4",
          "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855",
          "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae",
          "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f",
          "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e",
          "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9",
          "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393",
          "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90",
          "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1",
          "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4",
          "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b",
          "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9",
          "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5",
          "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e",
          "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd",
          "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28",
          "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b",
          "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582",
          "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e",
          "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391",
          "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306",
          "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41",
          "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639",
          "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a",
          "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619",
          "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005",
          "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79",
          "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e",
          "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9",
          "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc",
          "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a",
          "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e",
          "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832",
          "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179",
          "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125",
          "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a",
          "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a",
          "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a",
          "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169",
          "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2",
          "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427",
          "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a",
          "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa",
          "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa",
          "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a",
          "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020",
          "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e",
          "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58",
          "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67",
          "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b",
          "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19",
          "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a",
          "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc",
          "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c",
          "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66",
          "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1",
          "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206",
          "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531",
          "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f",
          "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0",
          "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d",
          "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25",
          "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3",
          "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3",
          "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17",
          "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10",
          "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45",
          "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375",
          "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe",
          "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553",
          "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d",
          "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"
        }
      },
      "numpy": {
        "version": "2.5.2",
        "files": {
          "numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b",
          "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11",
          "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972",
          "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a",
          "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2",
          "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6",
          "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb",
          "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2",
          "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926",
          "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881",
          "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a",
          "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0",
          "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476",
          "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee",
          "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af",
          "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627",
          "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b",
          "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c",
          "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78",
          "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950",
          "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d",
          "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5",
          "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66",
          "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2",
          "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2",
          "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395",
          "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf",
          "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605",
          "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5",
          "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106",
          "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c",
          "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49",
          "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417",
          "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8",
          "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca",
          "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807",
          "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b",
          "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e",
          "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332",
          "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3",
          "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957",
          "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2",
          "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0",
          "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81",
          "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a",
          "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea",
          "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d",
          "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159",
          "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582",
          "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af",
          "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c",
          "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2",
          "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d",
          "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224",
          "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec",
          "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a",
          "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489",
          "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67",
          "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a",
          "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143",
          "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a",
          "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31",
          "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d",
          "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847",
          "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f",
          "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f",
          "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b",
          "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0",
          "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf",
          "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477",
          "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2",
          "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650",
          "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1",
          "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd",
          "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a",
          "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4",
          "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc",
          "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41",
          "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111",
          "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008",
          "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d",
          "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a",
          "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19",
          "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068",
          "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72",
          "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01",
          "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c",
          "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c",
          "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099",
          "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0",
          "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a",
          "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761",
          "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca",
          "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e",
          "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6",
          "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc",
          "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8",
          "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446",
          "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe",
          "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc",
          "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9",
          "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca",
          "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288",
          "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76",
          "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0",
          "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4",
          "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76",
          "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669",
          "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808",
          "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987",
          "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a",
          "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f",
          "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36",
          "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2",
          "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b",
          "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b",
          "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605",
          "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002",
          "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b",
          "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33",
          "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8",
          "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1",
          "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7",
          "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1",
          "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284",
          "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c",
          "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24",
          "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5",
          "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e",
          "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310",
          "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf",
          "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9",
          "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9",
          "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c",
          "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a",
          "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27",
          "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c",
          "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275",
          "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436",
          "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5",
          "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714",
          "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550",
          "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df",
          "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822",
          "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93",
          "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92",
          "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b",
          "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2",
          "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930",
          "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca",
          "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c",
          "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf",
          "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07",
          "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306",
          "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf",
          "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5",
          "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142",
          "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406",
          "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a",
          "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795",
          "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab",
          "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c",
          "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c",
          "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8",
          "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537",
          "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e",
          "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74",
          "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec",
          "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0",
          "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7",
          "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a",
          "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0",
          "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d",
          "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822",
          "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8",
          "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137",
          "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37",
          "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3",
          "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576",
          "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681",
          "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b",
          "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529",
          "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491",
          "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6",
          "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873",
          "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4",
          "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4",
          "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281",
          "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547",
          "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0",
          "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09",
          "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f",
          "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d",
          "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4",
          "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7",
          "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc",
          "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3",
          "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9",
          "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e",
          "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e",
          "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82",
          "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f",
          "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7",
          "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e",
          "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36",
          "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6",
          "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d",
          "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026",
          "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777",
          "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386",
          "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb",
          "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599",
          "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07",
          "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa",
          "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b",
          "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f",
          "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0",
          "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72",
          "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b",
          "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f",
          "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d",
          "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b",
          "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d",
          "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e",
          "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131",
          "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4",
          "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0",
          "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460",
          "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771",
          "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116",
          "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd",
          "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e",
          "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48",
          "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb",
          "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5",
          "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545",
          "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc",
          "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec",
          "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862",
          "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb",
          "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939",
          "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea",
          "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195",
          "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435",
          "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0",
          "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292",
          "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b",
          "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074",
          "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6",
          "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4",
          "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874",
          "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792",
          "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202",
          "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292",
          "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c",
          "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc",
          "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f",
          "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b",
          "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c",
          "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79",
          "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4",
          "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a",
          "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af",
          "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324",
          "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46",
          "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780",
          "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed",
          "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab",
          "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c",
          "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5",
          "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e",
          "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74",
          "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4",
          "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f",
          "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98",
          "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004",
          "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3",
          "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c",
          "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca",
          "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2",
          "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f",
          "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d",
          "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c",
          "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781",
          "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953",
          "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e",
          "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5",
          "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828",
          "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417",
          "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425",
          "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11",
          "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2",
          "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642",
          "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6",
          "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5",
          "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718",
          "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16",
          "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782",
          "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c",
          "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5",
          "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9",
          "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53",
          "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709",
          "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4",
          "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47",
          "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca",
          "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917",
          "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8",
          "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f",
          "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2",
          "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824",
          "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d",
          "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3",
          "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396",
          "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25",
          "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af",
          "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d",
          "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6",
          "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033",
          "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418",
          "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84",
          "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352",
          "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99",
          "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228",
          "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca",
          "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82",
          "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78",
          "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b",
          "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9",
          "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0",
          "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5",
          "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801",
          "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c",
          "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc",
          "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b",
          "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b",
          "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3",
          "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639",
          "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e",
          "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0",
          "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5",
          "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945",
          "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b",
          "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f",
          "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45",
          "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931",
          "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3",
          "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c",
          "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213",
          "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5",
          "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9",
          "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2",
          "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4",
          "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13",
          "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e",
          "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37",
          "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557",
          "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc",
          "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9",
          "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363",
          "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a",
          "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5",
          "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32",
          "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498",
          "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049",
          "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7",
          "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4",
          "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0",
          "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc",
          "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166",
          "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682",
          "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482",
          "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a",
          "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e",
          "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196",
          "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed",
          "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a",
          "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723",
          "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14",
          "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5",
          "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2",
          "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392",
          "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759",
          "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee",
          "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe",
          "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd",
          "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe",
          "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0",
          "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c",
          "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4",
          "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94",
          "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147",
          "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1",
          "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c",
          "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665",
          "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b",
          "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02",
          "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff",
          "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67",
          "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94",
          "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0",
          "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0",
          "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509",
          "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda",
          "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0",
          "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1",
          "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796",
          "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3",
          "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5",
          "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14",
          "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297",
          "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54",
          "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"
        }
      }
    },
    "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]",
    "sha256": "0505bcc315797f8fb5772bc6693d82a3315d6365507cddc472073011faf089e2"
  },
  "producer_sha256": "7326ce8a7281739c171bc38218539a454704c3ed733f0c35a789cab4cdf836fb",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21810184192,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    45956.\nPages active:                                1107709.\nPages inactive:                              1124160.\nPages speculative:                             32344.\nPages throttled:                                   0.\nPages wired down:                             181371.\nPages purgeable:                                2547.\n\"Translation faults\":                     1060348623.\nPages copy-on-write:                        63676246.\nPages zero filled:                        1903390312.\nPages reactivated:                          92988813.\nPages purged:                               10732273.\nFile-backed pages:                           1282685.\nAnonymous pages:                              981528.\nPages stored in compressor:                  1082208.\nPages occupied by compressor:                 593669.\nDecompressions:                             22873274.\nCompressions:                               32334370.\nPageins:                                   525382894.\nPageouts:                                     327314.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 131504.\nPages tagged resident:                         95138.\nPages tagged compressed:                       36366.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5169.\nPages tag-storage free:                          175.\nPages tag-storage non-tag pageable:            92952.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5258944.\nTagged compressions:                          427117.\nTagged decompressions:                        355595.\n"
  },
  "source_fixture": {
    "path": "layer-2-pass-0.safetensors",
    "layer": 2,
    "step": 0,
    "bytes": 3268867,
    "sha256": "41f902b5def7478e089d7611f0284f13b0211f14cd960c7a94b5fc83577ed427",
    "keys": [
      "conv",
      "hidden",
      "state"
    ]
  },
  "expanded_equals_whole": true,
  "memory": {
    "current_bytes": 475907056,
    "lifetime_peak_bytes": 475907056,
    "rss_peak_bytes": 434683904
  },
  "fixture": {
    "path": "attention.safetensors",
    "bytes": 302034,
    "sha256": "7bb701dd6c4b1aa5c6a0eb542ce284ce250934238a675fe10fe54e55540e197a"
  },
  "qualification": "unproven"
}
````

### vq-attention-3.2-v1-supervision/identity.json

Original bytes: 2766. SHA-256: `2cd09ba4f718993c45b607b790e72536b4cf9ee605528485822dfaf079a1e47c`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_attention_reference.py",
    "--model",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--architecture",
    "<HOME>/Projects/slotstream/.build/quantization-research/qwen4_exp-pr1788.py",
    "--fixture",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-model-3.2-v1",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-attention-3.2-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21832433664,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    62444.\nPages active:                                1105824.\nPages inactive:                              1111350.\nPages speculative:                             30574.\nPages throttled:                                   0.\nPages wired down:                             181350.\nPages purgeable:                                2563.\n\"Translation faults\":                     1060342946.\nPages copy-on-write:                        63675522.\nPages zero filled:                        1903387999.\nPages reactivated:                          92988813.\nPages purged:                               10732273.\nFile-backed pages:                           1267539.\nAnonymous pages:                              980209.\nPages stored in compressor:                  1082208.\nPages occupied by compressor:                 593669.\nDecompressions:                             22873274.\nCompressions:                               32334370.\nPageins:                                   525369397.\nPageouts:                                     327314.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 131504.\nPages tagged resident:                         95138.\nPages tagged compressed:                       36366.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5169.\nPages tag-storage free:                          172.\nPages tag-storage non-tag pageable:            92955.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5258944.\nTagged compressions:                          427117.\nTagged decompressions:                        355595.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-attention-3.2-v1-supervision/receipt.json

Original bytes: 2130. SHA-256: `d6f0cb1d0cb550ed7dea0fa6c33f4b0fea5c39c0512cea17a46905d80301b32c`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 475923440,
  "samples": 497,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22349725696,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    37368.\nPages active:                                1092142.\nPages inactive:                              1170018.\nPages speculative:                              4961.\nPages throttled:                                   0.\nPages wired down:                             186953.\nPages purgeable:                                 130.\n\"Translation faults\":                     1060485164.\nPages copy-on-write:                        63683469.\nPages zero filled:                        1903514891.\nPages reactivated:                          92997990.\nPages purged:                               10736592.\nFile-backed pages:                           1326621.\nAnonymous pages:                              940500.\nPages stored in compressor:                  1082581.\nPages occupied by compressor:                 593791.\nDecompressions:                             22873291.\nCompressions:                               32334788.\nPageins:                                   529499215.\nPageouts:                                     327465.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 129788.\nPages tagged resident:                         93316.\nPages tagged compressed:                       36472.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          189.\nPages tag-storage non-tag pageable:            92945.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5265408.\nTagged compressions:                          427223.\nTagged decompressions:                        355595.\n"
  },
  "seconds": 29.295899958
}
````

### vq-attention-3.2-v1-supervision/stdout.txt

Original bytes: 88658. SHA-256: `6b50c730feaac760190db3992378722ee162b88c1cf755337b3077de215daa05`.

````text
{"verified": "model-00001.safetensors"}
{"verified": "model-00012.safetensors"}
{"verified": "model-00013.safetensors"}
{"verified": "model-00014.safetensors"}
{"verified": "model-00015.safetensors"}
{"verified": "model-00016.safetensors"}
{"verified": "model-00017.safetensors"}
{"verified": "model-00018.safetensors"}
{"verified": "model-00019.safetensors"}
{"verified": "model-ple-0000.safetensors"}
{"verified": "model-ple-0001.safetensors"}
{"verified": "model-ple-0002.safetensors"}
{"verified": "model-ple-0003.safetensors"}
{"verified": "model-ple-0004.safetensors"}
{"verified": "model-ple-0005.safetensors"}
{"verified": "model-ple-0006.safetensors"}
{"verified": "model-ple-0007.safetensors"}
{"verified": "model-ple-0008.safetensors"}
{"verified": "model-ple-0009.safetensors"}
{"verified": "model-ple-0010.safetensors"}
{"verified": "model-ple-0011.safetensors"}
{"verified": "model-ple-0012.safetensors"}
{"verified": "model-ple-0013.safetensors"}
{"verified": "model-ple-0014.safetensors"}
{"verified": "model-ple-0015.safetensors"}
{"verified": "model-ple-0016.safetensors"}
{"verified": "model-ple-0017.safetensors"}
{"verified": "model-ple-0018.safetensors"}
{"verified": "model-ple-0019.safetensors"}
{"verified": "model-ple-0020.safetensors"}
{"verified": "model-ple-0021.safetensors"}
{"verified": "model-ple-0022.safetensors"}
{"verified": "model-ple-0023.safetensors"}
{"verified": "model-ple-0024.safetensors"}
{"verified": "model-ple-0025.safetensors"}
{"verified": "model-ple-0026.safetensors"}
{"verified": "model-ple-0027.safetensors"}
{"verified": "model-ple-0028.safetensors"}
{"verified": "model-ple-0029.safetensors"}
{"verified": "model-ple-0030.safetensors"}
{"verified": "model-ple-0031.safetensors"}
{"verified": "model-ple-0032.safetensors"}
{"verified": "model-ple-0033.safetensors"}
{"verified": "model-ple-0034.safetensors"}
{"verified": "model-ple-0035.safetensors"}
{"verified": "model-ple-0036.safetensors"}
{"verified": "model-ple-0037.safetensors"}
{"verified": "model-ple-0038.safetensors"}
{"verified": "model-ple-0039.safetensors"}
{"verified": "model-ple-0040.safetensors"}
{"verified": "model-ple-0041.safetensors"}
{"verified": "model-ple-0042.safetensors"}
{"verified": "model-ple-0043.safetensors"}
{"verified": "model-ple-0044.safetensors"}
{"verified": "model-ple-0045.safetensors"}
{"verified": "model-ple-0046.safetensors"}
{"verified": "model-ple-0047.safetensors"}
{"verified": "model-ple-0048.safetensors"}
{"verified": "model-ple-0049.safetensors"}
{"verified": "model-ple-0050.safetensors"}
{"verified": "model-ple-0051.safetensors"}
{"verified": "model-ple-0052.safetensors"}
{"verified": "model-ple-0053.safetensors"}
{"verified": "model-ple-0054.safetensors"}
{"verified": "model-ple-0055.safetensors"}
{"verified": "model-ple-0056.safetensors"}
{"verified": "model-ple-0057.safetensors"}
{"verified": "model-ple-0058.safetensors"}
{"verified": "model-ple-0059.safetensors"}
{"verified": "model-ple-0060.safetensors"}
{"verified": "model-ple-0061.safetensors"}
{"verified": "model-ple-0062.safetensors"}
{"verified": "model-ple-0063.safetensors"}
{"verified": "model-ple-0064.safetensors"}
{"verified": "model-ple-0065.safetensors"}
{"verified": "model-ple-0066.safetensors"}
{"verified": "model-ple-0067.safetensors"}
{"verified": "model-ple-0068.safetensors"}
{"verified": "model-ple-0069.safetensors"}
{"verified": "model-ple-0070.safetensors"}
{"verified": "model-ple-0071.safetensors"}
{"verified": "model-ple-0072.safetensors"}
{"verified": "model-ple-0073.safetensors"}
{"verified": "model-ple-0074.safetensors"}
{"verified": "model-ple-0075.safetensors"}
{"verified": "model-ple-0076.safetensors"}
{"verified": "model-ple-0077.safetensors"}
{"verified": "model-ple-0078.safetensors"}
{"verified": "model-ple-0079.safetensors"}
{"verified": "model-ple-0080.safetensors"}
{"verified": "model-ple-0081.safetensors"}
{"verified": "model-ple-0082.safetensors"}
{"verified": "model-ple-0083.safetensors"}
{"verified": "model-ple-0084.safetensors"}
{"verified": "model-ple-0085.safetensors"}
{"verified": "model-ple-0086.safetensors"}
{"verified": "model-ple-0087.safetensors"}
{"verified": "model-ple-0088.safetensors"}
{"verified": "model-ple-0089.safetensors"}
{"verified": "model-ple-0090.safetensors"}
{"verified": "model-ple-0091.safetensors"}
{"verified": "model-ple-0092.safetensors"}
{"verified": "model-ple-0093.safetensors"}
{"verified": "model-ple-0094.safetensors"}
{"verified": "model-ple-0095.safetensors"}
{"verified": "model-ple-0096.safetensors"}
{"verified": "model-ple-0097.safetensors"}
{"verified": "model-ple-0098.safetensors"}
{"verified": "model-ple-0099.safetensors"}
{"verified": "model-ple-0100.safetensors"}
{"verified": "model-ple-0101.safetensors"}
{"verified": "model-ple-0102.safetensors"}
{"verified": "model-ple-0103.safetensors"}
{"verified": "model-ple-0104.safetensors"}
{"verified": "model-ple-0105.safetensors"}
{"verified": "model-ple-0106.safetensors"}
{"verified": "model-ple-0107.safetensors"}
{"verified": "model-ple-0108.safetensors"}
{"verified": "model-ple-0109.safetensors"}
{"verified": "model-ple-0110.safetensors"}
{"verified": "model-ple-0111.safetensors"}
{"verified": "model-ple-0112.safetensors"}
{"verified": "model-ple-0113.safetensors"}
{"verified": "model-ple-0114.safetensors"}
{"verified": "model-ple-0115.safetensors"}
{"verified": "model-ple-0116.safetensors"}
{"verified": "model-ple-0117.safetensors"}
{"verified": "model-ple-0118.safetensors"}
{"verified": "model-ple-0119.safetensors"}
{"verified": "model-ple-0120.safetensors"}
{"verified": "model-ple-0121.safetensors"}
{"verified": "model-ple-0122.safetensors"}
{"verified": "model-ple-0123.safetensors"}
{"verified": "model-ple-0124.safetensors"}
{"verified": "model-ple-0125.safetensors"}
{"verified": "model-ple-0126.safetensors"}
{"verified": "model-ple-0127.safetensors"}
{"verified": "model-vision-graft.safetensors"}
{"verified": "mtp-head-q6.safetensors"}
{"schema": 1, "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87", "normalization": "vq-raw-zero-centered-to-pr1788-folded-bf16-v1", "artifact": {"verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e", "stamps": {"model-00001.safetensors": [16777232, 61124837, 3502305114, 1790981216969651631, 1790981216973805883], "model-00012.safetensors": [16777232, 61124923, 6258175824, 1790981377005612627, 1790981377009206956], "model-00013.safetensors": [16777232, 61125010, 6471407889, 1790981545033604036, 1790981545036494899], "model-00014.safetensors": [16777232, 61125132, 6547978262, 1790981736942738954, 1790981736944883976], "model-00015.safetensors": [16777232, 61125286, 6471407935, 1790981924339816693, 1790981924342464654], "model-00016.safetensors": [16777232, 61125510, 6857620951, 1790982119683472302, 1790982119685710216], "model-00017.safetensors": [16777232, 61129776, 6679034951, 1790982305666734292, 1790982305672913817], "model-00018.safetensors": [16777232, 61136554, 6733521211, 1790982515929442647, 1790982515931575685], "model-00019.safetensors": [16777232, 61136710, 3457093298, 1790982619932592777, 1790982619933742130], "model-ple-0000.safetensors": [16777232, 61140250, 162517607, 1790982627138573871, 1790982627139487012], "model-ple-0001.safetensors": [16777232, 61140257, 162517605, 1790982633555677032, 1790982633556582756], "model-ple-0002.safetensors": [16777232, 61140267, 162517610, 1790982639202217456, 1790982639203120347], "model-ple-0003.safetensors": [16777232, 61140272, 162517613, 1790982645069140209, 1790982645069823054], "model-ple-0004.safetensors": [16777232, 61140283, 162517613, 1790982650945947009, 1790982650946871359], "model-ple-0005.safetensors": [16777232, 61140293, 162517611, 1790982657117788365, 1790982657118728631], "model-ple-0006.safetensors": [16777232, 61140299, 162517611, 1790982663412388541, 1790982663413293974], "model-ple-0007.safetensors": [16777232, 61140312, 162517611, 1790982669152254855, 1790982669153205538], "model-ple-0008.safetensors": [16777232, 61140320, 162517613, 1790982674022126144, 1790982674023049244], "model-ple-0009.safetensors": [16777232, 61140331, 162517613, 1790982678928236736, 1790982678929079667], "model-ple-0010.safetensors": [16777232, 61140335, 162517613, 1790982683656085531, 1790982683656969339], "model-ple-0011.safetensors": [16777232, 61140341, 162517613, 1790982688473524025, 1790982688474332997], "model-ple-0012.safetensors": [16777232, 61140355, 162517613, 1790982693458602253, 1790982693459500144], "model-ple-0013.safetensors": [16777232, 61140371, 162517610, 1790982698170087804, 1790982698170988778], "model-ple-0014.safetensors": [16777232, 61140391, 162517613, 1790982703332828567, 1790982703333775500], "model-ple-0015.safetensors": [16777232, 61140399, 162517613, 1790982708259744691, 1790982708261148174], "model-ple-0016.safetensors": [16777232, 61140409, 162517613, 1790982713943583771, 1790982713944535246], "model-ple-0017.safetensors": [16777232, 61140416, 162517613, 1790982719388327528, 1790982719389255419], "model-ple-0018.safetensors": [16777232, 61140420, 162517611, 1790982725402636950, 1790982725403550133], "model-ple-0019.safetensors": [16777232, 61140425, 162517613, 1790982731256203385, 1790982731257126901], "model-ple-0020.safetensors": [16777232, 61140432, 162517611, 1790982738071856793, 1790982738076684212], "model-ple-0021.safetensors": [16777232, 61140437, 162517611, 1790982744489047206, 1790982744489882637], "model-ple-0022.safetensors": [16777232, 61140441, 162517613, 1790982750186433982, 1790982750187391749], "model-ple-0023.safetensors": [16777232, 61140448, 162517613, 1790982756483893209, 1790982756484835975], "model-ple-0024.safetensors": [16777232, 61140462, 162517610, 1790982762487478610, 1790982762488429168], "model-ple-0025.safetensors": [16777232, 61140474, 162517613, 1790982768446695857, 1790982768447609374], "model-ple-0026.safetensors": [16777232, 61140482, 162517611, 1790982774682704006, 1790982774683668940], "model-ple-0027.safetensors": [16777232, 61140487, 162517613, 1790982780054403106, 1790982780055155744], "model-ple-0028.safetensors": [16777232, 61140492, 162517611, 1790982786131927514, 1790982786133070409], "model-ple-0029.safetensors": [16777232, 61140498, 162517613, 1790982791720789884, 1790982791721679899], "model-ple-0030.safetensors": [16777232, 61140507, 162517613, 1790982797363790787, 1790982797364736846], "model-ple-0031.safetensors": [16777232, 61140513, 162517611, 1790982802855896085, 1790982802856819934], "model-ple-0032.safetensors": [16777232, 61140518, 162517613, 1790982807785930346, 1790982807786920405], "model-ple-0033.safetensors": [16777232, 61140523, 162517610, 1790982812651563228, 1790982812652470660], "model-ple-0034.safetensors": [16777232, 61140532, 162517610, 1790982817300943895, 1790982817301852203], "model-ple-0035.safetensors": [16777232, 61140541, 162517610, 1790982821915884168, 1790982821916815851], "model-ple-0036.safetensors": [16777232, 61140548, 162517610, 1790982826932480491, 1790982826933326089], "model-ple-0037.safetensors": [16777232, 61140558, 162517608, 1790982832539544681, 1790982832540443571], "model-ple-0038.safetensors": [16777232, 61140562, 162517608, 1790982838522902935, 1790982838523814159], "model-ple-0039.safetensors": [16777232, 61140567, 162517610, 1790982843582402768, 1790982843583243134], "model-ple-0040.safetensors": [16777232, 61140573, 162517607, 1790982848339011099, 1790982848339968272], "model-ple-0041.safetensors": [16777232, 61140580, 162517610, 1790982853469781697, 1790982853470684511], "model-ple-0042.safetensors": [16777232, 61140585, 162517610, 1790982858244013692, 1790982858244908195], "model-ple-0043.safetensors": [16777232, 61140590, 162517610, 1790982864003203242, 1790982864003554394], "model-ple-0044.safetensors": [16777232, 61140723, 162517610, 1790982869607285689, 1790982869607623044], "model-ple-0045.safetensors": [16777232, 61140727, 162517610, 1790982874968029129, 1790982874968458830], "model-ple-0046.safetensors": [16777232, 61140733, 162517610, 1790982880349184866, 1790982880349581326], "model-ple-0047.safetensors": [16777232, 61140740, 162517610, 1790982885705681830, 1790982885706026572], "model-ple-0048.safetensors": [16777232, 61140754, 162517610, 1790982891521923333, 1790982891522300880], "model-ple-0049.safetensors": [16777232, 61140765, 162517610, 1790982897650766513, 1790982897651168488], "model-ple-0050.safetensors": [16777232, 61140771, 162517610, 1790982902965919941, 1790982902966278301], "model-ple-0051.safetensors": [16777232, 61140786, 162517607, 1790982908425811945, 1790982908426161103], "model-ple-0052.safetensors": [16777232, 61140797, 162517610, 1790982913785471096, 1790982913785813799], "model-ple-0053.safetensors": [16777232, 61140810, 162517610, 1790982919733610844, 1790982919734091924], "model-ple-0054.safetensors": [16777232, 61140815, 162517610, 1790982925452621410, 1790982925452965243], "model-ple-0055.safetensors": [16777232, 61140822, 162517608, 1790982932055042996, 1790982932055373372], "model-ple-0056.safetensors": [16777232, 61140834, 162517610, 1790982936821992693, 1790982936822328986], "model-ple-0057.safetensors": [16777232, 61140853, 162517610, 1790982941795208562, 1790982941795727564], "model-ple-0058.safetensors": [16777232, 61140865, 162517610, 1790982946659199029, 1790982946659690490], "model-ple-0059.safetensors": [16777232, 61140875, 162517608, 1790982951976555530, 1790982951976913741], "model-ple-0060.safetensors": [16777232, 61140902, 162517610, 1790982956943755943, 1790982956944108612], "model-ple-0061.safetensors": [16777232, 61140920, 162517608, 1790982962665866982, 1790982962666720072], "model-ple-0062.safetensors": [16777232, 61140930, 162517607, 1790982967600947912, 1790982967601780793], "model-ple-0063.safetensors": [16777232, 61140936, 162517610, 1790982973501324444, 1790982973502267410], "model-ple-0064.safetensors": [16777232, 61140943, 162517610, 1790982979530596195, 1790982979531817747], "model-ple-0065.safetensors": [16777232, 61140947, 162517610, 1790982985158304116, 1790982985159197707], "model-ple-0066.safetensors": [16777232, 61140953, 162517610, 1790982990898086726, 1790982990899063943], "model-ple-0067.safetensors": [16777232, 61140961, 162517610, 1790982996401559646, 1790982996402469196], "model-ple-0068.safetensors": [16777232, 61140966, 162517610, 1790983001756097601, 1790983001756707940], "model-ple-0069.safetensors": [16777232, 61140971, 162517610, 1790983007637603657, 1790983007638662583], "model-ple-0070.safetensors": [16777232, 61140981, 162517610, 1790983013286585629, 1790983013287401512], "model-ple-0071.safetensors": [16777232, 61140991, 162517610, 1790983018661604180, 1790983018662524313], "model-ple-0072.safetensors": [16777232, 61140996, 162517608, 1790983025820209701, 1790983025820855165], "model-ple-0073.safetensors": [16777232, 61141003, 162517607, 1790983031268771311, 1790983031269542818], "model-ple-0074.safetensors": [16777232, 61141007, 162517610, 1790983036991725465, 1790983036992614640], "model-ple-0075.safetensors": [16777232, 61141012, 162517608, 1790983043613793342, 1790983043614438681], "model-ple-0076.safetensors": [16777232, 61141018, 162517610, 1790983049313185610, 1790983049313857116], "model-ple-0077.safetensors": [16777232, 61141023, 162517610, 1790983055161970608, 1790983055162864367], "model-ple-0078.safetensors": [16777232, 61141032, 162517610, 1790983061167775992, 1790983061168481748], "model-ple-0079.safetensors": [16777232, 61141036, 162517610, 1790983067037600567, 1790983067038473950], "model-ple-0080.safetensors": [16777232, 61141049, 162517610, 1790983072453387751, 1790983072454284801], "model-ple-0081.safetensors": [16777232, 61141056, 162517610, 1790983078283342764, 1790983078284280980], "model-ple-0082.safetensors": [16777232, 61141060, 162517610, 1790983084482326237, 1790983084483212704], "model-ple-0083.safetensors": [16777232, 61141066, 162517610, 1790983089959112142, 1790983089959804899], "model-ple-0084.safetensors": [16777232, 61141082, 162517607, 1790983095473290968, 1790983095474232352], "model-ple-0085.safetensors": [16777232, 61141108, 162517610, 1790983101378794539, 1790983101379764131], "model-ple-0086.safetensors": [16777232, 61141148, 162517610, 1790983107460704078, 1790983107461626962], "model-ple-0087.safetensors": [16777232, 61141156, 162517610, 1790983113584810374, 1790983113585582464], "model-ple-0088.safetensors": [16777232, 61141169, 162517610, 1790983119099203121, 1790983119100094587], "model-ple-0089.safetensors": [16777232, 61141174, 162517608, 1790983124882360253, 1790983124883316345], "model-ple-0090.safetensors": [16777232, 61141184, 162517610, 1790983129724665676, 1790983129728605211], "model-ple-0091.safetensors": [16777232, 61141201, 162517610, 1790983134421494909, 1790983134422479168], "model-ple-0092.safetensors": [16777232, 61141209, 162517608, 1790983140041034022, 1790983140041975030], "model-ple-0093.safetensors": [16777232, 61141216, 162517610, 1790983144777734031, 1790983144778600997], "model-ple-0094.safetensors": [16777232, 61141241, 162517610, 1790983149994926383, 1790983149995738224], "model-ple-0095.safetensors": [16777232, 61141276, 162517607, 1790983154752645124, 1790983154753430965], "model-ple-0096.safetensors": [16777232, 61141310, 162517610, 1790983159970819319, 1790983159971858203], "model-ple-0097.safetensors": [16777232, 61141318, 162517610, 1790983164974114237, 1790983164975063121], "model-ple-0098.safetensors": [16777232, 61141323, 162517610, 1790983170565673096, 1790983170566609646], "model-ple-0099.safetensors": [16777232, 61141341, 162517610, 1790983176718977574, 1790983176719852457], "model-ple-0100.safetensors": [16777232, 61141350, 162517610, 1790983182892329693, 1790983182892738405], "model-ple-0101.safetensors": [16777232, 61141372, 162517608, 1790983190065519468, 1790983190066574978], "model-ple-0102.safetensors": [16777232, 61141385, 162517610, 1790983196095511208, 1790983196096427549], "model-ple-0103.safetensors": [16777232, 61141390, 162517610, 1790983202080614873, 1790983202081544381], "model-ple-0104.safetensors": [16777232, 61141399, 162517610, 1790983208182737513, 1790983208183661313], "model-ple-0105.safetensors": [16777232, 61141403, 162517608, 1790983215042826794, 1790983215043752094], "model-ple-0106.safetensors": [16777232, 61141409, 162517607, 1790983221162356590, 1790983221163275015], "model-ple-0107.safetensors": [16777232, 61141416, 162517610, 1790983227340430125, 1790983227341199799], "model-ple-0108.safetensors": [16777232, 61141423, 162517610, 1790983233417963378, 1790983233418918095], "model-ple-0109.safetensors": [16777232, 61141427, 162517610, 1790983240053641506, 1790983240054479847], "model-ple-0110.safetensors": [16777232, 61141434, 162517610, 1790983246089577132, 1790983246090531974], "model-ple-0111.safetensors": [16777232, 61141445, 162517608, 1790983252879031941, 1790983252879968574], "model-ple-0112.safetensors": [16777232, 61141452, 162517610, 1790983259339176441, 1790983259340068949], "model-ple-0113.safetensors": [16777232, 61141456, 162517610, 1790983265744837490, 1790983265745586580], "model-ple-0114.safetensors": [16777232, 61141462, 162517608, 1790983271948410630, 1790983271949375806], "model-ple-0115.safetensors": [16777232, 61141468, 162517610, 1790983277072728185, 1790983277073646361], "model-ple-0116.safetensors": [16777232, 61141474, 162517610, 1790983281919413398, 1790983281920340073], "model-ple-0117.safetensors": [16777232, 61141479, 162517607, 1790983287080135032, 1790983287081064707], "model-ple-0118.safetensors": [16777232, 61141484, 162517610, 1790983292260776471, 1790983292261697105], "model-ple-0119.safetensors": [16777232, 61141492, 162517610, 1790983298780979640, 1790983298781872273], "model-ple-0120.safetensors": [16777232, 61141500, 162517610, 1790983303892181911, 1790983303893137127], "model-ple-0121.safetensors": [16777232, 61141508, 162517610, 1790983308606338467, 1790983308610440713], "model-ple-0122.safetensors": [16777232, 61141514, 162517610, 1790983313679208182, 1790983313680128357], "model-ple-0123.safetensors": [16777232, 61141521, 162517610, 1790983318626470763, 1790983318627401563], "model-ple-0124.safetensors": [16777232, 61141525, 162517608, 1790983324394582509, 1790983324395549101], "model-ple-0125.safetensors": [16777232, 61141530, 162517610, 1790983329613341251, 1790983329614258593], "model-ple-0126.safetensors": [16777232, 61141535, 162517610, 1790983334867535188, 1790983334868484072], "model-ple-0127.safetensors": [16777232, 61141544, 162517610, 1790983340019529075, 1790983340022576061], "model-vision-graft.safetensors": [16777232, 61141549, 897899165, 1790983365524919672, 1790983365525846388], "mtp-head-q6.safetensors": [16777232, 61141567, 2297560747, 1790983429393243759, 1790983429397524048]}, "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"}, "instrument": {"scripts": {"vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec", "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e", "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749", "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c", "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb", "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8", "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34", "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472", "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"}, "packages": {"mlx": {"version": "0.32.2", "files": {"mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912", "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de", "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29", "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2", "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66", "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723", "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb", "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27", "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492", "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831", "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007", "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1", "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f", "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6", "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee", "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b", "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969", "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f", "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8", "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23", "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83", "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c", "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77", "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b", "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7", "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b", "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc", "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849", "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247", "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42", "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a", "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae", "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"}}, "mlx-metal": {"version": "0.32.2", "files": {"mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a", "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084", "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8", "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"}}, "mlx-lm": {"version": "0.31.3", "files": {"mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608", "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834", "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c", "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553", "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8", "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7", "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7", "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5", "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a", "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1", "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39", "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f", "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b", "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7", "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5", "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9", "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72", "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5", "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82", "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f", "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb", "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d", "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7", "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373", "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5", "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8", "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750", "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a", "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610", "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70", "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66", "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095", "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d", "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9", "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7", "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91", "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db", "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1", "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914", "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e", "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96", "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1", "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c", "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251", "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a", "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38", "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6", "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8", "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f", "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2", "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2", "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05", "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643", "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e", "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec", "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9", "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd", "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443", "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba", "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af", "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19", "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332", "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197", "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db", "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f", "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19", "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d", "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd", "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305", "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d", "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0", "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8", "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c", "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395", "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca", "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb", "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c", "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8", "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f", "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8", "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4", "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf", "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7", "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd", "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13", "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306", "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145", "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca", "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d", "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c", "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057", "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4", "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855", "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae", "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f", "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e", "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9", "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393", "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90", "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1", "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4", "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b", "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9", "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5", "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e", "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd", "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28", "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b", "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582", "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e", "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391", "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306", "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41", "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639", "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a", "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619", "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005", "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79", "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e", "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9", "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc", "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a", "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e", "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832", "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179", "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125", "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a", "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a", "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a", "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169", "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2", "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427", "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a", "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa", "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa", "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a", "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020", "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e", "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58", "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67", "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b", "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19", "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a", "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc", "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c", "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66", "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1", "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206", "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531", "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f", "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0", "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d", "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25", "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3", "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3", "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17", "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10", "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45", "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375", "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe", "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553", "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d", "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"}}, "numpy": {"version": "2.5.2", "files": {"numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b", "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11", "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972", "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a", "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2", "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6", "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb", "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2", "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926", "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881", "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a", "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0", "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476", "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee", "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af", "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627", "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b", "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c", "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78", "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950", "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d", "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5", "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66", "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2", "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2", "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395", "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf", "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605", "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5", "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106", "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c", "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49", "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417", "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8", "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca", "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807", "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b", "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e", "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332", "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3", "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957", "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2", "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0", "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81", "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a", "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea", "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d", "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159", "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582", "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af", "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c", "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2", "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d", "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224", "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec", "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a", "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489", "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67", "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a", "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143", "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a", "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31", "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d", "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847", "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f", "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f", "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b", "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0", "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf", "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477", "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2", "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650", "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1", "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd", "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a", "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4", "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc", "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41", "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111", "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008", "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d", "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a", "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19", "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068", "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72", "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01", "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c", "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c", "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099", "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0", "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a", "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761", "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca", "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e", "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6", "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc", "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8", "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446", "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe", "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc", "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9", "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca", "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288", "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76", "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0", "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4", "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76", "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669", "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808", "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987", "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a", "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f", "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36", "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2", "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b", "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605", "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002", "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b", "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33", "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8", "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1", "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7", "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1", "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284", "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c", "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24", "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5", "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e", "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310", "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf", "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9", "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9", "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c", "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a", "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27", "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c", "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275", "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436", "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5", "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714", "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550", "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df", "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822", "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93", "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92", "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b", "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2", "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930", "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca", "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c", "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf", "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07", "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306", "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf", "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5", "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142", "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406", "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a", "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795", "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab", "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c", "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c", "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8", "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537", "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e", "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74", "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec", "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0", "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7", "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a", "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0", "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d", "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822", "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8", "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137", "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37", "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3", "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576", "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681", "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529", "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491", "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6", "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873", "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4", "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4", "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281", "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547", "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0", "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09", "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f", "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d", "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4", "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7", "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc", "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3", "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9", "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e", "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e", "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82", "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f", "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7", "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e", "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36", "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6", "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d", "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026", "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777", "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386", "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb", "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599", "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07", "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa", "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b", "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f", "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0", "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72", "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b", "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f", "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d", "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b", "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d", "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e", "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131", "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4", "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0", "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460", "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771", "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116", "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd", "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e", "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48", "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb", "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5", "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545", "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc", "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec", "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862", "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb", "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939", "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea", "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195", "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435", "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0", "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292", "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b", "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074", "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6", "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4", "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874", "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792", "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202", "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292", "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c", "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc", "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f", "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b", "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c", "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79", "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4", "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a", "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af", "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324", "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46", "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780", "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed", "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab", "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c", "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5", "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e", "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74", "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4", "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f", "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98", "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004", "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3", "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c", "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca", "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2", "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f", "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d", "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c", "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781", "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953", "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e", "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5", "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828", "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417", "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425", "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11", "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2", "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642", "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6", "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5", "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718", "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16", "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782", "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c", "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5", "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9", "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53", "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709", "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4", "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47", "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca", "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917", "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8", "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f", "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2", "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824", "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d", "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3", "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396", "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25", "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af", "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d", "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6", "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033", "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418", "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84", "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352", "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99", "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228", "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca", "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82", "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78", "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b", "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9", "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0", "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5", "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801", "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c", "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc", "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b", "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b", "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3", "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639", "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e", "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0", "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5", "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945", "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b", "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f", "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45", "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931", "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3", "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c", "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213", "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5", "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9", "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2", "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4", "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13", "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e", "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37", "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557", "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc", "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9", "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363", "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a", "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5", "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32", "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498", "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049", "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7", "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4", "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0", "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc", "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166", "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682", "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482", "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a", "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e", "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196", "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed", "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a", "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723", "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14", "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5", "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2", "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392", "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759", "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee", "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe", "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd", "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe", "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0", "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c", "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4", "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94", "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147", "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1", "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c", "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665", "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b", "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02", "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff", "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67", "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94", "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0", "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0", "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509", "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda", "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0", "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1", "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796", "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3", "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5", "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14", "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297", "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54", "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"}}}, "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]", "sha256": "0505bcc315797f8fb5772bc6693d82a3315d6365507cddc472073011faf089e2"}, "producer_sha256": "7326ce8a7281739c171bc38218539a454704c3ed733f0c35a789cab4cdf836fb", "before": {"page_bytes": 16384, "reclaimable_bytes": 21810184192, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    45956.\nPages active:                                1107709.\nPages inactive:                              1124160.\nPages speculative:                             32344.\nPages throttled:                                   0.\nPages wired down:                             181371.\nPages purgeable:                                2547.\n\"Translation faults\":                     1060348623.\nPages copy-on-write:                        63676246.\nPages zero filled:                        1903390312.\nPages reactivated:                          92988813.\nPages purged:                               10732273.\nFile-backed pages:                           1282685.\nAnonymous pages:                              981528.\nPages stored in compressor:                  1082208.\nPages occupied by compressor:                 593669.\nDecompressions:                             22873274.\nCompressions:                               32334370.\nPageins:                                   525382894.\nPageouts:                                     327314.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 131504.\nPages tagged resident:                         95138.\nPages tagged compressed:                       36366.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5169.\nPages tag-storage free:                          175.\nPages tag-storage non-tag pageable:            92952.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5258944.\nTagged compressions:                          427117.\nTagged decompressions:                        355595.\n"}, "source_fixture": {"path": "layer-2-pass-0.safetensors", "layer": 2, "step": 0, "bytes": 3268867, "sha256": "41f902b5def7478e089d7611f0284f13b0211f14cd960c7a94b5fc83577ed427", "keys": ["conv", "hidden", "state"]}, "expanded_equals_whole": true, "memory": {"current_bytes": 475907056, "lifetime_peak_bytes": 475907056, "rss_peak_bytes": 434683904}, "fixture": {"path": "attention.safetensors", "bytes": 302034, "sha256": "7bb701dd6c4b1aa5c6a0eb542ce284ce250934238a675fe10fe54e55540e197a"}, "qualification": "unproven"}
````

### vq-attention-3.2-v1-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-attention-3.2-v2/attention.json

Original bytes: 96905. SHA-256: `ab7d4f7b37d9ba9486a6b9812543ef14419508ed433ce698e47779b2aafdc515`.

````text
{
  "schema": 1,
  "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "normalization": "vq-raw-zero-centered-to-pr1788-folded-bf16-v1",
  "artifact": {
    "verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e",
    "stamps": {
      "model-00001.safetensors": [
        16777232,
        61124837,
        3502305114,
        1790981216969651631,
        1790981216973805883
      ],
      "model-00012.safetensors": [
        16777232,
        61124923,
        6258175824,
        1790981377005612627,
        1790981377009206956
      ],
      "model-00013.safetensors": [
        16777232,
        61125010,
        6471407889,
        1790981545033604036,
        1790981545036494899
      ],
      "model-00014.safetensors": [
        16777232,
        61125132,
        6547978262,
        1790981736942738954,
        1790981736944883976
      ],
      "model-00015.safetensors": [
        16777232,
        61125286,
        6471407935,
        1790981924339816693,
        1790981924342464654
      ],
      "model-00016.safetensors": [
        16777232,
        61125510,
        6857620951,
        1790982119683472302,
        1790982119685710216
      ],
      "model-00017.safetensors": [
        16777232,
        61129776,
        6679034951,
        1790982305666734292,
        1790982305672913817
      ],
      "model-00018.safetensors": [
        16777232,
        61136554,
        6733521211,
        1790982515929442647,
        1790982515931575685
      ],
      "model-00019.safetensors": [
        16777232,
        61136710,
        3457093298,
        1790982619932592777,
        1790982619933742130
      ],
      "model-ple-0000.safetensors": [
        16777232,
        61140250,
        162517607,
        1790982627138573871,
        1790982627139487012
      ],
      "model-ple-0001.safetensors": [
        16777232,
        61140257,
        162517605,
        1790982633555677032,
        1790982633556582756
      ],
      "model-ple-0002.safetensors": [
        16777232,
        61140267,
        162517610,
        1790982639202217456,
        1790982639203120347
      ],
      "model-ple-0003.safetensors": [
        16777232,
        61140272,
        162517613,
        1790982645069140209,
        1790982645069823054
      ],
      "model-ple-0004.safetensors": [
        16777232,
        61140283,
        162517613,
        1790982650945947009,
        1790982650946871359
      ],
      "model-ple-0005.safetensors": [
        16777232,
        61140293,
        162517611,
        1790982657117788365,
        1790982657118728631
      ],
      "model-ple-0006.safetensors": [
        16777232,
        61140299,
        162517611,
        1790982663412388541,
        1790982663413293974
      ],
      "model-ple-0007.safetensors": [
        16777232,
        61140312,
        162517611,
        1790982669152254855,
        1790982669153205538
      ],
      "model-ple-0008.safetensors": [
        16777232,
        61140320,
        162517613,
        1790982674022126144,
        1790982674023049244
      ],
      "model-ple-0009.safetensors": [
        16777232,
        61140331,
        162517613,
        1790982678928236736,
        1790982678929079667
      ],
      "model-ple-0010.safetensors": [
        16777232,
        61140335,
        162517613,
        1790982683656085531,
        1790982683656969339
      ],
      "model-ple-0011.safetensors": [
        16777232,
        61140341,
        162517613,
        1790982688473524025,
        1790982688474332997
      ],
      "model-ple-0012.safetensors": [
        16777232,
        61140355,
        162517613,
        1790982693458602253,
        1790982693459500144
      ],
      "model-ple-0013.safetensors": [
        16777232,
        61140371,
        162517610,
        1790982698170087804,
        1790982698170988778
      ],
      "model-ple-0014.safetensors": [
        16777232,
        61140391,
        162517613,
        1790982703332828567,
        1790982703333775500
      ],
      "model-ple-0015.safetensors": [
        16777232,
        61140399,
        162517613,
        1790982708259744691,
        1790982708261148174
      ],
      "model-ple-0016.safetensors": [
        16777232,
        61140409,
        162517613,
        1790982713943583771,
        1790982713944535246
      ],
      "model-ple-0017.safetensors": [
        16777232,
        61140416,
        162517613,
        1790982719388327528,
        1790982719389255419
      ],
      "model-ple-0018.safetensors": [
        16777232,
        61140420,
        162517611,
        1790982725402636950,
        1790982725403550133
      ],
      "model-ple-0019.safetensors": [
        16777232,
        61140425,
        162517613,
        1790982731256203385,
        1790982731257126901
      ],
      "model-ple-0020.safetensors": [
        16777232,
        61140432,
        162517611,
        1790982738071856793,
        1790982738076684212
      ],
      "model-ple-0021.safetensors": [
        16777232,
        61140437,
        162517611,
        1790982744489047206,
        1790982744489882637
      ],
      "model-ple-0022.safetensors": [
        16777232,
        61140441,
        162517613,
        1790982750186433982,
        1790982750187391749
      ],
      "model-ple-0023.safetensors": [
        16777232,
        61140448,
        162517613,
        1790982756483893209,
        1790982756484835975
      ],
      "model-ple-0024.safetensors": [
        16777232,
        61140462,
        162517610,
        1790982762487478610,
        1790982762488429168
      ],
      "model-ple-0025.safetensors": [
        16777232,
        61140474,
        162517613,
        1790982768446695857,
        1790982768447609374
      ],
      "model-ple-0026.safetensors": [
        16777232,
        61140482,
        162517611,
        1790982774682704006,
        1790982774683668940
      ],
      "model-ple-0027.safetensors": [
        16777232,
        61140487,
        162517613,
        1790982780054403106,
        1790982780055155744
      ],
      "model-ple-0028.safetensors": [
        16777232,
        61140492,
        162517611,
        1790982786131927514,
        1790982786133070409
      ],
      "model-ple-0029.safetensors": [
        16777232,
        61140498,
        162517613,
        1790982791720789884,
        1790982791721679899
      ],
      "model-ple-0030.safetensors": [
        16777232,
        61140507,
        162517613,
        1790982797363790787,
        1790982797364736846
      ],
      "model-ple-0031.safetensors": [
        16777232,
        61140513,
        162517611,
        1790982802855896085,
        1790982802856819934
      ],
      "model-ple-0032.safetensors": [
        16777232,
        61140518,
        162517613,
        1790982807785930346,
        1790982807786920405
      ],
      "model-ple-0033.safetensors": [
        16777232,
        61140523,
        162517610,
        1790982812651563228,
        1790982812652470660
      ],
      "model-ple-0034.safetensors": [
        16777232,
        61140532,
        162517610,
        1790982817300943895,
        1790982817301852203
      ],
      "model-ple-0035.safetensors": [
        16777232,
        61140541,
        162517610,
        1790982821915884168,
        1790982821916815851
      ],
      "model-ple-0036.safetensors": [
        16777232,
        61140548,
        162517610,
        1790982826932480491,
        1790982826933326089
      ],
      "model-ple-0037.safetensors": [
        16777232,
        61140558,
        162517608,
        1790982832539544681,
        1790982832540443571
      ],
      "model-ple-0038.safetensors": [
        16777232,
        61140562,
        162517608,
        1790982838522902935,
        1790982838523814159
      ],
      "model-ple-0039.safetensors": [
        16777232,
        61140567,
        162517610,
        1790982843582402768,
        1790982843583243134
      ],
      "model-ple-0040.safetensors": [
        16777232,
        61140573,
        162517607,
        1790982848339011099,
        1790982848339968272
      ],
      "model-ple-0041.safetensors": [
        16777232,
        61140580,
        162517610,
        1790982853469781697,
        1790982853470684511
      ],
      "model-ple-0042.safetensors": [
        16777232,
        61140585,
        162517610,
        1790982858244013692,
        1790982858244908195
      ],
      "model-ple-0043.safetensors": [
        16777232,
        61140590,
        162517610,
        1790982864003203242,
        1790982864003554394
      ],
      "model-ple-0044.safetensors": [
        16777232,
        61140723,
        162517610,
        1790982869607285689,
        1790982869607623044
      ],
      "model-ple-0045.safetensors": [
        16777232,
        61140727,
        162517610,
        1790982874968029129,
        1790982874968458830
      ],
      "model-ple-0046.safetensors": [
        16777232,
        61140733,
        162517610,
        1790982880349184866,
        1790982880349581326
      ],
      "model-ple-0047.safetensors": [
        16777232,
        61140740,
        162517610,
        1790982885705681830,
        1790982885706026572
      ],
      "model-ple-0048.safetensors": [
        16777232,
        61140754,
        162517610,
        1790982891521923333,
        1790982891522300880
      ],
      "model-ple-0049.safetensors": [
        16777232,
        61140765,
        162517610,
        1790982897650766513,
        1790982897651168488
      ],
      "model-ple-0050.safetensors": [
        16777232,
        61140771,
        162517610,
        1790982902965919941,
        1790982902966278301
      ],
      "model-ple-0051.safetensors": [
        16777232,
        61140786,
        162517607,
        1790982908425811945,
        1790982908426161103
      ],
      "model-ple-0052.safetensors": [
        16777232,
        61140797,
        162517610,
        1790982913785471096,
        1790982913785813799
      ],
      "model-ple-0053.safetensors": [
        16777232,
        61140810,
        162517610,
        1790982919733610844,
        1790982919734091924
      ],
      "model-ple-0054.safetensors": [
        16777232,
        61140815,
        162517610,
        1790982925452621410,
        1790982925452965243
      ],
      "model-ple-0055.safetensors": [
        16777232,
        61140822,
        162517608,
        1790982932055042996,
        1790982932055373372
      ],
      "model-ple-0056.safetensors": [
        16777232,
        61140834,
        162517610,
        1790982936821992693,
        1790982936822328986
      ],
      "model-ple-0057.safetensors": [
        16777232,
        61140853,
        162517610,
        1790982941795208562,
        1790982941795727564
      ],
      "model-ple-0058.safetensors": [
        16777232,
        61140865,
        162517610,
        1790982946659199029,
        1790982946659690490
      ],
      "model-ple-0059.safetensors": [
        16777232,
        61140875,
        162517608,
        1790982951976555530,
        1790982951976913741
      ],
      "model-ple-0060.safetensors": [
        16777232,
        61140902,
        162517610,
        1790982956943755943,
        1790982956944108612
      ],
      "model-ple-0061.safetensors": [
        16777232,
        61140920,
        162517608,
        1790982962665866982,
        1790982962666720072
      ],
      "model-ple-0062.safetensors": [
        16777232,
        61140930,
        162517607,
        1790982967600947912,
        1790982967601780793
      ],
      "model-ple-0063.safetensors": [
        16777232,
        61140936,
        162517610,
        1790982973501324444,
        1790982973502267410
      ],
      "model-ple-0064.safetensors": [
        16777232,
        61140943,
        162517610,
        1790982979530596195,
        1790982979531817747
      ],
      "model-ple-0065.safetensors": [
        16777232,
        61140947,
        162517610,
        1790982985158304116,
        1790982985159197707
      ],
      "model-ple-0066.safetensors": [
        16777232,
        61140953,
        162517610,
        1790982990898086726,
        1790982990899063943
      ],
      "model-ple-0067.safetensors": [
        16777232,
        61140961,
        162517610,
        1790982996401559646,
        1790982996402469196
      ],
      "model-ple-0068.safetensors": [
        16777232,
        61140966,
        162517610,
        1790983001756097601,
        1790983001756707940
      ],
      "model-ple-0069.safetensors": [
        16777232,
        61140971,
        162517610,
        1790983007637603657,
        1790983007638662583
      ],
      "model-ple-0070.safetensors": [
        16777232,
        61140981,
        162517610,
        1790983013286585629,
        1790983013287401512
      ],
      "model-ple-0071.safetensors": [
        16777232,
        61140991,
        162517610,
        1790983018661604180,
        1790983018662524313
      ],
      "model-ple-0072.safetensors": [
        16777232,
        61140996,
        162517608,
        1790983025820209701,
        1790983025820855165
      ],
      "model-ple-0073.safetensors": [
        16777232,
        61141003,
        162517607,
        1790983031268771311,
        1790983031269542818
      ],
      "model-ple-0074.safetensors": [
        16777232,
        61141007,
        162517610,
        1790983036991725465,
        1790983036992614640
      ],
      "model-ple-0075.safetensors": [
        16777232,
        61141012,
        162517608,
        1790983043613793342,
        1790983043614438681
      ],
      "model-ple-0076.safetensors": [
        16777232,
        61141018,
        162517610,
        1790983049313185610,
        1790983049313857116
      ],
      "model-ple-0077.safetensors": [
        16777232,
        61141023,
        162517610,
        1790983055161970608,
        1790983055162864367
      ],
      "model-ple-0078.safetensors": [
        16777232,
        61141032,
        162517610,
        1790983061167775992,
        1790983061168481748
      ],
      "model-ple-0079.safetensors": [
        16777232,
        61141036,
        162517610,
        1790983067037600567,
        1790983067038473950
      ],
      "model-ple-0080.safetensors": [
        16777232,
        61141049,
        162517610,
        1790983072453387751,
        1790983072454284801
      ],
      "model-ple-0081.safetensors": [
        16777232,
        61141056,
        162517610,
        1790983078283342764,
        1790983078284280980
      ],
      "model-ple-0082.safetensors": [
        16777232,
        61141060,
        162517610,
        1790983084482326237,
        1790983084483212704
      ],
      "model-ple-0083.safetensors": [
        16777232,
        61141066,
        162517610,
        1790983089959112142,
        1790983089959804899
      ],
      "model-ple-0084.safetensors": [
        16777232,
        61141082,
        162517607,
        1790983095473290968,
        1790983095474232352
      ],
      "model-ple-0085.safetensors": [
        16777232,
        61141108,
        162517610,
        1790983101378794539,
        1790983101379764131
      ],
      "model-ple-0086.safetensors": [
        16777232,
        61141148,
        162517610,
        1790983107460704078,
        1790983107461626962
      ],
      "model-ple-0087.safetensors": [
        16777232,
        61141156,
        162517610,
        1790983113584810374,
        1790983113585582464
      ],
      "model-ple-0088.safetensors": [
        16777232,
        61141169,
        162517610,
        1790983119099203121,
        1790983119100094587
      ],
      "model-ple-0089.safetensors": [
        16777232,
        61141174,
        162517608,
        1790983124882360253,
        1790983124883316345
      ],
      "model-ple-0090.safetensors": [
        16777232,
        61141184,
        162517610,
        1790983129724665676,
        1790983129728605211
      ],
      "model-ple-0091.safetensors": [
        16777232,
        61141201,
        162517610,
        1790983134421494909,
        1790983134422479168
      ],
      "model-ple-0092.safetensors": [
        16777232,
        61141209,
        162517608,
        1790983140041034022,
        1790983140041975030
      ],
      "model-ple-0093.safetensors": [
        16777232,
        61141216,
        162517610,
        1790983144777734031,
        1790983144778600997
      ],
      "model-ple-0094.safetensors": [
        16777232,
        61141241,
        162517610,
        1790983149994926383,
        1790983149995738224
      ],
      "model-ple-0095.safetensors": [
        16777232,
        61141276,
        162517607,
        1790983154752645124,
        1790983154753430965
      ],
      "model-ple-0096.safetensors": [
        16777232,
        61141310,
        162517610,
        1790983159970819319,
        1790983159971858203
      ],
      "model-ple-0097.safetensors": [
        16777232,
        61141318,
        162517610,
        1790983164974114237,
        1790983164975063121
      ],
      "model-ple-0098.safetensors": [
        16777232,
        61141323,
        162517610,
        1790983170565673096,
        1790983170566609646
      ],
      "model-ple-0099.safetensors": [
        16777232,
        61141341,
        162517610,
        1790983176718977574,
        1790983176719852457
      ],
      "model-ple-0100.safetensors": [
        16777232,
        61141350,
        162517610,
        1790983182892329693,
        1790983182892738405
      ],
      "model-ple-0101.safetensors": [
        16777232,
        61141372,
        162517608,
        1790983190065519468,
        1790983190066574978
      ],
      "model-ple-0102.safetensors": [
        16777232,
        61141385,
        162517610,
        1790983196095511208,
        1790983196096427549
      ],
      "model-ple-0103.safetensors": [
        16777232,
        61141390,
        162517610,
        1790983202080614873,
        1790983202081544381
      ],
      "model-ple-0104.safetensors": [
        16777232,
        61141399,
        162517610,
        1790983208182737513,
        1790983208183661313
      ],
      "model-ple-0105.safetensors": [
        16777232,
        61141403,
        162517608,
        1790983215042826794,
        1790983215043752094
      ],
      "model-ple-0106.safetensors": [
        16777232,
        61141409,
        162517607,
        1790983221162356590,
        1790983221163275015
      ],
      "model-ple-0107.safetensors": [
        16777232,
        61141416,
        162517610,
        1790983227340430125,
        1790983227341199799
      ],
      "model-ple-0108.safetensors": [
        16777232,
        61141423,
        162517610,
        1790983233417963378,
        1790983233418918095
      ],
      "model-ple-0109.safetensors": [
        16777232,
        61141427,
        162517610,
        1790983240053641506,
        1790983240054479847
      ],
      "model-ple-0110.safetensors": [
        16777232,
        61141434,
        162517610,
        1790983246089577132,
        1790983246090531974
      ],
      "model-ple-0111.safetensors": [
        16777232,
        61141445,
        162517608,
        1790983252879031941,
        1790983252879968574
      ],
      "model-ple-0112.safetensors": [
        16777232,
        61141452,
        162517610,
        1790983259339176441,
        1790983259340068949
      ],
      "model-ple-0113.safetensors": [
        16777232,
        61141456,
        162517610,
        1790983265744837490,
        1790983265745586580
      ],
      "model-ple-0114.safetensors": [
        16777232,
        61141462,
        162517608,
        1790983271948410630,
        1790983271949375806
      ],
      "model-ple-0115.safetensors": [
        16777232,
        61141468,
        162517610,
        1790983277072728185,
        1790983277073646361
      ],
      "model-ple-0116.safetensors": [
        16777232,
        61141474,
        162517610,
        1790983281919413398,
        1790983281920340073
      ],
      "model-ple-0117.safetensors": [
        16777232,
        61141479,
        162517607,
        1790983287080135032,
        1790983287081064707
      ],
      "model-ple-0118.safetensors": [
        16777232,
        61141484,
        162517610,
        1790983292260776471,
        1790983292261697105
      ],
      "model-ple-0119.safetensors": [
        16777232,
        61141492,
        162517610,
        1790983298780979640,
        1790983298781872273
      ],
      "model-ple-0120.safetensors": [
        16777232,
        61141500,
        162517610,
        1790983303892181911,
        1790983303893137127
      ],
      "model-ple-0121.safetensors": [
        16777232,
        61141508,
        162517610,
        1790983308606338467,
        1790983308610440713
      ],
      "model-ple-0122.safetensors": [
        16777232,
        61141514,
        162517610,
        1790983313679208182,
        1790983313680128357
      ],
      "model-ple-0123.safetensors": [
        16777232,
        61141521,
        162517610,
        1790983318626470763,
        1790983318627401563
      ],
      "model-ple-0124.safetensors": [
        16777232,
        61141525,
        162517608,
        1790983324394582509,
        1790983324395549101
      ],
      "model-ple-0125.safetensors": [
        16777232,
        61141530,
        162517610,
        1790983329613341251,
        1790983329614258593
      ],
      "model-ple-0126.safetensors": [
        16777232,
        61141535,
        162517610,
        1790983334867535188,
        1790983334868484072
      ],
      "model-ple-0127.safetensors": [
        16777232,
        61141544,
        162517610,
        1790983340019529075,
        1790983340022576061
      ],
      "model-vision-graft.safetensors": [
        16777232,
        61141549,
        897899165,
        1790983365524919672,
        1790983365525846388
      ],
      "mtp-head-q6.safetensors": [
        16777232,
        61141567,
        2297560747,
        1790983429393243759,
        1790983429397524048
      ]
    },
    "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"
  },
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c",
      "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb",
      "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8",
      "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34",
      "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472",
      "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"
    },
    "packages": {
      "mlx": {
        "version": "0.32.2",
        "files": {
          "mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912",
          "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de",
          "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29",
          "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2",
          "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66",
          "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723",
          "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb",
          "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27",
          "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492",
          "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831",
          "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007",
          "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1",
          "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f",
          "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6",
          "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee",
          "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b",
          "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969",
          "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f",
          "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8",
          "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23",
          "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83",
          "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c",
          "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77",
          "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b",
          "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7",
          "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b",
          "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc",
          "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849",
          "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247",
          "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42",
          "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a",
          "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae",
          "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"
        }
      },
      "mlx-metal": {
        "version": "0.32.2",
        "files": {
          "mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a",
          "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084",
          "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8",
          "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
        }
      },
      "mlx-lm": {
        "version": "0.31.3",
        "files": {
          "mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608",
          "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834",
          "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c",
          "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553",
          "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8",
          "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7",
          "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7",
          "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5",
          "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a",
          "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1",
          "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39",
          "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f",
          "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b",
          "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7",
          "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5",
          "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9",
          "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72",
          "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5",
          "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82",
          "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f",
          "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb",
          "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d",
          "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7",
          "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373",
          "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5",
          "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8",
          "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750",
          "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a",
          "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610",
          "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70",
          "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66",
          "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095",
          "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d",
          "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9",
          "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7",
          "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91",
          "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db",
          "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1",
          "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914",
          "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e",
          "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96",
          "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1",
          "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c",
          "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251",
          "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a",
          "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38",
          "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6",
          "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8",
          "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f",
          "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2",
          "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2",
          "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05",
          "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643",
          "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e",
          "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec",
          "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9",
          "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd",
          "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443",
          "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba",
          "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af",
          "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19",
          "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332",
          "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197",
          "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db",
          "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f",
          "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19",
          "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d",
          "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd",
          "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305",
          "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d",
          "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0",
          "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8",
          "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c",
          "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395",
          "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca",
          "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb",
          "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c",
          "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8",
          "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f",
          "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8",
          "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4",
          "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf",
          "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7",
          "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd",
          "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13",
          "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306",
          "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145",
          "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca",
          "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d",
          "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c",
          "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057",
          "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4",
          "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855",
          "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae",
          "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f",
          "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e",
          "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9",
          "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393",
          "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90",
          "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1",
          "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4",
          "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b",
          "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9",
          "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5",
          "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e",
          "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd",
          "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28",
          "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b",
          "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582",
          "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e",
          "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391",
          "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306",
          "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41",
          "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639",
          "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a",
          "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619",
          "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005",
          "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79",
          "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e",
          "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9",
          "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc",
          "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a",
          "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e",
          "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832",
          "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179",
          "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125",
          "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a",
          "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a",
          "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a",
          "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169",
          "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2",
          "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427",
          "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a",
          "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa",
          "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa",
          "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a",
          "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020",
          "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e",
          "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58",
          "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67",
          "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b",
          "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19",
          "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a",
          "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc",
          "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c",
          "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66",
          "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1",
          "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206",
          "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531",
          "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f",
          "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0",
          "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d",
          "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25",
          "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3",
          "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3",
          "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17",
          "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10",
          "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45",
          "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375",
          "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe",
          "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553",
          "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d",
          "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"
        }
      },
      "numpy": {
        "version": "2.5.2",
        "files": {
          "numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b",
          "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11",
          "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972",
          "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a",
          "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2",
          "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6",
          "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb",
          "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2",
          "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926",
          "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881",
          "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a",
          "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0",
          "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476",
          "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee",
          "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af",
          "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627",
          "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b",
          "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c",
          "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78",
          "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950",
          "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d",
          "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5",
          "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66",
          "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2",
          "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2",
          "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395",
          "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf",
          "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605",
          "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5",
          "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106",
          "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c",
          "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49",
          "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417",
          "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8",
          "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca",
          "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807",
          "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b",
          "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e",
          "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332",
          "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3",
          "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957",
          "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2",
          "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0",
          "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81",
          "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a",
          "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea",
          "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d",
          "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159",
          "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582",
          "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af",
          "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c",
          "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2",
          "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d",
          "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224",
          "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec",
          "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a",
          "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489",
          "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67",
          "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a",
          "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143",
          "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a",
          "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31",
          "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d",
          "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847",
          "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f",
          "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f",
          "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b",
          "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0",
          "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf",
          "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477",
          "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2",
          "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650",
          "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1",
          "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd",
          "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a",
          "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4",
          "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc",
          "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41",
          "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111",
          "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008",
          "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d",
          "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a",
          "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19",
          "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068",
          "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72",
          "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01",
          "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c",
          "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c",
          "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099",
          "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0",
          "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a",
          "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761",
          "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca",
          "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e",
          "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6",
          "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc",
          "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8",
          "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446",
          "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe",
          "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc",
          "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9",
          "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca",
          "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288",
          "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76",
          "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0",
          "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4",
          "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76",
          "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669",
          "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808",
          "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987",
          "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a",
          "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f",
          "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36",
          "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2",
          "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b",
          "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b",
          "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605",
          "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002",
          "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b",
          "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33",
          "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8",
          "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1",
          "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7",
          "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1",
          "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284",
          "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c",
          "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24",
          "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5",
          "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e",
          "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310",
          "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf",
          "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9",
          "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9",
          "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c",
          "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a",
          "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27",
          "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c",
          "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275",
          "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436",
          "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5",
          "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714",
          "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550",
          "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df",
          "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822",
          "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93",
          "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92",
          "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b",
          "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2",
          "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930",
          "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca",
          "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c",
          "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf",
          "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07",
          "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306",
          "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf",
          "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5",
          "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142",
          "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406",
          "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a",
          "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795",
          "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab",
          "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c",
          "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c",
          "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8",
          "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537",
          "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e",
          "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74",
          "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec",
          "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0",
          "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7",
          "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a",
          "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0",
          "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d",
          "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822",
          "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8",
          "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137",
          "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37",
          "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3",
          "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576",
          "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681",
          "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b",
          "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529",
          "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491",
          "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6",
          "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873",
          "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4",
          "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4",
          "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281",
          "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547",
          "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0",
          "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09",
          "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f",
          "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d",
          "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4",
          "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7",
          "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc",
          "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3",
          "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9",
          "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e",
          "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e",
          "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82",
          "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f",
          "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7",
          "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e",
          "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36",
          "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6",
          "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d",
          "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026",
          "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777",
          "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386",
          "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb",
          "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599",
          "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07",
          "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa",
          "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b",
          "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f",
          "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0",
          "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72",
          "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b",
          "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f",
          "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d",
          "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b",
          "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d",
          "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e",
          "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131",
          "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4",
          "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0",
          "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460",
          "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771",
          "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116",
          "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd",
          "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e",
          "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48",
          "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb",
          "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5",
          "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545",
          "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc",
          "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec",
          "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862",
          "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb",
          "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939",
          "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea",
          "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195",
          "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435",
          "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0",
          "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292",
          "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b",
          "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074",
          "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6",
          "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4",
          "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874",
          "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792",
          "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202",
          "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292",
          "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c",
          "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc",
          "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f",
          "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b",
          "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c",
          "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79",
          "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4",
          "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a",
          "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af",
          "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324",
          "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46",
          "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780",
          "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed",
          "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab",
          "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c",
          "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5",
          "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e",
          "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74",
          "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4",
          "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f",
          "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98",
          "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004",
          "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3",
          "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c",
          "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca",
          "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2",
          "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f",
          "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d",
          "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c",
          "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781",
          "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953",
          "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e",
          "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5",
          "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828",
          "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417",
          "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425",
          "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11",
          "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2",
          "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642",
          "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6",
          "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5",
          "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718",
          "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16",
          "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782",
          "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c",
          "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5",
          "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9",
          "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53",
          "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709",
          "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4",
          "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47",
          "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca",
          "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917",
          "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8",
          "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f",
          "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2",
          "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824",
          "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d",
          "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3",
          "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396",
          "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25",
          "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af",
          "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d",
          "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6",
          "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033",
          "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418",
          "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84",
          "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352",
          "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99",
          "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228",
          "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca",
          "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82",
          "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78",
          "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b",
          "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9",
          "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0",
          "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5",
          "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801",
          "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c",
          "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc",
          "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b",
          "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b",
          "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3",
          "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639",
          "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e",
          "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0",
          "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5",
          "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945",
          "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b",
          "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f",
          "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45",
          "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931",
          "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3",
          "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c",
          "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213",
          "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5",
          "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9",
          "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2",
          "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4",
          "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13",
          "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e",
          "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37",
          "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557",
          "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc",
          "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9",
          "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363",
          "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a",
          "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5",
          "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32",
          "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498",
          "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049",
          "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7",
          "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4",
          "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0",
          "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc",
          "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166",
          "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682",
          "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482",
          "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a",
          "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e",
          "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
          "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196",
          "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed",
          "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a",
          "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723",
          "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14",
          "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5",
          "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2",
          "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392",
          "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759",
          "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee",
          "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe",
          "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd",
          "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe",
          "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0",
          "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c",
          "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4",
          "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94",
          "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147",
          "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1",
          "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c",
          "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665",
          "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b",
          "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02",
          "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff",
          "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67",
          "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94",
          "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0",
          "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0",
          "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509",
          "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda",
          "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0",
          "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1",
          "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796",
          "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3",
          "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5",
          "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14",
          "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297",
          "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54",
          "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"
        }
      }
    },
    "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]",
    "sha256": "0505bcc315797f8fb5772bc6693d82a3315d6365507cddc472073011faf089e2"
  },
  "producer_sha256": "de31d0be74b02e620e07ce82523bfa32fd07c6dfc7f275e53d24611beec47658",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22329720832,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    85229.\nPages active:                                1101839.\nPages inactive:                              1091171.\nPages speculative:                             32659.\nPages throttled:                                   0.\nPages wired down:                             181493.\nPages purgeable:                                2005.\n\"Translation faults\":                     1061545996.\nPages copy-on-write:                        63772716.\nPages zero filled:                        1904182064.\nPages reactivated:                          92999068.\nPages purged:                               10738424.\nFile-backed pages:                           1275664.\nAnonymous pages:                              950005.\nPages stored in compressor:                  1080112.\nPages occupied by compressor:                 593014.\nDecompressions:                             22875459.\nCompressions:                               32334788.\nPageins:                                   530464342.\nPageouts:                                     327934.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 131345.\nPages tagged resident:                         94891.\nPages tagged compressed:                       36454.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          110.\nPages tag-storage non-tag pageable:            93024.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5264640.\nTagged compressions:                          427223.\nTagged decompressions:                        355608.\n"
  },
  "source_fixture": {
    "path": "layer-2-pass-0.safetensors",
    "layer": 2,
    "step": 0,
    "bytes": 3268867,
    "sha256": "41f902b5def7478e089d7611f0284f13b0211f14cd960c7a94b5fc83577ed427",
    "keys": [
      "conv",
      "hidden",
      "state"
    ]
  },
  "expanded_equals_whole": true,
  "memory": {
    "current_bytes": 475857904,
    "lifetime_peak_bytes": 475857904,
    "rss_peak_bytes": 434683904
  },
  "fixture": {
    "path": "attention.safetensors",
    "bytes": 572658,
    "sha256": "5c5a2af3e5c1cc401a695c3a504268752ee19ee3709eedb3f6f1a30531756d66"
  },
  "qualification": "unproven"
}
````

### vq-attention-3.2-v2-supervision/identity.json

Original bytes: 2766. SHA-256: `4a39ee1ece181615f199c93a0017e916ddec420dccad10e6bf723b2861b44dfd`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_attention_reference.py",
    "--model",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--architecture",
    "<HOME>/Projects/slotstream/.build/quantization-research/qwen4_exp-pr1788.py",
    "--fixture",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-model-3.2-v1",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-attention-3.2-v2"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22351986688,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   100793.\nPages active:                                1100493.\nPages inactive:                              1078576.\nPages speculative:                             31047.\nPages throttled:                                   0.\nPages wired down:                             181472.\nPages purgeable:                                2005.\n\"Translation faults\":                     1061540568.\nPages copy-on-write:                        63771995.\nPages zero filled:                        1904179731.\nPages reactivated:                          92999068.\nPages purged:                               10738424.\nFile-backed pages:                           1261459.\nAnonymous pages:                              948657.\nPages stored in compressor:                  1080112.\nPages occupied by compressor:                 593014.\nDecompressions:                             22875459.\nCompressions:                               32334788.\nPageins:                                   530451738.\nPageouts:                                     327934.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 131345.\nPages tagged resident:                         94891.\nPages tagged compressed:                       36454.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          111.\nPages tag-storage non-tag pageable:            93023.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5264640.\nTagged compressions:                          427223.\nTagged decompressions:                        355608.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-attention-3.2-v2-supervision/receipt.json

Original bytes: 2136. SHA-256: `89580d34ff386ec624c9c36e2ffb62768863a051c6af3e7b2f7d67f45e52cda3`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 475857904,
  "samples": 497,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22448455680,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    36582.\nPages active:                                1093861.\nPages inactive:                              1176502.\nPages speculative:                              4855.\nPages throttled:                                   0.\nPages wired down:                             180595.\nPages purgeable:                                  75.\n\"Translation faults\":                     1061716118.\nPages copy-on-write:                        63785892.\nPages zero filled:                        1904300058.\nPages reactivated:                          93013460.\nPages purged:                               10740958.\nFile-backed pages:                           1333488.\nAnonymous pages:                              941730.\nPages stored in compressor:                  1080303.\nPages occupied by compressor:                 593043.\nDecompressions:                             22875541.\nCompressions:                               32335063.\nPageins:                                   534581090.\nPageouts:                                     328095.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 130021.\nPages tagged resident:                         93564.\nPages tagged compressed:                       36457.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          210.\nPages tag-storage non-tag pageable:            92924.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5265088.\nTagged compressions:                          427226.\nTagged decompressions:                        355608.\n"
  },
  "seconds": 29.290421499999997
}
````

### vq-attention-3.2-v2-supervision/stdout.txt

Original bytes: 88658. SHA-256: `18685872b501fbb1c4c0f2c0e799ac1dbdef8e06bc57fd681a57ab9b5ea3f840`.

````text
{"verified": "model-00001.safetensors"}
{"verified": "model-00012.safetensors"}
{"verified": "model-00013.safetensors"}
{"verified": "model-00014.safetensors"}
{"verified": "model-00015.safetensors"}
{"verified": "model-00016.safetensors"}
{"verified": "model-00017.safetensors"}
{"verified": "model-00018.safetensors"}
{"verified": "model-00019.safetensors"}
{"verified": "model-ple-0000.safetensors"}
{"verified": "model-ple-0001.safetensors"}
{"verified": "model-ple-0002.safetensors"}
{"verified": "model-ple-0003.safetensors"}
{"verified": "model-ple-0004.safetensors"}
{"verified": "model-ple-0005.safetensors"}
{"verified": "model-ple-0006.safetensors"}
{"verified": "model-ple-0007.safetensors"}
{"verified": "model-ple-0008.safetensors"}
{"verified": "model-ple-0009.safetensors"}
{"verified": "model-ple-0010.safetensors"}
{"verified": "model-ple-0011.safetensors"}
{"verified": "model-ple-0012.safetensors"}
{"verified": "model-ple-0013.safetensors"}
{"verified": "model-ple-0014.safetensors"}
{"verified": "model-ple-0015.safetensors"}
{"verified": "model-ple-0016.safetensors"}
{"verified": "model-ple-0017.safetensors"}
{"verified": "model-ple-0018.safetensors"}
{"verified": "model-ple-0019.safetensors"}
{"verified": "model-ple-0020.safetensors"}
{"verified": "model-ple-0021.safetensors"}
{"verified": "model-ple-0022.safetensors"}
{"verified": "model-ple-0023.safetensors"}
{"verified": "model-ple-0024.safetensors"}
{"verified": "model-ple-0025.safetensors"}
{"verified": "model-ple-0026.safetensors"}
{"verified": "model-ple-0027.safetensors"}
{"verified": "model-ple-0028.safetensors"}
{"verified": "model-ple-0029.safetensors"}
{"verified": "model-ple-0030.safetensors"}
{"verified": "model-ple-0031.safetensors"}
{"verified": "model-ple-0032.safetensors"}
{"verified": "model-ple-0033.safetensors"}
{"verified": "model-ple-0034.safetensors"}
{"verified": "model-ple-0035.safetensors"}
{"verified": "model-ple-0036.safetensors"}
{"verified": "model-ple-0037.safetensors"}
{"verified": "model-ple-0038.safetensors"}
{"verified": "model-ple-0039.safetensors"}
{"verified": "model-ple-0040.safetensors"}
{"verified": "model-ple-0041.safetensors"}
{"verified": "model-ple-0042.safetensors"}
{"verified": "model-ple-0043.safetensors"}
{"verified": "model-ple-0044.safetensors"}
{"verified": "model-ple-0045.safetensors"}
{"verified": "model-ple-0046.safetensors"}
{"verified": "model-ple-0047.safetensors"}
{"verified": "model-ple-0048.safetensors"}
{"verified": "model-ple-0049.safetensors"}
{"verified": "model-ple-0050.safetensors"}
{"verified": "model-ple-0051.safetensors"}
{"verified": "model-ple-0052.safetensors"}
{"verified": "model-ple-0053.safetensors"}
{"verified": "model-ple-0054.safetensors"}
{"verified": "model-ple-0055.safetensors"}
{"verified": "model-ple-0056.safetensors"}
{"verified": "model-ple-0057.safetensors"}
{"verified": "model-ple-0058.safetensors"}
{"verified": "model-ple-0059.safetensors"}
{"verified": "model-ple-0060.safetensors"}
{"verified": "model-ple-0061.safetensors"}
{"verified": "model-ple-0062.safetensors"}
{"verified": "model-ple-0063.safetensors"}
{"verified": "model-ple-0064.safetensors"}
{"verified": "model-ple-0065.safetensors"}
{"verified": "model-ple-0066.safetensors"}
{"verified": "model-ple-0067.safetensors"}
{"verified": "model-ple-0068.safetensors"}
{"verified": "model-ple-0069.safetensors"}
{"verified": "model-ple-0070.safetensors"}
{"verified": "model-ple-0071.safetensors"}
{"verified": "model-ple-0072.safetensors"}
{"verified": "model-ple-0073.safetensors"}
{"verified": "model-ple-0074.safetensors"}
{"verified": "model-ple-0075.safetensors"}
{"verified": "model-ple-0076.safetensors"}
{"verified": "model-ple-0077.safetensors"}
{"verified": "model-ple-0078.safetensors"}
{"verified": "model-ple-0079.safetensors"}
{"verified": "model-ple-0080.safetensors"}
{"verified": "model-ple-0081.safetensors"}
{"verified": "model-ple-0082.safetensors"}
{"verified": "model-ple-0083.safetensors"}
{"verified": "model-ple-0084.safetensors"}
{"verified": "model-ple-0085.safetensors"}
{"verified": "model-ple-0086.safetensors"}
{"verified": "model-ple-0087.safetensors"}
{"verified": "model-ple-0088.safetensors"}
{"verified": "model-ple-0089.safetensors"}
{"verified": "model-ple-0090.safetensors"}
{"verified": "model-ple-0091.safetensors"}
{"verified": "model-ple-0092.safetensors"}
{"verified": "model-ple-0093.safetensors"}
{"verified": "model-ple-0094.safetensors"}
{"verified": "model-ple-0095.safetensors"}
{"verified": "model-ple-0096.safetensors"}
{"verified": "model-ple-0097.safetensors"}
{"verified": "model-ple-0098.safetensors"}
{"verified": "model-ple-0099.safetensors"}
{"verified": "model-ple-0100.safetensors"}
{"verified": "model-ple-0101.safetensors"}
{"verified": "model-ple-0102.safetensors"}
{"verified": "model-ple-0103.safetensors"}
{"verified": "model-ple-0104.safetensors"}
{"verified": "model-ple-0105.safetensors"}
{"verified": "model-ple-0106.safetensors"}
{"verified": "model-ple-0107.safetensors"}
{"verified": "model-ple-0108.safetensors"}
{"verified": "model-ple-0109.safetensors"}
{"verified": "model-ple-0110.safetensors"}
{"verified": "model-ple-0111.safetensors"}
{"verified": "model-ple-0112.safetensors"}
{"verified": "model-ple-0113.safetensors"}
{"verified": "model-ple-0114.safetensors"}
{"verified": "model-ple-0115.safetensors"}
{"verified": "model-ple-0116.safetensors"}
{"verified": "model-ple-0117.safetensors"}
{"verified": "model-ple-0118.safetensors"}
{"verified": "model-ple-0119.safetensors"}
{"verified": "model-ple-0120.safetensors"}
{"verified": "model-ple-0121.safetensors"}
{"verified": "model-ple-0122.safetensors"}
{"verified": "model-ple-0123.safetensors"}
{"verified": "model-ple-0124.safetensors"}
{"verified": "model-ple-0125.safetensors"}
{"verified": "model-ple-0126.safetensors"}
{"verified": "model-ple-0127.safetensors"}
{"verified": "model-vision-graft.safetensors"}
{"verified": "mtp-head-q6.safetensors"}
{"schema": 1, "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87", "normalization": "vq-raw-zero-centered-to-pr1788-folded-bf16-v1", "artifact": {"verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e", "stamps": {"model-00001.safetensors": [16777232, 61124837, 3502305114, 1790981216969651631, 1790981216973805883], "model-00012.safetensors": [16777232, 61124923, 6258175824, 1790981377005612627, 1790981377009206956], "model-00013.safetensors": [16777232, 61125010, 6471407889, 1790981545033604036, 1790981545036494899], "model-00014.safetensors": [16777232, 61125132, 6547978262, 1790981736942738954, 1790981736944883976], "model-00015.safetensors": [16777232, 61125286, 6471407935, 1790981924339816693, 1790981924342464654], "model-00016.safetensors": [16777232, 61125510, 6857620951, 1790982119683472302, 1790982119685710216], "model-00017.safetensors": [16777232, 61129776, 6679034951, 1790982305666734292, 1790982305672913817], "model-00018.safetensors": [16777232, 61136554, 6733521211, 1790982515929442647, 1790982515931575685], "model-00019.safetensors": [16777232, 61136710, 3457093298, 1790982619932592777, 1790982619933742130], "model-ple-0000.safetensors": [16777232, 61140250, 162517607, 1790982627138573871, 1790982627139487012], "model-ple-0001.safetensors": [16777232, 61140257, 162517605, 1790982633555677032, 1790982633556582756], "model-ple-0002.safetensors": [16777232, 61140267, 162517610, 1790982639202217456, 1790982639203120347], "model-ple-0003.safetensors": [16777232, 61140272, 162517613, 1790982645069140209, 1790982645069823054], "model-ple-0004.safetensors": [16777232, 61140283, 162517613, 1790982650945947009, 1790982650946871359], "model-ple-0005.safetensors": [16777232, 61140293, 162517611, 1790982657117788365, 1790982657118728631], "model-ple-0006.safetensors": [16777232, 61140299, 162517611, 1790982663412388541, 1790982663413293974], "model-ple-0007.safetensors": [16777232, 61140312, 162517611, 1790982669152254855, 1790982669153205538], "model-ple-0008.safetensors": [16777232, 61140320, 162517613, 1790982674022126144, 1790982674023049244], "model-ple-0009.safetensors": [16777232, 61140331, 162517613, 1790982678928236736, 1790982678929079667], "model-ple-0010.safetensors": [16777232, 61140335, 162517613, 1790982683656085531, 1790982683656969339], "model-ple-0011.safetensors": [16777232, 61140341, 162517613, 1790982688473524025, 1790982688474332997], "model-ple-0012.safetensors": [16777232, 61140355, 162517613, 1790982693458602253, 1790982693459500144], "model-ple-0013.safetensors": [16777232, 61140371, 162517610, 1790982698170087804, 1790982698170988778], "model-ple-0014.safetensors": [16777232, 61140391, 162517613, 1790982703332828567, 1790982703333775500], "model-ple-0015.safetensors": [16777232, 61140399, 162517613, 1790982708259744691, 1790982708261148174], "model-ple-0016.safetensors": [16777232, 61140409, 162517613, 1790982713943583771, 1790982713944535246], "model-ple-0017.safetensors": [16777232, 61140416, 162517613, 1790982719388327528, 1790982719389255419], "model-ple-0018.safetensors": [16777232, 61140420, 162517611, 1790982725402636950, 1790982725403550133], "model-ple-0019.safetensors": [16777232, 61140425, 162517613, 1790982731256203385, 1790982731257126901], "model-ple-0020.safetensors": [16777232, 61140432, 162517611, 1790982738071856793, 1790982738076684212], "model-ple-0021.safetensors": [16777232, 61140437, 162517611, 1790982744489047206, 1790982744489882637], "model-ple-0022.safetensors": [16777232, 61140441, 162517613, 1790982750186433982, 1790982750187391749], "model-ple-0023.safetensors": [16777232, 61140448, 162517613, 1790982756483893209, 1790982756484835975], "model-ple-0024.safetensors": [16777232, 61140462, 162517610, 1790982762487478610, 1790982762488429168], "model-ple-0025.safetensors": [16777232, 61140474, 162517613, 1790982768446695857, 1790982768447609374], "model-ple-0026.safetensors": [16777232, 61140482, 162517611, 1790982774682704006, 1790982774683668940], "model-ple-0027.safetensors": [16777232, 61140487, 162517613, 1790982780054403106, 1790982780055155744], "model-ple-0028.safetensors": [16777232, 61140492, 162517611, 1790982786131927514, 1790982786133070409], "model-ple-0029.safetensors": [16777232, 61140498, 162517613, 1790982791720789884, 1790982791721679899], "model-ple-0030.safetensors": [16777232, 61140507, 162517613, 1790982797363790787, 1790982797364736846], "model-ple-0031.safetensors": [16777232, 61140513, 162517611, 1790982802855896085, 1790982802856819934], "model-ple-0032.safetensors": [16777232, 61140518, 162517613, 1790982807785930346, 1790982807786920405], "model-ple-0033.safetensors": [16777232, 61140523, 162517610, 1790982812651563228, 1790982812652470660], "model-ple-0034.safetensors": [16777232, 61140532, 162517610, 1790982817300943895, 1790982817301852203], "model-ple-0035.safetensors": [16777232, 61140541, 162517610, 1790982821915884168, 1790982821916815851], "model-ple-0036.safetensors": [16777232, 61140548, 162517610, 1790982826932480491, 1790982826933326089], "model-ple-0037.safetensors": [16777232, 61140558, 162517608, 1790982832539544681, 1790982832540443571], "model-ple-0038.safetensors": [16777232, 61140562, 162517608, 1790982838522902935, 1790982838523814159], "model-ple-0039.safetensors": [16777232, 61140567, 162517610, 1790982843582402768, 1790982843583243134], "model-ple-0040.safetensors": [16777232, 61140573, 162517607, 1790982848339011099, 1790982848339968272], "model-ple-0041.safetensors": [16777232, 61140580, 162517610, 1790982853469781697, 1790982853470684511], "model-ple-0042.safetensors": [16777232, 61140585, 162517610, 1790982858244013692, 1790982858244908195], "model-ple-0043.safetensors": [16777232, 61140590, 162517610, 1790982864003203242, 1790982864003554394], "model-ple-0044.safetensors": [16777232, 61140723, 162517610, 1790982869607285689, 1790982869607623044], "model-ple-0045.safetensors": [16777232, 61140727, 162517610, 1790982874968029129, 1790982874968458830], "model-ple-0046.safetensors": [16777232, 61140733, 162517610, 1790982880349184866, 1790982880349581326], "model-ple-0047.safetensors": [16777232, 61140740, 162517610, 1790982885705681830, 1790982885706026572], "model-ple-0048.safetensors": [16777232, 61140754, 162517610, 1790982891521923333, 1790982891522300880], "model-ple-0049.safetensors": [16777232, 61140765, 162517610, 1790982897650766513, 1790982897651168488], "model-ple-0050.safetensors": [16777232, 61140771, 162517610, 1790982902965919941, 1790982902966278301], "model-ple-0051.safetensors": [16777232, 61140786, 162517607, 1790982908425811945, 1790982908426161103], "model-ple-0052.safetensors": [16777232, 61140797, 162517610, 1790982913785471096, 1790982913785813799], "model-ple-0053.safetensors": [16777232, 61140810, 162517610, 1790982919733610844, 1790982919734091924], "model-ple-0054.safetensors": [16777232, 61140815, 162517610, 1790982925452621410, 1790982925452965243], "model-ple-0055.safetensors": [16777232, 61140822, 162517608, 1790982932055042996, 1790982932055373372], "model-ple-0056.safetensors": [16777232, 61140834, 162517610, 1790982936821992693, 1790982936822328986], "model-ple-0057.safetensors": [16777232, 61140853, 162517610, 1790982941795208562, 1790982941795727564], "model-ple-0058.safetensors": [16777232, 61140865, 162517610, 1790982946659199029, 1790982946659690490], "model-ple-0059.safetensors": [16777232, 61140875, 162517608, 1790982951976555530, 1790982951976913741], "model-ple-0060.safetensors": [16777232, 61140902, 162517610, 1790982956943755943, 1790982956944108612], "model-ple-0061.safetensors": [16777232, 61140920, 162517608, 1790982962665866982, 1790982962666720072], "model-ple-0062.safetensors": [16777232, 61140930, 162517607, 1790982967600947912, 1790982967601780793], "model-ple-0063.safetensors": [16777232, 61140936, 162517610, 1790982973501324444, 1790982973502267410], "model-ple-0064.safetensors": [16777232, 61140943, 162517610, 1790982979530596195, 1790982979531817747], "model-ple-0065.safetensors": [16777232, 61140947, 162517610, 1790982985158304116, 1790982985159197707], "model-ple-0066.safetensors": [16777232, 61140953, 162517610, 1790982990898086726, 1790982990899063943], "model-ple-0067.safetensors": [16777232, 61140961, 162517610, 1790982996401559646, 1790982996402469196], "model-ple-0068.safetensors": [16777232, 61140966, 162517610, 1790983001756097601, 1790983001756707940], "model-ple-0069.safetensors": [16777232, 61140971, 162517610, 1790983007637603657, 1790983007638662583], "model-ple-0070.safetensors": [16777232, 61140981, 162517610, 1790983013286585629, 1790983013287401512], "model-ple-0071.safetensors": [16777232, 61140991, 162517610, 1790983018661604180, 1790983018662524313], "model-ple-0072.safetensors": [16777232, 61140996, 162517608, 1790983025820209701, 1790983025820855165], "model-ple-0073.safetensors": [16777232, 61141003, 162517607, 1790983031268771311, 1790983031269542818], "model-ple-0074.safetensors": [16777232, 61141007, 162517610, 1790983036991725465, 1790983036992614640], "model-ple-0075.safetensors": [16777232, 61141012, 162517608, 1790983043613793342, 1790983043614438681], "model-ple-0076.safetensors": [16777232, 61141018, 162517610, 1790983049313185610, 1790983049313857116], "model-ple-0077.safetensors": [16777232, 61141023, 162517610, 1790983055161970608, 1790983055162864367], "model-ple-0078.safetensors": [16777232, 61141032, 162517610, 1790983061167775992, 1790983061168481748], "model-ple-0079.safetensors": [16777232, 61141036, 162517610, 1790983067037600567, 1790983067038473950], "model-ple-0080.safetensors": [16777232, 61141049, 162517610, 1790983072453387751, 1790983072454284801], "model-ple-0081.safetensors": [16777232, 61141056, 162517610, 1790983078283342764, 1790983078284280980], "model-ple-0082.safetensors": [16777232, 61141060, 162517610, 1790983084482326237, 1790983084483212704], "model-ple-0083.safetensors": [16777232, 61141066, 162517610, 1790983089959112142, 1790983089959804899], "model-ple-0084.safetensors": [16777232, 61141082, 162517607, 1790983095473290968, 1790983095474232352], "model-ple-0085.safetensors": [16777232, 61141108, 162517610, 1790983101378794539, 1790983101379764131], "model-ple-0086.safetensors": [16777232, 61141148, 162517610, 1790983107460704078, 1790983107461626962], "model-ple-0087.safetensors": [16777232, 61141156, 162517610, 1790983113584810374, 1790983113585582464], "model-ple-0088.safetensors": [16777232, 61141169, 162517610, 1790983119099203121, 1790983119100094587], "model-ple-0089.safetensors": [16777232, 61141174, 162517608, 1790983124882360253, 1790983124883316345], "model-ple-0090.safetensors": [16777232, 61141184, 162517610, 1790983129724665676, 1790983129728605211], "model-ple-0091.safetensors": [16777232, 61141201, 162517610, 1790983134421494909, 1790983134422479168], "model-ple-0092.safetensors": [16777232, 61141209, 162517608, 1790983140041034022, 1790983140041975030], "model-ple-0093.safetensors": [16777232, 61141216, 162517610, 1790983144777734031, 1790983144778600997], "model-ple-0094.safetensors": [16777232, 61141241, 162517610, 1790983149994926383, 1790983149995738224], "model-ple-0095.safetensors": [16777232, 61141276, 162517607, 1790983154752645124, 1790983154753430965], "model-ple-0096.safetensors": [16777232, 61141310, 162517610, 1790983159970819319, 1790983159971858203], "model-ple-0097.safetensors": [16777232, 61141318, 162517610, 1790983164974114237, 1790983164975063121], "model-ple-0098.safetensors": [16777232, 61141323, 162517610, 1790983170565673096, 1790983170566609646], "model-ple-0099.safetensors": [16777232, 61141341, 162517610, 1790983176718977574, 1790983176719852457], "model-ple-0100.safetensors": [16777232, 61141350, 162517610, 1790983182892329693, 1790983182892738405], "model-ple-0101.safetensors": [16777232, 61141372, 162517608, 1790983190065519468, 1790983190066574978], "model-ple-0102.safetensors": [16777232, 61141385, 162517610, 1790983196095511208, 1790983196096427549], "model-ple-0103.safetensors": [16777232, 61141390, 162517610, 1790983202080614873, 1790983202081544381], "model-ple-0104.safetensors": [16777232, 61141399, 162517610, 1790983208182737513, 1790983208183661313], "model-ple-0105.safetensors": [16777232, 61141403, 162517608, 1790983215042826794, 1790983215043752094], "model-ple-0106.safetensors": [16777232, 61141409, 162517607, 1790983221162356590, 1790983221163275015], "model-ple-0107.safetensors": [16777232, 61141416, 162517610, 1790983227340430125, 1790983227341199799], "model-ple-0108.safetensors": [16777232, 61141423, 162517610, 1790983233417963378, 1790983233418918095], "model-ple-0109.safetensors": [16777232, 61141427, 162517610, 1790983240053641506, 1790983240054479847], "model-ple-0110.safetensors": [16777232, 61141434, 162517610, 1790983246089577132, 1790983246090531974], "model-ple-0111.safetensors": [16777232, 61141445, 162517608, 1790983252879031941, 1790983252879968574], "model-ple-0112.safetensors": [16777232, 61141452, 162517610, 1790983259339176441, 1790983259340068949], "model-ple-0113.safetensors": [16777232, 61141456, 162517610, 1790983265744837490, 1790983265745586580], "model-ple-0114.safetensors": [16777232, 61141462, 162517608, 1790983271948410630, 1790983271949375806], "model-ple-0115.safetensors": [16777232, 61141468, 162517610, 1790983277072728185, 1790983277073646361], "model-ple-0116.safetensors": [16777232, 61141474, 162517610, 1790983281919413398, 1790983281920340073], "model-ple-0117.safetensors": [16777232, 61141479, 162517607, 1790983287080135032, 1790983287081064707], "model-ple-0118.safetensors": [16777232, 61141484, 162517610, 1790983292260776471, 1790983292261697105], "model-ple-0119.safetensors": [16777232, 61141492, 162517610, 1790983298780979640, 1790983298781872273], "model-ple-0120.safetensors": [16777232, 61141500, 162517610, 1790983303892181911, 1790983303893137127], "model-ple-0121.safetensors": [16777232, 61141508, 162517610, 1790983308606338467, 1790983308610440713], "model-ple-0122.safetensors": [16777232, 61141514, 162517610, 1790983313679208182, 1790983313680128357], "model-ple-0123.safetensors": [16777232, 61141521, 162517610, 1790983318626470763, 1790983318627401563], "model-ple-0124.safetensors": [16777232, 61141525, 162517608, 1790983324394582509, 1790983324395549101], "model-ple-0125.safetensors": [16777232, 61141530, 162517610, 1790983329613341251, 1790983329614258593], "model-ple-0126.safetensors": [16777232, 61141535, 162517610, 1790983334867535188, 1790983334868484072], "model-ple-0127.safetensors": [16777232, 61141544, 162517610, 1790983340019529075, 1790983340022576061], "model-vision-graft.safetensors": [16777232, 61141549, 897899165, 1790983365524919672, 1790983365525846388], "mtp-head-q6.safetensors": [16777232, 61141567, 2297560747, 1790983429393243759, 1790983429397524048]}, "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"}, "instrument": {"scripts": {"vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec", "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e", "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749", "vq_kernel_sources.py": "00e931902b2c4f8b6f348897ca5c094f23747ea7d9260868d5440d791309a84c", "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb", "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8", "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34", "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472", "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"}, "packages": {"mlx": {"version": "0.32.2", "files": {"mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912", "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de", "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29", "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2", "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66", "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723", "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb", "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27", "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492", "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831", "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007", "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1", "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f", "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6", "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee", "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b", "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969", "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f", "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8", "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23", "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83", "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c", "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77", "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b", "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7", "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b", "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc", "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849", "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247", "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42", "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a", "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae", "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"}}, "mlx-metal": {"version": "0.32.2", "files": {"mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a", "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084", "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8", "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"}}, "mlx-lm": {"version": "0.31.3", "files": {"mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608", "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834", "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c", "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553", "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8", "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7", "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7", "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5", "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a", "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1", "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39", "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f", "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b", "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7", "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5", "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9", "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72", "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5", "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82", "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f", "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb", "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d", "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7", "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373", "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5", "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8", "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750", "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a", "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610", "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70", "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66", "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095", "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d", "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9", "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7", "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91", "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db", "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1", "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914", "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e", "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96", "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1", "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c", "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251", "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a", "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38", "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6", "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8", "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f", "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2", "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2", "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05", "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643", "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e", "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec", "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9", "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd", "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443", "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba", "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af", "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19", "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332", "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197", "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db", "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f", "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19", "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d", "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd", "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305", "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d", "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0", "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8", "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c", "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395", "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca", "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb", "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c", "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8", "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f", "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8", "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4", "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf", "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7", "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd", "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13", "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306", "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145", "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca", "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d", "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c", "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057", "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4", "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855", "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae", "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f", "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e", "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9", "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393", "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90", "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1", "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4", "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b", "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9", "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5", "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e", "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd", "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28", "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b", "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582", "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e", "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391", "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306", "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41", "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639", "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a", "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619", "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005", "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79", "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e", "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9", "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc", "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a", "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e", "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832", "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179", "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125", "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a", "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a", "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a", "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169", "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2", "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427", "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a", "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa", "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa", "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a", "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020", "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e", "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58", "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67", "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b", "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19", "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a", "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc", "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c", "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66", "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1", "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206", "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531", "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f", "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0", "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d", "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25", "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3", "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3", "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17", "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10", "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45", "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375", "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe", "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553", "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d", "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"}}, "numpy": {"version": "2.5.2", "files": {"numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b", "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11", "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972", "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a", "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2", "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6", "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb", "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2", "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926", "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881", "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a", "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0", "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476", "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee", "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af", "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627", "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b", "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c", "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78", "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950", "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d", "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5", "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66", "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2", "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2", "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395", "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf", "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605", "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5", "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106", "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c", "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49", "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417", "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8", "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca", "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807", "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b", "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e", "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332", "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3", "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957", "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2", "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0", "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81", "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a", "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea", "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d", "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159", "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582", "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af", "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c", "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2", "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d", "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224", "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec", "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a", "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489", "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67", "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a", "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143", "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a", "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31", "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d", "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847", "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f", "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f", "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b", "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0", "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf", "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477", "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2", "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650", "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1", "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd", "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a", "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4", "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc", "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41", "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111", "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008", "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d", "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a", "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19", "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068", "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72", "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01", "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c", "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c", "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099", "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0", "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a", "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761", "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca", "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e", "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6", "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc", "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8", "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446", "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe", "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc", "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9", "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca", "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288", "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76", "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0", "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4", "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76", "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669", "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808", "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987", "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a", "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f", "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36", "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2", "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b", "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605", "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002", "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b", "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33", "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8", "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1", "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7", "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1", "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284", "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c", "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24", "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5", "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e", "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310", "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf", "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9", "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9", "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c", "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a", "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27", "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c", "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275", "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436", "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5", "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714", "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550", "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df", "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822", "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93", "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92", "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b", "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2", "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930", "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca", "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c", "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf", "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07", "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306", "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf", "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5", "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142", "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406", "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a", "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795", "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab", "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c", "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c", "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8", "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537", "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e", "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74", "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec", "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0", "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7", "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a", "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0", "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d", "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822", "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8", "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137", "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37", "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3", "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576", "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681", "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529", "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491", "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6", "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873", "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4", "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4", "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281", "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547", "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0", "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09", "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f", "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d", "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4", "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7", "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc", "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3", "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9", "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e", "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e", "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82", "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f", "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7", "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e", "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36", "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6", "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d", "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026", "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777", "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386", "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb", "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599", "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07", "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa", "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b", "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f", "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0", "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72", "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b", "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f", "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d", "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b", "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d", "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e", "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131", "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4", "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0", "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460", "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771", "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116", "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd", "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e", "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48", "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb", "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5", "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545", "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc", "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec", "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862", "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb", "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939", "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea", "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195", "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435", "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0", "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292", "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b", "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074", "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6", "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4", "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874", "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792", "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202", "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292", "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c", "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc", "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f", "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b", "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c", "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79", "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4", "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a", "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af", "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324", "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46", "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780", "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed", "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab", "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c", "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5", "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e", "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74", "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4", "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f", "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98", "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004", "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3", "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c", "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca", "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2", "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f", "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d", "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c", "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781", "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953", "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e", "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5", "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828", "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417", "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425", "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11", "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2", "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642", "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6", "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5", "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718", "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16", "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782", "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c", "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5", "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9", "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53", "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709", "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4", "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47", "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca", "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917", "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8", "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f", "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2", "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824", "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d", "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3", "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396", "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25", "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af", "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d", "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6", "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033", "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418", "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84", "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352", "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99", "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228", "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca", "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82", "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78", "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b", "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9", "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0", "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5", "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801", "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c", "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc", "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b", "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b", "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3", "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639", "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e", "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0", "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5", "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945", "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b", "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f", "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45", "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931", "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3", "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c", "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213", "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5", "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9", "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2", "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4", "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13", "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e", "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37", "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557", "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc", "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9", "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363", "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a", "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5", "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32", "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498", "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049", "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7", "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4", "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0", "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc", "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166", "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682", "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482", "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a", "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e", "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196", "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed", "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a", "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723", "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14", "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5", "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2", "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392", "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759", "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee", "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe", "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd", "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe", "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0", "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c", "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4", "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94", "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147", "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1", "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c", "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665", "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b", "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02", "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff", "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67", "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94", "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0", "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0", "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509", "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda", "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0", "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1", "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796", "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3", "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5", "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14", "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297", "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54", "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"}}}, "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]", "sha256": "0505bcc315797f8fb5772bc6693d82a3315d6365507cddc472073011faf089e2"}, "producer_sha256": "de31d0be74b02e620e07ce82523bfa32fd07c6dfc7f275e53d24611beec47658", "before": {"page_bytes": 16384, "reclaimable_bytes": 22329720832, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    85229.\nPages active:                                1101839.\nPages inactive:                              1091171.\nPages speculative:                             32659.\nPages throttled:                                   0.\nPages wired down:                             181493.\nPages purgeable:                                2005.\n\"Translation faults\":                     1061545996.\nPages copy-on-write:                        63772716.\nPages zero filled:                        1904182064.\nPages reactivated:                          92999068.\nPages purged:                               10738424.\nFile-backed pages:                           1275664.\nAnonymous pages:                              950005.\nPages stored in compressor:                  1080112.\nPages occupied by compressor:                 593014.\nDecompressions:                             22875459.\nCompressions:                               32334788.\nPageins:                                   530464342.\nPageouts:                                     327934.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 131345.\nPages tagged resident:                         94891.\nPages tagged compressed:                       36454.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          110.\nPages tag-storage non-tag pageable:            93024.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5264640.\nTagged compressions:                          427223.\nTagged decompressions:                        355608.\n"}, "source_fixture": {"path": "layer-2-pass-0.safetensors", "layer": 2, "step": 0, "bytes": 3268867, "sha256": "41f902b5def7478e089d7611f0284f13b0211f14cd960c7a94b5fc83577ed427", "keys": ["conv", "hidden", "state"]}, "expanded_equals_whole": true, "memory": {"current_bytes": 475857904, "lifetime_peak_bytes": 475857904, "rss_peak_bytes": 434683904}, "fixture": {"path": "attention.safetensors", "bytes": 572658, "sha256": "5c5a2af3e5c1cc401a695c3a504268752ee19ee3709eedb3f6f1a30531756d66"}, "qualification": "unproven"}
````

### vq-attention-3.2-v2-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-model-arithmetic-v4-supervision/identity.json

Original bytes: 2400. SHA-256: `88352d31ba39385d201f36639f9ab94928a7bb8bff7c0672dc3a51d166c0c074`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-model-native-v4/slotstream",
    "quantization-check",
    "--kernels",
    "--trunk-fixture-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-trunk-3.2-v3"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22415327232,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    54893.\nPages active:                                1110932.\nPages inactive:                              1105090.\nPages speculative:                             43057.\nPages throttled:                                   0.\nPages wired down:                             180060.\nPages purgeable:                                2821.\n\"Translation faults\":                     1064327558.\nPages copy-on-write:                        64051994.\nPages zero filled:                        1906144912.\nPages reactivated:                          93018483.\nPages purged:                               10748497.\nFile-backed pages:                           1310409.\nAnonymous pages:                              948670.\nPages stored in compressor:                  1076251.\nPages occupied by compressor:                 591535.\nDecompressions:                             22877565.\nCompressions:                               32335063.\nPageins:                                   535544735.\nPageouts:                                     328530.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128358.\nPages tagged resident:                         92620.\nPages tagged compressed:                       35738.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          196.\nPages tag-storage non-tag pageable:            92938.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5210688.\nTagged compressions:                          427226.\nTagged decompressions:                        355718.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-model-arithmetic-v4-supervision/receipt.json

Original bytes: 2136. SHA-256: `7729c24f4f4d34a9d5d7623b57699a32775a9d0e20ab353a35bb3ad17a3f9050`.

````text
{
  "exit_code": -5,
  "failure": null,
  "sampled_peak_bytes": 478856176,
  "samples": 78,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22087532544,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    33556.\nPages active:                                1130318.\nPages inactive:                              1104905.\nPages speculative:                             43617.\nPages throttled:                                   0.\nPages wired down:                             181242.\nPages purgeable:                                2836.\n\"Translation faults\":                     1064426350.\nPages copy-on-write:                        64054142.\nPages zero filled:                        1906235168.\nPages reactivated:                          93018485.\nPages purged:                               10748497.\nFile-backed pages:                           1311724.\nAnonymous pages:                              967116.\nPages stored in compressor:                  1076050.\nPages occupied by compressor:                 591505.\nDecompressions:                             22877766.\nCompressions:                               32335063.\nPageins:                                   535545709.\nPageouts:                                     328530.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 129270.\nPages tagged resident:                         93621.\nPages tagged compressed:                       35649.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5162.\nPages tag-storage free:                          232.\nPages tag-storage non-tag pageable:            92902.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5193920.\nTagged compressions:                          427226.\nTagged decompressions:                        355807.\n"
  },
  "seconds": 4.6268783749999995
}
````

### vq-model-arithmetic-v4-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-model-arithmetic-v4-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-model-arithmetic-v5-supervision/identity.json

Original bytes: 2400. SHA-256: `d3f5a9c33d55b4577a0caa2adb05e6a7fd5f1470a4dd3c300cc225776df11893`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-model-native-v5/slotstream",
    "quantization-check",
    "--kernels",
    "--trunk-fixture-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-trunk-3.2-v3"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22775660544,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70707.\nPages active:                                1104344.\nPages inactive:                              1070665.\nPages speculative:                             58708.\nPages throttled:                                   0.\nPages wired down:                             181566.\nPages purgeable:                                1899.\n\"Translation faults\":                     1067638007.\nPages copy-on-write:                        64172253.\nPages zero filled:                        1908931599.\nPages reactivated:                          93187662.\nPages purged:                               10758227.\nFile-backed pages:                           1317510.\nAnonymous pages:                              916207.\nPages stored in compressor:                  1089584.\nPages occupied by compressor:                 599527.\nDecompressions:                             22947524.\nCompressions:                               32431538.\nPageins:                                   544142292.\nPageouts:                                     329110.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128118.\nPages tagged resident:                         92485.\nPages tagged compressed:                       35633.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5228.\nPages tag-storage free:                          124.\nPages tag-storage non-tag pageable:            92944.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5185152.\nTagged compressions:                          428912.\nTagged decompressions:                        356487.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-model-arithmetic-v5-supervision/receipt.json

Original bytes: 2130. SHA-256: `df10f6d1367fbae1a7733986673bd1473bb8b417740a475930691405e2665ce5`.

````text
{
  "exit_code": -11,
  "failure": null,
  "sampled_peak_bytes": 488719344,
  "samples": 80,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22529064960,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    49050.\nPages active:                                1133590.\nPages inactive:                              1073168.\nPages speculative:                             59397.\nPages throttled:                                   0.\nPages wired down:                             170971.\nPages purgeable:                                7586.\n\"Translation faults\":                     1067727646.\nPages copy-on-write:                        64173192.\nPages zero filled:                        1909022013.\nPages reactivated:                          93187662.\nPages purged:                               10758227.\nFile-backed pages:                           1318429.\nAnonymous pages:                              947726.\nPages stored in compressor:                  1089432.\nPages occupied by compressor:                 599458.\nDecompressions:                             22947672.\nCompressions:                               32431538.\nPageins:                                   544142406.\nPageouts:                                     329110.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128196.\nPages tagged resident:                         92565.\nPages tagged compressed:                       35631.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5228.\nPages tag-storage free:                          168.\nPages tag-storage non-tag pageable:            92900.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5184640.\nTagged compressions:                          428912.\nTagged decompressions:                        356489.\n"
  },
  "seconds": 4.786266542
}
````

### vq-model-arithmetic-v5-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-model-arithmetic-v5-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-model-arithmetic-v6-supervision/identity.json

Original bytes: 2400. SHA-256: `fd3d43a4ad9a2634099d3f246f06df491c0b0e339519dc55b5de40c17262a5cb`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-model-native-v6/slotstream",
    "quantization-check",
    "--kernels",
    "--trunk-fixture-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-trunk-3.2-v3"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21419229184,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    81814.\nPages active:                                1090942.\nPages inactive:                              1066815.\nPages speculative:                             57223.\nPages throttled:                                   0.\nPages wired down:                             191462.\nPages purgeable:                                6730.\n\"Translation faults\":                     1069688743.\nPages copy-on-write:                        64343121.\nPages zero filled:                        1910226175.\nPages reactivated:                          93190522.\nPages purged:                               10761505.\nFile-backed pages:                           1218782.\nAnonymous pages:                              996198.\nPages stored in compressor:                  1083725.\nPages occupied by compressor:                 596863.\nDecompressions:                             22952791.\nCompressions:                               32431538.\nPageins:                                   544205764.\nPageouts:                                     331453.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 146281.\nPages tagged resident:                        110841.\nPages tagged compressed:                       35440.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 7711.\nPages tag-storage free:                          323.\nPages tag-storage non-tag pageable:            90262.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5166016.\nTagged compressions:                          428912.\nTagged decompressions:                        356635.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-model-arithmetic-v6-supervision/receipt.json

Original bytes: 2134. SHA-256: `c5ca1f7b699a758cd053552c6539e01d7b49f1b3a40603957b6edf527b400323`.

````text
{
  "exit_code": 1,
  "failure": null,
  "sampled_peak_bytes": 473072576,
  "samples": 73,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21647409152,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    79373.\nPages active:                                1106828.\nPages inactive:                              1067185.\nPages speculative:                             61356.\nPages throttled:                                   0.\nPages wired down:                             173763.\nPages purgeable:                               18013.\n\"Translation faults\":                     1069732621.\nPages copy-on-write:                        64344140.\nPages zero filled:                        1910268456.\nPages reactivated:                          93190572.\nPages purged:                               10761505.\nFile-backed pages:                           1223867.\nAnonymous pages:                             1011502.\nPages stored in compressor:                  1083719.\nPages occupied by compressor:                 596860.\nDecompressions:                             22952794.\nCompressions:                               32431538.\nPageins:                                   544206564.\nPageouts:                                     331453.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 146206.\nPages tagged resident:                        110772.\nPages tagged compressed:                       35434.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 7710.\nPages tag-storage free:                          329.\nPages tag-storage non-tag pageable:            90257.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5165888.\nTagged compressions:                          428912.\nTagged decompressions:                        356638.\n"
  },
  "seconds": 4.341999584000001
}
````

### vq-model-arithmetic-v6-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-model-arithmetic-v6-supervision/stderr.txt

Original bytes: 154. SHA-256: `6229f72cc8f566a224c38eca427f097b75522864850c41295695e50f4ac3673b`.

````text
Error: MLX Error: float64 is not supported on the GPU at <HOME>/Projects/slotstream/.build/checkouts/mlx-swift/Source/Cmlx/mlx-c/mlx/c/ops.cpp:456
````

### frozen-model-native-v4/build-identity.json

Original bytes: 29367. SHA-256: `173c06ac15a6373d24021e583e0e8d0a2023982f942a2aca492736483ab43486`.

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
    "Sources/Slotstream/Layers.swift": "2bec5d87b89f84e23d214b43e1b5cb28311319dbd54df33b1b30a5e7058773e9",
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
    "Sources/Slotstream/VQArithmetic.swift": "d8badc8ab432b069124808d712431bd029e8a79d7cf05871b82645b8bf2ef3d9",
    "Sources/Slotstream/VQCheckpoint.swift": "ef94b0c97c99f69be4ca6e801a6b5f74a8f48117537094f9a0a55b32f72f0a12",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "37ae933a76e926f1abcef8df6902375fdf3613b5cec50fb168e766f6ae0cace5",
    "Sources/Slotstream/VQKernelSources.swift": "ea98803b719f0916e7c2ba6ce53f9d85c624d72a691959cb843fb3abf50653d9",
    "Sources/Slotstream/VQModelProbe.swift": "9c7cb9f38f20903b3cebd1f644d8973a13ff6dcadfe6c204a500eb577ca4483a",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQRecord.swift": "c772ade2085bf9cceb30e2c697a60e350c4ef5474b550bc77510fa051da43925",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+QuantizationFixtures.swift": "ba0be64d8fed21c0e85cf080aafbabdfef557e351d1d4a080b8894c38e663593",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "6f67b41a3f12cc164b7f478c0725f157f176321aa079151abf4b2ab616a7869a",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "798ecd52d1d716360cbb9c90508d7c5564c617e55a5858d8cb5eaa3ae44f5467",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "5234f431d16e769d16127283e77934ebffc6eb02aacdb15abfff10e21067f7c3",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "0c7032f5fed7581b74e3674df1dfd6b08ad6feebb5ece3b903fc6da1db310e68",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "e25d9405271d6be0d57b22d0970c3677a962038d786a418f418a3047b5cbf9c7",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "fa1b3d033982c75aebd0f4d78a7e568e01e620cc9e1f31b7f1ed9a939721fbd6",
  "binary_sha256": "214c2107afe5ee9cc51a60a420fb63f12d618536ae8631f3d6eb0fc2d279a3ff",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
