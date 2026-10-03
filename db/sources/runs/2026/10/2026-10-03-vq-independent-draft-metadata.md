---
type: run
created: 2026-10-03T10:50:40.073998+00:00
updated: 2026-10-03T10:50:40.073998+00:00
summary: Independent VQ draft identity, storage ledger and adapter review
binary: 2f7020b03c17dbc7ab3de52018af2ee96445a9445c094356ef3037c5dc946a1a
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Independent VQ draft identity, storage ledger and adapter review
tool: bounded VQ research diagnostics
---

The three staged VQ packs carry the same hash-pinned mtp-head-q6.safetensors. A fresh complete-file hash of the 3.2 copy passes; the earlier complete-pack verifications bind the other copies. The header declares affine six-bit, group 32, full-attention layer index 3, independently of the main pack's eight-bit dense weights and vector-quantized experts. All 71 tensors and 20 quantized modules are covered. Payload is 2,297,552,576 bytes: 2,202,009,600 routed-expert bytes and 95,542,976 other tensor bytes. One expert record is 4,300,800 bytes and the largest tensor is 629,145,600 bytes. None is a process-memory floor or measured transient/cache allowance.

Tools/vq_draft_inventory.py authenticates bounded metadata, validates every tensor extent and the independent recipe, refuses symlink inputs and changed bytes, and optionally hashes the whole payload. Header-only results explicitly report payload_verified:false. Four focused tests cover inherited/wrong recipes, unknown expert overrides, incomplete families, corrupted extents, header/payload distinctions and tampered/symlink files. Static harness selection tests also pass. This is an inventory instrument, not a draft loader.

Nine source/license documents from VQLab revision a31c1f38e5752b2f116d6486019399a52aaa32cc are read as data and preserved with hashes. None is executed. The reviewed source uses block.* and mixer.* names, a fused fc.weight and per-stream hidden normalization. Existing Slotstream MTP uses separate projections and a full-width hidden norm. Further, the pinned PR architecture folds zero-centered norms at load, whereas the reviewed sidecar loader assumes the norm operator adds one. A compatible reference adapter must settle these conventions explicitly; stock loading is not accepted as proof. The shared head must not inherit trunk quantization, normalization or quality status. MTP execution, acceptance, memory behavior and speed remain unqualified. The prepared native binary field identifies the surrounding experiment only; this CPU metadata tool did not run that binary.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### capture-vq-draft-metadata-v1.py

Original bytes: 3109. SHA-256: `d5b0473279d26c7b646139d00a914e3ab19a615b7be06481fbdc5f4991fb8bee`.

Normalized bytes: 3109. SHA-256: `d5b0473279d26c7b646139d00a914e3ab19a615b7be06481fbdc5f4991fb8bee`.

````text
from pathlib import Path
import json,runpy,shutil
r=Path('.build/quantization-research');h=runpy.run_path(str(r/'capture-vq-kernel-cache-v1.py'));d=json.loads((r/'vq-draft-inventory-v1.json').read_text());assert d['payload_verified']
files=['capture-vq-draft-metadata-v1.py','vq-draft-header-audit-v1.json','vq-draft-inventory-v1.json','vq-draft-inventory-v1.log','vq-draft-inventory-tests-v1.log','vq-upstream-master-v1.json','vq-upstream-mtp-a31c1f3/receipt.json']
for entry in json.loads((r/'vq-upstream-mtp-a31c1f3/receipt.json').read_text())['files']:files+=['vq-upstream-mtp-a31c1f3/'+entry['path']]
for path in ['Tools/vq_draft_inventory.py','Tools/vq_draft_inventory_test.py','bench/quantization/draft-sidecar-v1-header.json']:
 target=r/'vq-draft-source-v1'/path;target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(path,target);files+=[str(target.relative_to(r))]
h['capture']('vq-independent-draft-metadata','Independent VQ draft identity, storage ledger and adapter review',
'''The three staged VQ packs carry the same hash-pinned mtp-head-q6.safetensors. A fresh complete-file hash of the 3.2 copy passes; the earlier complete-pack verifications bind the other copies. The header declares affine six-bit, group 32, full-attention layer index 3, independently of the main pack's eight-bit dense weights and vector-quantized experts. All 71 tensors and 20 quantized modules are covered. Payload is 2,297,552,576 bytes: 2,202,009,600 routed-expert bytes and 95,542,976 other tensor bytes. One expert record is 4,300,800 bytes and the largest tensor is 629,145,600 bytes. None is a process-memory floor or measured transient/cache allowance.

Tools/vq_draft_inventory.py authenticates bounded metadata, validates every tensor extent and the independent recipe, refuses symlink inputs and changed bytes, and optionally hashes the whole payload. Header-only results explicitly report payload_verified:false. Four focused tests cover inherited/wrong recipes, unknown expert overrides, incomplete families, corrupted extents, header/payload distinctions and tampered/symlink files. Static harness selection tests also pass. This is an inventory instrument, not a draft loader.

Nine source/license documents from VQLab revision a31c1f38e5752b2f116d6486019399a52aaa32cc are read as data and preserved with hashes. None is executed. The reviewed source uses block.* and mixer.* names, a fused fc.weight and per-stream hidden normalization. Existing Slotstream MTP uses separate projections and a full-width hidden norm. Further, the pinned PR architecture folds zero-centered norms at load, whereas the reviewed sidecar loader assumes the norm operator adds one. A compatible reference adapter must settle these conventions explicitly; stock loading is not accepted as proof. The shared head must not inherit trunk quantization, normalization or quality status. MTP execution, acceptance, memory behavior and speed remain unqualified. The prepared native binary field identifies the surrounding experiment only; this CPU metadata tool did not run that binary.''',files,'frozen-allocator-reuse-v1')
````

### vq-draft-header-audit-v1.json

Original bytes: 53552. SHA-256: `55ad070a7431314bf9ddddb078925a419edf717a719bb343e633e6488f7dcd9c`.

Normalized bytes: 53552. SHA-256: `55ad070a7431314bf9ddddb078925a419edf717a719bb343e633e6488f7dcd9c`.

