---
type: run
created: 2026-10-03T15:41:29.697056+00:00
updated: 2026-10-03T15:41:29.697056+00:00
summary: Composite draft reference passes input identity but original native prefill exceeds parity tolerance
binary: 0c435ae491263b4bae35aaec29845d0e7f6507170ce411f3c1a811b3c1f52fff
captured_at: 2026-10-03
command: Exact sequential commands are preserved in the driver and supervision identities below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Composite draft reference passes input identity but original native prefill exceeds parity tolerance
tool: bounded VQ research diagnostics
---

The CPU-only sidecar inventory authenticates the original four-bit group-64 draft independently from the VQ trunk: 68 tensors, 18 quantized modules, 1470955171 file bytes and 1470946816 payload bytes. The complete-file and header hashes plus conversion metadata are captured below. No model is run by that inventory producer.

One independent Python composite prefill matches all 160 previously frozen boundaries and next token 760. The same process releases the main model and constructs an original four-bit draft head with its own metadata, then emits a 2253521-byte BF16 fixture from 43 real composite-input entries and one cached step. Its complete input and producer identity, 43/44 cache offsets and 2424162872-byte physical peak are preserved. No old fixture is changed.

The first orchestration attempt stops before native launch because the generic supervisor's preflight cannot be called inside the parent-held model lock. A separate explicit native-only correction performs the same 13-GB preflight before acquiring that lock, monitors the actual single child with a ten-GB physical bound and three-GB headroom, and makes exactly one native call. The original native head executes while the parent holds the model lock, reproducing the standalone MTP loader's missing exclusion check. That run peaks at 1608042320 bytes and fails its unchanged two-percent parity gate: prefill sample relative maximum 0.02927 and multi 0.02970; the cached step matches exactly. This is a preserved failed component qualification, not permission to relax tolerance or claim working speculation.

The native producer block below binds only the original native command. The separately captured Python reference receipt binds its producer, dependencies and runtime; the CPU inventory is explicitly CPU-only. No throughput or draft acceptance measurement is made.

Local home prefixes are replaced with <HOME>. Original byte lengths and hashes identify the unmodified local files. For large transcripts, the normalized UTF-8 bytes are stored losslessly as zlib-compressed base64 inside this Markdown source. Decode with `zlib.decompress(base64.b64decode(block))` and verify the listed normalized byte length and SHA-256. Every encoded block was round-trip checked before writing. This changes storage only, not the captured evidence. Small transcripts remain plain text. Raw tensor fixtures and source-bound executables remain in the bounded research directory; manifests bind their hashes. No model is installed or activated.

### capture-vq-draft-initial-v1.py

Original bytes: 3279. SHA-256: `be21fdff8c990268714d55e529f6715f73768fc23c2c3d4901be0859e74a7320`.

Normalized bytes: 3279. SHA-256: `be21fdff8c990268714d55e529f6715f73768fc23c2c3d4901be0859e74a7320`.

````text
from pathlib import Path
import json,runpy,hashlib,shutil
r=Path('.build/quantization-research');h=runpy.run_path(str(r/'capture-vq-kernel-cache-v1.py'))
d=json.loads((r/'vq-composite-draft-v1/run.json').read_text());assert not d['complete'] and len(d['runs'])==1
ref=json.loads((r/'vq-composite-draft-v1/reference/receipt.json').read_text());assert ref['passed']
n=json.loads((r/'vq-composite-draft-legacy-v2/run.json').read_text());assert n['exit_code']==2 and n['parent_held_model_lock']
shutil.copy2('Tools/vq_composite_draft_reference.py',r/'vq_composite_draft_reference.py')
files=['capture-vq-draft-initial-v1.py','vq-baseline-draft-hypothesis-v1.json','vq-baseline-draft-inventory-prototype-v1.py','vq-baseline-draft-inventory-v1.json','vq-baseline-draft-inventory-v1.log','vq_composite_draft_reference.py','run-vq-composite-draft-v1.py','vq-composite-draft-v1/run.json','vq-composite-draft-v1.log','vq-composite-draft-v1/reference/receipt.json','run-vq-composite-draft-legacy-v2.py','vq-composite-draft-legacy-v2.log','vq-composite-draft-legacy-v2/run.json','vq-composite-draft-legacy-v2/stdout.txt','vq-composite-draft-legacy-v2/stderr.txt']+h['supervision']('vq-composite-draft-v1/reference-supervision')
h['capture']('vq-composite-draft-initial-parity-failure','Composite draft reference passes input identity but original native prefill exceeds parity tolerance', '''The CPU-only sidecar inventory authenticates the original four-bit group-64 draft independently from the VQ trunk: 68 tensors, 18 quantized modules, 1470955171 file bytes and 1470946816 payload bytes. The complete-file and header hashes plus conversion metadata are captured below. No model is run by that inventory producer.

One independent Python composite prefill matches all 160 previously frozen boundaries and next token 760. The same process releases the main model and constructs an original four-bit draft head with its own metadata, then emits a 2253521-byte BF16 fixture from 43 real composite-input entries and one cached step. Its complete input and producer identity, 43/44 cache offsets and 2424162872-byte physical peak are preserved. No old fixture is changed.

The first orchestration attempt stops before native launch because the generic supervisor's preflight cannot be called inside the parent-held model lock. A separate explicit native-only correction performs the same 13-GB preflight before acquiring that lock, monitors the actual single child with a ten-GB physical bound and three-GB headroom, and makes exactly one native call. The original native head executes while the parent holds the model lock, reproducing the standalone MTP loader's missing exclusion check. That run peaks at 1608042320 bytes and fails its unchanged two-percent parity gate: prefill sample relative maximum 0.02927 and multi 0.02970; the cached step matches exactly. This is a preserved failed component qualification, not permission to relax tolerance or claim working speculation.

The native producer block below binds only the original native command. The separately captured Python reference receipt binds its producer, dependencies and runtime; the CPU inventory is explicitly CPU-only. No throughput or draft acceptance measurement is made.''',files,'vq-contiguous-build-v1/candidate')
````

### vq-baseline-draft-hypothesis-v1.json

Original bytes: 2695. SHA-256: `3599100a1378251167b746acadb980d5a54f356d645a92a032dbce7c6c0eccc7`.

Normalized bytes: 2695. SHA-256: `3599100a1378251167b746acadb980d5a54f356d645a92a032dbce7c6c0eccc7`.

````text
{
  "schema": 1,
  "status": "prospective component-admission experiment; no draft run started",
  "hypothesis": "Reuse the pinned original four-bit MTP sidecar with the same-checkpoint VQ-expert/dense-four-bit composite. Its embedding and output-head tensors already match the original four-bit representation; the draft head must retain its separate four-bit configuration and official full-width hidden normalization. Main-model verification remains mandatory before any draft output could be committed.",
  "composite_sha256": "f31f100d47f062c415251d92a4c14956b2328e393294a9680eb2ba9c1664f645",
  "draft_file_bytes": 1470955171,
  "draft_file_sha256": "c80b58faae46eeacb94dea49dd3453566ee05597fbd28c7c647eccb2862ab744",
  "additional_weights_bytes": 0,
  "maximum_additional_fixture_bytes": 8000000,
  "maximum_additional_raw_f32_bytes": 5000000,
  "maximum_total_staging_bytes": 350000000000,
  "maximum_total_raw_f32_bytes": 2000000000,
  "minimum_reclaimable_bytes": 13000000000,
  "minimum_remaining_headroom_bytes": 3000000000,
  "reference_maximum_process_bytes": 4000000000,
  "native_maximum_process_bytes": 10000000000,
  "maximum_model_processes_concurrent": 1,
  "maximum_reference_runs": 1,
  "maximum_native_component_runs": 2,
  "maximum_seconds_per_reference": 7200,
  "maximum_seconds_per_native": 1800,
  "paid_compute": false,
  "gates": [
    "Finish the current read-layout campaign before any head hashing, model run or build.",
    "Bind exact baseline config, draft file/header/tensor extents, conversion provenance and separate recipe; do not reuse the trunk default quantization for the head.",
    "Capture an independent on-manifold composite prefill and next-token embedding matching the existing greedy boundary hashes; release the main model before reference head loading.",
    "Produce independently pinned draft prefill and cached-step outputs under the existing official full-width normalization contract. Preserve numerical failures without tuning tolerances or replacing old goldens.",
    "Authenticate and materialize every native head tensor through owned verified descriptors with explicit payload/load-copy bounds; verify finite outputs, state alignment, exact input identity and reference parity.",
    "Require separate main-state snapshot, batched verification, rejection rollback, EOS, cancellation, sequence and cost gates before speculative generation. Component parity alone enables no serving, Auto, speed claim or distribution."
  ],
  "scope": "Existing local artifacts and reviewed local source only. No product activation, installed-file edit, new quality verdict or context-limit change. Preserve every attempt; no automatic retries."
}
````

### vq-baseline-draft-inventory-prototype-v1.py

Original bytes: 5018. SHA-256: `7818f16d375ba502a0e31610933ae15c0f8b50ff1c2c96e36e748af4a5840972`.

