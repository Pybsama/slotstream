---
type: run
created: 2026-10-03T04:57:32.259610+00:00
updated: 2026-10-03T04:57:32.259610+00:00
summary: Pinned VQ prefill rotary arithmetic diagnosis and repair
binary: 5d1e28c9e5e8b9a486c494b7c1bad62de8604b94f5a46793fb2db707e474e54f
captured_at: 2026-10-02
command: Exact sequential producer and diagnostic commands are preserved in the driver and supervision identity transcripts below.
discarded: false
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Pinned VQ prefill rotary arithmetic diagnosis and repair
tool: bounded VQ research diagnostics
---

The first complete 512-token native prefill matches embedding and layers zero through two, including PLE and recurrent state, then differs at the first QSA layer. Identical repeated reference hashes confirm the captured input. An expanded attention microscope matches the unchanged pinned attention call. Native and Python intermediates match through hyper-connection, query/key projections and normalization, then diverge after rotary position encoding.

The retained native frequency vector differs at 23 of 32 FP32 entries and equals a JIT Metal fast::pow probe exactly. JIT precise::pow matches all pinned Python frequency bits. The first probe failed before GPU work because its test script called an unsupported array.repeat method; that instrument error and its corrected successor are retained. The corrected candidate uses precise power explicitly. Its dedicated native arithmetic checks match the complete 32-value frequency vector and all first-512-position FP32 sine/cosine rows, alongside the previous exhaustive BF16 sigmoid check. Public/deployed rotary construction retains its original arithmetic. Full-model corrected prefill results are captured separately; neither this component repair nor its tiny differences establish task quality or timing.

Local home prefixes are replaced with <HOME>. Original byte counts and SHA-256 values identify unmodified local transcripts. Tensor fixture payloads, frozen executables and source archives remain in the bounded research directory; manifests bind their hashes. These functional runs do not qualify timing, task quality or an alternative production pack. No model is installed or activated.

### run-vq-prefill-model-v1.py

Original bytes: 1385. SHA-256: `209e08b67830adcaf704abc90c7694ffe2ed0da01a66c5ea825761c25fe98577`.

````text
from pathlib import Path
import sys,json,shutil
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();s=Path('.build/arm64-apple-macosx/release');f=r/'frozen-prefill-model-v1';f.mkdir()
for n in ('slotstream','slotstream-checks','mlx.metallib','build-identity.json','build-source.tar.gz'):shutil.copy2(s/n,f/n)
identity=json.loads((f/'build-identity.json').read_text());assert digest(f/'slotstream')==identity['binary_sha256']
for pack in ('3.2','4.4'):
 command=[str(Path('.venv/bin/python').absolute()),'Tools/vq_model_prefill_reference.py','--model',str(r/f'candidate-{pack}'),'--inventory',str(r/f'inventory-{pack}/inventory.json'),'--architecture',str(r/'qwen4_exp-pr1788.py'),'--out',str(r/f'vq-prefill-model-reference-{pack}-v1')]
 print(json.dumps({'reference':pack,'result':supervise(command,r/f'vq-prefill-model-reference-{pack}-v1-supervision',1800)}),flush=True)
 command=[str(f/'slotstream'),'quantization-model-check','--prefill','--source-directory',str(r/f'candidate-{pack}'),'--source-inventory',str(r/f'inventory-{pack}/inventory.json'),'--fixture-directory',str(r/f'vq-prefill-model-reference-{pack}-v1'),'--output',str(r/f'vq-prefill-model-native-{pack}-v1')]
 print(json.dumps({'native':pack,'result':supervise(command,r/f'vq-prefill-model-native-{pack}-v1-supervision',1800)}),flush=True)
````

### vq-prefill-model-v1.log

Original bytes: 2669. SHA-256: `a422e78758bf8d6d8c93c87b4beb0ef19831a363cb4a263a3c62ef90bf1bfc20`.

````text
{"reference": "3.2", "result": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 3189083136, "samples": 690, "after": {"page_bytes": 16384, "reclaimable_bytes": 23427088384, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   185953.\nPages active:                                1037894.\nPages inactive:                              1020531.\nPages speculative:                             23183.\nPages throttled:                                   0.\nPages wired down:                             182029.\nPages purgeable:                                3402.\n\"Translation faults\":                     1116664385.\nPages copy-on-write:                        67721109.\nPages zero filled:                        1942576135.\nPages reactivated:                          93547584.\nPages purged:                               10838379.\nFile-backed pages:                           1240521.\nAnonymous pages:                              841087.\nPages stored in compressor:                  1163321.\nPages occupied by compressor:                 635003.\nDecompressions:                             23333915.\nCompressions:                               33029249.\nPageins:                                   609325985.\nPageouts:                                     334765.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128856.\nPages tagged resident:                         89944.\nPages tagged compressed:                       38912.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          799.\nPages tag-storage non-tag pageable:            92198.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5735232.\nTagged compressions:                          439847.\nTagged decompressions:                        362982.\n"}, "seconds": 40.368778583}}
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-prefill-model-v1.py", line 12, in <module>
    print(json.dumps({'native':pack,'result':supervise(command,r/f'vq-prefill-model-native-{pack}-v1-supervision',1800)}),flush=True)
  File "<HOME>/Projects/slotstream/Tools/quantization_logit_run.py", line 96, in supervise
    raise RuntimeError('pilot producer failed; preserved output must be inspected')
RuntimeError: pilot producer failed; preserved output must be inspected
````

### run-vq-prefill-microscope-v2.py

Original bytes: 2204. SHA-256: `ca544cd9dbddceb1813498b514f662b628cd78df0f89dd2dead94333787226c2`.

````text
from pathlib import Path
import sys,json,shutil
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();s=Path('.build/arm64-apple-macosx/release');f=r/'frozen-prefill-model-v2';f.mkdir()
for n in ('slotstream','slotstream-checks','mlx.metallib','build-identity.json','build-source.tar.gz'):shutil.copy2(s/n,f/n)
identity=json.loads((f/'build-identity.json').read_text());assert digest(f/'slotstream')==identity['binary_sha256']
common=['--model',str(r/'candidate-3.2'),'--inventory',str(r/'inventory-3.2/inventory.json'),'--architecture',str(r/'qwen4_exp-pr1788.py')]
python=str(Path('.venv/bin/python').absolute());fixture=r/'vq-prefill-model-reference-3.2-capture-v1'
command=[python,'Tools/vq_model_prefill_reference.py',*common,'--save-layer','2','--out',str(fixture)]
print(json.dumps({'reference_capture':supervise(command,r/'vq-prefill-model-reference-3.2-capture-v1-supervision',1800)}),flush=True)
original=json.loads((r/'vq-prefill-model-reference-3.2-v1/model.json').read_text());repeat=json.loads((fixture/'model.json').read_text())
assert original['boundaries']==repeat['boundaries'],'repeat reference changed'
print('Repeated reference has identical complete boundaries',flush=True)
command=[python,'Tools/vq_prefill_attention_reference.py',*common,'--fixture',str(fixture),'--out',str(r/'vq-prefill-attention-3.2-v1')]
print(json.dumps({'attention_capture':supervise(command,r/'vq-prefill-attention-3.2-v1-supervision',1800)}),flush=True)
command=[str(f/'slotstream'),'quantization-model-check','--prefill','--source-directory',str(r/'candidate-3.2'),'--source-inventory',str(r/'inventory-3.2/inventory.json'),'--fixture-directory',str(fixture),'--output',str(r/'vq-prefill-model-native-3.2-v2')]
try:supervise(command,r/'vq-prefill-model-native-3.2-v2-supervision',1800)
except RuntimeError:
 receipt=json.loads((r/'vq-prefill-model-native-3.2-v2/receipt.json').read_text())
 assert receipt.get('failure')=='VQ prefill model mismatch at 0:3:hidden',receipt.get('failure')
 print('Expected failure captured at layer 3',flush=True)
else:raise RuntimeError('microscope unexpectedly passed; inspect before continuing')
````

### vq-prefill-microscope-v2.log

Original bytes: 4327. SHA-256: `aa85f10286dea6ab415ae2c15f4b9832e3566cdd0bd4bfa25f37d3c840ae9d47`.

````text
{"reference_capture": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 3189033888, "samples": 683, "after": {"page_bytes": 16384, "reclaimable_bytes": 23427661824, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   185821.\nPages active:                                1045156.\nPages inactive:                              1027088.\nPages speculative:                             23771.\nPages throttled:                                   0.\nPages wired down:                             171284.\nPages purgeable:                                6712.\n\"Translation faults\":                     1121783700.\nPages copy-on-write:                        67899321.\nPages zero filled:                        1947979263.\nPages reactivated:                          93601608.\nPages purged:                               10845035.\nFile-backed pages:                           1237378.\nAnonymous pages:                              858637.\nPages stored in compressor:                  1160202.\nPages occupied by compressor:                 631859.\nDecompressions:                             23382013.\nCompressions:                               33136416.\nPageins:                                   619191865.\nPageouts:                                     335598.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128450.\nPages tagged resident:                         88911.\nPages tagged compressed:                       39539.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          635.\nPages tag-storage non-tag pageable:            92362.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5839424.\nTagged compressions:                          440855.\nTagged decompressions:                        363356.\n"}, "seconds": 40.026167167}}
Repeated reference has identical complete boundaries
{"attention_capture": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 768263440, "samples": 505, "after": {"page_bytes": 16384, "reclaimable_bytes": 23199121408, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    54400.\nPages active:                                1039009.\nPages inactive:                              1176786.\nPages speculative:                              4730.\nPages throttled:                                   0.\nPages wired down:                             181986.\nPages purgeable:                                1092.\n\"Translation faults\":                     1121973797.\nPages copy-on-write:                        67912972.\nPages zero filled:                        1948126996.\nPages reactivated:                          93601708.\nPages purged:                               10846501.\nFile-backed pages:                           1360470.\nAnonymous pages:                              860055.\nPages stored in compressor:                  1152689.\nPages occupied by compressor:                 628201.\nDecompressions:                             23385778.\nCompressions:                               33136416.\nPageins:                                   623904331.\nPageouts:                                     335725.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128605.\nPages tagged resident:                         89128.\nPages tagged compressed:                       39477.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          521.\nPages tag-storage non-tag pageable:            92476.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5832448.\nTagged compressions:                          440855.\nTagged decompressions:                        363416.\n"}, "seconds": 29.606384624999997}}
Expected failure captured at layer 3
````

### run-vq-rope-v3.py

Original bytes: 1366. SHA-256: `55494e8d536b0a97719be4108ff4ed0ad72bafded2f96df71955bb812c094c9b`.

````text
from pathlib import Path
import sys,json,shutil
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();s=Path('.build/arm64-apple-macosx/release');f=r/'frozen-prefill-model-v3';f.mkdir()
for n in ('slotstream','slotstream-checks','mlx.metallib','build-identity.json','build-source.tar.gz'):shutil.copy2(s/n,f/n)
assert digest(f/'slotstream')==json.loads((f/'build-identity.json').read_text())['binary_sha256']
command=[str(Path('.venv/bin/python').absolute()),str(r/'probe-vq-rope-v1.py')]
print(json.dumps({'rope':supervise(command,r/'vq-rope-probe-v1-supervision',600)}),flush=True)
command=[str(f/'slotstream'),'quantization-model-check','--prefill','--source-directory',str(r/'candidate-3.2'),'--source-inventory',str(r/'inventory-3.2/inventory.json'),'--fixture-directory',str(r/'vq-prefill-model-reference-3.2-v1'),'--output',str(r/'vq-prefill-model-native-3.2-v3')]
try:supervise(command,r/'vq-prefill-model-native-3.2-v3-supervision',1800)
except RuntimeError:
 receipt=json.loads((r/'vq-prefill-model-native-3.2-v3/receipt.json').read_text())
 assert receipt.get('failure')=='VQ prefill model mismatch at 0:3:hidden',receipt.get('failure')
 print('Expected failure captured with angles',flush=True)
else:raise RuntimeError('microscope unexpectedly passed; inspect before continuing')
````

### vq-rope-v3.log

Original bytes: 499. SHA-256: `1a7f84d7165f1943ccc94de5b5fed722031556541eb1e3a7cc120a962912cae4`.

````text
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/run-vq-rope-v3.py", line 9, in <module>
    print(json.dumps({'rope':supervise(command,r/'vq-rope-probe-v1-supervision',600)}),flush=True)
  File "<HOME>/Projects/slotstream/Tools/quantization_logit_run.py", line 96, in supervise
    raise RuntimeError('pilot producer failed; preserved output must be inspected')
RuntimeError: pilot producer failed; preserved output must be inspected
````

### run-vq-rope-v3-resume.py

Original bytes: 1249. SHA-256: `2abf15c9235c0b3c2aefc63bd7930224f9c7123cf7fcea27fcc04fc50cf21696`.

````text
from pathlib import Path
import sys,json,shutil
sys.path.insert(0,'Tools')
from quantization_logit_run import supervise,digest
r=Path('.build/quantization-research').resolve();s=Path('.build/arm64-apple-macosx/release');f=r/'frozen-prefill-model-v3';assert f.is_dir()
assert digest(f/'slotstream')==json.loads((f/'build-identity.json').read_text())['binary_sha256']
command=[str(Path('.venv/bin/python').absolute()),str(r/'probe-vq-rope-v2.py')]
print(json.dumps({'rope':supervise(command,r/'vq-rope-probe-v2-supervision',600)}),flush=True)
command=[str(f/'slotstream'),'quantization-model-check','--prefill','--source-directory',str(r/'candidate-3.2'),'--source-inventory',str(r/'inventory-3.2/inventory.json'),'--fixture-directory',str(r/'vq-prefill-model-reference-3.2-v1'),'--output',str(r/'vq-prefill-model-native-3.2-v3')]
try:supervise(command,r/'vq-prefill-model-native-3.2-v3-supervision',1800)
except RuntimeError:
 receipt=json.loads((r/'vq-prefill-model-native-3.2-v3/receipt.json').read_text())
 assert receipt.get('failure')=='VQ prefill model mismatch at 0:3:hidden',receipt.get('failure')
 print('Expected failure captured with angles',flush=True)
else:raise RuntimeError('microscope unexpectedly passed; inspect before continuing')
````

### vq-rope-v3-resume.log

Original bytes: 2145. SHA-256: `a00944c9f050726011be350e33a66b4c180530d956975526a4d8279bb889ad13`.

````text
{"rope": {"exit_code": 0, "failure": null, "sampled_peak_bytes": 154174208, "samples": 16, "after": {"page_bytes": 16384, "reclaimable_bytes": 22951657472, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70769.\nPages active:                                1070472.\nPages inactive:                              1093238.\nPages speculative:                             45331.\nPages throttled:                                   0.\nPages wired down:                             180623.\nPages purgeable:                                2082.\n\"Translation faults\":                     1123234955.\nPages copy-on-write:                        68001302.\nPages zero filled:                        1949018237.\nPages reactivated:                          93602455.\nPages purged:                               10847911.\nFile-backed pages:                           1328007.\nAnonymous pages:                              881034.\nPages stored in compressor:                  1144262.\nPages occupied by compressor:                 624941.\nDecompressions:                             23391424.\nCompressions:                               33136416.\nPageins:                                   625948806.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128177.\nPages tagged resident:                         89416.\nPages tagged compressed:                       38761.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          158.\nPages tag-storage non-tag pageable:            92840.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708544.\nTagged compressions:                          440855.\nTagged decompressions:                        363657.\n"}, "seconds": 0.9593791250000001}}
Expected failure captured with angles
````

### probe-vq-rope-v1.py

Original bytes: 2307. SHA-256: `feaad52b382d5bb05fff49a84a11edc41f5bf072129d0b828aa1b4a3c998e6e0`.

````text
from pathlib import Path
import sys,json,hashlib
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight,verification_lock
from vq_model_reference import references,instrument_identity,physical,ARCH_SHA256
r=Path('.build/quantization-research').resolve();out=r/'vq-rope-probe-v1';out.mkdir()
before=quiet_preflight(13)
with verification_lock():
 import mlx.core as mx
 import numpy as np
 mx.set_memory_limit(1_000_000_000);mx.set_cache_limit(64_000_000)
 instrument=instrument_identity(); arch,_=references(r/'qwen4_exp-pr1788.py',r/'candidate-3.2/model.py')
 rope=arch.RotaryEmbedding(64,10_000_000.0);pos=mx.arange(512)[None];cos,sin=rope(pos)
 arrays={'ropeInvFreq':rope.inv_freq,'ropeCos':cos,'ropeSin':sin};rows=[]
 def bits(x):return np.array(x.view(mx.uint32),copy=False)
 for fn,ref,inputs in [('pow',rope.inv_freq,[mx.arange(0,64,2,dtype=mx.float32)/64]),('cos',cos,[(pos.astype(mx.float32)[...,None]*rope.inv_freq).repeat(2,axis=0)]),('sin',sin,[(pos.astype(mx.float32)[...,None]*rope.inv_freq).repeat(2,axis=0)])]:
  if fn!='pow':
   freq=pos.astype(mx.float32)[...,None]*rope.inv_freq;inputs=[mx.concatenate([freq,freq],axis=-1)]
  for mode in ('fast','precise'):
   expression=f'metal::{mode}::{fn}(input[i])' if fn!='pow' else f'metal::{mode}::pow(10000000.0f, -input[i])'
   kernel=mx.fast.metal_kernel(name=f'probe_rope_{fn}_{mode}',input_names=['input'],output_names=['output'],source=f'uint i=thread_position_in_grid.x; output[i]={expression};')
   value=kernel(inputs=inputs,grid=(ref.size,1,1),threadgroup=(min(256,ref.size),1,1),output_shapes=[ref.shape],output_dtypes=[mx.float32])[0]
   mx.eval(value,ref);a=bits(value);b=bits(ref)
   rows.append({'function':fn,'mode':mode,'different':int(np.count_nonzero(a!=b)),'total':a.size,'different_after_bf16':int(np.count_nonzero(np.array(value.astype(mx.bfloat16).view(mx.uint16))!=np.array(ref.astype(mx.bfloat16).view(mx.uint16))))})
   arrays[fn+'_'+mode]=value
 mx.save_safetensors(str(out/'angles.safetensors'),arrays)
 data={'architecture':ARCH_SHA256,'instrument':instrument,'before':before,'memory':physical(),'results':rows,'fixture_sha256':hashlib.sha256((out/'angles.safetensors').read_bytes()).hexdigest()}
 (out/'angles.json').write_text(json.dumps(data,indent=2)+'\n');print(json.dumps(data),flush=True)
````

### probe-vq-rope-v2.py

Original bytes: 2183. SHA-256: `960590dc3127119d02bf91caa99718d88fc7557c13289c580e7d23ed39eaf6d3`.

````text
from pathlib import Path
import sys,json,hashlib
sys.path.insert(0,'Tools')
from context_qualification import quiet_preflight,verification_lock
from vq_model_reference import references,instrument_identity,physical,ARCH_SHA256
r=Path('.build/quantization-research').resolve();out=r/'vq-rope-probe-v2';out.mkdir()
before=quiet_preflight(13)
with verification_lock():
 import mlx.core as mx
 import numpy as np
 mx.set_memory_limit(1_000_000_000);mx.set_cache_limit(64_000_000)
 instrument=instrument_identity(); arch,_=references(r/'qwen4_exp-pr1788.py',r/'candidate-3.2/model.py')
 rope=arch.RotaryEmbedding(64,10_000_000.0);pos=mx.arange(512)[None];cos,sin=rope(pos)
 arrays={'ropeInvFreq':rope.inv_freq,'ropeCos':cos,'ropeSin':sin};rows=[]
 def bits(x):return np.array(x.view(mx.uint32),copy=False)
 for fn,ref,inputs in [('pow',rope.inv_freq,[mx.arange(0,64,2,dtype=mx.float32)/64]),('cos',cos,[pos]),('sin',sin,[pos])]:
  if fn!='pow':
   freq=pos.astype(mx.float32)[...,None]*rope.inv_freq;inputs=[mx.concatenate([freq,freq],axis=-1)]
  for mode in ('fast','precise'):
   expression=f'metal::{mode}::{fn}(input[i])' if fn!='pow' else f'metal::{mode}::pow(10000000.0f, -input[i])'
   kernel=mx.fast.metal_kernel(name=f'probe_rope_{fn}_{mode}',input_names=['input'],output_names=['output'],source=f'uint i=thread_position_in_grid.x; output[i]={expression};')
   value=kernel(inputs=inputs,grid=(ref.size,1,1),threadgroup=(min(256,ref.size),1,1),output_shapes=[ref.shape],output_dtypes=[mx.float32])[0]
   mx.eval(value,ref);a=bits(value);b=bits(ref)
   rows.append({'function':fn,'mode':mode,'different':int(np.count_nonzero(a!=b)),'total':a.size,'different_after_bf16':int(np.count_nonzero(np.array(value.astype(mx.bfloat16).view(mx.uint16))!=np.array(ref.astype(mx.bfloat16).view(mx.uint16))))})
   arrays[fn+'_'+mode]=value
 mx.save_safetensors(str(out/'angles.safetensors'),arrays)
 data={'architecture':ARCH_SHA256,'instrument':instrument,'before':before,'memory':physical(),'results':rows,'fixture_sha256':hashlib.sha256((out/'angles.safetensors').read_bytes()).hexdigest()}
 (out/'angles.json').write_text(json.dumps(data,indent=2)+'\n');print(json.dumps(data),flush=True)
````

### vq-prefill-attention-native-v2-comparison.json

Original bytes: 3576. SHA-256: `19332b5ce98c6f7448616d783bdc9aa7c8da0b5c6dc6d9459177c91f9af500dc`.