````text
{
  "scope": "Read-only pinned draft-header audit; no execution or support claim",
  "packs": {
    "2.1": {
      "pin": {
        "path": "mtp-head-q6.safetensors",
        "bytes": 2297560747,
        "sha256": "31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585"
      },
      "header_bytes": 8163,
      "header_sha256": "c39b16ad910abc919c270ef22ab2fe1c3313c7c8107022be976a5607e05a5436",
      "metadata": {
        "format": "mlx",
        "mtplx_compatible": "false",
        "vqlab_mtp": "{\"bits\": 6, \"group_size\": 32, \"fa_idx\": 3}"
      },
      "tensor_count": 71,
      "dtypes": {
        "BF16": 49,
        "U32": 20,
        "F32": 2
      },
      "tensors": {
        "block.attn_hyper_connection.block_inject_weight.biases": {
          "data_offsets": [
            87231616,
            87234176
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.attn_hyper_connection.block_inject_weight.scales": {
          "data_offsets": [
            34286080,
            34288640
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.attn_hyper_connection.block_inject_weight.weight": {
          "data_offsets": [
            880486176,
            880516896
          ],
          "dtype": "U32",
          "shape": [
            4,
            1920
          ]
        },
        "block.attn_hyper_connection.hc_norm.weight": {
          "data_offsets": [
            1517056544,
            1517077024
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.biases": {
          "data_offsets": [
            34288640,
            34493440
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.scales": {
          "data_offsets": [
            2266975776,
            2267180576
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.weight": {
          "data_offsets": [
            2267180576,
            2269638176
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.biases": {
          "data_offsets": [
            195266336,
            195471136
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.scales": {
          "data_offsets": [
            141055616,
            141260416
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.weight": {
          "data_offsets": [
            195471136,
            197928736
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "block.mlp.gate.weight": {
          "data_offsets": [
            1517077536,
            1519698976
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560
          ]
        },
        "block.mlp.shared_expert.down_proj.biases": {
          "data_offsets": [
            86924416,
            87026816
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            20
          ]
        },
        "block.mlp.shared_expert.down_proj.scales": {
          "data_offsets": [
            87129216,
            87231616
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            20
          ]
        },
        "block.mlp.shared_expert.down_proj.weight": {
          "data_offsets": [
            1584006176,
            1585234976
          ],
          "dtype": "U32",
          "shape": [
            2560,
            120
          ]
        },
        "block.mlp.shared_expert.gate_proj.biases": {
          "data_offsets": [
            88217216,
            88319616
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.gate_proj.scales": {
          "data_offsets": [
            140748416,
            140850816
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.gate_proj.weight": {
          "data_offsets": [
            141362816,
            142591616
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.mlp.shared_expert.up_proj.biases": {
          "data_offsets": [
            87026816,
            87129216
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.up_proj.scales": {
          "data_offsets": [
            2273857216,
            2273959616
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.up_proj.weight": {
          "data_offsets": [
            881499936,
            882728736
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.mlp.shared_expert_gate.biases": {
          "data_offsets": [
            2271604256,
            2271604416
          ],
          "dtype": "BF16",
          "shape": [
            1,
            80
          ]
        },
        "block.mlp.shared_expert_gate.scales": {
          "data_offsets": [
            142591616,
            142591776
          ],
          "dtype": "BF16",
          "shape": [
            1,
            80
          ]
        },
        "block.mlp.shared_expert_gate.weight": {
          "data_offsets": [
            86922240,
            86924160
          ],
          "dtype": "U32",
          "shape": [
            1,
            480
          ]
        },
        "block.mlp.switch_mlp.down_proj.biases": {
          "data_offsets": [
            1585234976,
            1637663776
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560,
            20
          ]
        },
        "block.mlp.switch_mlp.down_proj.scales": {
          "data_offsets": [
            142796576,
            195225376
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560,
            20
          ]
        },
        "block.mlp.switch_mlp.down_proj.weight": {
          "data_offsets": [
            1637663776,
            2266809376
          ],
          "dtype": "U32",
          "shape": [
            512,
            2560,
            120
          ]
        },
        "block.mlp.switch_mlp.gate_proj.biases": {
          "data_offsets": [
            88319616,
            140748416
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.gate_proj.scales": {
          "data_offsets": [
            34493440,
            86922240
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.gate_proj.weight": {
          "data_offsets": [
            887705376,
            1516850976
          ],
          "dtype": "U32",
          "shape": [
            512,
            640,
            480
          ]
        },
        "block.mlp.switch_mlp.up_proj.biases": {
          "data_offsets": [
            197928736,
            250357536
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.up_proj.scales": {
          "data_offsets": [
            1531495456,
            1583924256
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.up_proj.weight": {
          "data_offsets": [
            251340576,
            880486176
          ],
          "dtype": "U32",
          "shape": [
            512,
            640,
            480
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.biases": {
          "data_offsets": [
            28907520,
            28910080
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.scales": {
          "data_offsets": [
            2266809376,
            2266811936
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.weight": {
          "data_offsets": [
            28910080,
            28940800
          ],
          "dtype": "U32",
          "shape": [
            4,
            1920
          ]
        },
        "block.mlp_hyper_connection.hc_norm.weight": {
          "data_offsets": [
            34060800,
            34081280
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.biases": {
          "data_offsets": [
            31398400,
            31603200
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.scales": {
          "data_offsets": [
            140850816,
            141055616
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.weight": {
          "data_offsets": [
            31603200,
            34060800
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.biases": {
          "data_offsets": [
            142591776,
            142796576
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.scales": {
          "data_offsets": [
            882728736,
            882933536
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.weight": {
          "data_offsets": [
            28940800,
            31398400
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "block.self_attn.indexer.index_qk_proj.biases": {
          "data_offsets": [
            885145376,
            885247776
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.self_attn.indexer.index_qk_proj.scales": {
          "data_offsets": [
            141260416,
            141362816
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.self_attn.indexer.index_qk_proj.weight": {
          "data_offsets": [
            882933536,
            884162336
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.self_attn.indexer.k_layernorm.weight": {
          "data_offsets": [
            1516850976,
            1516851232
          ],
          "dtype": "BF16",
          "shape": [
            128
          ]
        },
        "block.self_attn.indexer.q_layernorm.weight": {
          "data_offsets": [
            86924160,
            86924416
          ],
          "dtype": "BF16",
          "shape": [
            128
          ]
        },
        "block.self_attn.k_norm.weight": {
          "data_offsets": [
            1517077024,
            1517077536
          ],
          "dtype": "BF16",
          "shape": [
            256
          ]
        },
        "block.self_attn.k_proj.biases": {
          "data_offsets": [
            2266811936,
            2266893856
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.k_proj.scales": {
          "data_offsets": [
            2273775296,
            2273857216
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.k_proj.weight": {
          "data_offsets": [
            880516896,
            881499936
          ],
          "dtype": "U32",
          "shape": [
            512,
            480
          ]
        },
        "block.self_attn.o_proj.biases": {
          "data_offsets": [
            884162336,
            885145376
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            192
          ]
        },
        "block.self_attn.o_proj.scales": {
          "data_offsets": [
            250357536,
            251340576
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            192
          ]
        },
        "block.self_attn.o_proj.weight": {
          "data_offsets": [
            1519698976,
            1531495456
          ],
          "dtype": "U32",
          "shape": [
            2560,
            1152
          ]
        },
        "block.self_attn.q_norm.weight": {
          "data_offsets": [
            1517056032,
            1517056544
          ],
          "dtype": "BF16",
          "shape": [
            256
          ]
        },
        "block.self_attn.q_proj.biases": {
          "data_offsets": [
            2269638176,
            2271604256
          ],
          "dtype": "BF16",
          "shape": [
            12288,
            80
          ]
        },
        "block.self_attn.q_proj.scales": {
          "data_offsets": [
            2271809216,
            2273775296
          ],
          "dtype": "BF16",
          "shape": [
            12288,
            80
          ]
        },
        "block.self_attn.q_proj.weight": {
          "data_offsets": [
            2273959616,
            2297552576
          ],
          "dtype": "U32",
          "shape": [
            12288,
            480
          ]
        },
        "block.self_attn.v_proj.biases": {
          "data_offsets": [
            2266893856,
            2266975776
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.v_proj.scales": {
          "data_offsets": [
            1583924256,
            1584006176
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.v_proj.weight": {
          "data_offsets": [
            87234176,
            88217216
          ],
          "dtype": "U32",
          "shape": [
            512,
            480
          ]
        },
        "fc.weight": {
          "data_offsets": [
            0,
            26214400
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            5120
          ]
        },
        "mixer.hc_norm.weight": {
          "data_offsets": [
            28887040,
            28907520
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "mixer.input_mix_weight_down.biases": {
          "data_offsets": [
            26224640,
            26429440
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "mixer.input_mix_weight_down.scales": {
          "data_offsets": [
            1516851232,
            1517056032
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "mixer.input_mix_weight_down.weight": {
          "data_offsets": [
            26429440,
            28887040
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "mixer.input_mix_weight_up.biases": {
          "data_offsets": [
            2271604416,
            2271809216
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "mixer.input_mix_weight_up.scales": {
          "data_offsets": [
            34081280,
            34286080
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "mixer.input_mix_weight_up.weight": {
          "data_offsets": [
            885247776,
            887705376
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "norm_e.weight": {
          "data_offsets": [
            26214400,
            26224640
          ],
          "dtype": "F32",
          "shape": [
            2560
          ]
        },
        "norm_h.weight": {
          "data_offsets": [
            195225376,
            195266336
          ],
          "dtype": "F32",
          "shape": [
            10240
          ]
        }
      }
    },
    "3.2": {
      "pin": {
        "path": "mtp-head-q6.safetensors",
        "bytes": 2297560747,
        "sha256": "31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585"
      },
      "header_bytes": 8163,
      "header_sha256": "c39b16ad910abc919c270ef22ab2fe1c3313c7c8107022be976a5607e05a5436",
      "metadata": {
        "format": "mlx",
        "mtplx_compatible": "false",
        "vqlab_mtp": "{\"bits\": 6, \"group_size\": 32, \"fa_idx\": 3}"
      },
      "tensor_count": 71,
      "dtypes": {
        "BF16": 49,
        "U32": 20,
        "F32": 2
      },
      "tensors": {
        "block.attn_hyper_connection.block_inject_weight.biases": {
          "data_offsets": [
            87231616,
            87234176
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.attn_hyper_connection.block_inject_weight.scales": {
          "data_offsets": [
            34286080,
            34288640
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.attn_hyper_connection.block_inject_weight.weight": {
          "data_offsets": [
            880486176,
            880516896
          ],
          "dtype": "U32",
          "shape": [
            4,
            1920
          ]
        },
        "block.attn_hyper_connection.hc_norm.weight": {
          "data_offsets": [
            1517056544,
            1517077024
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.biases": {
          "data_offsets": [
            34288640,
            34493440
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.scales": {
          "data_offsets": [
            2266975776,
            2267180576
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.weight": {
          "data_offsets": [
            2267180576,
            2269638176
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.biases": {
          "data_offsets": [
            195266336,
            195471136
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.scales": {
          "data_offsets": [
            141055616,
            141260416
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.weight": {
          "data_offsets": [
            195471136,
            197928736
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "block.mlp.gate.weight": {
          "data_offsets": [
            1517077536,
            1519698976
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560
          ]
        },
        "block.mlp.shared_expert.down_proj.biases": {
          "data_offsets": [
            86924416,
            87026816
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            20
          ]
        },
        "block.mlp.shared_expert.down_proj.scales": {
          "data_offsets": [
            87129216,
            87231616
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            20
          ]
        },
        "block.mlp.shared_expert.down_proj.weight": {
          "data_offsets": [
            1584006176,
            1585234976
          ],
          "dtype": "U32",
          "shape": [
            2560,
            120
          ]
        },
        "block.mlp.shared_expert.gate_proj.biases": {
          "data_offsets": [
            88217216,
            88319616
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.gate_proj.scales": {
          "data_offsets": [
            140748416,
            140850816
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.gate_proj.weight": {
          "data_offsets": [
            141362816,
            142591616
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.mlp.shared_expert.up_proj.biases": {
          "data_offsets": [
            87026816,
            87129216
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.up_proj.scales": {
          "data_offsets": [
            2273857216,
            2273959616
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.up_proj.weight": {
          "data_offsets": [
            881499936,
            882728736
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.mlp.shared_expert_gate.biases": {
          "data_offsets": [
            2271604256,
            2271604416
          ],
          "dtype": "BF16",
          "shape": [
            1,
            80
          ]
        },
        "block.mlp.shared_expert_gate.scales": {
          "data_offsets": [
            142591616,
            142591776
          ],
          "dtype": "BF16",
          "shape": [
            1,
            80
          ]
        },
        "block.mlp.shared_expert_gate.weight": {
          "data_offsets": [
            86922240,
            86924160
          ],
          "dtype": "U32",
          "shape": [
            1,
            480
          ]
        },
        "block.mlp.switch_mlp.down_proj.biases": {
          "data_offsets": [
            1585234976,
            1637663776
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560,
            20
          ]
        },
        "block.mlp.switch_mlp.down_proj.scales": {
          "data_offsets": [
            142796576,
            195225376
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560,
            20
          ]
        },
        "block.mlp.switch_mlp.down_proj.weight": {
          "data_offsets": [
            1637663776,
            2266809376
          ],
          "dtype": "U32",
          "shape": [
            512,
            2560,
            120
          ]
        },
        "block.mlp.switch_mlp.gate_proj.biases": {
          "data_offsets": [
            88319616,
            140748416
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.gate_proj.scales": {
          "data_offsets": [
            34493440,
            86922240
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.gate_proj.weight": {
          "data_offsets": [
            887705376,
            1516850976
          ],
          "dtype": "U32",
          "shape": [
            512,
            640,
            480
          ]
        },
        "block.mlp.switch_mlp.up_proj.biases": {
          "data_offsets": [
            197928736,
            250357536
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.up_proj.scales": {
          "data_offsets": [
            1531495456,
            1583924256
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.up_proj.weight": {
          "data_offsets": [
            251340576,
            880486176
          ],
          "dtype": "U32",
          "shape": [
            512,
            640,
            480
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.biases": {
          "data_offsets": [
            28907520,
            28910080
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.scales": {
          "data_offsets": [
            2266809376,
            2266811936
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.weight": {
          "data_offsets": [
            28910080,
            28940800
          ],
          "dtype": "U32",
          "shape": [
            4,
            1920
          ]
        },
        "block.mlp_hyper_connection.hc_norm.weight": {
          "data_offsets": [
            34060800,
            34081280
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.biases": {
          "data_offsets": [
            31398400,
            31603200
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.scales": {
          "data_offsets": [
            140850816,
            141055616
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.weight": {
          "data_offsets": [
            31603200,
            34060800
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.biases": {
          "data_offsets": [
            142591776,
            142796576
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.scales": {
          "data_offsets": [
            882728736,
            882933536
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.weight": {
          "data_offsets": [
            28940800,
            31398400
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "block.self_attn.indexer.index_qk_proj.biases": {
          "data_offsets": [
            885145376,
            885247776
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.self_attn.indexer.index_qk_proj.scales": {
          "data_offsets": [
            141260416,
            141362816
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.self_attn.indexer.index_qk_proj.weight": {
          "data_offsets": [
            882933536,
            884162336
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.self_attn.indexer.k_layernorm.weight": {
          "data_offsets": [
            1516850976,
            1516851232
          ],
          "dtype": "BF16",
          "shape": [
            128
          ]
        },
        "block.self_attn.indexer.q_layernorm.weight": {
          "data_offsets": [
            86924160,
            86924416
          ],
          "dtype": "BF16",
          "shape": [
            128
          ]
        },
        "block.self_attn.k_norm.weight": {
          "data_offsets": [
            1517077024,
            1517077536
          ],
          "dtype": "BF16",
          "shape": [
            256
          ]
        },
        "block.self_attn.k_proj.biases": {
          "data_offsets": [
            2266811936,
            2266893856
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.k_proj.scales": {
          "data_offsets": [
            2273775296,
            2273857216
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.k_proj.weight": {
          "data_offsets": [
            880516896,
            881499936
          ],
          "dtype": "U32",
          "shape": [
            512,
            480
          ]
        },
        "block.self_attn.o_proj.biases": {
          "data_offsets": [
            884162336,
            885145376
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            192
          ]
        },
        "block.self_attn.o_proj.scales": {
          "data_offsets": [
            250357536,
            251340576
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            192
          ]
        },
        "block.self_attn.o_proj.weight": {
          "data_offsets": [
            1519698976,
            1531495456
          ],
          "dtype": "U32",
          "shape": [
            2560,
            1152
          ]
        },
        "block.self_attn.q_norm.weight": {
          "data_offsets": [
            1517056032,
            1517056544
          ],
          "dtype": "BF16",
          "shape": [
            256
          ]
        },
        "block.self_attn.q_proj.biases": {
          "data_offsets": [
            2269638176,
            2271604256
          ],
          "dtype": "BF16",
          "shape": [
            12288,
            80
          ]
        },
        "block.self_attn.q_proj.scales": {
          "data_offsets": [
            2271809216,
            2273775296
          ],
          "dtype": "BF16",
          "shape": [
            12288,
            80
          ]
        },
        "block.self_attn.q_proj.weight": {
          "data_offsets": [
            2273959616,
            2297552576
          ],
          "dtype": "U32",
          "shape": [
            12288,
            480
          ]
        },
        "block.self_attn.v_proj.biases": {
          "data_offsets": [
            2266893856,
            2266975776
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.v_proj.scales": {
          "data_offsets": [
            1583924256,
            1584006176
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.v_proj.weight": {
          "data_offsets": [
            87234176,
            88217216
          ],
          "dtype": "U32",
          "shape": [
            512,
            480
          ]
        },
        "fc.weight": {
          "data_offsets": [
            0,
            26214400
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            5120
          ]
        },
        "mixer.hc_norm.weight": {
          "data_offsets": [
            28887040,
            28907520
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "mixer.input_mix_weight_down.biases": {
          "data_offsets": [
            26224640,
            26429440
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "mixer.input_mix_weight_down.scales": {
          "data_offsets": [
            1516851232,
            1517056032
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "mixer.input_mix_weight_down.weight": {
          "data_offsets": [
            26429440,
            28887040
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "mixer.input_mix_weight_up.biases": {
          "data_offsets": [
            2271604416,
            2271809216
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "mixer.input_mix_weight_up.scales": {
          "data_offsets": [
            34081280,
            34286080
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "mixer.input_mix_weight_up.weight": {
          "data_offsets": [
            885247776,
            887705376
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "norm_e.weight": {
          "data_offsets": [
            26214400,
            26224640
          ],
          "dtype": "F32",
          "shape": [
            2560
          ]
        },
        "norm_h.weight": {
          "data_offsets": [
            195225376,
            195266336
          ],
          "dtype": "F32",
          "shape": [
            10240
          ]
        }
      }
    },
    "4.4": {
      "pin": {
        "path": "mtp-head-q6.safetensors",
        "bytes": 2297560747,
        "sha256": "31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585"
      },
      "header_bytes": 8163,
      "header_sha256": "c39b16ad910abc919c270ef22ab2fe1c3313c7c8107022be976a5607e05a5436",
      "metadata": {
        "format": "mlx",
        "mtplx_compatible": "false",
        "vqlab_mtp": "{\"bits\": 6, \"group_size\": 32, \"fa_idx\": 3}"
      },
      "tensor_count": 71,
      "dtypes": {
        "BF16": 49,
        "U32": 20,
        "F32": 2
      },
      "tensors": {
        "block.attn_hyper_connection.block_inject_weight.biases": {
          "data_offsets": [
            87231616,
            87234176
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.attn_hyper_connection.block_inject_weight.scales": {
          "data_offsets": [
            34286080,
            34288640
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.attn_hyper_connection.block_inject_weight.weight": {
          "data_offsets": [
            880486176,
            880516896
          ],
          "dtype": "U32",
          "shape": [
            4,
            1920
          ]
        },
        "block.attn_hyper_connection.hc_norm.weight": {
          "data_offsets": [
            1517056544,
            1517077024
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.biases": {
          "data_offsets": [
            34288640,
            34493440
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.scales": {
          "data_offsets": [
            2266975776,
            2267180576
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_down.weight": {
          "data_offsets": [
            2267180576,
            2269638176
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.biases": {
          "data_offsets": [
            195266336,
            195471136
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.scales": {
          "data_offsets": [
            141055616,
            141260416
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.attn_hyper_connection.input_mix_weight_up.weight": {
          "data_offsets": [
            195471136,
            197928736
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "block.mlp.gate.weight": {
          "data_offsets": [
            1517077536,
            1519698976
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560
          ]
        },
        "block.mlp.shared_expert.down_proj.biases": {
          "data_offsets": [
            86924416,
            87026816
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            20
          ]
        },
        "block.mlp.shared_expert.down_proj.scales": {
          "data_offsets": [
            87129216,
            87231616
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            20
          ]
        },
        "block.mlp.shared_expert.down_proj.weight": {
          "data_offsets": [
            1584006176,
            1585234976
          ],
          "dtype": "U32",
          "shape": [
            2560,
            120
          ]
        },
        "block.mlp.shared_expert.gate_proj.biases": {
          "data_offsets": [
            88217216,
            88319616
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.gate_proj.scales": {
          "data_offsets": [
            140748416,
            140850816
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.gate_proj.weight": {
          "data_offsets": [
            141362816,
            142591616
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.mlp.shared_expert.up_proj.biases": {
          "data_offsets": [
            87026816,
            87129216
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.up_proj.scales": {
          "data_offsets": [
            2273857216,
            2273959616
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.mlp.shared_expert.up_proj.weight": {
          "data_offsets": [
            881499936,
            882728736
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.mlp.shared_expert_gate.biases": {
          "data_offsets": [
            2271604256,
            2271604416
          ],
          "dtype": "BF16",
          "shape": [
            1,
            80
          ]
        },
        "block.mlp.shared_expert_gate.scales": {
          "data_offsets": [
            142591616,
            142591776
          ],
          "dtype": "BF16",
          "shape": [
            1,
            80
          ]
        },
        "block.mlp.shared_expert_gate.weight": {
          "data_offsets": [
            86922240,
            86924160
          ],
          "dtype": "U32",
          "shape": [
            1,
            480
          ]
        },
        "block.mlp.switch_mlp.down_proj.biases": {
          "data_offsets": [
            1585234976,
            1637663776
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560,
            20
          ]
        },
        "block.mlp.switch_mlp.down_proj.scales": {
          "data_offsets": [
            142796576,
            195225376
          ],
          "dtype": "BF16",
          "shape": [
            512,
            2560,
            20
          ]
        },
        "block.mlp.switch_mlp.down_proj.weight": {
          "data_offsets": [
            1637663776,
            2266809376
          ],
          "dtype": "U32",
          "shape": [
            512,
            2560,
            120
          ]
        },
        "block.mlp.switch_mlp.gate_proj.biases": {
          "data_offsets": [
            88319616,
            140748416
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.gate_proj.scales": {
          "data_offsets": [
            34493440,
            86922240
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.gate_proj.weight": {
          "data_offsets": [
            887705376,
            1516850976
          ],
          "dtype": "U32",
          "shape": [
            512,
            640,
            480
          ]
        },
        "block.mlp.switch_mlp.up_proj.biases": {
          "data_offsets": [
            197928736,
            250357536
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.up_proj.scales": {
          "data_offsets": [
            1531495456,
            1583924256
          ],
          "dtype": "BF16",
          "shape": [
            512,
            640,
            80
          ]
        },
        "block.mlp.switch_mlp.up_proj.weight": {
          "data_offsets": [
            251340576,
            880486176
          ],
          "dtype": "U32",
          "shape": [
            512,
            640,
            480
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.biases": {
          "data_offsets": [
            28907520,
            28910080
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.scales": {
          "data_offsets": [
            2266809376,
            2266811936
          ],
          "dtype": "BF16",
          "shape": [
            4,
            320
          ]
        },
        "block.mlp_hyper_connection.block_inject_weight.weight": {
          "data_offsets": [
            28910080,
            28940800
          ],
          "dtype": "U32",
          "shape": [
            4,
            1920
          ]
        },
        "block.mlp_hyper_connection.hc_norm.weight": {
          "data_offsets": [
            34060800,
            34081280
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.biases": {
          "data_offsets": [
            31398400,
            31603200
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.scales": {
          "data_offsets": [
            140850816,
            141055616
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_down.weight": {
          "data_offsets": [
            31603200,
            34060800
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.biases": {
          "data_offsets": [
            142591776,
            142796576
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.scales": {
          "data_offsets": [
            882728736,
            882933536
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "block.mlp_hyper_connection.input_mix_weight_up.weight": {
          "data_offsets": [
            28940800,
            31398400
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "block.self_attn.indexer.index_qk_proj.biases": {
          "data_offsets": [
            885145376,
            885247776
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.self_attn.indexer.index_qk_proj.scales": {
          "data_offsets": [
            141260416,
            141362816
          ],
          "dtype": "BF16",
          "shape": [
            640,
            80
          ]
        },
        "block.self_attn.indexer.index_qk_proj.weight": {
          "data_offsets": [
            882933536,
            884162336
          ],
          "dtype": "U32",
          "shape": [
            640,
            480
          ]
        },
        "block.self_attn.indexer.k_layernorm.weight": {
          "data_offsets": [
            1516850976,
            1516851232
          ],
          "dtype": "BF16",
          "shape": [
            128
          ]
        },
        "block.self_attn.indexer.q_layernorm.weight": {
          "data_offsets": [
            86924160,
            86924416
          ],
          "dtype": "BF16",
          "shape": [
            128
          ]
        },
        "block.self_attn.k_norm.weight": {
          "data_offsets": [
            1517077024,
            1517077536
          ],
          "dtype": "BF16",
          "shape": [
            256
          ]
        },
        "block.self_attn.k_proj.biases": {
          "data_offsets": [
            2266811936,
            2266893856
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.k_proj.scales": {
          "data_offsets": [
            2273775296,
            2273857216
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.k_proj.weight": {
          "data_offsets": [
            880516896,
            881499936
          ],
          "dtype": "U32",
          "shape": [
            512,
            480
          ]
        },
        "block.self_attn.o_proj.biases": {
          "data_offsets": [
            884162336,
            885145376
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            192
          ]
        },
        "block.self_attn.o_proj.scales": {
          "data_offsets": [
            250357536,
            251340576
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            192
          ]
        },
        "block.self_attn.o_proj.weight": {
          "data_offsets": [
            1519698976,
            1531495456
          ],
          "dtype": "U32",
          "shape": [
            2560,
            1152
          ]
        },
        "block.self_attn.q_norm.weight": {
          "data_offsets": [
            1517056032,
            1517056544
          ],
          "dtype": "BF16",
          "shape": [
            256
          ]
        },
        "block.self_attn.q_proj.biases": {
          "data_offsets": [
            2269638176,
            2271604256
          ],
          "dtype": "BF16",
          "shape": [
            12288,
            80
          ]
        },
        "block.self_attn.q_proj.scales": {
          "data_offsets": [
            2271809216,
            2273775296
          ],
          "dtype": "BF16",
          "shape": [
            12288,
            80
          ]
        },
        "block.self_attn.q_proj.weight": {
          "data_offsets": [
            2273959616,
            2297552576
          ],
          "dtype": "U32",
          "shape": [
            12288,
            480
          ]
        },
        "block.self_attn.v_proj.biases": {
          "data_offsets": [
            2266893856,
            2266975776
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.v_proj.scales": {
          "data_offsets": [
            1583924256,
            1584006176
          ],
          "dtype": "BF16",
          "shape": [
            512,
            80
          ]
        },
        "block.self_attn.v_proj.weight": {
          "data_offsets": [
            87234176,
            88217216
          ],
          "dtype": "U32",
          "shape": [
            512,
            480
          ]
        },
        "fc.weight": {
          "data_offsets": [
            0,
            26214400
          ],
          "dtype": "BF16",
          "shape": [
            2560,
            5120
          ]
        },
        "mixer.hc_norm.weight": {
          "data_offsets": [
            28887040,
            28907520
          ],
          "dtype": "BF16",
          "shape": [
            10240
          ]
        },
        "mixer.input_mix_weight_down.biases": {
          "data_offsets": [
            26224640,
            26429440
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "mixer.input_mix_weight_down.scales": {
          "data_offsets": [
            1516851232,
            1517056032
          ],
          "dtype": "BF16",
          "shape": [
            320,
            320
          ]
        },
        "mixer.input_mix_weight_down.weight": {
          "data_offsets": [
            26429440,
            28887040
          ],
          "dtype": "U32",
          "shape": [
            320,
            1920
          ]
        },
        "mixer.input_mix_weight_up.biases": {
          "data_offsets": [
            2271604416,
            2271809216
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "mixer.input_mix_weight_up.scales": {
          "data_offsets": [
            34081280,
            34286080
          ],
          "dtype": "BF16",
          "shape": [
            10240,
            10
          ]
        },
        "mixer.input_mix_weight_up.weight": {
          "data_offsets": [
            885247776,
            887705376
          ],
          "dtype": "U32",
          "shape": [
            10240,
            60
          ]
        },
        "norm_e.weight": {
          "data_offsets": [
            26214400,
            26224640
          ],
          "dtype": "F32",
          "shape": [
            2560
          ]
        },
        "norm_h.weight": {
          "data_offsets": [
            195225376,
            195266336
          ],
          "dtype": "F32",
          "shape": [
            10240
          ]
        }
      }
    }
  }
}
````

### vq-draft-inventory-v1.json

Original bytes: 986. SHA-256: `bcc2a8e0379a9aba3b0c0704365b4512eed9ba52bf6959a31c53be909fb6b0cd`.

Normalized bytes: 986. SHA-256: `bcc2a8e0379a9aba3b0c0704365b4512eed9ba52bf6959a31c53be909fb6b0cd`.

````text
{
  "schema": 1,
  "scope": "independent draft storage and layout inventory",
  "qualification": "unproven",
  "file_bytes": 2297560747,
  "expected_file_sha256": "31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585",
  "header_sha256": "c39b16ad910abc919c270ef22ab2fe1c3313c7c8107022be976a5607e05a5436",
  "payload_verified": true,
  "limits": "Storage geometry only; no process floor, draft-cache, transient, acceptance or speed qualification.",
  "quantization": {
    "kind": "affine",
    "bits": 6,
    "group_size": 32
  },
  "full_attention_layer_index": 3,
  "tensor_count": 71,
  "quantized_modules": 20,
  "tensor_payload_bytes": 2297552576,
  "expert_payload_bytes": 2202009600,
  "expert_record_bytes": 4300800,
  "other_tensor_bytes": 95542976,
  "largest_tensor_bytes": 629145600,
  "normalization_and_fusion": "unqualified; raw sidecar conventions require an independent adapter",
  "trunk_binding": "unqualified",
  "legacy_mtp_loader_compatible": false
}
````

### vq-draft-inventory-v1.log

Original bytes: 928. SHA-256: `9c49a2b223c7edd38a8a7b99f067473be073b6d35d2f71e00c47fd8ca31bc0bf`.

Normalized bytes: 928. SHA-256: `9c49a2b223c7edd38a8a7b99f067473be073b6d35d2f71e00c47fd8ca31bc0bf`.

````text
{"schema": 1, "scope": "independent draft storage and layout inventory", "qualification": "unproven", "file_bytes": 2297560747, "expected_file_sha256": "31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585", "header_sha256": "c39b16ad910abc919c270ef22ab2fe1c3313c7c8107022be976a5607e05a5436", "payload_verified": true, "limits": "Storage geometry only; no process floor, draft-cache, transient, acceptance or speed qualification.", "quantization": {"kind": "affine", "bits": 6, "group_size": 32}, "full_attention_layer_index": 3, "tensor_count": 71, "quantized_modules": 20, "tensor_payload_bytes": 2297552576, "expert_payload_bytes": 2202009600, "expert_record_bytes": 4300800, "other_tensor_bytes": 95542976, "largest_tensor_bytes": 629145600, "normalization_and_fusion": "unqualified; raw sidecar conventions require an independent adapter", "trunk_binding": "unqualified", "legacy_mtp_loader_compatible": false}
````

### vq-draft-inventory-tests-v1.log

Original bytes: 232. SHA-256: `54acfc2ee1b8bb3e60b9349672c6cac474b047e221c16fd3b787bb73657503a4`.

Normalized bytes: 232. SHA-256: `54acfc2ee1b8bb3e60b9349672c6cac474b047e221c16fd3b787bb73657503a4`.

````text
....
----------------------------------------------------------------------
Ran 4 tests in 0.004s

OK
..............................
----------------------------------------------------------------------
Ran 30 tests in 20.486s

OK
````

### vq-upstream-master-v1.json

Original bytes: 81. SHA-256: `4c20a9a3cd8aa260cdd0bb384bcc0367a502cff24dacc74c0eac40592c42299f`.

Normalized bytes: 81. SHA-256: `4c20a9a3cd8aa260cdd0bb384bcc0367a502cff24dacc74c0eac40592c42299f`.

````text
{"date":"2026-10-02T23:48:05Z","sha":"a31c1f38e5752b2f116d6486019399a52aaa32cc"}
````

### vq-upstream-mtp-a31c1f3/receipt.json

Original bytes: 3251. SHA-256: `1e8eea6e465f7e555a0849a8bc796c889976eb4b1f8a817894433fd4628f34ca`.

Normalized bytes: 3251. SHA-256: `1e8eea6e465f7e555a0849a8bc796c889976eb4b1f8a817894433fd4628f34ca`.

````text
{
  "repo": "noahzelezny/VQLab",
  "revision": "a31c1f38e5752b2f116d6486019399a52aaa32cc",
  "scope": "Read-only independent draft-adapter review; nothing executed",
  "files": [
    {
      "path": "LICENSE",
      "bytes": 11358,
      "sha256": "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30",
      "git_blob": "d645695673349e3947e8e5ae42332d0ac3164cd7",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/LICENSE"
    },
    {
      "path": "docs/MTP.md",
      "bytes": 39450,
      "sha256": "a54fac7a0cfaf1d872afc500e12cb9d3faf5875ba9f2854d5bab2664f86f5b32",
      "git_blob": "fa2a8ea7575920995b295fbc18dd6b2ab075b995",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/docs/MTP.md"
    },
    {
      "path": "docs/MTP-USAGE.md",
      "bytes": 14014,
      "sha256": "ab4e7f998cffdda4290c4e091cbaf7f271d7332d2e954ffdbdee8238a697e805",
      "git_blob": "fe59639df0d0d13c6dfe786ee980ac050917d4e8",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/docs/MTP-USAGE.md"
    },
    {
      "path": "src/vqlab/mtp/mtp_head.py",
      "bytes": 11109,
      "sha256": "5944d29f222b610d003d4ff32d489dd42a15601a79255c2cbc68a968588dae6d",
      "git_blob": "f6f5b1bb33d1ba3cde147a5ee17fd952b3cd3818",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/src/vqlab/mtp/mtp_head.py"
    },
    {
      "path": "src/vqlab/mtp/runtime.py",
      "bytes": 3121,
      "sha256": "155f18b693ad603a74b67bcab704196e408cb1e0a9130daccd1c4a829a2dd0ab",
      "git_blob": "e83198f86484bf28f7c4243e2982fe761c37d493",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/src/vqlab/mtp/runtime.py"
    },
    {
      "path": "src/vqlab/assemble/mtp_pack.py",
      "bytes": 6487,
      "sha256": "ad203f57299ffeb3bd3591d02685fee9d9b3bef269f394e55440108d7efe99f5",
      "git_blob": "1b34d163042ad7866ee17418b6df5ef081654636",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/src/vqlab/assemble/mtp_pack.py"
    },
    {
      "path": "src/vqlab/assemble/mtp_extract.py",
      "bytes": 5566,
      "sha256": "fd9342141e6b6fe7f1085017711f8e440099dc4415644b9b821ef7a820aa88cb",
      "git_blob": "df112e6b32805d814066bf7a894a5594676b1dc1",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/src/vqlab/assemble/mtp_extract.py"
    },
    {
      "path": "src/vqlab/mtp/caches.py",
      "bytes": 5158,
      "sha256": "af086f2545640a9264890a1b0302369a5ee65f92e7940267484b9d6806e9ce04",
      "git_blob": "7538960e80adcd488e9f8ef81821889c862940f7",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/src/vqlab/mtp/caches.py"
    },
    {
      "path": "src/vqlab/mtp/sampling.py",
      "bytes": 5899,
      "sha256": "c1f554771d1a053700036b3f54dc84a61c1d4705472debbf8dbaeb6a84af29b1",
      "git_blob": "7f156512aa7eb67e17228a4696bb85779e836991",
      "url": "https://github.com/noahzelezny/VQLab/blob/a31c1f38e5752b2f116d6486019399a52aaa32cc/src/vqlab/mtp/sampling.py"
    }
  ]
}
````

### vq-upstream-mtp-a31c1f3/LICENSE

Original bytes: 11358. SHA-256: `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30`.

Normalized bytes: 11358. SHA-256: `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30`.

````text

                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
````

### vq-upstream-mtp-a31c1f3/docs/MTP.md

Original bytes: 39450. SHA-256: `a54fac7a0cfaf1d872afc500e12cb9d3faf5875ba9f2854d5bab2664f86f5b32`.

Normalized bytes: 39450. SHA-256: `a54fac7a0cfaf1d872afc500e12cb9d3faf5875ba9f2854d5bab2664f86f5b32`.

````text
# MTP speculative decoding — findings per family

Working notes for the MTP arc. The README carries the user-facing summary;
this is where per-family evidence, falsified predictions and open questions
live, so the next family does not re-derive them.

Status 2026-08-31: one family shipped and measured (`qwen4_exp`), four
identified and unimplemented, one measurement instrument built.

---

## 1. What we depend on

A drafting head predicts token *t+2* from (trunk hidden state at *t*,
embedding of *t+1*). Each step verifies one speculative token inside a single
2-token trunk forward: accepted gives two tokens for one forward, rejected
rolls the caches back and replays.

The only mlx-lm contract used is `load() -> model` and
`model(tokens, cache=cache) -> logits`, plus one per-family capture point for
the pre-lm_head activation. Everything else is VQLab's decode loop
(`vqlab/mtp/`), so we are not forking a runtime.

**Head precision cannot affect output quality.** The trunk verifies every
drafted token, so a worse draft costs a rejection, never a different token.
This is the single most useful property of the whole technique: head
quantization is a pure speed/memory search with no quality gate to defend.
It is why `--expert-bits 3` is safe and why a trunk bit traded for a head bit
is NOT a symmetric trade — see §6.

---

## 2. Three rules that are settled by measurement

**(a) The RMSNorm gain convention differs per family, and getting it wrong
gives exactly 0.0 acceptance.** Both families studied store MTP norm gains as
a delta needing +1.0, and they resolve it in *opposite places*:

| family | how the +1.0 arrives | what the head must do |
|---|---|---|
| `qwen3_5` | conventional `nn.RMSNorm`; mlx-lm's trunk sanitize adds 1.0, but `mtp.*` loads OUTSIDE sanitize | **shift the stored gains** (measured 0.0000 -> 0.7285) |
| `qwen4_exp` | the arch's OWN zero-centered RMSNorm (`y = norm(x) * (1 + weight)`) adds it | **do not shift** — apply via `arch.RMSNorm` (0.0000 -> 0.6992) |

Pre-shifting a qwen4_exp head double-counts. Hand-rolling `n * w` for either
drops the +1.0. This one mistake was the entire original bug.

**(b) The head's cache offset IS its position signal.** `qwen4_exp`'s
attention takes rotary positions straight from `cache.offset`. Keep one head
row per *committed* token — seed over the prompt, advance two positions per
step after verification — and the offset is the true position by
construction. Worth **+5.9pp acceptance** (t=6.34, better on 12/12 prompts).
MTPLX documents the same invariant for this architecture.

**(c) Attention caches roll back by the offset DELTA, not a fixed count.**
Trimming a hardcoded 1 leaves a stale key while recurrent caches roll back 2,
and the streams drift silently.

---

## 3. Measurement methodology (learned the hard way)

**Acceptance is the reliable instrument; wall-clock is not.** Greedy decode is
deterministic, so acceptance reproduces to four decimals regardless of machine
state. Speedup on a laptop swung 1.135x-1.723x for the *same configuration*
until active cooling brought the baseline spread from 26% to 0.32%.

- **Quote the baseline spread next to any speedup**, or do not quote the
  speedup. It is the readout for whether the machine held still.
- **Repeats add nothing.** Re-running a greedy prompt reproduces its
  acceptance exactly. Independent PROMPTS are the replicates.
- **Steps within one generation are not independent trials.** They share a
  prefix; a binomial interval over one trajectory's N steps is far too narrow.
- **Pair across prompts.** Prompt difficulty dominates the spread; pairing
  removes it. `vqlab mtp-accept` does this.
- **Never measure acceptance on synthetic repeated text.** A prompt built by
  repeating filler drove acceptance to exactly 1.0 at 1k-16k tokens: the model
  continues the pattern and the head predicts it perfectly. Prefill timings
  from such a prompt are still valid (prefill does not care what the text
  says); every decode, acceptance and speedup number from it is worthless.
- **Do not use a palindromic run order.** `(a,b,c,d,d,c,b,a)` pins the middle
  configuration to both hottest slots — worse than no design. Use balanced
  blocks shuffled within each, plus a cooldown.

### Falsified predictions, recorded as falsified

| prediction | what happened |
|---|---|
| alignment worth +12.5pp (n=48, one prompt) | 1.53 sigma. Did not survive. |
| alignment "measured neutral / falsified" (n=256, one prompt) | ALSO wrong — no power to see a 5pp effect. Failure to reject is not evidence of absence. |
| the 397B's MTP norms use a different convention from its trunk (their gains sit outside the trunk's range, by inconsistent offsets) | wrong. The offset is a uniform +1.0; a different layer simply has different learned magnitudes. Comparing magnitudes across layers was never evidence about a convention. See §8. |
| head-cache growth would decay throughput inside a long request (the bug MTPLX documents) | not reproduced: over 8192 tokens peak memory moved 47.34 -> 47.60 GiB and throughput was flat within noise. Caveat below. |
| the +5.9pp acceptance would convert to a large speedup | it converts to **+1.58%** wall-clock — which is near the depth-1 ceiling, not a defect. See §7. My first explanation (the extra head forward eats it) was only a third of the story. |

---

## 4. Family status

| family | models | head in source? | status |
|---|---|---|---|
| `qwen4_exp` | Qwen3.8-Flash-Next | graft on disk | **DONE** — 0.817 acceptance, 1.25 GiB head, 1.58x |
| `qwen3_5_moe` | Qwen3.5-397B-A17B, Qwen3.6-35B-A3B | **YES**, 397B bf16 has 1553 tensors / 12.29 GiB | **head works** — 0.9023 acceptance, our best. But **1.000x speedup**: see below |
| `qwen3_5` | Qwen3.8-27B | **YES**, 15 tensors / 0.79 GiB | **DONE** — 0.7399 pooled acceptance (12 prompts, real loop), 0.49 GiB head |
| `glm5_next` | GLM-5.3-Flash | needs bf16 re-download | not implemented; no mlx-lm class (mlx-vlm has one) |
| `deepseek` | — | we have no build | not a target: oMLX and MTPLX already serve it natively |

**Every VQ artifact we publish declares `mtp_num_hidden_layers: 1` (or
`num_nextn_predict_layers: 1`) and ships zero MTP tensors.** This is not
specific to us — Qwen's own MLX uploads and the GLM-5.3 MLX conversions also
carry none. MLX conversion strips `mtp.*` systematically, which is why oMLX
and MTPLX publish their own re-added checkpoints, and why `mtp-pack` /
`mtp-graft` exist.

### `qwen3_5_moe` head shape (397B, read from the index)

Structurally a different animal from `qwen4_exp`, so it needs its own head
module rather than a parameter:

- single fused `mtp.fc.weight` (qwen4_exp splits `fc_embedding`/`fc_hidden`)
- 1541 of 1553 tensors are `mtp.layers.0.mlp` — **unfused per-expert**, like
  `glm5_next`, not qwen4_exp's fused `[E, 2I, H]` stack
- conventional `input_layernorm` / `post_attention_layernorm` + `mtp.norm`,
  not hyper-connections
- but it DOES share `pre_fc_norm_embedding` / `pre_fc_norm_hidden` naming
- 512 experts, 10 active, hidden 4096 — the head is itself a large MoE layer,
  so it must ship quantized (the qwen4_exp bf16 head cost ~44ms/forward and
  ate the entire speedup until quantized)

---

## 5. Open questions

**The MTP prefill tax is small — but the first measurement of it was wrong.**

A first attempt compared mlx-lm's `stream_generate` against ours and reported
10-15%, attributing all of it to the head. That was two errors in one number.
It charged to MTP (a) a difference between two prefill implementations, and
(b) an outright bug in ours: the loop did `mx.eval(model(chunk, cache=cache))`,
forcing the full `lm_head` projection for every prefill position and throwing
it away. MLX is lazy; mlx-lm evaluates `[c.state for c in cache]` precisely to
avoid that. Fixed in 11abdfc.

The correct control is our OWN loop with seeding on and off, head resident in
every condition (2.1bpw, e3q8, TTFT = prefill + first token):

| prompt | mlx-lm | ours, no seed | ours, seeded | tax_seed | tax_loop |
|--------|--------|---------------|--------------|----------|----------|
| 256    | 2.26s  | 2.40s  | 2.49s  | 0.10s (**4.2%**) | 0.14s (6.1%) |
| 1024   | 2.84s  | 3.15s  | 3.20s  | 0.04s (**1.3%**) | 0.32s (11.2%) |
| 4096   | 9.73s  | 10.63s | 11.12s | 0.49s (**4.6%**) | 0.91s (9.3%) |
| 16384  | 42.95s | 45.31s | 47.63s | 2.32s (**5.1%**) | 2.36s (5.5%) |

**Seeding the head over the prompt costs 1.3-5.1% of TTFT.** That is the
actual MTP prefill tax and it does not grow super-linearly, so windowed
seeding would be a small optimisation rather than a fix.

`tax_loop` (5.5-11.2%) is our prefill path against mlx-lm's, and its cause is
**NOT ISOLATED**. It was predicted to be a fixed constant — two extra forwards
before the first token, since our first speculative step draws a draft and
runs a 2-token verify where mlx-lm runs one 1-token forward — but it grows
with prompt length (0.14 -> 0.32 -> 0.91 -> 2.36s), so that explanation is
insufficient. What is established is that it is not the head: seeding is
controlled separately above. Total MTP prefill overhead against stock mlx-lm
is 7-15%, of which seeding is the smaller half.

**Prefill is chunked, and the head is seeded inside the chunk loop.** The
chunk width is `prefill_step_size` (default 2048, override
`VQLAB_PREFILL_CHUNK`); it exists to bound the prefill MEMORY TRANSIENT, which
is what OOMs a fat trunk on a long prompt (GLM-5.3: 102G of weights on a 128G
box). Each chunk is forced with `mx.eval` on the cache state and the captured
hidden, then `mx.clear_cache()` — the same semantics exo's generator uses.
Because the head's input at position j is `(h_j, x_{j+1})` for every prompt
position, the head is advanced PER CHUNK over `(h_i..h_{end-1},
x_{i+1}..x_{end})` rather than over a concatenation of every chunk's hidden
states: `head.advance` appends to the head cache in order, so the two are
identical, and the per-chunk form keeps nothing of size O(prompt) resident.
The width changes memory only, never the tokens
(`tests/test_mtp_prefill.py`).

**The VQ prefill tax remains unquantified.** Decoding codebooks costs more per
token at prefill than an affine kernel. The obvious comparison —
Flash-Next-VQ-2.1bpw (46G) against the stock affine 4-bit (96G) — is
confounded by size, though it is decisive in one direction: if the 46G VQ
artifact prefills SLOWER than the 96G affine one, the kernel tax is
unambiguous.

**The MTPLX strategy.** MTPLX decouples the rope offset from the cache offset
(passing `position_offset` explicitly) instead of making the offset true by
construction. That keeps ONE head forward per step with correct positions,
where our scheme needs two — plausibly capturing the +5.9pp acceptance at half
the head cost, and turning the +1.58% into something larger. It also enables
two things we currently cannot do:

- **windowed prompt seeding** (bounding the prefill cost above)
- **head-cache reset on long generations.** MTPLX measured an uncapped draft
  cache decaying 86 -> 25 tok/s within a single 34k-token request. Our head
  cache grows one row per committed token with nothing trimming it, so we
  inherit this bug and have simply never generated long enough to hit it.

Both are correctness-free by the verify contract — head state conditions
acceptance only.

**Serving with prompt-cache reuse.** Cross-request prefix reuse is disabled
because a reused trunk cache would mis-position the head. Pairing a head cache
with each cached prefix is the fix; the loop currently RAISES rather than
decoding at wrong positions.

**oMLX interop.** Tested 2026-08-31 against oMLX 0.6.4: a VQ artifact does not
load. Two causes were identified — mlx-vlm tensor namespace (`language_model.*`
vs our `model.*`), and `model_file` apparently not honoured on the mlx-vlm
path. **The second needs re-testing**: it was measured against a bundle
predating VQLab a5cf00a, which made the bundle resolve its base arch from
either runtime.

---

## 6. The v2 plan: fund the head from better technique, not a worse trunk

The proposal is NOT to spend trunk quality on the head. It is to pull more
quality out of the same bits — better fitting, better per-layer allocation,
better codebook use — so the reclaimed GiB funds the head while output quality
goes UP, not down. That is the size-targeting thesis applied to a new budget
line, and it is the version worth doing.

Two asymmetries make it favourable:

- **Head bits are quality-free.** The trunk verifies every drafted token, so
  the head can be quantized as hard as acceptance tolerates. Measured: experts
  at 3-bit is 1.25 GiB against 2.14, indistinguishable in both acceptance
  (-0.2pp, t=0.54) and speed (0.5%).
- **The head is rung-independent.** It is grafted from the upstream bf16 MTP
  tensors, not derived from the trunk's quantization, so ONE head file serves
  every rung of a model. Technique improvements to the trunk compound across
  rungs; the head cost is paid once.

What this needs before it becomes a release plan:

1. A trunk recipe that is measurably BETTER at equal or smaller size —
  priced with `vqlab kl` and `vqlab score` against the current rungs, not
  assumed. `docs/ONBOARDING.md` and `layer-leverage` are the existing tools.
2. The head's true cost per family (measured, not projected).
3. **Both prefill taxes quantified** (see §5). A decode speedup that is paid
  for at prefill is a different product for a chat user than for an agent.

The failure mode to avoid is shipping a v2 whose headline is "now with MTP"
while quality quietly regressed to pay for it. The gates that prevent that
already exist and are cheap to run.

---

## 7. Why we are stuck near 1.6x, and what actually moves it

At depth 1 every step emits exactly two tokens whatever happens — the
committed `t1`, plus either the accepted draft or the trunk's own `t2`.
Acceptance therefore only controls how often a rejection costs a replay
forward. That caps what acceptance can buy:

    tokens per unit cost = 2 / (1 + (1 - alpha) + h)      h = head cost in
                                                          trunk-forward units

The measured +1.58% from a 2.7pp acceptance change fits this with h ~ 0.5:
the ceiling for that delta is +2.24% with a free head, and the head absorbs
about a third of it. **The depth-1 loop is close to its own ceiling.** Chasing
acceptance further, or making the head cheaper, buys single-digit percentages.

### The empirical depth-1 ceiling is 1.95x

Measured by accident and worth more than the run it came from: with a
repetitive synthetic prompt the head drafts perfectly, and at **acceptance
1.0 the depth-1 loop hits 1.95x** (1.93-1.95x at 1k/4k/16k). That is the
ceiling of the CURRENT design. We sit at 1.58x with acceptance 0.78, so
roughly **+0.37x is available from acceptance alone**, with no depth-k work.

It also falsifies the analytic head-cost estimate above: at alpha = 1.0 that
model predicts 2/(1+h), so 1.95x implies h ~ 0.03, not the ~0.5 inferred from
the alignment delta. The model assumed a speculative seq=2 forward costs the
same as a baseline seq=1 forward, and the ledger measured seq=2 as CHEAPER
(49ms vs 61ms). Trust the empirical ceiling, not the algebra.

### Depth is the lever — but only at high acceptance

Tokens per trunk-forward, modelled (head = 0.5 trunk-forwards each, geometric
acceptance along the chain):

| acceptance | depth 1 | depth 2 | depth 3 |
|-----------|---------|---------|---------|
| 0.70 | 1.13 | 1.09 | 1.01 |
| **0.78 (us)** | **1.19** | 1.19 | 1.15 |
| 0.85 | 1.23 | 1.29 | 1.27 |
| 0.92 | 1.28 | 1.38 | 1.42 |
| 0.97 | 1.31 | 1.46 | 1.53 |

**At our acceptance, going deeper is worthless** — each extra drafted token
costs a head forward and is probably rejected. Depth only pays above ~0.85.
This is the model, not a measurement, but the shape of it is robust: it is why
oMLX reports 2.33-2.62x with **96.8-97.9%** acceptance and we report 1.58x
with 78%. Their win is acceptance first, depth second.

### Trunk quantization does NOT affect acceptance (tested, negative)

The obvious hypothesis was that our 0.78 is capped by drafting from a damaged
VQ trunk — the head was trained against bf16, and is being asked to predict
what a 2.1bpw trunk will do. **Measured on three rungs, 12 paired prompts
each, and it is false:**

| rung | pooled acceptance | within-rung sd |
|------|------------------|----------------|
| 2.1bpw | 0.8151 | 0.076 |
| 3.2bpw | 0.7823 | 0.089 |
| 4.4bpw | 0.8057 | 0.044 |

| paired | delta | t | verdict |
|--------|-------|---|---------|
| 2.1 - 3.2 | +3.01pp | 1.50 | not significant |
| 2.1 - 4.4 | +0.74pp | 0.34 | not significant |
| 3.2 - 4.4 | -2.27pp | -0.97 | not significant |

Not monotonic, nothing significant, and the effect is not even ordered by
trunk quality. **Prompt-to-prompt spread within one rung dwarfs anything
between rungs.**

Two consequences, one of them load-bearing for §6:

- **Trunk improvements and MTP are independent.** Better technique buys
  quality without giving back speedup, and without buying extra acceptance
  either. They simply do not interact. (This also retires the worry that a
  better trunk would be HARDER to draft for and would cost speed — it does
  not.)
- **Acceptance is a property of the WORKLOAD, not of our quantization.** It
  ranged 0.64-0.95 across twelve ordinary prompts on one model, and hit
  exactly 1.0 on repetitive synthetic text.

### Single-prompt acceptance is not comparable across rungs either

`bench_plan` / `mtp-bench` use ONE fixed prompt. On that prompt, acceptance
came out 0.7695 on Flash-Next 2.1bpw and 0.6445 on 3.2bpw -- a 12.5pp gap in
the direction that would say a better trunk drafts worse.

It is not a real effect, and the reason is structural rather than statistical:
two rungs decoding greedily from the same prompt produce DIFFERENT TEXT, so
their acceptance figures are measured on different content. Acceptance is a
property of the text being generated (§7), so comparing one trajectory to
another compares workloads, not models. The 12-prompt paired instrument says
what the single prompt cannot: 0.7823 at 3.2bpw against 0.8057 at 4.4bpw,
alongside 0.78-0.82 at 2.1bpw -- all one band, consistent with the N=3 paired
result that trunk quantization does not move acceptance.

Read speedup out of `mtp-bench`. Read acceptance out of `mtp-accept`.

### So cross-project acceptance numbers are close to meaningless

Given the above, comparing our 0.78 against oMLX's reported 96.8-97.9% says
almost nothing: the spread from workload alone is larger than the gap being
discussed. An easy prompt gets 1.0 on our own stack. Independent numbers on a
third-party Flash-Next MTP checkpoint report 58.3-89.5%, which brackets ours
rather than theirs.

**Any acceptance comparison across projects needs the same prompts.** Until
someone runs that, the honest statement is that the numbers are not
comparable, not that theirs is better.

Still untested and now the most plausible remaining lever:

- **Hidden-state variant.** MTPLX exposes `mtp_hidden_variant`
  (fc / pre_norm / post_norm / embedding / prev / mix) as a knob because it
  matters. We feed the hyper-connection mixer's input and have never swept the
  alternatives on this family. The dense-27B ablation put pre_norm 0.7285
  against post_norm 0.7188 — a near-tie there, untested here.

---

## 8. Working state (2026-08-31, end of session)

### Settled

**Long-request decay: not reproduced, with one caveat.** An 8192-token single
request on Flash-Next 2.1bpw grew peak memory by 0.26 GiB total (47.34 ->
47.60) and held throughput flat (35.7 tok/s at 2304 tokens, 32.0 at 8192 --
consistent with ordinary trunk KV growth, not an MTP-specific leak). The
caveat is real and limits what the second half of that run measures: from
about token 2000 the unattended generation degenerated into repetition and
window acceptance pinned at exactly 1.000, which is the known
degenerate-text artifact. So the MEMORY result stands (it is structural), and
the throughput result past ~2000 tokens is measuring the easy case.

- qwen4_exp shipped: 1.25 GiB head, acceptance 0.78-0.82, **1.58x** measured
  with a 0.32% baseline spread.
- Alignment (`align="committed"`) is worth +5.9pp at short prompts and
  **grows with context** (+3.9pp at 512, +9.8pp at 2048 on real prose).
- Trunk quantization does NOT affect acceptance (N=3 rungs, paired).
- Acceptance is a workload property: 0.64-0.95 on ordinary prompts, 1.0 on
  repetitive text. Depth-1 ceiling measured at **1.95x**.
- MTP prefill tax (seeding) is **1.3-5.1%**.
- `vqlab serve` works, and has now been soaked: **643 requests over 60
  minutes, zero errors, and every single one drafted.** The two numbers that
  matter are the ones that caught the earlier silent failure --- 644 `MTP:
  acceptance` lines (one per request) and **0** `Prompt processing progress`
  lines, which only stock mlx-lm emits. The patches held for the full hour.
  Throughput was flat: mean 26.76 tok/s, median 26.79, p05 25.18, p95 28.20,
  and first-half to second-half drift of **+0.41%**. Cold start was 522s to
  page 46 GiB over SMB, which is a storage number, not a serving one.

- Speedup by rung on Flash-Next, same fixed prompt: **1.58x** at 2.1bpw
  (acceptance 0.77), **1.52x** at 3.2bpw (0.64), **1.65x** at 4.4bpw (0.70).
  It tracks acceptance, not bit-width --- and since each rung writes different
  text, those three acceptance figures are three workloads, not three models
  (see SS7).

### The 397B (qwen3_5_moe): head module written, wiring measured

`vqlab/mtp_head_qwen35.py` covers both `qwen3_5` (dense 27B) and
`qwen3_5_moe` (397B); they differ only in the mlp the stock `DecoderLayer`
builds from `args.num_experts`, so one module serves both. Structurally it is
much simpler than the qwen4_exp head: one residual stream, so no
hyper-connections and no per-stream norm statistics, and the head's block is a
stock full-attention `DecoderLayer` that owns its own rope.

Three things about the head are **not recoverable from the checkpoint**, and
each wrong choice is a silent near-zero-acceptance failure with no error --
the same failure mode that made the qwen4_exp head look dead for a day. So
`vqlab mtp-probe35` sweeps them against a single trunk load. Measured on the
dense 27B (VQ-3.9bpw, 512 positions, literary corpus, control 0.596):

| norm_shift | fc_order | h_source | acceptance vs main greedy |
|---|---|---|---|
| 1.0 | **eh** | pre_norm | **0.6562** |
| 1.0 | **eh** | post_norm | **0.6582** |
| 1.0 | he | pre_norm | 0.0020 |
| 1.0 | he | post_norm | 0.0020 |
| 0.0 | any | any | **0.0000** (all four) |

- **`norm_shift = 1.0` is settled.** The family stores RMSNorm gains as
  deltas. Without the shift the head is exactly dead, in every other wiring.
- **`fc_order = "eh"` is settled** — `[embedding | hidden]` into the fused
  `fc`. The other order is chance.
- **`h_source` is NOT settled** and probably cannot be by this experiment: a
  one-token difference over 512 positions. `pre_fc_norm_hidden` is applied
  immediately afterwards and an RMSNorm of an already-normed vector is close
  to idempotent, so the two arms are nearly the same computation. Default
  `pre_norm`, on the argument that the head carrying its own hidden norm
  expects a raw hidden state.

The real decode loop -- cache rollback, alignment, verification, none of
which the probe exercises -- confirms it on the dense 27B: **0.7399 pooled
acceptance** over 12 prompts / 1511 steps (per-prompt 0.617 to 0.852), which
sits in the same band as qwen4_exp's 0.78-0.82. The teacher-forced probe read
0.656 on a literary corpus; the loop reads higher on chat prompts, consistent
with acceptance being a workload property (SS7) rather than the two
instruments disagreeing.

#### The 27B wall-clock, and a problem that is NOT about MTP

The 27B VQ-3.9bpw artifact benchmarks at a **0.43 tok/s baseline** on the M4 ---
roughly forty times too slow for a 12 GiB model on that machine. My first
explanation was SMB contention. That was wrong: a re-measure with the link
quiet reproduced it exactly (0.43 and 0.42 tok/s, 1063s per config both
times). Reproducible is not contention.

So the number to carry forward is not the 1.43x ratio --- which is a real
ratio inside a broken regime, and not comparable to Flash-Next's 1.58x --- but
the baseline itself. The control settles it: on the same machine, same
harness, same prompt, no head involved, stock `Qwen3.8-27B-8bit` generates at
**16.687 tok/s** and our `27B-VQ-3.9bpw` at **0.426 tok/s** --- 39x slower,
while using 7 GB LESS memory.

**That is a VQ finding, not an MTP finding, and it is the most consequential
thing this campaign turned up.** It is written up separately in
[DENSE-VQ-DECODE.md](DENSE-VQ-DECODE.md). The MoE VQ path measures clean
(Flash-Next 18.85 tok/s, 397B 17.59), so it points at the dense read path
specifically.

The general rule: a speedup ratio is only a compute speedup if the absolute
throughput is plausible for the model. Check the baseline against what the
machine should do BEFORE reading the ratio --- and when something looks like
contention, reproduce it before believing that.

#### The recurrent-cache trap (cost 30 minutes of a run going nowhere)

`cache_semantics` is not just tidiness for this family, it is the difference
between working and unusable. The trunk's cache list is MOSTLY recurrent --
48 `ArraysCache` to 16 `KVCache` on the 27B -- and under `"copy"` every one of
those GatedDeltaNet states is deep-copied once per speculative step. It does
not fail; generation just crawls. `check_snapshot_semantics` against a loaded
27B returns True (GatedDeltaNet reassigns its slots, `cache[0] = ...`, and mlx
arrays are immutable), so the family earns `"reassign"`. Prompt 0 gives
0.6328 under both paths, so this is a pure speed fix with the answer
unchanged.

The lesson generalises: for any family whose trunk is mostly linear/recurrent
attention, run `check_snapshot_semantics` BEFORE concluding anything about
speed. The conservative default is correct and slow, and slow looks like
broken.

The 397B head packs to **3.19 GiB** at experts-3-bit / rest-8-bit (from 12.29
GiB bf16, ratio 0.257); e4q8 is 3.91 GiB. Against the 101 GiB 2.2bpw rung
that is ~104 GiB resident, which fits the M4's 120 GiB wired limit but is the
one 397B rung that does.

#### The 397B result: the best acceptance we have measured, and no speedup

Both instruments agree the head is correct, and the wiring measured on the
dense 27B transferred to the MoE unchanged:

| instrument | result |
|---|---|
| probe, 512 positions, literary corpus (control 0.850) | eh/pre_norm **0.8320**, eh/post_norm **0.8516**; he 0.0039 / 0.0000 |
| real decode loop, 12 prompts / 1536 steps | **0.9023** pooled, per-prompt 0.836 to 0.953 |
| wall-clock, 2.2bpw rung, 103.25 GiB resident | spec 17.61 vs base 17.59 tok/s = **1.001x** |

0.9023 is the highest acceptance in this document --- higher than qwen4_exp's
0.78-0.82, which is what you would expect from a much stronger model
predicting its own next token. At that acceptance the depth-1 ceiling (SS7)
says roughly 1.8x. We measured 1.000x, twice, with baselines agreeing to
0.3%.

**The mechanism is measured.** Depth-1 swaps two seq=1 trunk forwards for one
seq=2 forward, so it pays only when the second token is nearly free.
`seqcost.py` measures that directly, and the two models could hardly differ
more:

| | Flash-Next 2.1bpw | 397B 2.2bpw |
|---|---|---|
| t(seq=1) | 52.30 ms | 54.48 ms |
| t(seq=2) | 46.66 ms | **81.24 ms** |
| **ratio seq2/seq1** | **0.892** | **1.491** |
| head / trunk1 | 0.099 | 0.168 |
| predicted at its acceptance | 1.80x | 1.15x |
| measured | 1.58x | 1.00x |

On Flash-Next the second token rides along free --- single-token decode is
overhead-bound, so a 2-token forward is *cheaper* than a 1-token one. On the
397B the second token costs half a forward again.

That ratio is fatal on its own. At 1.491 with a head at 0.168, the ceiling at
PERFECT acceptance is 2 x 54.48 / (81.24 + 9.17) = 1.205x predicted --- and
the cost model overpredicts by 12-14% on both models, so the real ceiling is
about 1.06x. No acceptance rate rescues this, and neither does a cheaper head:
the head is only a tenth of the denominator.

**Memory pressure was the obvious explanation, and it is wrong.** The 397B
sits at 103.25 GiB against a 120 GiB wired limit, so bandwidth-bound decode
was the natural guess. Flash-Next tests it directly, being the same
architecture at three residencies:

| model | resident | ratio seq2/seq1 |
|---|---|---|
| Flash-Next 2.1bpw | 46 GiB | 0.892 |
| Flash-Next 3.2bpw | 70 GiB | 0.874 |
| Flash-Next 4.4bpw | **95 GiB** | **0.838** |
| 397B 2.2bpw | 103 GiB | **1.491** |

The ratio does not climb with residency --- it falls slightly, and it is still
0.838 at 95 GiB, within 8 GiB of where the 397B sits. Memory pressure on this
machine does not produce a 1.49 ratio.

**So this is not a "needs a bigger machine" problem, and clustering the 397B
across M3+M4 will not fix it.** That is worth knowing before anyone spends a
day on exo for this.

**Our VQ path is not the cause either.** The dense-VQ investigation
(DENSE-VQ-DECODE.md) made "our kernels behave badly at some shapes" a live
hypothesis for the MoE side too. The 35B-A3B settles it, being the same model
in both forms:

| model | t(1) | t(2) | ratio |
|---|---|---|---|
| Flash-Next 2.1bpw (VQ) | 52.27 | 46.78 | **0.895** |
| 27B 8-bit (stock, dense) | 62.28 | 63.41 | 1.018 |
| 35B-A3B 8-bit (stock, MoE) | 12.27 | 14.02 | 1.143 |
| 35B-A3B 3.8bpw (VQ, MoE) | 16.94 | 20.07 | 1.185 |
| 397B 2.2bpw (VQ, MoE) | 54.54 | 81.35 | **1.492** |

VQ costs ~38% of absolute time on the 35B (16.94 vs 12.27) and barely touches
the ratio (1.185 vs 1.143). So VQ is not eating the n=2 discount.

**The real lesson is that Flash-Next is the outlier, not the 397B.** It is
the only model measured whose 2-token forward is CHEAPER than its 1-token
forward. Everything else sits at 1.02-1.19, and the 397B's 1.49 is the
extreme end of a normal spectrum rather than a pathology --- consistent with
it having by far the most active parameters (17B), so the marginal token
costs more and there is less fixed overhead to amortise. **Some of our
headline 1.58x is Flash-Next collecting a kernel-selection discount at n=1
that other models do not offer.**

#### Two measurement confounds found afterwards (2026-09-01)

Both were found by the expert-kernel session, in my measurements.

**A ~0.33 ms `mx.eval` submit floor.** A 4x4 matmul times the same as a real
kernel on the M3, so any per-call timing near a millisecond was measuring the
harness. This invalidates the MoE per-kernel microbenchmark wholesale (it
reported 0.30-0.52 ms/call and concluded "latency-bound, not
bandwidth-bound"); real per-kernel timing needs chained submits. It does NOT
move the seq2/seq1 numbers below, which are trunk forwards of 46-81 ms:
floor-correcting them changes Flash-Next by -0.07% and the 397B by +0.20%.

**A 36 GB VLM server resident on the M4 during the 397B runs** --- checked,
and it changed nothing. The 397B at 2.2bpw is 101 GiB, so with
`scout_vlm_server` alongside it that was ~137 GB on a 128 GB box, and every
397B timing here was taken under real memory pressure nobody was accounting
for. Re-measured on an idle M4 (VLM stopped, exo idle at <300 MB):

| | t(1) | t(2) | ratio |
|---|---|---|---|
| under a 36 GB tenant | 54.54 | 81.35 | 1.4916 |
| idle box, 2 reps | 54.86 | 81.33 | **1.4826 / 1.4803** |

A 0.6% shift. **The depth-1 no-payoff result is real and is not an artifact
of measurement conditions.** The 35B figures were never at risk (~16 GB).

Worth separating the two judgements: flagging the confound was right, and the
conclusion it threatened survived it. A confound that turns out not to bite
is still worth having measured rather than argued about.

#### Codebook residency does NOT explain it (a wrong claim, corrected)

This document briefly recorded that Flash-Next behaves differently because
its codebook is small enough for threadgroup memory (d=2, K=256, 1 KB) while
the 397B's (d=8, K=16384, 256 KB) must stream from device memory. That was
wrong, and it came from reading the FIRST entry of `vq_modules` and
generalising it to the model. The real distributions:

| model | expert modules |
|---|---|
| Flash-Next 2.1bpw | **138 x d=8 K=16384 pack=14**, 6 x d=2 K=256 |
| 397B 2.2bpw | 171 x d=8 K=16384 pack=14 |

The six d=2 modules are layer 0 alone. **Both models are dominated by the
same geometry and both stream the same 256 KB codebook from device memory**,
so residency cannot be what separates 0.895 from 1.492. The seq2/seq1 gap
remains unexplained; the active-parameter argument above (17B vs far fewer)
is still the only account that survives, and it is an argument rather than a
measurement.

The methodological error is the same one this document already records twice:
reading a property off one sample and asserting it of the population. Check
the distribution.

### The expert-kernel layout is not the cause either (measured)

The simdgroup-per-row expert kernels (E141, commit e7726dc) were built partly
on the theory that the 397B's ratio was launch/latency-bound in the expert
kernel. Measured on the same idle box:

| 397B 2.2bpw | t(1) | t(2) | ratio |
|---|---|---|---|
| thread-per-row (old) | 54.86 | 81.33 | 1.4826 |
| simdgroup-per-row | 53.43 | 80.26 | **1.50** |

The kernel is faster in absolute terms at every sequence length and the ratio
does not move. **So the seq2/seq1 gap is not expert-kernel launch latency
either.** Ruled out so far: memory pressure, our VQ path in general, codebook
residency, and now the expert-kernel layout. The only account still standing
is the crude one --- the 397B has 17B active parameters, so its marginal
token costs more and there is proportionally less fixed overhead to amortise
--- and that remains an argument rather than a measurement.

### A microbenchmark that inverted at real sizes

Worth carrying forward beyond MTP. The isolated expert kernel wins 1.35x at
N = 24-30 pairs in a microbenchmark, and the same layout made a whole-forward
seq=3 **13.6% slower** (108.4 vs 95.4 ms, reproducible to 0.1 ms over 2x40
reps). Dispatch is therefore gated on N <= 20 pairs as well as NGRP >= 32.

Two consequences. Decode (top-k 8-10) and the 397B's seq=2 (2 x 10 = 20 pairs,
measured 80.1 vs 81.3 in the new kernel's favour) keep the win, so speculative
decoding is inside the gate. And **any seqcost sweep at seq >= 3 is measuring
the OLD kernel by design** --- do not read those rows as evidence about the
new one.

That is the third harness artifact in this document, after the thermal
wall-clock spread and the mx.eval submit floor. The pattern is consistent
enough to state as a rule: a kernel measured alone is not the same kernel
measured in a model.

### Depth is the lever, and the 397B is the best candidate we have

SS7 already argued depth pays only at high acceptance. The 397B has the
highest acceptance in this document (0.9023), and at depth-1 that asset is
wasted. Working the measured scaling curves --- a depth-d step is ONE trunk
forward of length d+1, d head forwards, and 1 + a + ... + a^d committed
tokens in expectation:

| model | depth | seq | E[commit] | cost | predicted |
|---|---|---|---|---|---|
| Flash-Next | 1 | 2 | 1.78 | 51.99 ms | 1.790x |
| Flash-Next | **2** | 3 | 2.39 | 68.00 ms | **1.836x** |
| Flash-Next | 3 | 4 | 2.86 | 87.57 ms | 1.709x |
| 397B | 1 | 2 | 1.90 | 89.61 ms | 1.134x |
| 397B | **2** | 3 | 2.72 | 114.25 ms | **1.270x** |
| 397B | 3 | 4 | 3.45 | 156.38 ms | 1.179x |

(397B rows recomputed on the clean idle-box timings, seq1 53.43 / seq2 80.26 /
seq3 95.55 / seq4 128.33. The head-forward term is still the 9.35 ms measured
under the old conditions --- it was not re-measured clean, so treat the 397B
depth numbers as good to about a percent, not better. Note also that seq3 and
seq4 are OLD-kernel numbers per the N <= 20 gate above.)

Depth-2 is optimal for both, and it is worth far more to the 397B (+13%
relative) than to Flash-Next (+3%), precisely because acceptance is higher.

Two corrections to apply before believing 1.295x: the cost model overshot
depth-1 by ~13% on both models, and geometric decay (a^2) flatters a
multi-step draft, since step 2 feeds the head its own hidden state rather
than the trunk's. Realistically depth-2 on the 397B is **~1.1x** --- not
the 1.6x Flash-Next gets, but no longer nothing.

**So: "the 397B buys nothing" is true only of depth-1.** The head is correct,
drafts better than any other family we have, and is currently being run in
the one configuration that cannot use it. Implementing depth-2 is real work
(multi-step drafting off the head's own hidden state, per-step acceptance
decay to measure rather than assume) and is a scoping decision, not something
to start unasked.

#### Flash-Next: the depth-1 cost model, measured rather than assumed

`seqcost.py` measures the trade depth-1 actually makes. On Flash-Next 2.1bpw
at 256 context:

| quantity | measured |
|---|---|
| t(seq=1) trunk forward | 52.30 ms |
| t(seq=2) trunk forward | 46.66 ms |
| **ratio seq2/seq1** | **0.892** |
| head forward | 5.17 ms = **9.9%** of a trunk forward |
| predicted speedup at acceptance 0.78 | 1.796x |
| measured speedup | 1.58x |

Two things worth keeping. First, a 2-token forward is *cheaper* than a 1-token
forward (ratio 0.892) --- single-token decode is overhead-bound, so the second
token rides along free. That is exactly the condition depth-1 needs, and it is
why this model gets 1.58x. Second, the head costs 9.9% of a trunk forward,
which finally puts a measured number on the head-cost term that SS7 could only
bound (it inferred h ~ 0.03 from the 1.95x ceiling; the direct measurement says
0.099).

The model still overpredicts --- 1.80x against a measured 1.58x, a 12% gap ---
so it is a mechanism, not a calibration. Do not quote the predicted number.

#### h_source is now worth a second look

On the 27B, `post_norm` beat `pre_norm` by one token in 512 --- noise. On the
397B the gap is ten tokens (436 vs 426, paired on the same positions), still
small but no longer obviously nothing. The shipped default is `pre_norm`.
This is cheap to settle properly (it is a flag on an already-packed sidecar,
so it costs one model load) and should be settled before the family is
described as tuned.

#### A wrong inference, recorded

Earlier the same evening I compared the 397B's MTP norm gains against their
trunk counterparts, found no single offset that explained all of them, and
concluded in this document that "the ledger's +1.0 rule does not survive
contact with this checkpoint" and that the convention had to be swept because
it might not be a uniform shift.

The sweep says the offset **is** a uniform +1.0. The magnitudes differ from
the trunk's because it is a different layer doing a different job, not
because it uses a different convention. Comparing a norm's magnitude to
another layer's was never evidence about the convention; the only evidence
was `has_unsanitized_conv1d` (the 397B source stores `conv1d.weight` as
`[12288, 1, 4]`, i.e. unsanitized, so the trunk norms ARE shifted at load)
and, decisively, acceptance.

Sweeping was still the right call -- it just was not right for the reason I
gave.

````

### vq-upstream-mtp-a31c1f3/docs/MTP-USAGE.md

Original bytes: 14014. SHA-256: `ab4e7f998cffdda4290c4e091cbaf7f271d7332d2e954ffdbdee8238a697e805`.

Normalized bytes: 14014. SHA-256: `ab4e7f998cffdda4290c4e091cbaf7f271d7332d2e954ffdbdee8238a697e805`.

````text
# MTP speculative decoding — usage and measurements

Per-family findings and open questions live in [MTP.md](MTP.md).


VQLab also ships a decode strategy: **multi-token-prediction speculative
decoding** for any mlx-lm model that has an MTP drafting head. It is a
library, not a server and not a fork — mlx-lm loads the model and owns the
architecture; we replace only the decode loop.

```python
from mlx_lm import load
from vqlab import load_mtp_head, mtp_generate, mtp_stream_generate

model, tok = load(path, trust_remote_code=True)
head, _ = load_mtp_head(model, model_path=path)     # or sidecar=<file>

print(mtp_generate(model, tok, "Explain VQ.", head, temp=0.7, top_p=0.9))

for r in mtp_stream_generate(model, tok, "Explain VQ.", head, max_tokens=256):
    print(r.text, end="")                            # r.acceptance, r.steps, …
```

```bash
vqlab publish      --artifact <dir> --repo <owner/name>           # gated upload
vqlab mtp-extract  --src <bf16 checkpoint> --out <graft.safetensors>  # pull the head
vqlab mtp-pack     --model <artifact> --mtp <graft.safetensors>       # build sidecar
vqlab mtp-generate --model <artifact> --temp 0.7
vqlab mtp-accept   --model <artifact> --head q8=<sidecar>        # acceptance
vqlab mtp-bench    --model <artifact> --tokens 128               # speedup
```

### Supported families

A family is one table entry in `vqlab/mtp/registry.py` plus a head module;
nothing else in the package names an architecture.

| family | models | head module | measured |
|---|---|---|---|
| `qwen4_exp` | Qwen3.8-Flash-Next | `mtp_head.py` | 0.78–0.82 acceptance, **1.58x**, 1.25 GiB head |
| `qwen3_5` | Qwen3.8-27B (dense) | `mtp_head_qwen35.py` | 0.63–0.85 acceptance, 0.49 GiB head |
| `qwen3_5_moe` | Qwen3.5-397B-A17B, Qwen3.6-35B | `mtp_head_qwen35.py` | 3.19 GiB head (experts 3-bit) |

The qwen3_5 head has three wiring choices the checkpoint does not determine —
the RMSNorm delta convention, the concat order into the fused `fc`, and which
side of the trunk's final norm it reads. Each wrong choice drafts at chance
with no error, so `vqlab mtp-probe35` sweeps them against one model load
instead of trusting an argument. See [MTP.md](MTP.md).

The head drafts token t+2 from (trunk hidden at t, embedding of t+1), so each
step verifies one speculative token inside a single 2-token trunk forward:
accepted gives two tokens for one forward; rejected rolls the caches back and
replays, costing one extra forward and never a wrong token.

### Serving

```bash
vqlab serve --model <artifact-dir> [--sidecar mtp-head-e3q8.safetensors] --port 8080
```

An OpenAI-compatible endpoint at `http://127.0.0.1:8080/v1`. Without
`--sidecar` it serves the artifact with no drafting, which is the useful
default: a VQ artifact needs the codebook kernels in its own bundled
`model.py`, so the environment that runs it is not interchangeable, and
shipping a server we know loads our artifacts is most of the value.

It is an **adapter, not a server**. mlx-lm already ships a complete
OpenAI-compatible server and calls generation at exactly one site, so VQLab
borrows that surface — templates, streaming, stop sequences, request schema —
and replaces only the decode strategy. Four patch points, verified at startup;
`serve` refuses to start if any has moved, because a server that quietly stops
drafting still answers every request correctly and only looks slower.

Verified on the 2.1bpw rung: greedy and temperature+top_p to 256 tokens,
streaming SSE, natural stop, served acceptance 0.773–0.925 — matching the
offline `mtp-accept` sweep, which is what confirms the served loop is the
measured loop.

Known limits: single user, no continuous batching, no cross-request prefix
reuse (a reused prefix cache would mis-position the drafting head, so the loop
**raises** rather than decoding at wrong positions).

### Measured (Qwen3.8-Flash-Next, 6-bit head, greedy, 96 tokens)

> The table below is M3 Ultra. The 2026-08-31 measurements below it are M4
> Max over SMB — different core counts, bandwidth and thermals, so speedups
> are **not** comparable across the two. Only within-run comparisons are.

| rung   | head  | baseline   | speculative | speedup | acceptance |
|--------|-------|-----------|-------------|---------|------------|
| 2.1bpw | 6-bit | 16.07 t/s | 26.87 t/s   | 1.67x   | 0.708      |
| 3.2bpw | 6-bit | 15.19 t/s | 23.71 t/s   | 1.56x   | 0.625      |

Across runs: **1.56–1.80x (median 1.65x)**, acceptance 0.578–0.812 (median
0.679). The 6-bit head is **2.12 GiB resident**, measured as an
`mx.get_active_memory` delta. Sidecars are named outside mlx-lm's
`model*.safetensors` glob, so a model directory carrying one still loads
normally through the stock loader — the head is optional residency.

### What the speedup depends on

**The MTP speedup is a function of how predictable your text is, not a
property of the model.** The head drafts a token, the trunk verifies it, and
the gain is however often the draft was right. Measured on one model with one
head, acceptance ranged **0.64 to 0.95 across twelve ordinary prompts**, and
hit exactly **1.0** on repetitive synthetic text.

| workload | acceptance | speedup |
|----------|-----------|---------|
| hardest prompt measured | 0.64 | ~1.35x (implied) |
| typical prose questions | 0.78-0.82 | **1.58-1.65x (measured)** |
| easiest prompt measured | 0.95 | ~1.87x (implied) |
| repetitive / boilerplate | 1.00 | 1.95x (measured) |

Only the bolded row and the last are measured directly; the others are
implied by interpolating between them. The practical reading: the feature is
strongest on code completion, structured output and boilerplate — where
drafts land — and weakest on short high-entropy answers, where decode time
matters least anyway.

The same fact makes **cross-project acceptance numbers meaningless without
shared prompts**: the spread from workload alone (0.64-1.0) is wider than the
gaps usually quoted between implementations.

Trunk quantization, by contrast, does NOT affect acceptance — measured across
three rungs, paired, nothing significant. See [MTP.md](MTP.md).

### Speedup, measured on a thermally stable machine (2026-08-31)

2.1bpw rung, 512 tokens greedy, M4 Max with active cooling, 12 runs in
randomised balanced blocks with a 25s cooldown, each keeping its own adjacent
baseline:

| head | align | acceptance | speedup | tok/s |
|------|-------|-----------|---------|-------|
| q6 (2.12 GiB)   | committed | 0.7812 | **1.591x** ±0.0006 | 29.99 |
| e4q8 (1.55 GiB) | committed | 0.7773 | 1.586x ±0.0017 | 29.90 |
| e3q8 (1.25 GiB) | committed | 0.7695 | 1.583x ±0.0081 | 29.85 |
| q6 (2.12 GiB)   | legacy    | 0.7539 | 1.566x ±0.0044 | 29.52 |

Baseline **18.85 tok/s**, spread 18.83–18.89 across all twelve runs — **0.32%**.
The same measurement without active cooling spread 13.98–19.04 (26%) and was
worthless. The baseline spread is the readout for whether a speedup number
from a laptop means anything; quote it alongside, or do not quote the speedup.

**All three heads are within 0.5% of each other**, so the 1.25 GiB head buys
its 0.87 GiB back for essentially nothing in speed as well as acceptance.

The alignment fix is worth **+1.58% wall-clock** (t=9.7). That is close to
the most it *could* be worth, and the reason is structural rather than a
defect: at depth 1 each step emits exactly two tokens regardless, so
acceptance only changes how often a rejection costs a replay. On this prompt
the delta was 2.7pp, whose ceiling is +2.24% even with a free head; the
measured +1.58% implies the head costs ~0.5 of a trunk forward, absorbing
about a third of the available gain. Alignment's value is in acceptance, which
is what a deeper draft would spend — not in wall-clock at depth 1.

### Head-cache alignment: worth +5.9pp acceptance (2026-08-31)

`qwen4_exp` reads the head's rotary positions straight off its cache offset
(`Attention.__call__`: `offset = cache.offset`). The old loop advanced that
cache once per step while two tokens committed, rolled it back on every
rejection, and never seeded it over the prompt. `align="committed"` keeps one
head row per committed token, which makes the offset the true position by
construction.

Measured with `vqlab mtp-accept`: 12 independent prompts, 256 tokens each,
every prompt run through every configuration so the comparison is paired
(2.1bpw, M4 Max, one model load).

| head | committed | legacy | paired delta | t | wins |
|------|-----------|--------|--------------|---|------|
| q6 (2.12 GiB)   | 0.8171 | 0.7578 | **+5.92pp** | 6.34 | 12/12 |
| e4q8 (1.55 GiB) | 0.8105 | 0.7598 | +5.08pp | 4.17 | 11/12 |
| e3q8 (1.25 GiB) | 0.8151 | 0.7643 | +5.08pp | 4.14 | 11/12 |

1536 steps per cell. The effect replicates independently across all three
heads, and the 12/12 sign test alone is p ~ 0.0002.

**A methodological warning, recorded because we walked into it.** The first
attempt compared a single prompt and read +12.5pp at n=48 steps; the second
read +2.7pp at n=256 and was written up here as "measured neutral, prediction
falsified". Both were wrong, in opposite directions. Two errors caused it:

- *Steps are not independent trials.* Consecutive steps of one generation
  share a prefix, so a single trajectory's N steps carry far less information
  than N Bernoulli trials, and any binomial interval over them is too narrow.
- *Failure to reject is not evidence of absence.* The n=256 design had no
  power to see a 5pp effect; calling it falsified overstated the result as
  badly as the n=48 overclaim did.

Independent prompts are the replicates, and pairing removes prompt
difficulty — which dominates the spread. That design finds the effect at
t=6.34 where the previous one could not see it at all. Repeats do NOT help:
greedy decoding is deterministic, so re-running a prompt reproduces its
acceptance to four decimals and adds nothing.

### Mixed-bit heads: 41% smaller for nothing

The 512-expert MoE stack is 4.688 of the head's 4.856 GiB — **96.5%, in two
tensors** — so head size is essentially one dial, and protecting the other
3.5% at a high bit-width is nearly free (+0.02 GiB from 6- to 8-bit across all
of it). `vqlab mtp-pack --expert-bits` sets the experts independently; the
recipe is recorded in the sidecar and replayed on load.

Paired across the same 12 prompts, `align="committed"`:

| head | resident | acceptance | vs q6 | t |
|------|----------|-----------|-------|---|
| q6 (uniform 6-bit)   | 2.12 GiB | 0.8171 | — | — |
| experts q4 / rest q8 | 1.55 GiB | 0.8105 | −0.65pp | 2.06 |
| experts q3 / rest q8 | **1.25 GiB** | 0.8151 | −0.20pp | 0.54 |

None of the differences is significant at 11 df, and `e3q8` scores *above*
`e4q8` — which a strictly coarser quantization cannot genuinely do, and is
the same tell the ledger used when 6-bit appeared to beat bf16. **Experts at
3-bit costs 41% of the head's residency and buys no measurable acceptance
loss**, which matters most on the large rungs where headroom decides whether
the head ships at all.

The search is safe by construction: head precision **cannot** affect output
quality, because the trunk verifies every drafted token. A coarser head costs
a rejection, never a wrong token. There is no quality gate to defend here,
only acceptance — and acceptance is measured directly.

### Can a VQ artifact use a native MTP runtime? Not today (2026-08-31)

oMLX 0.6.3+ serves `qwen4_exp` with its own native MTP ("Lightning MTP"), so
the obvious question is whether a VQLab VQ rung can borrow it. Tested directly
against oMLX 0.6.4. It cannot, and **the blocker has nothing to do with the
MTP head**:

- oMLX **does** honour `model_file` — but only on its mlx-lm path
  (`omlx/patches/deepseek_v4/utils_patch.py`). Its `qwen4_exp` is vendored into
  **mlx-vlm**'s namespace (`omlx/patches/mlx_vlm_qwen4_exp_compat/`), and the
  mlx-vlm loader does not honour `model_file`.
- Its `qwen4_exp` expects **mlx-vlm key layout** — `language_model.*`,
  `vision_tower.*`. VQLab artifacts are **mlx-lm layout** — `model.*`,
  `lm_head.*`, `model.visual.*`. A lazy load gets all the way through
  architecture construction and then rejects all 3671 tensors as "not in
  model".

So two changes are needed together, and only one is ours: emit VQ artifacts in
mlx-vlm layout, **and** have the mlx-vlm path honour `model_file` — without
which the VQ modules cannot be constructed at all and the packed codes have
nothing to decode them. The second is an upstream feature request, and oMLX
already implements exactly that for its mlx-lm path.

What DOES work with oMLX today is `vqlab mtp-graft` output on a stock
(non-VQ) Flash-Next checkpoint, since its `Qwen4ExpMTPModule` accepts `mtp.`,
`language_model.mtp.`, `model.mtp.` and `model.language_model.mtp.` prefixes.
That is not a VQLab differentiator — Qwen's own head serves the same purpose —
but it is the reason `mtp-graft` gates on key-set parity rather than guessing.

Per-family findings, falsified predictions and open questions live in
[MTP.md](MTP.md).

### Adding a family

A family is a `FamilySpec` table entry in `src/vqlab/mtp/registry.py` plus a
head module — nothing else in the package names an architecture. The entry
says where the head lives, which submodule's input is the pre-lm_head
activation, which cache the head uses, and whether the family's recurrent
caches may use free (non-copying) snapshots. That last field defaults to the
safe `"copy"`: qwen4_exp's free snapshots work because it *reassigns* cache
slots rather than mutating them, which is an implementation accident, not a
contract. `caches.check_snapshot_semantics` is the measurement that earns a
family the cheap path.

Registered: `qwen4_exp`. GLM-5.3 and DeepSeek also ship MTP heads and the
registry is shaped for them, but neither is registered here because neither
can be tested in this repo today — a table entry without a measured
acceptance number is not evidence of anything.
````

### vq-upstream-mtp-a31c1f3/src/vqlab/mtp/mtp_head.py

Original bytes: 11109. SHA-256: `5944d29f222b610d003d4ff32d489dd42a15601a79255c2cbc68a968588dae6d`.

Normalized bytes: 11109. SHA-256: `5944d29f222b610d003d4ff32d489dd42a15601a79255c2cbc68a968588dae6d`.

````text
"""The qwen4_exp multi-token-prediction head: build, quantize, save, load.

One module so the wiring lives in exactly one place. Every detail below was
settled by measurement (2026-08-30); see mtp_probe.py for the evidence and
docs/MTP.md for the numbers.

Wiring, per the llama.cpp qwen4-exp port (PR #27739) with the ambiguities
resolved against the architecture itself:

    h_row -> RMSNorm(hc*D, group_size=D)   one statistic per stream, as every
                                           other wide norm in this arch does
                                           (measured 0.6992 vs 0.6562 flat)
          -> reshape to [hc, D] streams
    e     -> RMSNorm(D)                    shared across streams
    per stream: fc_embedding @ e + fc_hidden @ h_stream
          -> ONE standard qwen4_exp full-attention block (own 512-expert MoE)
          -> the head's own hyper_connection_mixer (carries the final norm)
          -> the shared lm_head / tied embedding

The norms MUST be applied by the architecture's own RMSNorm, which is
zero-centered (y = norm(x) * (1 + weight)). Hand-rolling `n * w` drops the
+1.0 and drives draft acceptance to exactly 0.0 -- that single mistake was
the entire reason the head looked dead. Do not "simplify" it back.
"""
from __future__ import annotations

import json

import mlx.core as mx
import mlx.nn as nn
from mlx_lm.models.base import create_attention_mask
from mlx.utils import tree_flatten, tree_unflatten

SIDECAR_NAME = "mtp-head-q6.safetensors"


def _quantizable(path, mod):
    """nn.quantize hands the predicate EVERY submodule, norms included, and
    raises on anything without to_quantized -- so gate on that, not on names.
    The MoE router stays full precision, mirroring qwen4_exp's own
    quant_predicate."""
    return hasattr(mod, "to_quantized") and not path.endswith("mlp.gate")


# Measured from the bf16 graft header (2026-08-31): the 512-expert MoE stack
# is 4.688 of the head's 4.856 GiB -- 96.5% of it, in TWO tensors. Everything
# else together (attention, hyper-connections, the fc fuse, the shared expert,
# the norms) is 0.168 GiB. So head size is essentially a single dial, the
# expert bit-width, and protecting all the small modules at a high bit-width
# is nearly free: +0.02 GiB going from 6-bit to 8-bit across all of them.
#
# This is a pure speed/memory search. Head precision CANNOT affect output
# quality -- the trunk verifies every drafted token, so a coarser head costs
# a rejection, never a wrong token. The only risk is acceptance, and acceptance
# is measurable directly (`vqlab mtp-probe`).
_EXPERT_SUBSTR = "switch_mlp"


def _mixed_predicate(bits, expert_bits, group_size):
    """Per-module bit-widths. nn.quantize lets a predicate return the kwargs
    for to_quantized, so one pass can carry two bit-widths."""
    def predicate(path, mod):
        if not _quantizable(path, mod):
            return False
        b = expert_bits if _EXPERT_SUBSTR in path else bits
        return {"group_size": group_size, "bits": b}
    return predicate


class MTPHead:
    """One drafting head bound to a loaded qwen4_exp trunk."""

    def __init__(self, model, arch):
        core = model.model
        args_t = core.args
        self.model = model
        self.core = core
        self.arch = arch
        self.args = args_t
        self.tie = model.args.text.tie_word_embeddings
        self.lm_head = None if self.tie else model.lm_head
        self.D = args_t.hidden_size
        self.hc = core.hc
        self.eps = getattr(args_t, "rms_norm_eps", 1e-6)
        fa_idx = [i for i, l in enumerate(core.layers)
                  if l.layer_type == "full_attention"][0]
        self.fa_idx = fa_idx
        self.block = type(core.layers[fa_idx])(args_t, fa_idx)
        # The head has no PLE bank. A zero-filled stand-in is NOT a no-op
        # through this class, so the submodule has to go entirely.
        self.block.ple = None
        self.mixer = type(core.hyper_connection_mixer)(args_t, use_combine=False)
        theta = float((getattr(args_t, "mtp", {}) or {}).get(
            "rope_theta", 10_000_000))
        self.rope = type(core.rope)(core.rope.dim, theta)
        self.norm_e = None
        self.norm_h = None
        self.fc = None

    # ---------------------------------------------------------------- build
    def _norm(self, dim, w, group_size=None):
        n = self.arch.RMSNorm(dim, group_size=group_size, eps=self.eps)
        n.weight = w.astype(mx.float32)
        return n

    def load_graft(self, g):
        """Fill from an upstream bf16 `mtp.*` graft (keys already stripped)."""
        layer_w = {}
        for k, v in g.items():
            if not k.startswith("layers.0."):
                continue
            k = k[len("layers.0."):]
            # Upstream stacks the experts fused; apply the same split the
            # model's own sanitize applies to trunk layers.
            if k.endswith("mlp.experts.gate_up_proj"):
                mid = v.shape[-2] // 2
                layer_w["mlp.switch_mlp.gate_proj.weight"] = v[..., :mid, :]
                layer_w["mlp.switch_mlp.up_proj.weight"] = v[..., mid:, :]
            elif k.endswith("mlp.experts.down_proj"):
                layer_w["mlp.switch_mlp.down_proj.weight"] = v
            else:
                layer_w[k] = v
        slots = {k for k, _ in tree_flatten(self.block.parameters())}
        unmatched = sorted(set(layer_w) - slots)
        if unmatched:
            raise SystemExit(f"FAIL: {len(unmatched)} graft keys found no "
                             f"parameter slot, e.g. {unmatched[:4]}")
        self.block.load_weights(list(layer_w.items()), strict=False)
        self.mixer.load_weights(
            [(k[len("hyper_connection_mixer."):], v) for k, v in g.items()
             if k.startswith("hyper_connection_mixer.")], strict=False)
        self.norm_e = self._norm(self.D, g["pre_fc_norm_embedding.weight"])
        self.norm_h = self._norm(self.hc * self.D,
                                 g["pre_fc_norm_hidden.weight"],
                                 group_size=self.D)
        self.fc = mx.concatenate([g["fc_embedding.weight"],
                                  g["fc_hidden.weight"]], axis=1)
        mx.eval(self.block.parameters(), self.mixer.parameters())
        return self

    def quantize(self, bits=6, group_size=32, expert_bits=None):
        """Quantize the head. `expert_bits` overrides `bits` for the MoE
        expert stack, which is 96.5% of the weight; `bits` then applies to the
        3.5% of small modules, where protecting precision costs almost
        nothing. `expert_bits=None` reproduces the uniform recipe."""
        eb = bits if expert_bits is None else expert_bits
        for m in (self.block, self.mixer):
            nn.quantize(m, class_predicate=_mixed_predicate(
                bits, eb, group_size))
        mx.eval(self.block.parameters(), self.mixer.parameters())
        return self

    # ------------------------------------------------------------- sidecar
    def save(self, path, bits, group_size=32, expert_bits=None):
        flat = {f"block.{k}": v
                for k, v in tree_flatten(self.block.parameters())}
        flat.update({f"mixer.{k}": v
                     for k, v in tree_flatten(self.mixer.parameters())})
        flat["norm_e.weight"] = self.norm_e.weight
        flat["norm_h.weight"] = self.norm_h.weight
        flat["fc.weight"] = self.fc
        mx.save_safetensors(str(path), flat, metadata={
            "format": "mlx",
            "mtplx_compatible": "false",
            "vqlab_mtp": json.dumps({"bits": bits, "group_size": group_size,
                                     "expert_bits": expert_bits,
                                     "fa_idx": self.fa_idx}),
        })
        return flat

    @classmethod
    def from_sidecar(cls, model, arch, path):
        w = mx.load(str(path))
        meta = mx.load(str(path), return_metadata=True)[1]
        cfg = json.loads(meta.get("vqlab_mtp", "{}"))
        head = cls(model, arch)
        bits, gs = cfg.get("bits"), cfg.get("group_size", 32)
        if bits:
            # Build the quantized module shape first, then fill it. The recipe
            # must be replayed exactly -- a mixed-bit sidecar loaded as uniform
            # gives every expert tensor the wrong packed shape.
            eb = cfg.get("expert_bits") or bits
            for m in (head.block, head.mixer):
                nn.quantize(m, class_predicate=_mixed_predicate(bits, eb, gs))
        head.block.update(tree_unflatten(
            [(k[len("block."):], v) for k, v in w.items()
             if k.startswith("block.")]))
        head.mixer.update(tree_unflatten(
            [(k[len("mixer."):], v) for k, v in w.items()
             if k.startswith("mixer.")]))
        head.norm_e = head._norm(head.D, w["norm_e.weight"])
        head.norm_h = head._norm(head.hc * head.D, w["norm_h.weight"],
                                 group_size=head.D)
        head.fc = w["fc.weight"]
        mx.eval(head.block.parameters(), head.mixer.parameters())
        return head

    # --------------------------------------------------------------- draft
    def _trunk(self, h_row, nxt_id, cache=None):
        """(trunk hidden at t, token t+1) -> the head's output activation.

        T > 1 is a real case, not just prefill: aligning the head's cache to
        one row per COMMITTED token means advancing it two positions per
        speculative step. The mask MUST therefore be built the way the trunk
        builds its own (`create_attention_mask`) — passing None is only
        correct at T == 1, and at T > 1 it silently lets each position attend
        forwards, which shows up as degraded acceptance rather than an error.
        """
        core, D, hc = self.core, self.D, self.hc
        B, T = nxt_id.shape
        e = self.norm_e(core.embed_tokens(nxt_id))
        hs = self.norm_h(h_row).reshape(B, T, hc, D)
        es = mx.broadcast_to(e[:, :, None, :], (B, T, hc, D))
        cat = mx.concatenate([es, hs], axis=-1)
        hin = (cat @ self.fc.T.astype(cat.dtype)).reshape(B, T, hc * D)
        idx = cache.indexer if (cache is not None
                                and hasattr(cache, "indexer")) else None
        mask = create_attention_mask(hin, cache) if T > 1 else None
        out = self.block(hin, self.rope, mask, None, cache, idx, nxt_id, None)
        return self.mixer(out)

    def draft_logits(self, h_row, nxt_id, cache=None):
        """(trunk hidden at t, token t+1) -> logits for token t+2."""
        out = self._trunk(h_row, nxt_id, cache)
        return (self.core.embed_tokens.as_linear(out) if self.tie
                else self.lm_head(out))

    def advance(self, h_row, nxt_id, cache):
        """Fill the head's cache for these positions without projecting to
        the vocabulary. Used to seed the head over the prompt, where the
        logits are never read and the lm_head matmul over the whole prompt
        would be the single largest cost of the seed."""
        self._trunk(h_row, nxt_id, cache)
        return cache
````

### vq-upstream-mtp-a31c1f3/src/vqlab/mtp/runtime.py

Original bytes: 3121. SHA-256: `155f18b693ad603a74b67bcab704196e408cb1e0a9130daccd1c4a829a2dd0ab`.

Normalized bytes: 3121. SHA-256: `155f18b693ad603a74b67bcab704196e408cb1e0a9130daccd1c4a829a2dd0ab`.

````text
"""Trunk loading for the MTP tools, across BOTH runtimes.

mlx-lm serves most families; glm5_next exists only in mlx_vlm (which is
also exo's serving path for it). One loader keeps every mtp-* entry
point runtime-agnostic: it returns (model-to-bind, tokenizer), where the
model is the object the registry contract expects — mlx-lm's Model, or
the mlx_vlm LanguageModel (never the VLM wrapper).
"""
from __future__ import annotations

import importlib
import json
import pathlib


def load_trunk(model_path, lazy: bool = False):
    model_path = pathlib.Path(model_path)
    model_type = json.load(open(model_path / "config.json")).get("model_type")
    try:
        importlib.import_module(f"mlx_lm.models.{model_type}")
        have_mlx_lm = True
    except ImportError:
        have_mlx_lm = False
    if have_mlx_lm:
        from mlx_lm.utils import load
        try:
            return load(model_path, lazy=lazy, trust_remote_code=True)
        except TypeError:  # older mlx-lm: no trust_remote_code kwarg
            return load(model_path, lazy=lazy)
    from mlx_vlm.utils import load as vlm_load
    try:
        model, processor = vlm_load(str(model_path), lazy=lazy)
        tok = getattr(processor, "tokenizer", processor)
    except OSError:
        # VQ artifacts ship no preprocessor_config.json (they are served
        # text-only), and AutoProcessor refuses to build without the image
        # half. MTP needs only the tokenizer, so load the model and the
        # tokenizer separately.
        from mlx_vlm.utils import load_model as vlm_load_model
        from transformers import AutoTokenizer
        model = vlm_load_model(model_path, lazy=lazy, trust_remote_code=True)
        tok = AutoTokenizer.from_pretrained(str(model_path))
    lang = getattr(model, "language_model", model)
    return _LogitsAdapter(lang), tok


def encode_chat(tok, text):
    """Chat-template a single user message to token ids, whichever of the
    four shapes this tokenizer's apply_chat_template returns (ids, a BatchEncoding,
    rendered string, or a list of rendered strings — bare HF tokenizers
    from mlx_vlm do the latter two)."""
    ids = tok.apply_chat_template([{"role": "user", "content": text}],
                                  add_generation_prompt=True)
    if hasattr(ids, "get") and "input_ids" in ids:  # BatchEncoding
        return list(ids["input_ids"])
    if isinstance(ids, str):
        return tok.encode(ids)
    if ids and isinstance(ids[0], str):
        return tok.encode("".join(ids))
    return ids


class _LogitsAdapter:
    """mlx_vlm LanguageModels return LanguageModelOutput(logits=...); the
    loop's contract is `model(tokens, cache=...) -> logits`. Unwrap at the
    call and delegate everything else, so capture paths (model.model.*),
    make_cache, args and lm_head all reach the real module untouched."""

    def __init__(self, lang):
        self._lang = lang

    def __call__(self, *args, **kwargs):
        out = self._lang(*args, **kwargs)
        return getattr(out, "logits", out)

    def __getattr__(self, name):
        return getattr(self._lang, name)
````

### vq-upstream-mtp-a31c1f3/src/vqlab/assemble/mtp_pack.py

Original bytes: 6487. SHA-256: `ad203f57299ffeb3bd3591d02685fee9d9b3bef269f394e55440108d7efe99f5`.

Normalized bytes: 6487. SHA-256: `ad203f57299ffeb3bd3591d02685fee9d9b3bef269f394e55440108d7efe99f5`.

````text
"""Pack a bf16 MTP graft into a quantized drafting sidecar.

    python -m vqlab.cli mtp-pack --model <artifact> --mtp <graft.safetensors>
        [--bits 6] [--group-size 32] [--out <dir-or-file>]

The output is deliberately NOT named `model*.safetensors`. mlx-lm discovers
weights by globbing that pattern (utils.py:349) and never consults the index,
so a sidecar named `mtp-head-q6.safetensors` is invisible to the stock loader:
dropping it into an artifact directory costs nothing until something asks for
it by name. That is what makes the head optional.

Measured on Flash-Next 2.1bpw (2026-08-30): the 6-bit head is 2.12 GiB
resident and lifts greedy decoding from 16.07 to 26.87 tok/s (1.67x) at 0.708
draft acceptance. Head precision cannot affect output quality -- the trunk
verifies every drafted token, so a worse draft costs a rejection, never a
wrong token; 6-bit and bf16 measured identical acceptance.
"""
import argparse
import importlib
import pathlib
import sys

import mlx.core as mx

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))  # src/
from vqlab import _layout  # noqa: E402,F401  one module object per name
from vqlab.mtp import registry

SIDECAR_NAME = "mtp-head-q6.safetensors"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--model", required=True, help="artifact dir (loaded lazily; "
                    "no trunk weights are materialized)")
    ap.add_argument("--mtp", required=True, help="bf16 mtp graft safetensors")
    ap.add_argument("--bits", type=int, default=6,
                    help="bit-width for the small modules (attention, "
                         "hyper-connections, fc, shared expert) -- 3.5%% of "
                         "the head, so protecting them is nearly free")
    ap.add_argument("--expert-bits", type=int, default=None,
                    help="bit-width for the 512-expert MoE stack, which is "
                         "96.5%% of the head and therefore sets its size "
                         "(default: same as --bits)")
    ap.add_argument("--group-size", type=int, default=32)
    ap.add_argument("--family", default=None,
                    help="override the family resolved from the model's "
                         "model_type (registered: see registry.py)")
    ap.add_argument("--norm-shift", type=float, default=None,
                    help="qwen3_5 only: delta added to the head's RMSNorm "
                         "gains at load. This family stores norms as deltas "
                         "and mlx-lm's sanitize drops every mtp.* key before "
                         "shifting them, so the head owns the convention; "
                         "the wrong choice gives exactly 0.0 acceptance. "
                         "Default 1.0 (the head module's own default)")
    ap.add_argument("--fc-order", default=None, choices=("he", "eh"),
                    help="qwen3_5 only: concat order into the fused fc "
                         "projection; not recoverable from the checkpoint")
    ap.add_argument("--h-source", default=None,
                    choices=("pre_norm", "post_norm"),
                    help="qwen3_5 only: whether the head reads the trunk "
                         "hidden state before or after the trunk final norm")
    ap.add_argument("--out", default=None,
                    help="output file, or a directory to write "
                         f"{SIDECAR_NAME} into (default: the artifact dir)")
    a = ap.parse_args()

    # lazy=True everywhere: we need the architecture classes and args, not
    # the weights. Families mlx-lm has no class for (glm5_next) load via
    # mlx_vlm; the head binds to the LanguageModel, matching the registry's
    # arch_module contract either way.
    import json as _json
    model_type = _json.load(
        open(pathlib.Path(a.model) / "config.json")).get("model_type")
    try:
        importlib.import_module(f"mlx_lm.models.{model_type}")
        have_mlx_lm_class = True
    except ImportError:
        have_mlx_lm_class = False
    if have_mlx_lm_class:
        from mlx_lm.utils import load
        try:
            model, _ = load(a.model, lazy=True, trust_remote_code=True)
        except TypeError:  # older mlx-lm: no trust_remote_code kwarg
            model, _ = load(a.model, lazy=True)
    else:
        from mlx_vlm.utils import load_model
        model = load_model(pathlib.Path(a.model), lazy=True)
        model = getattr(model, "language_model", model)
    spec = registry.resolve(model, a.family)
    arch = spec.arch_module(model)
    cls = spec.head_cls()
    print(f"family {spec.name} -> {spec.head}", flush=True)

    # Head-specific wiring options, passed only when the user set them, so a
    # head class that does not take them is unaffected.
    kw = {}
    for flag, name in (("norm_shift", "norm-shift"), ("fc_order", "fc-order"),
                       ("h_source", "h-source")):
        v = getattr(a, flag.replace("-", "_"))
        if v is not None:
            kw[flag] = v
    if kw:
        print(f"  wiring: {kw}", flush=True)

    g = {k[len("mtp."):] if k.startswith("mtp.") else k: v
         for k, v in mx.load(a.mtp).items()}
    head = cls(model, arch, **kw).load_graft(g)
    del g

    before = mx.get_active_memory()
    head.quantize(bits=a.bits, group_size=a.group_size,
                  expert_bits=a.expert_bits)
    mx.clear_cache()
    resident = (mx.get_active_memory() - before) / 2**30

    eb = a.bits if a.expert_bits is None else a.expert_bits
    out = pathlib.Path(a.out) if a.out else pathlib.Path(a.model)
    if out.is_dir():
        SIDECAR_NAME_ = spec.sidecar_name
        if a.bits == 6 and eb == 6:
            out = out / SIDECAR_NAME_
        elif eb == a.bits:
            out = out / f"mtp-head-q{a.bits}.safetensors"
        else:
            out = out / f"mtp-head-e{eb}q{a.bits}.safetensors"
    flat = head.save(out, bits=a.bits, group_size=a.group_size,
                     expert_bits=a.expert_bits)
    size = out.stat().st_size / 2**30
    print(f"wrote {out}")
    recipe = (f"{a.bits}-bit" if eb == a.bits
              else f"experts {eb}-bit / rest {a.bits}-bit")
    print(f"  {len(flat)} tensors, {size:.2f} GiB on disk, "
          f"{recipe} / group {a.group_size}")
    print(f"  quantization changed resident by {resident:+.2f} GiB")
    print(f"  invisible to mlx-lm's model*.safetensors glob: "
          f"{not out.name.startswith('model')}")


if __name__ == "__main__":
    main()
````

### vq-upstream-mtp-a31c1f3/src/vqlab/assemble/mtp_extract.py

Original bytes: 5566. SHA-256: `fd9342141e6b6fe7f1085017711f8e440099dc4415644b9b821ef7a820aa88cb`.

Normalized bytes: 5566. SHA-256: `fd9342141e6b6fe7f1085017711f8e440099dc4415644b9b821ef7a820aa88cb`.

````text
"""Extract a model's MTP head from its source checkpoint into one graft file.

    python -m vqlab.cli mtp-extract --src <bf16-checkpoint> --out graft.safetensors

MLX conversion strips `mtp.*` systematically -- Qwen's own MLX uploads carry
none, and neither do ours -- so the head only exists in the original
checkpoint. This pulls it out into the single-file graft that `mtp-pack` and
`mtp-graft` consume, which is otherwise a step that happened once, by hand,
and was not reproducible.

Only the shards that actually hold `mtp.*` are opened, and only those tensors
are materialized, so extracting a 12 GiB head from a 400B checkpoint costs
12 GiB of RAM and not 800.

Per CONTRIBUTING, the load -> save path takes the lazy-read cure: the read
happens inside `mx.stream(mx.cpu)` with an `mx.eval` in the same block, and
the result is asserted non-zero before writing. A lazily-read tensor that is
evaluated after the stream closes silently writes zeros, and a graft of zeros
produces a head with exactly 0.0 acceptance -- indistinguishable from the
RMSNorm bug this package already documents.
"""
import argparse
import json
import pathlib
import re
import sys
from collections import defaultdict

import mlx.core as mx

# Default matcher: Qwen/DeepSeek-style checkpoints name the head mtp.* /
# nextn.*. NOT every family does: GLM-5.3 stores its MTP layer as plain
# `...layers.<num_hidden_layers>.*` (index 45 on Flash — eh_proj/enorm/
# hnorm + a full expert stack), which this regex cannot see. Use
# --key-regex for those, e.g. --key-regex '\.layers\.45\.'  (experts.45
# does not collide: the segment there is `experts`, not `layers`).
MTP_KEY = re.compile(r"(^|\.)(mtp|nextn)\b", re.IGNORECASE)


def find_mtp_keys(src: pathlib.Path, key_re: "re.Pattern[str]" = MTP_KEY):
    """{shard: [keys]} for every MTP tensor, from the index."""
    idx = src / "model.safetensors.index.json"
    if not idx.exists():
        raise SystemExit(f"no {idx.name} in {src}")
    wm = json.loads(idx.read_text())["weight_map"]
    by_shard = defaultdict(list)
    for k, shard in wm.items():
        if key_re.search(k):
            by_shard[shard].append(k)
    return dict(by_shard), len(wm)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", required=True, help="source checkpoint directory")
    ap.add_argument("--out", required=True, help="graft safetensors to write")
    ap.add_argument("--key-regex", default=None,
                    help="override the mtp/nextn key matcher (families "
                         "like glm5_next store the head as plain "
                         "layers.<N>.* — see MTP_KEY's comment)")
    ap.add_argument("--strip-prefix", default=None,
                    help="drop this leading prefix from every key "
                         "(default: keep keys as found)")
    ap.add_argument("--dry-run", action="store_true",
                    help="report what would be extracted and stop")
    a = ap.parse_args()

    src = pathlib.Path(a.src)
    key_re = re.compile(a.key_regex) if a.key_regex else MTP_KEY
    by_shard, n_total = find_mtp_keys(src, key_re)
    n_mtp = sum(len(v) for v in by_shard.values())
    if not n_mtp:
        raise SystemExit(
            f"no mtp/nextn tensors in {src}. The MLX conversion almost "
            f"certainly stripped them -- extract from the original "
            f"(usually bf16) checkpoint instead.")
    print(f"{src.name}: {n_mtp} MTP tensors of {n_total}, in "
          f"{len(by_shard)} shard(s)")
    groups = defaultdict(int)
    for keys in by_shard.values():
        for k in keys:
            groups[".".join(k.split(".")[:4])] += 1
    for g, n in sorted(groups.items(), key=lambda x: -x[1])[:8]:
        print(f"    {g:<52} x{n}")
    if a.dry_run:
        return 0

    out = {}
    total = 0
    for shard in sorted(by_shard):
        keys = by_shard[shard]
        # Lazy-read cure: read AND evaluate inside the cpu stream, or the
        # deferred read can resolve after the stream closes and write zeros.
        with mx.stream(mx.cpu):
            part = mx.load(str(src / shard))
            picked = {k: part[k] for k in keys}
            mx.eval(list(picked.values()))
        for k, v in picked.items():
            name = k
            if a.strip_prefix and name.startswith(a.strip_prefix):
                name = name[len(a.strip_prefix):]
            out[name] = v
            total += v.nbytes
        del part, picked
        print(f"  {shard}: +{len(keys)} tensors "
              f"({total / 2**30:.2f} GiB so far)", flush=True)

    # A graft of zeros yields a head with exactly 0.0 acceptance, which is
    # indistinguishable from the RMSNorm-convention bug. Refuse to write one.
    dead = [k for k, v in out.items()
            if v.size and not bool(mx.any(v != 0).item())]
    if dead:
        raise SystemExit(
            f"FAIL: {len(dead)} extracted tensors are entirely zero, e.g. "
            f"{dead[:3]}. This is the lazy-read failure, not a real head.")

    outp = pathlib.Path(a.out)
    outp.parent.mkdir(parents=True, exist_ok=True)
    mx.save_safetensors(str(outp), out, metadata={
        "format": "mlx", "vqlab_mtp_graft": json.dumps(
            {"source": src.name, "tensors": len(out)})})
    print(f"\nwrote {outp}")
    print(f"  {len(out)} tensors, {outp.stat().st_size / 2**30:.2f} GiB")
    print(f"  key prefixes: {sorted({k.split('.')[0] for k in out})}")
    print(f"  all-zero check: PASS ({len(out)} tensors carry data)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
````

### vq-upstream-mtp-a31c1f3/src/vqlab/mtp/caches.py

Original bytes: 5158. SHA-256: `af086f2545640a9264890a1b0302369a5ee65f92e7940267484b9d6806e9ce04`.

Normalized bytes: 5158. SHA-256: `af086f2545640a9264890a1b0302369a5ee65f92e7940267484b9d6806e9ce04`.

````text
"""Snapshot and rollback for a speculative decode step.

Two cache kinds appear in one `model.make_cache()` list and they roll back
completely differently:

  attention caches   expose keys/values and a `trim(n)`. They MUST be trimmed
                     by the offset DELTA, not by a fixed count. Trimming a
                     hardcoded 1 leaves a stale key behind while the recurrent
                     caches roll back 2, and the two streams then drift
                     silently — correct-looking text that is not what the
                     trunk would have produced. This bug was hit once already.

  recurrent caches   expose a `cache` list of state arrays. Rollback is
                     whatever the snapshot held.

For the recurrent kind there is a real hazard behind an implementation
accident. qwen4_exp REASSIGNS its slots (`cache[0] = ...`) and mlx arrays are
immutable, so keeping the old references is a free, correct snapshot. An
architecture that instead writes in place (`cache[0][..., i] = k`, which mlx
does support) would corrupt the snapshot through the very reference we saved.
So the copying policy is a per-family field, defaulting to "copy", and
`check_snapshot_semantics` is the measurement that earns a family the cheap
"reassign" path.
"""
from __future__ import annotations

import mlx.core as mx


def is_attention(c) -> bool:
    return hasattr(c, "keys") and hasattr(c, "trim")


def is_attention_composite(c) -> bool:
    """mlx_vlm's CacheList (glm5_next fa layers: main-KV + indexer-KV).
    No `keys` of its own, but every member is a plain attention cache, so
    the composite rolls back like one: trim each member by its offset
    delta. A CacheList holding anything non-attention falls through to
    the TypeError — its rollback is unproven."""
    subs = getattr(c, "caches", None)
    return (subs is not None and len(subs) > 0
            and all(is_attention(s) for s in subs))


def snapshot(caches, *, copy: bool = True) -> list:
    snaps = []
    for c in caches:
        if is_attention(c):
            snaps.append(("attn", c.offset, None))
        elif is_attention_composite(c):
            snaps.append(("attn-list", [s.offset for s in c.caches], None))
        elif hasattr(c, "cache"):
            state = list(c.cache)
            if copy:
                state = [mx.array(x) if isinstance(x, mx.array) else x
                         for x in state]
            snaps.append(("state", getattr(c, "offset", None), state))
        else:
            raise TypeError(
                f"cache {type(c).__name__} is neither an attention cache "
                f"(keys/trim) nor a state cache (.cache); speculative "
                f"rollback cannot be proven correct for it")
    return snaps


def restore(caches, snaps) -> None:
    """Back to exactly where the snapshot was taken."""
    for c, s in zip(caches, snaps):
        kind, offset, state = s
        if kind == "attn":
            n = c.offset - offset
            if n > 0:
                c.trim(n)
            elif n < 0:
                raise RuntimeError(
                    f"attention cache went BACKWARDS since the snapshot "
                    f"({c.offset} < {offset}); rollback would corrupt it")
        elif kind == "attn-list":
            for sub, off in zip(c.caches, offset):
                n = sub.offset - off
                if n > 0:
                    sub.trim(n)
                elif n < 0:
                    raise RuntimeError(
                        f"attention cache went BACKWARDS since the snapshot "
                        f"({sub.offset} < {off}); rollback would corrupt it")
        else:
            c.cache = list(state)
            if offset is not None:
                c.offset = offset


def check_snapshot_semantics(caches, advance) -> bool:
    """Does `copy=False` snapshotting actually hold for these caches?

    Snapshot without copying, deep-copy the same arrays separately, run
    `advance()` (one forward through the model), and check the snapshot's
    arrays are still what they were. True means the family may use
    cache_semantics="reassign"; False means it writes state in place and must
    copy. Returns True for an all-attention cache list (nothing to alias).

    This is the gate that lets a new family claim the cheap path, and it fails
    on an in-place cache by construction — see tests/test_mtp_caches.py, where
    it is run against both a reassigning and a mutating cache.
    """
    _ATTN_KINDS = ("attn", "attn-list")
    snaps = snapshot(caches, copy=False)
    witness = [[mx.array(x) if isinstance(x, mx.array) else x for x in s[2]]
               for s in snaps if s[0] not in _ATTN_KINDS]
    for w in witness:
        mx.eval(*[x for x in w if isinstance(x, mx.array)])
    advance()
    held = [s[2] for s in snaps if s[0] not in _ATTN_KINDS]
    for kept, ref in zip(held, witness):
        for a, b in zip(kept, ref):
            if not isinstance(a, mx.array) or not isinstance(b, mx.array):
                continue
            if a.shape != b.shape or not bool(mx.all(a == b).item()):
                return False
    return True
````

### vq-upstream-mtp-a31c1f3/src/vqlab/mtp/sampling.py

Original bytes: 5899. SHA-256: `c1f554771d1a053700036b3f54dc84a61c1d4705472debbf8dbaeb6a84af29b1`.

Normalized bytes: 5899. SHA-256: `c1f554771d1a053700036b3f54dc84a61c1d4705472debbf8dbaeb6a84af29b1`.

````text
"""Sampling for speculative decoding: the same distribution mlx-lm would
sample from, plus exact rejection sampling with residual correction.

The samplers are mlx-lm's (`mlx_lm.sample_utils`, Apache-2.0). We do not
reimplement top-p/top-k/min-p/XTC or the penalties — we adapt the *shape* of
mlx-lm's sampler, which returns a token, into one that also returns the
normalized distribution it sampled from, because speculative verification
needs the probabilities and not just the draw.

Filter order matches `make_sampler` exactly: the filters run on unscaled
logprobs and the temperature is applied at the categorical draw. So for the
same parameters a token from `Distribution.sample` is drawn from the same
distribution `mlx_lm`'s sampler would have used.

Correction (Leviathan et al. 2023, "Fast Inference from Transformers via
Speculative Decoding"; Chen et al. 2023): given a draft x ~ q and the target p,

    accept x with probability min(1, p(x)/q(x));
    otherwise draw from the normalized residual max(p - q, 0).

The resulting draw is distributed exactly as p, for ANY q. That is what makes
a bad draft cost speed and never quality — the same guarantee greedy decoding
gets from `argmax(p) == x`, which is this rule's zero-temperature limit.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, List, Optional

import mlx.core as mx
from mlx_lm.sample_utils import (
    apply_min_p,
    apply_top_k,
    apply_top_p,
    apply_xtc,
    make_logits_processors,
)

__all__ = ["Distribution", "make_distribution", "make_logits_processors",
           "rejection_correct", "acceptance_profile"]


@dataclass(frozen=True)
class Distribution:
    """One step's distribution over the vocabulary.

    `probs` is normalized and is what verification compares. `logits` is the
    temperature-scaled, filter-masked array the draw comes from, kept so the
    draw is bit-for-bit mlx-lm's."""
    probs: mx.array          # [B, V], sums to 1
    logits: mx.array         # [B, V], scaled + masked

    def sample(self) -> mx.array:
        return mx.random.categorical(self.logits)

    def argmax(self) -> mx.array:
        return mx.argmax(self.logits, axis=-1)


def make_distribution(
    temp: float = 0.0,
    top_p: float = 0.0,
    min_p: float = 0.0,
    min_tokens_to_keep: int = 1,
    top_k: int = 0,
    xtc_probability: float = 0.0,
    xtc_threshold: float = 0.0,
    xtc_special_tokens: List[int] = [],
) -> Optional[Callable[[mx.array], Distribution]]:
    """logits [B, V] -> Distribution, or None for greedy (temp == 0).

    None is not a fallback: at temp 0 the target is a point mass, rejection
    sampling degenerates to "accept iff the draft equals the argmax", and the
    loop takes that cheaper branch. Building a one-hot vector to rediscover
    the same rule would only add a softmax per token."""
    if temp == 0:
        return None

    methods = []
    if 0 < top_p < 1.0:
        methods.append(lambda x: apply_top_p(x, top_p))
    if min_p != 0.0:
        methods.append(lambda x: apply_min_p(x, min_p, min_tokens_to_keep))
    if xtc_probability > 0.0:
        methods.append(lambda x: apply_xtc(x, xtc_probability, xtc_threshold,
                                           xtc_special_tokens))
    if top_k > 0:
        methods.append(lambda x: apply_top_k(x, top_k))

    inv_temp = 1.0 / temp

    def distribution(logits: mx.array) -> Distribution:
        lp = logits.astype(mx.float32)
        lp = lp - mx.logsumexp(lp, axis=-1, keepdims=True)
        for method in methods:
            lp = method(lp)
        scaled = lp * inv_temp
        return Distribution(probs=mx.softmax(scaled, axis=-1), logits=scaled)

    return distribution


def rejection_correct(p: mx.array, q: mx.array, draft: mx.array):
    """Verify one drafted token against the target distribution.

    p, q: [B, V] normalized. draft: [B] the token drawn from q.
    Returns (accepted: bool array [B], token: [B]).

    On rejection the replacement comes from the normalized residual
    max(p - q, 0), which is what makes the pair (accept-or-residual) exactly
    p-distributed. Sampling the replacement from p itself — the tempting
    simplification — over-weights tokens the draft already had a chance to
    propose, and biases the output.
    """
    idx = draft[:, None]
    p_d = mx.take_along_axis(p, idx, axis=-1)[:, 0]
    q_d = mx.take_along_axis(q, idx, axis=-1)[:, 0]
    # q_d == 0 can only arise from underflow in a token q itself produced;
    # treat it as certainly acceptable rather than dividing by zero.
    ratio = mx.where(q_d > 0, p_d / mx.maximum(q_d, 1e-30), 1.0)
    accepted = mx.random.uniform(shape=p_d.shape) < ratio

    residual = mx.maximum(p - q, 0.0)
    total = residual.sum(axis=-1, keepdims=True)
    # total is 0 only if q dominates p everywhere, which forces ratio >= 1 and
    # acceptance; the fallback keeps the draw well-defined regardless.
    residual = mx.where(total > 0, residual / mx.maximum(total, 1e-30), p)
    replacement = mx.random.categorical(mx.log(residual))

    return accepted, mx.where(accepted, draft, replacement)


def acceptance_profile(p: mx.array, q: mx.array):
    """The exact per-token outcome probabilities of `rejection_correct`,
    computed in closed form: (accept_prob, resulting_distribution).

    Used as a test oracle — the resulting distribution must equal p for any q,
    which is the whole claim — and useful for reporting the acceptance rate a
    given draft head earns at a given temperature without sampling it."""
    a = mx.minimum(p, q)                      # P(draw x AND accept x)
    accept = a.sum(axis=-1)
    residual = mx.maximum(p - q, 0.0)
    total = residual.sum(axis=-1, keepdims=True)
    norm = mx.where(total > 0, residual / mx.maximum(total, 1e-30), p)
    return accept, a + (1.0 - accept)[:, None] * norm
````

### vq-draft-source-v1/Tools/vq_draft_inventory.py

Original bytes: 6015. SHA-256: `5d144aeee82205075f2fa296f26a1e01fdf35cd4799d825cccb5128911fbe85b`.

Normalized bytes: 6015. SHA-256: `5d144aeee82205075f2fa296f26a1e01fdf35cd4799d825cccb5128911fbe85b`.

````text
#!/usr/bin/env python3
"""Inspect the pinned VQ draft sidecar independently of trunk quantization.

No MLX, remote-code execution, model loading or product admission occurs here.
Header-only output explicitly leaves payload authenticity unverified. This is a
cost/compatibility instrument; tensor bytes are not a process-memory estimate.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import stat

from quantization_inventory import unique_json, validate_header

FILE_BYTES = 2_297_560_747
FILE_SHA256 = '31e237a3c58f51508850287dda6d78ab4c454b704ae2d4b737934af233c78585'
HEADER_SHA256 = 'c39b16ad910abc919c270ef22ab2fe1c3313c7c8107022be976a5607e05a5436'
MAX_HEADER_BYTES = 64_000


def describe(header, payload_bytes):
    validate_header(header, payload_bytes)
    metadata = header.get('__metadata__')
    if (not isinstance(metadata, dict) or metadata.get('format') != 'mlx'
            or metadata.get('mtplx_compatible') != 'false'):
        raise ValueError('draft sidecar requires its independent VQLab metadata')
    recipe = unique_json(metadata.get('vqlab_mtp', '').encode())
    if (recipe != {'bits': 6, 'group_size': 32, 'fa_idx': 3}
            or any(type(value) is not int for value in recipe.values())):
        raise ValueError('uninspected draft recipe; never inherit trunk bits or group size')
    tensors = {k: v for k, v in header.items() if k != '__metadata__'}
    if len(tensors) != 71 or set(tensors) - {'fc.weight', 'norm_e.weight', 'norm_h.weight'} != {
            k for k in tensors if k.startswith(('block.', 'mixer.'))}:
        raise ValueError('draft sidecar tensor family changed')
    triples = 0
    for name, value in tensors.items():
        if value['dtype'] != 'U32':
            continue
        if not name.endswith('.weight'):
            raise ValueError('draft packed data is not a weight')
        base = name[:-len('.weight')]
        scales, biases = tensors.get(base + '.scales'), tensors.get(base + '.biases')
        if (scales is None or biases is None or scales['dtype'] != 'BF16' or biases['dtype'] != 'BF16'
                or scales['shape'] != biases['shape'] or value['shape'][:-1] != scales['shape'][:-1]
                or value['shape'][-1] != scales['shape'][-1] * 6):
            raise ValueError('draft packed shape does not match its own six-bit group-32 recipe')
        triples += 1
    if triples != 20:
        raise ValueError('draft quantized family coverage changed')
    def size(value):
        lo, hi = value['data_offsets']
        return hi - lo
    experts = {k: v for k, v in tensors.items() if '.switch_mlp.' in k}
    if len(experts) != 9 or any(v['shape'][0] != 512 for v in experts.values()):
        raise ValueError('draft expert family coverage changed')
    expert_bytes = sum(size(v) for v in experts.values())
    if expert_bytes % 512:
        raise ValueError('draft expert records are incomplete')
    return {'quantization': {'kind': 'affine', 'bits': 6, 'group_size': 32},
            'full_attention_layer_index': 3, 'tensor_count': len(tensors), 'quantized_modules': triples,
            'tensor_payload_bytes': sum(size(v) for v in tensors.values()),
            'expert_payload_bytes': expert_bytes, 'expert_record_bytes': expert_bytes // 512,
            'other_tensor_bytes': sum(size(v) for k, v in tensors.items() if k not in experts),
            'largest_tensor_bytes': max(size(v) for v in tensors.values()),
            'normalization_and_fusion': 'unqualified; raw sidecar conventions require an independent adapter',
            'trunk_binding': 'unqualified', 'legacy_mtp_loader_compatible': False}


def inspect(path, verify_payload=False):
    fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW)
    with os.fdopen(fd, 'rb') as file:
        before = os.fstat(file.fileno())
        if not stat.S_ISREG(before.st_mode) or before.st_size != FILE_BYTES:
            raise ValueError('draft file does not match its pinned type or size')
        prefix = file.read(8)
        length = int.from_bytes(prefix, 'little')
        if len(prefix) != 8 or not 1 <= length <= MAX_HEADER_BYTES:
            raise ValueError('draft header exceeds its byte bound')
        raw = file.read(length)
        if len(raw) != length or hashlib.sha256(prefix + raw).hexdigest() != HEADER_SHA256:
            raise ValueError('draft header differs from its pinned identity')
        result = describe(unique_json(raw), FILE_BYTES - length - 8)
        if verify_payload:
            file.seek(0)
            digest = hashlib.sha256()
            for block in iter(lambda: file.read(1_000_000), b''):
                digest.update(block)
            if digest.hexdigest() != FILE_SHA256:
                raise ValueError('draft payload differs from its pinned identity')
        after = os.fstat(file.fileno())
        if (before.st_dev, before.st_ino, before.st_size, before.st_mtime_ns, before.st_ctime_ns) != (
                after.st_dev, after.st_ino, after.st_size, after.st_mtime_ns, after.st_ctime_ns):
            raise ValueError('draft file changed during inspection')
    return {'schema': 1, 'scope': 'independent draft storage and layout inventory', 'qualification': 'unproven',
            'file_bytes': FILE_BYTES, 'expected_file_sha256': FILE_SHA256,
            'header_sha256': HEADER_SHA256, 'payload_verified': verify_payload,
            'limits': 'Storage geometry only; no process floor, draft-cache, transient, acceptance or speed qualification.',
            **result}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--sidecar', type=Path, required=True)
    parser.add_argument('--verify-payload', action='store_true')
    parser.add_argument('--out', type=Path, required=True)
    options = parser.parse_args()
    result = inspect(options.sidecar, options.verify_payload)
    with options.out.open('x') as output:
        output.write(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))
````

### vq-draft-source-v1/Tools/vq_draft_inventory_test.py

Original bytes: 3997. SHA-256: `df1e4d82f658e1a94a80a447f4f3253a060f22bd5d020e7abb9f2c737f826159`.

Normalized bytes: 3997. SHA-256: `df1e4d82f658e1a94a80a447f4f3253a060f22bd5d020e7abb9f2c737f826159`.

````text
import copy
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import vq_draft_inventory as draft


class DraftInventoryTests(unittest.TestCase):
    def setUp(self):
        self.header = json.loads((Path(__file__).resolve().parent.parent /
            'bench/quantization/draft-sidecar-v1-header.json').read_text())
        self.payload = max(v['data_offsets'][1] for k, v in self.header.items() if k != '__metadata__')

    def test_independent_recipe_and_exact_storage_ledger(self):
        value = draft.describe(self.header, self.payload)
        self.assertEqual(value['quantization'], {'kind': 'affine', 'bits': 6, 'group_size': 32})
        self.assertEqual(value['tensor_count'], 71)
        self.assertEqual(value['quantized_modules'], 20)
        self.assertEqual(value['tensor_payload_bytes'], self.payload)
        self.assertEqual(value['expert_record_bytes'] * 512, value['expert_payload_bytes'])
        self.assertEqual(value['other_tensor_bytes'] + value['expert_payload_bytes'], self.payload)
        self.assertFalse(value['legacy_mtp_loader_compatible'])
        self.assertEqual(value['trunk_binding'], 'unqualified')

    def test_main_recipe_missing_metadata_and_unknown_expert_override_refused(self):
        recipes = [{'bits': bits, 'group_size': 64, 'fa_idx': 3} for bits in (4, 8)]
        recipes += [{'bits': 6, 'group_size': 32, 'fa_idx': 3, 'expert_bits': 4},
                    {'bits': 6.0, 'group_size': 32, 'fa_idx': 3}, {}]
        for recipe in recipes:
            header = copy.deepcopy(self.header)
            header['__metadata__']['vqlab_mtp'] = json.dumps(recipe)
            with self.assertRaisesRegex(ValueError, 'draft recipe'):
                draft.describe(header, self.payload)
        header = copy.deepcopy(self.header); del header['__metadata__']
        with self.assertRaisesRegex(ValueError, 'independent VQLab metadata'):
            draft.describe(header, self.payload)

    def test_missing_family_and_damaged_extent_refused(self):
        header = copy.deepcopy(self.header); del header['norm_e.weight']
        with self.assertRaises(ValueError):
            draft.describe(header, self.payload)
        header = copy.deepcopy(self.header)
        header['block.mlp.switch_mlp.up_proj.weight']['data_offsets'][1] -= 1
        with self.assertRaises(ValueError):
            draft.describe(header, self.payload)

    def test_header_authentication_does_not_claim_payload_authentication(self):
        # Bounded stand-in exercises the file-authentication boundary without
        # allocating or hashing the real multi-GB head. Layout has its own tests.
        raw = b'{}'; prefix = len(raw).to_bytes(8, 'little'); payload = b'abcdef'
        body = prefix + raw + payload
        with tempfile.TemporaryDirectory() as directory, \
                patch.object(draft, 'FILE_BYTES', len(body)), \
                patch.object(draft, 'HEADER_SHA256', hashlib.sha256(prefix + raw).hexdigest()), \
                patch.object(draft, 'FILE_SHA256', hashlib.sha256(body).hexdigest()), \
                patch.object(draft, 'describe', return_value={}):
            path = Path(directory) / 'head'; path.write_bytes(body)
            self.assertFalse(draft.inspect(path)['payload_verified'])
            self.assertTrue(draft.inspect(path, True)['payload_verified'])
            path.write_bytes(prefix + raw + b'abcdeg')
            self.assertFalse(draft.inspect(path)['payload_verified'])
            with self.assertRaisesRegex(ValueError, 'draft payload differs'):
                draft.inspect(path, True)
            path.write_bytes(bytes(8) + raw + payload)
            with self.assertRaisesRegex(ValueError, 'header exceeds'):
                draft.inspect(path)
            link = Path(directory) / 'link'; link.symlink_to(path)
            with self.assertRaises(OSError):
                draft.inspect(link)


if __name__ == '__main__':
    unittest.main()
````

### vq-draft-source-v1/bench/quantization/draft-sidecar-v1-header.json

Original bytes: 12663. SHA-256: `2b28357cb59578309bc103975f4ecbd4212df1731b3c7170c7697fb8b6fd4303`.

Normalized bytes: 12663. SHA-256: `2b28357cb59578309bc103975f4ecbd4212df1731b3c7170c7697fb8b6fd4303`.

````text
{
  "__metadata__": {
    "format": "mlx",
    "mtplx_compatible": "false",
    "vqlab_mtp": "{\"bits\": 6, \"group_size\": 32, \"fa_idx\": 3}"
  },
  "block.attn_hyper_connection.block_inject_weight.biases": {
    "data_offsets": [
      87231616,
      87234176
    ],
    "dtype": "BF16",
    "shape": [
      4,
      320
    ]
  },
  "block.attn_hyper_connection.block_inject_weight.scales": {
    "data_offsets": [
      34286080,
      34288640
    ],
    "dtype": "BF16",
    "shape": [
      4,
      320
    ]
  },
  "block.attn_hyper_connection.block_inject_weight.weight": {
    "data_offsets": [
      880486176,
      880516896
    ],
    "dtype": "U32",
    "shape": [
      4,
      1920
    ]
  },
  "block.attn_hyper_connection.hc_norm.weight": {
    "data_offsets": [
      1517056544,
      1517077024
    ],
    "dtype": "BF16",
    "shape": [
      10240
    ]
  },
  "block.attn_hyper_connection.input_mix_weight_down.biases": {
    "data_offsets": [
      34288640,
      34493440
    ],
    "dtype": "BF16",
    "shape": [
      320,
      320
    ]
  },
  "block.attn_hyper_connection.input_mix_weight_down.scales": {
    "data_offsets": [
      2266975776,
      2267180576
    ],
    "dtype": "BF16",
    "shape": [
      320,
      320
    ]
  },
  "block.attn_hyper_connection.input_mix_weight_down.weight": {
    "data_offsets": [
      2267180576,
      2269638176
    ],
    "dtype": "U32",
    "shape": [
      320,
      1920
    ]
  },
  "block.attn_hyper_connection.input_mix_weight_up.biases": {
    "data_offsets": [
      195266336,
      195471136
    ],
    "dtype": "BF16",
    "shape": [
      10240,
      10
    ]
  },
  "block.attn_hyper_connection.input_mix_weight_up.scales": {
    "data_offsets": [
      141055616,
      141260416
    ],
    "dtype": "BF16",
    "shape": [
      10240,
      10
    ]
  },
  "block.attn_hyper_connection.input_mix_weight_up.weight": {
    "data_offsets": [
      195471136,
      197928736
    ],
    "dtype": "U32",
    "shape": [
      10240,
      60
    ]
  },
  "block.mlp.gate.weight": {
    "data_offsets": [
      1517077536,
      1519698976
    ],
    "dtype": "BF16",
    "shape": [
      512,
      2560
    ]
  },
  "block.mlp.shared_expert.down_proj.biases": {
    "data_offsets": [
      86924416,
      87026816
    ],
    "dtype": "BF16",
    "shape": [
      2560,
      20
    ]
  },
  "block.mlp.shared_expert.down_proj.scales": {
    "data_offsets": [
      87129216,
      87231616
    ],
    "dtype": "BF16",
    "shape": [
      2560,
      20
    ]
  },
  "block.mlp.shared_expert.down_proj.weight": {
    "data_offsets": [
      1584006176,
      1585234976
    ],
    "dtype": "U32",
    "shape": [
      2560,
      120
    ]
  },
  "block.mlp.shared_expert.gate_proj.biases": {
    "data_offsets": [
      88217216,
      88319616
    ],
    "dtype": "BF16",
    "shape": [
      640,
      80
    ]
  },
  "block.mlp.shared_expert.gate_proj.scales": {
    "data_offsets": [
      140748416,
      140850816
    ],
    "dtype": "BF16",
    "shape": [
      640,
      80
    ]
  },
  "block.mlp.shared_expert.gate_proj.weight": {
    "data_offsets": [
      141362816,
      142591616
    ],
    "dtype": "U32",
    "shape": [
      640,
      480
    ]
  },
  "block.mlp.shared_expert.up_proj.biases": {
    "data_offsets": [
      87026816,
      87129216
    ],
    "dtype": "BF16",
    "shape": [
      640,
      80
    ]
  },
  "block.mlp.shared_expert.up_proj.scales": {
    "data_offsets": [
      2273857216,
      2273959616
    ],
    "dtype": "BF16",
    "shape": [
      640,
      80
    ]
  },
  "block.mlp.shared_expert.up_proj.weight": {
    "data_offsets": [
      881499936,
      882728736
    ],
    "dtype": "U32",
    "shape": [
      640,
      480
    ]
  },
  "block.mlp.shared_expert_gate.biases": {
    "data_offsets": [
      2271604256,
      2271604416
    ],
    "dtype": "BF16",
    "shape": [
      1,
      80
    ]
  },
  "block.mlp.shared_expert_gate.scales": {
    "data_offsets": [
      142591616,
      142591776
    ],
    "dtype": "BF16",
    "shape": [
      1,
      80
    ]
  },
  "block.mlp.shared_expert_gate.weight": {
    "data_offsets": [
      86922240,
      86924160
    ],
    "dtype": "U32",
    "shape": [
      1,
      480
    ]
  },
  "block.mlp.switch_mlp.down_proj.biases": {
    "data_offsets": [
      1585234976,
      1637663776
    ],
    "dtype": "BF16",
    "shape": [
      512,
      2560,
      20
    ]
  },
  "block.mlp.switch_mlp.down_proj.scales": {
    "data_offsets": [
      142796576,
      195225376
    ],
    "dtype": "BF16",
    "shape": [
      512,
      2560,
      20
    ]
  },
  "block.mlp.switch_mlp.down_proj.weight": {
    "data_offsets": [
      1637663776,
      2266809376
    ],
    "dtype": "U32",
    "shape": [
      512,
      2560,
      120
    ]
  },
  "block.mlp.switch_mlp.gate_proj.biases": {
    "data_offsets": [
      88319616,
      140748416
    ],
    "dtype": "BF16",
    "shape": [
      512,
      640,
      80
    ]
  },
  "block.mlp.switch_mlp.gate_proj.scales": {
    "data_offsets": [
      34493440,
      86922240
    ],
    "dtype": "BF16",
    "shape": [
      512,
      640,
      80
    ]
  },
  "block.mlp.switch_mlp.gate_proj.weight": {
    "data_offsets": [
      887705376,
      1516850976
    ],
    "dtype": "U32",
    "shape": [
      512,
      640,
      480
    ]
  },
  "block.mlp.switch_mlp.up_proj.biases": {
    "data_offsets": [
      197928736,
      250357536
    ],
    "dtype": "BF16",
    "shape": [
      512,
      640,
      80
    ]
  },
  "block.mlp.switch_mlp.up_proj.scales": {
    "data_offsets": [
      1531495456,
      1583924256
    ],
    "dtype": "BF16",
    "shape": [
      512,
      640,
      80
    ]
  },
  "block.mlp.switch_mlp.up_proj.weight": {
    "data_offsets": [
      251340576,
      880486176
    ],
    "dtype": "U32",
    "shape": [
      512,
      640,
      480
    ]
  },
  "block.mlp_hyper_connection.block_inject_weight.biases": {
    "data_offsets": [
      28907520,
      28910080
    ],
    "dtype": "BF16",
    "shape": [
      4,
      320
    ]
  },
  "block.mlp_hyper_connection.block_inject_weight.scales": {
    "data_offsets": [
      2266809376,
      2266811936
    ],
    "dtype": "BF16",
    "shape": [
      4,
      320
    ]
  },
  "block.mlp_hyper_connection.block_inject_weight.weight": {
    "data_offsets": [
      28910080,
      28940800
    ],
    "dtype": "U32",
    "shape": [
      4,
      1920
    ]
  },
  "block.mlp_hyper_connection.hc_norm.weight": {
    "data_offsets": [
      34060800,
      34081280
    ],
    "dtype": "BF16",
    "shape": [
      10240
    ]
  },
  "block.mlp_hyper_connection.input_mix_weight_down.biases": {
    "data_offsets": [
      31398400,
      31603200
    ],
    "dtype": "BF16",
    "shape": [
      320,
      320
    ]
  },
  "block.mlp_hyper_connection.input_mix_weight_down.scales": {
    "data_offsets": [
      140850816,
      141055616
    ],
    "dtype": "BF16",
    "shape": [
      320,
      320
    ]
  },
  "block.mlp_hyper_connection.input_mix_weight_down.weight": {
    "data_offsets": [
      31603200,
      34060800
    ],
    "dtype": "U32",
    "shape": [
      320,
      1920
    ]
  },
  "block.mlp_hyper_connection.input_mix_weight_up.biases": {
    "data_offsets": [
      142591776,
      142796576
    ],
    "dtype": "BF16",
    "shape": [
      10240,
      10
    ]
  },
  "block.mlp_hyper_connection.input_mix_weight_up.scales": {
    "data_offsets": [
      882728736,
      882933536
    ],
    "dtype": "BF16",
    "shape": [
      10240,
      10
    ]
  },
  "block.mlp_hyper_connection.input_mix_weight_up.weight": {
    "data_offsets": [
      28940800,
      31398400
    ],
    "dtype": "U32",
    "shape": [
      10240,
      60
    ]
  },
  "block.self_attn.indexer.index_qk_proj.biases": {
    "data_offsets": [
      885145376,
      885247776
    ],
    "dtype": "BF16",
    "shape": [
      640,
      80
    ]
  },
  "block.self_attn.indexer.index_qk_proj.scales": {
    "data_offsets": [
      141260416,
      141362816
    ],
    "dtype": "BF16",
    "shape": [
      640,
      80
    ]
  },
  "block.self_attn.indexer.index_qk_proj.weight": {
    "data_offsets": [
      882933536,
      884162336
    ],
    "dtype": "U32",
    "shape": [
      640,
      480
    ]
  },
  "block.self_attn.indexer.k_layernorm.weight": {
    "data_offsets": [
      1516850976,
      1516851232
    ],
    "dtype": "BF16",
    "shape": [
      128
    ]
  },
  "block.self_attn.indexer.q_layernorm.weight": {
    "data_offsets": [
      86924160,
      86924416
    ],
    "dtype": "BF16",
    "shape": [
      128
    ]
  },
  "block.self_attn.k_norm.weight": {
    "data_offsets": [
      1517077024,
      1517077536
    ],
    "dtype": "BF16",
    "shape": [
      256
    ]
  },
  "block.self_attn.k_proj.biases": {
    "data_offsets": [
      2266811936,
      2266893856
    ],
    "dtype": "BF16",
    "shape": [
      512,
      80
    ]
  },
  "block.self_attn.k_proj.scales": {
    "data_offsets": [
      2273775296,
      2273857216
    ],
    "dtype": "BF16",
    "shape": [
      512,
      80
    ]
  },
  "block.self_attn.k_proj.weight": {
    "data_offsets": [
      880516896,
      881499936
    ],
    "dtype": "U32",
    "shape": [
      512,
      480
    ]
  },
  "block.self_attn.o_proj.biases": {
    "data_offsets": [
      884162336,
      885145376
    ],
    "dtype": "BF16",
    "shape": [
      2560,
      192
    ]
  },
  "block.self_attn.o_proj.scales": {
    "data_offsets": [
      250357536,
      251340576
    ],
    "dtype": "BF16",
    "shape": [
      2560,
      192
    ]
  },
  "block.self_attn.o_proj.weight": {
    "data_offsets": [
      1519698976,
      1531495456
    ],
    "dtype": "U32",
    "shape": [
      2560,
      1152
    ]
  },
  "block.self_attn.q_norm.weight": {
    "data_offsets": [
      1517056032,
      1517056544
    ],
    "dtype": "BF16",
    "shape": [
      256
    ]
  },
  "block.self_attn.q_proj.biases": {
    "data_offsets": [
      2269638176,
      2271604256
    ],
    "dtype": "BF16",
    "shape": [
      12288,
      80
    ]
  },
  "block.self_attn.q_proj.scales": {
    "data_offsets": [
      2271809216,
      2273775296
    ],
    "dtype": "BF16",
    "shape": [
      12288,
      80
    ]
  },
  "block.self_attn.q_proj.weight": {
    "data_offsets": [
      2273959616,
      2297552576
    ],
    "dtype": "U32",
    "shape": [
      12288,
      480
    ]
  },
  "block.self_attn.v_proj.biases": {
    "data_offsets": [
      2266893856,
      2266975776
    ],
    "dtype": "BF16",
    "shape": [
      512,
      80
    ]
  },
  "block.self_attn.v_proj.scales": {
    "data_offsets": [
      1583924256,
      1584006176
    ],
    "dtype": "BF16",
    "shape": [
      512,
      80
    ]
  },
  "block.self_attn.v_proj.weight": {
    "data_offsets": [
      87234176,
      88217216
    ],
    "dtype": "U32",
    "shape": [
      512,
      480
    ]
  },
  "fc.weight": {
    "data_offsets": [
      0,
      26214400
    ],
    "dtype": "BF16",
    "shape": [
      2560,
      5120
    ]
  },
  "mixer.hc_norm.weight": {
    "data_offsets": [
      28887040,
      28907520
    ],
    "dtype": "BF16",
    "shape": [
      10240
    ]
  },
  "mixer.input_mix_weight_down.biases": {
    "data_offsets": [
      26224640,
      26429440
    ],
    "dtype": "BF16",
    "shape": [
      320,
      320
    ]
  },
  "mixer.input_mix_weight_down.scales": {
    "data_offsets": [
      1516851232,
      1517056032
    ],
    "dtype": "BF16",
    "shape": [
      320,
      320
    ]
  },
  "mixer.input_mix_weight_down.weight": {
    "data_offsets": [
      26429440,
      28887040
    ],
    "dtype": "U32",
    "shape": [
      320,
      1920
    ]
  },
  "mixer.input_mix_weight_up.biases": {
    "data_offsets": [
      2271604416,
      2271809216
    ],
    "dtype": "BF16",
    "shape": [
      10240,
      10
    ]
  },
  "mixer.input_mix_weight_up.scales": {
    "data_offsets": [
      34081280,
      34286080
    ],
    "dtype": "BF16",
    "shape": [
      10240,
      10
    ]
  },
  "mixer.input_mix_weight_up.weight": {
    "data_offsets": [
      885247776,
      887705376
    ],
    "dtype": "U32",
    "shape": [
      10240,
      60
    ]
  },
  "norm_e.weight": {
    "data_offsets": [
      26214400,
      26224640
    ],
    "dtype": "F32",
    "shape": [
      2560
    ]
  },
  "norm_h.weight": {
    "data_offsets": [
      195225376,
      195266336
    ],
    "dtype": "F32",
    "shape": [
      10240
    ]
  }
}
````

### frozen-allocator-reuse-v1/build-identity.json

Original bytes: 31350. SHA-256: `4d41ad2aeecf69d4e6adeba62a1150a4ddc8c155b22c3855f76f0ebe7b18cc8f`.

Normalized bytes: 31350. SHA-256: `4d41ad2aeecf69d4e6adeba62a1150a4ddc8c155b22c3855f76f0ebe7b18cc8f`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "14114d449ff37e3bcbdb6164b79c716e78f8498837a268976e157950aacd3859",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "f0950d99825896a97cd1989d0b56d5fa075294fe47057175af8972e90e90501c",
    "Sources/Slotstream/VQExpertKernels.swift": "3d0a9c22935d8984583ea59cf94a923f31ac03f8944ae570abb0b6b9749ded86",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "969a6f7139be266cb0a45e51d5f7885d0090704378fc3286ec44b81bcee631f5",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "51cfa0e87789742e06383cca422ab85656ec0f3cfe3fed2660b99115bbd33a70",
    "Sources/Slotstream/VQRecordBank.swift": "e73d822499fb5f88379794dc012cae461f279adb761879795da196d8b64983a6",
    "Sources/Slotstream/VQRecordCache.swift": "4b418eccf814e9aec7ac1b8bac01a0bad89dfbd8c7ef26223a4531d95ccf0f15",
    "Sources/Slotstream/VQRecordReadBatch.swift": "1eae4e09e69bf0a16cfb55721f004b36aa038c6745ec4f3b05e3a41b21f678fc",
    "Sources/Slotstream/VQRecordReadPlan.swift": "2cc1f093b52aaac1bf19fb75ba76ca347da08a026a8cadc673b2ccf3d2f5ff7e",
    "Sources/Slotstream/VQResidentText.swift": "40f720e7dfd3c180f7b6bfb5f9eb2fb3861b65a12d64f412c6dc0c0874ab2761",
    "Sources/Slotstream/VQRotaryTable.swift": "effaca0017e9bf7047f181e4e63de212aa64e6e3531278902b7d6353bcd619c1",
    "Sources/Slotstream/VQRouteStream.swift": "b4bf62f52ffe7cc3a8a6daece599f2fb077b65da2e5911f5f273f8d414e487ab",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+Quantization.swift": "667ed424ecef89ac38d11d3803dad4f13c7e1a94e64c9512ab641fd71831f328",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQGeneration.swift": "cb9ebefecd4659bbac061b5cce5d57f8b36b52c7a46b56c5f4025ba8fb92a6e4",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "4d902e2d7231874213d5bbc003d92f485ec119dc925f2f8bc91a03e6f7775d1e",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQParallelBank.swift": "759f747c8adb4e89e3f7caaf72ae57fbbb4cc993c08f7ea87ed4a7336ae95088",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPerformance.swift": "51c0213c8589bd50c6ebe19ee0d56c4b6431d746df1432bc2c5bc17b09d21ea0",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "ecd13f382803ee387cf384cd722825cdad996e8cc3500799fa532c8f5f2933ed",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQReadBatch.swift": "676209813620c2aaf7992bf03bd1fa6f108a9898ebd0e9cb4ab863afbf7fedc1",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "f61cfb7d10f341e8ee12c32a58a874b10f27bb7ba5b8a9cde75e1217693867d8",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQTensorFile.swift": "af0d99556cbc8591034905c3883bf07628a0773f232122a0ee5e3ea0295453a1",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "a82963eda38e950ef637c49fcda06e97bd69831c120ea9eb11f18893dc03aabe",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "1539fa20986c554865714a5b17d23c5563917419fd044ec2ab3972b8608f9355",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "9a48cfc42ab4b7814c4b64a49c86c892f7ce2617aa48f634531518891e39c661",
  "binary_sha256": "2f7020b03c17dbc7ab3de52018af2ee96445a9445c094356ef3037c5dc946a1a",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