Normalized bytes: 5018. SHA-256: `7818f16d375ba502a0e31610933ae15c0f8b50ff1c2c96e36e748af4a5840972`.

````text
"""Bounded CPU inventory of the existing pinned affine-four-bit draft head.

Run only after the current timing campaign completes. This exports metadata,
never new model weights or a product support verdict.
"""
from pathlib import Path
import hashlib,json,os,stat,sys
sys.path.insert(0,str(Path.cwd()/'Tools'))
from quantization_inventory import unique_json,validate_header
from context_qualification import quiet_preflight,verification_lock
from vq_ple_stream import stamp

FILE_BYTES=1470955171
FILE_SHA='c80b58faae46eeacb94dea49dd3453566ee05597fbd28c7c647eccb2862ab744'
CONFIG_SHA='0da22a8ed4323fbe969bf982aeb054743b315206791f28ef74a309c707080ba5'

def inspect(directory):
    config_fd=os.open(directory/'config.json',os.O_RDONLY|os.O_NOFOLLOW|os.O_NONBLOCK)
    with os.fdopen(config_fd,'rb') as file:
        initial=os.fstat(file.fileno())
        if not stat.S_ISREG(initial.st_mode) or initial.st_size!=33408:
            raise ValueError('baseline configuration extent changed')
        config=file.read(33409)
        if len(config)!=33408 or hashlib.sha256(config).hexdigest()!=CONFIG_SHA or stamp(os.fstat(file.fileno()))!=stamp(initial):
            raise ValueError('baseline configuration changed')
    fd=os.open(directory/'mtp.safetensors',os.O_RDONLY|os.O_NOFOLLOW|os.O_NONBLOCK)
    with os.fdopen(fd,'rb') as file:
        before=os.fstat(file.fileno())
        if not stat.S_ISREG(before.st_mode) or before.st_size!=FILE_BYTES:
            raise ValueError('draft file size or kind changed')
        prefix=file.read(8);length=int.from_bytes(prefix,'little')
        if len(prefix)!=8 or not 0<length<=64000:raise ValueError('draft header exceeds its bound')
        raw=file.read(length)
        if len(raw)!=length:raise ValueError('short draft header')
        header=unique_json(raw);validate_header(header,FILE_BYTES-8-length)
        digest=hashlib.sha256();file.seek(0)
        for block in iter(lambda:file.read(1000000),b''):digest.update(block)
        if digest.hexdigest()!=FILE_SHA or stamp(os.fstat(file.fileno()))!=stamp(before):
            raise ValueError('draft payload failed complete owned-file authentication')
    tensors={k:v for k,v in header.items() if k!='__metadata__'}
    if not all(k.startswith('mtp.') for k in tensors):raise ValueError('draft namespace changed')
    if tensors['mtp.pre_fc_norm_hidden.weight']['shape']!=[10240] or tensors['mtp.pre_fc_norm_embedding.weight']['shape']!=[2560]:
        raise ValueError('full-width draft normalization geometry changed')
    modules=[]
    for name,value in tensors.items():
        if value['dtype']=='U32':
            if not name.endswith('.weight'):raise ValueError('unrecognized packed draft tensor')
            base=name[:-7];scales=tensors.get(base+'.scales');biases=tensors.get(base+'.biases')
            if (not scales or not biases or scales['dtype']!='BF16' or biases['dtype']!='BF16'
                or scales['shape']!=biases['shape'] or value['shape'][:-1]!=scales['shape'][:-1]
                or value['shape'][-1]!=scales['shape'][-1]*8):
                raise ValueError('draft tensor does not match its separate affine-four-bit group-64 recipe')
            modules.append(base)
        elif value['dtype']!='BF16':raise ValueError('uninspected draft dtype')
    sizes={k:v['data_offsets'][1]-v['data_offsets'][0] for k,v in tensors.items()}
    experts={k:v for k,v in tensors.items() if '.switch_mlp.' in k}
    if len(experts)!=9 or any(v['shape'][0]!=512 for v in experts.values()):raise ValueError('draft expert coverage changed')
    return {'schema':1,'scope':'CPU inventory only; no composite draft binding or execution qualification',
        'config':{'file_bytes':len(config),'sha256':CONFIG_SHA},
        'file_bytes':FILE_BYTES,'file_sha256':FILE_SHA,'header_bytes':length,
        'header_sha256':hashlib.sha256(raw).hexdigest(),'header_prefix_sha256':hashlib.sha256(prefix+raw).hexdigest(),
        'payload_verified':True,'quantization':{'kind':'affine','bits':4,'group_size':64},
        'normalization':'already folded BF16 scales; ordinary RMS with full-width hidden statistics',
        'tensor_count':len(tensors),'quantized_modules':sorted(modules),'tensor_payload_bytes':sum(sizes.values()),
        'expert_payload_bytes':sum(sizes[k] for k in experts),'largest_tensor_bytes':max(sizes.values()),
        'metadata':header.get('__metadata__',{}),'tensors':tensors}