````text
[
  {
    "name": "hcInput",
    "shape": [
      1,
      512,
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 5242880,
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
      512,
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 5242880,
    "max_abs_error": 0.0
  },
  {
    "name": "hcDown",
    "shape": [
      1,
      512,
      320
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 163840,
    "max_abs_error": 0.0
  },
  {
    "name": "hcActivated",
    "shape": [
      1,
      512,
      320
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 163840,
    "max_abs_error": 0.0
  },
  {
    "name": "hcUp",
    "shape": [
      1,
      512,
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 5242880,
    "max_abs_error": 0.0
  },
  {
    "name": "hcGates",
    "shape": [
      1,
      512,
      10240
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 5242880,
    "max_abs_error": 0.0
  },
  {
    "name": "attnInput",
    "shape": [
      1,
      512,
      2560
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 1310720,
    "max_abs_error": 0.0
  },
  {
    "name": "attnInject",
    "shape": [
      1,
      512,
      4
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 2048,
    "max_abs_error": 0.0
  },
  {
    "name": "qgRaw",
    "shape": [
      1,
      512,
      24,
      512
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 6291456,
    "max_abs_error": 0.0
  },
  {
    "name": "qNormed",
    "shape": [
      1,
      24,
      512,
      256
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 3145728,
    "max_abs_error": 0.0
  },
  {
    "name": "kNormed",
    "shape": [
      1,
      2,
      512,
      256
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 262144,
    "max_abs_error": 0.0
  },
  {
    "name": "v",
    "shape": [
      1,
      2,
      512,
      256
    ],
    "geometry_equal": true,
    "differing": 0,
    "elements": 262144,
    "max_abs_error": 0.0
  },
  {
    "name": "qRoped",
    "shape": [
      1,
      24,
      512,
      256
    ],
    "geometry_equal": true,
    "differing": 34,
    "elements": 3145728,
    "max_abs_error": 0.015625
  },
  {
    "name": "kRoped",
    "shape": [
      1,
      2,
      512,
      256
    ],
    "geometry_equal": true,
    "differing": 5,
    "elements": 262144,
    "max_abs_error": 0.015625
  },
  {
    "name": "sdpaOut",
    "shape": [
      1,
      24,
      512,
      256
    ],
    "geometry_equal": true,
    "differing": 2634,
    "elements": 3145728,
    "max_abs_error": 0.0087890625
  },
  {
    "name": "attnOutput",
    "shape": [
      1,
      512,
      2560
    ],
    "geometry_equal": true,
    "differing": 12484,
    "elements": 1310720,
    "max_abs_error": 0.002197265625
  },
  {
    "name": "afterAttn",
    "shape": [
      1,
      512,
      10240
    ],
    "geometry_equal": true,
    "differing": 6436,
    "elements": 5242880,
    "max_abs_error": 0.00048828125
  },
  {
    "name": "mlpInput",
    "shape": [
      1,
      512,
      2560
    ],
    "geometry_equal": true,
    "differing": 7158,
    "elements": 1310720,
    "max_abs_error": 0.03125
  }
]
````

### vq-prefill-rope-comparison-v3.json

Original bytes: 2798. SHA-256: `b03fe04cd251338fa44cd90f9cb93fddb4bdabafcdd5cadb44f83cc2a368182a`.

````text
[
  {
    "name": "ropeInvFreq",
    "equal_bits": false,
    "native_sha256": "984b2734bf48204e04c5fd15e48da68b3b09f115fe1ec453fe374c76fda53b57",
    "reference_sha256": "2fb3c351f0a3fc12c0b204e77660cca2c1bc373dae37f5d0a2bfe2b92cef1248",
    "different": 23,
    "max_abs_error": 7.450580596923828e-09,
    "native_matches_jit_fast": true,
    "native_values": [
      1.0,
      0.6042963862419128,
      0.36517414450645447,
      0.22067341208457947,
      0.1333521604537964,
      0.08058422803878784,
      0.04869675263762474,
      0.02942727319896221,
      0.017782796174287796,
      0.010746080428361893,
      0.006493817549198866,
      0.003924190998077393,
      0.00237137358635664,
      0.001433013123460114,
      0.0008659643935970962,
      0.0005232993862591684,
      0.0003162278444506228,
      0.0001910952851176262,
      0.00011547822941793129,
      6.978306191740558e-05,
      4.216966772219166e-05,
      2.548297015891876e-05,
      1.5399273252114654e-05,
      9.305728781328071e-06,
      5.6234130170196295e-06,
      3.398209400984342e-06,
      2.0535264866339276e-06,
      1.240937535840203e-06,
      7.498943546124792e-07,
      4.5315860575101397e-07,
      2.738422324455314e-07,
      1.6548170833630138e-07
    ],
    "reference_values": [
      1.0,
      0.6042963862419128,
      0.36517414450645447,
      0.22067341208457947,
      0.1333521604537964,
      0.08058422058820724,
      0.04869675263762474,
      0.029427271336317062,
      0.017782794311642647,
      0.010746078565716743,
      0.006493816617876291,
      0.003924190066754818,
      0.00237137358635664,
      0.0014330126577988267,
      0.0008659643353894353,
      0.0005232991534285247,
      0.0003162277862429619,
      0.00019109529966954142,
      0.00011547820031410083,
      6.978306191740558e-05,
      4.2169649532297626e-05,
      2.5482968339929357e-05,
      1.539926597615704e-05,
      9.305721505370457e-06,
      5.62341347176698e-06,
      3.398208264115965e-06,
      2.053525122391875e-06,
      1.2409378769007162e-06,
      7.498942409256415e-07,
      4.531583783773385e-07,
      2.7384197665014653e-07,
      1.6548170833630138e-07
    ]
  },
  {
    "name": "ropeCos",
    "equal_bits": false,
    "native_sha256": "1fcd50703c35b3adc839a3e38983ff1acc8746f6ec4093f70121581bd6116996",
    "reference_sha256": "20be5bf2cc1ff4c4208827d99c0f95adb511816556777bc1e965fe782703fd60",
    "different": 6958,
    "max_abs_error": 3.814697265625e-06
  },
  {
    "name": "ropeSin",
    "equal_bits": false,
    "native_sha256": "55a150caa6319f214dc2ebd74414135e05b5b0329e4abca30365b4175e9ca426",
    "reference_sha256": "3887752075ec29f866d82da8322cba01421caec5a6c257aa1eaa6f708280aba7",
    "different": 21416,
    "max_abs_error": 3.814697265625e-06
  }
]
````

### vq-prefill-attention-3.2-v1/attention.json

Original bytes: 96990. SHA-256: `11dba306dcab636ce1745f3106f577b46f8b072426d11e3f33acb7e1c5648335`.

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
      "vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
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
    "sha256": "579aa5d127d0e019f205170f54b96772c4e45e845d251160de6ea64857a05af2"
  },
  "producer_sha256": "561f184ed16d27686a93cd2ba6248b6bcec3261952564bf00b67c68de1aa35e8",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23416078336,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   186584.\nPages active:                                1044983.\nPages inactive:                              1027805.\nPages speculative:                             22823.\nPages throttled:                                   0.\nPages wired down:                             171305.\nPages purgeable:                                4920.\n\"Translation faults\":                     1121792439.\nPages copy-on-write:                        67900612.\nPages zero filled:                        1947982817.\nPages reactivated:                          93601612.\nPages purged:                               10845035.\nFile-backed pages:                           1237700.\nAnonymous pages:                              857911.\nPages stored in compressor:                  1159768.\nPages occupied by compressor:                 631799.\nDecompressions:                             23382206.\nCompressions:                               33136416.\nPageins:                                   619191912.\nPageouts:                                     335598.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128450.\nPages tagged resident:                         88911.\nPages tagged compressed:                       39539.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          328.\nPages tag-storage non-tag pageable:            92669.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5839424.\nTagged compressions:                          440855.\nTagged decompressions:                        363356.\n"
  },
  "source_fixture": {
    "layer": 2,
    "step": 0,
    "name": "hidden",
    "shape": [
      1,
      512,
      10240
    ],
    "dtype": "BF16",
    "bytes": 10485760,
    "sha256": "c733a7c7ec2d73b02ea90cc45e39425852622002d0ef87a9285e7e969f2e816c"
  },
  "source_file_sha256": "2ee1ee4169e7dfcf0d9039348ee14f99415e777b192551399b234e06beda4516",
  "expanded_equals_whole": true,
  "memory": {
    "current_bytes": 674186440,
    "lifetime_peak_bytes": 682181832,
    "rss_peak_bytes": 545390592
  },
  "fixture": {
    "path": "attention.safetensors",
    "bytes": 94004810,
    "sha256": "c2c8b8b5a72a30960ab406333c7c1c50ab384a76c2eec6dec43e30ec7a80f4da"
  },
  "qualification": "unproven"
}
````

### vq-rope-probe-v2/angles.json

Original bytes: 74848. SHA-256: `201149fd0332af4a105b187ec99ca028b9c57efecd39eb51fa749d13ca6d3a69`.

````text
{
  "architecture": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
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
    "sha256": "579aa5d127d0e019f205170f54b96772c4e45e845d251160de6ea64857a05af2"
  },
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22931226624,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70198.\nPages active:                                1070618.\nPages inactive:                              1091008.\nPages speculative:                             47162.\nPages throttled:                                   0.\nPages wired down:                             181718.\nPages purgeable:                                2066.\n\"Translation faults\":                     1123221906.\nPages copy-on-write:                        68000782.\nPages zero filled:                        1949006928.\nPages reactivated:                          93602455.\nPages purged:                               10847911.\nFile-backed pages:                           1327347.\nAnonymous pages:                              881441.\nPages stored in compressor:                  1144266.\nPages occupied by compressor:                 624944.\nDecompressions:                             23391420.\nCompressions:                               33136416.\nPageins:                                   625948277.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128131.\nPages tagged resident:                         89370.\nPages tagged compressed:                       38761.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          151.\nPages tag-storage non-tag pageable:            92847.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708544.\nTagged compressions:                          440855.\nTagged decompressions:                        363657.\n"
  },
  "memory": {
    "current_bytes": 154157824,
    "lifetime_peak_bytes": 154157824,
    "rss_peak_bytes": 119603200
  },
  "results": [
    {
      "function": "pow",
      "mode": "fast",
      "different": 23,
      "total": 32,
      "different_after_bf16": 0
    },
    {
      "function": "pow",
      "mode": "precise",
      "different": 0,
      "total": 32,
      "different_after_bf16": 0
    },
    {
      "function": "cos",
      "mode": "fast",
      "different": 0,
      "total": 32768,
      "different_after_bf16": 0
    },
    {
      "function": "cos",
      "mode": "precise",
      "different": 0,
      "total": 32768,
      "different_after_bf16": 0
    },
    {
      "function": "sin",
      "mode": "fast",
      "different": 0,
      "total": 32768,
      "different_after_bf16": 0
    },
    {
      "function": "sin",
      "mode": "precise",
      "different": 0,
      "total": 32768,
      "different_after_bf16": 0
    }
  ],
  "fixture_sha256": "5c0e3a97132ec1dc1637f392470b0f47d4ba0d51003b96e4e2dfeeab4cc35ed5"
}
````

### vq-rope-reference-v1/rope.json

Original bytes: 74839. SHA-256: `d704fcc72bf9600e16532df7a9faa13c3669f09f5c149b6e05860b008ce090b0`.

````text
{
  "schema": 1,
  "producer_sha256": "749964ffbb5f4304b8216e31411d175dfe0aee02d628c9a87f57693a5a49f363",
  "instrument": {
    "scripts": {
      "vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec",
      "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e",
      "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749",
      "vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
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
    "sha256": "579aa5d127d0e019f205170f54b96772c4e45e845d251160de6ea64857a05af2"
  },
  "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22907289600,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    24830.\nPages active:                                1067770.\nPages inactive:                              1142816.\nPages speculative:                             45808.\nPages throttled:                                   0.\nPages wired down:                             180495.\nPages purgeable:                                1678.\n\"Translation faults\":                     1124543629.\nPages copy-on-write:                        68091045.\nPages zero filled:                        1949979355.\nPages reactivated:                          93609777.\nPages purged:                               10854173.\nFile-backed pages:                           1371642.\nAnonymous pages:                              884752.\nPages stored in compressor:                  1141260.\nPages occupied by compressor:                 623595.\nDecompressions:                             23392708.\nCompressions:                               33136452.\nPageins:                                   627889891.\nPageouts:                                     336303.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128264.\nPages tagged resident:                         89602.\nPages tagged compressed:                       38662.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          291.\nPages tag-storage non-tag pageable:            92707.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5694848.\nTagged compressions:                          440855.\nTagged decompressions:                        363755.\n"
  },
  "memory": {
    "current_bytes": 154485504,
    "lifetime_peak_bytes": 154485504,
    "rss_peak_bytes": 120176640
  },
  "dim": 64,
  "base": 10000000,
  "start": 0,
  "rows": 512,
  "reference_sha256": {
    "inverse": "2fb3c351f0a3fc12c0b204e77660cca2c1bc373dae37f5d0a2bfe2b92cef1248",
    "cosine": "20be5bf2cc1ff4c4208827d99c0f95adb511816556777bc1e965fe782703fd60",
    "sine": "3887752075ec29f866d82da8322cba01421caec5a6c257aa1eaa6f708280aba7"
  },
  "fixture_sha256": "d5bc1f5e12ad771e28c0a39ba45d183e3321f178e1a51cb9763cbe1203cca2a9",
  "observations": [
    {
      "mode": "fast",
      "source": "uint i=thread_position_in_grid.x; output[i]=metal::fast::pow(base[0], -exponents[i]);",
      "different": 23
    },
    {
      "mode": "precise",
      "source": "uint i=thread_position_in_grid.x; output[i]=metal::precise::pow(base[0], -exponents[i]);",
      "different": 0
    }
  ],
  "qualification": "unproven"
}
````

### vq-prefill-model-build-v1.log

Original bytes: 11767. SHA-256: `55eb28c28e2897925d7066779e80a4cdf7fa7e109e23403603d26d65325b6bcf`.

````text
python3 Tools/build_identity.py before "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
swift build -c release -j 2
[0/1] Planning build
[1/1] Compiling plugin GenerateManual
[2/2] Compiling plugin GenerateDoccReference
Building for production...
[2/10] Write sources
[5/10] Write swift-version--1AB21518FC5DEDBE.txt
[7/11] Compiling Slotstream AdaptiveSpeculation.swift
<HOME>/Projects/slotstream/Sources/Slotstream/EmbeddingRows.swift:107:36: warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
105 |             data.withUnsafeMutableBytes { output in
106 |                 for (i, id) in ids.enumerated() {
107 |                     available[id]!.withUnsafeBytes { row in
    |                                    `- warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
108 |                         memcpy(output.baseAddress! + i * stride, row.baseAddress! + offsets[p], stride)
109 |                     }

<HOME>/Projects/slotstream/Sources/Slotstream/RouterTrace.swift:36:13: warning: variable 'header' was never mutated; consider changing to 'let' constant
34 |         lock.lock()
35 |         defer { lock.unlock() }
36 |         var header = [Int32(layer), Int32(tokens), Int32(topK)]
   |             `- warning: variable 'header' was never mutated; consider changing to 'let' constant
37 |         header.withUnsafeBytes { buffer.append(contentsOf: $0) }
38 |         var small = [Int16](repeating: 0, count: ids.count)
[8/12] Compiling SlotstreamDiagnostics CheckReport.swift
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
[9/14] Compiling slotstream_cli CheckRendering.swift
[9/14] Write Objects.LinkFileList
[10/14] Linking slotstream
[12/14] Compiling SlotstreamTestKit AnthropicChecks.swift
[12/14] Write Objects.LinkFileList
[13/14] Linking slotstream-checks
Build complete! (155.37s)
cp Tools/lib/mlx-0.32.2.metallib .build/release/mlx.metallib
python3 Tools/build_identity.py after "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
````

### vq-prefill-model-build-preflight-v1.json

Original bytes: 1986. SHA-256: `5af7b51a5ec83ed18ef363dfffc2c1017f8472aa82617c3d4a4b5a468251c24e`.

````text
{
  "page_bytes": 16384,
  "reclaimable_bytes": 21748514816,
  "swapins": 0,
  "swapouts": 16,
  "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    15838.\nPages active:                                1135890.\nPages inactive:                              1134645.\nPages speculative:                              3721.\nPages throttled:                                   0.\nPages wired down:                             183525.\nPages purgeable:                                8673.\n\"Translation faults\":                     1111742278.\nPages copy-on-write:                        67599849.\nPages zero filled:                        1937261963.\nPages reactivated:                          93454372.\nPages purged:                               10825123.\nFile-backed pages:                           1302913.\nAnonymous pages:                              971343.\nPages stored in compressor:                  1116975.\nPages occupied by compressor:                 611823.\nDecompressions:                             23272177.\nCompressions:                               32862459.\nPageins:                                   601378976.\nPageouts:                                     334031.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 134695.\nPages tagged resident:                         96520.\nPages tagged compressed:                       38175.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5302.\nPages tag-storage free:                          164.\nPages tag-storage non-tag pageable:            92830.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5640512.\nTagged compressions:                          438360.\nTagged decompressions:                        362630.\n"
}
````

### frozen-prefill-model-v1/build-identity.json

Original bytes: 29735. SHA-256: `ae42f8214734d444e26062bac78b913f4489417bd84fc9efdc61299a81548c58`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "53525f6def06413a8812f93cc1bcb9a21c4a39e4708719f911a9c5ad784954c6",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "4643b13b0506bd5230d0f8ea11f749ba708cec13b688b1355769acbb1b897ca9",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "02d7d623171320542927eb8d4992a4ed1fae9e47baaeba96c0a6dec86f5d515c",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "fa0068d90454df6dec0e5d8a73d887a96d4350207e0cc21dc74e58a08054c1ee",
    "Sources/Slotstream/VQRouteStream.swift": "935c13d19a8febd8e82cb3e42a8c13fd80a875928f64f9cfc4d741847a96b04e",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "d6c2b48e9d778da623c29e7b514d614628c40d5feceec29ab7f5e30a23a33403",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "8376a3a59bf56e3c71b550beedf5b5d6cc54141b5353ca5ace1449079c3f01c6",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "ec60779189c84f8085a0c5c2c96b3c977cf82539ba7f52826e2657c68b44f8fc",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "6b3c28a81f1132b2f8aa0a6f43aedecda3a1022b8a11634a8b8b0b7f7fb2d7d1",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "a964b86713ff5fb760f9ff1f41b2c59cc983db116adfc41c72801c317da23766",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "e25d9405271d6be0d57b22d0970c3677a962038d786a418f418a3047b5cbf9c7",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "6fd7b59274e2bcd66c030ec65803e71e39185336339f8f43204be03e687fcc9d",
  "binary_sha256": "08eb26deac7b3b7dd21979dcf4f15fb6cb440cc7c8e0a5adb506f282a9ebf448",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````

### vq-prefill-model-native-3.2-v1/receipt.json

Original bytes: 5111. SHA-256: `894a888d4ab2643d1ea47dc92f5fa4ac397ca2fe2a83cbf0df97f81d7446b08c`.

````text
{
  "before" : {
    "reclaimableBytes" : 23756603392,
    "swapins" : 0,
    "swapouts" : 16
  },
  "failure" : "VQ prefill model mismatch at 0:3:hidden",
  "fixture_sha256" : "49a0d4a40216dc45115fe39f499ffb8387bc07d0a05ae040d31529549cb120c6",
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "maximum_live_experts" : 32,
  "maximum_record_batches" : 11,
  "observed" : {
    "0:-1:embedded" : "09cbbdc6f63087c8b6e6822be2aa2854843b4908dc7d7129e04bd695044a87fd",
    "0:0:conv" : "8981b62090a11928fc6c440bb95f1fc9e96e3906da4f39149d4bae8d17d9cd8c",
    "0:0:hidden" : "ac10d21cfd551f897d8ad6a7a3451db69973c8410bd1b2685ece15dd0be20703",
    "0:0:state" : "709844dfd50713b068159ae2d10b89dfce1c0d711ee3f2e21993b6b7a268ade4",
    "0:1:conv" : "7fa3ee43f232c2f7f9a54ec6215cd318a3809479a1bb9e08bcdd785f73a9d95a",
    "0:1:hidden" : "1722c95afa638b31991cebf324adf3ffa3dfd164c3d1d0ca5791fecbc48c6fcd",
    "0:1:ple_conv" : "79f7a448d6ba75fa851da9e23e13b742e29ce51be0d36adeff3cd0eb85f0de7e",
    "0:1:state" : "496c0529dc3db23a249f8ae3c7733406355c9a52aef94d776ac541f3e9499004",
    "0:2:conv" : "2904fcbc91993f2e127ab2023bc9dc6b11fbfaab423fdf9c90f55a8a7e4c2db0",
    "0:2:hidden" : "c733a7c7ec2d73b02ea90cc45e39425852622002d0ef87a9285e7e969f2e816c",
    "0:2:state" : "916e2a9b03641152868cc775649085da83f2fe922df295e4b6bb440a9b32ab48",
    "0:3:hidden" : "5a3044ceb89ce7cb89eafb78084268c739295e6217456d9928897f094880bab5"
  },
  "peak_mlx_bytes" : 404258390,
  "peak_process_bytes" : 645579856,
  "profile" : "prefill512-decode1-v1",
  "qualification" : "unproven",
  "report" : {
    "items" : [
      {
        "name" : "0:-1:embedded geometry",
        "passed" : true
      },
      {
        "name" : "0:-1:embedded finite",
        "passed" : true
      },
      {
        "name" : "0:-1:embedded complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:0:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:0:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:0:conv finite",
        "passed" : true
      },
      {
        "name" : "0:0:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:state geometry",
        "passed" : true
      },
      {
        "name" : "0:0:state finite",
        "passed" : true
      },
      {
        "name" : "0:0:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:1:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:1:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:1:conv finite",
        "passed" : true
      },
      {
        "name" : "0:1:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:state geometry",
        "passed" : true
      },
      {
        "name" : "0:1:state finite",
        "passed" : true
      },
      {
        "name" : "0:1:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv geometry",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv finite",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:2:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:2:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:2:conv finite",
        "passed" : true
      },
      {
        "name" : "0:2:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:state geometry",
        "passed" : true
      },
      {
        "name" : "0:2:state finite",
        "passed" : true
      },
      {
        "name" : "0:2:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:3:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:3:hidden finite",
        "passed" : true
      },
      {
        "detail" : "got 5a3044ceb89ce7cb89eafb78084268c739295e6217456d9928897f094880bab5, want e8212ec42fdfa4ebc80b975a65ffc0a857a9bb3264b6eccb37e350c9e8d819c7",
        "name" : "0:3:hidden complete byte hash",
        "passed" : false
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-prefill-model",
    "passed" : false
  },
  "schema" : 1,
  "scope" : "complete prefill arithmetic and one continuation; no generation qualification",
  "segmented_prefill_layers" : 4,
  "verified_files" : 130,
  "verified_payload_bytes" : 30562735024
}
````

### vq-prefill-model-native-3.2-v1-supervision/identity.json

Original bytes: 2771. SHA-256: `50a5da33c06719de2d5d585588f00d74f8912ea85910231001dc34ef6309c0aa`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-prefill-model-v1/slotstream",
    "quantization-model-check",
    "--prefill",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--fixture-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-reference-3.2-v1",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-native-3.2-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23427186688,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   185957.\nPages active:                                1037994.\nPages inactive:                              1020531.\nPages speculative:                             23185.\nPages throttled:                                   0.\nPages wired down:                             182029.\nPages purgeable:                                3402.\n\"Translation faults\":                     1116667053.\nPages copy-on-write:                        67721553.\nPages zero filled:                        1942577241.\nPages reactivated:                          93547584.\nPages purged:                               10838379.\nFile-backed pages:                           1240523.\nAnonymous pages:                              841187.\nPages stored in compressor:                  1163223.\nPages occupied by compressor:                 634977.\nDecompressions:                             23334019.\nCompressions:                               33029249.\nPageins:                                   609325988.\nPageouts:                                     334765.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128856.\nPages tagged resident:                         89944.\nPages tagged compressed:                       38912.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          750.\nPages tag-storage non-tag pageable:            92247.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5735232.\nTagged compressions:                          439847.\nTagged decompressions:                        362982.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-prefill-model-native-3.2-v1-supervision/receipt.json

Original bytes: 2130. SHA-256: `61087991825341991e91cf686f1ad202a005dafaba4789c1a8d9f2a72766790d`.

````text
{
  "exit_code": 1,
  "failure": null,
  "sampled_peak_bytes": 645579856,
  "samples": 265,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23305388032,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    44458.\nPages active:                                1040712.\nPages inactive:                              1114202.\nPages speculative:                             73925.\nPages throttled:                                   0.\nPages wired down:                             181617.\nPages purgeable:                                  31.\n\"Translation faults\":                     1116933855.\nPages copy-on-write:                        67737033.\nPages zero filled:                        1942864536.\nPages reactivated:                          93547875.\nPages purged:                               10839604.\nFile-backed pages:                           1377959.\nAnonymous pages:                              850880.\nPages stored in compressor:                  1156877.\nPages occupied by compressor:                 630285.\nDecompressions:                             23339867.\nCompressions:                               33029249.\nPageins:                                   611327334.\nPageouts:                                     334944.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128297.\nPages tagged resident:                         89445.\nPages tagged compressed:                       38852.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          430.\nPages tag-storage non-tag pageable:            92567.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5722560.\nTagged compressions:                          439847.\nTagged decompressions:                        363042.\n"
  },
  "seconds": 15.606754959
}
````

### vq-prefill-model-native-3.2-v1-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-prefill-model-native-3.2-v1-supervision/stderr.txt

Original bytes: 116. SHA-256: `b1b42d89669e5f451a025af1d0a295ea54375fe76109b0eb256075920926417c`.

````text
VQ prefill P0 L0 exact
VQ prefill P0 L1 exact
VQ prefill P0 L2 exact
Error: VQ prefill model mismatch at 0:3:hidden
````

### vq-prefill-model-build-v2.log

Original bytes: 10431. SHA-256: `8a8e4883e4c90b71d15cbe0070a2036e972887b906551cc0a7ff8a92e5c0b537`.

````text
python3 Tools/build_identity.py before "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
swift build -c release -j 2
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
Build complete! (83.04s)
cp Tools/lib/mlx-0.32.2.metallib .build/release/mlx.metallib
python3 Tools/build_identity.py after "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
````

### vq-prefill-model-build-preflight-v2.json

Original bytes: 1986. SHA-256: `2ac9c4e5b2b23548fe975bc9b3d9a9f8f02deaea85e18231fa040b8e1424878a`.

````text
{
  "page_bytes": 16384,
  "reclaimable_bytes": 23231840256,
  "swapins": 0,
  "swapouts": 16,
  "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    37438.\nPages active:                                1045378.\nPages inactive:                              1117269.\nPages speculative:                             75010.\nPages throttled:                                   0.\nPages wired down:                             181480.\nPages purgeable:                                1040.\n\"Translation faults\":                     1117057355.\nPages copy-on-write:                        67756863.\nPages zero filled:                        1942916192.\nPages reactivated:                          93547891.\nPages purged:                               10839860.\nFile-backed pages:                           1379481.\nAnonymous pages:                              858176.\nPages stored in compressor:                  1152192.\nPages occupied by compressor:                 628556.\nDecompressions:                             23341618.\nCompressions:                               33029249.\nPageins:                                   611328184.\nPageouts:                                     334944.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128350.\nPages tagged resident:                         89511.\nPages tagged compressed:                       38839.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          185.\nPages tag-storage non-tag pageable:            92812.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5720512.\nTagged compressions:                          439847.\nTagged decompressions:                        363054.\n"
}
````

### frozen-prefill-model-v2/build-identity.json

Original bytes: 29735. SHA-256: `37c1eade9f1be30b28c20ebc3e92ef9bcf93ada82bdbe1e28fbc54764cd3c5b3`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "53525f6def06413a8812f93cc1bcb9a21c4a39e4708719f911a9c5ad784954c6",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "4643b13b0506bd5230d0f8ea11f749ba708cec13b688b1355769acbb1b897ca9",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "02d7d623171320542927eb8d4992a4ed1fae9e47baaeba96c0a6dec86f5d515c",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "fa0068d90454df6dec0e5d8a73d887a96d4350207e0cc21dc74e58a08054c1ee",
    "Sources/Slotstream/VQRouteStream.swift": "935c13d19a8febd8e82cb3e42a8c13fd80a875928f64f9cfc4d741847a96b04e",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "d6c2b48e9d778da623c29e7b514d614628c40d5feceec29ab7f5e30a23a33403",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "8376a3a59bf56e3c71b550beedf5b5d6cc54141b5353ca5ace1449079c3f01c6",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "49394377cc6e73ea5e995627504d13d3769e4cb2d8530eae245731e3aed44c41",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "6b3c28a81f1132b2f8aa0a6f43aedecda3a1022b8a11634a8b8b0b7f7fb2d7d1",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "a964b86713ff5fb760f9ff1f41b2c59cc983db116adfc41c72801c317da23766",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "e25d9405271d6be0d57b22d0970c3677a962038d786a418f418a3047b5cbf9c7",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "231b862ec8a9ebadd82ca9af46cd5b687ecb09cf575edaa2cb090b4a07aeeed5",
  "binary_sha256": "3120322cd0cf72b793a88cceea5ea372abb236e252782c1a9e8feb43073c5a78",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````

### vq-prefill-model-native-3.2-v2/receipt.json

Original bytes: 5111. SHA-256: `49176751e8f7c999f54eacd79a43fa33217c7233e225962684e55c53340a8838`.

````text
{
  "before" : {
    "reclaimableBytes" : 23243161600,
    "swapins" : 0,
    "swapouts" : 16
  },
  "failure" : "VQ prefill model mismatch at 0:3:hidden",
  "fixture_sha256" : "1c397b0c9f32e5477d3f60629aa4f8f4713b9fea81ef940ea6bcc19982c354a5",
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "maximum_live_experts" : 32,
  "maximum_record_batches" : 11,
  "observed" : {
    "0:-1:embedded" : "09cbbdc6f63087c8b6e6822be2aa2854843b4908dc7d7129e04bd695044a87fd",
    "0:0:conv" : "8981b62090a11928fc6c440bb95f1fc9e96e3906da4f39149d4bae8d17d9cd8c",
    "0:0:hidden" : "ac10d21cfd551f897d8ad6a7a3451db69973c8410bd1b2685ece15dd0be20703",
    "0:0:state" : "709844dfd50713b068159ae2d10b89dfce1c0d711ee3f2e21993b6b7a268ade4",
    "0:1:conv" : "7fa3ee43f232c2f7f9a54ec6215cd318a3809479a1bb9e08bcdd785f73a9d95a",
    "0:1:hidden" : "1722c95afa638b31991cebf324adf3ffa3dfd164c3d1d0ca5791fecbc48c6fcd",
    "0:1:ple_conv" : "79f7a448d6ba75fa851da9e23e13b742e29ce51be0d36adeff3cd0eb85f0de7e",
    "0:1:state" : "496c0529dc3db23a249f8ae3c7733406355c9a52aef94d776ac541f3e9499004",
    "0:2:conv" : "2904fcbc91993f2e127ab2023bc9dc6b11fbfaab423fdf9c90f55a8a7e4c2db0",
    "0:2:hidden" : "c733a7c7ec2d73b02ea90cc45e39425852622002d0ef87a9285e7e969f2e816c",
    "0:2:state" : "916e2a9b03641152868cc775649085da83f2fe922df295e4b6bb440a9b32ab48",
    "0:3:hidden" : "5a3044ceb89ce7cb89eafb78084268c739295e6217456d9928897f094880bab5"
  },
  "peak_mlx_bytes" : 404274780,
  "peak_process_bytes" : 644826336,
  "profile" : "prefill512-decode1-v1",
  "qualification" : "unproven",
  "report" : {
    "items" : [
      {
        "name" : "0:-1:embedded geometry",
        "passed" : true
      },
      {
        "name" : "0:-1:embedded finite",
        "passed" : true
      },
      {
        "name" : "0:-1:embedded complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:0:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:0:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:0:conv finite",
        "passed" : true
      },
      {
        "name" : "0:0:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:state geometry",
        "passed" : true
      },
      {
        "name" : "0:0:state finite",
        "passed" : true
      },
      {
        "name" : "0:0:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:1:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:1:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:1:conv finite",
        "passed" : true
      },
      {
        "name" : "0:1:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:state geometry",
        "passed" : true
      },
      {
        "name" : "0:1:state finite",
        "passed" : true
      },
      {
        "name" : "0:1:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv geometry",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv finite",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:2:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:2:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:2:conv finite",
        "passed" : true
      },
      {
        "name" : "0:2:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:state geometry",
        "passed" : true
      },
      {
        "name" : "0:2:state finite",
        "passed" : true
      },
      {
        "name" : "0:2:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:3:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:3:hidden finite",
        "passed" : true
      },
      {
        "detail" : "got 5a3044ceb89ce7cb89eafb78084268c739295e6217456d9928897f094880bab5, want e8212ec42fdfa4ebc80b975a65ffc0a857a9bb3264b6eccb37e350c9e8d819c7",
        "name" : "0:3:hidden complete byte hash",
        "passed" : false
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-prefill-model",
    "passed" : false
  },
  "schema" : 1,
  "scope" : "complete prefill arithmetic and one continuation; no generation qualification",
  "segmented_prefill_layers" : 4,
  "verified_files" : 130,
  "verified_payload_bytes" : 30562735024
}
````

### vq-prefill-model-native-3.2-v2-supervision/identity.json

Original bytes: 2779. SHA-256: `7effa6d3378f846c10edccfe4d9d4682168bf865dc00a42e8ef4c5790b58cf49`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-prefill-model-v2/slotstream",
    "quantization-model-check",
    "--prefill",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--fixture-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-reference-3.2-capture-v1",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-native-3.2-v2"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23199219712,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    54404.\nPages active:                                1040176.\nPages inactive:                              1176787.\nPages speculative:                              4732.\nPages throttled:                                   0.\nPages wired down:                             180856.\nPages purgeable:                                1092.\n\"Translation faults\":                     1121976444.\nPages copy-on-write:                        67913409.\nPages zero filled:                        1948128124.\nPages reactivated:                          93601708.\nPages purged:                               10846501.\nFile-backed pages:                           1360472.\nAnonymous pages:                              861223.\nPages stored in compressor:                  1152654.\nPages occupied by compressor:                 628172.\nDecompressions:                             23385822.\nCompressions:                               33136416.\nPageins:                                   623904334.\nPageouts:                                     335725.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128605.\nPages tagged resident:                         89128.\nPages tagged compressed:                       39477.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          489.\nPages tag-storage non-tag pageable:            92508.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5832448.\nTagged compressions:                          440855.\nTagged decompressions:                        363416.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-prefill-model-native-3.2-v2-supervision/receipt.json

Original bytes: 2136. SHA-256: `525887d5b9495511619c520778a22f08b2813d03eb8b1e49ed1adefb5e9e2962`.

````text
{
  "exit_code": 1,
  "failure": null,
  "sampled_peak_bytes": 644826336,
  "samples": 234,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23137337344,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    37480.\nPages active:                                1045749.\nPages inactive:                              1112414.\nPages speculative:                             81222.\nPages throttled:                                   0.\nPages wired down:                             180728.\nPages purgeable:                                 333.\n\"Translation faults\":                     1122207059.\nPages copy-on-write:                        67922113.\nPages zero filled:                        1948409854.\nPages reactivated:                          93601832.\nPages purged:                               10846925.\nFile-backed pages:                           1374378.\nAnonymous pages:                              865007.\nPages stored in compressor:                  1150754.\nPages occupied by compressor:                 627533.\nDecompressions:                             23386725.\nCompressions:                               33136416.\nPageins:                                   625880830.\nPageouts:                                     335753.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128053.\nPages tagged resident:                         89241.\nPages tagged compressed:                       38812.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          437.\nPages tag-storage non-tag pageable:            92560.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5717568.\nTagged compressions:                          440855.\nTagged decompressions:                        363612.\n"
  },
  "seconds": 13.787190582999997
}
````

### vq-prefill-model-native-3.2-v2-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-prefill-model-native-3.2-v2-supervision/stderr.txt

Original bytes: 116. SHA-256: `b1b42d89669e5f451a025af1d0a295ea54375fe76109b0eb256075920926417c`.

````text
VQ prefill P0 L0 exact
VQ prefill P0 L1 exact
VQ prefill P0 L2 exact
Error: VQ prefill model mismatch at 0:3:hidden
````

### vq-prefill-model-build-v3.log

Original bytes: 1758. SHA-256: `a6c9bb61070c85f3b47e6d6c4a506c144eef0d1f20915ee6eb0fc8be02313859`.

````text
python3 Tools/build_identity.py before "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
swift build -c release -j 2
[1/1] Compiling plugin GenerateManual
[2/2] Compiling plugin GenerateDoccReference
Building for production...
[2/6] Write sources
[3/6] Write swift-version--1AB21518FC5DEDBE.txt
[5/7] Compiling Slotstream AdaptiveSpeculation.swift
<HOME>/Projects/slotstream/Sources/Slotstream/EmbeddingRows.swift:107:36: warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
105 |             data.withUnsafeMutableBytes { output in
106 |                 for (i, id) in ids.enumerated() {
107 |                     available[id]!.withUnsafeBytes { row in
    |                                    `- warning: result of call to 'withUnsafeBytes' is unused [#no-usage]
108 |                         memcpy(output.baseAddress! + i * stride, row.baseAddress! + offsets[p], stride)
109 |                     }

<HOME>/Projects/slotstream/Sources/Slotstream/RouterTrace.swift:36:13: warning: variable 'header' was never mutated; consider changing to 'let' constant
34 |         lock.lock()
35 |         defer { lock.unlock() }
36 |         var header = [Int32(layer), Int32(tokens), Int32(topK)]
   |             `- warning: variable 'header' was never mutated; consider changing to 'let' constant
37 |         header.withUnsafeBytes { buffer.append(contentsOf: $0) }
38 |         var small = [Int16](repeating: 0, count: ids.count)
[5/9] Write Objects.LinkFileList
[7/9] Linking slotstream-checks
[8/9] Linking slotstream
Build complete! (56.68s)
cp Tools/lib/mlx-0.32.2.metallib .build/release/mlx.metallib
python3 Tools/build_identity.py after "<HOME>/Projects/slotstream/.build/arm64-apple-macosx/release"
````

### vq-prefill-model-build-preflight-v3.json

Original bytes: 1986. SHA-256: `e0d097b0c163a0afa04b84fe8e6017671ffd7295f04723ac46b2d458633ad567`.

````text
{
  "page_bytes": 16384,
  "reclaimable_bytes": 23140057088,
  "swapins": 0,
  "swapouts": 16,
  "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    31832.\nPages active:                                1040610.\nPages inactive:                              1131435.\nPages speculative:                             72806.\nPages throttled:                                   0.\nPages wired down:                             181661.\nPages purgeable:                                1328.\n\"Translation faults\":                     1122444558.\nPages copy-on-write:                        67954328.\nPages zero filled:                        1948535884.\nPages reactivated:                          93601966.\nPages purged:                               10847189.\nFile-backed pages:                           1379197.\nAnonymous pages:                              865654.\nPages stored in compressor:                  1149577.\nPages occupied by compressor:                 626856.\nDecompressions:                             23387448.\nCompressions:                               33136416.\nPageins:                                   625888407.\nPageouts:                                     335846.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128079.\nPages tagged resident:                         89282.\nPages tagged compressed:                       38797.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          206.\nPages tag-storage non-tag pageable:            92791.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5715648.\nTagged compressions:                          440855.\nTagged decompressions:                        363626.\n"
}
````

### frozen-prefill-model-v3/build-identity.json

Original bytes: 29735. SHA-256: `a9df8fc3b3718c7c26b1ea15a9434a018b017798df460122999b510dc94d0885`.

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
    "Sources/Slotstream/VQCheckpoint.swift": "53525f6def06413a8812f93cc1bcb9a21c4a39e4708719f911a9c5ad784954c6",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "4643b13b0506bd5230d0f8ea11f749ba708cec13b688b1355769acbb1b897ca9",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "fe76311eda9627f6039450077383a45e9fafa0d0b53c48beaa232d71c63ae33b",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "fa0068d90454df6dec0e5d8a73d887a96d4350207e0cc21dc74e58a08054c1ee",
    "Sources/Slotstream/VQRouteStream.swift": "935c13d19a8febd8e82cb3e42a8c13fd80a875928f64f9cfc4d741847a96b04e",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "d6c2b48e9d778da623c29e7b514d614628c40d5feceec29ab7f5e30a23a33403",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "8376a3a59bf56e3c71b550beedf5b5d6cc54141b5353ca5ace1449079c3f01c6",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "49394377cc6e73ea5e995627504d13d3769e4cb2d8530eae245731e3aed44c41",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "6b3c28a81f1132b2f8aa0a6f43aedecda3a1022b8a11634a8b8b0b7f7fb2d7d1",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "a964b86713ff5fb760f9ff1f41b2c59cc983db116adfc41c72801c317da23766",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "e25d9405271d6be0d57b22d0970c3677a962038d786a418f418a3047b5cbf9c7",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "b4f8366c8f999551639f73d806919f73e2b9c4bd55c2303f618d267b901e6a79",
  "binary_sha256": "6ee9a9fecf2449a3490d2a4f1d6e9ec2e12470489ed0c88eddf4b31972503859",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````

### vq-prefill-model-native-3.2-v3/receipt.json

Original bytes: 5111. SHA-256: `04f3dc88e521f27a0d39e06b58f1d36c780d9d6f1dcf79c18647bb1e5564fa33`.

````text
{
  "before" : {
    "reclaimableBytes" : 23664279552,
    "swapins" : 0,
    "swapouts" : 16
  },
  "failure" : "VQ prefill model mismatch at 0:3:hidden",
  "fixture_sha256" : "49a0d4a40216dc45115fe39f499ffb8387bc07d0a05ae040d31529549cb120c6",
  "inventory_sha256" : "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
  "maximum_live_experts" : 32,
  "maximum_record_batches" : 11,
  "observed" : {
    "0:-1:embedded" : "09cbbdc6f63087c8b6e6822be2aa2854843b4908dc7d7129e04bd695044a87fd",
    "0:0:conv" : "8981b62090a11928fc6c440bb95f1fc9e96e3906da4f39149d4bae8d17d9cd8c",
    "0:0:hidden" : "ac10d21cfd551f897d8ad6a7a3451db69973c8410bd1b2685ece15dd0be20703",
    "0:0:state" : "709844dfd50713b068159ae2d10b89dfce1c0d711ee3f2e21993b6b7a268ade4",
    "0:1:conv" : "7fa3ee43f232c2f7f9a54ec6215cd318a3809479a1bb9e08bcdd785f73a9d95a",
    "0:1:hidden" : "1722c95afa638b31991cebf324adf3ffa3dfd164c3d1d0ca5791fecbc48c6fcd",
    "0:1:ple_conv" : "79f7a448d6ba75fa851da9e23e13b742e29ce51be0d36adeff3cd0eb85f0de7e",
    "0:1:state" : "496c0529dc3db23a249f8ae3c7733406355c9a52aef94d776ac541f3e9499004",
    "0:2:conv" : "2904fcbc91993f2e127ab2023bc9dc6b11fbfaab423fdf9c90f55a8a7e4c2db0",
    "0:2:hidden" : "c733a7c7ec2d73b02ea90cc45e39425852622002d0ef87a9285e7e969f2e816c",
    "0:2:state" : "916e2a9b03641152868cc775649085da83f2fe922df295e4b6bb440a9b32ab48",
    "0:3:hidden" : "5a3044ceb89ce7cb89eafb78084268c739295e6217456d9928897f094880bab5"
  },
  "peak_mlx_bytes" : 404274780,
  "peak_process_bytes" : 674383072,
  "profile" : "prefill512-decode1-v1",
  "qualification" : "unproven",
  "report" : {
    "items" : [
      {
        "name" : "0:-1:embedded geometry",
        "passed" : true
      },
      {
        "name" : "0:-1:embedded finite",
        "passed" : true
      },
      {
        "name" : "0:-1:embedded complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:0:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:0:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:0:conv finite",
        "passed" : true
      },
      {
        "name" : "0:0:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:0:state geometry",
        "passed" : true
      },
      {
        "name" : "0:0:state finite",
        "passed" : true
      },
      {
        "name" : "0:0:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:1:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:1:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:1:conv finite",
        "passed" : true
      },
      {
        "name" : "0:1:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:state geometry",
        "passed" : true
      },
      {
        "name" : "0:1:state finite",
        "passed" : true
      },
      {
        "name" : "0:1:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv geometry",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv finite",
        "passed" : true
      },
      {
        "name" : "0:1:ple_conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:2:hidden finite",
        "passed" : true
      },
      {
        "name" : "0:2:hidden complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:conv geometry",
        "passed" : true
      },
      {
        "name" : "0:2:conv finite",
        "passed" : true
      },
      {
        "name" : "0:2:conv complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:2:state geometry",
        "passed" : true
      },
      {
        "name" : "0:2:state finite",
        "passed" : true
      },
      {
        "name" : "0:2:state complete byte hash",
        "passed" : true
      },
      {
        "name" : "0:3:hidden geometry",
        "passed" : true
      },
      {
        "name" : "0:3:hidden finite",
        "passed" : true
      },
      {
        "detail" : "got 5a3044ceb89ce7cb89eafb78084268c739295e6217456d9928897f094880bab5, want e8212ec42fdfa4ebc80b975a65ffc0a857a9bb3264b6eccb37e350c9e8d819c7",
        "name" : "0:3:hidden complete byte hash",
        "passed" : false
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-prefill-model",
    "passed" : false
  },
  "schema" : 1,
  "scope" : "complete prefill arithmetic and one continuation; no generation qualification",
  "segmented_prefill_layers" : 4,
  "verified_files" : 130,
  "verified_payload_bytes" : 30562735024
}
````

### vq-prefill-model-native-3.2-v3-supervision/identity.json

Original bytes: 2771. SHA-256: `ff06c0aa4b9c5934ac8b18034631afc0b9e14954469e369e99e341e44e9e4755`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-prefill-model-v3/slotstream",
    "quantization-model-check",
    "--prefill",
    "--source-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--source-inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--fixture-directory",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-reference-3.2-v1",
    "--output",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-native-3.2-v3"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22952574976,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70823.\nPages active:                                1070473.\nPages inactive:                              1093238.\nPages speculative:                             45333.\nPages throttled:                                   0.\nPages wired down:                             180623.\nPages purgeable:                                2082.\n\"Translation faults\":                     1123237541.\nPages copy-on-write:                        68001765.\nPages zero filled:                        1949019343.\nPages reactivated:                          93602455.\nPages purged:                               10847911.\nFile-backed pages:                           1328009.\nAnonymous pages:                              881035.\nPages stored in compressor:                  1144262.\nPages occupied by compressor:                 624941.\nDecompressions:                             23391424.\nCompressions:                               33136416.\nPageins:                                   625948809.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128177.\nPages tagged resident:                         89416.\nPages tagged compressed:                       38761.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          152.\nPages tag-storage non-tag pageable:            92846.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708544.\nTagged compressions:                          440855.\nTagged decompressions:                        363657.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-prefill-model-native-3.2-v3-supervision/receipt.json

Original bytes: 2136. SHA-256: `944a2fcb4e7a197953a57150cff54acfc22e3af36dbca045099ac6d524a5b8d8`.

````text
{
  "exit_code": 1,
  "failure": null,
  "sampled_peak_bytes": 674383072,
  "samples": 227,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23089659904,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    36667.\nPages active:                                1049344.\nPages inactive:                              1123565.\nPages speculative:                             80123.\nPages throttled:                                   0.\nPages wired down:                             170951.\nPages purgeable:                                5963.\n\"Translation faults\":                     1123446607.\nPages copy-on-write:                        68009879.\nPages zero filled:                        1949294596.\nPages reactivated:                          93608778.\nPages purged:                               10853080.\nFile-backed pages:                           1366651.\nAnonymous pages:                              886381.\nPages stored in compressor:                  1143440.\nPages occupied by compressor:                 624398.\nDecompressions:                             23392048.\nCompressions:                               33136452.\nPageins:                                   627830607.\nPageouts:                                     336240.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128165.\nPages tagged resident:                         89467.\nPages tagged compressed:                       38698.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          541.\nPages tag-storage non-tag pageable:            92457.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5698752.\nTagged compressions:                          440855.\nTagged decompressions:                        363719.\n"
  },
  "seconds": 13.468560375000001
}
````

### vq-prefill-model-native-3.2-v3-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-prefill-model-native-3.2-v3-supervision/stderr.txt

Original bytes: 116. SHA-256: `b1b42d89669e5f451a025af1d0a295ea54375fe76109b0eb256075920926417c`.

````text
VQ prefill P0 L0 exact
VQ prefill P0 L1 exact
VQ prefill P0 L2 exact
Error: VQ prefill model mismatch at 0:3:hidden
````

### vq-prefill-model-reference-3.2-capture-v1-supervision/identity.json

Original bytes: 2718. SHA-256: `2b2d43cebe7de1f49dcccd5c9edd572ba74d4d979dbea64a5d63846db99bab21`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_model_prefill_reference.py",
    "--model",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--architecture",
    "<HOME>/Projects/slotstream/.build/quantization-research/qwen4_exp-pr1788.py",
    "--save-layer",
    "2",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-reference-3.2-capture-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23101308928,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    79811.\nPages active:                                1076356.\nPages inactive:                              1081879.\nPages speculative:                             42816.\nPages throttled:                                   0.\nPages wired down:                             178303.\nPages purgeable:                                7444.\n\"Translation faults\":                     1117865957.\nPages copy-on-write:                        67834959.\nPages zero filled:                        1943329278.\nPages reactivated:                          93548318.\nPages purged:                               10840434.\nFile-backed pages:                           1322737.\nAnonymous pages:                              878314.\nPages stored in compressor:                  1146784.\nPages occupied by compressor:                 626296.\nDecompressions:                             23345805.\nCompressions:                               33029249.\nPageins:                                   611372163.\nPageouts:                                     335088.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 129058.\nPages tagged resident:                         90239.\nPages tagged compressed:                       38819.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          185.\nPages tag-storage non-tag pageable:            92812.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5717440.\nTagged compressions:                          439847.\nTagged decompressions:                        363070.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-prefill-model-reference-3.2-capture-v1-supervision/receipt.json

Original bytes: 2131. SHA-256: `512bb04d2d2eda126f02cddd1ba95d6cdf370b022af1f6503f9ae33764e31b74`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 3189033888,
  "samples": 683,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23427661824,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   185821.\nPages active:                                1045156.\nPages inactive:                              1027088.\nPages speculative:                             23771.\nPages throttled:                                   0.\nPages wired down:                             171284.\nPages purgeable:                                6712.\n\"Translation faults\":                     1121783700.\nPages copy-on-write:                        67899321.\nPages zero filled:                        1947979263.\nPages reactivated:                          93601608.\nPages purged:                               10845035.\nFile-backed pages:                           1237378.\nAnonymous pages:                              858637.\nPages stored in compressor:                  1160202.\nPages occupied by compressor:                 631859.\nDecompressions:                             23382013.\nCompressions:                               33136416.\nPageins:                                   619191865.\nPageouts:                                     335598.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128450.\nPages tagged resident:                         88911.\nPages tagged compressed:                       39539.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          635.\nPages tag-storage non-tag pageable:            92362.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5839424.\nTagged compressions:                          440855.\nTagged decompressions:                        363356.\n"
  },
  "seconds": 40.026167167
}
````

### vq-prefill-model-reference-3.2-capture-v1-supervision/stdout.txt

Original bytes: 11845. SHA-256: `434ea88645c41d5b211b9047625573d0497706881aaa65f8af76acb04aa25a0f`.

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
{"layer": 0, "memory": {"current_bytes": 2164607328, "lifetime_peak_bytes": 2846214808, "rss_peak_bytes": 2275590144}}
{"layer": 1, "memory": {"current_bytes": 2238073256, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 2, "memory": {"current_bytes": 1901267128, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 3, "memory": {"current_bytes": 1611728912, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 4, "memory": {"current_bytes": 1622640632, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 5, "memory": {"current_bytes": 2186119592, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 6, "memory": {"current_bytes": 1622820856, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 7, "memory": {"current_bytes": 1611892752, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 8, "memory": {"current_bytes": 1622935544, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 9, "memory": {"current_bytes": 1620690936, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 10, "memory": {"current_bytes": 1620559864, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 11, "memory": {"current_bytes": 1609599016, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 12, "memory": {"current_bytes": 1620494328, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 13, "memory": {"current_bytes": 1620494328, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 14, "memory": {"current_bytes": 1620559840, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 15, "memory": {"current_bytes": 1609582584, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 16, "memory": {"current_bytes": 1610352608, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 17, "memory": {"current_bytes": 1610352608, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 18, "memory": {"current_bytes": 1908934840, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 19, "memory": {"current_bytes": 1900398824, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 20, "memory": {"current_bytes": 1620445152, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 21, "memory": {"current_bytes": 1899399352, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 22, "memory": {"current_bytes": 1620625400, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 23, "memory": {"current_bytes": 1609582560, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 24, "memory": {"current_bytes": 1615595488, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 25, "memory": {"current_bytes": 1620428768, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 26, "memory": {"current_bytes": 1620445176, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 27, "memory": {"current_bytes": 1609615376, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 28, "memory": {"current_bytes": 1620445152, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 29, "memory": {"current_bytes": 1610368992, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 30, "memory": {"current_bytes": 1909098704, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 31, "memory": {"current_bytes": 2187118992, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 32, "memory": {"current_bytes": 1610385376, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 33, "memory": {"current_bytes": 1902020792, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 34, "memory": {"current_bytes": 1908967632, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 35, "memory": {"current_bytes": 1609615376, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 36, "memory": {"current_bytes": 1620494304, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 37, "memory": {"current_bytes": 1898891448, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 38, "memory": {"current_bytes": 1909016784, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 39, "memory": {"current_bytes": 2183235984, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 40, "memory": {"current_bytes": 1610401760, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 41, "memory": {"current_bytes": 1908984016, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 42, "memory": {"current_bytes": 1611040736, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 43, "memory": {"current_bytes": 1609615352, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 44, "memory": {"current_bytes": 1620461536, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 45, "memory": {"current_bytes": 1908967608, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 46, "memory": {"current_bytes": 1909098680, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"layer": 47, "memory": {"current_bytes": 2178451856, "lifetime_peak_bytes": 2889927344, "rss_peak_bytes": 2276114432}}
{"complete": true, "boundaries": 320, "memory": {"current_bytes": 2297367072, "lifetime_peak_bytes": 3189033888, "rss_peak_bytes": 2276114432}}
````

### vq-prefill-model-reference-3.2-capture-v1-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-prefill-attention-3.2-v1-supervision/identity.json

Original bytes: 2808. SHA-256: `5953c4d20439248b16a3574a0605714a9202ba1bdbfde984d9c89f8f6c821431`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_prefill_attention_reference.py",
    "--model",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2",
    "--inventory",
    "<HOME>/Projects/slotstream/.build/quantization-research/inventory-3.2/inventory.json",
    "--architecture",
    "<HOME>/Projects/slotstream/.build/quantization-research/qwen4_exp-pr1788.py",
    "--fixture",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-model-reference-3.2-capture-v1",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-prefill-attention-3.2-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23428153344,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   185837.\nPages active:                                1045419.\nPages inactive:                              1027065.\nPages speculative:                             23773.\nPages throttled:                                   0.\nPages wired down:                             171284.\nPages purgeable:                                6712.\n\"Translation faults\":                     1121786519.\nPages copy-on-write:                        67899753.\nPages zero filled:                        1947980452.\nPages reactivated:                          93601608.\nPages purged:                               10845035.\nFile-backed pages:                           1237392.\nAnonymous pages:                              858865.\nPages stored in compressor:                  1160038.\nPages occupied by compressor:                 631805.\nDecompressions:                             23382186.\nCompressions:                               33136416.\nPageins:                                   619191868.\nPageouts:                                     335598.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128450.\nPages tagged resident:                         88911.\nPages tagged compressed:                       39539.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          576.\nPages tag-storage non-tag pageable:            92421.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5839424.\nTagged compressions:                          440855.\nTagged decompressions:                        363356.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-prefill-attention-3.2-v1-supervision/receipt.json

Original bytes: 2136. SHA-256: `83f55f92fe04df749b75a4c0f33fc01520f5045dffb6b9bea6bf31ebcc4d578f`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 768263440,
  "samples": 505,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23199121408,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    54400.\nPages active:                                1039009.\nPages inactive:                              1176786.\nPages speculative:                              4730.\nPages throttled:                                   0.\nPages wired down:                             181986.\nPages purgeable:                                1092.\n\"Translation faults\":                     1121973797.\nPages copy-on-write:                        67912972.\nPages zero filled:                        1948126996.\nPages reactivated:                          93601708.\nPages purged:                               10846501.\nFile-backed pages:                           1360470.\nAnonymous pages:                              860055.\nPages stored in compressor:                  1152689.\nPages occupied by compressor:                 628201.\nDecompressions:                             23385778.\nCompressions:                               33136416.\nPageins:                                   623904331.\nPageouts:                                     335725.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128605.\nPages tagged resident:                         89128.\nPages tagged compressed:                       39477.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          521.\nPages tag-storage non-tag pageable:            92476.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5832448.\nTagged compressions:                          440855.\nTagged decompressions:                        363416.\n"
  },
  "seconds": 29.606384624999997
}
````

### vq-prefill-attention-3.2-v1-supervision/stdout.txt

Original bytes: 88737. SHA-256: `0b624f324e062d45bf6b3d045c6bfe4841ad1381115c835f71bae6a184e46a26`.

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
{"schema": 1, "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87", "normalization": "vq-raw-zero-centered-to-pr1788-folded-bf16-v1", "artifact": {"verification_sha256": "ec76e8ddf0a7038ad51f3a08cabf12e2c22ca199b15d4b94c71688c1a73b8d7e", "stamps": {"model-00001.safetensors": [16777232, 61124837, 3502305114, 1790981216969651631, 1790981216973805883], "model-00012.safetensors": [16777232, 61124923, 6258175824, 1790981377005612627, 1790981377009206956], "model-00013.safetensors": [16777232, 61125010, 6471407889, 1790981545033604036, 1790981545036494899], "model-00014.safetensors": [16777232, 61125132, 6547978262, 1790981736942738954, 1790981736944883976], "model-00015.safetensors": [16777232, 61125286, 6471407935, 1790981924339816693, 1790981924342464654], "model-00016.safetensors": [16777232, 61125510, 6857620951, 1790982119683472302, 1790982119685710216], "model-00017.safetensors": [16777232, 61129776, 6679034951, 1790982305666734292, 1790982305672913817], "model-00018.safetensors": [16777232, 61136554, 6733521211, 1790982515929442647, 1790982515931575685], "model-00019.safetensors": [16777232, 61136710, 3457093298, 1790982619932592777, 1790982619933742130], "model-ple-0000.safetensors": [16777232, 61140250, 162517607, 1790982627138573871, 1790982627139487012], "model-ple-0001.safetensors": [16777232, 61140257, 162517605, 1790982633555677032, 1790982633556582756], "model-ple-0002.safetensors": [16777232, 61140267, 162517610, 1790982639202217456, 1790982639203120347], "model-ple-0003.safetensors": [16777232, 61140272, 162517613, 1790982645069140209, 1790982645069823054], "model-ple-0004.safetensors": [16777232, 61140283, 162517613, 1790982650945947009, 1790982650946871359], "model-ple-0005.safetensors": [16777232, 61140293, 162517611, 1790982657117788365, 1790982657118728631], "model-ple-0006.safetensors": [16777232, 61140299, 162517611, 1790982663412388541, 1790982663413293974], "model-ple-0007.safetensors": [16777232, 61140312, 162517611, 1790982669152254855, 1790982669153205538], "model-ple-0008.safetensors": [16777232, 61140320, 162517613, 1790982674022126144, 1790982674023049244], "model-ple-0009.safetensors": [16777232, 61140331, 162517613, 1790982678928236736, 1790982678929079667], "model-ple-0010.safetensors": [16777232, 61140335, 162517613, 1790982683656085531, 1790982683656969339], "model-ple-0011.safetensors": [16777232, 61140341, 162517613, 1790982688473524025, 1790982688474332997], "model-ple-0012.safetensors": [16777232, 61140355, 162517613, 1790982693458602253, 1790982693459500144], "model-ple-0013.safetensors": [16777232, 61140371, 162517610, 1790982698170087804, 1790982698170988778], "model-ple-0014.safetensors": [16777232, 61140391, 162517613, 1790982703332828567, 1790982703333775500], "model-ple-0015.safetensors": [16777232, 61140399, 162517613, 1790982708259744691, 1790982708261148174], "model-ple-0016.safetensors": [16777232, 61140409, 162517613, 1790982713943583771, 1790982713944535246], "model-ple-0017.safetensors": [16777232, 61140416, 162517613, 1790982719388327528, 1790982719389255419], "model-ple-0018.safetensors": [16777232, 61140420, 162517611, 1790982725402636950, 1790982725403550133], "model-ple-0019.safetensors": [16777232, 61140425, 162517613, 1790982731256203385, 1790982731257126901], "model-ple-0020.safetensors": [16777232, 61140432, 162517611, 1790982738071856793, 1790982738076684212], "model-ple-0021.safetensors": [16777232, 61140437, 162517611, 1790982744489047206, 1790982744489882637], "model-ple-0022.safetensors": [16777232, 61140441, 162517613, 1790982750186433982, 1790982750187391749], "model-ple-0023.safetensors": [16777232, 61140448, 162517613, 1790982756483893209, 1790982756484835975], "model-ple-0024.safetensors": [16777232, 61140462, 162517610, 1790982762487478610, 1790982762488429168], "model-ple-0025.safetensors": [16777232, 61140474, 162517613, 1790982768446695857, 1790982768447609374], "model-ple-0026.safetensors": [16777232, 61140482, 162517611, 1790982774682704006, 1790982774683668940], "model-ple-0027.safetensors": [16777232, 61140487, 162517613, 1790982780054403106, 1790982780055155744], "model-ple-0028.safetensors": [16777232, 61140492, 162517611, 1790982786131927514, 1790982786133070409], "model-ple-0029.safetensors": [16777232, 61140498, 162517613, 1790982791720789884, 1790982791721679899], "model-ple-0030.safetensors": [16777232, 61140507, 162517613, 1790982797363790787, 1790982797364736846], "model-ple-0031.safetensors": [16777232, 61140513, 162517611, 1790982802855896085, 1790982802856819934], "model-ple-0032.safetensors": [16777232, 61140518, 162517613, 1790982807785930346, 1790982807786920405], "model-ple-0033.safetensors": [16777232, 61140523, 162517610, 1790982812651563228, 1790982812652470660], "model-ple-0034.safetensors": [16777232, 61140532, 162517610, 1790982817300943895, 1790982817301852203], "model-ple-0035.safetensors": [16777232, 61140541, 162517610, 1790982821915884168, 1790982821916815851], "model-ple-0036.safetensors": [16777232, 61140548, 162517610, 1790982826932480491, 1790982826933326089], "model-ple-0037.safetensors": [16777232, 61140558, 162517608, 1790982832539544681, 1790982832540443571], "model-ple-0038.safetensors": [16777232, 61140562, 162517608, 1790982838522902935, 1790982838523814159], "model-ple-0039.safetensors": [16777232, 61140567, 162517610, 1790982843582402768, 1790982843583243134], "model-ple-0040.safetensors": [16777232, 61140573, 162517607, 1790982848339011099, 1790982848339968272], "model-ple-0041.safetensors": [16777232, 61140580, 162517610, 1790982853469781697, 1790982853470684511], "model-ple-0042.safetensors": [16777232, 61140585, 162517610, 1790982858244013692, 1790982858244908195], "model-ple-0043.safetensors": [16777232, 61140590, 162517610, 1790982864003203242, 1790982864003554394], "model-ple-0044.safetensors": [16777232, 61140723, 162517610, 1790982869607285689, 1790982869607623044], "model-ple-0045.safetensors": [16777232, 61140727, 162517610, 1790982874968029129, 1790982874968458830], "model-ple-0046.safetensors": [16777232, 61140733, 162517610, 1790982880349184866, 1790982880349581326], "model-ple-0047.safetensors": [16777232, 61140740, 162517610, 1790982885705681830, 1790982885706026572], "model-ple-0048.safetensors": [16777232, 61140754, 162517610, 1790982891521923333, 1790982891522300880], "model-ple-0049.safetensors": [16777232, 61140765, 162517610, 1790982897650766513, 1790982897651168488], "model-ple-0050.safetensors": [16777232, 61140771, 162517610, 1790982902965919941, 1790982902966278301], "model-ple-0051.safetensors": [16777232, 61140786, 162517607, 1790982908425811945, 1790982908426161103], "model-ple-0052.safetensors": [16777232, 61140797, 162517610, 1790982913785471096, 1790982913785813799], "model-ple-0053.safetensors": [16777232, 61140810, 162517610, 1790982919733610844, 1790982919734091924], "model-ple-0054.safetensors": [16777232, 61140815, 162517610, 1790982925452621410, 1790982925452965243], "model-ple-0055.safetensors": [16777232, 61140822, 162517608, 1790982932055042996, 1790982932055373372], "model-ple-0056.safetensors": [16777232, 61140834, 162517610, 1790982936821992693, 1790982936822328986], "model-ple-0057.safetensors": [16777232, 61140853, 162517610, 1790982941795208562, 1790982941795727564], "model-ple-0058.safetensors": [16777232, 61140865, 162517610, 1790982946659199029, 1790982946659690490], "model-ple-0059.safetensors": [16777232, 61140875, 162517608, 1790982951976555530, 1790982951976913741], "model-ple-0060.safetensors": [16777232, 61140902, 162517610, 1790982956943755943, 1790982956944108612], "model-ple-0061.safetensors": [16777232, 61140920, 162517608, 1790982962665866982, 1790982962666720072], "model-ple-0062.safetensors": [16777232, 61140930, 162517607, 1790982967600947912, 1790982967601780793], "model-ple-0063.safetensors": [16777232, 61140936, 162517610, 1790982973501324444, 1790982973502267410], "model-ple-0064.safetensors": [16777232, 61140943, 162517610, 1790982979530596195, 1790982979531817747], "model-ple-0065.safetensors": [16777232, 61140947, 162517610, 1790982985158304116, 1790982985159197707], "model-ple-0066.safetensors": [16777232, 61140953, 162517610, 1790982990898086726, 1790982990899063943], "model-ple-0067.safetensors": [16777232, 61140961, 162517610, 1790982996401559646, 1790982996402469196], "model-ple-0068.safetensors": [16777232, 61140966, 162517610, 1790983001756097601, 1790983001756707940], "model-ple-0069.safetensors": [16777232, 61140971, 162517610, 1790983007637603657, 1790983007638662583], "model-ple-0070.safetensors": [16777232, 61140981, 162517610, 1790983013286585629, 1790983013287401512], "model-ple-0071.safetensors": [16777232, 61140991, 162517610, 1790983018661604180, 1790983018662524313], "model-ple-0072.safetensors": [16777232, 61140996, 162517608, 1790983025820209701, 1790983025820855165], "model-ple-0073.safetensors": [16777232, 61141003, 162517607, 1790983031268771311, 1790983031269542818], "model-ple-0074.safetensors": [16777232, 61141007, 162517610, 1790983036991725465, 1790983036992614640], "model-ple-0075.safetensors": [16777232, 61141012, 162517608, 1790983043613793342, 1790983043614438681], "model-ple-0076.safetensors": [16777232, 61141018, 162517610, 1790983049313185610, 1790983049313857116], "model-ple-0077.safetensors": [16777232, 61141023, 162517610, 1790983055161970608, 1790983055162864367], "model-ple-0078.safetensors": [16777232, 61141032, 162517610, 1790983061167775992, 1790983061168481748], "model-ple-0079.safetensors": [16777232, 61141036, 162517610, 1790983067037600567, 1790983067038473950], "model-ple-0080.safetensors": [16777232, 61141049, 162517610, 1790983072453387751, 1790983072454284801], "model-ple-0081.safetensors": [16777232, 61141056, 162517610, 1790983078283342764, 1790983078284280980], "model-ple-0082.safetensors": [16777232, 61141060, 162517610, 1790983084482326237, 1790983084483212704], "model-ple-0083.safetensors": [16777232, 61141066, 162517610, 1790983089959112142, 1790983089959804899], "model-ple-0084.safetensors": [16777232, 61141082, 162517607, 1790983095473290968, 1790983095474232352], "model-ple-0085.safetensors": [16777232, 61141108, 162517610, 1790983101378794539, 1790983101379764131], "model-ple-0086.safetensors": [16777232, 61141148, 162517610, 1790983107460704078, 1790983107461626962], "model-ple-0087.safetensors": [16777232, 61141156, 162517610, 1790983113584810374, 1790983113585582464], "model-ple-0088.safetensors": [16777232, 61141169, 162517610, 1790983119099203121, 1790983119100094587], "model-ple-0089.safetensors": [16777232, 61141174, 162517608, 1790983124882360253, 1790983124883316345], "model-ple-0090.safetensors": [16777232, 61141184, 162517610, 1790983129724665676, 1790983129728605211], "model-ple-0091.safetensors": [16777232, 61141201, 162517610, 1790983134421494909, 1790983134422479168], "model-ple-0092.safetensors": [16777232, 61141209, 162517608, 1790983140041034022, 1790983140041975030], "model-ple-0093.safetensors": [16777232, 61141216, 162517610, 1790983144777734031, 1790983144778600997], "model-ple-0094.safetensors": [16777232, 61141241, 162517610, 1790983149994926383, 1790983149995738224], "model-ple-0095.safetensors": [16777232, 61141276, 162517607, 1790983154752645124, 1790983154753430965], "model-ple-0096.safetensors": [16777232, 61141310, 162517610, 1790983159970819319, 1790983159971858203], "model-ple-0097.safetensors": [16777232, 61141318, 162517610, 1790983164974114237, 1790983164975063121], "model-ple-0098.safetensors": [16777232, 61141323, 162517610, 1790983170565673096, 1790983170566609646], "model-ple-0099.safetensors": [16777232, 61141341, 162517610, 1790983176718977574, 1790983176719852457], "model-ple-0100.safetensors": [16777232, 61141350, 162517610, 1790983182892329693, 1790983182892738405], "model-ple-0101.safetensors": [16777232, 61141372, 162517608, 1790983190065519468, 1790983190066574978], "model-ple-0102.safetensors": [16777232, 61141385, 162517610, 1790983196095511208, 1790983196096427549], "model-ple-0103.safetensors": [16777232, 61141390, 162517610, 1790983202080614873, 1790983202081544381], "model-ple-0104.safetensors": [16777232, 61141399, 162517610, 1790983208182737513, 1790983208183661313], "model-ple-0105.safetensors": [16777232, 61141403, 162517608, 1790983215042826794, 1790983215043752094], "model-ple-0106.safetensors": [16777232, 61141409, 162517607, 1790983221162356590, 1790983221163275015], "model-ple-0107.safetensors": [16777232, 61141416, 162517610, 1790983227340430125, 1790983227341199799], "model-ple-0108.safetensors": [16777232, 61141423, 162517610, 1790983233417963378, 1790983233418918095], "model-ple-0109.safetensors": [16777232, 61141427, 162517610, 1790983240053641506, 1790983240054479847], "model-ple-0110.safetensors": [16777232, 61141434, 162517610, 1790983246089577132, 1790983246090531974], "model-ple-0111.safetensors": [16777232, 61141445, 162517608, 1790983252879031941, 1790983252879968574], "model-ple-0112.safetensors": [16777232, 61141452, 162517610, 1790983259339176441, 1790983259340068949], "model-ple-0113.safetensors": [16777232, 61141456, 162517610, 1790983265744837490, 1790983265745586580], "model-ple-0114.safetensors": [16777232, 61141462, 162517608, 1790983271948410630, 1790983271949375806], "model-ple-0115.safetensors": [16777232, 61141468, 162517610, 1790983277072728185, 1790983277073646361], "model-ple-0116.safetensors": [16777232, 61141474, 162517610, 1790983281919413398, 1790983281920340073], "model-ple-0117.safetensors": [16777232, 61141479, 162517607, 1790983287080135032, 1790983287081064707], "model-ple-0118.safetensors": [16777232, 61141484, 162517610, 1790983292260776471, 1790983292261697105], "model-ple-0119.safetensors": [16777232, 61141492, 162517610, 1790983298780979640, 1790983298781872273], "model-ple-0120.safetensors": [16777232, 61141500, 162517610, 1790983303892181911, 1790983303893137127], "model-ple-0121.safetensors": [16777232, 61141508, 162517610, 1790983308606338467, 1790983308610440713], "model-ple-0122.safetensors": [16777232, 61141514, 162517610, 1790983313679208182, 1790983313680128357], "model-ple-0123.safetensors": [16777232, 61141521, 162517610, 1790983318626470763, 1790983318627401563], "model-ple-0124.safetensors": [16777232, 61141525, 162517608, 1790983324394582509, 1790983324395549101], "model-ple-0125.safetensors": [16777232, 61141530, 162517610, 1790983329613341251, 1790983329614258593], "model-ple-0126.safetensors": [16777232, 61141535, 162517610, 1790983334867535188, 1790983334868484072], "model-ple-0127.safetensors": [16777232, 61141544, 162517610, 1790983340019529075, 1790983340022576061], "model-vision-graft.safetensors": [16777232, 61141549, 897899165, 1790983365524919672, 1790983365525846388], "mtp-head-q6.safetensors": [16777232, 61141567, 2297560747, 1790983429393243759, 1790983429397524048]}, "inventory_sha256": "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe"}, "instrument": {"scripts": {"vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec", "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e", "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749", "vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e", "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb", "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8", "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34", "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472", "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"}, "packages": {"mlx": {"version": "0.32.2", "files": {"mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912", "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de", "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29", "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2", "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66", "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723", "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb", "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27", "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492", "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831", "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007", "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1", "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f", "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6", "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee", "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b", "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969", "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f", "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8", "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23", "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83", "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c", "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77", "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b", "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7", "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b", "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc", "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849", "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247", "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42", "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a", "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae", "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"}}, "mlx-metal": {"version": "0.32.2", "files": {"mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a", "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084", "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8", "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"}}, "mlx-lm": {"version": "0.31.3", "files": {"mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608", "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834", "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c", "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553", "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8", "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7", "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7", "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5", "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a", "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1", "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39", "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f", "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b", "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7", "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5", "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9", "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72", "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5", "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82", "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f", "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb", "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d", "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7", "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373", "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5", "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8", "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750", "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a", "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610", "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70", "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66", "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095", "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d", "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9", "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7", "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91", "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db", "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1", "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914", "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e", "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96", "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1", "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c", "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251", "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a", "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38", "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6", "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8", "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f", "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2", "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2", "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05", "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643", "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e", "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec", "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9", "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd", "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443", "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba", "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af", "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19", "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332", "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197", "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db", "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f", "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19", "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d", "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd", "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305", "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d", "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0", "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8", "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c", "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395", "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca", "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb", "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c", "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8", "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f", "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8", "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4", "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf", "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7", "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd", "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13", "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306", "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145", "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca", "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d", "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c", "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057", "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4", "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855", "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae", "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f", "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e", "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9", "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393", "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90", "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1", "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4", "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b", "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9", "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5", "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e", "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd", "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28", "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b", "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582", "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e", "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391", "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306", "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41", "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639", "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a", "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619", "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005", "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79", "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e", "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9", "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc", "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a", "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e", "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832", "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179", "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125", "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a", "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a", "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a", "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169", "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2", "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427", "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a", "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa", "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa", "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a", "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020", "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e", "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58", "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67", "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b", "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19", "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a", "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc", "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c", "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66", "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1", "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206", "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531", "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f", "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0", "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d", "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25", "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3", "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3", "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17", "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10", "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45", "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375", "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe", "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553", "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d", "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"}}, "numpy": {"version": "2.5.2", "files": {"numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b", "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11", "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972", "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a", "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2", "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6", "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb", "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2", "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926", "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881", "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a", "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0", "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476", "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee", "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af", "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627", "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b", "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c", "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78", "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950", "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d", "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5", "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66", "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2", "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2", "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395", "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf", "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605", "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5", "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106", "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c", "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49", "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417", "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8", "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca", "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807", "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b", "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e", "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332", "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3", "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957", "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2", "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0", "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81", "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a", "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea", "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d", "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159", "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582", "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af", "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c", "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2", "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d", "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224", "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec", "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a", "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489", "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67", "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a", "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143", "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a", "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31", "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d", "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847", "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f", "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f", "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b", "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0", "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf", "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477", "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2", "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650", "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1", "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd", "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a", "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4", "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc", "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41", "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111", "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008", "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d", "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a", "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19", "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068", "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72", "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01", "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c", "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c", "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099", "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0", "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a", "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761", "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca", "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e", "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6", "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc", "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8", "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446", "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe", "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc", "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9", "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca", "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288", "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76", "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0", "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4", "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76", "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669", "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808", "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987", "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a", "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f", "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36", "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2", "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b", "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605", "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002", "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b", "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33", "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8", "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1", "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7", "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1", "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284", "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c", "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24", "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5", "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e", "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310", "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf", "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9", "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9", "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c", "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a", "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27", "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c", "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275", "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436", "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5", "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714", "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550", "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df", "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822", "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93", "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92", "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b", "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2", "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930", "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca", "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c", "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf", "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07", "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306", "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf", "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5", "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142", "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406", "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a", "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795", "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab", "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c", "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c", "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8", "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537", "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e", "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74", "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec", "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0", "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7", "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a", "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0", "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d", "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822", "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8", "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137", "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37", "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3", "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576", "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681", "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529", "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491", "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6", "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873", "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4", "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4", "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281", "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547", "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0", "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09", "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f", "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d", "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4", "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7", "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc", "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3", "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9", "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e", "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e", "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82", "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f", "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7", "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e", "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36", "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6", "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d", "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026", "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777", "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386", "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb", "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599", "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07", "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa", "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b", "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f", "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0", "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72", "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b", "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f", "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d", "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b", "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d", "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e", "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131", "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4", "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0", "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460", "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771", "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116", "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd", "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e", "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48", "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb", "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5", "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545", "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc", "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec", "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862", "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb", "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939", "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea", "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195", "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435", "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0", "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292", "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b", "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074", "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6", "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4", "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874", "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792", "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202", "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292", "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c", "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc", "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f", "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b", "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c", "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79", "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4", "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a", "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af", "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324", "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46", "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780", "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed", "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab", "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c", "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5", "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e", "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74", "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4", "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f", "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98", "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004", "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3", "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c", "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca", "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2", "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f", "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d", "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c", "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781", "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953", "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e", "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5", "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828", "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417", "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425", "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11", "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2", "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642", "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6", "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5", "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718", "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16", "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782", "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c", "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5", "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9", "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53", "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709", "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4", "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47", "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca", "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917", "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8", "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f", "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2", "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824", "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d", "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3", "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396", "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25", "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af", "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d", "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6", "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033", "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418", "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84", "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352", "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99", "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228", "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca", "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82", "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78", "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b", "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9", "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0", "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5", "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801", "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c", "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc", "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b", "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b", "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3", "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639", "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e", "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0", "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5", "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945", "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b", "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f", "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45", "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931", "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3", "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c", "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213", "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5", "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9", "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2", "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4", "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13", "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e", "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37", "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557", "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc", "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9", "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363", "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a", "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5", "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32", "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498", "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049", "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7", "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4", "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0", "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc", "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166", "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682", "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482", "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a", "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e", "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196", "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed", "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a", "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723", "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14", "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5", "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2", "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392", "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759", "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee", "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe", "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd", "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe", "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0", "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c", "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4", "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94", "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147", "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1", "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c", "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665", "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b", "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02", "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff", "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67", "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94", "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0", "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0", "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509", "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda", "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0", "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1", "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796", "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3", "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5", "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14", "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297", "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54", "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"}}}, "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]", "sha256": "579aa5d127d0e019f205170f54b96772c4e45e845d251160de6ea64857a05af2"}, "producer_sha256": "561f184ed16d27686a93cd2ba6248b6bcec3261952564bf00b67c68de1aa35e8", "before": {"page_bytes": 16384, "reclaimable_bytes": 23416078336, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   186584.\nPages active:                                1044983.\nPages inactive:                              1027805.\nPages speculative:                             22823.\nPages throttled:                                   0.\nPages wired down:                             171305.\nPages purgeable:                                4920.\n\"Translation faults\":                     1121792439.\nPages copy-on-write:                        67900612.\nPages zero filled:                        1947982817.\nPages reactivated:                          93601612.\nPages purged:                               10845035.\nFile-backed pages:                           1237700.\nAnonymous pages:                              857911.\nPages stored in compressor:                  1159768.\nPages occupied by compressor:                 631799.\nDecompressions:                             23382206.\nCompressions:                               33136416.\nPageins:                                   619191912.\nPageouts:                                     335598.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128450.\nPages tagged resident:                         88911.\nPages tagged compressed:                       39539.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          328.\nPages tag-storage non-tag pageable:            92669.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5839424.\nTagged compressions:                          440855.\nTagged decompressions:                        363356.\n"}, "source_fixture": {"layer": 2, "step": 0, "name": "hidden", "shape": [1, 512, 10240], "dtype": "BF16", "bytes": 10485760, "sha256": "c733a7c7ec2d73b02ea90cc45e39425852622002d0ef87a9285e7e969f2e816c"}, "source_file_sha256": "2ee1ee4169e7dfcf0d9039348ee14f99415e777b192551399b234e06beda4516", "expanded_equals_whole": true, "memory": {"current_bytes": 674186440, "lifetime_peak_bytes": 682181832, "rss_peak_bytes": 545390592}, "fixture": {"path": "attention.safetensors", "bytes": 94004810, "sha256": "c2c8b8b5a72a30960ab406333c7c1c50ab384a76c2eec6dec43e30ec7a80f4da"}, "qualification": "unproven"}
````

### vq-prefill-attention-3.2-v1-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-rope-probe-v1-supervision/identity.json

Original bytes: 2282. SHA-256: `8a6e63657dfde7d95e44bfc14d2026c0bb4cd1d786d949cb25876a56f2c81dfa`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "<HOME>/Projects/slotstream/.build/quantization-research/probe-vq-rope-v1.py"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23034052608,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    92224.\nPages active:                                1077924.\nPages inactive:                              1074560.\nPages speculative:                             43854.\nPages throttled:                                   0.\nPages wired down:                             171934.\nPages purgeable:                                6240.\n\"Translation faults\":                     1123104163.\nPages copy-on-write:                        67983698.\nPages zero filled:                        1948942779.\nPages reactivated:                          93602295.\nPages purged:                               10847655.\nFile-backed pages:                           1307423.\nAnonymous pages:                              888915.\nPages stored in compressor:                  1146620.\nPages occupied by compressor:                 625259.\nDecompressions:                             23389279.\nCompressions:                               33136416.\nPageins:                                   625934652.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128210.\nPages tagged resident:                         89443.\nPages tagged compressed:                       38767.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          131.\nPages tag-storage non-tag pageable:            92867.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708928.\nTagged compressions:                          440855.\nTagged decompressions:                        363651.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-rope-probe-v1-supervision/receipt.json

Original bytes: 2126. SHA-256: `ceca2bc20b20efc6d119005509f0fdc879922c361f193ae86e40d56d3e24f8d6`.

````text
{
  "exit_code": 1,
  "failure": null,
  "sampled_peak_bytes": 79135416,
  "samples": 19,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22913728512,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70839.\nPages active:                                1070927.\nPages inactive:                              1090502.\nPages speculative:                             46409.\nPages throttled:                                   0.\nPages wired down:                             181896.\nPages purgeable:                                1604.\n\"Translation faults\":                     1123122306.\nPages copy-on-write:                        67985136.\nPages zero filled:                        1948954100.\nPages reactivated:                          93602295.\nPages purged:                               10847655.\nFile-backed pages:                           1326100.\nAnonymous pages:                              881738.\nPages stored in compressor:                  1146617.\nPages occupied by compressor:                 625258.\nDecompressions:                             23389282.\nCompressions:                               33136416.\nPageins:                                   625947950.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128190.\nPages tagged resident:                         89423.\nPages tagged compressed:                       38767.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          121.\nPages tag-storage non-tag pageable:            92877.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708928.\nTagged compressions:                          440855.\nTagged decompressions:                        363651.\n"
  },
  "seconds": 1.12053675
}
````

### vq-rope-probe-v1-supervision/stdout.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-rope-probe-v1-supervision/stderr.txt

Original bytes: 621. SHA-256: `e76dabbd9de33e57f23cdcd3c6c24c3f74a422d57303f6ceb742e82e96f43fd0`.

````text
Traceback (most recent call last):
  File "<HOME>/Projects/slotstream/.build/quantization-research/probe-vq-rope-v1.py", line 16, in <module>
    for fn,ref,inputs in [('pow',rope.inv_freq,[mx.arange(0,64,2,dtype=mx.float32)/64]),('cos',cos,[(pos.astype(mx.float32)[...,None]*rope.inv_freq).repeat(2,axis=0)]),('sin',sin,[(pos.astype(mx.float32)[...,None]*rope.inv_freq).repeat(2,axis=0)])]:
                                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AttributeError: 'mlx.core.array' object has no attribute 'repeat'
````

### vq-rope-probe-v2-supervision/identity.json

Original bytes: 2282. SHA-256: `44ccf693289b35610e9eecfe28d53aa7ca80780d74a88faee9bb5a23fdb2634c`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "<HOME>/Projects/slotstream/.build/quantization-research/probe-vq-rope-v2.py"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22945824768,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    71074.\nPages active:                                1070581.\nPages inactive:                              1090848.\nPages speculative:                             47321.\nPages throttled:                                   0.\nPages wired down:                             180631.\nPages purgeable:                                2082.\n\"Translation faults\":                     1123216816.\nPages copy-on-write:                        68000046.\nPages zero filled:                        1949004880.\nPages reactivated:                          93602455.\nPages purged:                               10847911.\nFile-backed pages:                           1327346.\nAnonymous pages:                              881404.\nPages stored in compressor:                  1144267.\nPages occupied by compressor:                 624944.\nDecompressions:                             23391419.\nCompressions:                               33136416.\nPageins:                                   625948274.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128131.\nPages tagged resident:                         89370.\nPages tagged compressed:                       38761.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          151.\nPages tag-storage non-tag pageable:            92847.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708544.\nTagged compressions:                          440855.\nTagged decompressions:                        363657.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-rope-probe-v2-supervision/receipt.json

Original bytes: 2135. SHA-256: `af1d6b5a066fde489032be50e54605c39435fa1bcfbdcf645d39531fdc12272a`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 154174208,
  "samples": 16,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22951657472,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70769.\nPages active:                                1070472.\nPages inactive:                              1093238.\nPages speculative:                             45331.\nPages throttled:                                   0.\nPages wired down:                             180623.\nPages purgeable:                                2082.\n\"Translation faults\":                     1123234955.\nPages copy-on-write:                        68001302.\nPages zero filled:                        1949018237.\nPages reactivated:                          93602455.\nPages purged:                               10847911.\nFile-backed pages:                           1328007.\nAnonymous pages:                              881034.\nPages stored in compressor:                  1144262.\nPages occupied by compressor:                 624941.\nDecompressions:                             23391424.\nCompressions:                               33136416.\nPageins:                                   625948806.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128177.\nPages tagged resident:                         89416.\nPages tagged compressed:                       38761.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          158.\nPages tag-storage non-tag pageable:            92840.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708544.\nTagged compressions:                          440855.\nTagged decompressions:                        363657.\n"
  },
  "seconds": 0.9593791250000001
}
````

### vq-rope-probe-v2-supervision/stdout.txt

Original bytes: 68014. SHA-256: `228c3acd4b0d16c6657f8db9a9caa0a58a92a5a04e77d11be2a63cd7b6ecf09d`.

````text
{"architecture": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87", "instrument": {"scripts": {"vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec", "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e", "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749", "vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e", "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb", "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8", "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34", "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472", "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"}, "packages": {"mlx": {"version": "0.32.2", "files": {"mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912", "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de", "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29", "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2", "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66", "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723", "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb", "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27", "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492", "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831", "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007", "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1", "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f", "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6", "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee", "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b", "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969", "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f", "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8", "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23", "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83", "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c", "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77", "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b", "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7", "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b", "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc", "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849", "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247", "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42", "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a", "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae", "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"}}, "mlx-metal": {"version": "0.32.2", "files": {"mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a", "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084", "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8", "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"}}, "mlx-lm": {"version": "0.31.3", "files": {"mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608", "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834", "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c", "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553", "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8", "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7", "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7", "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5", "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a", "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1", "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39", "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f", "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b", "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7", "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5", "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9", "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72", "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5", "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82", "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f", "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb", "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d", "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7", "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373", "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5", "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8", "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750", "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a", "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610", "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70", "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66", "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095", "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d", "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9", "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7", "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91", "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db", "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1", "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914", "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e", "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96", "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1", "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c", "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251", "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a", "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38", "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6", "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8", "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f", "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2", "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2", "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05", "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643", "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e", "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec", "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9", "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd", "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443", "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba", "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af", "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19", "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332", "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197", "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db", "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f", "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19", "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d", "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd", "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305", "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d", "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0", "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8", "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c", "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395", "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca", "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb", "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c", "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8", "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f", "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8", "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4", "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf", "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7", "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd", "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13", "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306", "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145", "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca", "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d", "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c", "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057", "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4", "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855", "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae", "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f", "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e", "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9", "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393", "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90", "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1", "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4", "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b", "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9", "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5", "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e", "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd", "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28", "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b", "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582", "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e", "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391", "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306", "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41", "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639", "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a", "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619", "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005", "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79", "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e", "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9", "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc", "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a", "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e", "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832", "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179", "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125", "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a", "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a", "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a", "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169", "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2", "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427", "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a", "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa", "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa", "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a", "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020", "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e", "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58", "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67", "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b", "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19", "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a", "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc", "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c", "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66", "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1", "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206", "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531", "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f", "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0", "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d", "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25", "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3", "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3", "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17", "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10", "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45", "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375", "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe", "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553", "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d", "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"}}, "numpy": {"version": "2.5.2", "files": {"numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b", "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11", "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972", "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a", "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2", "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6", "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb", "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2", "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926", "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881", "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a", "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0", "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476", "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee", "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af", "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627", "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b", "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c", "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78", "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950", "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d", "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5", "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66", "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2", "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2", "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395", "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf", "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605", "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5", "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106", "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c", "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49", "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417", "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8", "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca", "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807", "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b", "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e", "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332", "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3", "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957", "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2", "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0", "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81", "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a", "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea", "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d", "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159", "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582", "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af", "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c", "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2", "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d", "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224", "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec", "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a", "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489", "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67", "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a", "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143", "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a", "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31", "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d", "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847", "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f", "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f", "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b", "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0", "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf", "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477", "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2", "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650", "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1", "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd", "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a", "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4", "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc", "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41", "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111", "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008", "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d", "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a", "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19", "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068", "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72", "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01", "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c", "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c", "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099", "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0", "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a", "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761", "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca", "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e", "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6", "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc", "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8", "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446", "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe", "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc", "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9", "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca", "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288", "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76", "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0", "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4", "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76", "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669", "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808", "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987", "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a", "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f", "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36", "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2", "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b", "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605", "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002", "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b", "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33", "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8", "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1", "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7", "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1", "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284", "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c", "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24", "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5", "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e", "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310", "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf", "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9", "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9", "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c", "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a", "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27", "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c", "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275", "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436", "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5", "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714", "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550", "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df", "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822", "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93", "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92", "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b", "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2", "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930", "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca", "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c", "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf", "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07", "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306", "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf", "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5", "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142", "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406", "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a", "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795", "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab", "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c", "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c", "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8", "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537", "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e", "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74", "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec", "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0", "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7", "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a", "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0", "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d", "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822", "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8", "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137", "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37", "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3", "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576", "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681", "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529", "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491", "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6", "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873", "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4", "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4", "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281", "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547", "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0", "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09", "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f", "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d", "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4", "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7", "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc", "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3", "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9", "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e", "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e", "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82", "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f", "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7", "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e", "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36", "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6", "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d", "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026", "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777", "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386", "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb", "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599", "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07", "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa", "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b", "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f", "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0", "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72", "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b", "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f", "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d", "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b", "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d", "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e", "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131", "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4", "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0", "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460", "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771", "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116", "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd", "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e", "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48", "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb", "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5", "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545", "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc", "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec", "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862", "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb", "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939", "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea", "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195", "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435", "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0", "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292", "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b", "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074", "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6", "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4", "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874", "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792", "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202", "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292", "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c", "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc", "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f", "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b", "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c", "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79", "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4", "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a", "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af", "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324", "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46", "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780", "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed", "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab", "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c", "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5", "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e", "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74", "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4", "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f", "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98", "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004", "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3", "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c", "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca", "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2", "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f", "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d", "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c", "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781", "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953", "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e", "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5", "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828", "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417", "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425", "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11", "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2", "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642", "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6", "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5", "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718", "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16", "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782", "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c", "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5", "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9", "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53", "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709", "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4", "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47", "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca", "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917", "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8", "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f", "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2", "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824", "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d", "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3", "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396", "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25", "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af", "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d", "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6", "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033", "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418", "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84", "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352", "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99", "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228", "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca", "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82", "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78", "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b", "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9", "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0", "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5", "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801", "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c", "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc", "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b", "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b", "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3", "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639", "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e", "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0", "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5", "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945", "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b", "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f", "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45", "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931", "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3", "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c", "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213", "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5", "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9", "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2", "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4", "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13", "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e", "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37", "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557", "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc", "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9", "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363", "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a", "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5", "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32", "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498", "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049", "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7", "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4", "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0", "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc", "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166", "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682", "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482", "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a", "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e", "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196", "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed", "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a", "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723", "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14", "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5", "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2", "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392", "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759", "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee", "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe", "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd", "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe", "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0", "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c", "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4", "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94", "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147", "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1", "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c", "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665", "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b", "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02", "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff", "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67", "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94", "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0", "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0", "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509", "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda", "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0", "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1", "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796", "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3", "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5", "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14", "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297", "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54", "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"}}}, "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]", "sha256": "579aa5d127d0e019f205170f54b96772c4e45e845d251160de6ea64857a05af2"}, "before": {"page_bytes": 16384, "reclaimable_bytes": 22931226624, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    70198.\nPages active:                                1070618.\nPages inactive:                              1091008.\nPages speculative:                             47162.\nPages throttled:                                   0.\nPages wired down:                             181718.\nPages purgeable:                                2066.\n\"Translation faults\":                     1123221906.\nPages copy-on-write:                        68000782.\nPages zero filled:                        1949006928.\nPages reactivated:                          93602455.\nPages purged:                               10847911.\nFile-backed pages:                           1327347.\nAnonymous pages:                              881441.\nPages stored in compressor:                  1144266.\nPages occupied by compressor:                 624944.\nDecompressions:                             23391420.\nCompressions:                               33136416.\nPageins:                                   625948277.\nPageouts:                                     335949.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128131.\nPages tagged resident:                         89370.\nPages tagged compressed:                       38761.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          151.\nPages tag-storage non-tag pageable:            92847.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5708544.\nTagged compressions:                          440855.\nTagged decompressions:                        363657.\n"}, "memory": {"current_bytes": 154157824, "lifetime_peak_bytes": 154157824, "rss_peak_bytes": 119603200}, "results": [{"function": "pow", "mode": "fast", "different": 23, "total": 32, "different_after_bf16": 0}, {"function": "pow", "mode": "precise", "different": 0, "total": 32, "different_after_bf16": 0}, {"function": "cos", "mode": "fast", "different": 0, "total": 32768, "different_after_bf16": 0}, {"function": "cos", "mode": "precise", "different": 0, "total": 32768, "different_after_bf16": 0}, {"function": "sin", "mode": "fast", "different": 0, "total": 32768, "different_after_bf16": 0}, {"function": "sin", "mode": "precise", "different": 0, "total": 32768, "different_after_bf16": 0}], "fixture_sha256": "5c0e3a97132ec1dc1637f392470b0f47d4ba0d51003b96e4e2dfeeab4cc35ed5"}
````

### vq-rope-probe-v2-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-rope-reference-v1-supervision/identity.json

Original bytes: 2552. SHA-256: `cd3704e37957996576bb601a456a2c87ee7a85938e6c341d4f9e1f3275e8774b`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.venv/bin/python",
    "Tools/vq_rope_reference.py",
    "--architecture",
    "<HOME>/Projects/slotstream/.build/quantization-research/qwen4_exp-pr1788.py",
    "--runtime",
    "<HOME>/Projects/slotstream/.build/quantization-research/candidate-3.2/model.py",
    "--out",
    "<HOME>/Projects/slotstream/.build/quantization-research/vq-rope-reference-v1"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22928228352,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    40479.\nPages active:                                1066592.\nPages inactive:                              1129976.\nPages speculative:                             44176.\nPages throttled:                                   0.\nPages wired down:                             180474.\nPages purgeable:                                1678.\n\"Translation faults\":                     1124538234.\nPages copy-on-write:                        68090320.\nPages zero filled:                        1949977090.\nPages reactivated:                          93609777.\nPages purged:                               10854173.\nFile-backed pages:                           1357271.\nAnonymous pages:                              883473.\nPages stored in compressor:                  1141260.\nPages occupied by compressor:                 623595.\nDecompressions:                             23392708.\nCompressions:                               33136452.\nPageins:                                   627877130.\nPageouts:                                     336303.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128264.\nPages tagged resident:                         89602.\nPages tagged compressed:                       38662.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          294.\nPages tag-storage non-tag pageable:            92704.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5694848.\nTagged compressions:                          440855.\nTagged decompressions:                        363755.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-rope-reference-v1-supervision/receipt.json

Original bytes: 2135. SHA-256: `ecd6f5b10fe56239293d49a64f6c0aa2a67dd92b937e0a33f3485aa680860272`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 154469120,
  "samples": 22,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22926098432,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    20986.\nPages active:                                1066923.\nPages inactive:                              1147174.\nPages speculative:                             46030.\nPages throttled:                                   0.\nPages wired down:                             180503.\nPages purgeable:                                1678.\n\"Translation faults\":                     1124555840.\nPages copy-on-write:                        68091713.\nPages zero filled:                        1949990485.\nPages reactivated:                          93609777.\nPages purged:                               10854173.\nFile-backed pages:                           1376634.\nAnonymous pages:                              883493.\nPages stored in compressor:                  1141259.\nPages occupied by compressor:                 623595.\nDecompressions:                             23392709.\nCompressions:                               33136452.\nPageins:                                   627890721.\nPageouts:                                     336303.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128374.\nPages tagged resident:                         89712.\nPages tagged compressed:                       38662.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          276.\nPages tag-storage non-tag pageable:            92722.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5694848.\nTagged compressions:                          440855.\nTagged decompressions:                        363755.\n"
  },
  "seconds": 1.3099293749999998
}
````

### vq-rope-reference-v1-supervision/stdout.txt

Original bytes: 68157. SHA-256: `adf5688a5d6e8baf96f6fb88e000f050f7912e5585f62f0b5cfec4323e503d73`.

````text
{"schema": 1, "producer_sha256": "749964ffbb5f4304b8216e31411d175dfe0aee02d628c9a87f57693a5a49f363", "instrument": {"scripts": {"vq_model_reference.py": "d715d396362bd1ff52ee4e5327ec260f17156d564fc97542e5a3fa79eefff8ec", "vq_ple_stream.py": "8e784edda032ac88dd8771e3e6337f8a59e78e14c5b8845c6e7808642f5ce33e", "vq_fused_reference.py": "0b7c71fbead91611460a5466f3082ca576301e95766dcee69bb82476feb85749", "vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e", "quantization_inventory.py": "af0220f7dde0b783fd5800ed2f0ee5545ed30bd855cf6d34d6a79820c9ef47cb", "quantization_quality.py": "99c99d16ee7bbb8576156fe5e8971a74ce243642bff240f855613c3ec0d135f8", "context_qualification.py": "094b567ccc21613444cfd0edf098967bb758af42652be8ba70762ae313cbbf34", "prefill_bench.py": "000868d66f82cd1eba5973c0fa9b4259831a6bdbc5bcf7d4c4f858d86c71d472", "memory_gate.py": "fed53adbbc761457f94e11ded179915d538b515d448dc029ff3f0604f7faf6fc"}, "packages": {"mlx": {"version": "0.32.2", "files": {"mlx/__array_api_info.py": "67bd1bf52f853f2ea96fd6d4f0c64435899f36292290e3d528327a799f863912", "mlx/__main__.py": "957f513bd1c40f9b8d6cf51d676aa66618bf59b40fa1278ba339a87799c318de", "mlx/_distributed_utils/common.py": "407793d67635491c16bd37ce2928a0ba8ff11c0478110878adae79a3fd406e29", "mlx/_distributed_utils/config.py": "82e17f9c0322b2875ee975196399c7c4ef662694ea7bff39af0484cbef3023a2", "mlx/_distributed_utils/launch.py": "6a85d23ed3e505cb1d410d18139ae61599f6805f6ee2b98a1030a28d8a5a7f66", "mlx/_reprlib_fix.py": "f748ea4f10995bf30ed6ba76ed3539f23c18cdf541031e1c0968dd60dc98f723", "mlx/core.cpython-312-darwin.so": "5ff77c777a73864d2af86defd61b141467746636f0047b76b66a7ae645fa12fb", "mlx/extension.py": "ccab3caf8660bf6b43ec949f147c64bac95e914ab8cab6a8afac090d69aebd27", "mlx/nn/__init__.py": "6d578784bfe696a3ba6eca2a559c87e9fd1ec5eaa5e6d4e199e6e959ebe0a492", "mlx/nn/init.py": "c6ef640bf114039d5c6c5f2d0d9e53675c171ba1456beba20278c9cc12922831", "mlx/nn/layers/__init__.py": "1eb646e38a87579eb63201100c3f9b038e2466d7fbad509c2f32841bc1f2a007", "mlx/nn/layers/activations.py": "153660ac19d4fe93d6ca15f67ad8527ed03b0e860e36192f3815e1d3daf73ed1", "mlx/nn/layers/base.py": "ec749e1d50fd1a5e57e0aedc8e6eb13fc697e630f59333a0e24aee62a8dc7f0f", "mlx/nn/layers/containers.py": "29ef203c13d9bebb6b8cad6aadb44d1ad495e2bbc19184ca5415b6a505eb36f6", "mlx/nn/layers/convolution.py": "d79473462d907735740352bbecd74b961049b55831be4d4369966a68ed325cee", "mlx/nn/layers/convolution_transpose.py": "a47cbf2bffebce18a9858d7850a313504fb02fe452591ff5ae4f8e3d2d464f7b", "mlx/nn/layers/distributed.py": "67e4048ce29b4caf8df9c5ea8ee758e05ac682ee1582e2004c7d9557f6c89969", "mlx/nn/layers/dropout.py": "a79c13d31c61163587d83c58f4e4cb81bf24f32923994abd3d98d9dfdd59148f", "mlx/nn/layers/embedding.py": "f77b039903294c6e880c503a953ea86b43aac36661b724cc9c38e3ed1969e3a8", "mlx/nn/layers/linear.py": "07ce0d9ac6a1499a0d0f01971bf195305424b6d91a20f77488f7d8116c0a2e23", "mlx/nn/layers/normalization.py": "0873ca425d5de6dd462d336ff45a2563f945abeebef3f5146bfc7c83af54be83", "mlx/nn/layers/pooling.py": "01e25b975ea6c8c962a8d13f748596a3390a94e9a6d1d5e9d973347697d1509c", "mlx/nn/layers/positional_encoding.py": "613835daf6977ec6e0c34159349d68ddcc234958e82d18adb159d7a8bf9d0c77", "mlx/nn/layers/quantized.py": "1797a3571484ad3134224354b7f130c0931f495691aa8e54eb55329d674bb00b", "mlx/nn/layers/recurrent.py": "553738db5ffede77d4d97a6b431ac82475b99c34902a9a32e05b940a95f34ae7", "mlx/nn/layers/transformer.py": "4d1b35213d4895e86a3f124d2f0c2d99b64ce7f3c208b884cc13edff0997e77b", "mlx/nn/layers/upsample.py": "8ea1fadaf6101899d30e18b3f05b0f8618048c835c42d972cb43a334bc57b1dc", "mlx/nn/losses.py": "10b5439bf1a9ebbb6e5f0dc115efc01a17bf1edac0e746ba564a09ada15be849", "mlx/nn/utils.py": "55aab8b6d6cad221f7f6f4c400b65e9f82cb84fe5cb17b82fff0219718dd6247", "mlx/optimizers/__init__.py": "289a7bcf845366d2f823be75cb25cd8745ad9d8b2692ba1fd7b72a084f71dd42", "mlx/optimizers/optimizers.py": "57501691b4cf5e16cc4edd738f2dd358305e6c54bcd4bb93c7d10144d09e2c3a", "mlx/optimizers/schedulers.py": "4276bf0907e24701bc22464a73620fd30d27bd63eb6c9ccb3168a621c9ecd9ae", "mlx/utils.py": "c33a787a429a2736eb10783b087931cdfd0bab9edcf0ad57d48bcbc33b9e49a2"}}, "mlx-metal": {"version": "0.32.2", "files": {"mlx/include/metal_cpp/SingleHeader/MakeSingleHeader.py": "5b87e3f4aebe564025f5e4120258a797ea77fdc92c0b5a2d7bf84e835769ad5a", "mlx/lib/libjaccl.dylib": "9cfd72679ff35c593a1d46fd30d995cc4a131eed15733617efb1118001e74084", "mlx/lib/libmlx.dylib": "d24c7a9b9d55a76bfd3bbcd1d042251a185cbadcb6340c3244a6ffa3dcb7c7e8", "mlx/lib/mlx.metallib": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"}}, "mlx-lm": {"version": "0.31.3", "files": {"mlx_lm/__init__.py": "f9ffa88772d26e537a98aa39ab16488a7a0d13cc1fac5d665376132c94b49608", "mlx_lm/__main__.py": "cc0a2e7be2522fa62570799088414b6da673369cfc6ebc75d1fb387f29a24834", "mlx_lm/_version.py": "f0da9bc5c5c1bf21d576f7aa67b4eda887f1c7f0666746187b493e6831c4af6c", "mlx_lm/benchmark.py": "31ee1bfff33bc7b87adc94f746eab8f3a6c537a286a7eacf66748875eabd1553", "mlx_lm/cache_prompt.py": "b2f561f47e177367499be07aa92214a70d30220a84a126a5460ab51ebab25cd8", "mlx_lm/chat.py": "f3d9ef0cc6dd5c2ce308f7f1b1617a4ce616bd65849de27a6792cdc25a465ff7", "mlx_lm/chat_templates/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/chat_templates/deepseek_v32.py": "4df892725d65d936044d70d365e9a78eb0e10f201059120c7b0b965e66f669b7", "mlx_lm/cli.py": "88212797d36748052adc7a7104fe51d0b45ed322c78075e6bc1b10064ee37ac5", "mlx_lm/convert.py": "dc60df164c2d51ee2f05f5f9f3324bc3a44a59dd2ccddb75dde680e854ce5e9a", "mlx_lm/evaluate.py": "15b2ad60db63f49c4f4300dad4cf5658652fe57cff94c94606ffa9d669a4f5c1", "mlx_lm/fuse.py": "610321cd10016ee76fcc1617bd25d753b9a66a8980d0e296ee9d18f5f901ba39", "mlx_lm/generate.py": "270778ad53eaca55a8533d82e6752660fe5d2605c4aa0879b48a50a91f69345f", "mlx_lm/gguf.py": "56b35b6f5942ff184ce9e756c94cb0e6a1d85e094f5f52ed6232d8c48cb2247b", "mlx_lm/lora.py": "3f188fc6aef80efcb9938678af0548588122ed25845053cc555aece0ad2da5e7", "mlx_lm/manage.py": "fcf74fca1b5ee12827c1104a28dfdf11204e1672ab2fdc10ed7cce51a3fdbed5", "mlx_lm/models/Klear.py": "ace3e8656ec00d25b89f1fbce69e7cdd4fce4629fbae01dfe7bb945c13b611c9", "mlx_lm/models/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/models/activations.py": "dbca5bae41ba0a8380a53903c3e98da37c1e15b46383bc2edb5806ba94fafe72", "mlx_lm/models/afm7.py": "04aa5558f761b7ab29798c64286e1cdd6f6580f88301cbf920c0a6b2fe1fd9f5", "mlx_lm/models/afmoe.py": "614473752ff0f341cbb5ebef90bcd3b8845f61125e860e4b081c6ae4454edc82", "mlx_lm/models/apertus.py": "b2e01af3c9a413fc3eecd44b417858cf9f7f19ab7258559df01aed1983ac126f", "mlx_lm/models/baichuan_m1.py": "720fbfbd794f8ae4196a76d58acbaa3174e91ab52ac830962a709dfa458eebeb", "mlx_lm/models/bailing_moe.py": "7ec47d3be0c4dea8c808b08dbf0cbfeaf6e407c156f453f281e702e43b7b359d", "mlx_lm/models/bailing_moe_linear.py": "ed69bdb69655f3160c21611d498b3a76f3c5da63aac16cfc2519d342f74887e7", "mlx_lm/models/base.py": "61330e1c065739cd712bfeb09d673f33797cde7e613e95bf6d9ebbee9006f373", "mlx_lm/models/bitlinear_layers.py": "fe64bfff02b300d965a560e33792dfd93ba4f86a121d18679f5f8550d86cf5d5", "mlx_lm/models/bitnet.py": "7326a010bdbb749b07d21b1ed102ea8481187ad540b3f3fcf28673f2dfcdb7f8", "mlx_lm/models/cache.py": "819ed95dcbf755652363cfdb15a639890447abb534a06dcefd52c7fff5055750", "mlx_lm/models/cohere.py": "34f3a144e830a1b177d5883e2443bcc8f517c8ef5f3ada512f42fa3e64393b5a", "mlx_lm/models/cohere2.py": "8d3f343f1bb7b8ab0056c30154fe35bf3545151693c1aeff409f6903f4efe610", "mlx_lm/models/dbrx.py": "b6f61442ae508f555f19c96116b0d5798fe0366b2c2c1f9fcb66444d25e69a70", "mlx_lm/models/deepseek.py": "4345ee533236ca9b92c655e4e1b77f969380cefbeafdafcfa2279c58e2101b66", "mlx_lm/models/deepseek_v2.py": "08b944cbc3398b4b4c8798ad33804fa8dcff630b2858eda73d071295b839e095", "mlx_lm/models/deepseek_v3.py": "7d1c6cad01368c3f5e26d5907fb2910145cbeaf867991f91a136d16572b8e98d", "mlx_lm/models/deepseek_v32.py": "a829f0a505d9fc56c54fd95c93bcd08e011ef2fd75b11fb00941abc2f34183a9", "mlx_lm/models/dots1.py": "682ef8f43b4b1d5c4c196263b311b7cdd68b2a209fc0202bcc442cd0c8050ef7", "mlx_lm/models/ernie4_5.py": "34df71212f9ec0978bf685a90cb6c63107f1a1ec958f4acdac0d3867c2c34f91", "mlx_lm/models/ernie4_5_moe.py": "4bab223f3d8f8b09bb15cd4aaf0bcffd07ca3556eb4bb771f268377ad83b81db", "mlx_lm/models/exaone.py": "d4902d790ed42c6edd1fe7494e9800869470ee95bc93024536f688fcc88a2cb1", "mlx_lm/models/exaone4.py": "fb7f62b3f2c6e5519e5d90e40506d81c030042bdf2e90d040ecd3b9626f34914", "mlx_lm/models/exaone_moe.py": "0df4f9b87ecf8ceb4fb202de5c285eba50a1a9c6363ce13cc9c893d6b298513e", "mlx_lm/models/falcon_h1.py": "b888a9795a36d4b92868f7a2bb1e8850f877c45bb81e65fcb0e6e271a640fd96", "mlx_lm/models/gated_delta.py": "79c8376a51c694b03e54d2f996ced6ea6c8c42868b8571529f97334db165a3e1", "mlx_lm/models/gemma.py": "8bd836c39701aaaaf615e7089e46965a41346cb415a8f32b02bcf5ce2496bf3c", "mlx_lm/models/gemma2.py": "64b0935b06fe2c4d5d4ed23a9cf62deb6218c55a88b9403a657afe9e2be8f251", "mlx_lm/models/gemma3.py": "69d321648629b0f22e8cd9f3c3b597af6f34b5405c761ce089e825deebb2939a", "mlx_lm/models/gemma3_text.py": "884bb398288beda5e90caf3de60a15f5d17b8e383d28c85cca07de1e0aeafa38", "mlx_lm/models/gemma3n.py": "5278b3075e5d07db69bb5c0db52fe4e2ce9d345524aa97496040803db6d8b0d6", "mlx_lm/models/gemma4.py": "4671e4a63cb9849582abac566599a0a85370a46d410f4ad69d81a88788d00fd8", "mlx_lm/models/gemma4_text.py": "77f46bc3f162a0b9513157dade4be2c381d4df3295262c69034a53d46111370f", "mlx_lm/models/glm.py": "a122242c74beabed8ab1ed7cfc60f8b7891f71d69e1ecd9a25206f4493751fa2", "mlx_lm/models/glm4.py": "d0971768b6cd3a3a9b7d54b0244ef2fa92c1d511124fe8547e6f51f3ddd96cb2", "mlx_lm/models/glm4_moe.py": "f0d9a42dff8413730d9fbce375e158c791210339a383935da8afd58758aa4c05", "mlx_lm/models/glm4_moe_lite.py": "6d4011ff91837c5f29bf4207bad6665d981d8b0fcbd159289b6cd2b96fa72643", "mlx_lm/models/glm_moe_dsa.py": "bfe16d1ef63f919b47c96a4f7cb2359afb46127769c75f62e65339510c0c936e", "mlx_lm/models/gpt2.py": "ca20a95bf371428b78c5f8a959a41b8fe85acfbf2e5424acbc88590a9f2053ec", "mlx_lm/models/gpt_bigcode.py": "08d2e98fe4c4b43340d40f6496cae23fee9e295ce293b7ac746c9432951f3fa9", "mlx_lm/models/gpt_neox.py": "e23b59ef46431c3e8244c12a774c35633704f5495687dda017b156aa039043cd", "mlx_lm/models/gpt_oss.py": "a71c0402bcdf9495291ff1efdba02dca2dfc9c4c821d81df460ba4bd6cca3443", "mlx_lm/models/granite.py": "a12410cea370422007b54115bb0000442d5a60b0697aa55b1979ec30a80d97ba", "mlx_lm/models/granitemoe.py": "26186a3e66429f38900164764a9da8f0d9a32e7ca30941607bf65b69d36415af", "mlx_lm/models/granitemoehybrid.py": "a9d4214a84d2ecb998d3ea00c6ff6de82c2b5d0a08680149739405f4466e0a19", "mlx_lm/models/helium.py": "a8607988de77c5f51e6a02e6532ea28b600529a0be804003c2cc605b9fefc332", "mlx_lm/models/hunyuan.py": "dbd7ee128dd4ce28d40d301ee4744f303e47c0443ab17885a1b08bf3745b8197", "mlx_lm/models/hunyuan_v1_dense.py": "8303eb6467e43263e557199c13df69986c24e4917d91b0acab18a5076e6327db", "mlx_lm/models/internlm2.py": "070a55600e9503e04750b6204b09e2823d59c723787a22f5eabf8416c99dfe6f", "mlx_lm/models/internlm3.py": "fcc962ce1b3d4b93c08e9b728ce4e4c26679b60492ca6ec388001b36d00e3b19", "mlx_lm/models/iquestloopcoder.py": "c2bba6a7a7f224aa2acf5d812a44484ec10fcb6bffcaf0ef1929cda846d1cd9d", "mlx_lm/models/jamba.py": "f0d5e5551127179b79f10dff764aeaa70ab3c1fc06e71487a25ad414561f28bd", "mlx_lm/models/kimi_k25.py": "5388e4355775549b2bacb47ac57c2e4e523673ec789fe524859e26790421d305", "mlx_lm/models/kimi_linear.py": "37bed1dc098c455ebb6e0eceedf9374ef6314a78b7f25b0b2c87828fc3fb2c8d", "mlx_lm/models/kimi_vl.py": "2d4bdfbb6303828b42264039038f9500a9aae1f7f6a040d1b8c48891f79cc4e0", "mlx_lm/models/lfm2-vl.py": "1ec76d720051d56b186bf1703ade5497eb29796fcd3f3682a68d4968556a7ec8", "mlx_lm/models/lfm2.py": "5ce16a8231800fdbb842ea7e603754572d5608cda0f3ef8c61c862840d18806c", "mlx_lm/models/lfm2_moe.py": "4cb248cd8d1c8ff279efb77b6fa3ef93dce96771850933f41b0f3669a6377395", "mlx_lm/models/lille-130m.py": "971390eaf6d5d4761460e1b5852ec3351da27248aa4b18442cbae6792c1accca", "mlx_lm/models/llama.py": "8b46ac7f11c7134c1d83f12ec6e05b3d64a30f18aa7468798437b2e413f80cdb", "mlx_lm/models/llama4.py": "6386b73f86adf88de756c1198623235119d9c10af32c6ed9a676f341ad55654c", "mlx_lm/models/llama4_text.py": "f6ce3838b18bb6d281de84694639f483209019b1da4bdeb82848909d6af84ad8", "mlx_lm/models/longcat_flash.py": "9d801bccfc1081fd34d32b5467b1cf4eb0356ea3563d4e7b87a5530f1ac54e0f", "mlx_lm/models/longcat_flash_ngram.py": "9fbda1eb9787f4f03d99bb788e6f171922ff6da1a469a060fcc68286844277e8", "mlx_lm/models/mamba.py": "3de6e1dafb147bfc346205df07a298f1623f843ff0e06835cb21d38360ec7da4", "mlx_lm/models/mamba2.py": "36d6841678e32dbd132cb1ea94d068f88779287350c58d4b2de34b1317af0fdf", "mlx_lm/models/mimo.py": "1ec3ceda0da736880f7879fa1b9bc3a82982d48d6502d807bc3a1bd59b67d6e7", "mlx_lm/models/mimo_v2_flash.py": "1c0cff7c66fe6cf90b569f787b1f8f25fa8fce582b74de77f13b854c246407bd", "mlx_lm/models/minicpm.py": "444c3c1606cf0f590e661505cdbad4e56a81c769275b16c67ba9471333db9c13", "mlx_lm/models/minicpm3.py": "b63fa19d1219ab877e4ab104082f8dc2fc7117ced45abf036c90b19121f34306", "mlx_lm/models/minimax.py": "23596bc95ea66c88a79f3e72d220cdd156df7a549f0ed29f917deab8941ae145", "mlx_lm/models/ministral3.py": "658de236349540794672fa5526049222d0877edffc43783a9208f483f4fa5dca", "mlx_lm/models/mistral3.py": "38b9603ea56130614593a30eabd87d32816b7aa05443af817c1439174786551d", "mlx_lm/models/mixtral.py": "a7d15990aa42b81b659c8679089b6f1571225466825c71d9350eace1964c3b5c", "mlx_lm/models/mla.py": "22877b336255e58d949d982b6ac4730bd0ca1a1a6f40479f736570b3c9f35057", "mlx_lm/models/nanochat.py": "989d414c4c8c3f1ae0d2d9b06c06d45b7dc5fc0bd8b796f585e318586b27dfe4", "mlx_lm/models/nemotron-nas.py": "05b40ddd35fd5b829172b2e40ce9674a787623e5bbb26c55d45ed31f5734a855", "mlx_lm/models/nemotron.py": "1ca8e8bd88d450fb03ba1723b0376a3199f2a92db2e8a3ccdc512b6cea492bae", "mlx_lm/models/nemotron_h.py": "47143633f5ad663aa6834a18be69520ae4d588371e392bcdfdfad898b2571b1f", "mlx_lm/models/olmo.py": "cc4cc1097d73449ae22ee2dcf637d6e68b5f11c0482e75261f563b46c41bd40e", "mlx_lm/models/olmo2.py": "f14a7484ebf584fdd92faefcc394b1064ffe1828b3b7fd75267de38b1b50b4a9", "mlx_lm/models/olmo3.py": "ede2b37d41cff6f73877e8ab4174e9eac10dc37b49962f03c297fe41d9a27393", "mlx_lm/models/olmoe.py": "4f8f78d368666ad0bf396963cd094bdf48caeec45d7a188c299bee7fc4bfea90", "mlx_lm/models/openelm.py": "5e188106d087d4bae2c009c00cc965ff74a5d6d84e1c1b0cc2aebb145708eea1", "mlx_lm/models/phi.py": "93fe4a0f016a55ce225023c703ae34af3e184e3241cafe7140eb688c340a6fb4", "mlx_lm/models/phi3.py": "55824e3cc8ddf3e092be202b455bfa423c6abfe43199b24df39d089abf83964b", "mlx_lm/models/phi3small.py": "97e71c9a3b879f5892056cd0ff59613f645c8a883df738b63cb41a8787adbfd9", "mlx_lm/models/phimoe.py": "8d1ccfadd2ccd81cd259d7bfe5cd218a8652d77ba2d76f45a596406248c0c2f5", "mlx_lm/models/phixtral.py": "8987cd1716e7ed32ea7a617dbad7a7a82d7ee63ed865cff0e45948848553dd2e", "mlx_lm/models/pipeline.py": "b2bf11a2990f75243f1964d5f8c9aad5842dc69bc99c9028fe87e60788ef0bdd", "mlx_lm/models/pixtral.py": "cbccd51a330e724ecc9e98399006b965db5ae7f8fce0698ab03354c6ad119f28", "mlx_lm/models/plamo.py": "a3fc5fc6d5648afc8db21cb28ebe1885e69ef8b32edf044e636dc4a4a4dda46b", "mlx_lm/models/plamo2.py": "b698b92ec4497ddcb4ab2ce29d54332e30ba76665276ff0681dfc01622d8e582", "mlx_lm/models/qwen.py": "27ca9aac6c6d1819c51f7c0f49f352d03b2e508e0ab42200b5a14d514320d02e", "mlx_lm/models/qwen2.py": "30d38786f3c598bf58c1dafcdffbeac6f3c507442bde768944350c57222cf391", "mlx_lm/models/qwen2_moe.py": "ebd2e5ea63804ad4279073da6d2a6ff3919af2c36a4e1586a7de23cd390fa306", "mlx_lm/models/qwen2_vl.py": "c6338e4dc1135cd2a5b07a4496aa6d2ef72fff32ecc58cdfd91872fe073d2a41", "mlx_lm/models/qwen3.py": "2284df96ecb669109b281df4534470b18f285aa9a5e41735ad682f601f93c639", "mlx_lm/models/qwen3_5.py": "f0daa30bba5cb521c8bdfa7093101a544c6a37bbba09bca582288219cb04ae3a", "mlx_lm/models/qwen3_5_moe.py": "ef9e8e1f6a5c097b29587c8330e8eb9c9cbdc52fbb4597fbc2362606c1996619", "mlx_lm/models/qwen3_moe.py": "539a201316616d2296a15a0998859e8bc0af36d8433d6f78ab0c46beed51b005", "mlx_lm/models/qwen3_next.py": "3c572fe3fbb36721efab4d80d1bb6af11beb4ad1caae18deefc9fc84cbcd9b79", "mlx_lm/models/qwen3_vl.py": "d4344d0a3681be91e59a8c0823a0ae58e9bed16da531565c360389976a62bb3e", "mlx_lm/models/qwen3_vl_moe.py": "aed222b12c86aa0472288db6d13e0536a6bd06b61dae5850afd7abb8c2613aa9", "mlx_lm/models/recurrent_gemma.py": "7446b3cfb9f77c30aa056a4f4449f48991f84c32ba97ed370fc25c3499052edc", "mlx_lm/models/rope_utils.py": "9f68c938c040fa111d13f2ed95c70e8261515fb3b54f8a0a474c096baf4e087a", "mlx_lm/models/rwkv7.py": "be2b710ed17a417e1f80d4b6f28cb6a61d2cbaa917a348803105902df72cc29e", "mlx_lm/models/seed_oss.py": "451a32421feaae71e6508b0ecb6dc8fecdcaf2e1f9ce7347a56ffea95c871832", "mlx_lm/models/smollm3.py": "89bb60ff0fc8bc5e04dbde5375dd2475aae8e75e5c792b93f85217b99f594179", "mlx_lm/models/solar_open.py": "fbf6c1c57de579e3322978464aebb8cddce77718a396cb18f916efa999328125", "mlx_lm/models/ssm.py": "404adb47453e176d1561f1efa5eb09c1c0e58e78defb15c25cb40f6d7aa7890a", "mlx_lm/models/stablelm.py": "7788eaa5dcd78d174a4229076af2cba0a0e37657712d62487e4f28932e26d64a", "mlx_lm/models/starcoder2.py": "c18e1c679ba5d16910600bc2c6eddcdcb91811bb38216bfa5de8a7daf076f64a", "mlx_lm/models/step3p5.py": "ced87a3562463f8a4657b51106fa97fcebce0b5b23c80ae0430ec9edfb7e6169", "mlx_lm/models/switch_layers.py": "073a6a808d5c90bb699a2ecca0e559b06727ae96dbc1f0253e4c7e77e4ee1ef2", "mlx_lm/models/telechat3.py": "14ce1bf6a19044265873233edd65e37586704c85310cfcb756a109b679e6e427", "mlx_lm/models/youtu_llm.py": "cc31f3bde475530f0388d18e99bb50b7fc54248cbaea9d0720f7983d38cd444a", "mlx_lm/perplexity.py": "8146c8da1bd6df6b2edeea6c1dab20ee8570c0f13e095479b1a16e85528b3faa", "mlx_lm/quant/awq.py": "04834a6d2447626557ca3c05d82140eae9480564abdfb1507a600b76e8ca84aa", "mlx_lm/quant/dwq.py": "9a70448d4e5f3d20efc4e70bbbc91ab311fa42479f703077d55d3af75231c72a", "mlx_lm/quant/dynamic_quant.py": "c1031bd9b2046a93fe3ffaa991001055a7b591f29b549cc1ed5959ad0bc87020", "mlx_lm/quant/gptq.py": "8ba42877f45e86262146c6c962691c19a819478b561f55f04371d28ae3a74c9e", "mlx_lm/quant/utils.py": "fbae54a7e39b9ae999bedfebf833e865e6912bada29f4c3fe53383b9d8655e58", "mlx_lm/sample_utils.py": "c0ce439f8dbf0d4e6d0f37f728a324f3f72878e6a9123df41be520804c596d67", "mlx_lm/server.py": "cdfcb4ac848636f9927851a0ec7a951584526530cb7832ba58049e4a9144db8b", "mlx_lm/share.py": "3c25e46d4b413d67cf5bde546f47d09fbcea9ccc446e878721543af43cf91c19", "mlx_lm/tokenizer_utils.py": "25784bb03c922d0d7832ce6c66a6cd4eb3a4820b6c5a8e583dedb63a018fb56a", "mlx_lm/tool_parsers/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "mlx_lm/tool_parsers/function_gemma.py": "b8531d412cb87d1ceaecd5e2d15b162ff8036e093a4daa9e3f872d005191defc", "mlx_lm/tool_parsers/gemma4.py": "8806c0593a9ababb7f8617a2ffcb9c50f19a0cebdf659124691adba6e09c826c", "mlx_lm/tool_parsers/glm47.py": "4007036f3b6440aea56cac6cd2f5ab590b9be941dacd630ba9c01e5f67475b66", "mlx_lm/tool_parsers/json_tools.py": "398c044ebd6bbb5578131d57817753d70b43803da509c14d12a2591e01d9cdb1", "mlx_lm/tool_parsers/kimi_k2.py": "7d02c9fef2b43d18b5b74261e774943d0ad85a05ea50b92764fb1ee821976206", "mlx_lm/tool_parsers/longcat.py": "dcf25a84edd35b92b7df8dceef424e12930828159ad315a67dd997d90f2fc531", "mlx_lm/tool_parsers/minimax_m2.py": "db2bd5cd0286ca66881bf363612f65c2a42d0d681d8f1a5e9b442f847066e60f", "mlx_lm/tool_parsers/mistral.py": "df143d4bcadadb22291b0d634f485c714065d973aae129f0b6ba789e81fc92b0", "mlx_lm/tool_parsers/pythonic.py": "14cf949cac8ba3ce7366fa9f692213f300c1103db5642b4c56af67ca8f0ef13d", "mlx_lm/tool_parsers/qwen3_coder.py": "32de6d9f7472a1f00a2acfaacaf13e0e0864cfc19adebbff688ac5004b8ecc25", "mlx_lm/tuner/__init__.py": "a03c637c7952112a09906b6e77caf5dadf3aceeb1c2716fd10b01afd318673a3", "mlx_lm/tuner/callbacks.py": "dd1e5e7641c3271ae33cdd53bcebb99b67c3d1471a4294b68afd6014dda77ed3", "mlx_lm/tuner/datasets.py": "fa112840e6ea98a4ff18428792fe2ab023999c2da51ea64b3ebdf8657a152f17", "mlx_lm/tuner/dora.py": "b2f2d80bc5091efcb56916157b0166210aca9333fd20a621ed04ea53bc45ba10", "mlx_lm/tuner/lora.py": "4d3a8edab111d4ddba33398ba8700203db7b61621c39e9c348fdd50e57278b45", "mlx_lm/tuner/losses.py": "f5a039f681a8727f47ef3a7f073b5a0813182d6b1feaa22e2d697eba6a9f4375", "mlx_lm/tuner/trainer.py": "ee33ebdbd20a184108541cb490d08085485e71a82ffd6d68d7d216029ecd28fe", "mlx_lm/tuner/utils.py": "166eaf5e5f923113bed43614a5fb7319795fa0cac5a7fa319ea54e5f0045b553", "mlx_lm/upload.py": "d25c543f54c58bdcf755ceeea9d9dda36169a704e2754ea1075fac119038eb3d", "mlx_lm/utils.py": "ba0371e9c88d52b34d71271945c2394005fbcb2bfb2ee9f6f82d627a33b72422"}}, "numpy": {"version": "2.5.2", "files": {"numpy/__config__.py": "902479a9549d83acadad6179810f40f79630a6a7b82801e79b306dba34648c0b", "numpy/__init__.py": "09295a80660f17925ae23765ce8cbd7ff7ceae968d5f2f89349f1cb74c0b9e11", "numpy/_array_api_info.py": "4332889405b9c5b4f946d761086346f58c0acb82bbfb5f9180b30d5520b5c972", "numpy/_configtool.py": "105449de96b34f162113da29fa8716c8a4cb66bae91617e6992fed5ababc0b1a", "numpy/_core/__init__.py": "837ce8aec8693095d2e1c7c306d385d1785a50be97a009935c64cae04e3555d2", "numpy/_core/_add_newdocs.py": "2fc06f2d919b16afc1e1f1abdb161bdce9eedafe3e07f127bb0f45b0841964c6", "numpy/_core/_add_newdocs_scalars.py": "db6f2b889f9dcfd7d5df64ef3a430f532b3fdbfc279c3b94f8451b1757a16efb", "numpy/_core/_asarray.py": "f5aa779032cd51c8ca49039fae454fcebd2d64647513576d0884ff61e68525d2", "numpy/_core/_dtype.py": "59a285cabfcef070f8c3e6eaa15c1d4fde4791983e374e275944fd638c11f926", "numpy/_core/_dtype_ctypes.py": "28f3e56a40ec3e4b938523abe6a1705b48c9f559e36ef5b811684e6c21d81881", "numpy/_core/_exceptions.py": "5fc120d61ab5b94f0bf7088ec05a368d1aba4b4be78c27606051e3de1016f42a", "numpy/_core/_internal.py": "497f1ce325bcc6ffc2ccf013e2cdd2ff2e32c55106a0a07997213d45d6c777a0", "numpy/_core/_methods.py": "724facf7e63c5b8fcc2fac14bf31a02cb048d9e28f516d86502ba5077a425476", "numpy/_core/_multiarray_tests.cpython-312-darwin.so": "20c3c985bc0bd6bd8a0bee5198083aa6be418f7994471f83a5cb7ee2119c6fee", "numpy/_core/_multiarray_umath.cpython-312-darwin.so": "359e4f56a73e02b63b00e9d8e0b4190e1a8cf2a1dc6351c83c7eb2f76c4e16af", "numpy/_core/_operand_flag_tests.cpython-312-darwin.so": "e910e6642301f2f28a986d819a3249d5d1013b2ee6ce4e5e9a95082ecc4d3627", "numpy/_core/_rational_tests.cpython-312-darwin.so": "73d0f8c90654dd97fa2b0ed6c45882eb8fe83a8c4256e38bfc31713e5e07841b", "numpy/_core/_simd.cpython-312-darwin.so": "e1323e4eb0f2ae78cc1c47d7ff374f7ac39b6e06b5490ae54bfa639816181f7c", "numpy/_core/_string_helpers.py": "e929a0a22ea80f60ae9e3c014abf41676d079029ef5ba9d33db953394de95a78", "numpy/_core/_struct_ufunc_tests.cpython-312-darwin.so": "24218eec682f48246b450903e270be19eca1c6c2d828235ddef29949f2cc8950", "numpy/_core/_type_aliases.py": "fd576d1516aca4b752b374a3b448f03a9acc6b748243dd72f89619f7b300344d", "numpy/_core/_ufunc_config.py": "0e938bb63600619bfe9028e8f285f9ddcd925b62d0220690ec4a650a48ac45a5", "numpy/_core/_umath_tests.cpython-312-darwin.so": "1c55454c29a1a5f500fc22cf095e862b0af0f17e14c2a1fbe7140832c21a0d66", "numpy/_core/arrayprint.py": "ea1e7577acc4048383d842a628827e33dc544f06842ab5848b3ee3bb298eaea2", "numpy/_core/cversions.py": "1ff88d229c7dfa1635710371aa34f677fe525d98496cca3f71aab8feae8b07b2", "numpy/_core/defchararray.py": "a174cd2354ef6fd8851d51c6f5b43f3fc836a344d1a37fa9600060387858d395", "numpy/_core/einsumfunc.py": "4b4fc2d54ebe6b533f680fde2fa468d30449c2d44afc73041b6debb6e302dedf", "numpy/_core/fromnumeric.py": "ed6b3fe56e1921ed140c9d8ddd26393faaaa9304846084ae3ce78146bcabe605", "numpy/_core/function_base.py": "97925f5f2a271088cbff838a149a6312335d8dac80ac0314f0c85a31b442c1b5", "numpy/_core/getlimits.py": "ec0927f602302ef9b449f2773151deaab480cb5ad8eff4c8bbba59e489daf106", "numpy/_core/memmap.py": "9f79da21b64da6722a66cc86e126061b33371ad66139314580de483a0ebc254c", "numpy/_core/multiarray.py": "afd14181b927aa10800a0c5dab5f456f52e219726847dbef379e313419029d49", "numpy/_core/numeric.py": "feb150554b4879d4df7bd0a4ab7b1a6b818de7ba994ed0c73583fee177533417", "numpy/_core/numerictypes.py": "de7be532bd85cff56ad4e29786d76ec5bf2d511f7e364919bdd7cb0ad93ad3a8", "numpy/_core/overrides.py": "88cf63f86be1eba2a303d221f011af2077194d819c06a10c725f01c939afe4ca", "numpy/_core/printoptions.py": "345a6fcb96e78dbbea9ca7aa42dd2f784131a400180153688865c7de98255807", "numpy/_core/records.py": "bf0ffa47a868c210494dd351ebe9d58bea06bde6730e8224ca39979b12ba351b", "numpy/_core/shape_base.py": "1d6e897dfdb7edf2d71e8ed75254a6e7106b1a947592f88d91af96d1ad2c469e", "numpy/_core/strings.py": "725c16c3218fb3441b56465b94f08d5a84eea24669d3b9189ae45a6ab9aee332", "numpy/_core/tests/_locales.py": "96f1ea50954cb2b13b261dcdfcaa4ee5f181660203fa5dd9af8fbf46b1f564d3", "numpy/_core/tests/_natype.py": "93a0e3d9ef621fc988077d8e5bd148d851b1884fc50c2ee621a222e19810e957", "numpy/_core/tests/examples/cython/setup.py": "3b3f154b2d028de51ed79d7a1d0b607c1250213934628fe613d15c415805eef2", "numpy/_core/tests/examples/limited_api/setup.py": "63ab60b0e179f2a7bb786d909914071b6c1a71959fa5b24b4fcbbee4e6a68ea0", "numpy/_core/tests/test__exceptions.py": "96e313eaf3c875fe8bbb014d1b24fec4b31968a644618385cc5a4c69eb288e81", "numpy/_core/tests/test_abc.py": "f72d92b097643de574a16e9db1138f64e710ef6fe65e27b5b94db23cdf77c33a", "numpy/_core/tests/test_api.py": "8a8de65e7d39b3aa98c7d406f49fb998a6fb31e3b0c9bf2b46068795c3fba5ea", "numpy/_core/tests/test_argparse.py": "0d12d00f94f186e76b419efd866e5db3778ab1787f51bed0b2f118cec743497d", "numpy/_core/tests/test_array_api_info.py": "0ea5da065100fa5eb8512be2a65f69feecf463bbd22d5fd1c7352f3f79b7a159", "numpy/_core/tests/test_array_coercion.py": "dc4262a56f842b233400ef70d1053bae3c2c34657ad0df0f551480bae07b5582", "numpy/_core/tests/test_array_interface.py": "977f55b95e2709d21e575454bccb638cfa2102022f24ff95dc643931a3eb54af", "numpy/_core/tests/test_arraymethod.py": "67ccb0c9a462ec65ed5f2a690f9e86df47f39ce2a82d0daccd565116d86bc77c", "numpy/_core/tests/test_arrayobject.py": "b9165206e41aa5f911e567da0d5d114b741ea1152612c46f539ab37ade1632f2", "numpy/_core/tests/test_arrayprint.py": "d96991880c806a50529c991e339b59ead5ba16a8d2db23dae877c41373f7d64d", "numpy/_core/tests/test_casting_floatingpoint_errors.py": "431ab06b96ba03efacbaef26e33c1170a510037e7cda8cc59fd5907026c08224", "numpy/_core/tests/test_casting_unittests.py": "46cc4ce0866d18c1cda2e82f8598845a6d95845b53afbfb01590ff35c2f396ec", "numpy/_core/tests/test_conversion_utils.py": "e2db425fb76703ff294cc13cee86d48f2f0a0e4c37a8bc12661ad5a4b400db9a", "numpy/_core/tests/test_cpu_dispatcher.py": "0bd96f2d7e01e5de63d81186794fffffdf75f6efc7930c0f83af463ff19e7489", "numpy/_core/tests/test_cpu_features.py": "0b858a4cbf6998dc221dcfb75c889aaf63ef30ed5bfe3a493a2c2516cbdfae67", "numpy/_core/tests/test_custom_dtypes.py": "f68f7986b57c925bb8cee3eafdb60bd8535b80b5a3560096067ff63e2fff357a", "numpy/_core/tests/test_cython.py": "8220e498e61166e03802ad1ed7774aa22fde3bb98d494c2f8964dd6b239e1143", "numpy/_core/tests/test_datetime.py": "126ff9471a7ea11cd87927ab34540b7785d5043fdf9aa8efa5742e52e434f47a", "numpy/_core/tests/test_defchararray.py": "03a67d60f73134c440dec222b079e9973c5f6fc345b4a2ebbd56421ac91c9b31", "numpy/_core/tests/test_deprecations.py": "781fdb14d594e37aa9bcf9cb1ba0e346fba5bafbe1cd4a2fa2e187be636adb0d", "numpy/_core/tests/test_dlpack.py": "2730cca80cc56597f228f3c9bd6b883a457be7d0c81c343f380288455c4ad847", "numpy/_core/tests/test_dtype.py": "c516913ddb1513488076cccf6fe9a061c8d5552e31ef994c627561fcc457379f", "numpy/_core/tests/test_einsum.py": "a93befd3c9d981456bd7f0859bb447ac067a38e6d5ddcd6946744c47d790b73f", "numpy/_core/tests/test_errstate.py": "e1e86f96786243acded63bf5163ed2bd7c78e0e40ac9d215b3b36d3678ca647b", "numpy/_core/tests/test_extint128.py": "a281ce5ef6148392b6251b94bfd69eee65a5deaa035c562cf4881bf9acb9e0b0", "numpy/_core/tests/test_finfo.py": "3973c51228fe88cc63351539ee4f366a8fe3f62f848a97e4b4526d2f6f14c2bf", "numpy/_core/tests/test_function_base.py": "545558cbc18c944cf790fd3315b170426c221fb2e6d37fb148245c847b4e5477", "numpy/_core/tests/test_getlimits.py": "41efc0b7dca7a164039f21297458e8a8431d2c0122cce84747e0b3ace39c2bb2", "numpy/_core/tests/test_half.py": "47401dac9e81285fa243105560f1904ca1ef573b080559a81694c584806f0650", "numpy/_core/tests/test_hashtable.py": "3b69065299eb8ebb2fddca2b750b9a56c3a99a934f11ead3718c0311403533e1", "numpy/_core/tests/test_indexerrors.py": "d019c705a6b4dbf1fe8c7217db0fcdb6382ece19db83c38881bcf6098d5984cd", "numpy/_core/tests/test_indexing.py": "9d1a04348bd6d7cc5148e2bf92c09eed43db0d94b5a3d67d0b54e835ee8f7e7a", "numpy/_core/tests/test_item_selection.py": "cb2753d5ae899fe55c68eb5804e8db7891494969c2da256035f9350a40a238e4", "numpy/_core/tests/test_limited_api.py": "c61623695c5f239ae9f2d88ddf8f1c3b5c98ea13c6c9b55f82d2cdc1bdf0ccbc", "numpy/_core/tests/test_longdouble.py": "01315ff3d538502cf63fec1233e6feb8d04f475bafdbdd739eeb5c487c5c2c41", "numpy/_core/tests/test_mem_overlap.py": "038d16358b2f9c66cfc32ad9a09136a88a91ac67ad4176f21dfd0e982380c111", "numpy/_core/tests/test_mem_policy.py": "64a8eb408697f95c54db9691aaf387ecd8e975163e2215de9e45928583c60008", "numpy/_core/tests/test_memmap.py": "7a02d9c8543802b456e431b94313327099b52d72a241e9047d535dfe2d3da56d", "numpy/_core/tests/test_multiarray.py": "964e120033b517b0edb810f009b9be37e17706041a8a21ef77efecdd969fed8a", "numpy/_core/tests/test_multiprocessing.py": "2712b996209a173d669d1a6971f52167d3cd247c1e23954ce2ffe41764624c19", "numpy/_core/tests/test_multithreading.py": "b8df17f46fa0bc90648be0806a66279c852f50e39026a92f7ea7661be192d068", "numpy/_core/tests/test_nditer.py": "be1eb1d9ff487fc7c754c2ea0dc3f0245d3e6035082462725115a03bb56b5b72", "numpy/_core/tests/test_nep50_promotions.py": "48136d08733607f2c32b4e264958e263652c816b064eb31b57dfbbe2ece1eb01", "numpy/_core/tests/test_numeric.py": "301adc5258511108eb3d9ea47d14c3aa41b9e6644a0eb3e4f5f6397fd2d4424c", "numpy/_core/tests/test_numerictypes.py": "bed0d807cf81c3f41835f8068447163aa873b1c2b07cea833f8a721250f3d43c", "numpy/_core/tests/test_overrides.py": "1391dbce08fd891b99d8dc9094ec33ac97c574dbfb25202449fe9ec1e90ea099", "numpy/_core/tests/test_print.py": "58098ddd212cf5ebc1153ec27a41ef294cf3c522268329eda4aec8c7bb6a8ba0", "numpy/_core/tests/test_protocols.py": "a5b7ee9a844d9cf8433fa3c03cd2202c750f3e598275a982a386a490ef1a7e3a", "numpy/_core/tests/test_records.py": "03adf83cf934ece531dc2a12acb3177d98b545ab4776affbe3ab747dc95a1761", "numpy/_core/tests/test_regression.py": "527abff2e69f971b1d7154346419affc52ce418a07f9312c508e5f014d3e32ca", "numpy/_core/tests/test_scalar_ctors.py": "8d0615129de7382610d3ff32cc5cd0ede43afd150dceb4d511e6df2d610eae7e", "numpy/_core/tests/test_scalar_methods.py": "9d8aec8cd904d4c22f41171fe7fb18fd64cd4a9fe94014fb61aee082033dedb6", "numpy/_core/tests/test_scalarbuffer.py": "a442401574224a17e483d7ea7a063338f514c5f55c03365b95c72e873df18cdc", "numpy/_core/tests/test_scalarinherit.py": "388bd28eb96d74d4923f67391ef0d0ea9cdadda29f99f82d8b1bb565b6a1a5c8", "numpy/_core/tests/test_scalarmath.py": "a77ef1285dad35cb7e9c1a84540b3c2666ecef8df52b9a57c9e5aa19da7c1446", "numpy/_core/tests/test_scalarprint.py": "365029ff1ad4e580dcc36e3ed9b92459b928bf8a1bfe79c82ed01d0979183cfe", "numpy/_core/tests/test_shape_base.py": "97ec4e9f4e976672650a7a8e1044a2c7a8f7069b5392f62b33de0a57c937ebbc", "numpy/_core/tests/test_simd.py": "6f7f22312fb4ee881b17af2704f4093b4b7db28e5414df088d3497ca3d72ecd9", "numpy/_core/tests/test_simd_module.py": "14515e0b090c73b8df681c81e0c1876887c88699c1c5f3d22195baf713197fca", "numpy/_core/tests/test_stringdtype.py": "6c50f0167846d72e03cb4e178bd362aa52dc1d3b83561592868baffb27b34288", "numpy/_core/tests/test_strings.py": "746e8caf91c9ffcf67aaf7bbbc6f7ce036860b22275f8e899560a19ac65c7c76", "numpy/_core/tests/test_ufunc.py": "c9f4dbecbbb3192faa4ac7ba0ae309c7e987fdb8b8aa84fe44bcc08a430ceae0", "numpy/_core/tests/test_umath.py": "f076f371edcd8c36efb636e7a428a25f51079caeccb53743fdaeb8e3ff7e2ad4", "numpy/_core/tests/test_umath_accuracy.py": "7d45d72c1e380eb822bd0cc91553bd56c41e85c5927173f9d6625364fdc66c76", "numpy/_core/tests/test_umath_complex.py": "48f02853939105905697d250d3af1ecf306196ab7468d740a34c42f6342b8669", "numpy/_core/tests/test_unicode.py": "802b0821b8dbd702d7dd95c9cd4c6e2b940e180b007837968cac788f04aad808", "numpy/_core/umath.py": "fabc529bdfcc632ae82bcaaa5539494802757e5a52c492999e2ebfe10f396987", "numpy/_distributor_init.py": "14148976054795071ae41ad011560fa059ba2924c98481675ad59b1241214d2a", "numpy/_expired_attrs_2_0.py": "a6cf0f96202d89f172abe6ad706fe252ba7672ee35091722bd70870c83a0426f", "numpy/_globals.py": "fe13921c6f4a00bd12891da7d800f2a42f878c067d8ed881ddf0af3fbace3a36", "numpy/_pyinstaller/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/_pyinstaller/hook-numpy.py": "718e49402d6d0726ad3300413cce136164fb888ee4a6525218620bfb81ea4fb2", "numpy/_pyinstaller/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/_pyinstaller/tests/pyinstaller-smoke.py": "ea22fe787310686debc674b912072fac2a84966f5a28bd3b0a3af51592525e5b", "numpy/_pyinstaller/tests/test_pyinstaller.py": "f0afbb43199fa17086d0dc11d1b84880236b0e31a5ad3cd69eb475b11f1bb605", "numpy/_pytesttester.py": "cc2729e50688028a9aeedb131b2a12c0480f3477cc1c0e84be7f5d4177164002", "numpy/_typing/__init__.py": "23712a130b95f1134c0e93988ee72abe6c1015180277768ac13bae4fe1c8f59b", "numpy/_typing/_add_docstring.py": "89f41e376a028bae35ecfb597475cc2acbd4e4955cbb9b0f8b9eadd08a8b9b33", "numpy/_typing/_array_like.py": "5c9d8a290c4d76fe7e85f4367f21fdc33f40eed80b44f66d6378629fb4271bf8", "numpy/_typing/_char_codes.py": "c1ad22e8a3fb2405b257e8bdb303a07ff0a923ab23f7175bf5af3b6b62316bd1", "numpy/_typing/_dtype_like.py": "060ecb1f4c35793a8a3b4fe200cb1151b51b7d17fc2e53ac7699da4271752bc7", "numpy/_typing/_extended_precision.py": "a649d4aa06a4d0504d33eb0444fa96fa91461fbd7f2be89e84549e7b9a108aa1", "numpy/_typing/_nbit.py": "9a353bc8328b57ad47a79fbe36eae4c48272b136a7307df7b70e5ae2e725a284", "numpy/_typing/_nbit_base.py": "496ed60d5b3b711b201c21e1608c9f2e3f4757f0173f85ffd83d7187e54da43c", "numpy/_typing/_nested_sequence.py": "3bc45b3564a962a54c203adede2390a7c852ba48349a4c9332a5e7abfe3f2c24", "numpy/_typing/_scalars.py": "02ee1deaaea050040b408b9613fe4f1de80b45290a5c1bb38d5d70a76a6eb7f5", "numpy/_typing/_shape.py": "8086f11c19de0c82c78caa3617e4d4f0834ae82afd843befb0f88e9700137a3e", "numpy/_typing/_ufunc.py": "1ce91a13eeb05747dddeb9876460b7f580072087fcb72be5cde903e32e064310", "numpy/_utils/__init__.py": "4a9a9d941150a1648e017b1efcd2ebb8ffdde730f9c0366f1d826121eb099caf", "numpy/_utils/_conversions.py": "d3133175e2cece20e61ec44cffc96e121e12fa441d328320e86c4d0c36acebd9", "numpy/_utils/_inspect.py": "cc5b890011f4f03d4a82afde79c6240f53a0834397a75b78a2a8d9c4cd2474b9", "numpy/_utils/_pep440.py": "8adf4fe3fa075d6c37071768573ec93ccba3e64c45e4ceff049f19d66f67bb4c", "numpy/char/__init__.py": "93ff0019e949b734526cfd53c96a25923f8445fdae6c91ec3d400363de3ce94a", "numpy/conftest.py": "c18dedb095cbd8e6944ba7a2140b0b36c62d0c520637efd8b8a32602497f5c27", "numpy/core/__init__.py": "c0935a445d5414e9d92aa881aecb2158b8d31a2119f6bbd695c8add318fb634c", "numpy/core/_dtype.py": "1870617d5b6c56b3fbbf5dc8ba3133f5a18810d91821d6dfb91bbe35ec355275", "numpy/core/_dtype_ctypes.py": "c17e26dfb6f4cd08319734f93a313fba3d84e42a625fd13b1cb1693ba87f9436", "numpy/core/_internal.py": "ab1a472442d735471826426dd4b92d42e666e01c18bb86d79ccb8110ea7a3ce5", "numpy/core/_multiarray_umath.py": "4fcf07660143e550ae5d109278b6cfa23f7d9ca512760cb0f315b27fa7aa8714", "numpy/core/_utils.py": "e5f935f09378dd183a607bda9fa42376b39e3ae2ed4652d598fe8c69d0442550", "numpy/core/arrayprint.py": "2db7b8b26597605cddf6c3bd2cb2793d94b80b76d2bcbb7a1d1b70484e7ac4df", "numpy/core/defchararray.py": "6bd96ebef9e2f2046b19574a3bb53fc70b0516f9339719d58312fbe632d19822", "numpy/core/einsumfunc.py": "08db9c20d81422ba622d09f8c4f23f9a88308df2a5140de1ee0c00bd15706f93", "numpy/core/fromnumeric.py": "e536a89c956e0b5d74aafddfddca93b668dac935f4066a89020a00267e47dd92", "numpy/core/function_base.py": "be18e1cec1330ddd7544783aa6295f3093b75fa93de1a9f944026a8fe9e5ce6b", "numpy/core/getlimits.py": "ea70a4e13c342e35bb8e85aca6b2392e23338ded60b0e8ceda5490fcec0107c2", "numpy/core/multiarray.py": "6e374f2dbbc9ba3eb533a4d991b0793573823661f841b52aea0dde3e428fe930", "numpy/core/numeric.py": "0ad93f42293207698cd31234941781f184d47d3c104977d576920c46dba76cca", "numpy/core/numerictypes.py": "6d7c13c3351a8736c7ac51a14b946424ebdbe93604b109d00b9c30f6637ed55c", "numpy/core/overrides.py": "d456726f453a249bb2a23b7116f43b1d2276ae97e159e73417e5f499aa428dcf", "numpy/core/records.py": "f727c50f1c8e73af255ea7db6a8b2044d970d5d6d63fc0911f320f12d12d4a07", "numpy/core/shape_base.py": "dacadd42d17577c2e951b0e318c5d3f93ab3d8ad8d6933be6440b8be2098b306", "numpy/core/umath.py": "84c56636b20276a5d18a2446ed4315d06afef7162a2469a438d1909f6d222bdf", "numpy/ctypeslib/__init__.py": "585c0c8695762c93fe2103aca5a227855f1ce973ca670aa9a44f9cbed229aaf5", "numpy/ctypeslib/_ctypeslib.py": "739bd4529aa07a4f02f59a3464aad2f537dec1d4c9ce99d52f7be6845c1a0142", "numpy/doc/ufuncs.py": "98e9217609c568aa5f5495296787e17c1d24fbbfa85a51b0530cb0e212eb5406", "numpy/dtypes.py": "29ba7455e6125e2986d6e1149cd4ae9d699b208ad23edf1cd7482fdac29bda4a", "numpy/exceptions.py": "df16e967d97b1779a1c2dca6be5d2fa84e346a237c6e471e6a8f1a5df66c9795", "numpy/f2py/__init__.py": "7df877d7f533f3523a2871b265299c9e09188c7413147a391ddaf7436a80f1ab", "numpy/f2py/__main__.py": "ea2da3547d9f3eb895d5aa1c4d8fdd505bd62b5f2a6bece3a6721203e3a9177c", "numpy/f2py/__version__.py": "f7d4ba9927afba1c0698ef64bbefbb55425e921374a2de3e2747192a21dcaa9c", "numpy/f2py/_backends/__init__.py": "30813c4a5e37d4195b9fc9b463d4539fad899767747caf2792501109f5f67bc8", "numpy/f2py/_backends/_backend.py": "a055d9f3e57071049b96d97cfe98162cfa82399f18fe9c7ba1e4e4fc19712537", "numpy/f2py/_backends/_meson.py": "398d3089f27dddd148e357c1aba0ddb2f9d0fdeac0e6aba2c6fa7ad1eb5a888e", "numpy/f2py/_isocbind.py": "cda060a5f3cd466c551b776850895b6488b207df7432c5e2c0369bad28fd1e74", "numpy/f2py/_src_pyf.py": "3c7a68f43dbc2aadeaff7f8a157f03dec143f5e5fc0357372ee2cdcd7cc1c8ec", "numpy/f2py/auxfuncs.py": "32eec0653dc31d69707d3f409a4485a47f81399d13bb7202cef480e85c16f3f0", "numpy/f2py/capi_maps.py": "3cab905335d8a7af56eba8dc274c92bb05b3a849cf8176f7eed1e97ba694f6c7", "numpy/f2py/cb_rules.py": "008ce50f611508264a333f904c38082c25dc5cadad30cc579972671fe850249a", "numpy/f2py/cfuncs.py": "c6f0e44d6644416fe5a182b860541e2e1eee3f586413df14f39edb40e71097e0", "numpy/f2py/common_rules.py": "4c63644e918d20864d9d7f848f966304725891c6a230afe4feb9faf4f7e1c89d", "numpy/f2py/crackfortran.py": "a5ac64c74111262a521bc359963dc4907200d9dce0e3beaa31dcc0620136b822", "numpy/f2py/diagnose.py": "dd4233884349083f2f9daa6386996ca927736697ee01fa3bb69edcc79cb6f2a8", "numpy/f2py/f2py2e.py": "e01b3861161235c6f003aa774bff70afd211cf421465311abd5386f626f4d137", "numpy/f2py/f90mod_rules.py": "d2c33f315e2722d29635bcaef2838d08225ae5925f9a474cbf6f2f844619ad37", "numpy/f2py/func2subr.py": "a68999da32155a64e39fb9a8573afc3695862095192914ce349035245410a3b3", "numpy/f2py/rules.py": "a030a2cced2c5c25358c30d4877d50c5937312542ffdf464382ab19ad1deb576", "numpy/f2py/symbolic.py": "a83d5d2d5d592ecb881814f794736c91abdbdfd866c2ee0311a934916928e681", "numpy/f2py/tests/__init__.py": "a5d3db093470a4225a9a5caf222f4765396a02f2b91cf6c6bb7a0c03472ed91b", "numpy/f2py/tests/test_abstract_interface.py": "3d73500740d9766759cb2b09901f1ff46634fe103784692685af1a4015dcd529", "numpy/f2py/tests/test_array_from_pyobj.py": "df3605604d7caaa268fc5157c55a17e35e14fd39eadd0ae89756b34df351f491", "numpy/f2py/tests/test_assumed_shape.py": "791baf04573658be959fd6a046e2d423f4d71b01a666c258998a737ce1a77bf6", "numpy/f2py/tests/test_block_docstring.py": "5fbd9f44ac5f33640654dec3331db6791664122bb3cb4a4fbef314c81ca61873", "numpy/f2py/tests/test_callback.py": "ad462a269170f86ca7ab9a7f2fd434daca52987a11b2af1a237234e09f9802d4", "numpy/f2py/tests/test_capi_maps.py": "f6c842098b3ae8024ab1b3f1e13f962927c73c2488e3bec990fb80d42e5a69a4", "numpy/f2py/tests/test_character.py": "a9c9eb98ea7e1a6e2e4fac0cb3521f82aa2340d6aa97a820a81c464b3d0cd281", "numpy/f2py/tests/test_common.py": "255c08ccc131f99f6291cfb41087bab28058a6ffd923df47ad3006f3831c8547", "numpy/f2py/tests/test_crackfortran.py": "585b4db94707eff2ae786b0a778fc3d966feb42f49f4cde71205bbd60b4347f0", "numpy/f2py/tests/test_data.py": "2b287a11db951bfe214e64be092e7affe97af18ec6c27817721493a0f5897b09", "numpy/f2py/tests/test_docs.py": "81a47adafa456889dafb9d115e0788f6137c850d8b9fe0939e03229daea3f63f", "numpy/f2py/tests/test_f2cmap.py": "a75ff9bc4557b65c3e1dce82ada3edd321bbc9e2d621c2bd6392e1c4da1f220d", "numpy/f2py/tests/test_f2py2e.py": "886623fc8d54c87c9682894c3f4dca4f5ba5db9aafccb894be1132d61cca84f4", "numpy/f2py/tests/test_inplace.py": "432adca0893b21f0cb819c18953831e913b085a736fda79452f381bb764834d7", "numpy/f2py/tests/test_isoc.py": "2b136940ad4b3ecf12cfdd07dfca1d5eb3ef820738b90303bc985b6d163b8bbc", "numpy/f2py/tests/test_kind.py": "e2a0a1c0b7f6af9a6b9a91031ae81dcdc429fe8553bdc0c846efaae276f895e3", "numpy/f2py/tests/test_mixed.py": "171aa3a3767fc7bed09661551794a34e00d5fb4602a90f1349dee5baf3ed42d9", "numpy/f2py/tests/test_modules.py": "5580903ed8ddf5c7ed8ba96ede316d18849d139e3135d5759037dae941699c1e", "numpy/f2py/tests/test_parameter.py": "21d8a36002cab28930d170c23b8b46fb995cf894e6c24804bd6d3689995cbf6e", "numpy/f2py/tests/test_pyf_src.py": "c55f358518867b2b4514a7959e9fba3b63ab19577327279c3046a50904a80e82", "numpy/f2py/tests/test_quoted_character.py": "032def640ca1c48340d299bf98de8721f4a0a516073d2a2b3e4b45b4cb08387f", "numpy/f2py/tests/test_regression.py": "e2cde7ada18027cb7d0b07a09c2289835689f443acedb4ca182ed7d7220be2f7", "numpy/f2py/tests/test_return_character.py": "b7c7313bc2dab670577f6114f8791f99dc6f7473180e4f432f1de43544c0ac2e", "numpy/f2py/tests/test_return_complex.py": "fee5ab9d287e2032fc99e9fc5ffff9b2b3f8c0cd119080abe16549828360af36", "numpy/f2py/tests/test_return_integer.py": "c3da47bbea35adca75e3cb404e0152aae7ebf6702743121e30aa3ece8c313cd6", "numpy/f2py/tests/test_return_logical.py": "66dc61ac32ba631d08dfa8ca57d04eecf2d5b0b3c16f850691ff9b57c295397d", "numpy/f2py/tests/test_return_real.py": "7a78035f33d8801bd44cb2dd279bda2221b0b7a03bcce9f89643355ba9925026", "numpy/f2py/tests/test_routines.py": "7fda51f0534980ab815adcc28e57e789654725e7295ba8123641836f6b7af777", "numpy/f2py/tests/test_semicolon_split.py": "839fc53e6051a22427cfb27bab4d19768bb030f3c141bbb6cce0161bcfa28386", "numpy/f2py/tests/test_size.py": "4c49fc3aad3226a018f8c2035afb9eac604dd296c4d7750734adb9ee83de4bdb", "numpy/f2py/tests/test_string.py": "b2e17c745242d05447a5ff0399ea620b05cfdca980ee12424cdcbf935d246599", "numpy/f2py/tests/test_symbolic.py": "526dc7b71a4861589fdffde2734277c2c2e9eb470cb70eaf0b503de5346f9d07", "numpy/f2py/tests/test_value_attrspec.py": "c0497989a4730c640ee25b82d174a9adc524e0b7bfb476a04ec150c69ceb87fa", "numpy/f2py/tests/util.py": "4202f71db9d86874fb2b00ad4af7b2538d894945513ea54dfebebf098f922f8b", "numpy/f2py/use_rules.py": "0e8c25823ca3af6eb78520946f2f73f7b7b807f0ca5b3f2bf5b94a63c0108b4f", "numpy/fft/__init__.py": "251bd35d9a814b98e076ab2e0da2a5a7eabbfb11427a7e873ae127d5a26137c0", "numpy/fft/_helper.py": "337367a7a4e1068feb9538fb951f44fe1ee232ef4d74342e49699d486d8a9e72", "numpy/fft/_pocketfft.py": "b3afd951a4e60bf79b012b671683cd2df6f0d32d52d62036d7a25e756ac5362b", "numpy/fft/_pocketfft_umath.cpython-312-darwin.so": "51add49e0b523ae7b20a10a879a77e0998afb795d6d233ef8936f0a58ce4e36f", "numpy/fft/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/fft/tests/test_helper.py": "2de543082747cc5866090e41c8cb55c80db61a98604d04b976ea6ec6b2c4f17d", "numpy/fft/tests/test_pocketfft.py": "0530e76ed387693f3246a0a5f401f79208b49766d24c559069f7c340d7910f2b", "numpy/lib/__init__.py": "9983bd3542d050794af5c33999f9d6caedb36fc2c4c3184442b842fef757d92d", "numpy/lib/_array_utils_impl.py": "4644b9438e60d2a4cc38e0fb70d2a36b0887e0ae2251b37a1a9bb6b4da0a7b6e", "numpy/lib/_arraypad_impl.py": "69f17907431860505f879f7ac0f69be927464119e4068583b5f84f11fee63131", "numpy/lib/_arraysetops_impl.py": "9f896cc0ddc2f4f94ed7cf0b28fa5dba777ec77df3c44788afcd6448d55416b4", "numpy/lib/_arrayterator_impl.py": "1ed3800c81ee1bd0036db3138268783ff9ae91ed55fbc13e14d10eddb54e18f0", "numpy/lib/_datasource.py": "9ead7eb599f6ed893aae85ddf9a8316502b4efd0595cea2b9ddf7af1ab097460", "numpy/lib/_format_impl.py": "b34d4671a88964e22002effe2cb376263156babbe37237594311dda05dd85771", "numpy/lib/_function_base_impl.py": "000d045b739c89974bfd9bae66beaa35bfd97ea7a06d13378aa234153a3b6116", "numpy/lib/_histograms_impl.py": "3f4f1940f437fe139d852031afe1c2b9f85e32a2c32f8d90c0125445af9f16cd", "numpy/lib/_index_tricks_impl.py": "e168b1ab86f91c9c8ab64e97b2fdc7eb3fe0559c8432d33c9b267b68b4eb407e", "numpy/lib/_iotools.py": "04e6c05a9fe7ebd9a92d888524bf15512926b9272b453ae5c4ac5c63ab816b48", "numpy/lib/_nanfunctions_impl.py": "d923a746bdfc4cbc254cd932c03670a9f7566827002b2cf5dc40db8bc81bb5fb", "numpy/lib/_npyio_impl.py": "51eb4572baad1e8198f71b3488a3cbcdb81ac85aa3c15cc2708cd907198a1fb5", "numpy/lib/_polynomial_impl.py": "530f29b1db6a1610bd02291c94196e100a3dd7b80f3a278fb6173e29dd297545", "numpy/lib/_scimath_impl.py": "6f9ffec91cd62483bc75afd9e01f2a41eebc8fc9693bc82db4696f18da65cadc", "numpy/lib/_shape_base_impl.py": "b550d0cc5e7efe46dc1c77f0286330fcb4100fcbbeb98f41aa9127c2c44e01ec", "numpy/lib/_stride_tricks_impl.py": "0db57f30a81b00919e7922828cc23c4c32759c07a647639b76d1e157871fe862", "numpy/lib/_twodim_base_impl.py": "0b31bb9f23700e5bf20ab94648afc1357b175fb96b6e1fb80d248fbb461fcebb", "numpy/lib/_type_check_impl.py": "53a091170f8fe5fafb13e7b241f8d04c352185c1253125c389aba52ee37e4939", "numpy/lib/_ufunclike_impl.py": "f468fbb02ccb1038be6194044b04d3f873604c130f59841612109b0e1718feea", "numpy/lib/_user_array_impl.py": "65c91b14c34cdbc1136e97b5d9a6262780b58917a2a1233e4ded8dde217f5195", "numpy/lib/_utils_impl.py": "4cb745a05e5cef826bc6c38c55d62cd02113a61d4531b26098c7d86ff2ae2435", "numpy/lib/_version.py": "0affabe9bf73540e9b0febf2158f2d09746ef5de4eb069e3a976a57d8d9194e0", "numpy/lib/array_utils.py": "5db732849f52d0894d9cff4dcbacb280b30400259650f34e53cbdebe3d531292", "numpy/lib/format.py": "9e9274789853eee28d2b96b49423067e226ff91e23c8d86220f7996c970d5c1b", "numpy/lib/introspect.py": "e97a1b86c7a928352ff339a83e47d53391206421afeb53f63ca97f6916c49074", "numpy/lib/mixins.py": "cd047e8888c2492796c5ea4ae62fbbba34967f0163ad467fab18deac88a4c3a6", "numpy/lib/npyio.py": "79a3ef7c7192cd413bd132471cb3823c85fd1b98a132e0447b1cbafcf36127d4", "numpy/lib/recfunctions.py": "763ae03d31c71bd8802161dae859b82c647e7a4d23adcb4c62ca9101bb444874", "numpy/lib/scimath.py": "aa315a41eab4cc4225ee02aa3a16a3fef9820bf29a15dc9398774b514912a792", "numpy/lib/stride_tricks.py": "c74fc17f097270102547706fa714e775e3fde9d1c14ff7c049b9134d3cc16202", "numpy/lib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/lib/tests/test__datasource.py": "aae16cb323008efa343210fde5df35b9900e57002a1f91b921dacde686416292", "numpy/lib/tests/test__iotools.py": "18515e26a8345da61090931bab85705aab9aef2f0104f499c6853cb25962147c", "numpy/lib/tests/test__version.py": "4b05e812a31aa7ad377368ddece36877464e550797e93fb302b31fd373821dbc", "numpy/lib/tests/test_array_utils.py": "84f5ed0a3a0129ee8c3fdd6c83fd38101a51620ecc213565080803d4049c8f1f", "numpy/lib/tests/test_arraypad.py": "951fca963be4dcff213db3436fb8fad3475771a4cbc1569da8fce9135a669b9b", "numpy/lib/tests/test_arraysetops.py": "3dccaf565c8d1bd58488503fd2ec883e310b3452ff07ed33b02f9f6dc5cb225c", "numpy/lib/tests/test_arrayterator.py": "ba4088f1588ac14826725b80e58ae88604b2540d2d822b908c36e6e1a7e12f79", "numpy/lib/tests/test_format.py": "32c5f1c75989d5986a394ea45daa50a8395064725e30535f1eeb79a4c28913b4", "numpy/lib/tests/test_function_base.py": "2e30d2947f624b672c13f34d29bc9d70105802f0b3d41fa7a6fbb9d4ece4c43a", "numpy/lib/tests/test_histograms.py": "6d9c00935d0a37cb82abc958360d1aabb9e9b1e86532ffd434e0614e8aac93af", "numpy/lib/tests/test_index_tricks.py": "dce215ce105935233ecf4cfee1f7ba77fdde1062197fa2afdde1852b14d6b324", "numpy/lib/tests/test_io.py": "241ac332374da2f05191969ff24054cf7ff029dea39b7dfc71fb75d75bd00c46", "numpy/lib/tests/test_loadtxt.py": "3d8cbe26a69314b39d41288b15cf094f16fb2f04bf60acae2a9ab205c8a9d780", "numpy/lib/tests/test_mixins.py": "f6bead80fe166fabc20e7e7dd0f90798797e18102800bebffa6c29db06e268ed", "numpy/lib/tests/test_nanfunctions.py": "4a34474ad3f8afc08b1f497b70b23178af7433b46a82e638609dd63e20b6baab", "numpy/lib/tests/test_packbits.py": "b331a342542dbbb54234a5b6bccf5903d3ad2b78980b061c39b78c7d2f85699c", "numpy/lib/tests/test_polynomial.py": "0b5b26b653fcfe0c838df62835975b8f338878ec01ab5bd72b30973520914fa5", "numpy/lib/tests/test_recfunctions.py": "e2e70bf15f9e98ebd5343c2cf1347186fbfd0f39794241110169d4613541ab6e", "numpy/lib/tests/test_regression.py": "51446d9adc1faf1303177518d5930d6e020939adfc8d4cd82829a96180fc7b74", "numpy/lib/tests/test_shape_base.py": "6561de582b3dc74b03f8bd3787a9139947511efc47542fbc28ebbc2a89a1c8a4", "numpy/lib/tests/test_stride_tricks.py": "b3e3fa0649b9be51e6adbba4b08bcd536b42161629db310329d144a1015f8d4f", "numpy/lib/tests/test_twodim_base.py": "c2842b7beff23d5673ccaa69e02432969f89d4d3f9f326c25d952b95de295f98", "numpy/lib/tests/test_type_check.py": "d8ceaec8b488f823f5dc2032967067de46d3ea7acaeb06165be49cc35defb004", "numpy/lib/tests/test_ufunclike.py": "f6996e304db3c86991cf1e97052ace7b90f10252a5ba45a7ad0a137a8dc582c3", "numpy/lib/tests/test_utils.py": "1d16711fc46cf8fc42a4c02181b34ead37c1aec03c07679338aca963451d733c", "numpy/lib/user_array.py": "ceceaee93017a00c9218065cd6a13a7ca0f800dfadeaead909a89968a9878aca", "numpy/linalg/__init__.py": "3b50094af1bb3530254d3bcb19349c612d5db6f859707320a466c7f71499abc2", "numpy/linalg/_linalg.py": "fb51e084cbb05b72a571a088299222055f3f176792ea9ea66186327a31ec787f", "numpy/linalg/_umath_linalg.cpython-312-darwin.so": "dbaefc13a7379c877dee2618ea6f96d69560743d3ad392d57f3a866f1378728d", "numpy/linalg/lapack_lite.cpython-312-darwin.so": "a7895a9c0d4afdf3fbbdc2456e016590aa0fbd8d7e203079debee39bd0269b5c", "numpy/linalg/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/linalg/tests/test_deprecations.py": "1bbf8088181863e16a54e82ef5ba3428edb78aaa0638ca13d79f0bc174cd1781", "numpy/linalg/tests/test_linalg.py": "6f515492be3dd4b0d1a44b8286b0c058f8c6259309808c7fb2df24648201d953", "numpy/linalg/tests/test_regression.py": "f436e9a83c0c63d5d1e44be2143d9a310457b10e98edcd6a2421a9e02062db5e", "numpy/ma/__init__.py": "5e90d6617c1ab83738f7e20db24e39e43d37530e29eb115db1d58e9f6aedf3b5", "numpy/ma/core.py": "f7a05895d83965d6f48f9f858f59f7793c30e1ebcc98ce5a88f80de7a484c828", "numpy/ma/extras.py": "ffe5314b5364a723057ecf51d1da2ee21e0473eec10a982e03bf6bef70539417", "numpy/ma/mrecords.py": "dde45906ac048640d42df62d51c07c520b5b7161d36b2172b350e484ca3fe425", "numpy/ma/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/ma/tests/test_arrayobject.py": "312bc473196c56de1867b9955d4f2afe193033423bc6cc567a312a9d4431ea11", "numpy/ma/tests/test_core.py": "dccb4bdc1e2e2a147983147536bd00d568fc442f826dc162ab8824f37f9aded2", "numpy/ma/tests/test_deprecations.py": "a842094c9aeffadbc04ad07f46e411967b7b0efaf69f4df8c30f067a45066642", "numpy/ma/tests/test_extras.py": "e25c3f3e366a40f0e2f9e7b5d0e80ad533575170b8318d94ad4aa9fbc5002ff6", "numpy/ma/tests/test_mrecords.py": "1bd469f1ba0f6b25be5fd17fc31c621d4572a5f9d7b0768b9db69fbecf9271d5", "numpy/ma/tests/test_old_ma.py": "2799916c33dcbd8fd954faa180f13273113d38e7cc00e77bba83139396226718", "numpy/ma/tests/test_regression.py": "fcebc0baf7033dc77d3cceec75c9c51ac4a6b48cca84f630220e985abd8e4c16", "numpy/ma/tests/test_subclassing.py": "97c202e4565f190c9c5f60cb5196605b7a4cc9276a8359e4b2ad00c6c63e3782", "numpy/ma/testutils.py": "1d69f3dacc7244e58aedfadcd5a4768183cc36c4d4004e5e4e0b1c8d3268361c", "numpy/matlib.py": "e45c9bae995b8123aa7447583e5230d0e40e7b324341fdf00036e687d457b1c5", "numpy/matrixlib/__init__.py": "52de88a9f8ee03e930c28e8704e6008058d75c2fe1ed857fdc7c83b0a33bd9d9", "numpy/matrixlib/defmatrix.py": "8ce552b26458ede8773335bba3835e1c6793f28d5c83ef29dcaa535a8f645c53", "numpy/matrixlib/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/matrixlib/tests/test_defmatrix.py": "f9c8032747bb44ca26691398c26390ff6b35682a650eaf790a3c453caf0de709", "numpy/matrixlib/tests/test_interaction.py": "04ca5a008786389e441075aea330627cdf25dc0bf944eea31a868f81dcd38aa4", "numpy/matrixlib/tests/test_masked_matrix.py": "ddc3cc6c50ead3e7d414d6823a1ab8c7b81ff9e2ea3bf000f3992fe152339d47", "numpy/matrixlib/tests/test_matrix_linalg.py": "93ab686d71478ea6db86cde84e90ae09cc7cee2949c74fb394ea69382cef8fca", "numpy/matrixlib/tests/test_multiarray.py": "4b9923cec411d98813d2a206acd3b59540e5de8fa1d0421d83f8375370a7b917", "numpy/matrixlib/tests/test_numeric.py": "859fabf76d560c6f0293c2a64faba58329231d4d5068663a829ac2d8e3e8faf8", "numpy/matrixlib/tests/test_regression.py": "5e77d9e11a134b8f57314c9494754c73ac1c58898d4636bb0d3d704dd124e36f", "numpy/polynomial/__init__.py": "8064b02cda4f0a95df3e08894ac815a15b09d004b573efcc5a518e7a21b9e6c2", "numpy/polynomial/_polybase.py": "6f49028938149bc0f9402fcb5929bac8dbf00bbf67a4301e92c2b4bd03dc8824", "numpy/polynomial/chebyshev.py": "7689f5b2d3f2413a150889711e988287bc2db7a66cca655acb2d12c56349667d", "numpy/polynomial/hermite.py": "9fc3c280cf8cb9e3a154161a878a718e838a18109e2592cb487b00d8c7494fe3", "numpy/polynomial/hermite_e.py": "6e8a61a907c03f284d6f0c7436d6eccff8d539aaef935c2d5d7c6a0057e80396", "numpy/polynomial/laguerre.py": "eef829ae2523aaba2dbc27130623b68f9e8f7547b0e1ad78e770ccdef810ca25", "numpy/polynomial/legendre.py": "d8ca00bf07de32dafb567b8cf134451c0acd15f20bdb0d5044c72b88829cc9af", "numpy/polynomial/polynomial.py": "752e5feebd565edbe05d57c803bd8044673671810507bcca922c82778a7e607d", "numpy/polynomial/polyutils.py": "68064957a6f465962e2b520a0cf1e188981299757f7948a48d7714a132c7c3b6", "numpy/polynomial/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/polynomial/tests/test_chebyshev.py": "1d8e61512fe5729148d0c54df3a6b8d3a35e18c256dd083dc1a2ebbb490a6033", "numpy/polynomial/tests/test_classes.py": "eadb9e0004dfc87c01bd0d784e4cc19578491e9b65804d00afce4998fa8b0418", "numpy/polynomial/tests/test_hermite.py": "c2f6ab1e3b034bb1ae3147a771a2ea256f34bace8e6642dafb7d8decb01c6f84", "numpy/polynomial/tests/test_hermite_e.py": "80e5b7c28e2de60781599ba0c4dd7b108978c140139b4bb255499cf58e489352", "numpy/polynomial/tests/test_laguerre.py": "4309d138fdad039ce4745c18d4b1ce83695853b05a1a887e709dff3c45503b99", "numpy/polynomial/tests/test_legendre.py": "e7299740487044298f3445ae038ec9fc1a82144ef13716e941d53aaed3e80228", "numpy/polynomial/tests/test_polynomial.py": "df44a45dc7b881efc0b9f77bfb1040ba3fad5a5b35777f7ac0b7140fa97b9dca", "numpy/polynomial/tests/test_polyutils.py": "01d079423562086d8e725f46ab850b847d4a8fb71e41d911f431cb83ca8eda82", "numpy/polynomial/tests/test_printing.py": "1e8c71a0f2586154ffd4378b8c0625369e27e798c6ce63a0a1edf9e91454da78", "numpy/polynomial/tests/test_symbol.py": "4a105d360f5cbd8cb7d5f427ae7e20a6b654483d2c873e6bf33946f0212aee0b", "numpy/random/__init__.py": "585ce7b73b5454d6a25c2a50967f2dc322fc1d214d4bb5c0589949b105e06ea9", "numpy/random/_bounded_integers.cpython-312-darwin.so": "98824c15dbb99837be5f5184c9527881d82cf8c3c2637b46153915df5c6620f0", "numpy/random/_common.cpython-312-darwin.so": "8e178d437002b05a0b6ac401eae2dd21b4e76238521e83b504016350081682e5", "numpy/random/_examples/cffi/extending.py": "9c60ebc71d04f0bfd8fc28ad63dfe4846213ffe978e382b278d2e011b333b801", "numpy/random/_examples/cffi/parse.py": "3caf6f754c709af76716f1f7acea609e7a484b09e277bae2e573a606b316a49c", "numpy/random/_examples/numba/extending.py": "67b67f5e9ec73c4e0ae4167b030a59dbdaafb9fb45024be132d357e77b6530cc", "numpy/random/_examples/numba/extending_distributions.py": "7dd78f5de523e3ac972b430ad5cb33c541d088e4e236e36cadb66a3f0e00746b", "numpy/random/_generator.cpython-312-darwin.so": "82901230f84418c143328f74ce4ec9716044ad43f8a7ea6b146667bccf103f8b", "numpy/random/_mt19937.cpython-312-darwin.so": "1d03fcba1629253346ab44b8dcddb2d5a1dc540dd5d1dd5bd4c09de5f01633b3", "numpy/random/_pcg64.cpython-312-darwin.so": "79f75456a336b149bfcdd5ee4249ed4aec40c34938c0aabf682e2de48af21639", "numpy/random/_philox.cpython-312-darwin.so": "38165d856ef21850a3742bd438d9b990e1ad1784e7c4e381b8fa642729a08b0e", "numpy/random/_pickle.py": "2ede3b99afef9e72477674257398d9fc3a811ec74a8b442250d68890c7fde6a0", "numpy/random/_sfc64.cpython-312-darwin.so": "0a66ab6722069911b13548318daa4295a20d75a9fc31aee8c1eb135fd5b39fa5", "numpy/random/bit_generator.cpython-312-darwin.so": "55ec70de8b9331a9cc154aa202df236b93e8d76eff18f33fcda61790670af945", "numpy/random/mtrand.cpython-312-darwin.so": "5c7fe2992282d3917162a8a2e551748d3ff88f39a1e7ace868e5ff181c52928b", "numpy/random/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/data/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/random/tests/test_direct.py": "179f4a5d033f2079c4cdb8873c4c523e6d608d0d07067044a742dff56f15ff4f", "numpy/random/tests/test_extending.py": "d9d4ba1a2cc824a20919e91af45f8e566c0aaa6ce857c1c2c966172b64a64b45", "numpy/random/tests/test_generator_mt19937.py": "853efa839354a0358e2d157c953e23e19ca4d4a452730b644c9d38ccad2f9931", "numpy/random/tests/test_generator_mt19937_regressions.py": "8e3caec68bcb737757c17f08d3b267d485e68d61869453b974996d8df8925ca3", "numpy/random/tests/test_random.py": "91696cad0285f57d9491208a7e8f9120693767e63a001f2792f2efba18db497c", "numpy/random/tests/test_randomstate.py": "27973623ecaafa5d2a77b6c336ecf24dccfaa16dc7c35d24a3227a2307211213", "numpy/random/tests/test_randomstate_regression.py": "4bdc5733ceed86475af44514af2cb868047a439683534f08e31f45e32480eaa5", "numpy/random/tests/test_regression.py": "0000a9c84a80c2e19677493928eecef94773288da3517e837e76ee75d97ffdd9", "numpy/random/tests/test_seed_sequence.py": "4ebe1aef37dc7bcc31a1e6d9343fce5751cf063395dc58f0af563fe81c9beaf2", "numpy/random/tests/test_smoke.py": "047275f9a9d82939e9371dc7037f59f116489197846125945504bf1414b219c4", "numpy/rec/__init__.py": "90d0186284800348b3a545516fed7cb09c3e88ab45ab6465d94e52387de91d13", "numpy/strings/__init__.py": "a36ef01d6f2319a51f6c3a294b2126603e918dea37dc0ce4181053816ae5187e", "numpy/testing/__init__.py": "12a7be3b1fb7252aa4e904679cf3c52c25bd224aaff4eb890e19e6dae18cdf37", "numpy/testing/_private/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/_private/extbuild.py": "a45bbc8e1e26134835cd45a91e03edf2367e2b8178f5e09030ef72b630510557", "numpy/testing/_private/utils.py": "b55731515d2b64349472e88dbefbf18b7791e14fb5234c7d0b10f9ece07cbfcc", "numpy/testing/overrides.py": "07c63c3e5a6f2bbd48712ba8b9b5d68f82f935598b5529fb58c8352fbc593bc9", "numpy/testing/print_coercion_tables.py": "49ba0d9822dce45c95f9447c80a8c97363c8a233755d04ef1f45b30eaef93363", "numpy/testing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/testing/tests/test_utils.py": "adba8f20093d2dfdc1b5ccc891999bd6a367d83d2c79dd333064280442342e3a", "numpy/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/tests/test__all__.py": "0176d3f5599149362af5b79b6b87751289bf57d4955d712da6405d116d970aa5", "numpy/tests/test_configtool.py": "556d23e06cfce6de7d0c63b0a64918f480f4c923cb918eacf472c20e511fbc32", "numpy/tests/test_ctypeslib.py": "9b7265f3ede31613aaee88a81fa61076f9bc09775d4b9ec82a3ca7a666357498", "numpy/tests/test_lazyloading.py": "759f87ee3fccef639349f021de5247a6fbdbe64480e943c3c92af1857daea049", "numpy/tests/test_matlib.py": "44c76e4861c126e5459a4fff520fe155e183e3e6377f6f06d2d943b7c17b93b7", "numpy/tests/test_numpy_config.py": "e8710a0e60e251b4740d0819a1a7b138edf252f0e17344513ec238ea18dc52f4", "numpy/tests/test_numpy_version.py": "e8f21e212c7dfc7825a71737cba2ae81e02007878192e642f831655ede0ba1c0", "numpy/tests/test_public_api.py": "523ab20ef015e53761f5cbbdaac6fa4ce4f4506fdfa697001aeb58d55cf131cc", "numpy/tests/test_reloading.py": "1d4e90b68c6c91dd93749a2012dbff476e46aa4c25c09dd0d43bdf9fde09c166", "numpy/tests/test_scripts.py": "95e3d1d12b06e6c4313ef1e61313c798c861740e15b9976d5984c637042b3682", "numpy/tests/test_warnings.py": "ceae4bf7a8d36440e56af7eac44db442188cfd72e9f7b68e8741455a2550f482", "numpy/typing/__init__.py": "6e4a28e8b4a221250cb6f4c6423f568c439da1c1a236e7563dff818675b0f82a", "numpy/typing/mypy_plugin.py": "efe6277d69ebd6b47e48440c42f188b3bdd9e410cf7282af3f2d89a80f50411e", "numpy/typing/tests/__init__.py": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "numpy/typing/tests/data/pass/arithmetic.py": "9d9a0cb388e2cfc241b4ea129bdfc5dddc2c35d856e3a092b3b4773116bb3196", "numpy/typing/tests/data/pass/array_constructors.py": "4cd70c920f5be437b39e6eaae88830eeb0e9c195c80e4bff9a396d2e72382bed", "numpy/typing/tests/data/pass/array_like.py": "3b611860e7c16b938036e6b0ae30ba189f6badebbcf847be41233b3ae779f29a", "numpy/typing/tests/data/pass/arrayprint.py": "cbf2a4b8bcf5b8cee9bf9dea7eaec640ebae7782e85c4ddaa4ad70b4045d5723", "numpy/typing/tests/data/pass/arrayterator.py": "1ba0dd34451d24640d262bcf8a67296712477ecd24a34849d2b5cbe180f9db14", "numpy/typing/tests/data/pass/bitwise_ops.py": "f9fde6c9e248b548e83b40895c1c080f0620e2160286c0cd2bbad256970ca4c5", "numpy/typing/tests/data/pass/comparisons.py": "ad95d91ea062a5fd77b663a51fb4950a70e3a101ac9284e89c3c585a7e9659b2", "numpy/typing/tests/data/pass/dtype.py": "603b9801bd282a825cf5e3a7289ba83df2db20a3a011d134e3f098c514b85392", "numpy/typing/tests/data/pass/einsumfunc.py": "7978f92f93163ed40782b1cfb09dfaaaaae6047a9cb7d528ba38c90af1e71759", "numpy/typing/tests/data/pass/flatiter.py": "e857625daade8a3b3ebbb453e6211630364a1b6f48ec39e5de94ebd313010cee", "numpy/typing/tests/data/pass/fromnumeric.py": "77f8552f2ad50c53d5c77ddaa8b23200661843c5c0245233ac0b04f100a8a1fe", "numpy/typing/tests/data/pass/index_tricks.py": "2047759dd5e6c0f092dc46b332570fec5a9cd1fb28e1227756e93b77f51e7cbd", "numpy/typing/tests/data/pass/lib_user_array.py": "88f7a448def9fec56130f35928e9452d6d61f0cb3699803eb3277f91e5aeb3fe", "numpy/typing/tests/data/pass/lib_utils.py": "6e3d6c100e20b267b3a9b61da8a9d5b4acd8fdf6fae30ecf12867036f69a51d0", "numpy/typing/tests/data/pass/lib_version.py": "1e7b863b1eed400fdb731148277751a0c011d1fa1c931838946a90e20ecb188c", "numpy/typing/tests/data/pass/literal.py": "37555548a60e053a4ed48a3bf3f3e3cbd7b752971fc2ef830ff70d7f59b26ef4", "numpy/typing/tests/data/pass/ma.py": "cbdd1e782bcecdce0986bc0cdce3c1bf63ecf847311cbccb3acc7f4042ea8e94", "numpy/typing/tests/data/pass/mod.py": "3c08ed41a054b10b7eec778b66d7dd99749f2e8a2d70b391e04f99c2d19b9147", "numpy/typing/tests/data/pass/modules.py": "83d3e1c8b3baadf9581d9b66af2c755564ee6e984de1300f5127e8898ae24ea1", "numpy/typing/tests/data/pass/multiarray.py": "70e6cc286f4239fb3657d6f605edb9357f2cd00e99e85935a5e3c01637b27d4c", "numpy/typing/tests/data/pass/ndarray_conversion.py": "628e2a64e5ecf59907c4ea840e76ec0e8d955c5e04d84fd1645b9ddadf7e4665", "numpy/typing/tests/data/pass/ndarray_misc.py": "584c82c8a0636c3e2aa5aa091801e9d6d8612c290765310fd330b02da0960b5b", "numpy/typing/tests/data/pass/ndarray_shape_manipulation.py": "b2bfcab9e1c58e0f5a3be2723b759bef6d86b3f3ae5d5b0bd5ae47931d776c02", "numpy/typing/tests/data/pass/nditer.py": "9d83b8e4bc3764d6d0abbe5586df3acf32d9e1c5b33f79a5d2bc433e562df3ff", "numpy/typing/tests/data/pass/numeric.py": "8316f301067ff37a1cf42690a2ed836906471d6545242ab4a095f012f6b3ec67", "numpy/typing/tests/data/pass/numerictypes.py": "eb1e9e37dfb936c49051273aadfddf622792da9a18118d2dfee8dbc2017d4b94", "numpy/typing/tests/data/pass/random.py": "20c1c5194cb618bcc9706933e80e9b60d6273b9c9f2ebd0866a97e7043573ec0", "numpy/typing/tests/data/pass/recfunctions.py": "59202eacc00b5afcfce79f6312f180678a05cf78acae06eaec076e9721ea6fa0", "numpy/typing/tests/data/pass/scalars.py": "a0191df4817c472a35c64ef49b1e6aec5aef369d3bc07695abd2459307272509", "numpy/typing/tests/data/pass/shape.py": "183bf5ebf19372f8610cc4c1ac616f786aa9abd1caa3ec9b1a8d1bff1734ddda", "numpy/typing/tests/data/pass/simple.py": "df82747cd198bd947a582ac29c222aeafd70df9edde7e91f632a23e792c9d5b0", "numpy/typing/tests/data/pass/ufunc_config.py": "bb35ce84297d3782cf57d855d88aa0fec92090a31b04f045d065cf53d10c7ae1", "numpy/typing/tests/data/pass/ufunclike.py": "dc11ed2711b286ac749a09413f2c287c2dcf62c293b87861ac663d66bbf04796", "numpy/typing/tests/data/pass/ufuncs.py": "d517a6fe07849b8ab20f75da440d4d00f2b0af762346aebccdb2250bf5e18bd3", "numpy/typing/tests/data/pass/warnings_and_errors.py": "1132d99034c6a59b29bf08d56006659c0d601f83c9e1b498e4f916cb14e3bac5", "numpy/typing/tests/test_isfile.py": "f414d37643a906fbdea52fcd5a11de8e7bface9ac06fe62844cac4ee43885c14", "numpy/typing/tests/test_runtime.py": "b38929505b6cb64becb248604c3cbf4cc5c935c3b72a05027c151b1596b44297", "numpy/typing/tests/test_typing.py": "a9dd97f56f4319577c42660e2fa2e27a85afa9d6b70b508308f73d2422979e54", "numpy/version.py": "2a6201cf5d41c1ddefd7d267a6499a268770a3addb258945fa06b793621028e6"}}}, "python": "3.12.9 (main, Feb 12 2025, 15:09:19) [Clang 19.1.6 ]", "sha256": "579aa5d127d0e019f205170f54b96772c4e45e845d251160de6ea64857a05af2"}, "architecture_sha256": "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87", "before": {"page_bytes": 16384, "reclaimable_bytes": 22907289600, "swapins": 0, "swapouts": 16, "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    24830.\nPages active:                                1067770.\nPages inactive:                              1142816.\nPages speculative:                             45808.\nPages throttled:                                   0.\nPages wired down:                             180495.\nPages purgeable:                                1678.\n\"Translation faults\":                     1124543629.\nPages copy-on-write:                        68091045.\nPages zero filled:                        1949979355.\nPages reactivated:                          93609777.\nPages purged:                               10854173.\nFile-backed pages:                           1371642.\nAnonymous pages:                              884752.\nPages stored in compressor:                  1141260.\nPages occupied by compressor:                 623595.\nDecompressions:                             23392708.\nCompressions:                               33136452.\nPageins:                                   627889891.\nPageouts:                                     336303.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128264.\nPages tagged resident:                         89602.\nPages tagged compressed:                       38662.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          291.\nPages tag-storage non-tag pageable:            92707.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5694848.\nTagged compressions:                          440855.\nTagged decompressions:                        363755.\n"}, "memory": {"current_bytes": 154485504, "lifetime_peak_bytes": 154485504, "rss_peak_bytes": 120176640}, "dim": 64, "base": 10000000, "start": 0, "rows": 512, "reference_sha256": {"inverse": "2fb3c351f0a3fc12c0b204e77660cca2c1bc373dae37f5d0a2bfe2b92cef1248", "cosine": "20be5bf2cc1ff4c4208827d99c0f95adb511816556777bc1e965fe782703fd60", "sine": "3887752075ec29f866d82da8322cba01421caec5a6c257aa1eaa6f708280aba7"}, "fixture_sha256": "d5bc1f5e12ad771e28c0a39ba45d183e3321f178e1a51cb9763cbe1203cca2a9", "observations": [{"mode": "fast", "source": "uint i=thread_position_in_grid.x; output[i]=metal::fast::pow(base[0], -exponents[i]);", "different": 23}, {"mode": "precise", "source": "uint i=thread_position_in_grid.x; output[i]=metal::precise::pow(base[0], -exponents[i]);", "different": 0}], "qualification": "unproven"}
````

### vq-rope-reference-v1-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-prefill-arithmetic-v4-supervision/identity.json

Original bytes: 2282. SHA-256: `db40b0758f7c2101e929269a01d48d293892e11930b2ee9803dff087e3710565`.

````text
{
  "command": [
    "<HOME>/Projects/slotstream/.build/quantization-research/frozen-prefill-model-v4/slotstream",
    "quantization-check",
    "--kernels"
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23007199232,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    21070.\nPages active:                                1075762.\nPages inactive:                              1147174.\nPages speculative:                             46032.\nPages throttled:                                   0.\nPages wired down:                             171655.\nPages purgeable:                                6542.\n\"Translation faults\":                     1124558401.\nPages copy-on-write:                        68092168.\nPages zero filled:                        1949991586.\nPages reactivated:                          93609777.\nPages purged:                               10854173.\nFile-backed pages:                           1376636.\nAnonymous pages:                              892332.\nPages stored in compressor:                  1141259.\nPages occupied by compressor:                 623595.\nDecompressions:                             23392709.\nCompressions:                               33136452.\nPageins:                                   627890724.\nPageouts:                                     336303.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128374.\nPages tagged resident:                         89712.\nPages tagged compressed:                       38662.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          272.\nPages tag-storage non-tag pageable:            92726.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5694848.\nTagged compressions:                          440855.\nTagged decompressions:                        363755.\n"
  },
  "removed_override_names": [],
  "scope": "functional distribution pilot; no timing qualification"
}
````

### vq-prefill-arithmetic-v4-supervision/receipt.json

Original bytes: 2135. SHA-256: `ed17650a2d1ef18b8fde857179e013fa5d46bd9b834c8acbd8b6921cb565cde2`.

````text
{
  "exit_code": 0,
  "failure": null,
  "sampled_peak_bytes": 480281632,
  "samples": 78,
  "after": {
    "page_bytes": 16384,
    "reclaimable_bytes": 22914301952,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    34812.\nPages active:                                1067307.\nPages inactive:                              1147487.\nPages speculative:                             30980.\nPages throttled:                                   0.\nPages wired down:                             180540.\nPages purgeable:                                1698.\n\"Translation faults\":                     1124595516.\nPages copy-on-write:                        68093535.\nPages zero filled:                        1950029305.\nPages reactivated:                          93609781.\nPages purged:                               10854184.\nFile-backed pages:                           1362068.\nAnonymous pages:                              883706.\nPages stored in compressor:                  1141258.\nPages occupied by compressor:                 623595.\nDecompressions:                             23392710.\nCompressions:                               33136452.\nPageins:                                   627891215.\nPageouts:                                     336313.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 128364.\nPages tagged resident:                         89702.\nPages tagged compressed:                       38662.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5298.\nPages tag-storage free:                          198.\nPages tag-storage non-tag pageable:            92800.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5694848.\nTagged compressions:                          440855.\nTagged decompressions:                        363755.\n"
  },
  "seconds": 4.6013280409999995
}
````

### vq-prefill-arithmetic-v4-supervision/stdout.txt

Original bytes: 19649. SHA-256: `12c43f176d2195882d0662a09ded885b7e422015bf75cebc8aa620eb4d9182b4`.

````text
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
        "name" : "complete 3.2 regular record bytes",
        "passed" : true
      },
      {
        "name" : "swapped projections have equal byte counts",
        "passed" : true
      },
      {
        "name" : "equal bytes cannot alias different allocation classes",
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
        "name" : "D8 requested order and duplicates",
        "passed" : true
      },
      {
        "name" : "D8 scalar BF16 result",
        "passed" : true
      },
      {
        "name" : "D8 unpadded row extent",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "maximum request stays bounded",
        "passed" : true
      },
      {
        "name" : "maximum duplicate request reads once",
        "passed" : true
      },
      {
        "name" : "cancellation refused",
        "passed" : true
      },
      {
        "name" : "short row refused",
        "passed" : true
      },
      {
        "name" : "failed gather not published",
        "passed" : true
      },
      {
        "name" : "no partial cache survives read failure",
        "passed" : true
      },
      {
        "name" : "nonfinite scale refused",
        "passed" : true
      },
      {
        "name" : "D4 requested order and duplicates",
        "passed" : true
      },
      {
        "name" : "D4 scalar BF16 result",
        "passed" : true
      },
      {
        "name" : "D4 unpadded row extent",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "maximum request stays bounded",
        "passed" : true
      },
      {
        "name" : "maximum duplicate request reads once",
        "passed" : true
      },
      {
        "name" : "cancellation refused",
        "passed" : true
      },
      {
        "name" : "short row refused",
        "passed" : true
      },
      {
        "name" : "failed gather not published",
        "passed" : true
      },
      {
        "name" : "no partial cache survives read failure",
        "passed" : true
      },
      {
        "name" : "nonfinite scale refused",
        "passed" : true
      },
      {
        "name" : "D2 requested order and duplicates",
        "passed" : true
      },
      {
        "name" : "D2 scalar BF16 result",
        "passed" : true
      },
      {
        "name" : "D2 unpadded row extent",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "invalid IDs refused before I\/O",
        "passed" : true
      },
      {
        "name" : "maximum request stays bounded",
        "passed" : true
      },
      {
        "name" : "maximum duplicate request reads once",
        "passed" : true
      },
      {
        "name" : "cancellation refused",
        "passed" : true
      },
      {
        "name" : "short row refused",
        "passed" : true
      },
      {
        "name" : "failed gather not published",
        "passed" : true
      },
      {
        "name" : "no partial cache survives read failure",
        "passed" : true
      },
      {
        "name" : "nonfinite scale refused",
        "passed" : true
      },
      {
        "name" : "unsupported PLE geometry refused",
        "passed" : true
      },
      {
        "name" : "unsupported PLE geometry refused",
        "passed" : true
      },
      {
        "name" : "unsupported PLE geometry refused",
        "passed" : true
      },
      {
        "name" : "unsupported PLE geometry refused",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-ple-storage",
    "passed" : true
  },
  {
    "items" : [
      {
        "name" : "verified tensor geometry",
        "passed" : true
      },
      {
        "name" : "bounded tail read",
        "passed" : true
      },
      {
        "name" : "maximum read",
        "passed" : true
      },
      {
        "name" : "invalid tensor read refused",
        "passed" : true
      },
      {
        "name" : "invalid tensor read refused",
        "passed" : true
      },
      {
        "name" : "invalid tensor read refused",
        "passed" : true
      },
      {
        "name" : "invalid tensor read refused",
        "passed" : true
      },
      {
        "name" : "invalid tensor read refused",
        "passed" : true
      },
      {
        "name" : "invalid tensor read refused",
        "passed" : true
      },
      {
        "name" : "unknown tensor refused",
        "passed" : true
      },
      {
        "name" : "cancelled admission refused",
        "passed" : true
      },
      {
        "name" : "cancelled read refused",
        "passed" : true
      },
      {
        "name" : "cancelled read publishes no completed data",
        "passed" : true
      },
      {
        "name" : "reader closure owns verified descriptor",
        "passed" : true
      },
      {
        "name" : "path replacement safely refuses changed descriptor metadata",
        "passed" : true
      },
      {
        "name" : "in-place mutation refused",
        "passed" : true
      },
      {
        "name" : "same-size corrupt payload fails complete hash",
        "passed" : true
      },
      {
        "name" : "truncated owned file refused",
        "passed" : true
      },
      {
        "name" : "truncated admission refused",
        "passed" : true
      },
      {
        "name" : "symlink file refused",
        "passed" : true
      },
      {
        "name" : "FIFO refused without waiting for writer",
        "passed" : true
      },
      {
        "name" : "directory refused",
        "passed" : true
      },
      {
        "name" : "wrong header hash refused",
        "passed" : true
      },
      {
        "name" : "oversized header refused before read",
        "passed" : true
      },
      {
        "name" : "invalid header 0 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "invalid header 1 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "invalid header 2 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "invalid header 3 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "invalid header 4 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "invalid header 5 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "invalid header 6 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "invalid header 7 refused before tensor use",
        "passed" : true
      },
      {
        "name" : "overlapping tensors refused",
        "passed" : true
      },
      {
        "name" : "uncovered payload refused",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-tensor-file",
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
      },
      {
        "name" : "fused d2\/k256 columns640 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k256 columns640 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k256 columns640 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d2\/k1024 columns640 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k1024 columns640 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k1024 columns640 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d4\/k256 columns640 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k256 columns640 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k256 columns640 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d4\/k2048 columns640 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k2048 columns640 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k2048 columns640 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d8\/k16384 columns640 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d8\/k16384 columns640 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d8\/k16384 columns640 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d2\/k256 columns2560 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k256 columns2560 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k256 columns2560 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d2\/k1024 columns2560 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k1024 columns2560 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d2\/k1024 columns2560 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d4\/k256 columns2560 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k256 columns2560 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k256 columns2560 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d4\/k2048 columns2560 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k2048 columns2560 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d4\/k2048 columns2560 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
        "passed" : true
      },
      {
        "name" : "fused d8\/k16384 columns2560 pairs10 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d8\/k16384 columns2560 pairs20 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused d8\/k16384 columns2560 pairs30 exact constant dot",
        "passed" : true
      },
      {
        "name" : "fused rejects expert out of bounds",
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
        "name" : "every finite BF16 bit pattern present",
        "passed" : true
      },
      {
        "name" : "every finite BF16 sigmoid output bit matches pinned Python GPU",
        "passed" : true
      },
      {
        "name" : "finite sigmoid outputs",
        "passed" : true
      },
      {
        "name" : "rounding-boundary scalar shape",
        "passed" : true
      },
      {
        "name" : "inverse frequencies matches pinned Python FP32 bits",
        "passed" : true
      },
      {
        "name" : "512-row rotary cosine matches pinned Python FP32 bits",
        "passed" : true
      },
      {
        "name" : "512-row rotary sine matches pinned Python FP32 bits",
        "passed" : true
      }
    ],
    "measurements" : {

    },
    "name" : "quantization-candidate-arithmetic",
    "passed" : true
  }
]
````

### vq-prefill-arithmetic-v4-supervision/stderr.txt

Original bytes: 0. SHA-256: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

````text

````

### vq-prefill-model-reference-3.2-capture-v1/model.json

Original bytes: 188455. SHA-256: `1c397b0c9f32e5477d3f60629aa4f8f4713b9fea81ef940ea6bcc19982c354a5`.

````text
{
  "schema": 1,
  "profile": "prefill512-decode1-v1",
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
      "vq_kernel_sources.py": "30929f4be32dd352a957a81deb22f7120dedce11ecd78fc3cdff4bb714ff4b0e",
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
    "sha256": "579aa5d127d0e019f205170f54b96772c4e45e845d251160de6ea64857a05af2"
  },
  "producer_sha256": "294918f5fc1004ea407c0af4c21cb20b7a380988cca94c83e7085e77b5f580ce",
  "passes": [
    [
      100,
      137,
      174,
      211,
      248,
      285,
      322,
      359,
      396,
      433,
      470,
      507,
      544,
      581,
      618,
      655,
      692,
      729,
      766,
      803,
      840,
      877,
      914,
      951,
      988,
      1025,
      1062,
      1099,
      1136,
      1173,
      1210,
      1247,
      1284,
      1321,
      1358,
      1395,
      1432,
      1469,
      1506,
      1543,
      1580,
      1617,
      1654,
      1691,
      1728,
      1765,
      1802,
      1839,
      1876,
      1913,
      1950,
      1987,
      2024,
      2061,
      2098,
      2135,
      2172,
      2209,
      2246,
      2283,
      2320,
      2357,
      2394,
      2431,
      2468,
      2505,
      2542,
      2579,
      2616,
      2653,
      2690,
      2727,
      2764,
      2801,
      2838,
      2875,
      2912,
      2949,
      2986,
      3023,
      3060,
      3097,
      3134,
      3171,
      3208,
      3245,
      3282,
      3319,
      3356,
      3393,
      3430,
      3467,
      3504,
      3541,
      3578,
      3615,
      3652,
      3689,
      3726,
      3763,
      3800,
      3837,
      3874,
      3911,
      3948,
      3985,
      4022,
      4059,
      4096,
      4133,
      4170,
      4207,
      4244,
      4281,
      4318,
      4355,
      4392,
      4429,
      4466,
      4503,
      4540,
      4577,
      4614,
      4651,
      4688,
      4725,
      4762,
      4799,
      4836,
      4873,
      4910,
      4947,
      4984,
      5021,
      5058,
      5095,
      5132,
      5169,
      5206,
      5243,
      5280,
      5317,
      5354,
      5391,
      5428,
      5465,
      5502,
      5539,
      5576,
      5613,
      5650,
      5687,
      5724,
      5761,
      5798,
      5835,
      5872,
      5909,
      5946,
      5983,
      6020,
      6057,
      6094,
      6131,
      6168,
      6205,
      6242,
      6279,
      6316,
      6353,
      6390,
      6427,
      6464,
      6501,
      6538,
      6575,
      6612,
      6649,
      6686,
      6723,
      6760,
      6797,
      6834,
      6871,
      6908,
      6945,
      6982,
      7019,
      7056,
      7093,
      7130,
      7167,
      7204,
      7241,
      7278,
      7315,
      7352,
      7389,
      7426,
      7463,
      7500,
      7537,
      7574,
      7611,
      7648,
      7685,
      7722,
      7759,
      7796,
      7833,
      7870,
      7907,
      7944,
      7981,
      8018,
      8055,
      8092,
      8129,
      8166,
      8203,
      8240,
      8277,
      8314,
      8351,
      8388,
      8425,
      8462,
      8499,
      8536,
      8573,
      8610,
      8647,
      8684,
      8721,
      8758,
      8795,
      8832,
      8869,
      8906,
      8943,
      8980,
      9017,
      9054,
      9091,
      9128,
      9165,
      9202,
      9239,
      9276,
      9313,
      9350,
      9387,
      9424,
      9461,
      9498,
      248044,
      9572,
      9609,
      9646,
      9683,
      9720,
      9757,
      9794,
      9831,
      9868,
      9905,
      9942,
      9979,
      10016,
      10053,
      10090,
      127,
      164,
      201,
      238,
      275,
      312,
      349,
      386,
      423,
      460,
      497,
      534,
      571,
      608,
      645,
      682,
      719,
      756,
      793,
      830,
      867,
      904,
      941,
      978,
      1015,
      1052,
      1089,
      1126,
      1163,
      1200,
      1237,
      1274,
      1311,
      1348,
      1385,
      1422,
      1459,
      1496,
      1533,
      1570,
      1607,
      1644,
      1681,
      1718,
      1755,
      1792,
      1829,
      1866,
      1903,
      1940,
      1977,
      2014,
      2051,
      2088,
      2125,
      2162,
      2199,
      2236,
      2273,
      2310,
      2347,
      2384,
      2421,
      2458,
      2495,
      2532,
      2569,
      2606,
      2643,
      2680,
      2717,
      2754,
      2791,
      2828,
      2865,
      2902,
      2939,
      2976,
      3013,
      3050,
      3087,
      3124,
      3161,
      3198,
      3235,
      3272,
      3309,
      3346,
      3383,
      3420,
      3457,
      3494,
      3531,
      3568,
      3605,
      3642,
      3679,
      3716,
      3753,
      3790,
      3827,
      3864,
      3901,
      3938,
      3975,
      4012,
      4049,
      4086,
      4123,
      4160,
      4197,
      4234,
      4271,
      4308,
      4345,
      4382,
      4419,
      4456,
      4493,
      4530,
      4567,
      4604,
      4641,
      4678,
      4715,
      4752,
      4789,
      4826,
      4863,
      4900,
      4937,
      4974,
      5011,
      5048,
      5085,
      5122,
      5159,
      5196,
      5233,
      5270,
      5307,
      5344,
      5381,
      5418,
      5455,
      5492,
      5529,
      5566,
      5603,
      5640,
      5677,
      5714,
      5751,
      5788,
      5825,
      5862,
      5899,
      5936,
      5973,
      6010,
      6047,
      6084,
      6121,
      6158,
      6195,
      6232,
      6269,
      6306,
      6343,
      6380,
      6417,
      6454,
      6491,
      6528,
      6565,
      6602,
      6639,
      6676,
      6713,
      6750,
      6787,
      6824,
      6861,
      6898,
      6935,
      6972,
      7009,
      7046,
      7083,
      7120,
      7157,
      7194,
      7231,
      7268,
      7305,
      7342,
      7379,
      7416,
      7453,
      7490,
      7527,
      7564,
      7601,
      7638,
      7675,
      7712,
      7749,
      7786,
      7823,
      7860,
      7897,
      7934,
      7971,
      8008,
      8045,
      8082,
      8119,
      8156,
      8193,
      8230,
      8267,
      8304,
      8341,
      8378,
      8415,
      8452,
      8489,
      8526,
      8563,
      8600,
      8637,
      8674,
      8711,
      8748,
      8785,
      8822,
      8859,
      8896,
      8933,
      8970,
      9007
    ],
    [
      101
    ]
  ],
  "boundaries": [
    {
      "layer": -1,
      "step": 0,
      "name": "embedded",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "09cbbdc6f63087c8b6e6822be2aa2854843b4908dc7d7129e04bd695044a87fd"
    },
    {
      "layer": -1,
      "step": 1,
      "name": "embedded",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "56cbf0adecea40b87a4e21ddfba4fc64c3b061eeb400a2c20e91a3c54024ff98"
    },
    {
      "layer": 0,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "ac10d21cfd551f897d8ad6a7a3451db69973c8410bd1b2685ece15dd0be20703"
    },
    {
      "layer": 0,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "8981b62090a11928fc6c440bb95f1fc9e96e3906da4f39149d4bae8d17d9cd8c"
    },
    {
      "layer": 0,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "709844dfd50713b068159ae2d10b89dfce1c0d711ee3f2e21993b6b7a268ade4"
    },
    {
      "layer": 0,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "993bd39584025dea163546c45acbdfec4d8258125ae22bba5f848be65cb966d0"
    },
    {
      "layer": 0,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "c8f546680e8991ebaa146786d1cdf3794eed4d6cd80022a9a33bbe60294142b5"
    },
    {
      "layer": 0,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "6ab35a0fb53693c4c76b7b8c23020bb1a2dad302705173dcd8eb031db6887822"
    },
    {
      "layer": 1,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "1722c95afa638b31991cebf324adf3ffa3dfd164c3d1d0ca5791fecbc48c6fcd"
    },
    {
      "layer": 1,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "7fa3ee43f232c2f7f9a54ec6215cd318a3809479a1bb9e08bcdd785f73a9d95a"
    },
    {
      "layer": 1,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "496c0529dc3db23a249f8ae3c7733406355c9a52aef94d776ac541f3e9499004"
    },
    {
      "layer": 1,
      "step": 0,
      "name": "ple_conv",
      "shape": [
        1,
        9,
        10240
      ],
      "dtype": "BF16",
      "bytes": 184320,
      "sha256": "79f7a448d6ba75fa851da9e23e13b742e29ce51be0d36adeff3cd0eb85f0de7e"
    },
    {
      "layer": 1,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "19689a22bd07e98c7fc5686aacbc59e17a26dbaaee8012622379d9432cb84d68"
    },
    {
      "layer": 1,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "8040c961ba07604e709e98a7b0647e2233ac9f2b14d771ace2410461057333a2"
    },
    {
      "layer": 1,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "7dcc10e5fb8de3290bb1335ec0a316d5bf4f9985032f4a4e01b534d1d1766773"
    },
    {
      "layer": 1,
      "step": 1,
      "name": "ple_conv",
      "shape": [
        1,
        9,
        10240
      ],
      "dtype": "BF16",
      "bytes": 184320,
      "sha256": "a62984d3643ee3393d19c153f1236e1af6046ea00194c56f7c4e9d1d62325cc7"
    },
    {
      "layer": 2,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "c733a7c7ec2d73b02ea90cc45e39425852622002d0ef87a9285e7e969f2e816c"
    },
    {
      "layer": 2,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "2904fcbc91993f2e127ab2023bc9dc6b11fbfaab423fdf9c90f55a8a7e4c2db0"
    },
    {
      "layer": 2,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "916e2a9b03641152868cc775649085da83f2fe922df295e4b6bb440a9b32ab48"
    },
    {
      "layer": 2,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "676a0f815c6df7bc2cffaf453554b7bf113d5fec5f787bb2167e06113f176cf5"
    },
    {
      "layer": 2,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "6ad283c61ba9d72b35c51b81f3afe7ebb1b6db94775a9038c16e0e635db76f2f"
    },
    {
      "layer": 2,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "ed75c11b2abec7a7455919b0ea7d2f5c960dc3b622475996baa2c92d7a36e382"
    },
    {
      "layer": 3,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "e8212ec42fdfa4ebc80b975a65ffc0a857a9bb3264b6eccb37e350c9e8d819c7"
    },
    {
      "layer": 3,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "fb90d83db74ca00cfc17337990f76919eb465ce61aee6a31cf0a1297374499ad"
    },
    {
      "layer": 3,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "dd3cdd0b038e84fc9ebd361426783cf36ace1f20fdd9dc17b6134650b7da8c64"
    },
    {
      "layer": 3,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "e2df2dc0205dd06f7afc78510ed8c90f2a6873eb62d576d566ffbee11230d6e6"
    },
    {
      "layer": 3,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "d7a9ca673f9b52c2a5fd330d085e82cca71c16e4a08c492f1cbc577a764701c1"
    },
    {
      "layer": 3,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "5361b0092fa37890245ebe1d479d90a7d8464bab36dd8a1a19b8d1eb6ecb9fc4"
    },
    {
      "layer": 3,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "3ab030123e7cd3e848dd80652337e8e95f9828376adc0648a88a64a6478752a5"
    },
    {
      "layer": 3,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "b326d10f5495cc63aef0827f56b40f2f398f67b5bb9aa426fcba67ab3325602b"
    },
    {
      "layer": 4,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "b3d1bead4202a4dab9c71973ea3743ebadf8430a04c830da9e6c918431124bd3"
    },
    {
      "layer": 4,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "6c49041af66977c620e9155feda25b8a5a32a2aaa38cd51a58f0ac069d50d6ff"
    },
    {
      "layer": 4,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "be442b7555571273eb8a683d7c0cbf406aa345e2decfc08c25f5123e802b74c2"
    },
    {
      "layer": 4,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "b027aac8e6733b340325828cd9bd2f72e83e6e2e4d77353638818aa3955ef205"
    },
    {
      "layer": 4,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "d2d5cbde2350e454ab03a46b1345d6ca0d7a70fe6fc2a29f220947fd03f5af8d"
    },
    {
      "layer": 4,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "212b8936abc4cc0e0eb5e6d72fc33fc03b3dc4a0b4d6444ed1932668ac9d1b89"
    },
    {
      "layer": 5,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "84b3e9e9d90fedc023e2bfc586f5d32853031e114b9cc4a1279e6d56f6c43ae4"
    },
    {
      "layer": 5,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "ac4ee55ab5fea0742dc31dc093d359f090a3f98e2582fff8f99ecd39c7eaba70"
    },
    {
      "layer": 5,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "9a3f8ec0eebca57fb7b94672156005de466c8745921e5954e4f6b4be21875269"
    },
    {
      "layer": 5,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "b9205a7387bbdd494a11e5faab3f48b75014d51fa01240a398959d01c121f8ee"
    },
    {
      "layer": 5,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "984460a0ca6d3ffb7e003de5cc4e92790394c7bbaebc5d706ff00949d01c11db"
    },
    {
      "layer": 5,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "56c12264986f839a7e061cf40ecfa925c2052b6e406678c4fc1c6c05ed99433e"
    },
    {
      "layer": 6,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "17d4439e077182bd86ec91ce754fb49a20406f1114c56237248867e0f0aa3717"
    },
    {
      "layer": 6,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "235950d94021d28070307d0072f59a87b68653cf12c48f3049974015b6fadc18"
    },
    {
      "layer": 6,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "3eefd09a9fa6e44eff926e73cca0f30faa94eb31b4265fa0d3a29835ac91d1d6"
    },
    {
      "layer": 6,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "e2ab23976f348c9eb2adb593867975fdff216fae9f6376b4665cbda4dc399bf3"
    },
    {
      "layer": 6,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "daa0be1c3d29cab27d73dba121aa1daca809c7a7c487ac35c078e30a92f2cbe9"
    },
    {
      "layer": 6,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "dd089bd92d4c55e46de4898722480964be01e1d86e046951d878441bfc3df232"
    },
    {
      "layer": 7,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "ff3c02b639e6a7cabb53abb9092bf810f1e5374b6574a442e93ae1e4102edbd5"
    },
    {
      "layer": 7,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "573b4968062e1c77b20759bb679068e3244263cdf080110544c0881f690f3d92"
    },
    {
      "layer": 7,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "5f7ba17f96923ce118ae2312f5106a403e4bc0b593f47794ea6d4bf0dbb5f595"
    },
    {
      "layer": 7,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "594a3716885c7aea8ba03fa04e37dfdabaf46a7debcdbf14058ec7b8bb850c29"
    },
    {
      "layer": 7,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "14af8d62c9498fcc61d1b5269c3c3ac220cdfaa71235ff324ede799e2a611647"
    },
    {
      "layer": 7,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "27f41b4337eb8610e811819f0c9bee4c938ed00a3a4c697599a66025937a53fe"
    },
    {
      "layer": 7,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "838ec7b91c831c9c9f720b6ebc130341bedfeb9174b69b93c54109a997573c4c"
    },
    {
      "layer": 7,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "c6b0931ea5706ee64ba8af0e73abcac463291f19aa6edfcec718cbce8f48d8eb"
    },
    {
      "layer": 8,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "32927d03877325927158b8de2a24cdaa534150a17129bddcd385ba97c88766d2"
    },
    {
      "layer": 8,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "a332a358e35c34681c9e7813a32aefd126c6e7c73522952ab7bb695e2fb69751"
    },
    {
      "layer": 8,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "4647dee59bb40dd3c05c85a385979d842c63f4d8f32a38e40b8f92f5990227d6"
    },
    {
      "layer": 8,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "1196ec252eee55f69d35c06844fdc53667b3f62ac921603f517813125703888b"
    },
    {
      "layer": 8,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "62dfbf7ae394c6620a6ce8c79bf9ec7c5f09b997e43ed7b258f7302515aa02cc"
    },
    {
      "layer": 8,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "efb80576dc5382c1acac375a96abbbbb5ecd7d102cf7532e347b2d64c244e321"
    },
    {
      "layer": 9,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "d07d5268416b8609a6c1f83ff7f83604062d9106fc75a75a319347a82ca6bd8a"
    },
    {
      "layer": 9,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "236cde03e59c6aabe0b8f00e2fa4eecf5910ce1a3d797a4e9e1af68412cf0b71"
    },
    {
      "layer": 9,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "bd3b20e823674eb21049c9fa596b10163baa1073932eb3b56fbff907388d3159"
    },
    {
      "layer": 9,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "35288956982654ab33c3de5d57dd3ef7cc8e82f45ba2aac3db09998145dfb7b3"
    },
    {
      "layer": 9,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "a825278546ff537a5e67757713f4d54f9d34bd1d1739106b6d47ad073a488090"
    },
    {
      "layer": 9,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "8becfd25d9b175a3939f99b4b3c3cd670f8f03a77b7cc296d34549ea7c22be09"
    },
    {
      "layer": 10,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "1dac0c00b3b4808a369c2ce57320c09c1e849581f98f680d3976d4f04cd63c0d"
    },
    {
      "layer": 10,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "f6f5772448c3bde93f0c5c6480236fd4d88e5cb7e5b9d9e912b13a888c5a284c"
    },
    {
      "layer": 10,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "8e6daafa81e733bae9ae183be5858ae477563b9e9bc0f32d158d31e6bea732ed"
    },
    {
      "layer": 10,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "d5736606bccfbf716848bb3d2f1f93928e89ecd6b2ed9dd55806d6beaed257dc"
    },
    {
      "layer": 10,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "38e0d366d32662d9e23111d2b50a7d48f34cf3b98d4af80c9b82e2624dee4c48"
    },
    {
      "layer": 10,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "b0f91900e357f51e59223bb8ee464155ee4196032017ac3635222bcd9ab5a9a6"
    },
    {
      "layer": 11,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "26ad2c1d16ab7b1ef20120f1a05ca9ae81505e880f7cd5494c89d01548b7dcc5"
    },
    {
      "layer": 11,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "cbf82662666e034bc6c085cfa81a6978e379e45921302f100bab0135d6f4714f"
    },
    {
      "layer": 11,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "5d9ff3816c8a51feb09a4e3a9af79dfd4f4aff60965f46c8f93589838f1487b6"
    },
    {
      "layer": 11,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "055bbc66ef1b06a149626dea3431b151c32e43eaca7403bce98519ec07a70bc2"
    },
    {
      "layer": 11,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "3d16f22cd2cde7f5cea69c991878d682258e51e3b4f29cf4be0cf5177ceb41b7"
    },
    {
      "layer": 11,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "acd373cfe470bbb44386f99d307321bdfae0671ac9404a5189d273f0f7ee59f5"
    },
    {
      "layer": 11,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "8a08a7731d4e610dd4279c5f28679982f02939ebe306683ee4ea8d7c4afbfbd6"
    },
    {
      "layer": 11,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "a31af4cfe128e3b84ffd13b069b6f260fcc82893e57d2c934fb4fe212a087c58"
    },
    {
      "layer": 12,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "4ed5b699d7b26d847c39c88f127f606cfc2136a0486e2b658b924762e3462cf1"
    },
    {
      "layer": 12,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "b2c436eb2dad76ccb282b80399c88722d711e5cc2548361e0185f0df70d81fe1"
    },
    {
      "layer": 12,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "c3f918b779e9db6ead1cd6f8e3ac29944561d2fb08ddb124dd64843215010882"
    },
    {
      "layer": 12,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "a69d3811811a920f6a785b5529198685f8e6a78bea10cc762a422f4a7d0e04d3"
    },
    {
      "layer": 12,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "23412cc4cff9b527583de97e675928d271b5f6baf0feb0ff3f96b70628d7db22"
    },
    {
      "layer": 12,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "ea8e642708b9360408f0e5e36864155db3ea3657b39d28ea523ab30dd62c5b9d"
    },
    {
      "layer": 13,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "93def14197bcdbc2e2f0364de324eb581e527c39177411a40e96c0fb6a643cc1"
    },
    {
      "layer": 13,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "e5ff2e454d1a9c517b52fff841d36ce781c2d46486fe35bead8dc4563b6640fd"
    },
    {
      "layer": 13,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "4ad88691a79673b37a37282f55aab563c49cc4a96518aa57e6ce7dc94193c965"
    },
    {
      "layer": 13,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "58aa36e46ff60df649a2e4a27226981f7a1c93cf0b7c84a00c1357b8b0723d2d"
    },
    {
      "layer": 13,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "8b491e804ae1d709ab402b4d23a0be7c6f4d990bce016de7d397e8505cfd3313"
    },
    {
      "layer": 13,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "058d4d6ac6a44f9df475fd8afbc23b839df7a5a8eb7435caedf3b783ef26381a"
    },
    {
      "layer": 14,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "9c8dd6b51fcdaa0487f9e9fcd566b5f9f9a616488013b1579cb764dc710ccf19"
    },
    {
      "layer": 14,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "1d2aec741a228098a6658902df8093d28280ebc7e38deb36ddbd31d9598babd6"
    },
    {
      "layer": 14,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "15aa087289356c3f7d08b6d96e998bb2fe8e3b3596135e8dcee4c29070f33b55"
    },
    {
      "layer": 14,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "02f637e574e25a93091e47be836844be270371d40e66f6e614bc2c672d81ee97"
    },
    {
      "layer": 14,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "d93cdadf4de0aa8f8aee77a9896ed0dd6577c30d1d1e5e5a4ced4dc7903591ef"
    },
    {
      "layer": 14,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "dcbda3d0a916a4a25d38fb937e24f9fa38a46932d3bb6346ad851c94fb9dd4a9"
    },
    {
      "layer": 15,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "ba4622a20f420bb33db5442054ddf87ac7147ee008a2746b83c5cf2b44b61a30"
    },
    {
      "layer": 15,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "2bf33ace2a1842ea19928e1b3e3833ede4aa907a21c36c59ee17f12abbb40751"
    },
    {
      "layer": 15,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "af127d8dcafee80f88ada051691d1453c57be22deba09e7740aabf511fe2953c"
    },
    {
      "layer": 15,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "c3b09af6147af8314f4149db2e1572cd00b6985f4527cb6d30cf540813165540"
    },
    {
      "layer": 15,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "c73ad3fe476ace8dce76cf243f589946192432d794eb5da7ae4f3286269752db"
    },
    {
      "layer": 15,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "eafc36cfb88707b1c6aed6858c160621a20e211e15af5e548eead18afc191ba9"
    },
    {
      "layer": 15,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "8b2cb74f49ca45a8a79ee005b840e6dcf466221a7e08a3e1c3e9f9db78052161"
    },
    {
      "layer": 15,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "1621e69822c72e7ae18e308c0070bd0704ec756bf2405f75a47e7f711d78aefe"
    },
    {
      "layer": 16,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "d6e54fdc7de15dcdd78f86ab74a1bf491fee6821f35c3201ceb08f6aeb6b91b8"
    },
    {
      "layer": 16,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "40e70775a1c2f311f5ca70c84b43a75620ad55ed4df207c5a3ce596a75b7bc07"
    },
    {
      "layer": 16,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "6bb5a5a5639bec7ef543e2aebb23068b26cc95d03282afba65cee86f38de3ee4"
    },
    {
      "layer": 16,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "b02b47ed5f6a81b43386d6adf7774db7d8198fc4acd869bfb7c7ad1a914d7900"
    },
    {
      "layer": 16,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "d0aeceb4c8954b79721938562e9ccb8807d3dd6f1c7369058df3e9fe629cc76f"
    },
    {
      "layer": 16,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "9583b581144360ed67a834a0ce41a41e9f62adfd40f1e0cd28e078442ad18b2e"
    },
    {
      "layer": 17,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "b47eb6097610eaa516e3cff0e1a366a7304b0cdf35437de3823262d93adf23fb"
    },
    {
      "layer": 17,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "9a0d1a55a79517e8d9bc562149595cd3e592f8fcfad88d2ff5d7d5d701769b7b"
    },
    {
      "layer": 17,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "b949e54a3b07bee948597aa646e1f1c183e5604c7202d1110f66e01245006cf1"
    },
    {
      "layer": 17,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "bb562e07abcf877670fabe42c5e4e7d74b7a2c6fdbc874d9c65cb371fd6dc4d8"
    },
    {
      "layer": 17,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "467586b3defbe230a4abf3eb44e9293b03e1623267f7876f46172f840566428a"
    },
    {
      "layer": 17,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "312b8bf8bb1a597b0b687838cd5224b1fdd98a70d3874afcaf67eab420f0cd45"
    },
    {
      "layer": 18,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "cb8d9a1341f6a429de0b0d715e9c0c9caf01eca45ae9b08050e5925a190f5a0b"
    },
    {
      "layer": 18,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "cb577f6ba82e0fd9c1381e2eabdf995385b7e5d3ed9ceadf41e45ddf6508526a"
    },
    {
      "layer": 18,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "52d112312612f38dc98efff14faa2b1d0f1078a4fbc0f40260ef66f2910647cf"
    },
    {
      "layer": 18,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "9df11f31d88f563bcbe428d38db33ab0c1432b8c44cf8096ccc327be6aa5c4d8"
    },
    {
      "layer": 18,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "714f8905e60832ac3038722b3613cb35cfc969a4eb6ffa512fc91e01a8a9d8ae"
    },
    {
      "layer": 18,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "9b0375f338165ff11d8db0f3e2b5b831488391689fb0a08b65017747020b0379"
    },
    {
      "layer": 19,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "68c48557b352a78eb141fced23d53fae2cf4d1d7dc99a5da552f2fc42181ffb6"
    },
    {
      "layer": 19,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "5839e4d2680bad05a1a00b22250d187a6e13ca3653ac49fcc89af3df54c045f4"
    },
    {
      "layer": 19,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "fdb5cd59d02650cbd8bb3e3dbc7a2256eaadd5754296d30cc2831df67b92245b"
    },
    {
      "layer": 19,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "3d223edd6d0353aedb477756e7c323c286eb06008811308828c554b4a2f098e9"
    },
    {
      "layer": 19,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "566182e204e54cf6a6010b7a5e675ae4d88c540e0368a6d2367243a4565db0fb"
    },
    {
      "layer": 19,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "902d320017cb08545b0e7e66b0d4c5671f3fdc3e56ad78db584bd34c2675891d"
    },
    {
      "layer": 19,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "95a42208c4b855dcf8e3aee39cf005dd74ad9733ec04289f70f708f6ceca796b"
    },
    {
      "layer": 19,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "1b099beb3c9d08f3ebe6626eb79bd3f54be6863182b9a415856f294d11336939"
    },
    {
      "layer": 20,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "9876e4e486a347fc4854823882587f9c18faf2c655bf55e4e1c3a31f65083707"
    },
    {
      "layer": 20,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "627eca759f6950cd79b3d5153dace8a98b9e53b0547a54b887d4968ce0ea3a8b"
    },
    {
      "layer": 20,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "1aad01047927b36ea426a6b2d39340c90951b1287db7217d56db10c5ecb5f789"
    },
    {
      "layer": 20,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "67504978783bfbecfb69abfb097ec528360f635f0fbb9afc80533f27ca52c074"
    },
    {
      "layer": 20,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "524e7faac2c460fb25c60f607fbf67e948b70a9519b6233ea101e5133ae54a35"
    },
    {
      "layer": 20,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "4f6f057acf162420a8d03cad43589c13cd717585db5d350f3145957ba2febdfe"
    },
    {
      "layer": 21,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "5e65168371ad5bce80120692e57d9175edc287231b428799ff9d661ddbe70d46"
    },
    {
      "layer": 21,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "4b922ceb235bc66fe8d88e7d82ea60ea23b74fbfd90abe0141d4ff393be1aeb3"
    },
    {
      "layer": 21,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "b7fd6e28d632f52cb32fc9e84206b111865c00d8f8f79a5a09db490798e57e45"
    },
    {
      "layer": 21,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "24a61f3d6c703b7f2e02d406627a9398436e806661a41b2e1933008ef272332c"
    },
    {
      "layer": 21,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "09a58f2a4c3da7e50a9b584dab748b9f23ef84bbb0083965e3573310827d42af"
    },
    {
      "layer": 21,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "f707fccee4bb871ebb2628746e043afe63a5a5f0dbee9095d50a373c9a58cd49"
    },
    {
      "layer": 22,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "ed6709ed6eba5bb6521eb8ad4e01b7393a633d0377e440b7efab6083c14d2fd8"
    },
    {
      "layer": 22,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "1e2c7f9216574a379572736db460eb41868337cc90a534f1258407dfcf6b2c02"
    },
    {
      "layer": 22,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "d20f29f95591922d98b1b15911208af20775671b93472faa36b0d8f651c42542"
    },
    {
      "layer": 22,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "54e59e16f6b53e4d95e7a02b91539f9949f7a9d5e2d23fb05e52c86c2066d5b6"
    },
    {
      "layer": 22,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "28305f69550fcca2826c2d84a0ec455c996d391c8ea2245c61889aa1b9507ee5"
    },
    {
      "layer": 22,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "a0937b65d53bb3a43934065032d58795aec0534fd11cd880f00fee1b21f4e4fe"
    },
    {
      "layer": 23,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "a73678dab13b1057b91f49b16c025cc1b0bc1d7de7331bf0d4670ea14fdd1123"
    },
    {
      "layer": 23,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "89d863b719343aa9af40ea267c5167f0f057325aed5f2f73c4ecb6263edeea39"
    },
    {
      "layer": 23,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "d733cfdd9cad053d01e5c0c36d355d8f8cb58904b92c6e6051ff335365650f89"
    },
    {
      "layer": 23,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "0ee7f446162236a319f524d7f0f562f3314978605a6e380bc3253ce112f4534a"
    },
    {
      "layer": 23,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "4882f31b7aaf272b50e0b1d70797b0961f729ec062e51416714081d5a64b7d5e"
    },
    {
      "layer": 23,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "01dfd378fa43be220d0ffe84443c99ce03a80cb26a49409bbce15ca06b45481a"
    },
    {
      "layer": 23,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "3ae50f92f677b70f8f8dfa40932cc151697e5d4274138ef19bc25021f777568f"
    },
    {
      "layer": 23,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "fdcb01791925cfdd6593e62b31aafa73497e7e0c37face05f3e78779ddfd3f56"
    },
    {
      "layer": 24,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "b1bd02932cfcccfbc9e596d861bba7d9dbc679dcdcfa2464fcc2803fb79594b3"
    },
    {
      "layer": 24,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "1186f84bedeba1414b3a1cf0ce24e26ca7779bce0f7ebd7de6245418a669a722"
    },
    {
      "layer": 24,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "b35e188d86ac6da3a2c6affa337ef0ebf22536855a658fe545c633be94425f68"
    },
    {
      "layer": 24,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "35dd738470bb0ed7709d210dd2e77b77ef92505c64d40f2d6894bcde05ff1f44"
    },
    {
      "layer": 24,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "bc609d35a7575496182f54541937c213432d006683325bfeca6e80dfa18ea78f"
    },
    {
      "layer": 24,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "aaf9f3ed4026b22f5ea0b68bd2a89ce19e82c37ca30bea31667f18e14fe4467d"
    },
    {
      "layer": 25,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "eaee772685ce169f7e9331105acf30ac6793c056cee90882918aad0e962e727b"
    },
    {
      "layer": 25,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "a2e2b1ad3f1d9d83651ff89fc4ad89d9ab941d71b2ac9aa2fd51d9d09dd08ae5"
    },
    {
      "layer": 25,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "14e0e2a1201d82fd2a2d08e1650cc9aba7113c648892d70da52c518534b1c7a9"
    },
    {
      "layer": 25,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "580d143ec97d132e30b1df569fea774cab6610cce8990f3242cf969d2163f946"
    },
    {
      "layer": 25,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "5fc2b164bcbc46449d8a22d84ff9df7dcb153c81112ab646438388c34c319945"
    },
    {
      "layer": 25,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "efe774512e07603d1070bd742b1f20c63445314ddd4b38c33b8a30cf1b2d8414"
    },
    {
      "layer": 26,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "14352e304491bb9ef405b27f3f5b82fe15a5009da980a0e4730e284cb58e97ba"
    },
    {
      "layer": 26,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "db56ecd2ffb0d66a7ea6dad188a6179b401a50f8fdb72da2b3754a5acf899b9c"
    },
    {
      "layer": 26,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "0a9920cb1ca7f7e82871fa4099be0d7102ae4380b90d1cce6a925abf2b1d41df"
    },
    {
      "layer": 26,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "22e4cbee48a8395ffc64e957c79e9498bd2db6f34e498dd5def5048347b62aa0"
    },
    {
      "layer": 26,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "caeae60552b971286f9781596beca538f9c923e74ddd816b87fde1a57dae06ad"
    },
    {
      "layer": 26,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "4b40936a41a71ab536596f9d839bc08d5a0005f645acdc0ce83fe62935caebd4"
    },
    {
      "layer": 27,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "caf3584a0c7f1adaf5718f3085ed6f14aa5539f926aa885f53604f98e98b0449"
    },
    {
      "layer": 27,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "b687fa520d887ff3494f2aabb6f17647f624974df08c6e0a183d7cb81c4d8d7e"
    },
    {
      "layer": 27,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "9b02f4371bef6a3e7262a93ac67cb1a8dcbb260c5589deafa94a5aa9c94f1b60"
    },
    {
      "layer": 27,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "13523c689dddc4d3ba9522a47bd9d53d2ef46d3466a169dc3cc9574f535e72db"
    },
    {
      "layer": 27,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "276c3576310e8e4c563f092626640607c75aa466730e0121577e90cf81175466"
    },
    {
      "layer": 27,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "207401c00e10e18a22776ce5c4d3d713e02622c1b76fae4d231057d994104eb5"
    },
    {
      "layer": 27,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "0bcc44d1fe10354eda82d04a3539553f745c026114cf0a65816ffc04cc86a966"
    },
    {
      "layer": 27,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "6c690e4bbc1d3190e34918a467fba29d8006f49b3f987fa0e732054d3213598d"
    },
    {
      "layer": 28,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "1c06ba91be71274514890872ec915a98d0a596db57f4f18582053d2693476be4"
    },
    {
      "layer": 28,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "c4d3951a54dfb2339aa6f94283612d3c3b3afc4a7c1cb888ef474e4027195484"
    },
    {
      "layer": 28,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "cb0f0ad4ff5d962fb23ffb8b8414b73c68f4b62ea418346790df56b9f7983c85"
    },
    {
      "layer": 28,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "c933754e3c3882a9eeaef2e28c3c0a60b9d40115dd7a64f0e664a0342296da7c"
    },
    {
      "layer": 28,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "7469c44f83516e1810296bcf240d01df398169fa609030fe61ed3ffe6aaf8f50"
    },
    {
      "layer": 28,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "feb32d20718159cbf8bc7da5242db7a24c99a51a159a2d301d7a8f354a328e1b"
    },
    {
      "layer": 29,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "93955b7fa922c005586aa9d401912033d8919c4f368abb2f04bf658019688938"
    },
    {
      "layer": 29,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "b90932e7bdbd29e013d51f05fc7c7c845c9dc6b68808a9318ec194734a7378e3"
    },
    {
      "layer": 29,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "ad56a90256dbc2dbdeccd0f0963dd5e12c57c41c4a5b1c34a8e9c2967524ef8a"
    },
    {
      "layer": 29,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "811b64388c6135b5a90aa2bde55f3aa0a175dbfbc6332196f64bd710163f0d94"
    },
    {
      "layer": 29,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "fdc60a6ed71dc79e078f9c684d79a9148a42f27ecc72e50330b498d70d470d8c"
    },
    {
      "layer": 29,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "d32ce41b95dd7dfc5c3a37659fade1c335afe7aab5b8b8e598b796de9f406c55"
    },
    {
      "layer": 30,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "30e7811a05af18b12492506826bdd457e1b11781b640128ab39de5fd7efb0585"
    },
    {
      "layer": 30,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "6bbed1058fcc42dcc24ef61abf3ee07a63d397529ab79027077aa345a5efd4e8"
    },
    {
      "layer": 30,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "005cc5d57b93f10830044a75f81dfbe8db3598db3ad74c59cbc7cb5e6f5dddbd"
    },
    {
      "layer": 30,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "4b0219882891d56579f0f28c1d10b32c4d1ec284ca8aca975892ce6adc8f7d06"
    },
    {
      "layer": 30,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "2735e7f4c128733a0b7f1715dbcee415b78cf0bbaeb66f137a1b1b6924521bcf"
    },
    {
      "layer": 30,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "83c558ab5dfd6cb5fc44d5b3cf2ff7edc7b154552cf8b2d784c0d4b96091b1f6"
    },
    {
      "layer": 31,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "03571bfd3b7a1ed367d16d93fd1ff0a38a511245a6c7eadde7a55d946000da5e"
    },
    {
      "layer": 31,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "64609e4f87aef0f4514900d374e8a6b374a3fc7fd47e0dda7414bf2d460afad3"
    },
    {
      "layer": 31,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "7bbd574aed3471c5ac9bb2862c22b154449ea2339e29847325bde2a292c15594"
    },
    {
      "layer": 31,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "aa303ac48e8c46472a2188736dd4844c8049b8a5b2a039b77b2bd18fa00c2d40"
    },
    {
      "layer": 31,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "f15f6f994bba7f11f55b127d51bd73f6bd482b979618b4cab1a5c958f70c7488"
    },
    {
      "layer": 31,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "b01008d5579020563231aa9fc7926b0459f9c8db11352991e13bb31f3907d0d2"
    },
    {
      "layer": 31,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "acc51dc5fb98ac7ce4b98bbd37ad441079e56d652d23938dcd6a7ef872992da6"
    },
    {
      "layer": 31,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "e5554608a03564c7febcaf891d68dea75f37778d138c908ae2f1654764dcf140"
    },
    {
      "layer": 32,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "a4b67fdd04971173618c4e71c2f32f226425d7c18dfb60500ad0111a132e39ba"
    },
    {
      "layer": 32,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "5c40c9c4671b9d2ae0cbf31979af4361b3beebaaa122aa4d26640d4c58f677ab"
    },
    {
      "layer": 32,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "c89f784418096860d451f23c2c9736381873014f37ac5370ad4e957577256cce"
    },
    {
      "layer": 32,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "f2b6773ad54d57a7d011e7997ef715935d2f509abdb3c4ee62c777c91ea72b1d"
    },
    {
      "layer": 32,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "a117cd54075ab0d989364f61165af0d87f0ffb987836d74b2f99f8db38c8f49c"
    },
    {
      "layer": 32,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "558f3a1d7c6ca3c7f30b26f75a3be7b0ade6f3faeab96928a80d8669b66571cc"
    },
    {
      "layer": 33,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "1a8b1252cc2ad2ac3d7e779b5071c6b0d09a1205b2f3614c8fb79cfae42a2b59"
    },
    {
      "layer": 33,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "98d3d91748e27ce3f55870b99aa7935e505f7cd62d2c7341eec4331dbee83c95"
    },
    {
      "layer": 33,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "b709fa2fba7fc012a2062c9e64cb9cee1c57f9950418366adc7d3cd32b949d47"
    },
    {
      "layer": 33,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "78972e4e84d43f927a73626f1a135cbf26597af7be628153f26883ce51b837f5"
    },
    {
      "layer": 33,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "74eb2d84b1296a2a0bd05027948c7b4c158a90defc9623b687220aef8302ef02"
    },
    {
      "layer": 33,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "a9bd57811332bf78fdd4e55d832f960328474767a6e8f50d1288ab0365af46ac"
    },
    {
      "layer": 34,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "9678684618893e52295a25074797afc891c9c37ed16743ff3a3a31615c07e4de"
    },
    {
      "layer": 34,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "d46ee23ba83caa7176519df7bc04d1c58596e05fe59ddea784ca0ce9f5781b83"
    },
    {
      "layer": 34,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "c1a129a06aa667f25fb94c3d5fe218e04e3336a688e5bd7c03b9a0bb18e2f4cb"
    },
    {
      "layer": 34,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "ca088cf40e1eaa4309b2635af6658d6119d7c8351eac6fb685e4c8043f83e807"
    },
    {
      "layer": 34,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "75b335ba498b11b628bef88b54c36c5e1c81ff0dabb7a6be3251883bca2c686b"
    },
    {
      "layer": 34,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "f31437f9f9936b5f760d0a6fb16339b4e4ec67186e700aa1d170cebb1fb7995b"
    },
    {
      "layer": 35,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "66be0eef01ce95f38bb36719e3018a2d0d3b12f007cd02e3718d21aa20d6947b"
    },
    {
      "layer": 35,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "9ce8d386567decf429255aefd231a9d79c28947bb0b4dee274f6de2cde9fc5c9"
    },
    {
      "layer": 35,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "12839b87576716072281a34ec258d215f7ef63a55c2720cba2607919806fb52e"
    },
    {
      "layer": 35,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "b0039027d08074e63e6ba872ae6fab40c0ba36a3b80a1155af77b15a48d9fd7d"
    },
    {
      "layer": 35,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "1427baa790bb2b4a2cc648716bd8306f8ffde6a3d6aaf5f428793bf150ba445f"
    },
    {
      "layer": 35,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "a564b26fdb371974eaac3eaf9c1f6445720a836e786e18eae4d1699e6e99840c"
    },
    {
      "layer": 35,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "5cd3cd1e470a15840c68d91304a4aa6b72c2974e62a1decd006120afb7363ee2"
    },
    {
      "layer": 35,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "86014bb23ef812162416fd1a506275cb2a9f994acd594af1df7c5d3e81033b11"
    },
    {
      "layer": 36,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "e636a1ccedfb8fbfc5b47e7c27019a23d98602351bd87a065221e268f3a32acc"
    },
    {
      "layer": 36,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "7fd5547b41e5b19849ac051901b576de37d6ab0d91c790368b03a1df4588bdda"
    },
    {
      "layer": 36,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "9d98886373dfde8816779f64212d2ea036b2a8630391c1b9ea06dddb92b9f540"
    },
    {
      "layer": 36,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "c0d826a4bbd5077fefd7b729a726f32456c3fa1ba4bf7484304bb55a0f28cc61"
    },
    {
      "layer": 36,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "39993caa13d7bd6274cb55edc6d50b23dff69a872517482740df667d3c32c020"
    },
    {
      "layer": 36,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "5adcab5eff8b2b61b4efa334ba69742003657fd13cd216cc19c09f9d44aa9e34"
    },
    {
      "layer": 37,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "3c0a18bba4569210aea1717c8a3797bc642dd7bcda350dc71a7ae3e01284ffbe"
    },
    {
      "layer": 37,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "8cbd2a4c84d14b65abb311ffff45cb293b714c3bf43ecd355d66468f1e209957"
    },
    {
      "layer": 37,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "0dc55d12bd723f07cc81349c944050bb77f209f4f61885047f6d9af31819b468"
    },
    {
      "layer": 37,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "19b9718c4497381686d4229be5322bcb14c1587de684c80234eda9acc249adcc"
    },
    {
      "layer": 37,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "9eaa89b6b51e14f2841e31ed560190543ef55b3bed40baefb365316cfb3198bf"
    },
    {
      "layer": 37,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "39632bd3a2ace37e1ca60cfab8dbf1e991d3ea59149cf5d587f2bd0c16c2aff8"
    },
    {
      "layer": 38,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "b58fc223477e0599ff6467e51a81426c5ad851978c582938f3d589d3124a7997"
    },
    {
      "layer": 38,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "f04e3771d2c20a1a0c6683da53f2886f14a8794eea7249a12bbff6a409ebeeb4"
    },
    {
      "layer": 38,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "f6a5effaa7c6d21b87400a1985e45fe2834884d7128e624777adab7ab9a3fe89"
    },
    {
      "layer": 38,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "eaf9fcab9b159aefb04d08050e681e02894db5eab54d8314b1eb6d7bbdad5488"
    },
    {
      "layer": 38,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "a9179d7cf4b62bc487b4b2e25ac9d6be2da84e664dfe015e0f44aa042cfe2d67"
    },
    {
      "layer": 38,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "84de578837ae3751e6144c917087ca8db5e30f0ecfb46374d287ede60abde37c"
    },
    {
      "layer": 39,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "d8a4ec08875e251907486fe8b3cb75442cea0d43a76ec44cf2eb3a5672e78519"
    },
    {
      "layer": 39,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "f96d859e11d7d8044c365e649c78ef998a8b179dca61332fc4e66fb34f19b3af"
    },
    {
      "layer": 39,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "59577c756d1eddae6478ea5a4b9a8cf0653b45eb8877351d1c7880cfbc0f7637"
    },
    {
      "layer": 39,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "5f0c87350bfaf6347995eac8347f81840f7418b70fc12ae1e8ca442f76055593"
    },
    {
      "layer": 39,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "3980293bb9fe19e3bfb3ff262a27c68deb2dadc8fb68c8adb0838f8a50f987a9"
    },
    {
      "layer": 39,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "1f210d47e0bea9d1aaaac2d50bbee1c7f9afa845e9c5ae1168d47e7d5d9b4e1b"
    },
    {
      "layer": 39,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "813d277de42e65a48edea658d5be6b0a7afdcbd418482885c6ec02ae44a5d07a"
    },
    {
      "layer": 39,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "3ca911a74954ce704fa2cbd4616fc50e700faf3922e08470391571970830f6d1"
    },
    {
      "layer": 40,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "872eb1733faedd4fa2379e859113f93c52c99c798087e6937c5c0625a49954a8"
    },
    {
      "layer": 40,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "aa824336c7b57fedc85b24bf35d9803f54b3683e6dbd45152adb2a2c42ada0ee"
    },
    {
      "layer": 40,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "b878fa756373dca858517cead9fcf22b012d2681eb29bd31d165d6d4a268b33a"
    },
    {
      "layer": 40,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "b249e99ee79aefeb3a86627593e48111f2fef83fe815925294c5ec7114cc95a4"
    },
    {
      "layer": 40,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "a74f190c6c3fdd06a36624521a91a362c82da0f4d9f59d920bff68af4560b9b8"
    },
    {
      "layer": 40,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "7cdba97c41b761fc78f574e5b7c21327b62bf3aa8dd4432510e688553237f376"
    },
    {
      "layer": 41,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "229bfc271b37b3df7e30fb0b8761035d551391c1dc1b0d252fa7716b70a007a9"
    },
    {
      "layer": 41,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "bf90d646b4cc33c05eefd6418bf1525fea6ef83be7cb9d6ed6cf6c91e0179d65"
    },
    {
      "layer": 41,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "0e9d262b733bd3faad802f302b1495e3d222f237b24efacd38e6ca32297eda28"
    },
    {
      "layer": 41,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "ca956a661c04da8104448ed4731d593d61cffc204373ed4713981dbfcee16c89"
    },
    {
      "layer": 41,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "ac876ac265714e3d72e79f0043005e50f26f0f1de65c86e320109ab0de79612f"
    },
    {
      "layer": 41,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "3a9d55c2123d437e1eb52131e5bcfe50a3f8f110ab780eb38052e48bca426926"
    },
    {
      "layer": 42,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "a43060f3076ba5fdd0ea71a47011ad972aa882e307529ecdd478e3d94f143cb9"
    },
    {
      "layer": 42,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "a37a67e5ba5b0c3e96e9fc8c3262e4b4c7b71b888f0e0a8b3faee1565afa08ce"
    },
    {
      "layer": 42,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "4b29f6ef76bd7de58e20172be02bdc98721d7df87e6868f1337057f254c48416"
    },
    {
      "layer": 42,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "b52b7386385a27dd364e82143a0cef96bddaa51091c03e2bb0edf9893ae626af"
    },
    {
      "layer": 42,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "05d824f7a214d715d1f975e5b5b34cf2f4a0a01373709e933510d8b6dfb0511d"
    },
    {
      "layer": 42,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "774a22cf65f3215e10154c8acd4ef80e81bf772e35dbc6f39462bc69ea37cbe5"
    },
    {
      "layer": 43,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "63a7ea7f625944cd029b669459cfbb92af8e3c08cc1ccbe2d5299b03b8ea2db5"
    },
    {
      "layer": 43,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "e4fbf8205b69caee168441cd4ad5358b0253d2ba023d9fd16b22408ede55a4b0"
    },
    {
      "layer": 43,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "e1d5fcc4bab4ae8b351589190b936dbd3bb199bb2cb9c05c23206ef74da15301"
    },
    {
      "layer": 43,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "967072883a3ab6e50f56f750e81f4ce0dc96fe4d9796f8343c7d1a464591fbd5"
    },
    {
      "layer": 43,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "ed0115f5295749ef028294824faf6044878ef36eb61b7591b4cad39d7126b0b4"
    },
    {
      "layer": 43,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "49d1e4d87fd0729d588d4bb9260ec0d32b1ab92e3acf877dc66da6ff94096dde"
    },
    {
      "layer": 43,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "1d5200d3bdf6a5242643aa7c511f628b0a5e8d2ae2cf6b9e011f01c1c74fe25a"
    },
    {
      "layer": 43,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "1fb1536b8a91fc0f79b387c81c75fa4280a41353bac0a1c36d8991f1be4c1379"
    },
    {
      "layer": 44,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "2d2b846910ca675bc43ec083de67f728ba1ec481607c445a97495b08938037ee"
    },
    {
      "layer": 44,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "0f585ad301322a6af63c8cc424f4a358d8e86eb0d8b92fedd6e05d6de687af4b"
    },
    {
      "layer": 44,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "d81d7a45858b5e6db36f975fcb786a6e13d90e47570ef671a6d64d9c3892fdbd"
    },
    {
      "layer": 44,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "03326d35bc397663a3bcdccfe7e9019d3a534b85d97911fa5c1c60d21481e3ab"
    },
    {
      "layer": 44,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "cd334439cfac8f324d50cfd35051070925429b0e94b8d3563e39f3a0250575a4"
    },
    {
      "layer": 44,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "96413708c306edeb5324ac6bcebf3715a5c051f0f28d070c228fd79be897dcf4"
    },
    {
      "layer": 45,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "aa5ac8730bdc2c760c6221cfa85752c0bff870b18585a65ad8eef09eb35f1a74"
    },
    {
      "layer": 45,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "478392d5a65fe1a2aa37d61ff3a1a119605fdc1a3437d4f11636186fc2170959"
    },
    {
      "layer": 45,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "0e9050e72e375e95b1ef44f63a8b3fa61b5ce675e64c85dacbebac258e02b270"
    },
    {
      "layer": 45,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "4b05dd6a7fbbadfc4a2daa98dbb9b64145c5b22faba9d2d17f0d546846cc9b51"
    },
    {
      "layer": 45,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "bfe51cdf2b8a33ca8ad6b347ba6a25a863fa5090f872ee59212697596c59a43c"
    },
    {
      "layer": 45,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "56076a1e9cd38349cbceeeabff3ff24f610f946bdd2683907f6d65e8c43abab6"
    },
    {
      "layer": 46,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "7117a0ab0fd0dc1767263a42694c05d56c245941dc9347b971f73afc8f7d7256"
    },
    {
      "layer": 46,
      "step": 0,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "0c33cb3d7ecb7193ea838bf03e7c7f0e02f10ba12ce860fc023b5014ce5edf69"
    },
    {
      "layer": 46,
      "step": 0,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "85f6b951b3803d608ffaa85160ce9951e3e61dc961201586cfe52b38965d6bd7"
    },
    {
      "layer": 46,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "3df40ab1a5de0093d7dfa0cdd0fe92d91a197603a05a5d5bf24cc752e56a9b8f"
    },
    {
      "layer": 46,
      "step": 1,
      "name": "conv",
      "shape": [
        1,
        3,
        10240
      ],
      "dtype": "BF16",
      "bytes": 61440,
      "sha256": "05703fee8108220a1ef1637fa361b83bfbdb50851aab7b562e653730646ffd9a"
    },
    {
      "layer": 46,
      "step": 1,
      "name": "state",
      "shape": [
        1,
        48,
        128,
        128
      ],
      "dtype": "F32",
      "bytes": 3145728,
      "sha256": "16bc608aac4d0ada4c25a9b88bf2001ae6c73a2b4e9a6bca4183c806cc7c3eeb"
    },
    {
      "layer": 47,
      "step": 0,
      "name": "hidden",
      "shape": [
        1,
        512,
        10240
      ],
      "dtype": "BF16",
      "bytes": 10485760,
      "sha256": "da63f86d931521d55778dd7e8e906c0d144e070228d3bdee02c3caaafd64d2d9"
    },
    {
      "layer": 47,
      "step": 0,
      "name": "keys",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "a29650379488872caf4232a2658f8c314d73509a5a558370d9013956788ae4b2"
    },
    {
      "layer": 47,
      "step": 0,
      "name": "values",
      "shape": [
        1,
        2,
        512,
        256
      ],
      "dtype": "BF16",
      "bytes": 524288,
      "sha256": "47c724cdd717490c6cd79888023d233ff6f58b0987604446238a71a1f1629389"
    },
    {
      "layer": 47,
      "step": 0,
      "name": "indexer",
      "shape": [
        1,
        512,
        128
      ],
      "dtype": "BF16",
      "bytes": 131072,
      "sha256": "74cdd9e65f611eb3007a00999d4519eca5d5e338abe6c707d86bf534b4b3e24a"
    },
    {
      "layer": 47,
      "step": 1,
      "name": "hidden",
      "shape": [
        1,
        1,
        10240
      ],
      "dtype": "BF16",
      "bytes": 20480,
      "sha256": "fd4bb8efbafe86ffa82e51d91c1c179ebb52eb9109d0f955bd320a4014048696"
    },
    {
      "layer": 47,
      "step": 1,
      "name": "keys",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "49c40e718bc47cef4c9e4c3363131501242eff1ab5cafd55b26d9ace56791ff5"
    },
    {
      "layer": 47,
      "step": 1,
      "name": "values",
      "shape": [
        1,
        2,
        513,
        256
      ],
      "dtype": "BF16",
      "bytes": 525312,
      "sha256": "b6a53f39c6f24bb11863124e2a34ab9fe3d669aa804a1fabb682bad7b89420b8"
    },
    {
      "layer": 47,
      "step": 1,
      "name": "indexer",
      "shape": [
        1,
        513,
        128
      ],
      "dtype": "BF16",
      "bytes": 131328,
      "sha256": "1edc24d312342b5f09b88d730038cc99e90758f3ca7639ac5851d4c924cbc7ae"
    },
    {
      "layer": 48,
      "step": 0,
      "name": "mixed",
      "shape": [
        1,
        512,
        2560
      ],
      "dtype": "BF16",
      "bytes": 2621440,
      "sha256": "dfe6776cb7c4ceec2bb5a3290d0182ac9c84d9bc67d117dd32a7f220ef9522f9"
    },
    {
      "layer": 48,
      "step": 0,
      "name": "logits",
      "shape": [
        1,
        512,
        248320
      ],
      "dtype": "F32",
      "bytes": 508559360,
      "sha256": "90cbde74b5dd23b3cf6e53a69eebec87d1c4478fe743b714d597ff19b36c6967"
    },
    {
      "layer": 48,
      "step": 1,
      "name": "mixed",
      "shape": [
        1,
        1,
        2560
      ],
      "dtype": "BF16",
      "bytes": 5120,
      "sha256": "322f70c2c35474f6e7e7ce761ace486b924cebca0fa5ae143b8e0f9d6c04b6b0"
    },
    {
      "layer": 48,
      "step": 1,
      "name": "logits",
      "shape": [
        1,
        1,
        248320
      ],
      "dtype": "F32",
      "bytes": 993280,
      "sha256": "5f43cec9ccf75d03f37f520e5650689873b158a7bc2cc829262f62609e74c0f0"
    }
  ],
  "before": {
    "page_bytes": 16384,
    "reclaimable_bytes": 23093231616,
    "swapins": 0,
    "swapouts": 16,
    "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                    64935.\nPages active:                                1076623.\nPages inactive:                              1094689.\nPages speculative:                             44585.\nPages throttled:                                   0.\nPages wired down:                             178363.\nPages purgeable:                                6681.\n\"Translation faults\":                     1117871730.\nPages copy-on-write:                        67835673.\nPages zero filled:                        1943331620.\nPages reactivated:                          93548318.\nPages purged:                               10840434.\nFile-backed pages:                           1337883.\nAnonymous pages:                              878014.\nPages stored in compressor:                  1146784.\nPages occupied by compressor:                 626296.\nDecompressions:                             23345805.\nCompressions:                               33029249.\nPageins:                                   611385660.\nPageouts:                                     335088.\nSwapins:                                           0.\nSwapouts:                                         16.\nPages tagged:                                 129058.\nPages tagged resident:                         90239.\nPages tagged compressed:                       38819.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 5299.\nPages tag-storage free:                          186.\nPages tag-storage non-tag pageable:            92811.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    5717440.\nTagged compressions:                          439847.\nTagged decompressions:                        363070.\n"
  },
  "memory": {
    "current_bytes": 2297367072,
    "lifetime_peak_bytes": 3189033888,
    "rss_peak_bytes": 2276114432
  },
  "mlx_peak_bytes": 2402878216,
  "save_layer": 2,
  "qualification": "unproven",
  "scope": "complete prefill arithmetic and one continuation; no generation qualification"
}
````

### frozen-prefill-model-v4/build-identity.json

Original bytes: 29735. SHA-256: `07bbe00a09f9afc849bb2870f460ea58bcf66f5f6a36354395eca256dfb57b92`.

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
    "Sources/Slotstream/Layers.swift": "01667c83165d5a80fd687eefe54e244ee406a76a3a36ed56767d0c9e0533ccf7",
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
    "Sources/Slotstream/VQArithmetic.swift": "2debfc72f3b798710f9a41e00a094032cc50731ea84bcd930332eac7787c9b53",
    "Sources/Slotstream/VQCheckpoint.swift": "53525f6def06413a8812f93cc1bcb9a21c4a39e4708719f911a9c5ad784954c6",
    "Sources/Slotstream/VQDecode.swift": "55f82886c55e197f81cba6929bd873b0929c10b94396819e416c47b34d138974",
    "Sources/Slotstream/VQExpert.swift": "4643b13b0506bd5230d0f8ea11f749ba708cec13b688b1355769acbb1b897ca9",
    "Sources/Slotstream/VQKernelSources.swift": "f950203240aa22027bd37da474e9ab122ce2709b3ad99a0a78e79f734df5a40b",
    "Sources/Slotstream/VQModelProbe.swift": "f89404ef585db9be655730feec83d8613e21186ce5594c6ed03ca049004266c1",
    "Sources/Slotstream/VQPLERows.swift": "5ea9a7a322be72af2c9def3777396b5dad6313206aec4c197be4edcb7a16a5dc",
    "Sources/Slotstream/VQPrefillStream.swift": "922701a104796635129361b304fc4c16c87c528539cc0655d44702f4fa321d03",
    "Sources/Slotstream/VQRecord.swift": "fa0068d90454df6dec0e5d8a73d887a96d4350207e0cc21dc74e58a08054c1ee",
    "Sources/Slotstream/VQRouteStream.swift": "935c13d19a8febd8e82cb3e42a8c13fd80a875928f64f9cfc4d741847a96b04e",
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
    "Sources/SlotstreamDiagnostics/Diagnostics+VQArithmetic.swift": "42086d94f36cac03143cdc9d43fb62f11b7f00ac0ba29b12e790814f1d6798ae",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQModel.swift": "8376a3a59bf56e3c71b550beedf5b5d6cc54141b5353ca5ace1449079c3f01c6",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPLE.swift": "04feef7169f18b87fc8b6ed5b793cddb6057a0ac561920f6dd3b7b1d7616b6ab",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQPrefillModel.swift": "49394377cc6e73ea5e995627504d13d3769e4cb2d8530eae245731e3aed44c41",
    "Sources/SlotstreamDiagnostics/Diagnostics+VQRecords.swift": "6b3c28a81f1132b2f8aa0a6f43aedecda3a1022b8a11634a8b8b0b7f7fb2d7d1",
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
    "Sources/slotstream-cli/QuantizationCommands.swift": "a964b86713ff5fb760f9ff1f41b2c59cc983db116adfc41c72801c317da23766",
    "Sources/slotstream-cli/StopCommand.swift": "a61e1ac21c157d1e11bc8676b9485ca8b79f1aadd04a20620b6bbed951ce5474",
    "Sources/slotstream-cli/SweepCommands.swift": "f7a988326232c70586b2dc096427d9f5826a317da46b0085c61c0d70096c5e3a",
    "Sources/slotstream-cli/VisionCommands.swift": "126a5bb05ccc6549337f04048d88256fcc106686dc8fb062d3759dad13af7971",
    "Sources/slotstream-cli/main.swift": "e25d9405271d6be0d57b22d0970c3677a962038d786a418f418a3047b5cbf9c7",
    "THIRD_PARTY_NOTICES.md": "dd7f676c763a2265aec700373a9a3bc2f6a203b4b55c7647e865534c855dbe5e",
    "Tools/build_identity.py": "436782b73e7c7454ef013b6375a568bdc503f40b7f3afedc68d35cefc9914078",
    "Tools/fetch_metallib.sh": "7df9293bbef54ff4fdd395adae9942f96ad6cec3f204e90dd334e4b0d779cc2a"
  },
  "source_archive_sha256": "0f9c1ce80b7fdfc9e8c2d55ac987460c3868b6623b3d8cdeac43c3d341800333",
  "binary_sha256": "5d1e28c9e5e8b9a486c494b7c1bad62de8604b94f5a46793fb2db707e474e54f",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed"
}
````