if __name__=='__main__':
    import argparse
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--baseline',type=Path,required=True);p.add_argument('--out',type=Path,required=True);a=p.parse_args()
    before=quiet_preflight(13)
    with verification_lock():result=inspect(a.baseline)
    result['before']=before;result['producer_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    with a.out.open('x') as f:f.write(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('tensors','before','metadata','quantized_modules')}))
````

### vq-baseline-draft-inventory-v1.json

Original bytes: 18018. SHA-256: `15160e242b4961ccf418bfed43a30e7624d734060cff6bf176b7a491b8a906ad`.

Normalized bytes: 18018. SHA-256: `15160e242b4961ccf418bfed43a30e7624d734060cff6bf176b7a491b8a906ad`.

````text
{
  "schema": 1,
  "scope": "CPU inventory only; no composite draft binding or execution qualification",
  "config": {
    "file_bytes": 33408,
    "sha256": "0da22a8ed4323fbe969bf982aeb054743b315206791f28ef74a309c707080ba5"
  },
  "file_bytes": 1470955171,
  "file_sha256": "c80b58faae46eeacb94dea49dd3453566ee05597fbd28c7c647eccb2862ab744",
  "header_bytes": 8347,
  "header_sha256": "836ae4156c99452e932c7a81322bcca959ac6f7ed86d6270cfd56ff94c62f4b9",
  "header_prefix_sha256": "9e8fdaa642163c998c43137e2825f7febc02b1ccec6b6e3a9cc1ff8ee01c4b8d",
  "payload_verified": true,
  "quantization": {
    "kind": "affine",
    "bits": 4,
    "group_size": 64
  },
  "normalization": "already folded BF16 scales; ordinary RMS with full-width hidden statistics",
  "tensor_count": 68,
  "quantized_modules": [
    "mtp.fc_embedding",
    "mtp.fc_hidden",
    "mtp.hyper_connection_mixer.input_mix_weight_down",
    "mtp.hyper_connection_mixer.input_mix_weight_up",
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_down",
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_up",
    "mtp.layers.0.mlp.shared_expert.down_proj",
    "mtp.layers.0.mlp.shared_expert.gate_proj",
    "mtp.layers.0.mlp.shared_expert.up_proj",
    "mtp.layers.0.mlp.switch_mlp.down_proj",
    "mtp.layers.0.mlp.switch_mlp.gate_proj",
    "mtp.layers.0.mlp.switch_mlp.up_proj",
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_down",
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_up",
    "mtp.layers.0.self_attn.k_proj",
    "mtp.layers.0.self_attn.o_proj",
    "mtp.layers.0.self_attn.q_proj",
    "mtp.layers.0.self_attn.v_proj"
  ],
  "tensor_payload_bytes": 1470946816,
  "expert_payload_bytes": 1415577600,
  "largest_tensor_bytes": 419430400,
  "metadata": {
    "recipe": "4-bit group 64 affine, router/gates/norms bf16, centered norms +1-folded (incl. pre_fc norms)",
    "source_repo": "Qwen/Qwen3.8-Flash-Next",
    "source_revision": "de4b8e4d43b917e7706784d8bb445c9af86a3540"
  },
  "tensors": {
    "mtp.fc_embedding.biases": {
      "data_offsets": [
        1459109376,
        1459314176
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        40
      ]
    },
    "mtp.fc_embedding.scales": {
      "data_offsets": [
        1469103616,
        1469308416
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        40
      ]
    },
    "mtp.fc_embedding.weight": {
      "data_offsets": [
        1462596096,
        1465872896
      ],
      "dtype": "U32",
      "shape": [
        2560,
        320
      ]
    },
    "mtp.fc_hidden.biases": {
      "data_offsets": [
        1466052096,
        1466256896
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        40
      ]
    },
    "mtp.fc_hidden.scales": {
      "data_offsets": [
        1466256896,
        1466461696
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        40
      ]
    },
    "mtp.fc_hidden.weight": {
      "data_offsets": [
        1455832576,
        1459109376
      ],
      "dtype": "U32",
      "shape": [
        2560,
        320
      ]
    },
    "mtp.hyper_connection_mixer.hc_norm.weight": {
      "data_offsets": [
        1466031616,
        1466052096
      ],
      "dtype": "BF16",
      "shape": [
        10240
      ]
    },
    "mtp.hyper_connection_mixer.input_mix_weight_down.biases": {
      "data_offsets": [
        1465878016,
        1465980416
      ],
      "dtype": "BF16",
      "shape": [
        320,
        160
      ]
    },
    "mtp.hyper_connection_mixer.input_mix_weight_down.scales": {
      "data_offsets": [
        585944320,
        586046720
      ],
      "dtype": "BF16",
      "shape": [
        320,
        160
      ]
    },
    "mtp.hyper_connection_mixer.input_mix_weight_down.weight": {
      "data_offsets": [
        1459314176,
        1460952576
      ],
      "dtype": "U32",
      "shape": [
        320,
        1280
      ]
    },
    "mtp.hyper_connection_mixer.input_mix_weight_up.biases": {
      "data_offsets": [
        1031742976,
        1031845376
      ],
      "dtype": "BF16",
      "shape": [
        10240,
        5
      ]
    },
    "mtp.hyper_connection_mixer.input_mix_weight_up.scales": {
      "data_offsets": [
        1454091776,
        1454194176
      ],
      "dtype": "BF16",
      "shape": [
        10240,
        5
      ]
    },
    "mtp.hyper_connection_mixer.input_mix_weight_up.weight": {
      "data_offsets": [
        1469308416,
        1470946816
      ],
      "dtype": "U32",
      "shape": [
        10240,
        40
      ]
    },
    "mtp.layers.0.attn_hyper_connection.block_inject_weight.weight": {
      "data_offsets": [
        58942720,
        59024640
      ],
      "dtype": "BF16",
      "shape": [
        4,
        10240
      ]
    },
    "mtp.layers.0.attn_hyper_connection.hc_norm.weight": {
      "data_offsets": [
        1469083136,
        1469103616
      ],
      "dtype": "BF16",
      "shape": [
        10240
      ]
    },
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_down.biases": {
      "data_offsets": [
        1032050176,
        1032152576
      ],
      "dtype": "BF16",
      "shape": [
        320,
        160
      ]
    },
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_down.scales": {
      "data_offsets": [
        1033668096,
        1033770496
      ],
      "dtype": "BF16",
      "shape": [
        320,
        160
      ]
    },
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_down.weight": {
      "data_offsets": [
        1454194176,
        1455832576
      ],
      "dtype": "U32",
      "shape": [
        320,
        1280
      ]
    },
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_up.biases": {
      "data_offsets": [
        1031845376,
        1031947776
      ],
      "dtype": "BF16",
      "shape": [
        10240,
        5
      ]
    },
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_up.scales": {
      "data_offsets": [
        1032746496,
        1032848896
      ],
      "dtype": "BF16",
      "shape": [
        10240,
        5
      ]
    },
    "mtp.layers.0.attn_hyper_connection.input_mix_weight_up.weight": {
      "data_offsets": [
        1460957696,
        1462596096
      ],
      "dtype": "U32",
      "shape": [
        10240,
        40
      ]
    },
    "mtp.layers.0.mlp.gate.weight": {
      "data_offsets": [
        1466461696,
        1469083136
      ],
      "dtype": "BF16",
      "shape": [
        512,
        2560
      ]
    },
    "mtp.layers.0.mlp.shared_expert.down_proj.biases": {
      "data_offsets": [
        60663040,
        60714240
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        10
      ]
    },
    "mtp.layers.0.mlp.shared_expert.down_proj.scales": {
      "data_offsets": [
        1034610176,
        1034661376
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        10
      ]
    },
    "mtp.layers.0.mlp.shared_expert.down_proj.weight": {
      "data_offsets": [
        60765440,
        61584640
      ],
      "dtype": "U32",
      "shape": [
        2560,
        80
      ]
    },
    "mtp.layers.0.mlp.shared_expert.gate_proj.biases": {
      "data_offsets": [
        60714240,
        60765440
      ],
      "dtype": "BF16",
      "shape": [
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.shared_expert.gate_proj.scales": {
      "data_offsets": [
        87819520,
        87870720
      ],
      "dtype": "BF16",
      "shape": [
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.shared_expert.gate_proj.weight": {
      "data_offsets": [
        1033770496,
        1034589696
      ],
      "dtype": "U32",
      "shape": [
        640,
        320
      ]
    },
    "mtp.layers.0.mlp.shared_expert.up_proj.biases": {
      "data_offsets": [
        1031691776,
        1031742976
      ],
      "dtype": "BF16",
      "shape": [
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.shared_expert.up_proj.scales": {
      "data_offsets": [
        1465980416,
        1466031616
      ],
      "dtype": "BF16",
      "shape": [
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.shared_expert.up_proj.weight": {
      "data_offsets": [
        1032848896,
        1033668096
      ],
      "dtype": "U32",
      "shape": [
        640,
        320
      ]
    },
    "mtp.layers.0.mlp.shared_expert_gate.weight": {
      "data_offsets": [
        1460952576,
        1460957696
      ],
      "dtype": "BF16",
      "shape": [
        1,
        2560
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.down_proj.biases": {
      "data_offsets": [
        559729920,
        585944320
      ],
      "dtype": "BF16",
      "shape": [
        512,
        2560,
        10
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.down_proj.scales": {
      "data_offsets": [
        586046976,
        612261376
      ],
      "dtype": "BF16",
      "shape": [
        512,
        2560,
        10
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.down_proj.weight": {
      "data_offsets": [
        612261376,
        1031691776
      ],
      "dtype": "U32",
      "shape": [
        512,
        2560,
        80
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.gate_proj.biases": {
      "data_offsets": [
        114085120,
        140299520
      ],
      "dtype": "BF16",
      "shape": [
        512,
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.gate_proj.scales": {
      "data_offsets": [
        30905600,
        57120000
      ],
      "dtype": "BF16",
      "shape": [
        512,
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.gate_proj.weight": {
      "data_offsets": [
        140299520,
        559729920
      ],
      "dtype": "U32",
      "shape": [
        512,
        640,
        320
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.up_proj.biases": {
      "data_offsets": [
        61605120,
        87819520
      ],
      "dtype": "BF16",
      "shape": [
        512,
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.up_proj.scales": {
      "data_offsets": [
        87870720,
        114085120
      ],
      "dtype": "BF16",
      "shape": [
        512,
        640,
        40
      ]
    },
    "mtp.layers.0.mlp.switch_mlp.up_proj.weight": {
      "data_offsets": [
        1034661376,
        1454091776
      ],
      "dtype": "U32",
      "shape": [
        512,
        640,
        320
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.block_inject_weight.weight": {
      "data_offsets": [
        57120000,
        57201920
      ],
      "dtype": "BF16",
      "shape": [
        4,
        10240
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.hc_norm.weight": {
      "data_offsets": [
        61584640,
        61605120
      ],
      "dtype": "BF16",
      "shape": [
        10240
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_down.biases": {
      "data_offsets": [
        1032152576,
        1032254976
      ],
      "dtype": "BF16",
      "shape": [
        320,
        160
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_down.scales": {
      "data_offsets": [
        58840320,
        58942720
      ],
      "dtype": "BF16",
      "shape": [
        320,
        160
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_down.weight": {
      "data_offsets": [
        59024640,
        60663040
      ],
      "dtype": "U32",
      "shape": [
        320,
        1280
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_up.biases": {
      "data_offsets": [
        30803200,
        30905600
      ],
      "dtype": "BF16",
      "shape": [
        10240,
        5
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_up.scales": {
      "data_offsets": [
        1031947776,
        1032050176
      ],
      "dtype": "BF16",
      "shape": [
        10240,
        5
      ]
    },
    "mtp.layers.0.mlp_hyper_connection.input_mix_weight_up.weight": {
      "data_offsets": [
        57201920,
        58840320
      ],
      "dtype": "U32",
      "shape": [
        10240,
        40
      ]
    },
    "mtp.layers.0.self_attn.indexer.index_qk_proj.weight": {
      "data_offsets": [
        27526400,
        30803200
      ],
      "dtype": "BF16",
      "shape": [
        640,
        2560
      ]
    },
    "mtp.layers.0.self_attn.indexer.k_layernorm.weight": {
      "data_offsets": [
        586046720,
        586046976
      ],
      "dtype": "BF16",
      "shape": [
        128
      ]
    },
    "mtp.layers.0.self_attn.indexer.q_layernorm.weight": {
      "data_offsets": [
        26543104,
        26543360
      ],
      "dtype": "BF16",
      "shape": [
        128
      ]
    },
    "mtp.layers.0.self_attn.k_norm.weight": {
      "data_offsets": [
        26542592,
        26543104
      ],
      "dtype": "BF16",
      "shape": [
        256
      ]
    },
    "mtp.layers.0.self_attn.k_proj.biases": {
      "data_offsets": [
        25764352,
        25805312
      ],
      "dtype": "BF16",
      "shape": [
        512,
        40
      ]
    },
    "mtp.layers.0.self_attn.k_proj.scales": {
      "data_offsets": [
        25805312,
        25846272
      ],
      "dtype": "BF16",
      "shape": [
        512,
        40
      ]
    },
    "mtp.layers.0.self_attn.k_proj.weight": {
      "data_offsets": [
        25846272,
        26501632
      ],
      "dtype": "U32",
      "shape": [
        512,
        320
      ]
    },
    "mtp.layers.0.self_attn.o_proj.biases": {
      "data_offsets": [
        1032254976,
        1032746496
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        96
      ]
    },
    "mtp.layers.0.self_attn.o_proj.scales": {
      "data_offsets": [
        17408512,
        17900032
      ],
      "dtype": "BF16",
      "shape": [
        2560,
        96
      ]
    },
    "mtp.layers.0.self_attn.o_proj.weight": {
      "data_offsets": [
        17900032,
        25764352
      ],
      "dtype": "U32",
      "shape": [
        2560,
        768
      ]
    },
    "mtp.layers.0.self_attn.q_norm.weight": {
      "data_offsets": [
        17408000,
        17408512
      ],
      "dtype": "BF16",
      "shape": [
        256
      ]
    },
    "mtp.layers.0.self_attn.q_proj.biases": {
      "data_offsets": [
        696320,
        1679360
      ],
      "dtype": "BF16",
      "shape": [
        12288,
        40
      ]
    },
    "mtp.layers.0.self_attn.q_proj.scales": {
      "data_offsets": [
        26543360,
        27526400
      ],
      "dtype": "BF16",
      "shape": [
        12288,
        40
      ]
    },
    "mtp.layers.0.self_attn.q_proj.weight": {
      "data_offsets": [
        1679360,
        17408000
      ],
      "dtype": "U32",
      "shape": [
        12288,
        320
      ]
    },
    "mtp.layers.0.self_attn.v_proj.biases": {
      "data_offsets": [
        26501632,
        26542592
      ],
      "dtype": "BF16",
      "shape": [
        512,
        40
      ]
    },
    "mtp.layers.0.self_attn.v_proj.scales": {
      "data_offsets": [
        0,
        40960
      ],
      "dtype": "BF16",
      "shape": [
        512,
        40
      ]
    },
    "mtp.layers.0.self_attn.v_proj.weight": {
      "data_offsets": [
        40960,
        696320
      ],
      "dtype": "U32",
      "shape": [
        512,
        320
      ]
    },
    "mtp.pre_fc_norm_embedding.weight": {
      "data_offsets": [
        1465872896,
        1465878016
      ],
      "dtype": "BF16",
      "shape": [
        2560
      ]
    },
    "mtp.pre_fc_norm_hidden.weight": {
      "data_offsets": [
        1034589696,
        1034610176
      ],
      "dtype": "BF16",
      "shape": [
        10240
      ]
    }
  },
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23719903232,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   370420.\nPages active:                                 895425.\nPages inactive:                               909132.\nPages speculative:                             35241.\nPages throttled:                                   0.\nPages wired down:                             197540.\nPages purgeable:                                5459.\n\"Translation faults\":                     1982684615.\nPages copy-on-write:                        99674007.\nPages zero filled:                        3253569418.\nPages reactivated:                         174254936.\nPages purged:                               12794976.\nFile-backed pages:                           1071869.\nAnonymous pages:                              767929.\nPages stored in compressor:                  1267695.\nPages occupied by compressor:                 676782.\nDecompressions:                            104745129.\nCompressions:                              118722359.\nPageins:                                  2370544511.\nPageouts:                                     489440.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 130462.\nPages tagged resident:                         87304.\nPages tagged compressed:                       43158.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5198.\nPages tag-storage free:                          792.\nPages tag-storage non-tag pageable:            92306.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6550784.\nTagged compressions:                          748804.\nTagged decompressions:                        616857.\n"
  },
  "producer_sha256": "7818f16d375ba502a0e31610933ae15c0f8b50ff1c2c96e36e748af4a5840972"
}
````

### vq-baseline-draft-inventory-v1.log

Original bytes: 919. SHA-256: `aeedffce2a91ccfafd93b5623469b2a53f961e012bc72f3a331dcb97131346e9`.

Normalized bytes: 919. SHA-256: `aeedffce2a91ccfafd93b5623469b2a53f961e012bc72f3a331dcb97131346e9`.

````text
{"schema": 1, "scope": "CPU inventory only; no composite draft binding or execution qualification", "config": {"file_bytes": 33408, "sha256": "0da22a8ed4323fbe969bf982aeb054743b315206791f28ef74a309c707080ba5"}, "file_bytes": 1470955171, "file_sha256": "c80b58faae46eeacb94dea49dd3453566ee05597fbd28c7c647eccb2862ab744", "header_bytes": 8347, "header_sha256": "836ae4156c99452e932c7a81322bcca959ac6f7ed86d6270cfd56ff94c62f4b9", "header_prefix_sha256": "9e8fdaa642163c998c43137e2825f7febc02b1ccec6b6e3a9cc1ff8ee01c4b8d", "payload_verified": true, "quantization": {"kind": "affine", "bits": 4, "group_size": 64}, "normalization": "already folded BF16 scales; ordinary RMS with full-width hidden statistics", "tensor_count": 68, "tensor_payload_bytes": 1470946816, "expert_payload_bytes": 1415577600, "largest_tensor_bytes": 419430400, "producer_sha256": "7818f16d375ba502a0e31610933ae15c0f8b50ff1c2c96e36e748af4a5840972"}
````

### vq_composite_draft_reference.py

Original bytes: 14693. SHA-256: `e4989cd926e54391525697eed265b38ca4a767039131cd55190d24c91b77e04e`.

Normalized bytes: 14693. SHA-256: `e4989cd926e54391525697eed265b38ca4a767039131cd55190d24c91b77e04e`.

````text
#!/usr/bin/env python3
"""Independent on-manifold input and draft-head fixture for the dense composite.

One authenticated main-model prefill matches the existing complete greedy
fixture before any draft computation. The main model is released before the
separately configured original four-bit head loads. No speculative generation,
acceptance-rate or quality/performance qualification follows from this probe.
"""
import argparse
import gc
import hashlib
import importlib.metadata
import importlib.util
import json
import os
from pathlib import Path
import sys
import threading
import time

from context_qualification import quiet_preflight, verification_lock
from quantization_inventory import unique_json
from vq_dense_overlay import Overlay, IDENTITY_SHA, BASE_CONFIG
from vq_dense_overlay_reference import instrument_identity, check_proof
from vq_execution_profile import select_runtime, recheck_runtime
from vq_fused_reference import bounded
from vq_model_reference import load_model, physical, references, recheck_owned_headroom, verify_files
from vq_ple_stream import Archive, TensorFile

PROFILE_SHA = '8e9ffd40c71d34bca08a55e7af55fda8ac7d45429f3ff7febef077d31bface7c'
MAIN_FIXTURE_SHA = '10003d625b179bdddfb6bd03d7544f1becf27f5beec2551cb71467af7639b68d'
DRAFT_BYTES = 1_470_955_171
DRAFT_SHA = 'c80b58faae46eeacb94dea49dd3453566ee05597fbd28c7c647eccb2862ab744'
HEADER_BYTES = 8347
HEADER_SHA = '836ae4156c99452e932c7a81322bcca959ac6f7ed86d6270cfd56ff94c62f4b9'
REFERENCE_SOURCES = {
    'qwen4_exp.py': '6fae4ec0decbf77ca4a4571de683bc5580ec75e84325ecb432dfcd2fc81df75e',
    'mtp_ref.py': 'f28827ac0409fe58b9c255f16add5ecb00b17a2310a3521d75a677f2d4a84f24',
}
LIMIT = 4_000_000_000


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def pinned_json(path, expected, limit):
    raw = bounded(path, limit)
    if hashlib.sha256(raw).hexdigest() != expected:
        raise ValueError('draft fixture input identity changed: ' + path.name)
    return unique_json(raw)


def owned_draft(directory):
    owner = TensorFile(directory / 'mtp.safetensors', file_bytes=DRAFT_BYTES,
                       header_bytes=HEADER_BYTES, header_sha256=HEADER_SHA)
    try:
        digest = hashlib.sha256()
        for position in range(0, DRAFT_BYTES, 1_000_000):
            owner.verify_unchanged()
            count = min(1_000_000, DRAFT_BYTES-position)
            raw = os.pread(owner.fd, count, position)
            if len(raw) != count: raise ValueError('short complete draft authentication')
            digest.update(raw)
        owner.verify_unchanged()
        if digest.hexdigest() != DRAFT_SHA: raise ValueError('draft payload identity changed')
        return owner
    except BaseException:
        owner.close(); raise


def load_draft(owner, module, args):
    import mlx.core as mx
    import mlx.nn as nn
    import numpy as np
    model = module.MTPModule(args)
    tensors = {k: v for k, v in owner.header.items() if k != '__metadata__'}
    if len(tensors) != 68: raise ValueError('draft tensor coverage changed')
    nn.quantize(model, group_size=64, bits=4,
                class_predicate=lambda p, m: 'mtp.' + p + '.scales' in tensors)
    values = []
    for name, tensor in tensors.items():
        recheck_owned_headroom()
        count = tensor['data_offsets'][1] - tensor['data_offsets'][0]
        if not 0 < count <= 419_430_400 or tensor['dtype'] not in ('BF16', 'U32'):
            raise ValueError('draft tensor exceeds the pinned materialization bound')
        raw = bytearray(count)
        for offset in range(0, count, 1_000_000):
            size = min(1_000_000, count-offset)
            raw[offset:offset+size] = owner.read(name, offset, size)
        dtype = np.uint16 if tensor['dtype'] == 'BF16' else np.uint32
        value = mx.array(np.frombuffer(raw, dtype=dtype))
        if tensor['dtype'] == 'BF16': value = value.view(mx.bfloat16)
        value = value.reshape(tensor['shape']); mx.eval(value)
        values.append((name.removeprefix('mtp.'), value)); del raw
        if max(physical().values()) > LIMIT: raise ValueError('draft load exceeded the four-GB process bound')
    model.load_weights(values); model.eval(); mx.eval(model.parameters())
    owner.verify_unchanged()
    return model


def run(options):
    root = Path(__file__).resolve().parent
    profile = pinned_json(options.profile, PROFILE_SHA, 32_000)
    main_fixture = pinned_json(options.main_fixture, MAIN_FIXTURE_SHA, 4_000_000)
    config = pinned_json(options.baseline / 'config.json', BASE_CONFIG, 64_000)
    source_raw = {name: bounded(root / 'reference' / name, 1_000_000) for name in REFERENCE_SOURCES}
    if any(hashlib.sha256(raw).hexdigest() != REFERENCE_SOURCES[name] for name, raw in source_raw.items()):
        raise ValueError('draft reference source differs from the reviewed baseline implementation')
    if (main_fixture['composite_sha256'] != IDENTITY_SHA or len(profile['prompt']) != 44
            or main_fixture['steps'][0]['input_ids'] != profile['prompt']):
        raise ValueError('independent main-model prefill fixture differs')
    execution_path, execution = select_runtime(options.model, None)
    instrument = instrument_identity()
    check_proof(unique_json(bounded(options.order_proof, 4_000_000)), instrument, execution)
    own_sha = sha(Path(__file__))
    inputs = [options.profile, options.main_fixture, options.order_proof, options.architecture, options.inventory,
              options.baseline / 'config.json'] + [root / 'reference' / p for p in REFERENCE_SOURCES]
    input_hashes = {str(p.resolve()): sha(p) for p in inputs}
    before = quiet_preflight(13)
    with verification_lock():
        options.out.mkdir(parents=True, exist_ok=False)
        record = {'schema': 1, 'passed': False, 'qualification': 'unproven', 'phase': 'authentication',
                  'scope': __doc__, 'before': before, 'composite_sha256': IDENTITY_SHA,
                  'draft_sha256': DRAFT_SHA, 'draft_quantization': {'bits': 4, 'group_size': 64},
                  'producer_sha256': own_sha, 'bound_inputs': input_hashes, 'instrument': instrument,
                  'execution_profile': execution, 'process_limit_bytes': LIMIT,
                  'maximum_fixture_bytes': 8_000_000, 'maximum_seconds': 7200}
        def save(): (options.out / 'receipt.json').write_text(json.dumps(record, indent=2) + '\n')
        save(); started = time.monotonic(); stop = threading.Event(); archive = draft_owner = None
        def monitor():
            while not stop.wait(.05):
                observed_memory = None
                try:
                    observed_memory = physical()
                    if max(observed_memory.values()) > LIMIT: raise RuntimeError('reference exceeded its four-GB process bound')
                    if time.monotonic()-started > 7200: raise RuntimeError('reference exceeded its time bound')
                except BaseException as error:
                    try:
                        (options.out / 'resource-refusal.json').write_text(json.dumps({'failure':str(error),'memory':observed_memory})+'\n')
                    finally:
                        os._exit(99)
        worker = threading.Thread(target=monitor, daemon=True); worker.start()
        try:
            record['parent'] = verify_files(options.model, options.inventory)
            overlay = Overlay(options.baseline, options.model, options.inventory)
            record['overlay'] = overlay.verify()
            draft_owner = owned_draft(options.baseline)
            import mlx.core as mx
            import numpy as np
            if mx.__version__ != '0.32.2' or importlib.metadata.version('mlx-lm') != '0.31.3':
                raise ValueError('draft probe requires the pinned current MLX versions')
            mx.set_memory_limit(3_500_000_000); mx.set_cache_limit(128_000_000)
            arch, vq = references(options.architecture, execution_path)
            archive = Archive(options.model, options.inventory)
            model = load_model(options.model, archive, arch, vq); overlay.apply(model)
            core = model.model; caches = model.make_cache()
            tokens = mx.array([profile['prompt']], dtype=mx.int64)
            history = mx.full((1,2),248044,mx.int64)
            embedded = core.embed_tokens(tokens); hidden = mx.tile(embedded,(1,1,core.hc))
            expected = {(x['layer'], x['name']): x for x in main_fixture['steps'][0]['boundaries']}
            observed = []
            tags = {mx.bfloat16:'BF16',mx.float32:'F32',mx.float16:'F16'}
            def observe(layer, arrays):
                for name, value in arrays.items():
                    mx.eval(value); entry=expected[(layer,name)]
                    if not bool(mx.all(mx.isfinite(value)).item()): raise ValueError('nonfinite main-model boundary')
                    raw=np.array(value.view(mx.uint8),copy=False).tobytes(order='C')
                    digest=hashlib.sha256(raw).hexdigest()
                    if (list(value.shape)!=entry['shape'] or tags[value.dtype]!=entry['dtype']
                            or len(raw)!=entry['bytes'] or digest!=entry['sha256']):
                        raise ValueError(f'independent main-model input changed at {layer}:{name}')
                    observed.append({'layer':layer,'name':name,'sha256':digest})
            record['phase']='main prefill';save();observe(-1,{'embedded':hidden})
            for layer in range(48):
                recheck_owned_headroom();block,cache=core.layers[layer],caches[layer];mx.eval(block.parameters())
                linear=block.layer_type=='linear_attention'
                mask=None if linear else arch.create_attention_mask(hidden,cache)
                conv=arch.create_ssm_mask(hidden,cache) if linear else None
                indexer=cache.indexer if hasattr(cache,'indexer') else None
                hidden=block(hidden,core.rope,mask,conv,cache,indexer,tokens,history)
                arrays={'hidden':hidden}
                if linear:
                    arrays.update(conv=cache[0],state=cache[1])
                    if layer==1:arrays['ple_conv']=cache[2]
                else:arrays.update(keys=cache.keys[:,:,:cache.offset],values=cache.values[:,:,:cache.offset],indexer=cache.indexer.keys)
                observe(layer,arrays);core.layers[layer]=None
                del block,cache,arrays,indexer,mask,conv;gc.collect();mx.clear_cache()
            mixed=core.hyper_connection_mixer(hidden);logits=model.lm_head(mixed).astype(mx.float32)
            observe(48,{'mixed':mixed,'logits':logits})
            token=int(mx.argmax(logits[0,-1]).item())
            if len(observed)!=160 or token!=main_fixture['generated'][0]:raise ValueError('main prefill omitted a boundary or changed its next token')
            embedded2=core.embed_tokens(mx.array([[token]],dtype=mx.int64));mx.eval(embedded,hidden,embedded2)
            fixtures={'embedded':embedded[:,1:,:],'hidden':hidden[:,:-1,:],
                      'embedded2':embedded2,'hidden2':hidden[:,-1:,:]}
            mx.eval(fixtures)
            del model,core,caches,tokens,history,embedded,hidden,embedded2,mixed,logits
            gc.collect();mx.clear_cache()
            record['main_boundaries']=observed;record['main_next_token']=token
            record['after_main_release']=physical();record['phase']='draft';save()
            for name in ('qwen4_exp.py','mtp_ref.py'):
                module_name=Path(name).stem
                spec=importlib.util.spec_from_file_location(module_name,root/'reference'/name)
                module=importlib.util.module_from_spec(spec);sys.modules[module_name]=module
                exec(compile(source_raw[name],str(root/'reference'/name),'exec'),module.__dict__)
            baseline_arch=sys.modules['qwen4_exp'];draft_module=sys.modules['mtp_ref']
            args=baseline_arch.ModelArgs.from_dict(config).text
            draft=load_draft(draft_owner,draft_module,args)
            rope=baseline_arch.RotaryEmbedding(int(args.head_dim*args.partial_rotary_factor),args.rope_theta)
            cache=baseline_arch._AttnCache()
            out1,multi1=draft(fixtures['embedded'],fixtures['hidden'],rope,cache);mx.eval(out1,multi1)
            if cache.offset!=43:raise ValueError('draft prefill cache misaligned')
            out2,multi2=draft(fixtures['embedded2'],fixtures['hidden2'],rope,cache);mx.eval(out2,multi2)
            if cache.offset!=44:raise ValueError('draft continuation cache misaligned')
            fixtures.update(out1=out1,multi1=multi1,out2=out2,multi2=multi2)
            if sum(v.nbytes for v in fixtures.values())>7_900_000:raise ValueError('draft fixture exceeds its byte bound')
            for value in fixtures.values():
                if value.dtype!=mx.bfloat16 or not bool(mx.all(mx.isfinite(value)).item()):raise ValueError('draft fixture dtype or finiteness changed')
            for owner in archive.files.values():owner.verify_unchanged()
            draft_owner.verify_unchanged();overlay.recheck();recheck_runtime(options.model,None,execution)
            if instrument_identity()['sha256']!=instrument['sha256'] or sha(Path(__file__))!=own_sha or any(sha(Path(p))!=h for p,h in input_hashes.items()):
                raise ValueError('draft producer input changed')
            target=options.out/'comparison.safetensors'
            mx.save_safetensors(str(target),fixtures,metadata={'scope':'composite main inputs and independent original four-bit MTP head'})
            if target.stat().st_size>8_000_000:raise ValueError('written fixture exceeds its bound')
            record.update(passed=True,phase='complete',fixture_sha256=sha(target),fixture_bytes=target.stat().st_size,
                          memory=physical(),seconds=time.monotonic()-started,
                          tensors={k:{'shape':list(v.shape),'dtype':'BF16','bytes':v.nbytes} for k,v in fixtures.items()},
                          cache_offsets=[43,44],native_comparison_relative_tolerance=0.02)
            save();print(json.dumps({k:record[k] for k in ['passed','fixture_sha256','fixture_bytes','memory','seconds']}),flush=True)
        except BaseException as error:
            record['failure']=repr(error);save();raise
        finally:
            stop.set();worker.join(timeout=1)
            if archive is not None:archive.close()
            if draft_owner is not None:draft_owner.close()


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    for key in ('model','baseline','inventory','architecture','profile','main-fixture','order-proof','out'):
        parser.add_argument('--'+key,type=Path,required=True)
    run(parser.parse_args())
````

### run-vq-composite-draft-v1.py

Original bytes: 3228. SHA-256: `390520d232a01f7251eec45303b4d26e29c87b8576965abc33aaa809c9f1fb3e`.

Normalized bytes: 3214. SHA-256: `dfdf73639187638269e40ef40f51ec48af254be7647a2b1cec7db80739d46dbe`.

````text
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,sys,time
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
from context_qualification import verification_lock
r=Path('.build/quantization-research').resolve();out=r/'vq-composite-draft-v1';out.mkdir()
paths=[Path(__file__),Path('Tools/vq_composite_draft_reference.py'),r/'vq-baseline-draft-hypothesis-v1.json',r/'vq-baseline-draft-inventory-prototype-v1.py',r/'vq-baseline-draft-inventory-v1.json',r/'vq-baseline-draft-inventory-v1.log']
record={'schema':1,'complete':False,'started_at':datetime.now(timezone.utc).isoformat(),
 'scope':'Independent composite-input baseline draft component reference and existing native-head comparison only; no speculation',
 'maximum_reference_runs':1,'maximum_native_legacy_runs':1,'paid_compute':False,
 'bound_inputs':{str(p.resolve()):digest(p) for p in paths},'runs':[]}
used=sum(p.stat().st_size for p in r.rglob('*') if p.is_file() and not p.is_symlink())
assert used+8000000<=350000000000
record['staging_bytes_before']=used
f=r/'vq-contiguous-build-v1/candidate';record['native_producer']=json.loads((f/'build-identity.json').read_text())
def save():(out/'run.json').write_text(json.dumps(record,indent=2)+'\n')
def unchanged():assert all(digest(Path(p))==h for p,h in record['bound_inputs'].items())
save()
try:
 command=[str(Path('.venv/bin/python').absolute()),str(Path('Tools/vq_composite_draft_reference.py').absolute()),
  '--model',str(r/'candidate-3.2'),'--baseline','<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit',
  '--inventory',str(r/'inventory-3.2/inventory.json'),'--architecture',str(r/'qwen4_exp-pr1788.py'),
  '--profile',str(Path('bench/quantization/greedy-v1.json').absolute()),
  '--main-fixture',str(r/'vq-dense-overlay-greedy-v1/reference/generation.json'),
  '--order-proof',str(r/'vq-dense-overlay-pilot-v1/traversal/receipt.json'),'--out',str(out/'reference')]
 unchanged();result=supervise(command,out/'reference-supervision',7200);record['runs'].append({'name':'reference',**result});save()
 receipt=json.loads((out/'reference/receipt.json').read_text());assert receipt['passed']
 fixture=out/'reference/comparison.safetensors';assert digest(fixture)==receipt['fixture_sha256']
 # The old standalone head command has no model-lock acquisition. Hold the
 # lock in this parent, with no other model, to keep this legacy probe safe.
 # Its success under that lock also provides a regression case for the fix.
 command=[str(f/'slotstream'),'mtp-parity','--model','<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit','--fixture',str(fixture)]
 unchanged()
 with verification_lock():result=supervise(command,out/'legacy-native-supervision',1800)
 record['runs'].append({'name':'legacy-native','parent_held_model_lock':True,**result});save()
 assert 'MTP PARITY PASS' in (out/'legacy-native-supervision/stdout.txt').read_text()
 assert digest(fixture)==receipt['fixture_sha256'];unchanged()
 record['complete']=True;record['finished_at']=datetime.now(timezone.utc).isoformat();save();print(json.dumps({'complete':True,'runs':record['runs']}),flush=True)
except BaseException as error:record['failure']=repr(error);save();raise
````

### vq-composite-draft-v1/run.json

Original bytes: 36084. SHA-256: `8e79549b930b0f9739b7b40882b85bea87d0c759f02936d2b974fb88dd556ac4`.

Normalized bytes: 36042. SHA-256: `0a6bca2712dc18e63c13f8eebd7f89e3fbaed35513e1c1d0343b9b8ae30aa77e`.

````text
{
  "schema": 1,
  "complete": false,
  "started_at": "2026-10-03T15:30:17.733409+00:00",
  "scope": "Independent composite-input baseline draft component reference and existing native-head comparison only; no speculation",
  "maximum_reference_runs": 1,
  "maximum_native_legacy_runs": 1,
  "paid_compute": false,
  "bound_inputs": {
    "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-composite-draft-v1.py": "390520d232a01f7251eec45303b4d26e29c87b8576965abc33aaa809c9f1fb3e",
    "<HOME>/Projects/slotstream/Tools/vq_composite_draft_reference.py": "e4989cd926e54391525697eed265b38ca4a767039131cd55190d24c91b77e04e",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-baseline-draft-hypothesis-v1.json": "3599100a1378251167b746acadb980d5a54f356d645a92a032dbce7c6c0eccc7",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-baseline-draft-inventory-prototype-v1.py": "7818f16d375ba502a0e31610933ae15c0f8b50ff1c2c96e36e748af4a5840972",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-baseline-draft-inventory-v1.json": "15160e242b4961ccf418bfed43a30e7624d734060cff6bf176b7a491b8a906ad",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-baseline-draft-inventory-v1.log": "aeedffce2a91ccfafd93b5623469b2a53f961e012bc72f3a331dcb97131346e9"
  },
  "runs": [
    {
      "name": "reference",
      "exit_code": 0,
      "failure": null,
      "sampled_peak_bytes": 2424162872,
      "samples": 1341,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 21224456192,
        "swapins": 44,
        "swapouts": 2908,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   154686.\nPages active:                                 987079.\nPages inactive:                               976588.\nPages speculative:                             22272.\nPages throttled:                                   0.\nPages wired down:                             185422.\nPages purgeable:                                5766.\n\"Translation faults\":                     1992911305.\nPages copy-on-write:                       100051534.\nPages zero filled:                        3272574605.\nPages reactivated:                         174773793.\nPages purged:                               12850108.\nFile-backed pages:                           1134986.\nAnonymous pages:                              850953.\nPages stored in compressor:                  1423855.\nPages occupied by compressor:                 758173.\nDecompressions:                            105245936.\nCompressions:                              119538632.\nPageins:                                  2383758067.\nPageouts:                                     490534.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 131593.\nPages tagged resident:                         86982.\nPages tagged compressed:                       44611.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5191.\nPages tag-storage free:                         1316.\nPages tag-storage non-tag pageable:            91789.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6986944.\nTagged compressions:                          761425.\nTagged decompressions:                        627869.\n"
      },
      "seconds": 72.96193029099959
    }
  ],
  "staging_bytes_before": 302971500806,
  "native_producer": {
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
  },
  "failure": "RuntimeError('another model process holds the lock')"
}
````

### vq-composite-draft-v1.log

Original bytes: 1383. SHA-256: `ccdd09c3ffbf8f47179b14d808bd8bf986a77f5181fcca7d5aa6a948519e2203`.

Normalized bytes: 1348. SHA-256: `1e1136a0653579116af43761fe0dfee970b7b813f9a1a26506e090e5a9e4cce7`.

````text
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/Tools/prefill_bench.py", line 52, in preflight
    try: fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
BlockingIOError: [Errno 35] Resource temporarily unavailable

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-composite-draft-v1.py", line 35, in <module>
    with verification_lock():result=supervise(command,out/'legacy-native-supervision',1800)
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/quantization_logit_run.py", line 56, in supervise
    before = quiet_preflight(13)
             ^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/context_qualification.py", line 58, in quiet_preflight
    return preflight(needed_gb)
           ^^^^^^^^^^^^^^^^^^^^
  File "<HOME>/Projects/slotstream/Tools/prefill_bench.py", line 53, in preflight
    except BlockingIOError as e: raise RuntimeError("another model process holds the lock") from e
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
RuntimeError: another model process holds the lock
````

### vq-composite-draft-v1/reference/receipt.json

Original bytes: 126053. SHA-256: `15b090f411f7415240db5d0120850df59ea6aaff24033546d4b8790dfc2b0f66`.

Normalized bytes: 125997. SHA-256: `be9991472a1646983b64648b19f4738d6296ab6d9866c8ddec1168ac7a1cf2de`.

````zlib-base64
eNq8vVlvZUmWpfeuX+HIJwmoiLB5KAgCNKIFodQNdEFPBRA2hrOCU3LIjOhG/Xd967jzkh7hJG+o
W12ozHSn8959jtke1jLbw3/+7z59+svD+Lyu21/+8ZP9B/31rj08rMlfH++f1vGTvz61q8t9Odrj
5e0N//CXp5u7+9u/rZu/fPnA5/aw9ONxe313tR7Xlx8/jNu748f/581cd4v/unn8dHvzw3W7udy3
V/PT5c3d0+OndjM/zfu2H3/4vNr8tC9/fXy6X5/27f2nx8/rE596WJ/0zbcPl4/rx3+5+Zebf3+z
PrUn/vXmUQ+15qfrdskX38519enufu3Lqyt+9Mh7PRxfsn69fHi8vPn50/MTfvr5fq3527/cPIvr
C4F8681vXx7m+M2nx+ONf/z0z3yHRHz6IuLy4dP9ulq89Xz+IFL+hQe9a/c8z9VvfJyv/plvnp9u
7y9/vrxpV7zS0/0P/fLx0/GiV7dtPvz46f++/fRwt8bTFaL+xnOtm3V/SP2Hf7lpY6y7x3Yz1g/6
Wr7p07EVj7/9dLfukXutf/v0zfYg5erq9u8Pn/b97TWPxbOyV10L92Vbvjww+/Kf+dux3T+vi/7b
43qQBiRfwj98+Yf7Na7a5XXrV6/+PeQUcokpPf/Ww9/b3eWN/i28/tHt06N+5qopz1/X/i5l+Kc2
Pn/6fy7vH3noT/+0rm/vf/v0H7XObNB4+MdP/72e59PD5X/idfeX5/l0SP8f/uXmP/BPerG1/vHT
Gf8XU03+x+ePtaEF/vCD1oaUfTl9jJ0754N8zOfoTh97tafvf9K6YuvpY4+f728fH6/WPOcFzelj
f7+Uos3bv998IKzG6PPpY3dP9z8v7e9H0pyrLsn0/vLP9+3m4eqrprWnq8eHf/nLP74hq5TkavYv
j4lD+O0HPMDf77HkN2XWWnPyPp4+9p/W/e0n2fQ7y+JdKiykC+n0sft17Jz8w9vvZ3Nwybtgv12U
D9df24Yp6GP/x+XV+qG38QtbIOV9ePezxfFR6cn/fHN789v17dPDGR/C7ooz7mXnHh5vteN4JPmp
+/XwcHv/vW+oyYTyspK3YzzdXcpr/fbuB6OrKerd/rf1/Gts+PvPaE2ogU8FPva/nvshGU7Jzvn4
bAOXH37iUEifTXYVd/T1Y/I3ZzmFT6HU6rQk//GL5zrvU18+Gr5+7Hxpnw4X+GLf7eefzzFu6xOa
+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
````

### run-vq-composite-draft-legacy-v2.py

Original bytes: 3844. SHA-256: `fa59370db8ff83c29d9ed0dd91911d93de64dc036cebd7fae6b665a5fca42d9b`.

Normalized bytes: 3837. SHA-256: `f22e29e294c342909c6258fdde4c21974af97b011657dc8a86b80394f8d61855`.

````text
from pathlib import Path
from datetime import datetime, timezone
import ctypes,ctypes.util,hashlib,json,os,subprocess,sys,time
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight,verification_lock
from prefill_bench import terminate_child_tree,vm_snapshot
from quantization_logit_run import digest
r=Path('.build/quantization-research').resolve();out=r/'vq-composite-draft-legacy-v2';out.mkdir()
prior=r/'vq-composite-draft-v1';ref=prior/'reference';fixture=ref/'comparison.safetensors'
receipt=json.loads((ref/'receipt.json').read_text());assert receipt['passed'] and digest(fixture)==receipt['fixture_sha256']
assert not (prior/'legacy-native-supervision').exists(), 'previous native attempt unexpectedly launched'
f=r/'vq-contiguous-build-v1/candidate';producer=json.loads((f/'build-identity.json').read_text())
assert digest(f/'slotstream')==producer['binary_sha256']
paths=[Path(__file__),prior/'run.json',ref/'receipt.json',fixture,r/'vq-baseline-draft-hypothesis-v1.json']
record={'schema':1,'complete':False,'started_at':datetime.now(timezone.utc).isoformat(),'parent_held_model_lock':True,
 'scope':'One original native component run under parent lock after explicit preflight; no second reference, no timing or speculative qualification',
 'reason':'v1 stopped before native launch because its supervisor repeated lock preflight inside the parent-held lock; original failed campaign is preserved',
 'maximum_model_runs':1,'bound_inputs':{str(p):digest(p) for p in paths},'native_producer':producer}
def save():(out/'run.json').write_text(json.dumps(record,indent=2)+'\n')
save();before=quiet_preflight(13)
command=[str(f/'slotstream'),'mtp-parity','--model','<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit','--fixture',str(fixture)]
env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG','VQ_','VQLAB_'))}
record.update(command=command,before=before,removed_override_names=sorted(set(os.environ)-set(env)));save()
lib=ctypes.CDLL(ctypes.util.find_library('proc'));peak=samples=0;child=None;started=time.monotonic();last_pressure=0
try:
 with verification_lock():
  with (out/'stdout.txt').open('w') as stdout,(out/'stderr.txt').open('w') as stderr:
   child=subprocess.Popen(command,env=env,stdout=stdout,stderr=stderr,start_new_session=True)
   while child.poll() is None:
    usage=ctypes.create_string_buffer(296)
    if lib.proc_pid_rusage(child.pid,4,usage)==0:
     footprint=max(int.from_bytes(usage.raw[72:80],'little'),int.from_bytes(usage.raw[240:248],'little'));peak=max(peak,footprint);samples+=1
     if footprint>10000000000:raise RuntimeError('10 GB process bound')
    elif child.poll() is None:raise RuntimeError('cannot observe child footprint')
    now=time.monotonic()
    if now-last_pressure>=1:
     if subprocess.check_output(['sysctl','-n','kern.memorystatus_vm_pressure_level'],text=True,timeout=5).strip()!='1':raise RuntimeError('OS memory pressure')
     if vm_snapshot()['reclaimable_bytes']<3000000000:raise RuntimeError('lost 3 GB real headroom')
     last_pressure=now
    if now-started>1800:raise RuntimeError('native component time bound')
    time.sleep(.05)
   assert child.returncode==0 and samples and 'MTP PARITY PASS' in (out/'stdout.txt').read_text()
  assert all(digest(Path(p))==h for p,h in record['bound_inputs'].items())
  record['complete']=True
except BaseException as error:
 record['failure']=repr(error);raise
finally:
 if child is not None and child.poll() is None:terminate_child_tree(child)
 record.update(exit_code=None if child is None else child.returncode,sampled_peak_bytes=peak,samples=samples,after=vm_snapshot(),seconds=time.monotonic()-started,finished_at=datetime.now(timezone.utc).isoformat());save()
print(json.dumps({k:record[k] for k in ('complete','exit_code','sampled_peak_bytes','seconds')}))
````

### vq-composite-draft-legacy-v2.log

Original bytes: 378. SHA-256: `d84768009cdafa1b9299be34364e526ae3c0f4a17448dc62a88d2b7d0d0c624a`.

Normalized bytes: 371. SHA-256: `02a1e13358b0ab53147e4115957b399d44fa6391b35c223a2e5302ad735a2fe0`.

````text
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-composite-draft-legacy-v2.py", line 42, in <module>
    assert child.returncode==0 and samples and 'MTP PARITY PASS' in (out/'stdout.txt').read_text()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError
````

### vq-composite-draft-legacy-v2/run.json

Original bytes: 38384. SHA-256: `f96f8b0643fc7dd1abdee1fbc8cca2318a2d9057bf3d0c57ba1dbe790935626c`.

Normalized bytes: 38328. SHA-256: `2be994d373d2c135bbacf970eb2e1e62d57553a3fcef595b190be79096913c30`.

````text
{
  "schema": 1,
  "complete": false,
  "started_at": "2026-10-03T15:38:31.131697+00:00",
  "parent_held_model_lock": true,
  "scope": "One original native component run under parent lock after explicit preflight; no second reference, no timing or speculative qualification",
  "reason": "v1 stopped before native launch because its supervisor repeated lock preflight inside the parent-held lock; original failed campaign is preserved",
  "maximum_model_runs": 1,
  "bound_inputs": {
    "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-composite-draft-legacy-v2.py": "fa59370db8ff83c29d9ed0dd91911d93de64dc036cebd7fae6b665a5fca42d9b",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/run.json": "8e79549b930b0f9739b7b40882b85bea87d0c759f02936d2b974fb88dd556ac4",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference/receipt.json": "15b090f411f7415240db5d0120850df59ea6aaff24033546d4b8790dfc2b0f66",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference/comparison.safetensors": "75061cdf20bf1221448ef07e5a07442bd0f26a101bfc788b78717a93feb8c032",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-baseline-draft-hypothesis-v1.json": "3599100a1378251167b746acadb980d5a54f356d645a92a032dbce7c6c0eccc7"
  },
  "native_producer": {
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
  },
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-contiguous-build-v1/candidate/slotstream",
    "mtp-parity",
    "--model",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--fixture",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference/comparison.safetensors"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 16240967680,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                     7829.\nPages active:                                1131304.\nPages inactive:                              1110911.\nPages speculative:                             21420.\nPages throttled:                                   0.\nPages wired down:                             202555.\nPages purgeable:                                9278.\n\"Translation faults\":                     1995756953.\nPages copy-on-write:                       100143349.\nPages zero filled:                        3274888737.\nPages reactivated:                         174777501.\nPages purged:                               12862256.\nFile-backed pages:                            974163.\nAnonymous pages:                             1289472.\nPages stored in compressor:                  1135387.\nPages occupied by compressor:                 611160.\nDecompressions:                            105505005.\nCompressions:                              119538632.\nPageins:                                  2383912456.\nPageouts:                                     491218.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 142838.\nPages tagged resident:                        106859.\nPages tagged compressed:                       35979.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5594.\nPages tag-storage free:                          253.\nPages tag-storage non-tag pageable:            92449.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5544384.\nTagged compressions:                          761425.\nTagged decompressions:                        636212.\n"
  },
  "removed_override_names": [],
  "failure": "AssertionError()",
  "exit_code": 2,
  "sampled_peak_bytes": 1608042320,
  "samples": 4,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 16129081344,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    96296.\nPages active:                                1084748.\nPages inactive:                              1071294.\nPages speculative:                             12310.\nPages throttled:                                   0.\nPages wired down:                             209461.\nPages purgeable:                                9292.\n\"Translation faults\":                     1995853502.\nPages copy-on-write:                       100143952.\nPages zero filled:                        3274988054.\nPages reactivated:                         174777501.\nPages purged:                               12862260.\nFile-backed pages:                            878853.\nAnonymous pages:                             1289499.\nPages stored in compressor:                  1135374.\nPages occupied by compressor:                 611156.\nDecompressions:                            105505018.\nCompressions:                              119538632.\nPageins:                                  2383914037.\nPageouts:                                     491250.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 142858.\nPages tagged resident:                        106879.\nPages tagged compressed:                       35979.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5595.\nPages tag-storage free:                          252.\nPages tag-storage non-tag pageable:            92449.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5544384.\nTagged compressions:                          761425.\nTagged decompressions:                        636212.\n"
  },
  "seconds": 0.24918429198442027,
  "finished_at": "2026-10-03T15:38:31.417168+00:00"
}
````

### vq-composite-draft-legacy-v2/stdout.txt

Original bytes: 212. SHA-256: `172655dc05b17f897f16ad4a4f176fbd7d61ede077c7f4bd73f0754de6f1fc88`.

Normalized bytes: 212. SHA-256: `172655dc05b17f897f16ad4a4f176fbd7d61ede077c7f4bd73f0754de6f1fc88`.

````text
prefill sample: max abs 3.00000  rel 0.02927  FAIL
prefill multi: max abs 0.75000  rel 0.02970  FAIL
decode sample: max abs 0.00000  rel 0.00000  OK
decode multi: max abs 0.00000  rel 0.00000  OK
MTP PARITY FAIL
````

### vq-composite-draft-legacy-v2/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-composite-draft-v1/reference-supervision/identity.json

Original bytes: 3180. SHA-256: `c11d702bd592ae54112e5a946512cc3b41ed3da0ab5bb6e1eb801c3a78e84900`.

Normalized bytes: 3110. SHA-256: `cc1349e373a0b2a3671ef0a74898ba750d6409d01fb999df9ed9827a23a41619`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "<HOME>/Projects/slotstream/Tools/vq_composite_draft_reference.py",
    "--model",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--baseline",
    "<HOME>/.slotstream/models/qwen38-flash-next-mlx-4bit",
    "--inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--architecture",
    "<HOME>/Projects/slotstream/.build/quantization-research/qwen4_exp-pr1788.py",
    "--profile",
    "<HOME>/Projects/slotstream/bench/quantization/greedy-v1.json",
    "--main-fixture",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-greedy-v1/reference/generation.json",
    "--order-proof",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-dense-overlay-pilot-v1/traversal/receipt.json",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-composite-draft-v1/reference"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 14723301376,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70309.\nPages active:                                1140752.\nPages inactive:                              1130036.\nPages speculative:                             11373.\nPages throttled:                                   0.\nPages wired down:                             203270.\nPages purgeable:                               20638.\n\"Translation faults\":                     1988623011.\nPages copy-on-write:                        99975510.\nPages zero filled:                        3268816092.\nPages reactivated:                         174263237.\nPages purged:                               12817321.\nFile-backed pages:                            807692.\nAnonymous pages:                             1474469.\nPages stored in compressor:                   960486.\nPages occupied by compressor:                 529651.\nDecompressions:                            104946513.\nCompressions:                              118722359.\nPageins:                                  2370716276.\nPageouts:                                     489925.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 136110.\nPages tagged resident:                        102307.\nPages tagged compressed:                       33803.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5197.\nPages tag-storage free:                          196.\nPages tag-storage non-tag pageable:            92903.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5143744.\nTagged compressions:                          748804.\nTagged decompressions:                        626061.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-composite-draft-v1/reference-supervision/receipt.json

Original bytes: 2140. SHA-256: `4b7f6d891eb4b4161912461a679d4426683e74a46d91ee3362d015649bcc1681`.

Normalized bytes: 2140. SHA-256: `4b7f6d891eb4b4161912461a679d4426683e74a46d91ee3362d015649bcc1681`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 2424162872,
  "samples": 1341,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 21224456192,
    "swapins": 44,
    "swapouts": 2908,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   154686.\nPages active:                                 987079.\nPages inactive:                               976588.\nPages speculative:                             22272.\nPages throttled:                                   0.\nPages wired down:                             185422.\nPages purgeable:                                5766.\n\"Translation faults\":                     1992911305.\nPages copy-on-write:                       100051534.\nPages zero filled:                        3272574605.\nPages reactivated:                         174773793.\nPages purged:                               12850108.\nFile-backed pages:                           1134986.\nAnonymous pages:                              850953.\nPages stored in compressor:                  1423855.\nPages occupied by compressor:                 758173.\nDecompressions:                            105245936.\nCompressions:                              119538632.\nPageins:                                  2383758067.\nPageouts:                                     490534.\nSwapins:                                          44.\nSwapouts:                                       2908.\nPages tagged:                                 131593.\nPages tagged resident:                         86982.\nPages tagged compressed:                       44611.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5191.\nPages tag-storage free:                         1316.\nPages tag-storage non-tag pageable:            91789.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    6986944.\nTagged compressions:                          761425.\nTagged decompressions:                        627869.\n"
  },
  "seconds": 72.96193029099959
}
````

### vq-composite-draft-v1/reference-supervision/stdout.txt

Original bytes: 6648. SHA-256: `d0f4bb6313e3059964db2daa76b0ac47a6791ed13ce466b0fd4b95f8a90523a6`.

Normalized bytes: 6648. SHA-256: `d0f4bb6313e3059964db2daa76b0ac47a6791ed13ce466b0fd4b95f8a90523a6`.

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
{"verified_overlay": "model-00001.safetensors"}
{"verified_overlay": "model-00004.safetensors"}
{"verified_overlay": "model-00005.safetensors"}
{"verified_overlay": "model-00006.safetensors"}
{"verified_overlay": "model-00007.safetensors"}
{"verified_overlay": "model-00008.safetensors"}
{"verified_overlay": "model-00009.safetensors"}
{"verified_overlay": "model-00010.safetensors"}
{"verified_overlay": "model-00011.safetensors"}
{"passed": true, "fixture_sha256": "75061cdf20bf1221448ef07e5a07442bd0f26a101bfc788b78717a93feb8c032", "fixture_bytes": 2253521, "memory": {"current_bytes": 2424113720, "lifetime_peak_bytes": 2424162872, "rss_peak_bytes": 2159214592}, "seconds": 72.61330641599488}
````

### vq-composite-draft-v1/reference-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

Normalized bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

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
